Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3289917E612
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 18:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgCIRvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 13:51:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60805 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726271AbgCIRvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583776266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30ZSJWSDIPDE4fYF7OsUvh2wMidd8+d99NLt7LNwo2k=;
        b=GhNCuNZ3MUYpbQSDM85rAH3xgKdve9RN2HudUVlVgdugjxZBxgkgMlrMHY9CluA0c1hmUp
        ztXKLcxdV+F8AmwITF/x3GrwMbLbO89h2PppF3E5D7E5gU1/USmSpehKZCEH3emDmLX13D
        rYAtnaY+dwus7LLX1M7Bq2dyDXsqxqc=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-J9l2Q22RM_mzI2iR5PDAnQ-1; Mon, 09 Mar 2020 13:51:03 -0400
X-MC-Unique: J9l2Q22RM_mzI2iR5PDAnQ-1
Received: by mail-yw1-f70.google.com with SMTP id i81so16452548ywa.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2020 10:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=30ZSJWSDIPDE4fYF7OsUvh2wMidd8+d99NLt7LNwo2k=;
        b=jH4cHs7XMJpFMw6vRrHW6e+XcHilZFK/a/H/ySU1S66ot0IMszuyLFxZdo1UInk6ND
         x4R4TYXw4H4hfDYfHnhYo9AdetMrl6e1C9IdcyMcah2HOMdqXaneYfMlZaGBkrbVU3jI
         RWRxj/X1qWhWABclzSDgCLiu2WHlhaN+cYeOy5Auun73UqLFyHKbVhWCRfqfpXCLAs9K
         3RvXiWOpeM8snA+x7XNjyxrElbrNOYFio/jEgEXKAY6/oblCYLszZWmrEq3maBvHZHxK
         n6Am3WAM4tIhp0Mso/z8ztqVqBQ+3vNVT/T+Uy+NIuVxdm1iNlhI/A5W6fCcFRJ17rIJ
         zYNw==
X-Gm-Message-State: ANhLgQ094Wq2G/oaA1JoNCrD4rcD+bCUDS6JJo4gW9vldib6rU18GF0H
        LErWkQpfNFRmvLk5NV0KQdcRxakF11PcvtXJPcZn7zIexOl4NR5A6uihLH6+n/ovRDTcZtbODC4
        ewa27CvKEPUSWQdY113KzA++npg==
X-Received: by 2002:a25:d9ce:: with SMTP id q197mr6672349ybg.241.1583776261657;
        Mon, 09 Mar 2020 10:51:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvYV3A8G2xB5rv6q5icA3hNDveYJLmuj6XuWtgu/niwnVZhR0qaxFeSrAZjqkGeQxLl3Sb91w==
X-Received: by 2002:a25:d9ce:: with SMTP id q197mr6672307ybg.241.1583776261007;
        Mon, 09 Mar 2020 10:51:01 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id d70sm2347903ywd.25.2020.03.09.10.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 10:51:00 -0700 (PDT)
Message-ID: <2d31e2658e5f6651dc7d9908c4c12b6ba461fc88.camel@redhat.com>
Subject: Re: [PATCH 00/14] VFS: Filesystem information [ver #18]
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     Theodore Ts'o <tytso@mit.edu>, Stefan Metzmacher <metze@samba.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andres Freund <andres@anarazel.de>
Date:   Mon, 09 Mar 2020 13:50:59 -0400
In-Reply-To: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-03-09 at 14:00 +0000, David Howells wrote:
> Here's a set of patches that adds a system call, fsinfo(), that allows
> information about the VFS, mount topology, superblock and files to be
> retrieved.
> 
> The patchset is based on top of the notifications patchset and allows event
> counters implemented in the latter to be retrieved to allow overruns to be
> efficiently managed.
> 
> Included are a couple of sample programs plus limited example code for NFS
> and Ext4.  The example code is not intended to go upstream as-is.
> 
> 
> =======
> THE WHY
> =======
> 
> Why do we want this?
> 
> Using /proc/mounts (or similar) has problems:
> 
>  (1) Reading from it holds a global lock (namespace_sem) that prevents
>      mounting and unmounting.  Lots of data is encoded and mangled into
>      text whilst the lock is held, including superblock option strings and
>      mount point paths.  This causes performance problems when there are a
>      lot of mount objects in a system.
> 
>  (2) Even though namespace_sem is held during a read, reading the whole
>      file isn't necessarily atomic with respect to mount-type operations.
>      If a read isn't satisfied in one go, then it may return to userspace
>      briefly and then continue reading some way into the file.  But changes
>      can occur in the interval that may then go unseen.
> 
>  (3) Determining what has changed means parsing and comparing consecutive
>      outputs of /proc/mounts.
> 
>  (4) Querying a specific mount or superblock means searching through
>      /proc/mounts and searching by path or mount ID - but we might have an
>      fd we want to query.
> 
>  (5) Mount topology is not explicit.  One must derive it manually by
>      comparing entries.
> 
>  (6) Whilst you can poll() it for events, it only tells you that something
>      changed in the namespace, not what or whether you can even see the
>      change.
> 
> To fix the notification issues, the preceding notifications patchset added
> mount watch notifications whereby you can watch for notifications in a
> specific mount subtree.  The notification messages include the ID(s) of the
> affected mounts.
> 
> To support notifications, however, we need to be able to handle overruns in
> the notification queue.  I added a number of event counters to struct
> super_block and struct mount to allow you to pin down the changes, but
> there needs to be a way to retrieve them.  Exposing them through /proc
> would require adding yet another /proc/mounts-type file.  We could add
> per-mount directories full of attributes in sysfs, but that has issues also
> (see below).
> 
> Adding an extensible system call interface for retrieving filesystem
> information also allows other things to be exposed:
> 
>  (1) Jeff Layton's error handling changes need a way to allow error event
>      information to be retrieved.
> 
>  (2) Bits in masks returned by things like statx() and FS_IOC_GETFLAGS are
>      actually 3-state { Set, Unset, Not supported }.  It could be useful to
>      provide a way to expose information like this[*].
> 
>  (3) Limits of the numerical metadata values in a filesystem[*].
> 
>  (4) Filesystem capability information[*].  Filesystems don't all have the
>      same capabilities, and even different instances may have different
>      capabilities, particularly with network filesystems where the set of
>      may be server-dependent.  Capabilities might even vary at file
>      granularity - though possibly such information should be conveyed
>      through statx() instead.
> 
>  (5) ID mapping/shifting tables in use for a superblock.
> 
>  (6) Filesystem-specific information.  I need something for AFS so that I
>      can do pioctl()-emulation, thereby allowing me to implement certain of
>      the AFS command line utilities that query state of a particular file.
>      This could also have application for other filesystems, such as NFS,
>      CIFS and ext4.
> 
>  [*] In a lot of cases these are probably fixed and can be memcpy'd from
>      static data.
> 
> There's a further consideration: I want to make it possible to have
> fsconfig(fd, FSCONFIG_CMD_CREATE) be intercepted by a container manager
> such that the manager can supervise a mount attempted inside the container.
> The manager would be given an fd pointing to the fs_context struct and
> would then need some way to query it (fsinfo()) and modify it (fsconfig()).
> This could also be used to arbitrate user-requested mounts when containers
> are not in play.
> 
> 
> ============================
> WHY NOT USE PROCFS OR SYSFS?
> ============================
> 
> Why is it better to go with a new system call rather than adding more magic
> stuff to /proc or /sysfs for each superblock object and each mount object?
> 
>  (1) It can be targetted.  It makes it easy to query directly by path or
>      fd, but can also query by mount ID or fscontext fd.  procfs and sysfs
>      cannot do three of these things easily.
> 
>  (2) Easier to provide LSM oversight.  Is the accessing process allowed to
>      query information pertinent to a particular file?
> 
>  (3) It's more efficient as we can return specific binary data rather than
>      making huge text dumps.  Granted, sysfs and procfs could present the
>      same data, though as lots of little files which have to be
>      individually opened, read, closed and parsed.
> 
>  (4) We wouldn't have the overhead of open and close (even adding a
>      self-contained readfile() syscall has to do that internally).
> 
>  (5) Opening a file in procfs or sysfs has a pathwalk overhead for each
>      file accessed.  We can use an integer attribute ID instead (yes, this
>      is similar to ioctl) - but could also use a string ID if that is
>      preferred.
> 
>  (6) Can query cross-namespace if, say, a container manager process is
>      given an fs_context that hasn't yet been mounted into a namespace - or
>      hasn't even been fully created yet.
> 
>  (7) Don't have to create/delete a bunch of sysfs/procfs nodes each time a
>      mount happens or is removed - and since systemd makes much use of
>      mount namespaces and mount propagation, this will create a lot of
>      nodes.
> 
> 
> ================
> DESIGN DECISIONS
> ================
> 
>  (1) Information is partitioned into sets of attributes.
> 
>  (2) Attribute IDs are integers as they're fast to compare.
> 
>  (3) Attribute values are typed (struct, list of structs, string, opaque
>      blob).  They type is fixed for a particular attribute.
> 
>  (4) For structure types, the length is also a version.  New fields can be
>      tacked onto the end.
> 
>  (5) When copying a versioned struct to userspace, the core handles a
>      version mismatch by truncating or zero-padding the data as necessary.
>      None of this is seen by the filesystem.
> 
>  (6) The core handles all the buffering and buffer resizing.
> 
>  (7) The filesystem never gets any access to the userspace parameter buffer
>      or result buffer.
> 
>  (8) "Meta" attributes can describe other attributes.
> 
> 
> ========
> OVERVIEW
> ========
> 
> fsinfo() is a system call that allows information about the filesystem at a
> particular path point to be queried as a set of attributes.
> 
> Attribute values are of four basic types:
> 
>  (1) Structure with version-dependent length (the length is the version).
> 
>  (2) Variable-length string.
> 
>  (3) List of structures (all the same length).
> 
>  (4) Opaque blob.
> 
> Attributes can have multiple values either as a sequence of values or a
> sequence-of-sequences of values and all the values of a particular
> attribute must be of the same type.  Values can be up to INT_MAX size,
> subject to memory availability.
> 
> Note that the values of an attribute *are* allowed to vary between dentries
> within a single superblock, depending on the specific dentry that you're
> looking at, but the values still have to be of the type for that attribute.
> 
> I've tried to make the interface as light as possible, so integer attribute
> ID rather than string and the core does all the buffer allocation and
> expansion and all the extensibility support work rather than leaving that
> to the filesystems.  This means that userspace pointers are not exposed to
> the filesystem.
> 
> 
> fsinfo() allows a variety of information to be retrieved about a filesystem
> and the mount topology:
> 
>  (1) General superblock attributes:
> 
>      - Filesystem identifiers (UUID, volume label, device numbers, ...)
>      - The limits on a filesystem's capabilities
>      - Information on supported statx fields and attributes and IOC flags.
>      - A variety single-bit flags indicating supported capabilities.
>      - Timestamp resolution and range.
>      - The amount of space/free space in a filesystem (as statfs()).
>      - Superblock notification counter.
> 
>  (2) Filesystem-specific superblock attributes:
> 
>      - Superblock-level timestamps.
>      - Cell name, workgroup or other netfs grouping concept.
>      - Server names and addresses.
> 
>  (3) VFS information:
> 
>      - Mount topology information.
>      - Mount attributes.
>      - Mount notification counter.
>      - Mount point path.
> 
>  (4) Information about what the fsinfo() syscall itself supports, including
>      the type and struct size of attributes.
> 
> The system is extensible:
> 
>  (1) New attributes can be added.  There is no requirement that a
>      filesystem implement every attribute.  A helper function is provided
>      to scan a list of attributes and a filesystem can have multiple such
>      lists.
> 
>  (2) Version length-dependent structure attributes can be made larger and
>      have additional information tacked on the end, provided it keeps the
>      layout of the existing fields.  If an older process asks for a shorter
>      structure, it will only be given the bits it asks for.  If a newer
>      process asks for a longer structure on an older kernel, the extra
>      space will be set to 0.  In all cases, the size of the data actually
>      available is returned.
> 
>      In essence, the size of a structure is that structure's version: a
>      smaller size is an earlier version and a later version includes
>      everything that the earlier version did.
> 
>  (3) New single-bit capability flags can be added.  This is a structure-typed
>      attribute and, as such, (2) applies.  Any bits you wanted but the kernel
>      doesn't support are automatically set to 0.
> 
> fsinfo() may be called like the following, for example:
> 
> 	struct fsinfo_params params = {
> 		.resolve_flags	= RESOLVE_NO_TRAILING_SYMLINKS,
> 		.flags		= FSINFO_FLAGS_QUERY_PATH,
> 		.request	= FSINFO_ATTR_AFS_SERVER_ADDRESSES,
> 		.Nth		= 2,
> 	};
> 	struct fsinfo_server_address address;
> 	len = fsinfo(AT_FDCWD, "/afs/grand.central.org/doc", &params,
> 		     &address, sizeof(address));
> 
> The above example would query an AFS filesystem to retrieve the address
> list for the 3rd server, and:
> 
> 	struct fsinfo_params params = {
> 		.resolve_flags	= RESOLVE_NO_TRAILING_SYMLINKS,
> 		.flags		= FSINFO_FLAGS_QUERY_PATH,
> 		.request	= FSINFO_ATTR_NFS_SERVER_NAME;
> 	};
> 	char server_name[256];
> 	len = fsinfo(AT_FDCWD, "/home/dhowells/", &params,
> 		     &server_name, sizeof(server_name));
> 
> would retrieve the name of the NFS server as a string.
> 
> In future, I want to make fsinfo() capable of querying a context created by
> fsopen() or fspick(), e.g.:
> 
> 	fd = fsopen("ext4", 0);
> 	struct fsinfo_params params = {
> 		.flags		= FSINFO_FLAGS_QUERY_FSCONTEXT,
> 		.request	= FSINFO_ATTR_CONFIGURATION;
> 	};
> 	char buffer[65536];
> 	fsinfo(fd, NULL, &params, &buffer, sizeof(buffer));
> 
> even if that context doesn't currently have a superblock attached.
> 
> The patches can be found here also:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
> 
> on branch:
> 
> 	fsinfo-core
> 
> 
> ===================
> SIGNIFICANT CHANGES
> ===================
> 
>  ver #18:
> 
>  (*) Moved the mount and superblock notification patches into a different
>      branch.
> 
>  (*) Made superblock configuration (->show_opts), bindmount path
>      (->show_path) and filesystem statistics (->show_stats) available as
>      the CONFIGURATION, MOUNT_PATH and FS_STATISTICS attributes.
> 
>  (*) Made mountpoint device name available, filtered through the superblock
>      (->show_devname), as the SOURCE attribute.
> 
>  (*) Made the mountpoint available as a full path as well as a relative
>      one.
> 
>  (*) Added more event counters to MOUNT_INFO, including a subtree
>      notification counter, to make it easier to clean up after a
>      notification overrun.
> 
>  (*) Made the event counter value returned by MOUNT_CHILDREN the sum of the
>      five event counters.
> 
>  (*) Added a mount uniquifier and added that to the MOUNT_CHILDREN entries
>      also so that mount ID reuse can be detected.
> 
>  (*) Merged the SB_NOTIFICATION attribute into the MOUNT_INFO attribute to
>      avoid duplicate information.
> 
>  (*) Switched to using the RESOLVE_* flags rather than AT_* flags for
>      pathwalk control.  Added more RESOLVE_* flags.
> 
>  (*) Used a lock instead of RCU to enumerate children for the
>      MOUNT_CHILDREN attribute for safety.  This is probably worth
>      revisiting at a later date, however.
> 
> 
>  ver #17:
> 
>  (*) Applied comments from Jann Horn, Darrick Wong and Christian Brauner.
> 
>  (*) Rearranged the order in which fsinfo() does things so that the
>      superblock operations table can have a function pointer rather than a
>      table pointer.  The ->fsinfo() op is now called at least twice, once
>      to determine the size of buffer needed and then to retrieve the data.
>      If the retrieval step indicates yet more space is needed, the buffer
>      will be expanded and that step repeated.
> 
>  (*) Merge the element size into the size in the fsinfo_attribute def and
>      don't set size for strings or opaques.  Let a helper work that out.
>      This means that strings can actually get larger then 4K.
> 
>  (*) A helper is provided to scan a list of attributes and call the
>      appropriate get function.  This can be called from a filesystem's
>      ->fsinfo() method multiple times.  It also handles attribute
>      enumeration and info querying.
> 
>  (*) Rearranged the patches to put all the notification patches first.
>      This allowed some of the bits to be squashed together.  At some point,
>      I'll move the notification patches into a different branch.
> 
>  ver #16:
> 
>  (*) Split the features bits out of the fsinfo() core into their own patch
>      and got rid of the name encoding attributes.
> 
>  (*) Renamed the 'array' type to 'list' and made AFS use it for returning
>      server address lists.
> 
>  (*) Changed the ->fsinfo() method into an ->fsinfo_attributes[] table,
>      where each attribute has a ->get() method to deal with it.  These
>      tables can then be returned with an fsinfo meta attribute.
> 
>  (*) Dropped the fscontext query and parameter/description retrieval
>      attributes for now.
> 
>  (*) Picked the mount topology attributes into this branch.
> 
>  (*) Picked the mount notifications into this branch and rebased on top of
>      notifications-pipe-core.
> 
>  (*) Picked the superblock notifications into this branch.
> 
>  (*) Add sample code for Ext4 and NFS.
> 
> David
> ---
> David Howells (14):
>       VFS: Add additional RESOLVE_* flags
>       fsinfo: Add fsinfo() syscall to query filesystem information
>       fsinfo: Provide a bitmap of supported features
>       fsinfo: Allow retrieval of superblock devname, options and stats
>       fsinfo: Allow fsinfo() to look up a mount object by ID
>       fsinfo: Add a uniquifier ID to struct mount
>       fsinfo: Allow mount information to be queried
>       fsinfo: Allow the mount topology propogation flags to be retrieved
>       fsinfo: Provide notification overrun handling support
>       fsinfo: sample: Mount listing program
>       fsinfo: Add API documentation
>       fsinfo: Add support for AFS
>       fsinfo: Example support for Ext4
>       fsinfo: Example support for NFS
> 
> 
>  Documentation/filesystems/fsinfo.rst        |  564 +++++++++++++++++
>  arch/alpha/kernel/syscalls/syscall.tbl      |    1 
>  arch/arm/tools/syscall.tbl                  |    1 
>  arch/arm64/include/asm/unistd.h             |    2 
>  arch/ia64/kernel/syscalls/syscall.tbl       |    1 
>  arch/m68k/kernel/syscalls/syscall.tbl       |    1 
>  arch/microblaze/kernel/syscalls/syscall.tbl |    1 
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 
>  arch/parisc/kernel/syscalls/syscall.tbl     |    1 
>  arch/powerpc/kernel/syscalls/syscall.tbl    |    1 
>  arch/s390/kernel/syscalls/syscall.tbl       |    1 
>  arch/sh/kernel/syscalls/syscall.tbl         |    1 
>  arch/sparc/kernel/syscalls/syscall.tbl      |    1 
>  arch/x86/entry/syscalls/syscall_32.tbl      |    1 
>  arch/x86/entry/syscalls/syscall_64.tbl      |    1 
>  arch/xtensa/kernel/syscalls/syscall.tbl     |    1 
>  fs/Kconfig                                  |    7 
>  fs/Makefile                                 |    1 
>  fs/afs/internal.h                           |    1 
>  fs/afs/super.c                              |  218 +++++++
>  fs/d_path.c                                 |    2 
>  fs/ext4/Makefile                            |    1 
>  fs/ext4/ext4.h                              |    6 
>  fs/ext4/fsinfo.c                            |   45 +
>  fs/ext4/super.c                             |    3 
>  fs/fsinfo.c                                 |  720 ++++++++++++++++++++++
>  fs/internal.h                               |   13 
>  fs/mount.h                                  |    3 
>  fs/namespace.c                              |  362 +++++++++++
>  fs/nfs/Makefile                             |    1 
>  fs/nfs/fsinfo.c                             |  230 +++++++
>  fs/nfs/internal.h                           |    6 
>  fs/nfs/nfs4super.c                          |    3 
>  fs/nfs/super.c                              |    3 
>  fs/open.c                                   |    8 
>  include/linux/fcntl.h                       |    3 
>  include/linux/fs.h                          |    4 
>  include/linux/fsinfo.h                      |  111 +++
>  include/linux/syscalls.h                    |    4 
>  include/uapi/asm-generic/unistd.h           |    4 
>  include/uapi/linux/fsinfo.h                 |  360 +++++++++++
>  include/uapi/linux/mount.h                  |   10 
>  include/uapi/linux/openat2.h                |    8 
>  include/uapi/linux/windows.h                |   35 +
>  kernel/sys_ni.c                             |    1 
>  samples/vfs/Makefile                        |    7 
>  samples/vfs/test-fsinfo.c                   |  880 +++++++++++++++++++++++++++
>  samples/vfs/test-mntinfo.c                  |  277 ++++++++
>  50 files changed, 3905 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/filesystems/fsinfo.rst
>  create mode 100644 fs/ext4/fsinfo.c
>  create mode 100644 fs/fsinfo.c
>  create mode 100644 fs/nfs/fsinfo.c
>  create mode 100644 include/linux/fsinfo.h
>  create mode 100644 include/uapi/linux/fsinfo.h
>  create mode 100644 include/uapi/linux/windows.h
>  create mode 100644 samples/vfs/test-fsinfo.c
>  create mode 100644 samples/vfs/test-mntinfo.c
> 
> 
The PostgreSQL devs asked a while back for some way to tell whether
there have been any writeback errors on a superblock w/o having to do
any sort of flush -- just "have there been any so far".

I sent a patch a few weeks ago to make syncfs() return errors when there
have been writeback errors on the superblock. It's not merged yet, but
once we have something like that in place, we could expose info from the
errseq_t to userland using this interface.

Something like this patch would do it (which depends on a few others in
my tree, nothing very large though):

---------------------------8<-----------------------

[PATCH] vfs: allow fsinfo to fetch the current state of s_wb_err

Add a new "error_state" struct to fsinfo, and teach the kernel to fill
that out from sb->s_wb_info. There are two fields:

wb_error_last: the most recently recorded errno for the filesystem

wb_error_cookie: this value will change vs. the previously fetched
                 value if a new error was recorded since it was last
		 checked. Callers should treat this as an opaque value
		 that can be compared to earlier fetched values.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/fsinfo.c                 | 11 +++++++++++
 include/uapi/linux/fsinfo.h | 13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 6d2bc03998e4..3bbe6d7b1a79 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -275,6 +275,7 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_SOURCE,		fsinfo_generic_mount_source),
 	FSINFO_STRING	(FSINFO_ATTR_CONFIGURATION,	fsinfo_generic_seq_read),
 	FSINFO_STRING	(FSINFO_ATTR_FS_STATISTICS,	fsinfo_generic_seq_read),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_ERROR_STATE,	fsinfo_generic_error_state),
 
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	(void *)123UL),
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, (void *)123UL),
@@ -376,6 +377,16 @@ static int fsinfo_get_attribute_info(struct path *path,
 	return -EOPNOTSUPP; /* We want to go through all the lists */
 }
 
+static int fsinfo_generic_error_state(struct path *path,
+				      struct fsinfo_context *ctx)
+{
+	struct fsinfo_error_state *es = ctx->buffer;
+
+	es->wb_error_cookie = errseq_scrape(&path->dentry->d_sb->s_wb_err);
+	es->wb_error_last = es->wb_error_cookie & MAX_ERRNO;
+	return sizeof(*es);
+}
+
 /**
  * fsinfo_get_attribute - Look up and handle an attribute
  * @path: The object to query
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 346cf0cf42cb..3d33744c2320 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -27,6 +27,7 @@
 #define FSINFO_ATTR_SOURCE		0x09	/* Superblock source/device name (string) */
 #define FSINFO_ATTR_CONFIGURATION	0x0a	/* Superblock configuration/options (string) */
 #define FSINFO_ATTR_FS_STATISTICS	0x0b	/* Superblock filesystem statistics (string) */
+#define FSINFO_ATTR_ERROR_STATE	0x0c	/* errseq_t state */
 
 #define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about attr N (for path) */
 #define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attrs (for path) */
@@ -357,4 +358,16 @@ struct fsinfo_nfs_server_address {
 
 #define FSINFO_ATTR_NFS_SERVER_ADDRESSES__STRUCT struct fsinfo_nfs_server_address
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_ERROR_STATE).
+ *
+ * Retrieve the error state for a filesystem.
+ */
+struct fsinfo_error_state {
+	__u32		wb_error_cookie;	/* writeback error cookie */
+	__u32		wb_error_last;		/* latest writeback error */
+};
+
+#define FSINFO_ATTR_ERROR_STATE__STRUCT struct fsinfo_error_state
+
 #endif /* _UAPI_LINUX_FSINFO_H */
-- 
2.24.1


