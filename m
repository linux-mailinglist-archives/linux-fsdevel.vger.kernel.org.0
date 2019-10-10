Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1BB4D2F26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 19:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfJJRDG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 13:03:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfJJRDG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:03:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A854A3098452;
        Thu, 10 Oct 2019 17:03:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 727196012A;
        Thu, 10 Oct 2019 17:03:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <10805.1570726908@warthog.procyon.org.uk>
References: <10805.1570726908@warthog.procyon.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [MANPAGE] fspick.2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10915.1570726982.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 10 Oct 2019 18:03:02 +0100
Message-ID: <10916.1570726982@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 10 Oct 2019 17:03:05 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

'\" t
.\" Copyright (c) 2019 David Howells <dhowells@redhat.com>
.\"
.\" %%%LICENSE_START(VERBATIM)
.\" Permission is granted to make and distribute verbatim copies of this
.\" manual provided the copyright notice and this permission notice are
.\" preserved on all copies.
.\"
.\" Permission is granted to copy and distribute modified versions of this
.\" manual under the conditions for verbatim copying, provided that the
.\" entire resulting derived work is distributed under the terms of a
.\" permission notice identical to this one.
.\"
.\" Since the Linux kernel and libraries are constantly changing, this
.\" manual page may be incorrect or out-of-date.  The author(s) assume no
.\" responsibility for errors or omissions, or for damages resulting from
.\" the use of the information contained herein.  The author(s) may not
.\" have taken the same level of care in the production of this manual,
.\" which is licensed free of charge, as they might when working
.\" professionally.
.\"
.\" Formatted or processed versions of this manual, if unaccompanied by
.\" the source, must acknowledge the copyright and authors of this work.
.\" %%%LICENSE_END
.\"
.TH FSPICK 2 2019-10-10 "Linux" "Linux Programmer's Manual"
.SH NAME
fspick \- Select filesystem for reconfiguration
.SH SYNOPSIS
.nf
.B #include <sys/types.h>
.br
.B #include <sys/mount.h>
.br
.B #include <unistd.h>
.br
.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
.PP
.BI "int fspick(int " dirfd ", const char *" pathname ", unsigned int " flags );
.fi
.PP
.IR Note :
There is no glibc wrapper for this system call.
.SH DESCRIPTION
.PP
.BR fspick ()
creates a new filesystem configuration context within the kernel and attaches a
pre-existing superblock to it so that it can be reconfigured (similar to
.BR mount (8)
with the "-o remount" option).  The configuration context is marked as being in
reconfiguration mode and attached to a file descriptor, which is returned to
the caller.  This can be marked close-on-exec by setting
.B FSPICK_CLOEXEC
in
.IR flags .
.PP
The target is whichever superblock backs the object determined by
.IR dfd ", " pathname " and " flags .
The following can be set in
.I flags
to control the pathwalk to that object:
.TP
.B FSPICK_SYMLINK_NOFOLLOW
Don't follow symbolic links in the terminal component of the path.
.TP
.B FSPICK_NO_AUTOMOUNT
Don't follow automounts in the terminal component of the path.
.TP
.B FSPICK_EMPTY_PATH
Allow an empty string to be specified as the pathname.  This allows
.I dirfd
to specify a path exactly.
.PP
After calling fspick(), the file descriptor should be passed to the
.BR fsconfig (2)
system call, using that to specify the desired changes to filesystem and
security parameters.
.PP
When the parameters are all set, the
.BR fsconfig ()
system call should then be called again with
.B FSCONFIG_CMD_RECONFIGURE
as the command argument to effect the reconfiguration.
.PP
After the reconfiguration has taken place, the context is wiped clean (apart
from the superblock attachment, which remains) and can be reused to make
another reconfiguration.
.PP
The file descriptor also serves as a channel by which more comprehensive error,
warning and information messages may be retrieved from the kernel using
.BR read (2).


.\"________________________________________________________
.SS Message Retrieval Interface
The context file descriptor may be queried for message strings at any time by
calling
.BR read (2)
on the file descriptor.  This will return formatted messages that are prefixed
to indicate their class:
.TP
\fB"e <message>"\fP
An error message string was logged.
.TP
\fB"i <message>"\fP
An informational message string was logged.
.TP
\fB"w <message>"\fP
An warning message string was logged.
.PP
Messages are removed from the queue as they're read and the queue has a limited
depth, so it's possible for some to get lost.

.\"________________________________________________________
.SH EXAMPLES
To illustrate the process, here's an example whereby this can be used to
reconfigure a filesystem:
.PP
.in +4n
.nf
sfd = fspick(AT_FDCWD, "/mnt", FSPICK_NO_AUTOMOUNT | FSPICK_CLOEXEC);
fsconfig(sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
fsconfig(sfd, FSCONFIG_SET_STRING, "user_xattr", "false", 0);
fsconfig(sfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);
.fi
.in
.PP


.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SH RETURN VALUE
On success, the function returns a file descriptor.  On error, \-1 is returned,
and
.I errno
is set appropriately.
.SH ERRORS
The error values given below result from filesystem type independent
errors.
Each filesystem type may have its own special errors and its
own special behavior.
See the Linux kernel source code for details.
.TP
.B EACCES
A component of a path was not searchable.
(See also
.BR path_resolution (7).)
.TP
.B EFAULT
.I pathname
points outside the user address space.
.TP
.B EINVAL
.I flags
includes an undefined value.
.TP
.B ELOOP
Too many links encountered during pathname resolution.
.TP
.B EMFILE
The system has too many open files to create more.
.TP
.B ENFILE
The process has too many open files to create more.
.TP
.B ENAMETOOLONG
A pathname was longer than
.BR MAXPATHLEN .
.TP
.B ENOENT
A pathname was empty or had a nonexistent component.
.TP
.B ENOMEM
The kernel could not allocate sufficient memory to complete the call.
.TP
.B EPERM
The caller does not have the required privileges.
.SH CONFORMING TO
These functions are Linux-specific and should not be used in programs intended
to be portable.
.SH VERSIONS
.BR fsopen "(), " fsmount "() and " fspick ()
were added to Linux in kernel 5.1.
.SH NOTES
Glibc does not (yet) provide a wrapper for the
.BR fspick "()"
system call; call it using
.BR syscall (2).
.SH SEE ALSO
.BR mountpoint (1),
.BR fsconfig (2),
.BR fsopen (2),
.BR path_resolution (7),
.BR mount (8)

