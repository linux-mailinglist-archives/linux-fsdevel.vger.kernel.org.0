Return-Path: <linux-fsdevel+bounces-62188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B58CB87A8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 04:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7634E7B1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 02:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEE5264A86;
	Fri, 19 Sep 2025 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="RJoiOuWF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2471F790F;
	Fri, 19 Sep 2025 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247225; cv=none; b=UVzIoMWiNv76S4rY/NkmybUtLcQgXhwjL3Iy6FK35jQgJOS+7Ii1ENI1HVHqCjK8B6yo6JHFd0sZx5orUGzG4DkeRosOqSX3o32ZX4LEGVHjmTMp2Vhzn2LJ+UE8+RGMZWCztnZ7xppY5rLnuvt93AVNMf759VNgKD80ESBUGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247225; c=relaxed/simple;
	bh=3JkEZK4xBrti4iIyGstioYHI62898EiUb7TklcJ8L+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epQgjzSCYaa2l+HV7wjS38fdMdzo3YZTDzuIcbUM+QUPYe8DMZomgMXUtGsXyt0xxrXMVfBIZdxJdsaZrkMSJ1aWxRY2op9Hk46u26AvgjPVEgOwiWF0TnX/ueRxeMisEKpPl6XlYQuH70lBpmX5pq8r2lwtzRSJQLF9rUHtmt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=RJoiOuWF; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cSbLW0VwWz9tWx;
	Fri, 19 Sep 2025 04:00:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758247219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTOnNWLTLMrr3vBPQIh0rPBkBIi8RXn0VGLT3s/grSU=;
	b=RJoiOuWFYXBVueVlyBFunudQwfKpaZBg1Q4N/z6/FU7ji/wS/pA9x4wK4cuZVVyXEZcTvF
	BNPIY0nBcgn5mzJJWaMwvpoXsZhpmMVx0siv7fn+rlDior+QXVVrDOSbzKcHIhKMphTqTG
	lfHBDisDlHGTWM7nK0ZE03gZWB/OCEArFne3y22VUuEOpL70vZLwbigsn+1m7EmRBTLEyQ
	ZWPJ5zijgloFHvd7c8WFwMj4409e+E+evv9WT9EC4WtIqzoOZfhISpk/zpjKwa1E4bxZrr
	I8dXQsFDAsdD5YqrLH3ITkZSLcr12BrhyLgMb12ffaIR7TLuUhEjvKM+90EPKw==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 19 Sep 2025 11:59:44 +1000
Subject: [PATCH v4 03/10] man/man2/fspick.2: document "new" mount API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-new-mount-api-v4-3-1261201ab562@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8488; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=3JkEZK4xBrti4iIyGstioYHI62898EiUb7TklcJ8L+4=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSc2SkaH3/Gq8JacF+S5o2jnZIeW55XKT72/6R5oCg19
 0bC3/0NHRNZGMS4GCzFFFm2+XmGbpq/+Eryp5VsMHNYmUCGSIs0MDAwMLAw8OUm5pUa6RjpmWob
 6hka6hjpGDFwcQrAVG9PZWSYa2r5tfu0pPO21ikLLjsssZunON0v0PqXZLlQxYv49cVdjAw7HDb
 2BtwNLkvRvt1TyWtXaib6ZOoOvUmsH2f99Y909mUHAA==
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
 man/man2/fspick.2 | 342 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 342 insertions(+)

diff --git a/man/man2/fspick.2 b/man/man2/fspick.2
new file mode 100644
index 0000000000000000000000000000000000000000..1f87293f44658adeb7ab7cffebcac3174888f040
--- /dev/null
+++ b/man/man2/fspick.2
@@ -0,0 +1,342 @@
+.\" Copyright, the authors of the Linux man-pages project
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH fspick 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+fspick \- select filesystem for reconfiguration
+.SH LIBRARY
+Standard C library
+.RI ( libc ,\~ \-lc )
+.SH SYNOPSIS
+.nf
+.BR "#include <fcntl.h>" "          /* Definition of " AT_* " constants */"
+.B #include <sys/mount.h>
+.P
+.BI "int fspick(int " dirfd ", const char *" path ", unsigned int " flags );
+.fi
+.SH DESCRIPTION
+The
+.BR fspick ()
+system call is part of
+the suite of file descriptor based mount facilities in Linux.
+.P
+.BR fspick()
+creates a new filesystem configuration context
+for the extant filesystem instance
+associated with the path described by
+.IR dirfd
+and
+.IR path ,
+places it into reconfiguration mode
+(similar to
+.BR mount (8)
+with the
+.I -o remount
+option).
+A new file descriptor
+associated with the filesystem configuration context
+is then returned.
+The calling process must have the
+.BR CAP_SYS_ADMIN
+capability in order to create a new filesystem configuration context.
+.P
+The resultant file descriptor can be used with
+.BR fsconfig (2)
+to specify the desired set of changes to
+filesystem parameters of the filesystem instance.
+Once the desired set of changes have been configured,
+the changes can be effectuated by calling
+.BR fsconfig (2)
+with the
+.B \%FSCONFIG_CMD_RECONFIGURE
+command.
+Please note that\[em]in contrast to
+the behaviour of
+.B MS_REMOUNT
+with
+.BR mount (2)\[em] fspick ()
+instantiates the filesystem configuration context
+with a copy of
+the extant filesystem's filesystem parameters,
+meaning that a subsequent
+.B \%FSCONFIG_CMD_RECONFIGURE
+operation
+will only update filesystem parameters
+explicitly modified with
+.BR fsconfig (2).
+.P
+As with "*at()" system calls,
+.BR fspick ()
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
+.BR \%FSPICK_EMPTY_PATH ,
+then the file descriptor
+.I dirfd
+is operated on directly.
+In this case,
+.I dirfd
+may refer to any type of file,
+not just a directory.
+.P
+See
+.BR openat (2)
+for an explanation of why the
+.I dirfd
+argument is useful.
+.P
+.I flags
+can be used to control aspects of how
+.I path
+is resolved and
+properties of the returned file descriptor.
+A value for
+.I flags
+is constructed by bitwise ORing
+zero or more of the following constants:
+.RS
+.TP
+.B FSPICK_CLOEXEC
+Set the close-on-exec
+.RB ( FD_CLOEXEC )
+flag on the new file descriptor.
+See the description of the
+.B O_CLOEXEC
+flag in
+.BR open (2)
+for reasons why this may be useful.
+.TP
+.B FSPICK_EMPTY_PATH
+If
+.I path
+is an empty string,
+operate on the file referred to by
+.I dirfd
+(which may have been obtained from
+.BR open (2),
+.BR fsmount (2),
+or
+.BR open_tree (2)).
+In this case,
+.I dirfd
+may refer to any type of file,
+not just a directory.
+If
+.I dirfd
+is
+.BR \%AT_FDCWD ,
+.BR fspick ()
+will operate on the current working directory
+of the calling process.
+.TP
+.B FSPICK_SYMLINK_NOFOLLOW
+Do not follow symbolic links
+in the terminal component of
+.IR path .
+If
+.I path
+references a symbolic link,
+the returned filesystem context will reference
+the filesystem that the symbolic link itself resides on.
+.TP
+.B FSPICK_NO_AUTOMOUNT
+Do not automount any automount points encountered
+while resolving
+.IR path .
+This allows you to reconfigure an automount point,
+rather than the location that would be mounted.
+This flag has no effect if
+the automount point has already been mounted over.
+.RE
+.P
+As with filesystem contexts created with
+.BR fsopen (2),
+the file descriptor returned by
+.BR fspick ()
+may be queried for message strings at any time by calling
+.BR read (2)
+on the file descriptor.
+(See the "Message retrieval interface" subsection in
+.BR fsopen (2)
+for more details on the message format.)
+.SH RETURN VALUE
+On success, a new file descriptor is returned.
+On error, \-1 is returned, and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+.TP
+.B EACCES
+Search permission is denied
+for one of the directories
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
+does not exist,
+or is a dangling symbolic link.
+.TP
+.B ENOENT
+.I path
+is an empty string, but
+.B \%FSPICK_EMPTY_PATH
+is not specified in
+.IR flags .
+.TP
+.B ENOTDIR
+A component of the path prefix of
+.I path
+is not a directory;
+or
+.I path
+is relative and
+.I dirfd
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
+.\" commit cf3cba4a429be43e5527a3f78859b1bfd9ebc5fb
+.\" commit 400913252d09f9cfb8cce33daee43167921fc343
+glibc 2.36.
+.SH EXAMPLES
+The following example sets the read-only flag
+on the filesystem instance referenced by
+the mount object attached at
+.IR /tmp .
+.P
+.in +4n
+.EX
+int fsfd = fspick(AT_FDCWD, "/tmp", FSPICK_CLOEXEC);
+fsconfig(fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
+fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);
+.EE
+.in
+.P
+The above procedure is roughly equivalent to
+the following mount operation using
+.BR mount (2):
+.P
+.in +4n
+.EX
+mount(NULL, "/tmp", NULL, MS_REMOUNT | MS_RDONLY, NULL);
+.EE
+.in
+.P
+With the notable caveat that
+in this example,
+.BR mount (2)
+will clear all other filesystem parameters
+(such as
+.B MS_NOSUID
+or
+.BR MS_NOEXEC );
+.BR fsconfig (2)
+will only modify the
+.I ro
+parameter.
+.SH SEE ALSO
+.BR fsconfig (2),
+.BR fsmount (2),
+.BR fsopen (2),
+.BR mount (2),
+.BR mount_setattr (2),
+.BR move_mount (2),
+.BR open_tree (2),
+.BR mount_namespaces (7)
+

-- 
2.51.0


