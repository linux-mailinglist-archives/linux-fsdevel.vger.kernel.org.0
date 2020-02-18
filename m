Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7AE162B4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgBRRFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:05:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43775 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgBRRFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582045505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MXxEADXiyAwvyFlTuLyGDTB80oMB5vywGZnM8j6bVf0=;
        b=YmoO3/a5SeiKtBDcXxYRbmK26dErbKvcfdtkSdGka/4VDG/oIRJMwCAjorNYKKNwmy2yDH
        taylLhzCw4Yw70uLnO3E6Ll80sJX5Edf91PhWqd9a8FG54JdiqzB9JbJpWf+L7Mx6jQP49
        CHEEVjocM0cbbmDfTlKkHDLhAPEbOnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-m604CH75P-2vVR3bvAzvsA-1; Tue, 18 Feb 2020 12:04:59 -0500
X-MC-Unique: m604CH75P-2vVR3bvAzvsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96462800D48;
        Tue, 18 Feb 2020 17:04:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC23919756;
        Tue, 18 Feb 2020 17:04:55 +0000 (UTC)
Subject: [PATCH 00/19] VFS: Filesystem information and notifications [ver #16]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 17:04:55 +0000
Message-ID: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here are a set of patches that adds system calls, that (a) allow
information about the VFS, mount topology, superblock and files to be
retrieved and (b) allow for notifications of mount topology rearrangement
events, mount and superblock attribute changes and other superblock events,
such as errors.

============================
FILESYSTEM INFORMATION QUERY
============================

The first system call, fsinfo(), allows information about the filesystem at
a particular path point to be queried as a set of attributes, some of which
may have more than one value.

Attribute values are of four basic types:

 (1) Version dependent-length structure (size defined by type).

 (2) Variable-length string (up to 4096, including NUL).

 (3) List of structures (up to INT_MAX size).

 (4) Opaque blob (up to INT_MAX size).

Attributes can have multiple values either as a sequence of values or a
sequence-of-sequences of values and all the values of a particular
attribute must be of the same type.

Note that the values of an attribute *are* allowed to vary between dentries
within a single superblock, depending on the specific dentry that you're
looking at, but all the values of an attribute have to be of the same type.

I've tried to make the interface as light as possible, so integer/enum
attribute selector rather than string and the core does all the allocation
and extensibility support work rather than leaving that to the filesystems.
That means that for the first two attribute types, the filesystem will
always see a sufficiently-sized buffer allocated.  Further, this removes
the possibility of the filesystem gaining access to the userspace buffer.


fsinfo() allows a variety of information to be retrieved about a filesystem
and the mount topology:

 (1) General superblock attributes:

     - Filesystem identifiers (UUID, volume label, device numbers, ...)
     - The limits on a filesystem's capabilities
     - Information on supported statx fields and attributes and IOC flags.
     - A variety single-bit flags indicating supported capabilities.
     - Timestamp resolution and range.
     - The amount of space/free space in a filesystem (as statfs()).
     - Superblock notification counter.

 (2) Filesystem-specific superblock attributes:

     - Superblock-level timestamps.
     - Cell name.
     - Server names and addresses.
     - Filesystem-specific information.

 (3) VFS information:

     - Mount topology information.
     - Mount attributes.
     - Mount notification counter.

 (4) Information about what the fsinfo() syscall itself supports, including
     the type and struct/element size of attributes.

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

fsinfo() may be called like the following, for example:

	struct fsinfo_params params = {
		.at_flags	= AT_SYMLINK_NOFOLLOW,
		.flags		= FSINFO_FLAGS_QUERY_PATH,
		.request	= FSINFO_ATTR_AFS_SERVER_ADDRESSES,
		.Nth		= 2,
	};
	struct fsinfo_server_address address;
	len = fsinfo(AT_FDCWD, "/afs/grand.central.org/doc", &params,
		     &address, sizeof(address));

The above example would query an AFS filesystem to retrieve the address
list for the 3rd server, and:

	struct fsinfo_params params = {
		.at_flags	= AT_SYMLINK_NOFOLLOW,
		.flags		= FSINFO_FLAGS_QUERY_PATH,
		.request	= FSINFO_ATTR_AFS_CELL_NAME;
	};
	char cell_name[256];
	len = fsinfo(AT_FDCWD, "/afs/grand.central.org/doc", &params,
		     &cell_name, sizeof(cell_name));

would retrieve the name of an AFS cell as a string.

In future, I want to make fsinfo() capable of querying a context created by
fsopen() or fspick(), e.g.:

	fd = fsopen("ext4", 0);
	struct fsinfo_params params = {
		.flags		= FSINFO_FLAGS_QUERY_FSCONTEXT,
		.request	= FSINFO_ATTR_PARAMETERS;
	};
	char buffer[65536];
	fsinfo(fd, NULL, &params, &buffer, sizeof(buffer));

even if that context doesn't currently have a superblock attached.  I would
prefer this to contain length-prefixed strings so that there's no need to
insert escaping, especially as any character, including '\', can be used as
the separator in cifs and so that binary parameters can be returned (though
that is a lesser issue).


========================
FILESYSTEM NOTIFICATIONS
========================

The second system call, watch_mount(), places a watch on a point in the
mount topology specified by the dirfd, path and at_flags parameters.  All
mount topology change and mount attribute change notifications in the
subtree rooted at that point can be intercepted by the watch.  Watches are
ducted through pipes:

	int fd[2];
	pipe2(fd, O_NOTIFICATION_PIPE);
	ioctl(fd[0], IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);
	watch_mount(AT_FDCWD, "/", 0, fd[0], 0x02);

Events include:

 - New mount made
 - Mount unmounted
 - Mount expired
 - R/O state changed
 - Other attribute changed
 - Mount moved from
 - Mount moved to

Using filtering, this may be limited in various ways (single mount watch vs
subtree watch, recursive vs non-recursive changes, to-R/O vs to-R/W, mount
vs submount).

Each mount now has a change counter.  Whenever a mount is changed, this
gets incremented.  It can be queried by fsinfo() using either
FSINFO_ATTR_MOUNT_INFO or FSINFO_ATTR_MOUNT_CHILDREN.  The ID of the mount
on which the notification is generated is placed into the notification
message (triggered_on).  If the event involves a second mount as well, such
as creation of a new mount, that gets returned too (changed_mount).


The third system call, watch_sb(), places a watch on the superblock
specified by the dirfd, path and at_flags parameters.  This allows various
superblock events to be monitored for, such as:

 - Transition between R/W and R/O
 - Filesystem errors
 - Quota overrun
 - Network status changes

Each superblock now gets a 64-bit unique superblock identifier and a
notification counter.  The counter is incremented each time one of these
notifications would be generated.  This attributes can be queried using
fsinfo() with FSINFO_ATTR_SB_NOTIFICATIONS.  The identifier is placed into
notification messages.


Two sample programs are provided, one to query filesystem attributes and
the other to display a mount subtree.  Both of them can be given a path or
a mount ID to start at.  Further, the watch_test sample program now watches
for mount events under "/" and for superblock events on whatever superblock
is backing "/mnt" when it the program is started.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

on branch:

	fsinfo-core


===================
SIGNIFICANT CHANGES
===================

 ver #16:

 (*) Split the features bits out of the fsinfo() core into their own patch
     and got rid of the name encoding attributes.

 (*) Renamed the 'array' type to 'list' and made AFS use it for returning
     server address lists.

 (*) Changed the ->fsinfo() method into an ->fsinfo_attributes[] table,
     where each attribute has a ->get() method to deal with it.  These
     tables can then be returned with an fsinfo meta attribute.

 (*) Dropped the fscontext query and parameter/description retrieval
     attributes for now.

 (*) Picked the mount topology attributes into this branch.

 (*) Picked the mount notifications into this branch and rebased on top of
     notifications-pipe-core.

 (*) Picked the superblock notifications into this branch.

 (*) Add sample code for Ext4 and NFS.

David
---
David Howells (19):
      vfs: syscall: Add fsinfo() to query filesystem information
      fsinfo: Add syscalls to other arches
      fsinfo: Provide a bitmap of supported features
      vfs: Add mount change counter
      vfs: Introduce a non-repeating system-unique superblock ID
      vfs: Allow fsinfo() to look up a mount object by ID
      vfs: Allow mount information to be queried by fsinfo()
      vfs: fsinfo sample: Mount listing program
      fsinfo: Allow the mount topology propogation flags to be retrieved
      fsinfo: Add API documentation
      afs: Support fsinfo()
      security: Add hooks to rule on setting a superblock or mount watch
      vfs: Add a mount-notification facility
      notifications: sample: Display mount tree change notifications
      vfs: Add superblock notifications
      fsinfo: Provide superblock notification counter
      notifications: sample: Display superblock notifications
      ext4: Add example fsinfo information
      nfs: Add example filesystem information


 Documentation/filesystems/fsinfo.rst        |  490 +++++++++++++++
 arch/alpha/kernel/syscalls/syscall.tbl      |    3 
 arch/arm/tools/syscall.tbl                  |    3 
 arch/arm64/include/asm/unistd.h             |    2 
 arch/arm64/include/asm/unistd32.h           |    2 
 arch/ia64/kernel/syscalls/syscall.tbl       |    3 
 arch/m68k/kernel/syscalls/syscall.tbl       |    4 
 arch/microblaze/kernel/syscalls/syscall.tbl |    3 
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    3 
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    3 
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    3 
 arch/parisc/kernel/syscalls/syscall.tbl     |    3 
 arch/powerpc/kernel/syscalls/syscall.tbl    |    3 
 arch/s390/kernel/syscalls/syscall.tbl       |    3 
 arch/sh/kernel/syscalls/syscall.tbl         |    3 
 arch/sparc/kernel/syscalls/syscall.tbl      |    3 
 arch/x86/entry/syscalls/syscall_32.tbl      |    3 
 arch/x86/entry/syscalls/syscall_64.tbl      |    3 
 arch/xtensa/kernel/syscalls/syscall.tbl     |    3 
 fs/Kconfig                                  |   28 +
 fs/Makefile                                 |    2 
 fs/afs/internal.h                           |    1 
 fs/afs/super.c                              |  229 +++++++
 fs/d_path.c                                 |    2 
 fs/ext4/Makefile                            |    1 
 fs/ext4/ext4.h                              |    9 
 fs/ext4/fsinfo.c                            |   40 +
 fs/ext4/super.c                             |    1 
 fs/fsinfo.c                                 |  635 ++++++++++++++++++++
 fs/internal.h                               |   12 
 fs/mount.h                                  |   31 +
 fs/mount_notify.c                           |  188 ++++++
 fs/namespace.c                              |  323 ++++++++++
 fs/nfs/Makefile                             |    1 
 fs/nfs/internal.h                           |    8 
 fs/nfs/nfs4super.c                          |    1 
 fs/nfs/super.c                              |    1 
 fs/super.c                                  |  149 +++++
 include/linux/dcache.h                      |    1 
 include/linux/fs.h                          |   89 +++
 include/linux/fsinfo.h                      |  102 +++
 include/linux/lsm_hooks.h                   |   24 +
 include/linux/security.h                    |   16 +
 include/linux/syscalls.h                    |    8 
 include/uapi/asm-generic/unistd.h           |    8 
 include/uapi/linux/fsinfo.h                 |  371 ++++++++++++
 include/uapi/linux/mount.h                  |   10 
 include/uapi/linux/watch_queue.h            |   61 ++
 kernel/sys_ni.c                             |    3 
 samples/vfs/Makefile                        |    7 
 samples/vfs/test-fsinfo.c                   |  858 +++++++++++++++++++++++++++
 samples/vfs/test-mntinfo.c                  |  243 ++++++++
 samples/watch_queue/watch_test.c            |   76 ++
 security/security.c                         |   14 
 54 files changed, 4081 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/filesystems/fsinfo.rst
 create mode 100644 fs/ext4/fsinfo.c
 create mode 100644 fs/fsinfo.c
 create mode 100644 fs/mount_notify.c
 create mode 100644 include/linux/fsinfo.h
 create mode 100644 include/uapi/linux/fsinfo.h
 create mode 100644 samples/vfs/test-fsinfo.c
 create mode 100644 samples/vfs/test-mntinfo.c


