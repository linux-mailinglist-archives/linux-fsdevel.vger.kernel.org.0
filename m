Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290CC214654
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 16:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgGDODS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 10:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgGDODN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 10:03:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD589218AC;
        Sat,  4 Jul 2020 14:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593871392;
        bh=Yj+14217YtAOnGW+R47dIfZ8DJrAtcfTkhE3moybXhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bo1VVkDd19yyAM+xVbtMirVeDtHC8y8RVtHm53sL556lDzTRt7fNbrNRVslVhYZQh
         jB4FnUhzApA+tdrCHP5OK5i0o7VSGvrVwKwgJAUXYBs2Tlqpg3HLvxn5WJhZkYfTZw
         DyEvXIMAXEm++4fTgZWv/HtWpliLrfrV11Oh3GoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, mtk.manpages@gmail.com, shuah@kernel.org,
        linux-api@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] readfile.2: new page describing readfile(2)
Date:   Sat,  4 Jul 2020 16:02:50 +0200
Message-Id: <20200704140250.423345-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200704140250.423345-1-gregkh@linuxfoundation.org>
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

readfile(2) is a new syscall to remove the need to do the
open/read/close dance for small virtual files in places like procfs or
sysfs.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

This patch is for the man-pages project, not the kernel source tree

 man2/readfile.2 | 159 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 man2/readfile.2

diff --git a/man2/readfile.2 b/man2/readfile.2
new file mode 100644
index 000000000000..449e722c3442
--- /dev/null
+++ b/man2/readfile.2
@@ -0,0 +1,159 @@
+.\" This manpage is Copyright (C) 2020 Greg Kroah-Hartman;
+.\"  and Copyright (C) 2020 The Linux Foundation
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
+.TH READFILE 2 2020-07-04 "Linux" "Linux Programmer's Manual"
+.SH NAME
+readfile \- read a file into a buffer
+.SH SYNOPSIS
+.nf
+.B #include <unistd.h>
+.PP
+.BI "ssize_t readfile(int " dirfd ", const char *" pathname ", void *" buf \
+", size_t " count ", int " flags );
+.fi
+.SH DESCRIPTION
+.BR readfile ()
+attempts to open the file specified by
+.IR pathname
+and to read up to
+.I count
+bytes from the file into the buffer starting at
+.IR buf .
+It is to be a shortcut of doing the sequence of
+.BR open ()
+and then
+.BR read ()
+and then
+.BR close ()
+for small files that are read frequently, such as those in
+.B procfs
+or
+.BR sysfs .
+.PP
+If the size of file is smaller than the value provided in
+.I count
+then the whole file will be copied into
+.IR buf .
+.PP
+If the file is larger than the value provided in
+.I count
+then only
+.I count
+number of bytes will be copied into
+.IR buf .
+.PP
+The argument
+.I flags
+may contain one of the following
+.IR "access modes" :
+.BR O_NOFOLLOW ", or " O_NOATIME .
+.PP
+If the pathname given in
+.I pathname
+is relative, then it is interpreted relative to the directory
+referred to by the file descriptor
+.IR dirfd .
+.PP
+If
+.I pathname
+is relative and
+.I dirfd
+is the special value
+.BR AT_FDCWD ,
+then
+.I pathname
+is interpreted relative to the current working
+directory of the calling process (like
+.BR openat ()).
+.PP
+If
+.I pathname
+is absolute, then
+.I dirfd
+is ignored.
+.SH RETURN VALUE
+On success, the number of bytes read is returned.
+It is not an error if this number is smaller than the number of bytes
+requested; this can happen if the file is smaller than the number of
+bytes requested.
+.PP
+On error, \-1 is returned, and
+.I errno
+is set appropriately.
+.SH ERRORS
+.TP
+.B EFAULT
+.I buf
+is outside your accessible address space.
+.TP
+.B EINTR
+The call was interrupted by a signal before any data was read; see
+.BR signal (7).
+.TP
+.B EINVAL
+.I flags
+was set to a value that is not allowed.
+.TP
+.B EIO
+I/O error.
+This will happen for example when the process is in a
+background process group, tries to read from its controlling terminal,
+and either it is ignoring or blocking
+.B SIGTTIN
+or its process group
+is orphaned.
+It may also occur when there is a low-level I/O error
+while reading from a disk or tape.
+A further possible cause of
+.B EIO
+on networked filesystems is when an advisory lock had been taken
+out on the file descriptor and this lock has been lost.
+See the
+.I "Lost locks"
+section of
+.BR fcntl (2)
+for further details.
+.SH CONFORMING TO
+None, this is a Linux-specific system call at this point in time.
+.SH NOTES
+The type
+.I size_t
+is an unsigned integer data type specified by POSIX.1.
+.PP
+On Linux,
+.BR read ()
+(and similar system calls) will transfer at most
+0x7ffff000 (2,147,479,552) bytes,
+returning the number of bytes actually transferred.
+.\" commit e28cc71572da38a5a12c1cfe4d7032017adccf69
+(This is true on both 32-bit and 64-bit systems.)
+.SH BUGS
+None yet!
+.SH SEE ALSO
+.BR close (2),
+.BR open (2),
+.BR openat (2),
+.BR read (2),
+.BR fread (3)
-- 
2.27.0

