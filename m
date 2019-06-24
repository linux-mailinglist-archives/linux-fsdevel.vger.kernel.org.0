Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B7F50D4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfFXOIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:08:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfFXOIy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:08:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C99E83082B68;
        Mon, 24 Jun 2019 14:08:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09286600D1;
        Mon, 24 Jun 2019 14:08:45 +0000 (UTC)
Subject: [PATCH 00/25] VFS: Introduce filesystem information query syscall
 [ver #14]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 15:08:45 +0100
Message-ID: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 24 Jun 2019 14:08:54 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Al,

Here are a set of patches that adds a syscall, fsinfo(), that allows
attributes of a filesystem/superblock to be queried.  Attribute values are
of four basic types:

 (1) Version dependent-length structure (size defined by type).

 (2) Variable-length string (up to PAGE_SIZE).

 (3) Array of fixed-length structures (up to INT_MAX size).

 (4) Opaque blob (up to INT_MAX size).

Attributes can have multiple values in up to two dimensions and all the
values of a particular attribute must have the same type.

Note that the attribute values *are* allowed to vary between dentries
within a single superblock, depending on the specific dentry that you're
looking at.

I've tried to make the interface as light as possible, so integer/enum
attribute selector rather than string and the core does all the allocation
and extensibility support work rather than leaving that to the filesystems.
That means that for the first two attribute types, sb->s_op->fsinfo() may
assume that the provided buffer is always present and always big enough.

Further, this removes the possibility of the filesystem gaining access to the
userspace buffer.


fsinfo() allows a variety of information to be retrieved about a filesystem
and the mount topology:

 (1) General superblock attributes:

      - The amount of space/free space in a filesystem (as statfs()).
      - Filesystem identifiers (UUID, volume label, device numbers, ...)
      - The limits on a filesystem's capabilities
      - Information on supported statx fields and attributes and IOC flags.
      - A variety single-bit flags indicating supported capabilities.
      - Timestamp resolution and range.
      - Sources (as per mount(2), but fsconfig() allows multiple sources).
      - In-filesystem filename format information.
      - Filesystem parameters ("mount -o xxx"-type things).
      - LSM parameters (again "mount -o xxx"-type things).

 (2) Filesystem-specific superblock attributes:

      - Server names and addresses.
      - Cell name.

 (3) Filesystem configuration metadata attributes:

      - Filesystem parameter type descriptions.
      - Name -> parameter mappings.
      - Simple enumeration name -> value mappings.

 (4) Mount topology:

      - General information about a mount object.
      - Mount device name(s).
      - Children of a mount object and their relative paths.

 (5) Information about what the fsinfo() syscall itself supports, including
     the number of attibutes supported and the number of capability bits
     supported.


The system is extensible:

 (1) New attributes can be added.  There is no requirement that a
     filesystem implement every attribute.  Note that the core VFS keeps a
     table of types and sizes so it can handle future extensibility rather
     than delegating this to the filesystems.

 (2) Version length-dependent structure attributes can be made larger and
     have additional information tacked on the end, provided it keeps the
     layout of the existing fields.  If an older process asks for a shorter
     structure, it will only be given the bits it asks for.  If a newer
     process asks for a longer structure on an older kernel, the extra
     space will be set to 0.  In all cases, the size of the data actually
     available is returned.

     In essence, the size of a structure is that structure's version: a
     smaller size is an earlier version and a later version includes
     everything that the earlier version did.

 (3) New single-bit capability flags can be added.  This is a structure-typed
     attribute and, as such, (2) applies.  Any bits you wanted but the kernel
     doesn't support are automatically set to 0.

If a filesystem-specific attribute is added, it should just take up the next
number in the enumeration.  Currently, I do not intend that the number space
should be subdivided between interested parties.


fsinfo() may be called like the following, for example:

	struct fsinfo_params params = {
		.at_flags	= AT_SYMLINK_NOFOLLOW,
		.request	= FSINFO_ATTR_SERVER_ADDRESS;
		.Nth		= 2;
		.Mth		= 1;
	};
	struct fsinfo_server_address address;

	len = fsinfo(AT_FDCWD, "/afs/grand.central.org/doc", &params,
		     &address, sizeof(address));

The above example would query a network filesystem, such as AFS or NFS, and
ask what the 2nd address (Mth) of the 3rd server (Nth) that the superblock is
using is.  Whereas:

	struct fsinfo_params params = {
		.at_flags	= AT_SYMLINK_NOFOLLOW,
		.request	= FSINFO_ATTR_CELL_NAME;
	};
	char cell_name[256];

	len = fsinfo(AT_FDCWD, "/afs/grand.central.org/doc", &params,
		     &cell_name, sizeof(cell_name));

would retrieve the name of an AFS cell as a string.

fsinfo() can also be used to query a context from fsopen() or fspick():

	fd = fsopen("ext4", 0);
	struct fsinfo_params params = {
		.request	= FSINFO_ATTR_PARAM_DESCRIPTION;
	};
	struct fsinfo_param_description desc;
	fsinfo(fd, NULL, &params, &desc, sizeof(desc));

even if that context doesn't currently have a superblock attached (though if
there's no superblock attached, only filesystem-specific things like parameter
descriptions can be accessed).

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

on branch:

	fsinfo


===================
SIGNIFICANT CHANGES
===================

 ver #14:

 (*) Increase to 128-bit the fields for number of blocks and files in the
     filesystem and also the max file size and max inode number fields.

 (*) Increase to 64-bit the fields for max hard links and max xattr body
     length.

 (*) Provide struct fsinfo_timestamp_one to represent the characteristics
     of a single timestamp and move the range into it.  FAT, for example,
     has different ranges for different timestamps.  Each timestamp is then
     represented by one of these structs.

 (*) Don't expose MS_* flags (such as MS_RDONLY) through this interface as
     they ought to be considered deprecated; instead anyone who wants them
     should parse FSINFO_ATTR_PARAMETERS for the string equivalents.

 (*) Add a flag, AT_FSINFO_FROM_FSOPEN, to indicate that the fd being
     accessed is from fsopen()/fspick() and that fsinfo() should look
     inside and access the filesystem referred to by the fs_context.

 (*) If the filesystem implements FSINFO_ATTR_PARAMETERS for itself, don't
     automatically include flags for the SB_* bits that are normally
     rendered by, say, /proc/mounts (such as SB_RDONLY).  Rather, a helper
     is provided that the filesystem must call with an appropriately
     wangled s_flags.

 (*) Drop the NFS fsinfo patch for now as NFS fs_context support is
     unlikely to get upstream in the upcoming merge window.

 ver #13:

 (*) Provided a "fixed-struct array" type so that the list of children of a
     mount and all their change counters can be read atomically.

 (*) Additional filesystem examples.

 (*) Documented the API.

 ver #12:

 (*) Rename ->get_fsinfo() to ->fsinfo().

 (*) Pass the path through to to ->fsinfo() as it's needed for NFS to
     retrocalculate the source name.

 (*) Indicated which is the source parameter in the param-description
     attribute.

 (*) Dropped the realm attribute.

David
---
David Howells (17):
      vfs: syscall: Add fsinfo() to query filesystem information
      fsinfo: Add syscalls to other arches
      vfs: Allow fsinfo() to query what's in an fs_context
      vfs: Allow fsinfo() to be used to query an fs parameter description
      vfs: Implement parameter value retrieval with fsinfo()
      fsinfo: Implement retrieval of LSM parameters with fsinfo()
      vfs: Introduce a non-repeating system-unique superblock ID
      vfs: Allow fsinfo() to look up a mount object by ID
      vfs: Add mount notification count
      vfs: Allow mount information to be queried by fsinfo()
      vfs: fsinfo sample: Mount listing program
      fsinfo: Add API documentation
      hugetlbfs: Add support for fsinfo()
      kernfs, cgroup: Add fsinfo support
      fsinfo: Support SELinux superblock parameter retrieval
      fsinfo: Support Smack superblock parameter retrieval
      afs: Support fsinfo()

Ian Kent (8):
      fsinfo: proc - add sb operation fsinfo()
      fsinfo: autofs - add sb operation fsinfo()
      fsinfo: shmem - add tmpfs sb operation fsinfo()
      fsinfo: devpts - add sb operation fsinfo()
      fsinfo: pstore - add sb operation fsinfo()
      fsinfo: debugfs - add sb operation fsinfo()
      fsinfo: bpf - add sb operation fsinfo()
      fsinfo: ufs - add sb operation fsinfo()


 Documentation/filesystems/fsinfo.rst        |  596 ++++++++++++++++++
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
 arch/arm64/include/asm/unistd.h             |    2 
 arch/ia64/kernel/syscalls/syscall.tbl       |    1 
 arch/m68k/kernel/syscalls/syscall.tbl       |    1 
 arch/microblaze/kernel/syscalls/syscall.tbl |    1 
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 
 arch/s390/kernel/syscalls/syscall.tbl       |    1 
 arch/sh/kernel/syscalls/syscall.tbl         |    1 
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 
 fs/Kconfig                                  |    7 
 fs/Makefile                                 |    1 
 fs/afs/internal.h                           |    1 
 fs/afs/super.c                              |  180 +++++-
 fs/autofs/inode.c                           |   64 ++
 fs/d_path.c                                 |    2 
 fs/debugfs/inode.c                          |   38 +
 fs/devpts/inode.c                           |   43 +
 fs/fsinfo.c                                 |  877 +++++++++++++++++++++++++++
 fs/hugetlbfs/inode.c                        |   57 ++
 fs/internal.h                               |   11 
 fs/kernfs/mount.c                           |   20 +
 fs/mount.h                                  |   22 +
 fs/namespace.c                              |  307 +++++++++
 fs/proc/inode.c                             |   37 +
 fs/pstore/inode.c                           |   32 +
 fs/statfs.c                                 |    2 
 fs/super.c                                  |   24 +
 fs/ufs/super.c                              |   58 ++
 include/linux/fs.h                          |    8 
 include/linux/fsinfo.h                      |   70 ++
 include/linux/kernfs.h                      |    4 
 include/linux/lsm_hooks.h                   |   13 
 include/linux/security.h                    |   11 
 include/linux/syscalls.h                    |    4 
 include/uapi/asm-generic/unistd.h           |    4 
 include/uapi/linux/fcntl.h                  |    3 
 include/uapi/linux/fsinfo.h                 |  319 ++++++++++
 kernel/bpf/inode.c                          |   25 +
 kernel/cgroup/cgroup-v1.c                   |   44 +
 kernel/cgroup/cgroup.c                      |   19 +
 kernel/sys_ni.c                             |    1 
 mm/shmem.c                                  |   72 ++
 samples/vfs/Makefile                        |    9 
 samples/vfs/test-fs-query.c                 |  138 ++++
 samples/vfs/test-fsinfo.c                   |  682 +++++++++++++++++++++
 samples/vfs/test-mntinfo.c                  |  241 +++++++
 security/security.c                         |   12 
 security/selinux/hooks.c                    |   41 +
 security/selinux/include/security.h         |    2 
 security/selinux/ss/services.c              |   49 ++
 security/smack/smack_lsm.c                  |   43 +
 60 files changed, 4202 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/filesystems/fsinfo.rst
 create mode 100644 fs/fsinfo.c
 create mode 100644 include/linux/fsinfo.h
 create mode 100644 include/uapi/linux/fsinfo.h
 create mode 100644 samples/vfs/test-fs-query.c
 create mode 100644 samples/vfs/test-fsinfo.c
 create mode 100644 samples/vfs/test-mntinfo.c

