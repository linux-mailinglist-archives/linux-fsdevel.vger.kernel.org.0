Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5682022C684
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 15:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgGXNe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 09:34:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52831 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726381AbgGXNe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595597693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a4vHYe3spI83+cKkolbaEeLXnlWnDNMO141eOit08Ts=;
        b=Ij51rlpYA4RE9bcy7LcwmANf6/oRDogv5rAviz3bSaIyOMlpxk2eVqY7r6PEDJLUR0F8Jr
        FYOi1U1VQXXUAyOg5y3gad5OgNIaPOEwoawcz+32q/R2RoBEUTTrBy0I6xoVQLexiVofb2
        zwEt+Y7dHzp5SNC8dXHobOp5GpV0cr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-6SiDWXm8NVmPz_uvgi3Qug-1; Fri, 24 Jul 2020 09:34:51 -0400
X-MC-Unique: 6SiDWXm8NVmPz_uvgi3Qug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD1D41083E82;
        Fri, 24 Jul 2020 13:34:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83278712C4;
        Fri, 24 Jul 2020 13:34:41 +0000 (UTC)
Subject: [PATCH 00/17] VFS: Filesystem information [ver #20]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     Theodore Ts'o <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>,
        linux-api@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Layton <jlayton@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, dhowells@redhat.com, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 14:34:40 +0100
Message-ID: <159559768062.2144584.13583793543173131929.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches that adds a system call, fsinfo(), that allows
information about the VFS, mount topology, superblock and files to be
retrieved.

The patchset is based on top of the notifications patchset and allows event
counters implemented in the latter to be retrieved to allow overruns to be
efficiently managed.


=======
THE WHY
=======

Why do we want this?

Using /proc/mounts (or similar) has problems:

 (1) Reading from it holds a global lock (namespace_sem) that prevents
     mounting and unmounting.  Lots of data is encoded and mangled into
     text whilst the lock is held, including superblock option strings and
     mount point paths.  This causes performance problems when there are a
     lot of mount objects in a system.

 (2) Even though namespace_sem is held during a read, reading the whole
     file isn't necessarily atomic with respect to mount-type operations.
     If a read isn't satisfied in one go, then it may return to userspace
     briefly and then continue reading some way into the file.  But changes
     can occur in the interval that may then go unseen.

 (3) Determining what has changed means parsing and comparing consecutive
     outputs of /proc/mounts.

 (4) Querying a specific mount or superblock means searching through
     /proc/mounts and searching by path or mount ID - but we might have an
     fd we want to query.

 (5) Whilst you can poll() it for events, it only tells you that something
     changed in the namespace, not what or whether you can even see the
     change.

To fix the notification issues, the preceding notifications patchset added
mount watch notifications whereby you can watch for notifications in a
specific mount subtree.  The notification messages include the ID(s) of the
affected mounts.

To support notifications, however, we need to be able to handle overruns in
the notification queue.  I added a number of event counters to struct
super_block and struct mount to allow you to pin down the changes, but
there needs to be a way to retrieve them.  Exposing them through /proc
would require adding yet another /proc/mounts-type file.  We could add
per-mount directories full of attributes in sysfs, but that has issues also
(see below).

Adding an extensible system call interface for retrieving filesystem
information also allows other things to be exposed:

 (1) Jeff Layton's error handling changes need a way to allow error event
     information to be retrieved.

 (2) Bits in masks returned by things like statx() and FS_IOC_GETFLAGS are
     actually 3-state { Set, Unset, Not supported }.  It could be useful to
     provide a way to expose information like this[*].

 (3) Limits of the numerical metadata values in a filesystem[*].

 (4) Filesystem capability information[*].  Filesystems don't all have the
     same capabilities, and even different instances may have different
     capabilities, particularly with network filesystems where the set of
     may be server-dependent.  Capabilities might even vary at file
     granularity - though possibly such information should be conveyed
     through statx() instead.

 (5) ID mapping/shifting tables in use for a superblock.

 (6) Filesystem-specific information.  I need something for AFS so that I
     can do pioctl()-emulation, thereby allowing me to implement certain of
     the AFS command line utilities that query state of a particular file.
     This could also have application for other filesystems, such as NFS,
     CIFS and ext4.

 [*] In a lot of cases these are probably invariant and can be memcpy'd
     from static data.

There's a further consideration: I want to make it possible to have
fsconfig(fd, FSCONFIG_CMD_CREATE) be intercepted by a container manager
such that the manager can supervise a mount attempted inside the container.
The manager would be given an fd pointing to the fs_context struct and
would then need some way to query it (fsinfo()) and modify it (fsconfig()).
This could also be used to arbitrate user-requested mounts when containers
are not in play.


================
DESIGN DECISIONS
================

 (1) Information is partitioned into sets of attributes.

 (2) Attribute IDs are integers as they're fast to compare.

 (3) Attribute values are typed (struct, list of structs, string, opaque
     blob).  They type is fixed for a particular attribute.

 (4) For structure types, the length is also a version.  New fields can be
     tacked onto the end.

 (5) When copying a versioned struct to userspace, the core handles a
     version mismatch by truncating or zero-padding the data as necessary.
     This is transparent to the filesystem.

 (6) The core handles all the buffering and buffer resizing.

 (7) The filesystem never gets any access to the userspace parameter buffer
     or result buffer.

 (8) "Meta" attributes can describe other attributes.


========
OVERVIEW
========

fsinfo() is a system call that allows information about the filesystem at a
particular path point to be queried as a set of attributes.

Attribute values are of four basic types:

 (1) Structure with version-dependent length (the length is the version).

 (2) Variable-length string.

 (3) List of structures (all the same length).

 (4) Opaque blob.

Attributes can have multiple values either as a sequence of values or a
sequence-of-sequences of values and all the values of a particular
attribute must be of the same type.  Values can be up to INT_MAX size,
subject to memory availability.

Note that the values of an attribute *are* allowed to vary between dentries
within a single superblock, depending on the specific dentry that you're
looking at, but the values still have to be of the type for that attribute.

I've tried to make the interface as light as possible, so integer attribute
IDs rather than string and the core does all the buffer allocation and
expansion and all the extensibility support work rather than leaving that
to the filesystems.  This also means that userspace pointers are not
exposed to the filesystem.


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
     - Cell name, workgroup or other netfs grouping concept.
     - Server names and addresses.

 (3) VFS information:

     - Mount topology information.
     - Mount attributes.
     - Mount notification counter.
     - Mount point path.

 (4) Information about what the fsinfo() syscall itself supports, including
     the type and struct size of attributes.

The system is extensible:

 (1) New attributes can be added.  There is no requirement that a
     filesystem implement every attribute.  A helper function is provided
     to scan a list of attributes and a filesystem can have multiple such
     lists.

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
	len = fsinfo(AT_FDCWD, "/afs/grand.central.org/doc",
		     &params, sizeof(params),
		     &address, sizeof(address));

The above example would query an AFS filesystem to retrieve the address
list for the 3rd server, and:

	struct fsinfo_params params = {
		.at_flags	= AT_SYMLINK_NOFOLLOW,
		.flags		= FSINFO_FLAGS_QUERY_PATH,
		.request	= FSINFO_ATTR_NFS_SERVER_NAME;
	};
	char server_name[256];
	len = fsinfo(AT_FDCWD, "/home/dhowells/",
		     &params, sizeof(params),
		     &server_name, sizeof(server_name));

would retrieve the name of the NFS server as a string.

In future, I want to make fsinfo() capable of querying a context created by
fsopen() or fspick(), e.g.:

	fd = fsopen("ext4", 0);
	struct fsinfo_params params = {
		.flags		= FSINFO_FLAGS_QUERY_FSCONTEXT,
		.request	= FSINFO_ATTR_CONFIGURATION;
	};
	char buffer[65536];
	fsinfo(fd, NULL, &params, sizeof(params), &buffer, sizeof(buffer));

even if that context doesn't currently have a superblock attached.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

on branch:

	fsinfo-core


===================
SIGNIFICANT CHANGES
===================

 ver #20:

 (*) Changed MOUNT_PROPAGATION_SLAVE to MOUNT_PROPAGATION_DEPENDENT and
     renamed the fields in the fsinfo_mount_topology struct.  The
     MOUNT_PROPAGATION_* settings have been turned into an enum and will
     also be passed to mount_setattr().

 (*) Adjusted the Ext4 patch from feedback and removed the example status
     from it.

 (*) Dropped the NFS patch.

 (*) I've dropped the superblock notifications for now.

 ver #19:

 (*) Split FSINFO_ATTR_MOUNT_TOPOLOGY from FSINFO_ATTR_MOUNT_INFO.  The
     latter requires no locking as it looks no further than the mount
     object it's dealing with.  The topology attribute, however, has to
     take the namespace lock.  That said, the info attribute includes a
     counter that indicates how many times a mount object's position in the
     topology has changed.

 (*) A bit of patch rearrangement to put the mount topology-exposing
     attributes into one patch.

 (*) Pass both AT_* and RESOLVE_* flags to fsinfo() as suggested by Linus,
     rather than adding missing RESOLVE_* flags.

 ver #18:

 (*) Moved the mount and superblock notification patches into a different
     branch.

 (*) Made superblock configuration (->show_opts), bindmount path
     (->show_path) and filesystem statistics (->show_stats) available as
     the CONFIGURATION, MOUNT_PATH and FS_STATISTICS attributes.

 (*) Made mountpoint device name available, filtered through the superblock
     (->show_devname), as the SOURCE attribute.

 (*) Made the mountpoint available as a full path as well as a relative
     one.

 (*) Added more event counters to MOUNT_INFO, including a subtree
     notification counter, to make it easier to clean up after a
     notification overrun.

 (*) Made the event counter value returned by MOUNT_CHILDREN the sum of the
     five event counters.

 (*) Added a mount uniquifier and added that to the MOUNT_CHILDREN entries
     also so that mount ID reuse can be detected.

 (*) Merged the SB_NOTIFICATION attribute into the MOUNT_INFO attribute to
     avoid duplicate information.

 (*) Switched to using the RESOLVE_* flags rather than AT_* flags for
     pathwalk control.  Added more RESOLVE_* flags.

 (*) Used a lock instead of RCU to enumerate children for the
     MOUNT_CHILDREN attribute for safety.  This is probably worth
     revisiting at a later date, however.

David
---
David Howells (14):
      fsinfo: Introduce a non-repeating system-unique superblock ID
      fsinfo: Add fsinfo() syscall to query filesystem information
      fsinfo: Provide a bitmap of the features a filesystem supports
      fsinfo: Allow retrieval of superblock devname, options and stats
      fsinfo: Allow fsinfo() to look up a mount object by ID
      fsinfo: Add a uniquifier ID to struct mount
      fsinfo: Allow mount information to be queried
      fsinfo: Allow mount topology and propagation info to be retrieved
      fsinfo: Provide notification overrun handling support
      fsinfo: sample: Mount listing program
      fsinfo: Add API documentation
      fsinfo: Add support for AFS
      fsinfo: Add support to ext4
      fsinfo: Add an attribute that lists all the visible mounts in a namespace

Jeff Layton (3):
      errseq: add a new errseq_scrape function
      vfs: allow fsinfo to fetch the current state of s_wb_err
      samples: add error state information to test-fsinfo.c


 Documentation/filesystems/fsinfo.rst        | 574 +++++++++++++
 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd32.h           |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 fs/Kconfig                                  |   7 +
 fs/Makefile                                 |   1 +
 fs/afs/internal.h                           |   1 +
 fs/afs/super.c                              | 216 ++++-
 fs/d_path.c                                 |   2 +-
 fs/ext4/Makefile                            |   1 +
 fs/ext4/ext4.h                              |   6 +
 fs/ext4/fsinfo.c                            |  97 +++
 fs/ext4/super.c                             |   3 +
 fs/fsinfo.c                                 | 748 +++++++++++++++++
 fs/internal.h                               |  15 +
 fs/mount.h                                  |   3 +
 fs/mount_notify.c                           |   2 +
 fs/namespace.c                              | 427 +++++++++-
 include/linux/errseq.h                      |   1 +
 include/linux/fs.h                          |   4 +
 include/linux/fsinfo.h                      | 112 +++
 include/linux/syscalls.h                    |   4 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 include/uapi/linux/fsinfo.h                 | 345 ++++++++
 include/uapi/linux/mount.h                  |  13 +-
 kernel/sys_ni.c                             |   1 +
 lib/errseq.c                                |  33 +-
 samples/vfs/Makefile                        |   6 +-
 samples/vfs/test-fsinfo.c                   | 881 ++++++++++++++++++++
 samples/vfs/test-mntinfo.c                  | 277 ++++++
 44 files changed, 3791 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/filesystems/fsinfo.rst
 create mode 100644 fs/ext4/fsinfo.c
 create mode 100644 fs/fsinfo.c
 create mode 100644 include/linux/fsinfo.h
 create mode 100644 include/uapi/linux/fsinfo.h
 create mode 100644 samples/vfs/test-fsinfo.c
 create mode 100644 samples/vfs/test-mntinfo.c


