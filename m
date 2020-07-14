Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF44A21F6F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgGNQPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 12:15:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40913 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgGNQPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:15:48 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jvNap-0005y1-2d; Tue, 14 Jul 2020 16:15:43 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] mount_setattr.2: New manual page documenting the mount_setattr() system call
Date:   Tue, 14 Jul 2020 18:14:12 +0200
Message-Id: <20200714161415.3886463-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714161415.3886463-1-christian.brauner@ubuntu.com>
References: <20200714161415.3886463-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 man2/mount_setattr.2 | 296 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 296 insertions(+)
 create mode 100644 man2/mount_setattr.2

diff --git a/man2/mount_setattr.2 b/man2/mount_setattr.2
new file mode 100644
index 000000000..aae10525e
--- /dev/null
+++ b/man2/mount_setattr.2
@@ -0,0 +1,296 @@
+.\" Copyright (c) 2020 by Christian Brauner <christian.brauner@ubuntu.com>
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
+.TH MOUNT_SETATTR 2 2020-07-14 "Linux" "Linux Programmer's Manual"
+.SH NAME
+mount_setattr \- change mount options of a mount or mount tree
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
+.BR mount_setattr ()
+system call changes the mount properties of a mount or whole mount tree.
+If
+.I path
+is a relative pathname, then it is interpreted relative to the directory
+referred to by the file descriptor
+.I dirfd
+(or the current working directory of the calling process, if
+.I dirfd
+is the special value
+.BR AT_FDCWD ).
+If
+.BR AT_EMPTY_PATH
+is specified in
+.I flags
+then the mount properties of the mount identified by
+.I dirfd
+are changed.
+.PP
+The
+.I flags
+argument can be used to alter the path resolution behavior. The supported
+values are:
+.TP
+.in +4n
+.B AT_EMPTY_PATH
+.in +4n
+The mount properties of the mount identified by
+.I dfd
+are changed.
+.TP
+.in +4n
+.B AT_RECURSIVE
+.in +4n
+Change the mount properties of the whole mount tree.
+.TP
+.in +4n
+.B AT_SYMLINK_NOFOLLOW
+.in +4n
+Don't follow trailing symlinks.
+.TP
+.in +4n
+.B AT_NO_AUTOMOUNT
+.in +4n
+Don't trigger automounts.
+.PP
+The
+.I attr
+argument of
+.BR mount_setattr ()
+is a structure of the following form:
+.PP
+.in +4n
+.EX
+struct mount_attr {
+    u64 attr_set;    /* Mount properties to set. */
+    u64 attr_clr;    /* Mount properties to clear. */
+    u32 propagation; /* Mount propagation type. */
+    u32 atime;       /* Access time settings. */
+};
+.EE
+.in
+.PP
+The
+.I attr_set
+and
+.I attr_clr
+members are used to specify the mount options that are supposed to be set or
+cleared for a given mount or mount tree. The following mount attributes can be
+specified in the
+.I attr_set
+and
+.I attr_clear
+fields:
+.TP
+.in +4n
+.B MOUNT_ATTR_RDONLY
+.in +4n
+If set in
+.I attr_set
+makes the mount read only and if set in
+.I attr_clr
+removes the read only setting if set on the mount.
+.TP
+.in +4n
+.B MOUNT_ATTR_NOSUID
+.in +4n
+If set in
+.I attr_set
+makes the mount not honor set-user-ID and set-group-ID bits or file capabilities
+when executing programs
+and if set in
+.I attr_clr
+clears the set-user-ID, set-group-ID bits, file capability restriction if set on
+this mount.
+.TP
+.in +4n
+.B MOUNT_ATTR_NODEV
+.in +4n
+If set in
+.I attr_set
+prevents access to devices on this mount
+and if set in
+.I attr_clr
+removes the device access restriction if set on this mount.
+.TP
+.in +4n
+.B MOUNT_ATTR_NOEXEC
+.in +4n
+If set in
+.I attr_set
+prevents executing programs on this mount
+and if set in
+.I attr_clr
+removes the restriction to execute programs on this mount.
+.TP
+.in +4n
+.B MOUNT_ATTR_NODIRATIME
+.in +4n
+If set in
+.I attr_set
+prevents updating access time for directories on this mount
+and if set in
+.I attr_clr
+removes access time restriction for directories. Note that
+.I MOUNT_ATTR_NODIRATIME
+can be combined with other access time settings and is implied
+by the noatime setting. All other access time settins are mutually
+exclusive.
+.PP
+The
+.I propagation
+member is used to specify the propagation type of the mount or mount tree.
+The supported mount propagation settings are:
+.TP
+.in +4n
+.B MAKE_PROPAGATION_PRIVATE
+.in +4n
+Turn all mounts into private mounts. Mount and umount events do not propagate
+into or out of this mount point.
+.TP
+.in +4n
+.B MAKE_PROPAGATION_SHARED
+.in +4n
+Turn all mounts into shared mounts. Mount points share events with members of a
+peer group. Mount and unmount events immediately under this mount point
+will propagate to the other mount points that are members of the peer group.
+Propagation here means that the same mount or unmount will automatically occur
+under all of the other mount points in the peer group. Conversely, mount and
+unmount events that take place under peer mount points will propagate to this
+mount point.
+.TP
+.in +4n
+.B MAKE_PROPAGATION_DEPENDENT
+.in +4n
+Turn all mounts into dependent mounts. Mount and unmount events propagate into
+this mount point from a shared  peer group. Mount and unmount events under this
+mount point do not propagate to any peer.
+.TP
+.in +4n
+.B MAKE_PROPAGATION_UNBINDABLE
+.in +4n
+This is like a private mount, and in addition this mount can't be bind mounted.
+Attempts to bind mount this mount will fail.
+When a recursive bind mount is performed on a directory subtree, any bind
+mounts within the subtree are automatically pruned (i.e., not replicated) when
+replicating that subtree to produce the target subtree.
+.PP
+The
+.I atime
+member is used to specify the access time behavior on a mount or mount tree.
+The supported access times settings are:
+.TP
+.in +4n
+.B MAKE_ATIME_RELATIVE
+.in +4n
+When a file on is accessed via this mount, update the file's last access time
+(atime) only if the current value of atime is less than or equal to the file's
+last modification time (mtime) or last status change time (ctime).
+.TP
+.in +4n
+.B MAKE_ATIME_NONE
+.in +4n
+Do not update access times for (all types of) files on this mount.
+.TP
+.in +4n
+.B MAKE_ATIME_STRICT
+.in +4n
+Always update the last access time (atime) when files are
+accessed on this mount.
+.PP
+The
+.I size
+argument that is supplied to
+.BR mount_setattr ()
+should be initialized to the size of this structure.
+(The existence of the
+.I size
+argument permits future extensions to the
+.IR mount_attr
+structure.)
+.SH RETURN VALUE
+On success,
+.BR mount_setattr ()
+zero is returned. On error, \-1 is returned and
+.I errno
+is set to indicate the cause of the error.
+.SH ERRORS
+.TP
+.B EBADF
+.I dfd
+is not a valid file descriptor.
+.TP
+.B ENOENT
+A pathname was empty or had a nonexistent component.
+.TP
+.B EINVAL
+Unsupported value in
+.I flags
+.TP
+.B EINVAL
+Unsupported value was specified in the
+.I attr_set
+field of
+.IR mount_attr.
+.TP
+.B EINVAL
+Unsupported value was specified in the
+.I attr_clr
+field of
+.IR mount_attr.
+.TP
+.B EINVAL
+Unsupported value was specified in the
+.I propagation
+field of
+.IR mount_attr.
+.TP
+.B EINVAL
+Unsupported value was specified in the
+.I atime
+field of
+.IR mount_attr.
+.TP
+.B EINVAL
+Caller tried to change the mount properties of a mount or mount tree
+in another mount namespace.
+.SH VERSIONS
+.BR mount_setattr ()
+first appeared in Linux ?.?.
+.\" commit ?
+.SH CONFORMING TO
+.BR mount_setattr ()
+is Linux specific.
+.SH NOTES
+Currently, there is no glibc wrapper for this system call; call it using
+.BR syscall (2).
+.SH SEE ALSO
+.BR mount (2),

base-commit: 28a4c58cc211900943f48d65fd42b313ce54e5a6
-- 
2.27.0

