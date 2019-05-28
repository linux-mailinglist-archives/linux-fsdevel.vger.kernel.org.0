Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962892C9C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfE1PLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:11:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfE1PLG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:11:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4450330C0DFC;
        Tue, 28 May 2019 15:11:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 287CA5D784;
        Tue, 28 May 2019 15:11:02 +0000 (UTC)
Subject: [PATCH 00/25] VFS: Introduce filesystem information query syscall
 [ver #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:11:01 +0100
Message-ID: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 28 May 2019 15:11:05 +0000 (UTC)
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
      vfs: Allow fsinfo() to query what's in an fs_context
      vfs: Allow fsinfo() to be used to query an fs parameter description
      vfs: Implement parameter value retrieval with fsinfo()
      fsinfo: Implement retrieval of LSM parameters with fsinfo()
      vfs: Introduce a non-repeating system-unique superblock ID
      vfs: Allow fsinfo() to look up a mount object by ID
      vfs: Add mount notification count
      vfs: Allow mount information to be queried by fsinfo()
      vfs: fsinfo sample: Mount listing program
      hugetlbfs: Add support for fsinfo()
      kernfs, cgroup: Add fsinfo support
      fsinfo: Support SELinux superblock parameter retrieval
      fsinfo: Support Smack superblock parameter retrieval
      afs: Support fsinfo()
      nfs: Support fsinfo()
      fsinfo: Add API documentation

Ian Kent (8):
      fsinfo: autofs - add sb operation fsinfo()
      fsinfo: shmem - add tmpfs sb operation fsinfo()
      fsinfo: proc - add sb operation fsinfo()
      fsinfo: devpts - add sb operation fsinfo()
      fsinfo: pstore - add sb operation fsinfo()
      fsinfo: debugfs - add sb operation fsinfo()
      fsinfo: bpf - add sb operation fsinfo()
      fsinfo: ufs - add sb operation fsinfo()


 Documentation/filesystems/fsinfo.rst   |  571 ++++++++++++++++++++++
 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/Kconfig                             |    7 
 fs/Makefile                            |    1 
 fs/afs/internal.h                      |    1 
 fs/afs/super.c                         |  155 ++++++
 fs/autofs/inode.c                      |   63 ++
 fs/d_path.c                            |    2 
 fs/debugfs/inode.c                     |   37 +
 fs/devpts/inode.c                      |   42 ++
 fs/fsinfo.c                            |  835 ++++++++++++++++++++++++++++++++
 fs/hugetlbfs/inode.c                   |   56 ++
 fs/internal.h                          |   11 
 fs/kernfs/mount.c                      |   20 +
 fs/mount.h                             |   22 +
 fs/namespace.c                         |  305 ++++++++++++
 fs/nfs/fs_context.c                    |  163 ++++++
 fs/nfs/internal.h                      |    6 
 fs/nfs/nfs4super.c                     |    3 
 fs/nfs/super.c                         |   77 +++
 fs/proc/inode.c                        |   36 +
 fs/pstore/inode.c                      |   31 +
 fs/statfs.c                            |    2 
 fs/super.c                             |   24 +
 fs/ufs/super.c                         |   57 ++
 include/linux/fs.h                     |    8 
 include/linux/fsinfo.h                 |   69 +++
 include/linux/kernfs.h                 |    4 
 include/linux/lsm_hooks.h              |   13 
 include/linux/security.h               |   11 
 include/linux/syscalls.h               |    4 
 include/uapi/linux/fcntl.h             |    2 
 include/uapi/linux/fsinfo.h            |  311 ++++++++++++
 kernel/bpf/inode.c                     |   24 +
 kernel/cgroup/cgroup-v1.c              |   44 ++
 kernel/cgroup/cgroup.c                 |   19 +
 kernel/sys_ni.c                        |    3 
 mm/shmem.c                             |   71 +++
 samples/vfs/Makefile                   |    9 
 samples/vfs/test-fs-query.c            |  139 +++++
 samples/vfs/test-fsinfo.c              |  675 ++++++++++++++++++++++++++
 samples/vfs/test-mntinfo.c             |  239 +++++++++
 security/security.c                    |   12 
 security/selinux/hooks.c               |   41 ++
 security/selinux/include/security.h    |    2 
 security/selinux/ss/services.c         |   49 ++
 security/smack/smack_lsm.c             |   43 ++
 48 files changed, 4313 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/filesystems/fsinfo.rst
 create mode 100644 fs/fsinfo.c
 create mode 100644 include/linux/fsinfo.h
 create mode 100644 include/uapi/linux/fsinfo.h
 create mode 100644 samples/vfs/test-fs-query.c
 create mode 100644 samples/vfs/test-fsinfo.c
 create mode 100644 samples/vfs/test-mntinfo.c

