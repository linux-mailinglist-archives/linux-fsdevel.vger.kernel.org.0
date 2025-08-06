Return-Path: <linux-fsdevel+bounces-56866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F3EB1CB54
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 530CE7B0DF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD6C2BEC23;
	Wed,  6 Aug 2025 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="gdsm/Hvr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D172BEC2E;
	Wed,  6 Aug 2025 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502337; cv=none; b=Rls1nDgOsBk17Wd1/csEPpTi/e6e95sGOxOzXsdN/Iw5EzS5PVHxoY8+LZhaOb2DZu+OyFk+iohfR+4+BrOGinRqWwGXNpdNyHz8gdRUxCbnrOsX45JFZJoK03puaf8zIV/eTAsu0Nbx2yFKXuH4WjFKJZt44DByFzaKK//T9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502337; c=relaxed/simple;
	bh=DfVp7Qh4qzNKnR+wvPx9r0CCicFOLCmcxyEIhNKUYHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTv93D/KHOEvXL79ZMtzxRUOWlnGMRvS98sCXBJOc+pb1M8FPOqWJbG45/xPv4K44ZSp3xp1qECv8vfqi2w6qnta7HsC3KRCRpeXtXvAipaTw4HBlZnNyk2fbMZly0jkGDC+DlMv0lxXBc3uU4Er3HS9h/41QfJHjtrsBhh6xwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=gdsm/Hvr; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bxyPR32lbz9t6m;
	Wed,  6 Aug 2025 19:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754502331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZ6rAyB1NSbePvXR8lDYnagwjuE0pZoX6N+BqIoX6RY=;
	b=gdsm/HvrQc+vohEtPfsUnIp7zquCkI268Ffs1X8WzVvmLRhm/Zy3kon2sy42qdjShXtstl
	Ft3gH/gv438Sbk8fUJ/9tXR3J8ryVILmKmMe7/R2KA7cK84tXqmaMguUxWgBQ8QR+kqU00
	An4CoTD2CDkR7cf8gn09eCvQfm1y4sWxHAymfYlX6IKCXrG7aAvjaS84h3YTY7ekPQbRkJ
	o1xWQgzu36uuAdyJNlQ7gthi6BVohw/hCjutAydCGhghZl8pun1UBrB60vqe986CUBI7wZ
	y2dS/RpSvTSftmMRTJG8HYh9C4/kCSaZntQI/LFHi5sb6O8E1uiCjUyRDLzSwg==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 07 Aug 2025 03:44:41 +1000
Subject: [PATCH v2 07/11] move_mount.2: document 'new' mount api
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-new-mount-api-v2-7-558a27b8068c@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
In-Reply-To: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=14804; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=DfVp7Qh4qzNKnR+wvPx9r0CCicFOLCmcxyEIhNKUYHY=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMntJuJreLV/FhlG6Cte3sd7HF3TNs3Dh/T7tzW2i2B
 9e/w8/zO0pZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBEgvQZ/ieydm9vX7VCYKlE
 lSdX0jvzvVUq1rOqDuhOzV3CsPok0xuGf/bF632Uk/ZYlf1pZhf4M+sdp0Jny6dQ/QWpNxU9Vl3
 K4wcA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

This is loosely based on the original documentation written by David
Howells and later maintained by Christian Brauner, but has been
rewritten to be more from a user perspective (as well as fixing a few
critical mistakes).

Co-developed-by: David Howells <dhowells@redhat.com>
Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/move_mount.2 | 609 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 609 insertions(+)

diff --git a/man/man2/move_mount.2 b/man/man2/move_mount.2
new file mode 100644
index 000000000000..6a944198f620
--- /dev/null
+++ b/man/man2/move_mount.2
@@ -0,0 +1,609 @@
+.\" Copyright, the authors of the Linux man-pages project
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH move_mount 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+move_mount \- move or attach mount object to filesystem
+.SH LIBRARY
+Standard C library
+.RI ( libc ,\~ \-lc )
+.SH SYNOPSIS
+.nf
+.BR "#include <fcntl.h>" \
+"          /* Definition of " AT_* " constants */"
+.BR "#include <sys/mount.h>"
+.P
+.BI "int move_mount(int " from_dirfd ", const char *" from_path ","
+.BI "               int " to_dirfd ", const char *" to_path ","
+.BI "               unsigned int " flags ");"
+.fi
+.SH DESCRIPTION
+The
+.BR move_mount ()
+system call is part of the suite of file descriptor based mount facilities
+in Linux.
+.P
+.BR move_mount ()
+moves the mount object indicated by
+.I from_dirfd
+and
+.I from_path
+to the path indicated by
+.I to_dirfd
+and
+.IR to_path .
+The mount object being moved
+could be an existing mount point in the current mount namespace,
+or it could be a detached mount object created by
+.BR fsmount (2)
+or
+.BR open_tree (2)
+with
+.BR \%OPEN_TREE_CLONE .
+.P
+To access the source mount object
+or the destination mount point,
+no permissions are required on the object itself,
+but if either pathname is supplied,
+execute (search) permission is required
+on all of the directories specified in
+.I from_path
+or
+.IR to_path .
+.P
+The calling process must have the
+.BR \%CAP_SYS_ADMIN
+capability in order to attach or move a mount object.
+.P
+As with "*at()" system calls,
+.BR move_mount ()
+uses the
+.I from_dirfd
+and
+.I to_dirfd
+arguments
+in conjunction with the
+.I from_path
+and
+.I to_path
+arguments to determine the source and destination objects to operate on
+(respectively), as follows:
+.IP \[bu] 3
+If the pathname given in
+.I *_path
+is absolute, then
+the corresponding
+.I *_dirfd
+is ignored.
+.IP \[bu]
+If the pathname given in
+.I *_path
+is relative and
+the corresponding
+.I *_dirfd
+is the special value
+.BR AT_FDCWD ,
+then
+.I *_path
+is interpreted relative to
+the current working directory
+of the calling process (like
+.BR open (2)).
+.IP \[bu]
+If the pathname given in
+.I *_path
+is relative,
+then it is interpreted relative to
+the directory referred to by
+the corresponding file descriptor
+.I *_dirfd
+(rather than relative to
+the current working directory
+of the calling process,
+as is done by
+.BR open (2)
+for a relative pathname).
+In this case,
+the corresponding
+.I *_dirfd
+must be a directory
+that was opened for reading
+.RB ( O_RDONLY )
+or using the
+.B O_PATH
+flag.
+.IP \[bu]
+If
+.I *_path
+is an empty string,
+and
+.I flags
+contains the appropriate
+.BI \%MOVE_MOUNT_ * _EMPTY_PATH
+flag,
+then the file descriptor referenced by
+the corresponding
+.I *_dirfd
+is operated on directly.
+In this case,
+the corresponding
+.I *_dirfd
+can refer to any type of file,
+not just a directory.
+.IP
+This is the most common mechanism
+used to attach detached mount objects
+to a mount point target.
+.P
+.I flags
+can be used to control aspects of the path lookup
+for both the source and destination objects,
+as well as other properties of the mount operation.
+A value for
+.I flags
+is constructed by bitwise ORing
+zero or more of the following constants:
+.RS
+.TP
+.B MOVE_MOUNT_F_EMPTY_PATH
+If
+.I from_path
+is an empty string, operate on the file referred to by
+.I from_dirfd
+(which may have been obtained from
+.BR open (2),
+.BR fsmount (2),
+or
+.BR open_tree (2)).
+In this case,
+.I from_dirfd
+can refer to any type of file,
+not just a directory.
+If
+.I from_dirfd
+is
+.BR AT_FDCWD ,
+the call operates on the current working directory.
+.TP
+.B MOVE_MOUNT_T_EMPTY_PATH
+As with
+.BR \%MOVE_MOUNT_F_EMPTY_PATH ,
+except operating on
+.IR to_dirfd " and " to_path .
+.TP
+.B MOVE_MOUNT_F_SYMLINKS
+If
+.IR from_path
+references a symbolic link,
+then dereference it.
+The default behaviour for
+.BR move_mount ()
+is to
+.I not follow
+symbolic links.
+.TP
+.B MOVE_MOUNT_T_SYMLINKS
+As with
+.BR \%MOVE_MOUNT_F_SYMLINKS ,
+except operating on
+.I to_dirfd
+and
+.IR to_path .
+.TP
+.B MOVE_MOUNT_F_NO_AUTOMOUNT
+Don't automount the terminal ("basename") component of
+.I from_path
+if it is a directory that is an automount point.
+This allows a mount object
+that has an automount point at its root
+to be moved
+and prevents unintended triggering of an automount point.
+This flag has no effect
+if the automount point has already been mounted over.
+.TP
+.B MOVE_MOUNT_T_NO_AUTOMOUNT
+As with
+.BR \%MOVE_MOUNT_F_NO_AUTOMOUNT ,
+except operating on
+.IR to_dirfd " and " to_path .
+This allows an automount point to be manually mounted over.
+.TP
+.BR MOVE_MOUNT_SET_GROUP " (since Linux 5.15)"
+Add the attached (private) mount indicated by
+.I to_dirfd
+and
+.I to_path
+into the mount propagation "peer group"
+of the attached (non-private) mount
+indicated by
+.IR from_dirfd " and " from_path .
+.IP
+Unlike other
+.BR move_mount ()
+operations,
+this operation does not move any actual mount objects.
+Instead, it only updates the metadata
+of existing (attached) mount objects.
+.IP
+This makes it possible to first create a mount tree
+consisting only of private mounts
+and then configure the desired propagation layout afterwards.
+(See the "SHARED SUBTREES" section of
+.BR mount_namespaces (7)
+for more information about mount propagation and peer groups.)
+.TP
+.BR MOVE_MOUNT_BENEATH " (since Linux 6.5)"
+If the path indicated by
+.I to_dirfd
+and
+.I to_path
+is an existing mount object,
+rather than placing the mount object indicated by
+.I from_dirfd
+and
+.I from_path
+on top of the mount stack,
+place it below the current top mount
+on the mount stack.
+.IP
+After using
+.BR \%MOVE_MOUNT_BENEATH ,
+it is possible to
+.BR umount (2)
+the top mount
+in order to reveal the mount
+which was moved beneath it earlier.
+This allows for the seamless (and atomic) replacement
+of intricate mount trees,
+which can further be used
+to "upgrade" a mount tree with a newer version.
+.IP
+This operation has several restrictions:
+.RS
+.IP \[bu] 3
+Mounts cannot be moved beneath the rootfs,
+including the rootfs as configured by
+.BR chroot (2)
+and
+.BR pivot_root (2).
+To mount beneath the rootfs,
+.BR pivot_root (2)
+must be used.
+.IP \[bu]
+The target path indicated by
+.I to_dirfd
+and
+.I to_path
+must be an attached mount object.
+It must not be a detached mount object given by
+.BR open_tree (2)
+with
+.B \%OPEN_TREE_CLONE
+or
+.BR fsmount (2).
+.IP \[bu]
+The current top mount
+of the target path's mount stack
+and its parent mount
+must be in the calling process's mount namespace.
+.IP \[bu]
+The caller must have sufficient privileges
+to unmount the top mount
+of the target path's mount stack,
+to prove they have privileges
+to reveal the underlying mount.
+.IP \[bu]
+Mount propagation events triggered by this
+.BR move_mount ()
+operation
+are calculated based on the parent mount
+of the current top mount
+of the target path's mount stack.
+.IP \[bu]
+The target path's mount
+cannot be a parent mount
+of the source mount object.
+.IP \[bu]
+The source mount object
+must not have any overmounts,
+otherwise it would be possible to create "shadow mounts"
+(i.e., two mounts mounted on the same parent mount at the same mount point).
+.IP \[bu]
+It is not possible to move a mount
+beneath a top mount
+if the parent mount
+of the current top mount
+propagates to the top mount itself.
+Otherwise,
+.B \%MOVE_MOUNT_BENEATH
+would cause the mount object
+to be propagated
+to the top mount
+from the parent mount,
+defeating the purpose of using
+.BR \%MOVE_MOUNT_BENEATH .
+.IP \[bu]
+It is not possible to move a mount
+beneath a top mount
+if the parent mount
+of the current top mount
+propagates to the mount object
+being mounted beneath.
+Otherwise, this would cause a similar propagation issue
+to the previous point,
+also defeating the purpose of using
+.BR \%MOVE_MOUNT_BENEATH .
+.RE
+.RE
+.P
+If
+.BR move_mount ()
+is called repeatedly
+with a file descriptor
+that refers to a mount object,
+then the object will be attached (or moved)
+the first time
+and then moved again and again,
+detaching it from the previous mount point each time.
+.SH RETURN VALUE
+On success,
+.BR move_mount ()
+returns 0.
+On error, \-1 is returned, and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+.TP
+.B EACCES
+Search permission is denied
+for one of the directories
+in the path prefix of one of
+.IR from_path " or " to_path .
+(See also
+.BR path_resolution (7).)
+.TP
+.B EBADF
+One of
+.I from_dirfd
+or
+.I to_dirfd
+is not a valid file descriptor.
+.TP
+.B EFAULT
+One of
+.I from_path
+or
+.I to_path
+is NULL
+or a pointer to a location
+outside the calling process's accessible address space.
+.TP
+.B EINVAL
+Invalid flag specified in
+.IR flags .
+.TP
+.B EINVAL
+The path indicated by
+.IR from_dirfd " and " from_path
+is not a mount object.
+.TP
+.B EINVAL
+The mount object type
+of the source mount object and target inode
+are not compatible
+(i.e., the source is a file but the target is a directory, or vice-versa).
+.TP
+.B EINVAL
+The source mount object or target path
+are not in the calling process's mount namespace
+(or an anonymous mount namespace of the calling process).
+.TP
+.B EINVAL
+The source mount object's parent mount
+has shared mount propagation,
+and thus cannot be moved
+(as described in
+.BR mount_namespaces (7)).
+.TP
+.B EINVAL
+The source mount has
+.B MS_UNBINDABLE
+child mounts
+but the target path
+resides on a mount tree with shared mount propagation,
+which would otherwise cause the unbindable mounts to be propagated
+(as described in
+.BR mount_namespaces (7)).
+.TP
+.B EINVAL
+.B \%MOVE_MOUNT_BENEATH
+was attempted,
+but one of the listed restrictions was violated.
+.TP
+.B ELOOP
+Too many symbolic links encountered
+when resolving one of
+.I from_path
+or
+.IR to_path .
+.TP
+.B ENAMETOOLONG
+One of
+.I from_path
+or
+.I to_path
+is longer than
+.BR PATH_MAX .
+.TP
+.B ENOENT
+A component of one of
+.I from_path
+or
+.I to_path
+does not exist.
+.TP
+.B ENOENT
+One of
+.I from_path
+or
+.I to_path
+is an empty string,
+but the corresponding
+.BI MOVE_MOUNT_ * _EMPTY_PATH
+flag is not specified in
+.IR flags .
+.TP
+.B ENOTDIR
+A component of the path prefix of one of
+.I from_path
+or
+.I to_path
+is not a directory,
+or one of
+.I from_path
+or
+.I to_path
+is relative
+and the corresponding
+.I from_dirfd
+or
+.I to_dirfd
+is a file descriptor referring to a file other than a directory.
+.TP
+.B ENOMEM
+The kernel could not allocate sufficient memory to complete the operation.
+.TP
+.B EPERM
+The calling process does not have the required
+.B \%CAP_SYS_ADMIN
+capability.
+.SH STANDARDS
+Linux.
+.SH HISTORY
+Linux 5.2.
+.\" commit 2db154b3ea8e14b04fee23e3fdfd5e9d17fbc6ae
+glibc 2.36.
+.SH EXAMPLES
+.BR move_mount ()
+can be used to move attached mounts like the following:
+.P
+.in +4n
+.EX
+move_mount(AT_FDCWD, "/a", AT_FDCWD, "/b", 0);
+.EE
+.in
+.P
+This would move the mount object mounted on
+.I /a
+to
+.IR /b .
+The above procedure is functionally equivalent to
+the following mount operation
+using
+.BR mount (2):
+.P
+.in +4n
+.EX
+mount("/a", "/b", NULL, MS_MOVE, NULL);
+.EE
+.in
+.P
+.BR move_mount ()
+can also be used in conjunction with file descriptors returned from
+.BR open_tree (2)
+or
+.BR open (2):
+.P
+.in +4n
+.EX
+int fd = open_tree(AT_FDCWD, "/mnt", 0); /* or open("/mnt", O_PATH); */
+move_mount(fd, "", AT_FDCWD, "/mnt2", MOVE_MOUNT_F_EMPTY_PATH);
+move_mount(fd, "", AT_FDCWD, "/mnt3", MOVE_MOUNT_F_EMPTY_PATH);
+move_mount(fd, "", AT_FDCWD, "/mnt4", MOVE_MOUNT_F_EMPTY_PATH);
+.EE
+.in
+.P
+This would move the mount object mounted at
+.I /mnt
+to
+.IR /mnt2 ,
+then
+.IR /mnt3 ,
+then
+.IR /mnt4 .
+.P
+If the source mount object
+indicated by
+.I from_dirfd
+and
+.I from_path
+is a detached mount object,
+.BR move_mount ()
+can be used to attach it to a mount point:
+.P
+.in +4n
+.EX
+int fsfd, mntfd;
+\&
+fsfd = fsopen("ext4", FSOPEN_CLOEXEC);
+fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "/dev/sda1", 0);
+fsconfig(fsfd, FSCONFIG_SET_FLAG, "user_xattr", NULL, 0);
+fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_NODEV);
+move_mount(mntfd, "", AT_FDCWD, "/home", MOVE_MOUNT_F_EMPTY_PATH);
+.EE
+.in
+.P
+This creates a new filesystem configuration context for ext4,
+configures it,
+creates a mount object,
+and then attaches it to
+.IR /home .
+The above procedure is functionally equivalent to
+the following mount operation
+using
+.BR mount (2):
+.P
+.in +4n
+.EX
+mount("/dev/sda1", "/home", "ext4", MS_NODEV, "user_xattr");
+.EE
+.in
+.P
+This also works with detached bind-mounts created with
+.BR open_tree (2)
+with
+.BR OPEN_TREE_CLONE :
+.P
+.in +4n
+.EX
+int mntfd = open_tree(AT_FDCWD, "/home/cyphar", OPEN_TREE_CLONE);
+move_mount(mntfd, "", AT_FDCWD, "/root", MOVE_MOUNT_F_EMPTY_PATH);
+.EE
+.in
+.P
+This creates a new detached bind-mount mount object of
+.IR /home/cyphar ,
+and then attaches it to
+.IR /root .
+The above procedure is functionally equivalent to
+the following mount operation
+using
+.BR mount (2):
+.P
+.in +4n
+.EX
+mount("/home/cyphar", "/root", NULL, MS_BIND, NULL);
+.EE
+.in
+.SH SEE ALSO
+.BR fsconfig (2),
+.BR fsmount (2),
+.BR fsopen (2),
+.BR fspick (2),
+.BR mount (2),
+.BR mount_setattr (2),
+.BR open_tree (2),
+.BR mount_namespaces (7)
+

-- 
2.50.1


