Return-Path: <linux-fsdevel+bounces-57149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C968B1EFB9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 22:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46477162448
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 20:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020ED2561AB;
	Fri,  8 Aug 2025 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="dEVzKYLn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D05253939;
	Fri,  8 Aug 2025 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685665; cv=none; b=P8BLCleIqxFEBhXiTU3lA0iOAww+dem5teHEvxAdbyoJ3VGMTpvu940sBqacyVIjrxvgcWlH/DneA3DSZHI4ilkXtepE4NLluTK09MGV0NmVc9wqpEULjl/eJTF2utXE0JHp0Fru8RQ4p8gUOB2QnF1CsJRxjnnYu/EZQ+O5OMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685665; c=relaxed/simple;
	bh=bSeqyXAXnjU3xZRJle5jTkcmh4aB3oDy5r9FCQk9ZOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGVr5g/lVMV9R4HGRlzG8V/FWEd/rfO/ux/YIQML6KTjE3aMovyzPujQPAWTsoIpMsWf02cx1naF9e5xi+CoUuE7i5gQ6SrSj6A+BL9ALNnUcPQwW5CMm3twMYJaYcSbgWhrN8mfOAMKEBdQUnvmkXqNvrtiYboFRJjMrMOfeos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=dEVzKYLn; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bzGBz6BP5z9ssn;
	Fri,  8 Aug 2025 22:40:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754685659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82z6kh61HtnSG2ifnALJUZbFSUNo8ByAHKEQBHqZEHQ=;
	b=dEVzKYLn2q4crj0n/GM9nb9c2hfBElQv0OE1DEDpswUeE7waA12kZrItg1yIevesPagAOa
	So/J9f759pHxFOpDP+0k9v1l+6+T73A9ZWtVLnS/cBICpQ6A0l6s+iqNwGr1gV1TfG2G68
	3s8ywcv/2gFnFeJIfWo3gU0vC116QUBGLgbnXtNJ63SNvWI2P8ftjELWCOaGib8cTCfp4d
	qy/BIrmJFoPeYYIHccQBLKhaHfrk1YU+kATTQ/58x8obaoU/6siRkaKqZFxr/OQYtl33TP
	PJ9P9mD/eVh07bTpFIG/UJw1LtN6vzyMOH4V8AwWucsPFZVFTaCV6IXZ3l6HXQ==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Sat, 09 Aug 2025 06:39:53 +1000
Subject: [PATCH v3 09/12] man/man2/open_tree.2: document "new" mount API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-new-mount-api-v3-9-f61405c80f34@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
In-Reply-To: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=11759; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=bSeqyXAXnjU3xZRJle5jTkcmh4aB3oDy5r9FCQk9ZOk=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMS5ghN/Ulp4qun9B759vPn7+56HKd+c+U9FdZfZHSw
 sKz96Wv6yhlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQATyc5hZDjx45m0wpTcOYqr
 595Jv+Qo77Qw3KGapbvGQfXmCuOn6S8Y/tdxTn/9NyjqwZQpW2zNA2uufC9W7Vi4XPy7oPWNt8s
 MlRgB
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
 man/man2/open_tree.2 | 471 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 471 insertions(+)

diff --git a/man/man2/open_tree.2 b/man/man2/open_tree.2
new file mode 100644
index 0000000000000000000000000000000000000000..07aac7616107d16d05cc71ba7db6aee35f3a9cc6
--- /dev/null
+++ b/man/man2/open_tree.2
@@ -0,0 +1,471 @@
+.\" Copyright, the authors of the Linux man-pages project
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH open_tree 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+open_tree \- open path or create detached mount object and attach to fd
+.SH LIBRARY
+Standard C library
+.RI ( libc ,\~ \-lc )
+.SH SYNOPSIS
+.nf
+.BR "#include <fcntl.h>" "          /* Definition of " AT_* " constants */"
+.B #include <sys/mount.h>
+.P
+.BI "int open_tree(int " dirfd ", const char *" path ", unsigned int " flags ");"
+.fi
+.SH DESCRIPTION
+The
+.BR open_tree ()
+system call is part of
+the suite of file descriptor based mount facilities in Linux.
+.IP \[bu] 3
+If
+.I flags
+contains
+.BR \%OPEN_TREE_CLONE ,
+.BR open_tree ()
+creates a detached mount object
+which consists of a bind-mount of
+the path specified by the
+.IR path .
+A new file descriptor
+associated with the detached mount object
+is then returned.
+The mount object is equivalent to a bind-mount
+that would be created by
+.BR mount (2)
+called with
+.BR MS_BIND ,
+except that it is tied to a file descriptor
+and is not mounted onto the filesystem.
+.IP
+As with file descriptors returned from
+.BR fsmount (2),
+the resultant file descriptor can then be used with
+.BR move_mount (2),
+.BR mount_setattr (2),
+or other such system calls to do further mount operations.
+This mount object will be unmounted and destroyed
+when the file descriptor is closed
+if it was not otherwise attached to a mount point
+by calling
+.BR move_mount (2).
+.IP \[bu]
+If
+.I flags
+does not contain
+.BR \%OPEN_TREE_CLONE ,
+.BR open_tree ()
+returns a file descriptor
+that is exactly equivalent to
+one produced by
+.BR openat (2)
+when called with the same
+.I dirfd
+and
+.IR path .
+.P
+In either case, the resultant file descriptor
+acts the same as one produced by
+.BR open (2)
+with
+.BR O_PATH ,
+meaning it can also be used as a
+.I dirfd
+argument to
+"*at()" system calls.
+.P
+As with "*at()" system calls,
+.BR open_tree ()
+uses the
+.I dirfd
+argument in conjunction with the
+.I path
+argument to determine the path to operate on, as follows:
+.IP \[bu] 3
+If the pathname given in
+.I path
+is absolute, then
+.I dirfd
+is ignored.
+.IP \[bu]
+If the pathname given in
+.I path
+is relative and
+.I dirfd
+is the special value
+.BR \%AT_FDCWD ,
+then
+.I path
+is interpreted relative to
+the current working directory
+of the calling process (like
+.BR open (2)).
+.IP \[bu]
+If the pathname given in
+.I path
+is relative,
+then it is interpreted relative to
+the directory referred to by the file descriptor
+.I dirfd
+(rather than relative to
+the current working directory
+of the calling process,
+as is done by
+.BR open (2)
+for a relative pathname).
+In this case,
+.I dirfd
+must be a directory
+that was opened for reading
+.RB ( O_RDONLY )
+or using the
+.B O_PATH
+flag.
+.IP \[bu]
+If
+.I path
+is an empty string,
+and
+.I flags
+contains
+.BR \%AT_EMPTY_PATH ,
+then the file descriptor
+.I dirfd
+is operated on directly.
+In this case,
+.I dirfd
+may refer to any type of file,
+not just a directory.
+.P
+.I flags
+can be used to control aspects of the path lookup
+and properties of the returned file descriptor.
+A value for
+.I flags
+is constructed by bitwise ORing
+zero or more of the following constants:
+.RS
+.TP
+.B AT_EMPTY_PATH
+If
+.I path
+is an empty string, operate on the file referred to by
+.I dirfd
+(which may have been obtained from
+.BR open (2),
+.BR fsmount(2),
+or from another
+.BR open_tree ()
+call).
+In this case,
+.I dirfd
+may refer to any type of file, not just a directory.
+If
+.I dirfd
+is
+.BR \%AT_FDCWD ,
+.BR open_tree ()
+will operate on the current working directory
+of the calling process.
+This flag is Linux-specific; define
+.B \%_GNU_SOURCE
+to obtain its definition.
+.TP
+.B AT_NO_AUTOMOUNT
+Do not automount any automount points encountered
+while resolving
+.IR path .
+This allows you to create a handle to the automount point itself,
+rather than the location it would mount.
+This flag has no effect if the mount point has already been mounted over.
+This flag is Linux-specific; define
+.B \%_GNU_SOURCE
+to obtain its definition.
+.TP
+.B AT_SYMLINK_NOFOLLOW
+If
+.I path
+is a symbolic link, do not dereference it; instead,
+create either a handle to the link itself
+or a bind-mount of it.
+The resultant file descriptor is indistinguishable from one produced by
+.BR openat (2)
+with
+.BR \%O_PATH | O_NOFOLLLOW .
+.TP
+.B OPEN_TREE_CLOEXEC
+Set the close-on-exec
+.RB ( FD_CLOEXEC )
+flag on the new file descriptor.
+See the description of the
+.B O_CLOEXEC
+flag in
+.BR open (2)
+for reasons why this may be useful.
+.TP
+.B OPEN_TREE_CLONE
+Rather than creating an
+.BR openat (2)-style
+.B O_PATH
+file descriptor,
+create a bind-mount of
+.I path
+(akin to
+.IR "mount --bind" )
+as a detached mount object.
+In order to do this operation,
+the calling process must have the
+.BR \%CAP_SYS_ADMIN
+capability.
+.TP
+.B AT_RECURSIVE
+Create a recursive bind-mount of the path
+(akin to
+.IR "mount --rbind" )
+as a detached mount object.
+This flag is only permitted in conjunction with
+.BR \%OPEN_TREE_CLONE .
+.SH RETURN VALUE
+On success, a new file descriptor is returned.
+On error, \-1 is returned, and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+.TP
+.B EACCES
+Search permission is denied for one of the directories
+in the path prefix of
+.IR path .
+(See also
+.BR path_resolution (7).)
+.TP
+.B EBADF
+.I path
+is relative but
+.I dirfd
+is neither
+.B \%AT_FDCWD
+nor a valid file descriptor.
+.TP
+.B EFAULT
+.I path
+is NULL
+or a pointer to a location
+outside the calling process's accessible address space.
+.TP
+.B EINVAL
+Invalid flag specified in
+.IR flags .
+.TP
+.B ELOOP
+Too many symbolic links encountered when resolving
+.IR path .
+.TP
+.B EMFILE
+The calling process has too many open files to create more.
+.TP
+.B ENAMETOOLONG
+.I path
+is longer than
+.BR PATH_MAX .
+.TP
+.B ENFILE
+The system has too many open files to create more.
+.TP
+.B ENOENT
+A component of
+.I path
+does not exist, or is a dangling symbolic link.
+.TP
+.B ENOENT
+.I path
+is an empty string, but
+.B AT_EMPTY_PATH
+is not specified in
+.IR flags .
+.TP
+.B ENOTDIR
+A component of the path prefix of
+.I path
+is not a directory, or
+.I path
+is relative and
+.I dirfd
+is a file descriptor referring to a file other than a directory.
+.TP
+.B ENOSPC
+The "anonymous" mount namespace
+necessary to contain the
+.B \%OPEN_TREE_CLONE
+detached bind-mount mount object
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
+.I flags
+contains
+.B \%OPEN_TREE_CLONE
+but the calling process does not have the required
+.B CAP_SYS_ADMIN
+capability.
+.SH STANDARDS
+Linux.
+.SH HISTORY
+Linux 5.2.
+.\" commit a07b20004793d8926f78d63eb5980559f7813404
+.\" commit 400913252d09f9cfb8cce33daee43167921fc343
+glibc 2.36.
+.SH NOTES
+.SS Anonymous mount namespaces
+The bind-mount mount objects created by
+.BR open_tree ()
+with
+.B \%OPEN_TREE_CLONE
+are not attached to the mount namespace of the calling process.
+Instead, each mount object is attached to
+a newly allocated "anonymous" mount namespace
+associated with the calling process.
+.P
+One of the side-effects of this is that
+(unlike bind-mounts created with
+.BR mount (2)),
+mount propagation
+(as described in
+.BR mount_namespaces (7))
+will not be applied to bind-mounts created by
+.BR open_tree ()
+until the bind-mount is attached with
+.BR move_mount (2),
+at which point the mount
+will be associated with the mount namespace
+where it was mounted
+and mount propagation will resume.
+.SH EXAMPLES
+The following examples show how
+.BR open_tree ()
+can be used in place of more traditional
+.BR mount (2)
+calls with
+.BR MS_BIND .
+.P
+.in +4n
+.EX
+int srcfd = open_tree(AT_FDCWD, "/var", OPEN_TREE_CLONE);
+move_mount(srcfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
+.EE
+.in
+.P
+First,
+a detached bind-mount mount object of
+.I /var
+is created and attached to the file descriptor
+.IR srcfd .
+Then, the mount object is attached to
+.I /mnt
+using
+.BR move_mount (2)
+with
+.B \%MOVE_MOUNT_F_EMPTY_PATH
+to request that the detached mount object attached to the file descriptor
+.I srcfd
+be moved (and thus attached) to
+.IR /mnt .
+.P
+The above procedure is functionally equivalent to
+the following mount operation using
+.BR mount (2):
+.P
+.in +4n
+.EX
+mount("/var", "/mnt", NULL, MS_BIND, NULL);
+.EE
+.in
+.P
+.B \%OPEN_TREE_CLONE
+can be combined with
+.B \%AT_RECURSIVE
+to create recursive detached bind-mount mount objects,
+which in turn can be attached to mount points
+to create recursive bind-mounts.
+.P
+.in +4n
+.EX
+int srcfd = open_tree(AT_FDCWD, "/var", OPEN_TREE_CLONE | AT_RECURSIVE);
+move_mount(srcfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
+.EE
+.in
+.P
+The above procedure is functionally equivalent to
+the following mount operation using
+.BR mount (2):
+.P
+.in +4n
+.EX
+mount("/var", "/mnt", NULL, MS_BIND | MS_REC, NULL);
+.EE
+.in
+.P
+One of the primary benefits of using
+.BR open_tree ()
+and
+.BR move_mount (2)
+over the traditional
+.BR mount (2)
+is that operating with
+.IR dirfd -style
+file descriptors is far easier and more intuitive.
+.P
+.in +4n
+.EX
+int srcfd = open_tree(100, "", AT_EMPTY_PATH | OPEN_TREE_CLONE);
+move_mount(srcfd, "", 200, "foo", MOVE_MOUNT_F_EMPTY_PATH);
+.EE
+.in
+.P
+The above procedure is roughly equivalent to
+the following mount operation using
+.BR mount (2):
+.P
+.in +4n
+.EX
+mount("/proc/self/fd/100", "/proc/self/fd/200/foo", NULL, MS_BIND, NULL);
+.EE
+.in
+.P
+In addition, you can use the file descriptor returned by
+.BR open_tree ()
+as the
+.I dirfd
+argument to any "*at()" system calls:
+.P
+.in +4n
+.EX
+int dirfd, fd;
+\&
+dirfd = open_tree(AT_FDCWD, "/etc", OPEN_TREE_CLONE);
+fd = openat(dirfd, "passwd", O_RDONLY);
+fchmodat(dirfd, "shadow", 0000, 0);
+close(dirfd);
+close(fd);
+/* The bind-mount is now destroyed. */
+.EE
+.in
+.SH SEE ALSO
+.BR fsconfig (2),
+.BR fsmount (2),
+.BR fsopen (2),
+.BR fspick (2),
+.BR mount (2),
+.BR mount_setattr (2),
+.BR move_mount (2),
+.BR mount_namespaces (7)

-- 
2.50.1


