Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6E43DB62A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 11:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbhG3Jlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 05:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhG3Jln (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:41:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70C33603E9;
        Fri, 30 Jul 2021 09:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627638099;
        bh=CPHYDTR1oYdXfo1M632p9LWhgverub63Lz/0wZ1qIzA=;
        h=From:To:Cc:Subject:Date:From;
        b=mmhB4+0YQSfLRtrRkJpQtAJgAA3ezg/rN56Sckx+OccAaW6jdJsEvEpuerlW1Kdki
         2AHd7155Z8YLU+W03FKof8MhTOuxa+4Z1qAPA5OFJA4YELlBnRPzgc5mfU4WCkOkk/
         CJYJ7YosXrk9+nZml+P4thrwGKsc0bRThgQe5eOL5cjOusMEp3ATE0/Bh9rcm1QCoM
         BrYlTi6U2YR1YGEmTc2f4AEtouy4LnBKJpcfpVLUmwM+iB2adPi0dRrR9qh/TYCfI5
         mug2mXODzqhXs4pDbY5GTDBxrjkvBa26XE69ZZsG/GRg2QVNN4XUOiU203xN5owF+z
         VeaBLqSEASFYg==
From:   Christian Brauner <brauner@kernel.org>
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2] mount_setattr.2: New manual page documenting the mount_setattr() system call
Date:   Fri, 30 Jul 2021 11:41:21 +0200
Message-Id: <20210730094121.3252024-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=31859; h=from:subject; bh=gTLhuPCTzn81eP+Vsfysd2qHKkv42H/ixIHIEJe8B0s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQyn7T7t/mLSpVF1Z3jCufMKrdPXvT3zhdPnUmXrarOr2L/ /qRavaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiyy8xMhw99T3xWKydvabgwlxGW+ mZzoymb4L0K/MPPs0wFvGI0GFk+Cb3MVvpfrO1zYb5cRuv3Cwyl+64YXxkclf//PWfHnO3cgEA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 man2/mount_setattr.2 | 1071 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1071 insertions(+)
 create mode 100644 man2/mount_setattr.2

diff --git a/man2/mount_setattr.2 b/man2/mount_setattr.2
new file mode 100644
index 000000000..1ef7630f2
--- /dev/null
+++ b/man2/mount_setattr.2
@@ -0,0 +1,1071 @@
+.\" Copyright (c) 2021 by Christian Brauner <christian.brauner@ubuntu.com>
+.\"
+.\" %%%LICENSE_START(VERBATIM)
+.\" Permission is granted to make and distribute verbatim copies of this
+.\" manual provided the copyright notice and this permission notice are
+.\" preserved on all copies.
+.\"
+.\" Permission is granted to copy and distribute modified versions of this
+.\" manual under the conditions for verbatim copying, provided that the
+.\" entire resulting derived work is distributed under the terms of a
+.\" permission notice identical to this one.
+.\"
+.\" Since the Linux kernel and libraries are constantly changing, this
+.\" manual page may be incorrect or out-of-date.  The author(s) assume no
+.\" responsibility for errors or omissions, or for damages resulting from
+.\" the use of the information contained herein.  The author(s) may not
+.\" have taken the same level of care in the production of this manual,
+.\" which is licensed free of charge, as they might when working
+.\" professionally.
+.\"
+.\" Formatted or processed versions of this manual, if unaccompanied by
+.\" the source, must acknowledge the copyright and authors of this work.
+.\" %%%LICENSE_END
+.\"
+.TH MOUNT_SETATTR 2 2021-03-22 "Linux" "Linux Programmer's Manual"
+.SH NAME
+mount_setattr \- change mount properties of a mount or mount tree
+.SH SYNOPSIS
+.nf
+.BI "int mount_setattr(int " dfd ", const char *" path ", unsigned int " flags ,
+.BI "                  struct mount_attr *" attr ", size_t " size );
+.fi
+.PP
+.IR Note :
+There is no glibc wrapper for this system call; see NOTES.
+.SH DESCRIPTION
+The
+.BR mount_setattr (2)
+system call changes the mount properties of a mount or entire mount tree.
+If
+.I path
+is a relative pathname, then it is interpreted relative to the directory
+referred to by the file descriptor
+.I dfd
+(or the current working directory of the calling process, if
+.I dfd
+is the special value
+.BR AT_FDCWD ).
+If
+.I path
+is the empty string and
+.BR AT_EMPTY_PATH
+is specified in
+.I flags
+then the mount properties of the mount identified by
+.I dfd
+are changed.
+.PP
+The
+.BR mount_setattr (2)
+system call uses an extensible structure
+.I ( "struct mount_attr" )
+to allow for future extensions. Any non-flag extensions to
+.BR mount_setattr (2)
+will be implemented as new fields appended to the above structure,
+with a zero value in a new field resulting in the kernel behaving
+as though that extension field was not present.
+Therefore, the caller
+.I must
+zero-fill this structure on initialization.
+(See the "Extensibility" section under
+.B NOTES
+for more details on why this is necessary.)
+.PP
+The
+.I size
+argument should usually be specified as
+.IR "sizeof(struct mount_attr)" .
+However, if the caller does not intend to make use of features that got
+introduced after the initial version of
+.I struct mount_attr
+they are free to pass the size of the initial struct together with the larger
+struct.
+This allows the kernel to not copy later parts of the struct that aren't used
+anyway.
+With each extension that changes the size of
+.I struct mount_attr
+the kernel will expose a define of the form
+.B MOUNT_ATTR_SIZE_VER<number> .
+For example the macro for the size of the initial version of
+.I struct mount_attr
+is
+.BR MOUNT_ATTR_SIZE_VER0 .
+.PP
+The
+.I flags
+argument can be used to alter the path resolution behavior.
+The supported values are:
+.TP
+.B AT_EMPTY_PATH
+If
+.I path
+is the empty string change the mount properties on
+.I dfd
+itself.
+.TP
+.B AT_RECURSIVE
+Change the mount properties of the entire mount tree.
+.TP
+.B AT_SYMLINK_NOFOLLOW
+Don't follow trailing symlinks.
+.TP
+.B AT_NO_AUTOMOUNT
+Don't trigger automounts.
+.PP
+The
+.I attr
+argument of
+.BR mount_setattr (2)
+is a structure of the following form:
+.PP
+.in +4n
+.EX
+struct mount_attr {
+    u64 attr_set;    /* Mount properties to set. */
+    u64 attr_clr;    /* Mount properties to clear. */
+    u64 propagation; /* Mount propagation type. */
+    u64 userns_fd;   /* User namespace file descriptor. */
+};
+.EE
+.in
+.PP
+The
+.I attr_set
+and
+.I attr_clr
+members are used to specify the mount properties that are supposed to be set or
+cleared for a given mount or mount tree.
+Flags set in
+.I attr_set
+enable a property on a mount or mount tree and flags set in
+.I attr_clr
+remove a property from a mount or mount tree.
+.PP
+When changing mount properties the kernel will first clear the flags specified
+in the
+.I attr_clr
+field and then set the flags specified in the
+.I attr_set
+field:
+.PP
+.in +4n
+.EX
+struct mount_attr attr = {
+    .attr_clr = MOUNT_ATTR_NOEXEC | MOUNT_ATTR_NODEV,
+    .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
+};
+unsigned int current_mnt_flags = mnt->mnt_flags;
+
+/*
+ * Clear all flags set in .attr_clr, i.e
+ * clear MOUNT_ATTR_NOEXEC and MOUNT_ATTR_NODEV.
+ */
+current_mnt_flags &= ~attr->attr_clr;
+
+/*
+ * Now set all flags set in .attr_set, i.e.
+ * set MOUNT_ATTR_RDONLY and MOUNT_ATTR_NOSUID.
+ */
+current_mnt_flags |= attr->attr_set;
+
+mnt->mnt_flags = current_mnt_flags;
+.EE
+.in
+.PP
+The effect of this change will be a mount or mount tree that is read-only,
+blocks the execution of setuid binaries but does allow to execute programs and
+access to devices nodes.
+Multiple changes with the same set of flags requested
+in
+.I attr_clr
+and
+.I attr_set
+are guaranteed to be idempotent after the changes have been applied.
+.PP
+The following mount attributes can be specified in the
+.I attr_set
+or
+.I attr_clr
+fields:
+.TP
+.B MOUNT_ATTR_RDONLY
+If set in
+.I attr_set
+makes the mount read only and if set in
+.I attr_clr
+removes the read only setting if set on the mount.
+.TP
+.B MOUNT_ATTR_NOSUID
+If set in
+.I attr_set
+makes the mount not honor setuid and setgid binaries, and file capabilities
+when executing programs.
+If set in
+.I attr_clr
+clears the setuid, setgid, and file capability restriction if set on this
+mount.
+.TP
+.B MOUNT_ATTR_NODEV
+If set in
+.I attr_set
+prevents access to devices on this mount and if set in
+.I attr_clr
+removes the device access restriction if set on this mount.
+.TP
+.B MOUNT_ATTR_NOEXEC
+If set in
+.I attr_set
+prevents executing programs on this mount and if set in
+.I attr_clr
+removes the restriction to execute programs on this mount.
+.TP
+.B MOUNT_ATTR_NODIRATIME
+If set in
+.I attr_set
+prevents updating access time for directories on this mount and if set in
+.I attr_clr
+removes access time restriction for directories.
+Note that
+.BR MOUNT_ATTR_NODIRATIME
+can be combined with other access time settings and is implied
+by the noatime setting.
+All other access time settings are mutually exclusive.
+.TP
+.B MOUNT_ATTR__ATIME - Changing access time settings
+In the new mount api the access time values are an enum starting from 0.
+Even though they are an enum in contrast to the other mount flags such as
+.BR MOUNT_ATTR_NOEXEC
+they are nonetheless passed in
+.I attr_set
+and
+.I attr_clr
+for consistency with
+.BR fsmount (2)
+which introduced this behavior.
+.IP
+Note, since access times are an enum, not a bitmap,
+users wanting to transition to a different access time setting cannot simply
+specify the access time in
+.I attr_set
+but must also set
+.BR MOUNT_ATTR__ATIME
+in the
+.I attr_clr
+field.
+The kernel will verify that
+.BR MOUNT_ATTR__ATIME
+isn't partially set in
+.I attr_clr
+and that
+.I attr_set
+doesn't have any access time bits set if
+.BR MOUNT_ATTR__ATIME
+isn't set in
+.I attr_clr.
+.RS
+.TP
+.B MOUNT_ATTR_RELATIME
+When a file is accessed via this mount, update the file's last access time
+(atime) only if the current value of atime is less than or equal to the file's
+last modification time (mtime) or last status change time (ctime).
+.IP
+To enable this access time setting on a mount or mount tree
+.BR MOUNT_ATTR_RELATIME
+must be set in
+.I attr_set
+and
+.BR MOUNT_ATTR__ATIME
+must be set in the
+.I attr_clr
+field.
+.TP
+.BR MOUNT_ATTR_NOATIME
+Do not update access times for (all types of) files on this mount.
+.IP
+To enable this access time setting on a mount or mount tree
+.BR MOUNT_ATTR_NOATIME
+must be set in
+.I attr_set
+and
+.BR MOUNT_ATTR__ATIME
+must be set in the
+.I attr_clr
+field.
+.TP
+.BR MOUNT_ATTR_STRICTATIME
+Always update the last access time (atime) when files are accessed on this
+mount.
+.IP
+To enable this access time setting on a mount or mount tree
+.BR MOUNT_ATTR_STRICTATIME
+must be set in
+.I attr_set
+and
+.BR MOUNT_ATTR__ATIME
+must be set in the
+.I attr_clr
+field.
+.RE
+.TP
+.BR MOUNT_ATTR_IDMAP
+If set in
+.I attr_set
+creates an idmapped mount.
+The idmapping is taken from the user namespace specified in
+.I userns_fd
+and attached to the mount.
+It is not supported to change the idmapping of a mount after it has been
+idmapped.
+Therefore, it is invalid to specify
+.BR MOUNT_ATTR_IDMAP
+in
+.I attr_clr.
+More details can be found in subsequent paragraphs.
+.IP
+Creating an idmapped mount allows to change the ownership of all files located
+under a given mount.
+Other mounts that expose the same files will not be affected,
+i.e. the ownership will not be changed.
+Consequently, a caller accessing files through an idmapped mount will see them
+owned by the uid and gid according to the idmapping attached to the mount.
+.IP
+The idmapping is also applied to the following
+.BR xattr (7)
+namespaces:
+.RS
+.RS
+.IP \(bu 2
+The
+.I security.
+namespace when interacting with filesystem capabilities through the
+.I security.capability
+key whenever filesystem
+.BR capabilities (7)
+are stored or returned in the
+.I VFS_CAP_REVISION_3
+format which stores a rootid alongside the capabilities.
+.IP \(bu 2
+The
+.I system.posix_acl_access
+and
+.I system.posix_acl_default
+keys whenever uids or gids are stored in
+.BR ACL_USER
+and
+.BR ACL_GROUP
+entries.
+.RE
+.RE
+.IP
+The following conditions must be met in order to create an idmapped mount:
+.RS
+.RS
+.IP \(bu 2
+The caller must have
+.I CAP_SYS_ADMIN
+in the initial user namespace.
+.IP \(bu 2
+The filesystem must be mounted in the initial user namespace.
+.IP \(bu
+The underlying filesystem must support idmapped mounts.
+Currently
+.BR xfs (5),
+.BR ext4 (5)
+and
+.BR fat
+filesystems support idmapped mounts with more filesystems being actively worked
+on.
+.IP \(bu
+The mount must not already be idmapped.
+This also implies that the idmapping of a mount cannot be altered.
+.IP \(bu
+The mount must be a detached/anonymous mount,
+i.e. it must have been created by calling
+.BR open_tree (2)
+with the
+.I OPEN_TREE_CLONE
+flag and it must not already have been visible in the filesystem.
+.RE
+.IP
+.RE
+.IP
+In the common case the user namespace passed in
+.I userns_fd
+together with
+.BR MOUNT_ATTR_IDMAP
+in
+.I attr_set
+to create an idmapped mount will be the user namespace of a container.
+In other scenarios it will be a dedicated user namespace associated with a
+given user's login session as is the case for portable home directories in
+.BR systemd-homed.service (8)).
+Details on how to create user namespaces and how to setup idmappings can be
+gathered from
+.BR user_namespaces (7).
+.IP
+In essence, an idmapping associated with a user namespace is a 1-to-1 mapping
+between source and target ids for a given range.
+Specifically, an idmapping always has the abstract form
+.I [type of id] [source id] [target id] [range].
+For example, uid 1000 1001 1 would mean that uid 1000 is mapped to uid 1001,
+gid 1000 1001 2 would mean that gid 1000 will be mapped to gid 1001 and gid
+1001 to gid 1002.
+If we were to attach the idmapping of uid 1000 1001 1 to a mount it would cause
+all files owned by uid 1000 to be owned by uid 1001.
+It is possible to specify up to 340 of such idmappings providing for a great
+deal of flexibility.
+If any source ids are not mapped to a target id all files owned by that
+unmapped source id will appear as being owned by the overflow uid or overflow
+gid respectively (see
+.BR user_namespaces (7)
+and
+.BR proc (5)).
+.IP
+Idmapped mounts can be useful in the following and a variety of other
+scenarios:
+.RS
+.RS
+.IP \(bu 2
+Idmapped mounts make it possible to easily share files between multiple users
+or multiple machines especially in complex scenarios.
+For example, idmapped mounts are used to implement portable home directories in
+.BR systemd-homed.service (8)
+where they allow users to move their home directory to an external storage
+device and use it on multiple computers where they are assigned different uids
+and gids.
+This effectively makes it possible to assign random uids and gids at login
+time.
+.IP \(bu
+It is possible to share files from the host with unprivileged containers
+without having to change ownership permanently through
+.BR chown (2).
+.IP \(bu
+It is possible to idmap a container's root filesystem without having to mangle
+every file.
+.IP \(bu
+It is possible to share files between containers with non-overlapping
+idmappings.
+.IP \(bu
+Filesystem that lack a proper concept of ownership such as fat can use idmapped
+mounts to implement discretionary access (DAC) permission checking.
+.IP \(bu
+Idmapped mounts allow users to efficiently change ownership on a per-mount
+basis without having to (recursively)
+.BR chown (2)
+all files. In contrast to
+.BR chown (2)
+changing ownership of large sets of files is instantenous with idmapped mounts.
+This is especially useful when ownership of an entire root filesystem of a
+virtual machine or container is to be changed.
+With idmapped mounts a single
+.BR mount_setattr (2)
+system call will be sufficient to change the ownership of all files.
+.IP \(bu
+Idmapped mounts always take the current ownership into account as
+idmappings specify what a given uid or gid is supposed to be mapped to.
+This contrasts with the
+.BR chown (2)
+system call which cannot by itself take the current ownership of the files it
+changes into account.
+It simply changes the ownership to the specified uid and gid.
+.IP \(bu
+Idmapped mounts allow to change ownership locally,
+restricting it to specific mounts,
+and temporarily as the ownership changes only apply as long
+as the mount exists.
+In contrast, changing ownership via the
+.BR chown (2)
+system call changes the ownership globally and permanently.
+.RE
+.RE
+.IP
+.PP
+The
+.I propagation
+field is used to specify the propagation type of the mount or mount tree.
+Mount propagation options are mutually exclusive,
+i.e. the propagation values behave like an enum.
+The supported mount propagation settings are:
+.TP
+.B MS_PRIVATE
+Turn all mounts into private mounts.
+Mount and unmount events do not propagate into or out of this mount point.
+.TP
+.B MS_SHARED
+Turn all mounts into shared mounts.
+Mount points share events with members of a peer group.
+Mount and unmount events immediately under this mount point
+will propagate to the other mount points that are members of the peer group.
+Propagation here means that the same mount or unmount will automatically occur
+under all of the other mount points in the peer group.
+Conversely, mount and unmount events that take place under peer mount points
+will propagate to this mount point.
+.TP
+.B MS_SLAVE
+Turn all mounts into dependent mounts.
+Mount and unmount events propagate into this mount point from a shared peer
+group.
+Mount and unmount events under this mount point do not propagate to any peer.
+.TP
+.B MS_UNBINDABLE
+This is like a private mount, and in addition this mount can't be bind mounted.
+Attempts to bind mount this mount will fail.
+When a recursive bind mount is performed on a directory subtree,
+any bind mounts within the subtree are automatically pruned
+(i.e., not replicated) when replicating that subtree to produce the target
+subtree.
+.PP
+.SH RETURN VALUE
+On success,
+.BR mount_setattr (2)
+returns zero.
+On error, \-1 is returned and
+.I errno
+is set to indicate the cause of the error.
+.SH ERRORS
+.TP
+.B EBADF
+.I dfd
+is not a valid file descriptor.
+.TP
+.B EBADF
+An invalid file descriptor value was specified in
+.I userns_fd.
+.TP
+.B EBUSY
+The caller tried to change the mount to
+.BR MOUNT_ATTR_RDONLY
+but the mount had writers.
+.TP
+.B EINVAL
+The path specified via the
+.I dfd
+and
+.I path
+arguments to
+.BR mount_setattr (2)
+isn't a mountpoint.
+.TP
+.B EINVAL
+An unsupported value was set in
+.I flags.
+.TP
+.B EINVAL
+An unsupported value was specified in the
+.I attr_set
+field of
+.IR mount_attr.
+.TP
+.B EINVAL
+An unsupported value was specified in the
+.I attr_clr
+field of
+.IR mount_attr.
+.TP
+.B EINVAL
+An unsupported value was specified in the
+.I propagation
+field of
+.IR mount_attr.
+.TP
+.B EINVAL
+More than one of
+.BR MS_SHARED,
+.BR MS_SLAVE,
+.BR MS_PRIVATE,
+or
+.BR MS_UNBINDABLE
+was set in
+.I propagation
+field of
+.IR mount_attr.
+.TP
+.B EINVAL
+An access time setting was specified in the
+.I attr_set
+field without
+.BR MOUNT_ATTR__ATIME
+being set in the
+.I attr_clr
+field.
+.TP
+.B EINVAL
+.BR MOUNT_ATTR_IDMAP
+was specified in
+.I attr_clr.
+.TP
+.B EINVAL
+A file descriptor value was specified in
+.I userns_fd
+which exceeds
+.BR INT_MAX.
+.TP
+.B EINVAL
+A valid file descriptor value was specified in
+.I userns_fd
+but the file descriptor wasn't a namespace file descriptor or did not refer to
+a user namespace.
+.TP
+.B EINVAL
+The underlying filesystem does not support idmapped mounts.
+.TP
+.B EINVAL
+The mount to idmap is not a detached/anonymous mount, i.e. the mount is already
+visible in the filesystem.
+.TP
+.B EINVAL
+A partial access time setting was specified in
+.I attr_clr
+instead of
+.BR MOUNT_ATTR__ATIME
+being set.
+.TP
+.B EINVAL
+The mount is located outside the caller's mount namespace.
+.TP
+.B EINVAL
+The underlying filesystem is mounted in a user namespace.
+.TP
+.B ENOENT
+A pathname was empty or had a nonexistent component.
+.TP
+.B ENOMEM
+When changing mount propagation to
+.BR MS_SHARED
+a new peer group id needs to be allocated for all mounts without a peer group
+id set.
+Allocation of this peer group id has failed.
+.TP
+.B ENOSPC
+When changing mount propagation to
+.BR MS_SHARED
+a new peer group id needs to be allocated for all mounts without a peer group
+id set.
+Allocation of this peer group id can fail.
+Note that technically further error codes are possible that are specific to the
+id allocation implementation used.
+.TP
+.B EPERM
+One of the mounts had at least one of
+.BR MOUNT_ATTR_RDONLY,
+.BR MOUNT_ATTR_NODEV,
+.BR MOUNT_ATTR_NOSUID,
+.BR MOUNT_ATTR_NOEXEC,
+.BR MOUNT_ATTR_NOATIME,
+or
+.BR MOUNT_ATTR_NODIRATIME
+set and the flag is locked.
+Mount attributes become locked on a mount if:
+.RS
+.IP \(bu 2
+a new mount or mount tree is created causing mount propagation across user
+namespaces.
+The kernel will lock the aforementioned flags to protect these sensitive
+properties from being altered.
+.IP \(bu
+a new mount and user namespace pair is created.
+This happens for example when specifying
+.BR CLONE_NEWUSER | CLONE_NEWNS
+in
+.BR unshare (2),
+.BR clone (2),
+or
+.BR clone3 (2).
+The aformentioned flags become locked to protect user namespaces from altering
+sensitive mount properties.
+.RE
+.TP
+.B EPERM
+A valid file descriptor value was specified in
+.I userns_fd
+but the file descriptor refers to the initial user namespace.
+.TP
+.B EPERM
+An already idmapped mount was supposed to be idmapped.
+.TP
+.B EPERM
+The caller does not have
+.I CAP_SYS_ADMIN
+in the initial user namespace.
+.SH VERSIONS
+.BR mount_setattr (2)
+first appeared in Linux 5.12.
+.\" commit 7d6beb71da3cc033649d641e1e608713b8220290
+.\" commit 2a1867219c7b27f928e2545782b86daaf9ad50bd
+.\" commit 9caccd41541a6f7d6279928d9f971f6642c361af
+.SH CONFORMING TO
+.BR mount_setattr (2)
+is Linux specific.
+.SH NOTES
+Currently, there is no glibc wrapper for this system call;
+call it using
+.BR syscall (2).
+.\"
+.SS Extensibility
+In order to allow for future extensibility,
+.BR mount_setattr (2)
+along with other system calls such as
+.BR openat2 (2)
+and
+.BR clone3 (2)
+requires the user-space application to specify the size of the
+.I mount_attr
+structure that it is passing.
+By providing this information, it is possible for
+.BR mount_setattr (2)
+to provide both forwards- and backwards-compatibility, with
+.I size
+acting as an implicit version number.
+(Because new extension fields will always
+be appended, the structure size will always increase.)
+This extensibility design is very similar to other system calls such as
+.BR perf_setattr (2),
+.BR perf_event_open (2),
+.BR clone3 (2)
+and
+.BR openat2 (2) .
+.PP
+Let
+.I usize
+be the size of the structure as specified by the user-space application,
+and let
+.I ksize
+be the size of the structure which the kernel supports,
+then there are three cases to consider:
+.IP \(bu 2
+If
+.IR ksize
+equals
+.IR usize ,
+then there is no version mismatch and
+.I attr
+can be used verbatim.
+.IP \(bu
+If
+.IR ksize
+is larger than
+.IR usize ,
+then there are some extension fields that the kernel supports which the
+user-space application is unaware of.
+Because a zero value in any added extension field signifies a no-op,
+the kernel treats all of the extension fields not provided by the user-space
+application as having zero values.
+This provides backwards-compatibility.
+.IP \(bu
+If
+.IR ksize
+is smaller than
+.IR usize ,
+then there are some extension fields which the user-space application is aware
+of but which the kernel does not support.
+Because any extension field must have its zero values signify a no-op,
+the kernel can safely ignore the unsupported extension fields if they are
+all zero.
+If any unsupported extension fields are non-zero, then \-1 is returned and
+.I errno
+is set to
+.BR E2BIG .
+This provides forwards-compatibility.
+.PP
+Because the definition of
+.I struct mount_attr
+may change in the future
+(with new fields being added when system headers are updated),
+user-space applications should zero-fill
+.I struct mount_attr
+to ensure that recompiling the program with new headers will not result in
+spurious errors at runtime.
+The simplest way is to use a designated initializer:
+.PP
+.in +4n
+.EX
+struct mount_attr attr = {
+    .attr_set = MOUNT_ATTR_RDONLY,
+    .attr_clr = MOUNT_ATTR_NODEV
+};
+.EE
+.in
+.PP
+or explicitly using
+.BR memset (3)
+or similar functions:
+.PP
+.in +4n
+.EX
+struct mount_attr attr;
+memset(&attr, 0, sizeof(attr));
+attr.attr_set = MOUNT_ATTR_RDONLY;
+attr.attr_clr = MOUNT_ATTR_NODEV;
+.EE
+.in
+.PP
+A user-space application that wishes to determine which extensions the running
+kernel supports can do so by conducting a binary search on
+.IR size
+with a structure which has every byte nonzero
+(to find the largest value which doesn't produce an error of
+.BR E2BIG ).
+.SH EXAMPLES
+.EX
+/*
+ * This program allows the caller to create a new detached mount and set
+ * various properties on it.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <linux/mount.h>
+#include <linux/types.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+/* mount_setattr() */
+#ifndef MOUNT_ATTR_RDONLY
+#define MOUNT_ATTR_RDONLY 0x00000001
+#endif
+
+#ifndef MOUNT_ATTR_NOSUID
+#define MOUNT_ATTR_NOSUID 0x00000002
+#endif
+
+#ifndef MOUNT_ATTR_NOEXEC
+#define MOUNT_ATTR_NOEXEC 0x00000008
+#endif
+
+#ifndef MOUNT_ATTR__ATIME
+#define MOUNT_ATTR__ATIME 0x00000070
+#endif
+
+#ifndef MOUNT_ATTR_NOATIME
+#define MOUNT_ATTR_NOATIME 0x00000010
+#endif
+
+#ifndef MOUNT_ATTR_IDMAP
+#define MOUNT_ATTR_IDMAP 0x00100000
+#endif
+
+#ifndef AT_RECURSIVE
+#define AT_RECURSIVE 0x8000
+#endif
+
+#ifndef __NR_mount_setattr
+    #if defined __alpha__
+        #define __NR_mount_setattr 552
+    #elif defined _MIPS_SIM
+        #if _MIPS_SIM == _MIPS_SIM_ABI32    /* o32 */
+            #define __NR_mount_setattr (442 + 4000)
+        #endif
+        #if _MIPS_SIM == _MIPS_SIM_NABI32   /* n32 */
+            #define __NR_mount_setattr (442 + 6000)
+        #endif
+        #if _MIPS_SIM == _MIPS_SIM_ABI64    /* n64 */
+            #define __NR_mount_setattr (442 + 5000)
+        #endif
+    #elif defined __ia64__
+        #define __NR_mount_setattr (442 + 1024)
+    #else
+        #define __NR_mount_setattr 442
+    #endif
+struct mount_attr {
+    __u64 attr_set;
+    __u64 attr_clr;
+    __u64 propagation;
+    __u64 userns_fd;
+};
+#endif
+
+/* open_tree() */
+#ifndef OPEN_TREE_CLONE
+#define OPEN_TREE_CLONE 1
+#endif
+
+#ifndef OPEN_TREE_CLOEXEC
+#define OPEN_TREE_CLOEXEC O_CLOEXEC
+#endif
+
+#ifndef __NR_open_tree
+    #if defined __alpha__
+        #define __NR_open_tree 538
+    #elif defined _MIPS_SIM
+        #if _MIPS_SIM == _MIPS_SIM_ABI32    /* o32 */
+            #define __NR_open_tree 4428
+        #endif
+        #if _MIPS_SIM == _MIPS_SIM_NABI32   /* n32 */
+            #define __NR_open_tree 6428
+        #endif
+        #if _MIPS_SIM == _MIPS_SIM_ABI64    /* n64 */
+            #define __NR_open_tree 5428
+        #endif
+    #elif defined __ia64__
+        #define __NR_open_tree (428 + 1024)
+    #else
+        #define __NR_open_tree 428
+    #endif
+#endif
+
+/* move_mount() */
+#ifndef MOVE_MOUNT_F_EMPTY_PATH
+#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
+#endif
+
+#ifndef __NR_move_mount
+    #if defined __alpha__
+        #define __NR_move_mount 539
+    #elif defined _MIPS_SIM
+        #if _MIPS_SIM == _MIPS_SIM_ABI32    /* o32 */
+            #define __NR_move_mount 4429
+        #endif
+        #if _MIPS_SIM == _MIPS_SIM_NABI32   /* n32 */
+            #define __NR_move_mount 6429
+        #endif
+        #if _MIPS_SIM == _MIPS_SIM_ABI64    /* n64 */
+            #define __NR_move_mount 5429
+        #endif
+    #elif defined __ia64__
+        #define __NR_move_mount (428 + 1024)
+    #else
+        #define __NR_move_mount 429
+    #endif
+#endif
+
+static inline int mount_setattr(int dfd,
+                                const char *path,
+                                unsigned int flags,
+                                struct mount_attr *attr,
+                                size_t size)
+{
+    return syscall(__NR_mount_setattr, dfd, path,
+                   flags, attr, size);
+}
+
+static inline int open_tree(int dfd, const char *filename,
+                            unsigned int flags)
+{
+    return syscall(__NR_open_tree, dfd, filename, flags);
+}
+
+static inline int move_mount(int from_dfd,
+                             const char *from_pathname,
+                             int to_dfd,
+                             const char *to_pathname,
+                             unsigned int flags)
+{
+    return syscall(__NR_move_mount, from_dfd,
+                   from_pathname, to_dfd, to_pathname, flags);
+}
+
+static const struct option longopts[] = {
+    {"map-mount",       required_argument,  0,  'a'},
+    {"recursive",       no_argument,        0,  'b'},
+    {"read-only",       no_argument,        0,  'c'},
+    {"block-setid",     no_argument,        0,  'd'},
+    {"block-devices",   no_argument,        0,  'e'},
+    {"block-exec",      no_argument,        0,  'f'},
+    {"no-access-time",  no_argument,        0,  'g'},
+    { NULL,             0,                  0,   0 },
+};
+
+#define exit_log(format, ...)                   \\
+    ({                                          \\
+        fprintf(stderr, format, ##__VA_ARGS__); \\
+        exit(EXIT_FAILURE);                     \\
+    })
+
+int main(int argc, char *argv[])
+{
+    int fd_userns = -EBADF, index = 0;
+    bool recursive = false;
+    struct mount_attr *attr = &(struct mount_attr){};
+    const char *source, *target;
+    int fd_tree, new_argc, ret;
+    char *const *new_argv;
+
+    while ((ret = getopt_long_only(argc, argv, "",
+                                  longopts, &index)) != -1) {
+        switch (ret) {
+        case 'a':
+            fd_userns = open(optarg, O_RDONLY | O_CLOEXEC);
+            if (fd_userns < 0)
+                exit_log("%m - Failed top open %s\n", optarg);
+            break;
+        case 'b':
+            recursive = true;
+            break;
+        case 'c':
+            attr->attr_set |= MOUNT_ATTR_RDONLY;
+            break;
+        case 'd':
+            attr->attr_set |= MOUNT_ATTR_NOSUID;
+            break;
+        case 'e':
+            attr->attr_set |= MOUNT_ATTR_NODEV;
+            break;
+        case 'f':
+            attr->attr_set |= MOUNT_ATTR_NOEXEC;
+            break;
+        case 'g':
+            attr->attr_set |= MOUNT_ATTR_NOATIME;
+            attr->attr_clr |= MOUNT_ATTR__ATIME;
+            break;
+        default:
+            exit_log("Invalid argument specified");
+        }
+    }
+
+    new_argv = &argv[optind];
+    new_argc = argc - optind;
+    if (new_argc < 2)
+        exit_log("Missing source or target mountpoint\n");
+    source = new_argv[0];
+    target = new_argv[1];
+
+    fd_tree = open_tree(-EBADF, source,
+                        OPEN_TREE_CLONE |
+                        OPEN_TREE_CLOEXEC |
+                        AT_EMPTY_PATH |
+                        (recursive ? AT_RECURSIVE : 0));
+    if (fd_tree < 0)
+        exit_log("%m - Failed to open %s\n", source);
+
+    if (fd_userns >= 0) {
+        attr->attr_set  |= MOUNT_ATTR_IDMAP;
+        attr->userns_fd = fd_userns;
+    }
+    ret = mount_setattr(fd_tree, "",
+                        AT_EMPTY_PATH |
+                        (recursive ? AT_RECURSIVE : 0),
+                        attr, sizeof(struct mount_attr));
+    if (ret < 0)
+        exit_log("%m - Failed to change mount attributes\n");
+    close(fd_userns);
+
+    ret = move_mount(fd_tree, "", -EBADF, target,
+                     MOVE_MOUNT_F_EMPTY_PATH);
+    if (ret < 0)
+        exit_log("%m - Failed to attach mount to %s\n", target);
+    close(fd_tree);
+
+    exit(EXIT_SUCCESS);
+}
+.EE
+.fi
+.SH SEE ALSO
+.BR capabilities (7),
+.BR clone (2),
+.BR clone3 (2),
+.BR ext4 (5),
+.BR mount (2),
+.BR mount_namespaces (7),
+.BR newuidmap (1),
+.BR newgidmap (1),
+.BR proc (5),
+.BR unshare (2),
+.BR user_namespaces (7),
+.BR xattr (7),
+.BR xfs (5)

base-commit: fbe71b1b79e72be3b9afc44b5d479e7fd84b598a
-- 
2.30.2

