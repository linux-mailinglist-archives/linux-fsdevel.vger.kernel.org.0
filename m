Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269EC23A9DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 17:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgHCPuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 11:50:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60509 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726910AbgHCPuR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596469814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=K8UT3unDVivSo/7e8l6c/7QHWGzaynkhVMN6d7Xbnu4=;
        b=c3oR4wA1u9QzYIYux8fbol9B8BLPY0z5qZhh/NBbcWZgQse3F7zNnJK3zezyPNnC4IYWip
        0LNOc5kiLAJ7pww5EJkM6OpglD8ACrfBhEOaWeTfNeI4b6tJKH7f2FyqVlnlk6mi2oZuiY
        Pbsu9YDoxTbfLmnFsD86Lle0em+mXLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-Z2eXgYxdPZ2fGuXFCfPxuQ-1; Mon, 03 Aug 2020 11:50:10 -0400
X-MC-Unique: Z2eXgYxdPZ2fGuXFCfPxuQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E23DD106B2AE;
        Mon,  3 Aug 2020 15:50:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02030277A5;
        Mon,  3 Aug 2020 15:49:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
References: <1842689.1596468469@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        kzak@redhat.com, jlayton@redhat.com, mszeredi@redhat.com,
        nicolas.dichtel@6wind.com, christian@brauner.io,
        lennart@poettering.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Filesystem Information
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 03 Aug 2020 16:49:55 +0100
Message-ID: <1845353.1596469795@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Linus,

Here's a set of patches that adds a system call, fsinfo(), that allows
information about the VFS, mount topology, superblock and files to be
retrieved.

The patchset is based on top of the mount notifications patchset so that
the mount notification mechanism can be hooked to provide event counters
that can be retrieved with fsinfo(), thereby making it a lot faster to work
out which mounts have changed.

Note that there was a last minute change requested by Mikl=C3=B3s: the event
counter bits got moved from the mount notification patchset to this one.
The counters got made atomic_long_t inside the kernel and __u64 in the
UAPI.  The aggregate changes can be assessed by comparing pre-change tag,
fsinfo-core-20200724 to the requested pull tag.

Karel Zak has created preliminary patches that add support to libmount[*]
and Ian Kent has started working on making systemd use these and mount
notifications[**].

[*] https://github.com/karelzak/util-linux/commits/topic/fsinfo

[**] https://lists.freedesktop.org/archives/systemd-devel/2020-July/044914.=
html


=3D=3D=3D=3D=3D=3D=3D
THE WHY
=3D=3D=3D=3D=3D=3D=3D

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


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DESIGN DECISIONS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

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


=3D=3D=3D=3D=3D=3D=3D=3D
OVERVIEW
=3D=3D=3D=3D=3D=3D=3D=3D

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

 (3) New single-bit capability flags can be added.  This is a structure-typ=
ed
     attribute and, as such, (2) applies.  Any bits you wanted but the kern=
el
     doesn't support are automatically set to 0.

fsinfo() may be called like the following, for example:

	struct fsinfo_params params =3D {
		.at_flags	=3D AT_SYMLINK_NOFOLLOW,
		.flags		=3D FSINFO_FLAGS_QUERY_PATH,
		.request	=3D FSINFO_ATTR_AFS_SERVER_ADDRESSES,
		.Nth		=3D 2,
	};
	struct fsinfo_server_address address;
	len =3D fsinfo(AT_FDCWD, "/afs/grand.central.org/doc",
		     &params, sizeof(params),
		     &address, sizeof(address));

The above example would query an AFS filesystem to retrieve the address
list for the 3rd server, and:

	struct fsinfo_params params =3D {
		.at_flags	=3D AT_SYMLINK_NOFOLLOW,
		.flags		=3D FSINFO_FLAGS_QUERY_PATH,
		.request	=3D FSINFO_ATTR_NFS_SERVER_NAME;
	};
	char server_name[256];
	len =3D fsinfo(AT_FDCWD, "/home/dhowells/",
		     &params, sizeof(params),
		     &server_name, sizeof(server_name));

would retrieve the name of the NFS server as a string.

In future, I want to make fsinfo() capable of querying a context created by
fsopen() or fspick(), e.g.:

	fd =3D fsopen("ext4", 0);
	struct fsinfo_params params =3D {
		.flags		=3D FSINFO_FLAGS_QUERY_FSCONTEXT,
		.request	=3D FSINFO_ATTR_CONFIGURATION;
	};
	char buffer[65536];
	fsinfo(fd, NULL, &params, sizeof(params), &buffer, sizeof(buffer));

even if that context doesn't currently have a superblock attached.


David
---
The following changes since commit 841a0dfa511364fa9a8d67512e0643669f1f03e3:

  watch_queue: sample: Display mount tree change notifications (2020-08-03 =
12:15:38 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/=
fsinfo-core-20200803

for you to fetch changes up to 19d687f5902b65a158c5bec904d65d0525ea4efe:

  samples: add error state information to test-fsinfo.c (2020-08-03 13:43:4=
6 +0100)

----------------------------------------------------------------
Filesystem information

----------------------------------------------------------------
David Howells (15):
      fsinfo: Introduce a non-repeating system-unique superblock ID
      fsinfo: Add fsinfo() syscall to query filesystem information
      fsinfo: Provide a bitmap of the features a filesystem supports
      fsinfo: Allow retrieval of superblock devname, options and stats
      fsinfo: Allow fsinfo() to look up a mount object by ID
      fsinfo: Add a uniquifier ID to struct mount
      fsinfo: Allow mount information to be queried
      fsinfo: Allow mount topology and propagation info to be retrieved
      watch_queue: Mount event counters
      fsinfo: Provide notification overrun handling support
      fsinfo: sample: Mount listing program
      fsinfo: Add API documentation
      fsinfo: Add support for AFS
      fsinfo: Add support to ext4
      fsinfo: Add an attribute that lists all the visible mounts in a names=
pace

Jeff Layton (3):
      errseq: add a new errseq_scrape function
      vfs: allow fsinfo to fetch the current state of s_wb_err
      samples: add error state information to test-fsinfo.c

 Documentation/filesystems/fsinfo.rst        | 574 ++++++++++++++++++
 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd.h             |   2 +-
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
 fs/afs/super.c                              | 216 ++++++-
 fs/d_path.c                                 |   2 +-
 fs/ext4/Makefile                            |   1 +
 fs/ext4/ext4.h                              |   6 +
 fs/ext4/fsinfo.c                            |  97 +++
 fs/ext4/super.c                             |   3 +
 fs/fsinfo.c                                 | 748 +++++++++++++++++++++++
 fs/internal.h                               |  16 +
 fs/mount.h                                  |   6 +
 fs/mount_notify.c                           |  10 +-
 fs/namespace.c                              | 427 +++++++++++++-
 fs/super.c                                  |   2 +
 include/linux/errseq.h                      |   1 +
 include/linux/fs.h                          |   7 +
 include/linux/fsinfo.h                      | 112 ++++
 include/linux/syscalls.h                    |   4 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 include/uapi/linux/fsinfo.h                 | 344 +++++++++++
 include/uapi/linux/mount.h                  |  13 +-
 kernel/sys_ni.c                             |   1 +
 lib/errseq.c                                |  33 +-
 samples/vfs/Makefile                        |   6 +-
 samples/vfs/test-fsinfo.c                   | 883 ++++++++++++++++++++++++=
++++
 samples/vfs/test-mntinfo.c                  | 277 +++++++++
 46 files changed, 3808 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/filesystems/fsinfo.rst
 create mode 100644 fs/ext4/fsinfo.c
 create mode 100644 fs/fsinfo.c
 create mode 100644 include/linux/fsinfo.h
 create mode 100644 include/uapi/linux/fsinfo.h
 create mode 100644 samples/vfs/test-fsinfo.c
 create mode 100644 samples/vfs/test-mntinfo.c

