Return-Path: <linux-fsdevel+bounces-62187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F6FB87A83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 04:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F9B4E70C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 02:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8011626056E;
	Fri, 19 Sep 2025 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="AYpNDpOU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84C25DCF0;
	Fri, 19 Sep 2025 02:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247219; cv=none; b=fp7WSXX/uuAc5T6OoVONcm7vf+xOSssFbt04g9xjzKaJS8+TRCq0D61YbNo4nwCUYQhE8OpMqj+6ogaWpj4ZRr0dWLgbTr1jIVMVxebQonwSYrL2QG77GJP12ogHZw4LXbf1eHAZ5MAkHtsLbVTAAbGx0aYxu9kqiMDEZ2Ybs7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247219; c=relaxed/simple;
	bh=Qt9JJwP7Po2UlxNm12cpyXuleZSZg10i2LGinn40v9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BDSYXEk6UkmDXJPYghPQbPHduTXAhAorlm0yO/IRHfQuidAggxUH1EU/H2QHyevJh4L8CHDBryJQbq+miayT0y/a2IKRV0SgWQ1AfGYCdikhbW6XH5hULi1WLZBuGwVbt77iLxWkMACqOr1PZ7t/v96x2mTOO0fMRpVsN4Xmzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=AYpNDpOU; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cSbLP5PJxz9sqC;
	Fri, 19 Sep 2025 04:00:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758247213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bnl6p0PV1/r3ERamNk0D3Pkl7+jfK7FLKiG+ClsUZ+I=;
	b=AYpNDpOU1VhAKbdl5Jldh4A7kYmTdetzDtGhE/fQrK6OAmYG4DXmf0DaFGX2cZBoZEuMtG
	HgX0b0wLr8rpgSnhGyRyVkC73pNsISdX2L5WfQdD/H6pMI3MuHDwumTkQwCgWHVlzLrdHO
	MIBoUEZvqoh9J+1ZQZDLR75MhXEBRP17W5NaVtsKtt43P4eSvHj3MoEo23rUSzoonWP1AE
	HNagD4oWSkez6JPlHNSqguH3p4ow6j4GCU0X6Uk0ryJKkWcPIXrZQCaGmMGR7omeSwYcpB
	LtYC664A8wQdZ269uJETwiaB3T3FM1R3fyKjDCW8dyvMB9KmrImzqCO9t9fFhg==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 19 Sep 2025 11:59:43 +1000
Subject: [PATCH v4 02/10] man/man2/fsopen.2: document "new" mount API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-new-mount-api-v4-2-1261201ab562@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12327; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=Qt9JJwP7Po2UlxNm12cpyXuleZSZg10i2LGinn40v9o=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSc2Skq0JC5k6vM4d2xn5753At/umr095n2CL6qkNzcJ
 COc7SjcMZGFQYyLwVJMkWWbn2fopvmLryR/WskGM4eVCWSItEgDAwMDAwsDX25iXqmRjpGeqbah
 nqGhjpGOEQMXpwBMdWwjw18Z0Uk7C/+FbfrWL9L85YL7tOfHm+PXy7Rt//hx09Tzp1mXMfz3CEh
 h6ra8r3zMykfZz2WD+PQPS1urfm1/lP6Jz+Z8UTkbAA==
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
 man/man2/fsopen.2 | 384 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 384 insertions(+)

diff --git a/man/man2/fsopen.2 b/man/man2/fsopen.2
new file mode 100644
index 0000000000000000000000000000000000000000..7cdbeac7d64b7e5c969dee619a039ec947d1e981
--- /dev/null
+++ b/man/man2/fsopen.2
@@ -0,0 +1,384 @@
+.\" Copyright, the authors of the Linux man-pages project
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH fsopen 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+fsopen \- create a new filesystem context
+.SH LIBRARY
+Standard C library
+.RI ( libc ,\~ \-lc )
+.SH SYNOPSIS
+.nf
+.B #include <sys/mount.h>
+.P
+.BI "int fsopen(const char *" fsname ", unsigned int " flags );
+.fi
+.SH DESCRIPTION
+The
+.BR fsopen ()
+system call is part of
+the suite of file descriptor based mount facilities in Linux.
+.P
+.BR fsopen ()
+creates a blank filesystem configuration context within the kernel
+for the filesystem named by
+.I fsname
+and places it into creation mode.
+A new file descriptor
+associated with the filesystem configuration context
+is then returned.
+The calling process must have the
+.B \%CAP_SYS_ADMIN
+capability in order to create a new filesystem configuration context.
+.P
+A filesystem configuration context is
+an in-kernel representation of a pending transaction,
+containing a set of configuration parameters that are to be applied
+when creating a new instance of a filesystem
+(or modifying the configuration of an existing filesystem instance,
+such as when using
+.BR fspick (2)).
+.P
+After obtaining a filesystem configuration context with
+.BR fsopen (),
+the general workflow for operating on the context looks like the following:
+.IP (1) 5
+Pass the filesystem context file descriptor to
+.BR fsconfig (2)
+to specify any desired filesystem parameters.
+This may be done as many times as necessary.
+.IP (2)
+Pass the same filesystem context file descriptor to
+.BR fsconfig (2)
+with
+.B \%FSCONFIG_CMD_CREATE
+to create an instance of the configured filesystem.
+.IP (3)
+Pass the same filesystem context file descriptor to
+.BR fsmount (2)
+to create a new detached mount object for
+the root of the filesystem instance,
+which is then attached to a new file descriptor.
+(This also places the filesystem context file descriptor into
+reconfiguration mode,
+similar to the mode produced by
+.BR fspick (2).)
+Once a mount object has been created with
+.BR fsmount (2),
+the filesystem context file descriptor can be safely closed.
+.IP (4)
+Now that a mount object has been created,
+you may
+.RS
+.IP (4.1) 7
+use the detached mount object file descriptor as a
+.I dirfd
+argument to "*at()" system calls; and/or
+.IP (4.2) 7
+attach the mount object to a mount point
+by passing the mount object file descriptor to
+.BR move_mount (2).
+This will also prevent the mount object from
+being unmounted and destroyed when
+the mount object file descriptor is closed.
+.RE
+.IP
+The mount object file descriptor will
+remain associated with the mount object
+even after doing the above operations,
+so you may repeatedly use the mount object file descriptor with
+.BR move_mount (2)
+and/or "*at()" system calls
+as many times as necessary.
+.P
+A filesystem context will move between different modes
+throughout its lifecycle
+(such as the creation phase
+when created with
+.BR fsopen (),
+the reconfiguration phase
+when an existing filesystem instance is selected with
+.BR fspick (2),
+and the intermediate "awaiting-mount" phase
+.\" FS_CONTEXT_AWAITING_MOUNT is the term the kernel uses for this.
+between
+.BR \%FSCONFIG_CMD_CREATE
+and
+.BR fsmount (2)),
+which has an impact on
+what operations are permitted on the filesystem context.
+.P
+The file descriptor returned by
+.BR fsopen ()
+also acts as a channel for filesystem drivers to
+provide more comprehensive diagnostic information
+than is normally provided through the standard
+.BR errno (3)
+interface for system calls.
+If an error occurs at any time during the workflow mentioned above,
+calling
+.BR read (2)
+on the filesystem context file descriptor
+will retrieve any ancillary information about the encountered errors.
+(See the "Message retrieval interface" section
+for more details on the message format.)
+.P
+.I flags
+can be used to control aspects of
+the creation of the filesystem configuration context file descriptor.
+A value for
+.I flags
+is constructed by bitwise ORing
+zero or more of the following constants:
+.RS
+.TP
+.B FSOPEN_CLOEXEC
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
+A list of filesystems supported by the running kernel
+(and thus a list of valid values for
+.IR fsname )
+can be obtained from
+.IR /proc/filesystems .
+(See also
+.BR proc_filesystems (5).)
+.SS Message retrieval interface
+When doing operations on a filesystem configuration context,
+the filesystem driver may choose to provide
+ancillary information to userspace
+in the form of message strings.
+.P
+The filesystem context file descriptors returned by
+.BR fsopen ()
+and
+.BR fspick (2)
+may be queried for message strings at any time by calling
+.BR read (2)
+on the file descriptor.
+Each call to
+.BR read (2)
+will return a single message,
+prefixed to indicate its class:
+.RS
+.TP
+\fBe\fP <\fImessage\fP>
+An error message was logged.
+This is usually associated with an error being returned
+from the corresponding system call which triggered this message.
+.TP
+\fBw\fP <\fImessage\fP>
+A warning message was logged.
+.TP
+\fBi\fP <\fImessage\fP>
+An informational message was logged.
+.RE
+.P
+Messages are removed from the queue as they are read.
+Note that the message queue has limited depth,
+so it is possible for messages to get lost.
+If there are no messages in the message queue,
+.B read(2)
+will return \-1 and
+.I errno
+will be set to
+.BR \%ENODATA .
+If the
+.I buf
+argument to
+.BR read (2)
+is not large enough to contain the entire message,
+.BR read (2)
+will return \-1 and
+.I errno
+will be set to
+.BR \%EMSGSIZE .
+(See BUGS.)
+.P
+If there are multiple filesystem contexts
+referencing the same filesystem instance
+(such as if you call
+.BR fspick (2)
+multiple times for the same mount),
+each one gets its own independent message queue.
+This does not apply to multiple file descriptors that are
+tied to the same underlying open file description
+(such as those created with
+.BR dup (2)).
+.P
+Message strings will usually be prefixed by
+the name of the filesystem or kernel subsystem
+that logged the message,
+though this may not always be the case.
+See the Linux kernel source code for details.
+.SH RETURN VALUE
+On success, a new file descriptor is returned.
+On error, \-1 is returned, and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+.TP
+.B EFAULT
+.I fsname
+is NULL
+or a pointer to a location
+outside the calling process's accessible address space.
+.TP
+.B EINVAL
+.I flags
+had an invalid flag set.
+.TP
+.B EMFILE
+The calling process has too many open files to create more.
+.TP
+.B ENFILE
+The system has too many open files to create more.
+.TP
+.B ENODEV
+The filesystem named by
+.I fsname
+is not supported by the kernel.
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
+.\" commit 24dcb3d90a1f67fe08c68a004af37df059d74005
+.\" commit 400913252d09f9cfb8cce33daee43167921fc343
+glibc 2.36.
+.SH BUGS
+.SS Message retrieval interface and \fB\%EMSGSIZE\fP
+As described in the "Message retrieval interface" subsection above,
+calling
+.BR read (2)
+with too small a buffer to contain
+the next pending message in the message queue
+for the filesystem configuration context
+will cause
+.BR read (2)
+to return \-1 and set
+.BR errno (3)
+to
+.BR \%EMSGSIZE .
+.P
+However,
+this failed operation still
+consumes the message from the message queue.
+This effectively discards the message silently,
+as no data is copied into the
+.BR read (2)
+buffer.
+.P
+Programs should take care to ensure that
+their buffers are sufficiently large
+to contain any reasonable message string,
+in order to avoid silently losing valuable diagnostic information.
+.\" Aleksa Sarai
+.\"   This unfortunate behaviour has existed since this feature was merged, but
+.\"   I have sent a patchset which will finally fix it.
+.\"   <https://lore.kernel.org/r/20250807-fscontext-log-cleanups-v3-1-8d91d6242dc3@cyphar.com/>
+.SH EXAMPLES
+To illustrate the workflow for creating a new mount,
+the following is an example of how to mount an
+.BR ext4 (5)
+filesystem stored on
+.I /dev/sdb1
+onto
+.IR /mnt .
+.P
+.in +4n
+.EX
+int fsfd, mntfd;
+\&
+fsfd = fsopen("ext4", FSOPEN_CLOEXEC);
+fsconfig(fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
+fsconfig(fsfd, FSCONFIG_SET_PATH, "source", "/dev/sdb1", AT_FDCWD);
+fsconfig(fsfd, FSCONFIG_SET_FLAG, "noatime", NULL, 0);
+fsconfig(fsfd, FSCONFIG_SET_FLAG, "acl", NULL, 0);
+fsconfig(fsfd, FSCONFIG_SET_FLAG, "user_xattr", NULL, 0);
+fsconfig(fsfd, FSCONFIG_SET_FLAG, "iversion", NULL, 0)
+fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_RELATIME);
+move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
+.EE
+.in
+.P
+First,
+an ext4 configuration context is created and attached to the file descriptor
+.IR fsfd .
+Then, a series of parameters
+(such as the source of the filesystem)
+are provided using
+.BR fsconfig (2),
+followed by the filesystem instance being created with
+.BR \%FSCONFIG_CMD_CREATE .
+.BR fsmount (2)
+is then used to create a new mount object attached to the file descriptor
+.IR mntfd ,
+which is then attached to the intended mount point using
+.BR move_mount (2).
+.P
+The above procedure is functionally equivalent to
+the following mount operation using
+.BR mount (2):
+.P
+.in +4n
+.EX
+mount("/dev/sdb1", "/mnt", "ext4", MS_RELATIME,
+      "ro,noatime,acl,user_xattr,iversion");
+.EE
+.in
+.P
+And here's an example of creating a mount object
+of an NFS server share
+and setting a Smack security module label.
+However, instead of attaching it to a mount point,
+the program uses the mount object directly
+to open a file from the NFS share.
+.P
+.in +4n
+.EX
+int fsfd, mntfd, fd;
+\&
+fsfd = fsopen("nfs", 0);
+fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "example.com/pub/linux", 0);
+fsconfig(fsfd, FSCONFIG_SET_STRING, "nfsvers", "3", 0);
+fsconfig(fsfd, FSCONFIG_SET_STRING, "rsize", "65536", 0);
+fsconfig(fsfd, FSCONFIG_SET_STRING, "wsize", "65536", 0);
+fsconfig(fsfd, FSCONFIG_SET_STRING, "smackfsdef", "foolabel", 0);
+fsconfig(fsfd, FSCONFIG_SET_FLAG, "rdma", NULL, 0);
+fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+mntfd = fsmount(fsfd, 0, MOUNT_ATTR_NODEV);
+fd = openat(mntfd, "src/linux-5.2.tar.xz", O_RDONLY);
+.EE
+.in
+.P
+Unlike the previous example,
+this operation has no trivial equivalent with
+.BR mount (2),
+as it was not previously possible to create a mount object
+that is not attached to any mount point.
+.SH SEE ALSO
+.BR fsconfig (2),
+.BR fsmount (2),
+.BR fspick (2),
+.BR mount (2),
+.BR mount_setattr (2),
+.BR move_mount (2),
+.BR open_tree (2),
+.BR mount_namespaces (7)

-- 
2.51.0


