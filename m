Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7703DD419
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 12:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhHBKmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 06:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233346AbhHBKmn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:42:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32F5B60FA0;
        Mon,  2 Aug 2021 10:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627900953;
        bh=csI23+QHOpCN3MS5PO0G/pkmARqF4ecxl1W+6JGo+kk=;
        h=From:To:Cc:Subject:Date:From;
        b=ViLJfnZ12BZJup/Mp6EoB4NkutXTTncbWUACcLoItmXXx7dz7HaMizFBKpkU7rL5V
         e8P3IXBPjLI28dxo4JOAUIeq+gEKHABje9IGt6cGFpOC+Gfu5qaDKC6HOvyFCTxOiV
         h3/jZLaVkwKp7reli+X6L11VVCtUUY2nEZQIx8Zv9g+WzZS1RyQJbE6vseqWE+KLIs
         CsfFP/3bUO5qAG0QNpznQNziJ6rkivwhTUA256s7j8Woj1PcKHlcqOXqMJvaGmF869
         P0VRrmy2rw+ULkEcLvbqM6Dx+bbDZaqRq+zcfSnXOJIVU7L2unLIIyJnPC47Yr6BXq
         hfC2tlsZEDdUA==
From:   Christian Brauner <brauner@kernel.org>
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4] mount_setattr.2: New manual page documenting the mount_setattr() system call
Date:   Mon,  2 Aug 2021 12:42:15 +0200
Message-Id: <20210802104215.525543-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=31042; h=from:subject; bh=ikzIHtSmMgGZbcI4HQ5Pf62hLaXZH1kfy+A6SEF2PK8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSyn36wV0mglGlRL6NXkF//K93CPsEqx0K1LMeXC7yUFpan Vi7qKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMjPWwz/NANv8k7Me2bL4y3tdqfzh+ ctgd+n3l1jFjm7/5XRYSbWNwx/eD8/PZj0882B3Bspj67FtovrPpv5WkLcdL/vk7DvLUsMuQA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v3 */
- "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>:
   - Adjust for comments provided by Alex.

/* v4 */
- "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>:
   - Adjust for comments provided by Alex.

- Christian Brauner <christian.brauner@ubuntu.com>:
  - Add missing MOUNT_ATTR_NOSYMFOLLOW flag.
  - Reword AT_FDCWD handling.
  - Reword reference to "Extensibility" section.
  - Reformat and reword wording in example to explain how attr_set and
    attr_clr are applied.
  - s/read only/read-only/g to match mount(2).
  - Reword security.capability reference when explaining idmappings.
  - s/uid/user ID/g, s/gid/group ID/g to comply with the style used in
    other manpages.
  - Remove pointless uses of "given".
  - Reformulate explanation of idmappings.
  - Reformulate explanation what idmappings apply to.
  - All negative numbers such as -EBADF have been changed to \-EBADF for
    consistency with other man pages.
  - Fix indendation of list in NOTES on system call extensibility.
---
 man2/mount_setattr.2 | 1002 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1002 insertions(+)
 create mode 100644 man2/mount_setattr.2

diff --git a/man2/mount_setattr.2 b/man2/mount_setattr.2
new file mode 100644
index 000000000..16881d90d
--- /dev/null
+++ b/man2/mount_setattr.2
@@ -0,0 +1,1002 @@
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
+
+.PP
+.BR "#include <linux/fcntl.h>" " /* Definition of " AT_* " constants */"
+.BR "#include <linux/mount.h>" " /* Definition of struct mount_attr and MOUNT_ATTR_* constants */"
+.BR "#include <sys/syscall.h>" " /* Definition of " SYS_* " constants */"
+.B #include <unistd.h>
+.PP
+.BI "int syscall(SYS_mount_setattr, int " dfd ", const char *" path \
+", unsigned int " flags \
+", struct mount_attr *" attr ", size_t " size );
+.fi
+.PP
+.IR Note :
+glibc provides no wrapper for
+.BR mount_setattr (),
+necessitating the use of
+.BR syscall (2).
+.SH DESCRIPTION
+The
+.BR mount_setattr (2)
+system call changes the mount properties of a mount or entire mount tree.
+If
+.I path
+is a relative pathname,
+then it is interpreted relative to the directory referred to by the file
+descriptor
+.IR dfd .
+If
+.I dfd
+is the special value
+.B AT_FDCWD
+then
+.I path
+is taken to be relative to the current working directory of the calling process.
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
+.IR ( "struct mount_attr" )
+to allow for future extensions.
+Any non-flag extensions to
+.BR mount_setattr (2)
+will be implemented as new fields appended to the above structure,
+with a zero value in a new field resulting in the kernel behaving
+as though that extension field was not present.
+Therefore,
+the caller
+.I must
+zero-fill this structure on initialization.
+Please see the "Extensibility" section under
+.B NOTES
+for more details.
+.PP
+The
+.I size
+argument should usually be specified as
+.IR "sizeof(struct mount_attr)" .
+However,
+if the caller does not intend to make use of features that got
+introduced after the initial version of
+.I struct mount_attr
+they are free to pass the size of the initial struct together with the larger
+struct.
+This allows the kernel to not copy later parts of the struct that aren't used
+anyway.
+With each extension that changes the size of
+.I struct mount_attr
+the kernel will expose a define of the form
+.BR MOUNT_ATTR_SIZE_VER<number> .
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
+    __u64 attr_set;    /* Mount properties to set. */
+    __u64 attr_clr;    /* Mount properties to clear. */
+    __u64 propagation; /* Mount propagation type. */
+    __u64 userns_fd;   /* User namespace file descriptor. */
+};
+.EE
+.in
+.PP
+The
+.I attr_set
+and
+.I attr_clr
+members are used to specify the mount properties that are supposed to be set or
+cleared for a mount or mount tree.
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
+ * Clear all flags set in .attr_clr,
+ * clearing MOUNT_ATTR_NOEXEC and MOUNT_ATTR_NODEV.
+ */
+current_mnt_flags &= ~attr->attr_clr;
+
+/*
+ * Now set all flags set in .attr_set,
+ * applying MOUNT_ATTR_RDONLY and MOUNT_ATTR_NOSUID.
+ */
+current_mnt_flags |= attr->attr_set;
+
+mnt->mnt_flags = current_mnt_flags;
+.EE
+.in
+.PP
+The effect of this change will be a mount or mount tree that is read-only,
+blocks the execution of set-user-ID and set-group-ID binaries but does allow to
+execute programs and access to devices nodes.
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
+makes the mount read-only and if set in
+.I attr_clr
+removes the read-only setting if set on the mount.
+.TP
+.B MOUNT_ATTR_NOSUID
+If set in
+.I attr_set
+makes the mount not honor set-user-ID and set-group-ID binaries,
+and file capabilities when executing programs.
+If set in
+.I attr_clr
+clears the set-user-ID, set-group-ID,
+and file capability restriction if set on this mount.
+.TP
+.B MOUNT_ATTR_NODEV
+If set in
+.I attr_set
+prevents access to devices on this mount and if set in
+.I attr_clr
+removes the device access restriction if set on this mount.
+.TP
+.BR MOUNT_ATTR_NOEXEC
+If set in
+.I attr_set
+prevents executing programs on this mount and if set in
+.I attr_clr
+removes the restriction to execute programs on this mount.
+.TP
+.BR MOUNT_ATTR_NOSYMFOLLOW
+If set in
+.I attr_set
+prevents following symlinks on this mount and if set in
+.I attr_clr
+removes the restriction to not follow symlinks on this mount.
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
+.BR MOUNT_ATTR__ATIME " - Changing access time settings
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
+Note,
+since access times are an enum,
+not a bitmap,
+users wanting to transition to a different access time setting cannot simply
+specify the access time in
+.I attr_set
+but must also set
+.B MOUNT_ATTR__ATIME
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
+.IR attr_clr .
+.RS
+.TP
+.B MOUNT_ATTR_RELATIME
+When a file is accessed via this mount,
+update the file's last access time
+(atime)
+only if the current value of atime is less than or equal to the file's
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
+Since it is not supported to change the idmapping of a mount after it has been
+idmapped,
+it is invalid to specify
+.B MOUNT_ATTR_IDMAP
+in
+.IR attr_clr .
+The idmapping is taken from the user namespace specified in
+.I userns_fd
+and attached to the mount.
+More details can be found in subsequent paragraphs.
+.IP
+Creating an idmapped mount allows to change the ownership of all files located
+under a mount.
+Thus, idmapped mounts make it possible to change ownership in a temporary and
+localized way.
+It is a localized change because ownership changes are restricted to a specific
+mount.
+All other users and locations where the filesystem is exposed are unaffected.
+And it is a temporary change because ownership changes are tied to the lifetime
+of the mount.
+.IP
+Whenever callers interact with the filesystem through an idmapped mount the
+idmapping of the mount will be applied to user and group IDs associated with
+filesystem objects.
+This encompasses the user and group IDs associated with inodes and also
+the following
+.BR xattr (7)
+keys:
+.RS
+.RS
+.IP \(bu 2
+.IR security.capability
+whenever filesystem
+.BR capabilities (7)
+are stored or returned in the
+.I VFS_CAP_REVISION_3
+format which stores a rootid alongside the capabilities.
+.IP \(bu 2
+.I system.posix_acl_access
+and
+.I system.posix_acl_default
+whenever user IDs or group IDs are stored in
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
+i.e.,
+it must have been created by calling
+.BR open_tree (2)
+with the
+.I OPEN_TREE_CLONE
+flag and it must not already have been visible in the filesystem.
+.RE
+.RE
+.IP
+Idmappings can be created for user IDs, group IDs, and project IDs.
+An idmapping is essentially a mapping of a range of user or group IDs into
+another or the same range of user or group IDs.
+Idmappings are usually written as three numbers either separated by white space
+or a full stop.
+The first two numbers specify the starting user or group ID in each of the two
+user namespaces.
+The third number specifies the range of the idmapping.
+For example, a mapping for user IDs such as 1000:1001:1 would indicate that
+user ID 1000 in the caller's user namespace is mapped to user ID 1001 in its
+ancestor user namespace.
+Since the map range is 1 only user ID 1000 is mapped.
+It is possible to specify up to 340 idmappings for each idmapping type.
+If any user IDs or group IDs are not mapped all files owned by that unmapped
+user or group ID will appear as being owned by the overflow user ID or overflow
+group ID respectively.
+Further details and instructions for setting up idmappings can be found in the
+.BR user_namespaces (7)
+man page.
+.IP
+In the common case the user namespace passed in
+.I userns_fd
+together with
+.BR MOUNT_ATTR_IDMAP
+in
+.I attr_set
+to create an idmapped mount will be the user namespace of a container.
+In other scenarios it will be a dedicated user namespace associated with a
+user's login session as is the case for portable home directories in
+.BR systemd-homed.service (8) ).
+It is also perfectly fine to create a dedicated user namespace for the sake of
+idmapping a mount.
+.IP
+Idmapped mounts can be useful in the following and a variety of other
+scenarios:
+.RS
+.RS
+.IP \(bu 2
+sharing files between multiple users or multiple machines especially in
+complex scenarios.
+For example,
+idmapped mounts are used to implement portable home directories in
+.BR systemd-homed.service (8)
+where they allow users to move their home directory to an external storage
+device and use it on multiple computers where they are assigned different user IDs
+and group IDs.
+This effectively makes it possible to assign random user IDs and group IDs at login time.
+.IP \(bu
+sharing files from the host with unprivileged containers.
+This allows user to avoid having to change ownership permanently through
+.BR chown (2) .
+.IP \(bu
+idmapping a container's root filesystem.
+Users don't need to change ownership
+permanently through
+.BR chown (2) .
+Especially for large root filesystems using
+.BR chown (2)
+can be prohibitively expensive.
+.IP \(bu
+sharing files between containers with non-overlapping
+idmappings.
+.IP \(bu
+implementing discretionary access (DAC) permission checking for fileystems
+lacking a concept of ownership.
+.IP \(bu
+efficiently change ownership on a per-mount basis.
+In contrast to
+.BR chown (2)
+changing ownership of large sets of files is instantenous with idmapped mounts.
+This is especially useful when ownership of an entire root filesystem of a
+virtual machine or container is to be changed as we've mentioned above.
+With idmapped mounts a single
+.BR mount_setattr (2)
+system call will be sufficient to change the ownership of all files.
+.IP \(bu
+taking the current ownership into account.
+Idmappings specify precisely what a user or group ID is supposed to be
+mapped to.
+This contrasts with the
+.BR chown (2)
+system call which cannot by itself take the current ownership of the files it
+changes into account.
+It simply changes the ownership to the specified user ID and group ID.
+.IP \(bu
+locally and temporarily restricted ownership changes.
+Idmapped mounts allow to change ownership locally,
+restricting it to specific mounts,
+and temporarily as the ownership changes only apply as long as the mount exists.
+In contrast,
+changing ownership via the
+.BR chown (2)
+system call changes the ownership globally and permanently.
+.RE
+.RE
+.PP
+The
+.I propagation
+field is used to specify the propagation type of the mount or mount tree.
+Mount propagation options are mutually exclusive,
+i.e.,
+the propagation values behave like an enum.
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
+Conversely,
+mount and unmount events that take place under peer mount points will propagate
+to this mount point.
+.TP
+.B MS_SLAVE
+Turn all mounts into dependent mounts.
+Mount and unmount events propagate into this mount point from a shared peer
+group.
+Mount and unmount events under this mount point do not propagate to any peer.
+.TP
+.B MS_UNBINDABLE
+This is like a private mount,
+and in addition this mount can't be bind mounted.
+Attempts to bind mount this mount will fail.
+When a recursive bind mount is performed on a directory subtree,
+any bind mounts within the subtree are automatically pruned
+(i.e., not replicated)
+when replicating that subtree to produce the target subtree.
+.PP
+.SH RETURN VALUE
+On success,
+.BR mount_setattr (2)
+returns zero.
+On error,
+\-1 is returned and
+.I errno
+is set to indicate the cause of the error.
+.SH ERRORS
+.TP
+.B EBADF
+.I dfd
+is not a valid file descriptor.
+.TP
+.B EBADF
+.I userns_fd
+is not a valid file descriptor.
+.TP
+.B EBUSY
+The caller tried to change the mount to
+.BR MOUNT_ATTR_RDONLY
+but the mount still has files open for writing.
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
+.IR mount_attr .
+.TP
+.B EINVAL
+An unsupported value was specified in the
+.I attr_clr
+field of
+.IR mount_attr .
+.TP
+.B EINVAL
+An unsupported value was specified in the
+.I propagation
+field of
+.IR mount_attr .
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
+.IR mount_attr .
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
+.IR attr_clr .
+.TP
+.B EINVAL
+A file descriptor value was specified in
+.I userns_fd
+which exceeds
+.BR INT_MAX .
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
+The mount to idmap is not a detached/anonymous mount,
+i.e.,
+the mount is already visible in the filesystem.
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
+.BR MOUNT_ATTR_NOATIME,
+.BR MOUNT_ATTR_NODEV,
+.BR MOUNT_ATTR_NODIRATIME,
+.BR MOUNT_ATTR_NOEXEC,
+.BR MOUNT_ATTR_NOSUID,
+or
+.BR MOUNT_ATTR_RDONLY
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
+.BR clone3 (2) .
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
+.RS
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
+.RE
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
+.BR E2BIG ) .
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
+static inline int mount_setattr(int dfd,
+                                const char *path,
+                                unsigned int flags,
+                                struct mount_attr *attr,
+                                size_t size)
+{
+    return syscall(SYS_mount_setattr, dfd, path,
+                   flags, attr, size);
+}
+
+static inline int open_tree(int dfd, const char *filename,
+                            unsigned int flags)
+{
+    return syscall(SYS_open_tree, dfd, filename, flags);
+}
+
+static inline int move_mount(int from_dfd,
+                             const char *from_pathname,
+                             int to_dfd,
+                             const char *to_pathname,
+                             unsigned int flags)
+{
+    return syscall(SYS_move_mount, from_dfd,
+                   from_pathname, to_dfd, to_pathname, flags);
+}
+
+static const struct option longopts[] = {
+    {"map-mount",       required_argument,  NULL,  'a'},
+    {"recursive",       no_argument,        NULL,  'b'},
+    {"read-only",       no_argument,        NULL,  'c'},
+    {"block-setid",     no_argument,        NULL,  'd'},
+    {"block-devices",   no_argument,        NULL,  'e'},
+    {"block-exec",      no_argument,        NULL,  'f'},
+    {"no-access-time",  no_argument,        NULL,  'g'},
+    { NULL,             0,                  NULL,   0 },
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
+    int fd_userns = \-EBADF, index = 0;
+    bool recursive = false;
+    struct mount_attr *attr = &(struct mount_attr){};
+    const char *source, *target;
+    int fd_tree, new_argc, ret;
+    char *const *new_argv;
+
+    while ((ret = getopt_long_only(argc, argv, "",
+                                  longopts, &index)) != \-1) {
+        switch (ret) {
+        case 'a':
+            fd_userns = open(optarg, O_RDONLY | O_CLOEXEC);
+            if (fd_userns == \-1)
+                exit_log("%m - Failed top open %s\en", optarg);
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
+    new_argc = argc \- optind;
+    if (new_argc < 2)
+        exit_log("Missing source or target mountpoint\en");
+    source = new_argv[0];
+    target = new_argv[1];
+
+    fd_tree = open_tree(\-EBADF, source,
+                        OPEN_TREE_CLONE |
+                        OPEN_TREE_CLOEXEC |
+                        AT_EMPTY_PATH |
+                        (recursive ? AT_RECURSIVE : 0));
+    if (fd_tree == \-1)
+        exit_log("%m - Failed to open %s\en", source);
+
+    if (fd_userns >= 0) {
+        attr->attr_set  |= MOUNT_ATTR_IDMAP;
+        attr->userns_fd = fd_userns;
+    }
+    ret = mount_setattr(fd_tree, "",
+                        AT_EMPTY_PATH |
+                        (recursive ? AT_RECURSIVE : 0),
+                        attr, sizeof(struct mount_attr));
+    if (ret == \-1)
+        exit_log("%m - Failed to change mount attributes\en");
+    close(fd_userns);
+
+    ret = move_mount(fd_tree, "", \-EBADF, target,
+                     MOVE_MOUNT_F_EMPTY_PATH);
+    if (ret == \-1)
+        exit_log("%m - Failed to attach mount to %s\en", target);
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

