Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 677BE59F1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfF1Pny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:43:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58325 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1Pny (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:43:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9AAF811D8;
        Fri, 28 Jun 2019 15:43:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 089AA1001E60;
        Fri, 28 Jun 2019 15:43:37 +0000 (UTC)
Subject: [PATCH 00/11] VFS: Introduce filesystem information query syscall
 [ver #15]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:43:37 +0100
Message-ID: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 28 Jun 2019 15:43:53 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here are a set of patches that adds a syscall, fsinfo(), that allows
attributes of a filesystem/superblock to be queried.  Attribute values are
of four basic types:

 (1) Version dependent-length structure (size defined by type).

 (2) Variable-length string (up to 4096, no NUL).

 (3) Array of fixed-length structures (up to INT_MAX size).

 (4) Opaque blob (up to INT_MAX size).

Attributes can have multiple values either as a sequence of values or a
sequence-of-sequences of values and all the values of a particular
attribute must be of the same type.

Note that the values of an attribute *are* allowed to vary between dentries
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

 (4) Information about what the fsinfo() syscall itself supports, including
     the number of attibutes supported and the number of capability bits
     supported.

 (5) Future patches will include information about the mount topology.

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
		.request	= FSINFO_ATTR_AFS_CELL_NAME;
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

	fsinfo-core


===================
SIGNIFICANT CHANGES
===================

 ver #15:

 (*) Rebase the patchset to v5.2-rc1 to remove the dependencies on my
     mount-api-viro branch.  Al has remunged the patches, but has not
     exposed what he might send upstream.

 (*) Split out various of the individual filesystem implementation patches
     that depend on mount API changes having been made.

 (*) Split out the specify-by-mount-ID patch and the mount-topology query
     patches into the fsinfo-mount branch.

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
David Howells (10):
      vfs: syscall: Add fsinfo() to query filesystem information
      fsinfo: Add syscalls to other arches
      vfs: Allow fsinfo() to query what's in an fs_context
      vfs: Allow fsinfo() to be used to query an fs parameter description
      vfs: Implement parameter value retrieval with fsinfo()
      fsinfo: Implement retrieval of LSM parameters with fsinfo()
      afs: Support fsinfo()
      fsinfo: Add API documentation
      hugetlbfs: Add support for fsinfo()
      kernfs, cgroup: Add fsinfo support

Ian Kent (1):
      fsinfo: proc - add sb operation fsinfo()


 Documentation/filesystems/fsinfo.rst        |  561 +++++++++++++++++++
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
 arch/arm64/include/asm/unistd.h             |    2 
 arch/arm64/include/asm/unistd32.h           |    2 
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
 fs/afs/super.c                              |  180 ++++++
 fs/fsinfo.c                                 |  818 +++++++++++++++++++++++++++
 fs/hugetlbfs/inode.c                        |   57 ++
 fs/kernfs/mount.c                           |   20 +
 fs/proc/inode.c                             |   37 +
 fs/statfs.c                                 |    2 
 include/linux/fs.h                          |    5 
 include/linux/fsinfo.h                      |   69 ++
 include/linux/kernfs.h                      |    4 
 include/linux/lsm_hooks.h                   |   13 
 include/linux/security.h                    |   11 
 include/linux/syscalls.h                    |    4 
 include/uapi/asm-generic/unistd.h           |    4 
 include/uapi/linux/fcntl.h                  |    2 
 include/uapi/linux/fsinfo.h                 |  291 ++++++++++
 kernel/cgroup/cgroup-v1.c                   |   44 +
 kernel/cgroup/cgroup.c                      |   19 +
 kernel/sys_ni.c                             |    1 
 samples/vfs/Makefile                        |    6 
 samples/vfs/test-fs-query.c                 |  138 +++++
 samples/vfs/test-fsinfo.c                   |  640 +++++++++++++++++++++
 security/security.c                         |   12 
 44 files changed, 2961 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/filesystems/fsinfo.rst
 create mode 100644 fs/fsinfo.c
 create mode 100644 include/linux/fsinfo.h
 create mode 100644 include/uapi/linux/fsinfo.h
 create mode 100644 samples/vfs/test-fs-query.c
 create mode 100644 samples/vfs/test-fsinfo.c

