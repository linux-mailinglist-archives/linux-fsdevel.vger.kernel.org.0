Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89F73197EB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 16:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgC3On2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 10:43:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57420 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728500AbgC3On1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585579405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NdgMqytT/5K4fWVCzOyE8JxSDEeceY1fzG9HXeCbrkk=;
        b=hooEDvFm5LciiR3YW0MERM50+QXjDSJXREFODC6bEPjcN6bLdvsqubdh/SS18ulpgamSse
        WIt+6zTR4/Mt5MC1kra7K8Y8D9cgcs3Df+k5GysEOy7Ywr2YKgjGF+njfKCsiYgdGvNnIo
        pNMCShobKO3MTfgmag8vAbsCR+fT6XA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-YVz-3ff2PpyuvdN5ojGHlw-1; Mon, 30 Mar 2020 10:43:24 -0400
X-MC-Unique: YVz-3ff2PpyuvdN5ojGHlw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C349F1005513;
        Mon, 30 Mar 2020 14:43:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-66.rdu2.redhat.com [10.10.112.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EDC7CFEA;
        Mon, 30 Mar 2020 14:43:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
References: <1445647.1585576702@warthog.procyon.org.uk>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, dray@redhat.com,
        kzak@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com,
        jlayton@redhat.com, raven@themaw.net, andres@anarazel.de,
        christian.brauner@ubuntu.com, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fsinfo: Filesystem information query
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1450011.1585579399.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 30 Mar 2020 15:43:19 +0100
Message-ID: <1450012.1585579399@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

If you could consider pulling this - or would you prefer it to go through
Al?  It adds a system call, fsinfo(), that allows information about the
VFS, mount topology, superblock and files to be retrieved.

This based on top of the mount and superblock notifications patchset and
allows event counters implemented in the latter to be retrieved to allow
overruns to be efficiently managed.

I've excluded the Ext4 and NFS sample code from this pull request that I'v=
e
previously included in my posted patchsets.


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
     briefly and then continue reading some way into the file.  But change=
s
     can occur in the interval that may then go unseen.

 (3) Determining what has changed means parsing and comparing consecutive
     outputs of /proc/mounts.

 (4) Querying a specific mount or superblock means searching through
     /proc/mounts and searching by path or mount ID - but we might have an
     fd we want to query.

 (5) Mount topology is not explicit.  One must derive it manually by
     comparing entries.

 (6) Whilst you can poll() it for events, it only tells you that something
     changed in the namespace, not what or whether you can even see the
     change.

To fix the notification issues, the preceding notifications patchset added
mount watch notifications whereby you can watch for notifications in a
specific mount subtree.  The notification messages include the ID(s) of th=
e
affected mounts.

To support notifications, however, we need to be able to handle overruns i=
n
the notification queue.  I added a number of event counters to struct
super_block and struct mount to allow you to pin down the changes, but
there needs to be a way to retrieve them.  Exposing them through /proc
would require adding yet another /proc/mounts-type file.  We could add
per-mount directories full of attributes in sysfs, but that has issues als=
o
(see below).

Adding an extensible system call interface for retrieving filesystem
information also allows other things to be exposed:

 (1) Jeff Layton's error handling changes need a way to allow error event
     information to be retrieved.

 (2) Bits in masks returned by things like statx() and FS_IOC_GETFLAGS are
     actually 3-state { Set, Unset, Not supported }.  It could be useful t=
o
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
     can do pioctl()-emulation, thereby allowing me to implement certain o=
f
     the AFS command line utilities that query state of a particular file.
     This could also have application for other filesystems, such as NFS,
     CIFS and ext4.

 [*] In a lot of cases these are probably fixed and can be memcpy'd from
     static data.

There's a further consideration: I want to make it possible to have
fsconfig(fd, FSCONFIG_CMD_CREATE) be intercepted by a container manager
such that the manager can supervise a mount attempted inside the container=
.
The manager would be given an fd pointing to the fs_context struct and
would then need some way to query it (fsinfo()) and modify it (fsconfig())=
.
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
     None of this is seen by the filesystem.

 (6) The core handles all the buffering and buffer resizing.

 (7) The filesystem never gets any access to the userspace parameter buffe=
r
     or result buffer.

 (8) "Meta" attributes can describe other attributes.


=3D=3D=3D=3D=3D=3D=3D=3D
OVERVIEW
=3D=3D=3D=3D=3D=3D=3D=3D

fsinfo() is a system call that allows information about the filesystem at =
a
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

Note that the values of an attribute *are* allowed to vary between dentrie=
s
within a single superblock, depending on the specific dentry that you're
looking at, but the values still have to be of the type for that attribute=
.

I've tried to make the interface as light as possible, so integer attribut=
e
ID rather than string and the core does all the buffer allocation and
expansion and all the extensibility support work rather than leaving that
to the filesystems.  This means that userspace pointers are not exposed to
the filesystem.


fsinfo() allows a variety of information to be retrieved about a filesyste=
m
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

 (4) Information about what the fsinfo() syscall itself supports, includin=
g
     the type and struct size of attributes.

The system is extensible:

 (1) New attributes can be added.  There is no requirement that a
     filesystem implement every attribute.  A helper function is provided
     to scan a list of attributes and a filesystem can have multiple such
     lists.

 (2) Version length-dependent structure attributes can be made larger and
     have additional information tacked on the end, provided it keeps the
     layout of the existing fields.  If an older process asks for a shorte=
r
     structure, it will only be given the bits it asks for.  If a newer
     process asks for a longer structure on an older kernel, the extra
     space will be set to 0.  In all cases, the size of the data actually
     available is returned.

     In essence, the size of a structure is that structure's version: a
     smaller size is an earlier version and a later version includes
     everything that the earlier version did.

 (3) New single-bit capability flags can be added.  This is a structure-ty=
ped
     attribute and, as such, (2) applies.  Any bits you wanted but the ker=
nel
     doesn't support are automatically set to 0.

fsinfo() may be called like the following, for example:

	struct fsinfo_params params =3D {
		.at_flags	=3D AT_SYMLINK_NOFOLLOW,
		.flags		=3D FSINFO_FLAGS_QUERY_PATH,
		.request	=3D FSINFO_ATTR_AFS_SERVER_ADDRESSES,
		.Nth		=3D 2,
	};
	struct fsinfo_server_address address;
	len =3D fsinfo(AT_FDCWD, "/afs/grand.central.org/doc", &params,
		     &address, sizeof(address));

The above example would query an AFS filesystem to retrieve the address
list for the 3rd server, and:

	struct fsinfo_params params =3D {
		.at_flags	=3D AT_SYMLINK_NOFOLLOW,
		.flags		=3D FSINFO_FLAGS_QUERY_PATH,
		.request	=3D FSINFO_ATTR_NFS_SERVER_NAME;
	};
	char server_name[256];
	len =3D fsinfo(AT_FDCWD, "/home/dhowells/", &params,
		     &server_name, sizeof(server_name));

would retrieve the name of the NFS server as a string.

In future, I want to make fsinfo() capable of querying a context created b=
y
fsopen() or fspick(), e.g.:

	fd =3D fsopen("ext4", 0);
	struct fsinfo_params params =3D {
		.flags		=3D FSINFO_FLAGS_QUERY_FSCONTEXT,
		.request	=3D FSINFO_ATTR_CONFIGURATION;
	};
	char buffer[65536];
	fsinfo(fd, NULL, &params, &buffer, sizeof(buffer));

even if that context doesn't currently have a superblock attached.

Thanks,
David
---
The following changes since commit 8dbf1aa122da5bbb4ede0f363a8a18dfc723be3=
3:

  watch_queue: sample: Display superblock notifications (2020-03-19 17:31:=
09 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/fsinfo-20200330

for you to fetch changes up to 80f0ef902951fd3e7446767e7d37d543d936b72f:

  fsinfo: Add support for AFS (2020-03-19 17:31:34 +0000)

----------------------------------------------------------------
Filesystem information

----------------------------------------------------------------
David Howells (11):
      fsinfo: Add fsinfo() syscall to query filesystem information
      fsinfo: Provide a bitmap of supported features
      fsinfo: Allow retrieval of superblock devname, options and stats
      fsinfo: Allow fsinfo() to look up a mount object by ID
      fsinfo: Add a uniquifier ID to struct mount
      fsinfo: Allow mount information to be queried
      fsinfo: Allow mount topology and propagation info to be retrieved
      fsinfo: Provide notification overrun handling support
      fsinfo: sample: Mount listing program
      fsinfo: Add API documentation
      fsinfo: Add support for AFS

 Documentation/filesystems/fsinfo.rst        | 574 +++++++++++++++++++
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
 fs/afs/super.c                              | 218 +++++++-
 fs/d_path.c                                 |   2 +-
 fs/fsinfo.c                                 | 725 +++++++++++++++++++++++=
+
 fs/internal.h                               |  14 +
 fs/mount.h                                  |   3 +
 fs/mount_notify.c                           |   2 +
 fs/namespace.c                              | 389 ++++++++++++-
 include/linux/fs.h                          |   4 +
 include/linux/fsinfo.h                      | 111 ++++
 include/linux/syscalls.h                    |   4 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 include/uapi/linux/fsinfo.h                 | 326 +++++++++++
 include/uapi/linux/mount.h                  |  10 +-
 kernel/sys_ni.c                             |   1 +
 samples/vfs/Makefile                        |   7 +
 samples/vfs/test-fsinfo.c                   | 818 +++++++++++++++++++++++=
+++++
 samples/vfs/test-mntinfo.c                  | 279 ++++++++++
 39 files changed, 3511 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/filesystems/fsinfo.rst
 create mode 100644 fs/fsinfo.c
 create mode 100644 include/linux/fsinfo.h
 create mode 100644 include/uapi/linux/fsinfo.h
 create mode 100644 samples/vfs/test-fsinfo.c
 create mode 100644 samples/vfs/test-mntinfo.c

