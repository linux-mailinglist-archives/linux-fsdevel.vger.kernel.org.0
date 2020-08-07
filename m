Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B36223EEA0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHGOHw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 10:07:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43440 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726518AbgHGODu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596808991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4jkFvtc0/cVLXMEonOCyvDbru2s10L42s9UjSm/sTUw=;
        b=KWmS6i4y73qgPzBAcuyKtylzXOqrrjo4OHfHpkK+Z5td6OMbjW2rFJ+Y28te/LIofBWdsh
        8Pi/gorZO506B5qa8H0ke7J3Gk1gE7f2VxEFaoyLoGYq94KsEliWUzfsfyjOsjgw0pKuto
        QfYBdP1SVtN3p/qOltRbkBYVUxo6gQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-d2TXLffXM7Cw8CuSWldhuQ-1; Fri, 07 Aug 2020 10:03:06 -0400
X-MC-Unique: d2TXLffXM7Cw8CuSWldhuQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B365FD8DED;
        Fri,  7 Aug 2020 14:02:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-69.rdu2.redhat.com [10.10.113.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E9F85D9FC;
        Fri,  7 Aug 2020 14:02:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/5] Add manpage for fsconfig(2)
From:   David Howells <dhowells@redhat.com>
To:     mtk.manpages@gmail.com, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        christian.brauner@ubuntu.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Aug 2020 15:02:51 +0100
Message-ID: <159680897140.29015.15318866561972877762.stgit@warthog.procyon.org.uk>
In-Reply-To: <159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk>
References: <159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a manual page to document the fsconfig() system call.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 man2/fsconfig.2 |  282 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 282 insertions(+)
 create mode 100644 man2/fsconfig.2

diff --git a/man2/fsconfig.2 b/man2/fsconfig.2
new file mode 100644
index 000000000..32f0bce13
--- /dev/null
+++ b/man2/fsconfig.2
@@ -0,0 +1,282 @@
+'\" t
+.\" Copyright (c) 2020 David Howells <dhowells@redhat.com>
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
+.TH FSCONFIG 2 2020-08-07 "Linux" "Linux Programmer's Manual"
+.SH NAME
+fsconfig \- Filesystem parameterisation
+.SH SYNOPSIS
+.nf
+.B #include <sys/types.h>
+.br
+.B #include <sys/mount.h>
+.br
+.B #include <unistd.h>
+.br
+.B #include <sys/mount.h>
+.PP
+.BI "int fsconfig(int *" fd ", unsigned int " cmd ", const char *" key ,
+.br
+.BI "             const void __user *" value ", int " aux ");"
+.br
+.BI
+.fi
+.PP
+.IR Note :
+There is no glibc wrapper for this system call.
+.SH DESCRIPTION
+.PP
+.BR fsconfig ()
+is used to supply parameters to and issue commands against a filesystem
+configuration context as set up by
+.BR fsopen (2)
+or
+.BR fspick (2).
+The context is supplied attached to the file descriptor specified by
+.I fd
+argument.
+.PP
+The
+.I cmd
+argument indicates the command to be issued, where some of the commands simply
+supply parameters to the context.  The meaning of
+.IR key ", " value " and " aux
+are command-dependent; unless required for the command, these should be set to
+NULL or 0.
+.PP
+The available commands are:
+.TP
+.B FSCONFIG_SET_FLAG
+Set the parameter named by
+.IR key
+to true.  This may incur error
+.B EINVAL
+if the parameter requires an argument.
+.TP
+.B FSCONFIG_SET_STRING
+Set the parameter named by
+.I key
+to a string.  This may incur error
+.B EINVAL
+if the parser doesn't want a parameter here, wants a non-string or the string
+cannot be interpreted appropriately.
+.I value
+points to a NUL-terminated string.
+.TP
+.B FSCONFIG_SET_BINARY
+Set the parameter named by
+.I key
+to be a binary blob argument.  This may cause
+.B EINVAL
+to be returned if the filesystem parser isn't expecting a binary blob and it
+can't be converted to something usable.
+.I value
+points to the data and
+.I aux
+indicates the size of the data.
+.TP
+.B FSCONFIG_SET_PATH
+Set the parameter named by
+.I key
+to the object at the provided path.
+.I value
+should point to a NULL-terminated pathname string and aux may indicate
+.B AT_FDCWD
+or a file descriptor indicating a directory from which to begin a relative
+pathwalk.  This may return any errors incurred by the pathwalk and may return
+.B EINVAL
+if the parameter isn't expecting a path.
+.IP
+Note that FSCONFIG_SET_STRING can be used instead, implying AT_FDCWD.
+.TP
+.B FSCONFIG_SET_PATH_EMPTY
+As FSCONFIG_SET_PATH, but with
+.B AT_EMPTY_PATH
+applied to the pathwalk.
+.TP
+.B FSCONFIG_SET_FD
+Set the parameter named by
+.I key
+to the file descriptor specified by
+.IR aux .
+This will incur
+.B EINVAL
+if the parameter doesn't expect a file descriptor or
+.B EBADF
+if the file descriptor is invalid.
+.IP
+Note that FSCONFIG_SET_STRING can be used instead with the file descriptor
+passed as a decimal string.
+.TP
+.B FSCONFIG_CMD_CREATE
+This command causes the filesystem to take the parameters set in the context
+and to try to create filesystem representation in the kernel.  If it can share
+an existing one, it may do that instead if the filesystem type and parameters
+permit that.  This is intended for use with
+.BR fsopen (2).
+.TP
+.B FSCONFIG_CMD_RECONFIGURE
+This command causes the filesystem to apply the parameters set in the context
+to an already existing filesystem representation in memory and to alter it.
+This is intended for use with
+.BR fspick (2),
+but may also by used against the context created by
+.BR fsopen()
+after
+.BR fsmount (2)
+has been called on it.
+
+.\"________________________________________________________
+.SH EXAMPLES
+.PP
+.in +4n
+.nf
+fsconfig(sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
+
+fsconfig(sfd, FSCONFIG_SET_STRING, "user_xattr", "false", 0);
+
+fsconfig(sfd, FSCONFIG_SET_BINARY, "ms_pac", pac_buffer, pac_size);
+
+fsconfig(sfd, FSCONFIG_SET_PATH, "journal", "/dev/sdd4", AT_FDCWD);
+
+dirfd = open("/dev/", O_PATH);
+fsconfig(sfd, FSCONFIG_SET_PATH, "journal", "sdd4", dirfd);
+
+fd = open("/overlays/mine/", O_PATH);
+fsconfig(sfd, FSCONFIG_SET_PATH_EMPTY, "lower_dir", "", fd);
+
+pipe(pipefds);
+fsconfig(sfd, FSCONFIG_SET_FD, "fd", NULL, pipefds[1]);
+.fi
+.in
+.PP
+
+.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+.SH RETURN VALUE
+On success, the function returns 0.  On error, \-1 is returned, and
+.I errno
+is set appropriately.
+.SH ERRORS
+The error values given below result from filesystem type independent
+errors.
+Each filesystem type may have its own special errors and its
+own special behavior.
+See the Linux kernel source code for details.
+.TP
+.B EACCES
+A component of a path was not searchable.
+(See also
+.BR path_resolution (7).)
+.TP
+.B EACCES
+Mounting a read-only filesystem was attempted without specifying the
+.RB ' ro '
+parameter.
+.TP
+.B EACCES
+A specified block device is located on a filesystem mounted with the
+.B MS_NODEV
+option.
+.\" mtk: Probably: write permission is required for MS_BIND, with
+.\" the error EPERM if not present; CAP_DAC_OVERRIDE is required.
+.TP
+.B EBADF
+The file descriptor given by
+.I fd
+or possibly by
+.I aux
+(depending on the command) is invalid.
+.TP
+.B EBUSY
+The context attached to
+.I fd
+is in the wrong state for the given command.
+.TP
+.B EBUSY
+The filesystem representation cannot be reconfigured read-only because it still
+holds files open for writing.
+.TP
+.B EFAULT
+One of the pointer arguments points outside the user address space.
+.TP
+.B EINVAL
+.I fd
+does not refer to a filesystem configuration context.
+.TP
+.B EINVAL
+One of the source parameters referred to an invalid superblock.
+.TP
+.B ELOOP
+Too many links encountered during pathname resolution.
+.TP
+.B ENAMETOOLONG
+A path name was longer than
+.BR MAXPATHLEN .
+.TP
+.B ENOENT
+A pathname was empty or had a nonexistent component.
+.TP
+.B ENOMEM
+The kernel could not allocate sufficient memory to complete the call.
+.TP
+.B ENOTBLK
+Once of the parameters does not refer to a block device (and a device was
+required).
+.TP
+.B ENOTDIR
+.IR pathname ,
+or a prefix of
+.IR source ,
+is not a directory.
+.TP
+.B EOPNOTSUPP
+The command given by
+.I cmd
+was not valid.
+.TP
+.B ENXIO
+The major number of a block device parameter is out of range.
+.TP
+.B EPERM
+The caller does not have the required privileges.
+.SH CONFORMING TO
+These functions are Linux-specific and should not be used in programs intended
+to be portable.
+.SH VERSIONS
+.BR fsconfig ()
+was added to Linux in kernel 5.1.
+.SH NOTES
+Glibc does not (yet) provide a wrapper for the
+.BR fsconfig ()
+system call; call it using
+.BR syscall (2).
+.SH SEE ALSO
+.BR mountpoint (1),
+.BR fsmount (2),
+.BR fsopen (2),
+.BR fspick (2),
+.BR mount_namespaces (7),
+.BR path_resolution (7)


