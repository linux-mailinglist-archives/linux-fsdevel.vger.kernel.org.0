Return-Path: <linux-fsdevel+bounces-56864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94453B1CB4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4B318C5018
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48372BCF6C;
	Wed,  6 Aug 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="HhyqPcca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8394329E118;
	Wed,  6 Aug 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502327; cv=none; b=EVfLT9uxKtFg0qRCQGkEzRmpdxEu2wCjnD/gYwzaiVtJDLhyAuBed/p4hu5ZLmfXgPLVDiimzZKlacRldThtAFIalvcrwuP8dnQMNOoH8hp+3fMA6I0G9w9i008NSEPievOykMrmOAG2fEwXotWnmgPmruLEUv86jUm6Fq7XVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502327; c=relaxed/simple;
	bh=8V5517SfnGC9fh/OccXaDL7CQ7+9CNxdK3JGUA8FL2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bO0+1JDSffCY9iVnC1Q8P1nuvc5CfKludnndQ4h5d626Ow7Tj3YhX9NikiMuhdWxcjFt5VSlmDuhhFS06aaYsjvmkJfCGzjSczbnq/ltY5QhlCO9yYJofS7l/XERUONbRbv7P5omKTvhSQ6Y0Dk8Js10gvcRRzP1YEyu701Ht+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=HhyqPcca; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bxyPC2Srhz9ssJ;
	Wed,  6 Aug 2025 19:45:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754502319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxruyvtEGOEMkNqH0my5XkmE1kqlEqYsLOif0ZsJwuc=;
	b=HhyqPccaikb6aqP9MUVNglo3Ws7krVK9k2+aGH8qUVjq3yqGjgUytA3F+RJIgkT1NRqiX9
	2Rq2KnNvz/CTuA9CXcv+59aWTsK1nJvohisxBbtCNUS6DTV7FPaTFAXuMl+/Z0AgIQcbI+
	jjyysEl/+v7/fZV19fyX3xRAKtYtUArVdpN34TfZI0h3z03wZGWtSgQGMgan33kZnW4YKh
	vj02Ums/7+Rvjmn+SSQfEOz2rLYEwtk+w0RQZ5hr+rtNZG6QrrQxEPyoqNagetN/TAtH61
	3siGD/dgHPdFi1vKcmFTSGVByo+BBEaYjHn2DTE68jXYcEAnoAmhHVRhcG9faA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 07 Aug 2025 03:44:39 +1000
Subject: [PATCH v2 05/11] fsconfig.2: document 'new' mount api
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-new-mount-api-v2-5-558a27b8068c@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15498; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=8V5517SfnGC9fh/OccXaDL7CQ7+9CNxdK3JGUA8FL2w=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMntLWwBr60k74B9uvwytm2jxoK760RPKO+AOhZC2HL
 6fLbl3e1VHKwiDGxSArpsiyzc8zdNP8xVeSP61kg5nDygQyhIGLUwAmYtPFyPAstX4pj8mKl4zH
 69asLOzmSVh5gqtJ7cyqG/Iv67JZmuoZ/kcmtyzgP5MZb197b0H0/4RqjwlXd3E+sTAwfrxH+d9
 caTYA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bxyPC2Srhz9ssJ

This is loosely based on the original documentation written by David
Howells and later maintained by Christian Brauner, but has been
rewritten to be more from a user perspective (as well as fixing a few
critical mistakes).

Co-developed-by: David Howells <dhowells@redhat.com>
Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/fsconfig.2 | 559 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 559 insertions(+)

diff --git a/man/man2/fsconfig.2 b/man/man2/fsconfig.2
new file mode 100644
index 000000000000..e2121b7a6b68
--- /dev/null
+++ b/man/man2/fsconfig.2
@@ -0,0 +1,559 @@
+.\" Copyright, the authors of the Linux man-pages project
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH fsconfig 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+fsconfig \- configure new or existing filesystem context
+.SH LIBRARY
+Standard C library
+.RI ( libc ,\~ \-lc )
+.SH SYNOPSIS
+.nf
+.BR "#include <sys/mount.h>"
+.P
+.BI "int fsconfig(int " fd ", unsigned int " cmd ","
+.BI "             const char *" key ", const void *" value ", int " aux ");"
+.fi
+.SH DESCRIPTION
+The
+.BR fsconfig ()
+system call is part of the suite of file descriptor based mount facilities
+in Linux.
+.P
+.BR fsconfig ()
+is used to supply parameters to
+and issue commands against
+the filesystem configuration context
+associated with the file descriptor
+.IR fd .
+Filesystem configuration contexts can be created with
+.BR fsopen (2)
+or instantiated from an extant filesystem instance with
+.BR fspick (2).
+.P
+The
+.I cmd
+argument indicates the command to be issued.
+Some commands supply parameters to the context
+(equivalent to mount options specified with
+.BR mount (8)),
+while others are meta-operations on the filesystem context.
+The list of valid
+.I cmd
+values are:
+.RS
+.TP
+.B FSCONFIG_SET_FLAG
+Set the flag parameter named by
+.IR key .
+.I value
+must be NULL,
+and
+.I aux
+must be 0.
+.TP
+.B FSCONFIG_SET_STRING
+Set the string parameter named by
+.I key
+to the value specified by
+.IR value .
+.I value
+points to a null-terminated string,
+and
+.I aux
+must be 0.
+.TP
+.B FSCONFIG_SET_BINARY
+Set the blob parameter named by
+.I key
+to the contents of the binary blob
+specified by
+.IR value .
+.I value
+points to
+the start of a buffer
+that is
+.I aux
+bytes in length.
+.TP
+.B FSCONFIG_SET_FD
+Set the file parameter named by
+.I key
+to the file referenced by the file descriptor
+.IR aux .
+.I value
+must be NULL.
+.IP
+You may also use
+.B \%FSCONFIG_SET_STRING
+for file parameters,
+with
+.I value
+set to a null-terminated string
+containing a base-10 representation
+of the file descriptor number.
+This mechanism is primarily intended for compatibility with older
+.BR mount (2)-based
+programs.
+.TP
+.B FSCONFIG_SET_PATH
+Set the path parameter named by
+.I key
+to the object at a provided path,
+resolved in a similar manner to
+.BR openat (2).
+.I value
+points to a null-terminated pathname string,
+and
+.I aux
+is equivalent to the
+.I dirfd
+argument to
+.BR openat (2).
+.IP
+You may also use
+.B \%FSCONFIG_SET_STRING
+for path parameters,
+the behaviour of which is equivalent to
+.B \%FSCONFIG_SET_PATH
+with
+.I aux
+set to
+.BR AT_FDCWD .
+.TP
+.B FSCONFIG_SET_PATH_EMPTY
+As with
+.BR \%FSCONFIG_SET_PATH ,
+except that if
+.I value
+is an empty string,
+the file descriptor specified by
+.I aux
+may be any type of file
+(not just a directory)
+and will be used as the path parameter value,
+equivalent to the behaviour of
+.B \%AT_EMPTY_PATH
+with most "*at()" system calls.
+If
+.I aux
+is
+.BR AT_FDCWD ,
+the call operates on the current working directory
+of the calling process.
+.IP
+Note that this behaviour with empty paths is distinct in some subtle ways to
+.BR \%FSCONFIG_SET_FD .
+.B \%FSCONFIG_SET_FD
+indicates that the underlying file
+for the file descriptor
+.I aux
+should be used as the parameter value directly;
+.B \%FSCONFIG_SET_PATH_EMPTY
+indicates that the underlying file
+for the file descriptor
+.I aux
+should be re-opened by the filesystem driver,
+and the newly created file description
+should be used as the parameter value.
+This can result in slightly different behaviour
+when dealing with special files
+or files sourced from pseudofilesystems.
+Filesystems may also choose to only support one kind of parameter,
+and so a parameter that accepts
+.B FSCONFIG_SET_FD
+may not work with
+.BR FSCONFIG_SET_PATH ( _EMPTY )
+(or vice-versa).
+.TP
+.B FSCONFIG_CMD_CREATE
+This command instructs the filesystem driver
+to instantiate an instance of the filesystem in the kernel
+with the parameters set in the filesystem configuration context
+referenced by the file descriptor
+.IR fd .
+.IR key " and " value
+must be NULL,
+and
+.I aux
+must be 0.
+.IP
+If this operation succeeds,
+the filesystem context
+associated with file descriptor
+.I fd
+now references the created filesystem instance,
+and is placed into a special "needs-mount" mode
+that allows you to use
+.BR fsmount (2)
+to create a mount object from the filesystem instance.
+.IP
+This is intended for use with filesystem configuration contexts created with
+.BR fsopen (2).
+In order to create a filesystem instance,
+the calling process must have the
+.B \%CAP_SYS_ADMIN
+capability.
+.IP
+Note that the Linux kernel reuses filesystem instances
+for many filesystems,
+so (depending on the filesystem being configured and parameters used)
+it is possible for the filesystem instance "created" by
+.B \%FSCONFIG_CMD_CREATE
+to, in fact, be a reference
+to an existing filesystem instance in the kernel.
+The kernel will attempt to merge the specified parameters
+of this filesystem configuration context
+with those of the filesystem instance being reused,
+but some parameters may be
+.IR "silently ignored" .
+.IP
+Programs that need to ensure
+that they create a new filesystem instance
+with specific parameters
+(notably, security-related parameters such as "acl" to enable
+POSIX ACLs as described in
+.BR acl (5))
+should use
+.B \%FSCONFIG_CMD_CREATE_EXCL
+instead.
+.TP
+.BR FSCONFIG_CMD_CREATE_EXCL " (since Linux 6.6)"
+.\" commit 22ed7ecdaefe0cac0c6e6295e83048af60435b13
+As with
+.BR \%FSCONFIG_CMD_CREATE ,
+except that the kernel is instructed
+to create a new filesystem instance
+("superblock" in kernel developer parlance)
+rather than reusing an existing one.
+.IP
+If this is not possible
+(such as with disk-backed filesystems
+where multiple filesystem instances
+using the same filesystem driver
+and writing to the same underlying device
+could result in data corruption),
+this operation will incur
+an
+.B EBUSY
+error.
+.IP
+As a result (unlike
+.BR \%FSCONFIG_CMD_CREATE ),
+if this command succeeds
+then the calling process can be sure that
+all of the parameters successfully configured with
+.BR fsconfig ()
+will actually be applied
+to the created filesystem instance.
+.TP
+.B FSCONFIG_CMD_RECONFIGURE
+This command instructs the filesystem driver
+to apply the parameters set in this filesystem configuration context
+to an already existing filesystem instance.
+.IP
+This is primarily intended for use with
+.BR fspick (2),
+but may also be used to modify the parameters of filesystem instance after
+.BR \%FSCONFIG_CMD_CREATE
+was used to create it
+and a mount object was created using
+.BR fsmount (2).
+In order to reconfigure an extant filesystem instance,
+the calling process must have the
+.B CAP_SYS_ADMIN
+capability.
+.IP
+Once this operation succeeds, the filesystem context is reset
+but remains in reconfiguration mode
+and thus can be used for subsequent
+.B \%FSCONFIG_CMD_RECONFIGURE
+commands.
+.SH RETURN VALUE
+On success,
+.BR fsconfig ()
+returns 0.
+On error, \-1 is returned, and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+If an error occurs, the filesystem driver may provide
+additional information about the error
+through the message retrieval interface for filesystem configuration contexts.
+This additional information can be retrieved at any time by calling
+.BR read (2)
+on the filesystem instance or filesystem configuration context referenced by
+the file descriptor
+.IR fd .
+(See the "Message retrieval interface" subsection in
+.BR fsopen (2)
+for more details on the message format.)
+.P
+Even after an error occurs,
+the filesystem configuration context is
+.I not
+invalidated,
+and thus can still be used with other
+.BR fsconfig ()
+commands.
+This means that users can probe support for mount parameters
+on a per-parameter basis,
+and adjust which parameters they wish to set.
+.P
+The error values given below result from filesystem type independent errors.
+Each filesystem type may have its own special errors
+and its own special behavior.
+See the Linux kernel source code for details.
+.TP
+.B EACCES
+A component of a path
+provided as a path parameter
+was not searchable.
+(See also
+.BR path_resolution (7).)
+.TP
+.B EACCES
+.B \%FSCONFIG_CMD_CREATE
+was attempted
+for a read-only filesystem
+without specifying the
+.RB ' ro '
+flag parameter.
+.TP
+.B EACCES
+A specified block device parameter
+is located on a filesystem
+mounted with the
+.B \%MS_NODEV
+option.
+.TP
+.B EBADF
+The file descriptor given by
+.I fd
+(or possibly by
+.IR aux ,
+depending on the command)
+is invalid.
+.TP
+.B EBUSY
+The filesystem context attached to
+.I fd
+is in the wrong state
+for the given command.
+.TP
+.B EBUSY
+The filesystem instance cannot be reconfigured as read-only
+with
+.B \%FSCONFIG_CMD_RECONFIGURE
+because some programs
+still hold files open for writing.
+.TP
+.B EBUSY
+A new filesystem instance was requested with
+.B \%FSCONFIG_CMD_CREATE_EXCL
+but a matching superblock already existed.
+.TP
+.B EFAULT
+One of the pointer arguments
+points to a location
+outside the calling process's accessible address space.
+.TP
+.B EINVAL
+.I fd
+does not refer to
+a filesystem configuration context
+or filesystem instance.
+.TP
+.B EINVAL
+One of the values of
+.IR name ,
+.IR value ,
+and/or
+.I aux
+were set to a non-zero value when
+.I cmd
+required that they be zero
+(or NULL).
+.TP
+.B EINVAL
+The parameter named by
+.I name
+cannot be set
+using the type specified with
+.IR cmd .
+.TP
+.B EINVAL
+One of the source parameters
+referred to
+an invalid superblock.
+.TP
+.B ELOOP
+Too many links encountered
+during pathname resolution
+of a path argument.
+.TP
+.B ENAMETOOLONG
+A path argument was longer than
+.BR PATH_MAX .
+.TP
+.B ENOENT
+A path argument had a non-existent component.
+.TP
+.B ENOENT
+A path argument is an empty string,
+but
+.I cmd
+is not
+.BR \%FSCONFIG_SET_PATH_EMPTY .
+.TP
+.B ENOMEM
+The kernel could not allocate sufficient memory to complete the operation.
+.TP
+.B ENOTBLK
+The parameter named by
+.I name
+must be a block device,
+but the provided parameter value was not a block device.
+.TP
+.B ENOTDIR
+A component of the path prefix
+of a path argument
+was not a directory.
+.TP
+.B EOPNOTSUPP
+The command given by
+.I cmd
+is not valid.
+.TP
+.B ENXIO
+The major number
+of a block device parameter
+is out of range.
+.TP
+.B EPERM
+The command given by
+.I cmd
+was
+.BR \%FSCONFIG_CMD_CREATE ,
+.BR \%FSCONFIG_CMD_CREATE_EXCL ,
+or
+.BR \% FSCONFIG_CMD_RECONFIGURE ,
+but the calling process does not have the required
+.B \%CAP_SYS_ADMIN
+capability.
+.SH STANDARDS
+Linux.
+.SH HISTORY
+Linux 5.2.
+.\" commit ecdab150fddb42fe6a739335257949220033b782
+glibc 2.36.
+.SH EXAMPLES
+To illustrate the different kinds of flags that can be configured with
+.BR fsconfig (),
+here are a few examples of some different filesystems being created:
+.P
+.in +4n
+.EX
+int fsfd, mntfd;
+\&
+fsfd = fsopen("tmpfs", FSOPEN_CLOEXEC);
+fsconfig(fsfd, FSCONFIG_SET_FLAG, "inode64", NULL, 0);
+fsconfig(fsfd, FSCONFIG_SET_STRING, "uid", "1234", 0);
+fsconfig(fsfd, FSCONFIG_SET_STRING, "huge", "never", 0);
+fsconfig(fsfd, FSCONFIG_SET_FLAG, "casefold", NULL, 0);
+fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_NOEXEC);
+move_mount(mntfd, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH);
+\&
+fsfd = fsopen("erofs", FSOPEN_CLOEXEC);
+fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "/dev/loop0", 0);
+fsconfig(fsfd, FSCONFIG_SET_FLAG, "acl", NULL, 0);
+fsconfig(fsfd, FSCONFIG_SET_FLAG, "user_xattr", NULL, 0);
+fsconfig(fsfd, FSCONFIG_CMD_CREATE_EXCL, NULL, NULL, 0);
+mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_NOSUID);
+move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
+.EE
+.in
+.P
+Some filesystems have different behaviour
+when using
+.BR fsconfig ()
+to set the same parameter
+named by
+.I key
+multiple times:
+.P
+.in +4n
+.EX
+\&
+int fsfd, mntfd, lowerdirfd;
+\&
+lowerdirfd = open("/o/ctr/lower1", O_DIRECTORY | O_CLOEXEC);
+fsfd = fsopen("overlay", FSOPEN_CLOEXEC);
+/* "lowerdir+" appends to the lower dir stack */
+fsconfig(fsfd, FSCONFIG_SET_FD, "lowerdir+", NULL, lowerdirfd);
+fsconfig(fsfd, FSCONFIG_SET_STRING, "lowerdir+", "/o/ctr/lower2", 0);
+.\" fsconfig(fsfd, FSCONFIG_SET_PATH, "lowerdir+", "/o/ctr/lower3", AT_FDCWD);
+.\" fsconfig(fsfd, FSCONFIG_SET_PATH_EMPTY, "lowerdir+", "", lowerdirfd);
+fsconfig(fsfd, FSCONFIG_SET_STRING, "xino", "auto", 0);
+fsconfig(fsfd, FSCONFIG_SET_STRING, "nfs_export", "off", 0);
+fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
+.EE
+.in
+.P
+Other filesystems allow you to use different
+.BI FSCONFIG_SET_ *
+commands for the same parameter
+named by
+.IR key :
+.P
+.in +4n
+.EX
+\&
+int fsfd, mntfd, nsfd, nsdirfd;
+\&
+nsfd = open("/proc/self/ns/pid", O_PATH);
+nsdirfd = open("/proc/1/ns", O_DIRECTORY);
+\&
+fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+/* "pidns" changes the value each time. */
+fsconfig(fsfd, FSCONFIG_SET_PATH, "pidns", "/proc/self/ns/pid", AT_FDCWD);
+fsconfig(fsfd, FSCONFIG_SET_PATH, "pidns", "pid", NULL, nsdirfd);
+fsconfig(fsfd, FSCONFIG_SET_PATH_EMPTY, "pidns", "", nsfd);
+fsconfig(fsfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
+fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+move_mount(mntfd, "", AT_FDCWD, "/proc", MOVE_MOUNT_F_EMPTY_PATH);
+.EE
+.in
+.P
+And here is an example of how
+.BR fspick (2)
+can be used with
+.BR fsconfig ()
+to reconfigure the parameters
+of an extant filesystem instance
+attached to
+.IR /proc :
+.P
+.in +4n
+.EX
+int fsfd = fspick(AT_FDCWD, "/proc", FSPICK_CLOEXEC);
+fsconfig(fsfd, FSCONFIG_SET_STRING, "hidepid", "ptraceable", 0);
+fsconfig(fsfd, FSCONFIG_SET_STRING, "subset", "pid", 0);
+fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);
+.EE
+.in
+.SH SEE ALSO
+.BR fsmount (2),
+.BR fsopen (2),
+.BR fspick (2),
+.BR mount (2),
+.BR mount_setattr (2),
+.BR move_mount (2),
+.BR open_tree (2),
+.BR mount_namespaces (7)
+

-- 
2.50.1


