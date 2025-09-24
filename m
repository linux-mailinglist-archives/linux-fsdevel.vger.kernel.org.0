Return-Path: <linux-fsdevel+bounces-62602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05AAB9AAD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F91164879
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955F43115BB;
	Wed, 24 Sep 2025 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="EPw6+pO1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C71530BBA1;
	Wed, 24 Sep 2025 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727930; cv=none; b=j8MzaODR9hllw/fkkgTGC7IhbVQlmnHRRPGj66BZ1ogdAQhRIlDochUiWjQGcY2VIJ7VllHL2pWy3BU8nhQVc9r5on35ALdeArgVtxyS4Ye+Cuc6f8GoF5EBXPyh87EUgObJbgNElnfreqNAUX5YKdJx++WOrWSDrWArAGi00Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727930; c=relaxed/simple;
	bh=k9cHeEix8A3JLB6qcHM/CwFWw4AO5MexTEadFAgcixU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BRYfzuEDI3ODr6FScpJNVghZBAlDtzJLNNWbzaJwVUAr0Iyi0ILFyiq+rxjteHSDrBp/not7t0Wo7A29uXNdaEz/RwZ4Pna4GqILCslnIX4/2l/Nclm7jsxPsUszpPrQ9NynEXOKV1rBWnpASCC+ccO+3aXBiOYSCgvXYun5qZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=EPw6+pO1; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cX16r6Bxtz9tV9;
	Wed, 24 Sep 2025 17:32:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758727924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0Gp1o7v3xihQTHcLuuyiFt1h+NYrCI22NIp8uL/H/c=;
	b=EPw6+pO1K3d63oT9I7MtvrLuYYXcngSwVU4xUV0bhiTB3NEcTn3b6hmhBKga6aeof6FMlI
	QcX+QJB8Y+2Z9xyQl0hbEYl2qjqtNAMU2M4hBcDZSD79ZKPZbF5kohWlCKBkE5vZyMj5f0
	b25BBo7fsVRvJ7KvtHoj6mwlgeowGZY3gsw4k7uuCR7Y8hQA3+TvS5VfP37TvN1GxKrpBc
	kXxOUQ3agAOu5/7yHGhA5fI0SvPENvo8BHGFuNKnU/c0TAROK0EySdHkm93FGpKD6DlY0B
	galsFUzygn4RO+6EDxFymDbLIiU8CeBm4g+S8vZa4EISc/XAvk/XhEkhdSpAvw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 25 Sep 2025 01:31:24 +1000
Subject: [PATCH v5 2/8] man/man2/fspick.2: document "new" mount API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-new-mount-api-v5-2-028fb88023f2@cyphar.com>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
In-Reply-To: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8505; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=k9cHeEix8A3JLB6qcHM/CwFWw4AO5MexTEadFAgcixU=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRc4bvrPOOVZWWR5LlPDgeWPz71eN5yL/7WrMlu8RkPX
 8aVtK283jGRhUGMi8FSTJFlm59n6Kb5i68kf1rJBjOHlQlkiLRIAwMDAwMLA19uYl6pkY6Rnqm2
 oZ6hoY6RjhEDF6cAXLUrw//A8w31B5iCDvBPv79xf7HPmYAVq5nmNVVf8//f9MLDnimekeFTVX2
 1qcvx/IU2O4N2eESvcX1rfG7Hb1upN5xHHy0/78cBAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4cX16r6Bxtz9tV9

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
 man/man2/fspick.2 | 343 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 343 insertions(+)

diff --git a/man/man2/fspick.2 b/man/man2/fspick.2
new file mode 100644
index 0000000000000000000000000000000000000000..800aed81d38384be4563f2558e3cef846d7e7cee
--- /dev/null
+++ b/man/man2/fspick.2
@@ -0,0 +1,343 @@
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
+the suite of file-descriptor-based mount facilities in Linux.
+.P
+.BR fspick ()
+creates a new filesystem configuration context
+for the extant filesystem instance
+associated with the path described by
+.I dirfd
+and
+.IR path ,
+places it into reconfiguration mode
+(similar to
+.BR mount (8)
+with the
+.I \-o\~remount
+option).
+A new file descriptor
+associated with the filesystem configuration context
+is then returned.
+The calling process must have the
+.B \%CAP_SYS_ADMIN
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
+In contrast to
+the behaviour of
+.B MS_REMOUNT
+with
+.BR mount (2),
+.BR fspick ()
+instantiates the filesystem configuration context
+with a copy of
+the extant filesystem's filesystem parameters;
+thus,
+subsequent
+.B \%FSCONFIG_CMD_RECONFIGURE
+operations
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
+Do not automount the terminal ("basename") component of
+.I path
+if it is a directory that is an automount point.
+This allows you to reconfigure an automount point,
+rather than the location that would be mounted.
+This flag has no effect
+if the automount point has already been mounted over.
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
+.B MS_DIRSYNC
+or
+.BR MS_SYNCHRONOUS );
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

-- 
2.51.0


