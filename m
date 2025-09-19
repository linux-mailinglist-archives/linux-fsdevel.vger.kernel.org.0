Return-Path: <linux-fsdevel+bounces-62190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E93B87AAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 04:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243CC621D8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 02:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F6A258ED6;
	Fri, 19 Sep 2025 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="IXqFy9VN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CAD2580E2;
	Fri, 19 Sep 2025 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247242; cv=none; b=t9RGy4uyu3UXDsux8UlyNtXrciPXVzTVWRh3y8IHkmhGEQQjFlJIqw/AbUQwOxAi4hLihuIqNMuje9S8p8jZD8VvNAqoNhHGIBql1yc5cqoL16y/R+flp/rh03MuMdVYjp7tdY+O6GlkN+F3xt1bMQWkD48e/ehLW6/Y92WmPlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247242; c=relaxed/simple;
	bh=qXaSaDudSthlQFTGMniG/9MOQZxPmVJfi5d4/BACW5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UyxEoHVIPEiB4wumXt9p/jXO/tQ4Bs2iN6uVbgjmckP7rRD/zyUkH8AyIBRxxgeQ8/2s2fsJcrm31QYq/kl/haxfl9fMNATLhbFODgAdt76Tsx7JjCeIZF6Tjnz2sHA53yTkd5YzfdIfMr5M5FsOSEj6i4At1xmL5vH3HDS5RZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=IXqFy9VN; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cSbLk3PCZz9t7f;
	Fri, 19 Sep 2025 04:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758247230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hJFrhCfM9NDkzHdXtwu3Sc4WrKTnmNW2zAaU4xBs3k=;
	b=IXqFy9VNV/boUP8WG4/Xgo1FufkQuhvhaBh5oD3tazdcpJVHOHovHYVcCVP4Nr6LHkf9kn
	kWgEMosE6ZAeo8KgDwn+TG7M4wfdBxE0/bCdZlqpTiwgtxtamlaOjaEpeFfbUQljGFU+BM
	1YmvgMIcGY65y3g62taWXuAcGiwrSx2jCNKQkaUQd24T7mTv81LBvAxK9wmTN5y41z6bIp
	Ryo/hdABG097pyCuGZ7HTWxwsAxDuKuzkSli72g59MLMh0KHEPVIckwf1Kj7g0nz8UZlDv
	HspMElh1yElJn5HDWgmk5Cwiu9hyK5a1fhVG1iCJ4RPjyhu6fub1ii9S89pDkw==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 19 Sep 2025 11:59:46 +1000
Subject: [PATCH v4 05/10] man/man2/fsmount.2: document "new" mount API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-new-mount-api-v4-5-1261201ab562@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
In-Reply-To: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6666; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=qXaSaDudSthlQFTGMniG/9MOQZxPmVJfi5d4/BACW5Y=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSc2SmmGnns68/AMw9/MP4MSji0SP52yo/MO8bztktMV
 oi/w+ZT3DGRhUGMi8FSTJFlm59n6Kb5i68kf1rJBjOHlQlkiLRIAwMDAwMLA19uYl6pkY6Rnqm2
 oZ6hoY6RjhEDF6cATHVWFSPDVr9bllln2l1qjyt7F7jNrdNa8aziuvKvwxwmr1c7f3Jcwcjw+h7
 zNO8N3XvStYJkDhlHz7mmwCPOf6171zExpzUWZW3cAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

This is loosely based on the original documentation written by David
Howells and later maintained by Christian Brauner, but has been
rewritten to be more from a user perspective (as well as fixing a few
critical mistakes).

Co-authored-by: David Howells <dhowells@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Co-authored-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/fsmount.2 | 231 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/man/man2/fsmount.2 b/man/man2/fsmount.2
new file mode 100644
index 0000000000000000000000000000000000000000..c054c04376975c620aec08b76ad5151d8b6ae2ed
--- /dev/null
+++ b/man/man2/fsmount.2
@@ -0,0 +1,231 @@
+.\" Copyright, the authors of the Linux man-pages project
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH fsmount 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+fsmount \- instantiate mount object from filesystem context
+.SH LIBRARY
+Standard C library
+.RI ( libc ,\~ \-lc )
+.SH SYNOPSIS
+.nf
+.B #include <sys/mount.h>
+.P
+.BI "int fsmount(int " fsfd ", unsigned int " flags ", \
+unsigned int " attr_flags );
+.fi
+.SH DESCRIPTION
+The
+.BR fsmount ()
+system call is part of
+the suite of file descriptor based mount facilities in Linux.
+.P
+.BR fsmount ()
+creates a new detached mount object
+for the root of the new filesystem instance
+referenced by the filesystem context file descriptor
+.IR fsfd .
+A new file descriptor
+associated with the detached mount object
+is then returned.
+In order to create a mount object with
+.BR fsmount (),
+the calling process must have the
+.BR \%CAP_SYS_ADMIN
+capability.
+.P
+The filesystem context must have been created with a call to
+.BR fsopen (2)
+and then had a filesystem instance instantiated with a call to
+.BR fsconfig (2)
+with
+.B \%FSCONFIG_CMD_CREATE
+or
+.B \%FSCONFIG_CMD_CREATE_EXCL
+in order to be in the correct state
+for this operation
+(the "awaiting-mount" mode in kernel-developer parlance).
+.\" FS_CONTEXT_AWAITING_MOUNT is the term the kernel uses for this.
+Unlike
+.BR open_tree (2)
+with
+.BR \%OPEN_TREE_CLONE,
+.BR fsmount ()
+can only be called once
+in the lifetime of a filesystem context
+to produce a mount object.
+.P
+As with file descriptors returned from
+.BR open_tree (2)
+called with
+.BR OPEN_TREE_CLONE ,
+the returned file descriptor
+can then be used with
+.BR move_mount (2),
+.BR mount_setattr (2),
+or other such system calls to do further mount operations.
+This mount object will be unmounted and destroyed
+when the file descriptor is closed
+if it was not otherwise attached to a mount point
+by calling
+.BR move_mount (2).
+(Note that the unmount operation on
+.BR close (2)
+is lazy\[em]akin to calling
+.BR umount2 (2)
+with
+.BR MOUNT_DETACH ;
+any existing open references to files
+from the mount object
+will continue to work,
+and the mount object will only be completely destroyed
+once it ceases to be busy.)
+The returned file descriptor
+also acts the same as one produced by
+.BR open (2)
+with
+.BR O_PATH ,
+meaning it can also be used as a
+.I dirfd
+argument
+to "*at()" system calls.
+.P
+.I flags
+controls the creation of the returned file descriptor.
+A value for
+.I flags
+is constructed by bitwise ORing
+zero or more of the following constants:
+.RS
+.TP
+.B FSMOUNT_CLOEXEC
+Set the close-on-exec
+.RB ( FD_CLOEXEC )
+flag on the new file descriptor.
+See the description of the
+.B O_CLOEXEC
+flag in
+.BR open (2)
+for reasons why this may be useful.
+.RE
+.P
+.I attr_flags
+specifies mount attributes
+which will be applied to the created mount object,
+in the form of
+.BI \%MOUNT_ATTR_ *
+flags.
+The flags are interpreted as though
+.BR mount_setattr (2)
+was called with
+.I attr.attr_set
+set to the same value as
+.IR attr_flags .
+.BI \%MOUNT_ATTR_ *
+flags which would require
+specifying additional fields in
+.BR mount_attr (2type)
+(such as
+.BR \%MOUNT_ATTR_IDMAP )
+are not valid flag values for
+.IR attr_flags .
+.P
+If the
+.BR fsmount ()
+operation is successful,
+the filesystem context
+associated with the file descriptor
+.I fsfd
+is reset
+and placed into reconfiguration mode,
+as if it were just returned by
+.BR fspick (2).
+You may continue to use
+.BR fsconfig (2)
+with the now-reset filesystem context,
+including issuing the
+.B \%FSCONFIG_CMD_RECONFIGURE
+command
+to reconfigure the filesystem instance.
+.SH RETURN VALUE
+On success, a new file descriptor is returned.
+On error, \-1 is returned, and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+.TP
+.B EBUSY
+The filesystem context associated with
+.I fsfd
+is not in the right state
+to be used by
+.BR fsmount ().
+.TP
+.B EINVAL
+.I flags
+had an invalid flag set.
+.TP
+.B EINVAL
+.I attr_flags
+had an invalid
+.BI MOUNT_ATTR_ *
+flag set.
+.TP
+.B EMFILE
+The calling process has too many open files to create more.
+.TP
+.B ENFILE
+The system has too many open files to create more.
+.TP
+.B ENOSPC
+The "anonymous" mount namespace
+necessary to contain the new mount object
+could not be allocated,
+as doing so would exceed
+the configured per-user limit on
+the number of mount namespaces in the current user namespace.
+(See also
+.BR namespaces (7).)
+.TP
+.B ENOMEM
+The kernel could not allocate sufficient memory to complete the operation.
+.TP
+.B EPERM
+The calling process does not have the required
+.B CAP_SYS_ADMIN
+capability.
+.SH STANDARDS
+Linux.
+.SH HISTORY
+Linux 5.2.
+.\" commit 93766fbd2696c2c4453dd8e1070977e9cd4e6b6d
+.\" commit 400913252d09f9cfb8cce33daee43167921fc343
+glibc 2.36.
+.SH EXAMPLES
+.in +4n
+.EX
+int fsfd, mntfd, tmpfd;
+\&
+fsfd = fsopen("tmpfs", FSOPEN_CLOEXEC);
+fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_NODEV | MOUNT_ATTR_NOEXEC);
+\&
+/* Create a new file without attaching the mount object. */
+int tmpfd = openat(mntfd, "tmpfile", O_CREAT | O_EXCL | O_RDWR, 0600);
+unlinkat(mntfd, "tmpfile", 0);
+\&
+/* Attach the mount object to "/tmp". */
+move_mount(mntfd, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH);
+.EE
+.in
+.SH SEE ALSO
+.BR fsconfig (2),
+.BR fsopen (2),
+.BR fspick (2),
+.BR mount (2),
+.BR mount_setattr (2),
+.BR move_mount (2),
+.BR open_tree (2),
+.BR mount_namespaces (7)
+

-- 
2.51.0


