Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F13D2F2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 19:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfJJRES convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 13:04:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfJJRES (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:04:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D884F3086E21;
        Thu, 10 Oct 2019 17:04:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A496B600F8;
        Thu, 10 Oct 2019 17:04:16 +0000 (UTC)
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
Subject: [MANPAGE] open_tree.2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11043.1570727055.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 10 Oct 2019 18:04:15 +0100
Message-ID: <11044.1570727055@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 10 Oct 2019 17:04:17 +0000 (UTC)
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
.TH OPEN_TREE 2 2019-10-10 "Linux" "Linux Programmer's Manual"
.SH NAME
open_tree \- Pick or clone mount object and attach to fd
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
.BI "int open_tree(int " dirfd ", const char *" pathname ", unsigned int " flags );
.fi
.PP
.IR Note :
There are no glibc wrappers for these system calls.
.SH DESCRIPTION
.BR open_tree ()
picks the mount object specified by the pathname and attaches it to a new file
descriptor or clones it and attaches the clone to the file descriptor.  The
resultant file descriptor is indistinguishable from one produced by
.BR open "(2) with " O_PATH .
.PP
In the case that the mount object is cloned, the clone will be "unmounted" and
destroyed when the file descriptor is closed if it is not otherwise mounted
somewhere by calling
.BR move_mount (2).
.PP
To select a mount object, no permissions are required on the object referred
to by the path, but execute (search) permission is required on all of the
directories in
.I pathname
that lead to the object.
.PP
To clone an object, however, the caller must have mount capabilities and
permissions.
.PP
.BR open_tree ()
uses
.IR pathname ", " dirfd " and " flags
to locate the target object in one of a variety of ways:
.TP
[*] By absolute path.
.I pathname
points to an absolute path and
.I dirfd
is ignored.  The object is looked up by name, starting from the root of the
filesystem as seen by the calling process.
.TP
[*] By cwd-relative path.
.I pathname
points to a relative path and
.IR dirfd " is " AT_FDCWD .
The object is looked up by name, starting from the current working directory.
.TP
[*] By dir-relative path.
.I pathname
points to relative path and
.I dirfd
indicates a file descriptor pointing to a directory.  The object is looked up
by name, starting from the directory specified by
.IR dirfd .
.TP
[*] By file descriptor.
.I pathname
is "",
.I dirfd
indicates a file descriptor and
.B AT_EMPTY_PATH
is set in
.IR flags .
The mount attached to the file descriptor is queried directly.  The file
descriptor may point to any type of file, not just a directory.

.\"______________________________________________________________
.PP
.I flags
can be used to control the operation of the function and to influence a
path-based lookup.  A value for
.I flags
is constructed by OR'ing together zero or more of the following constants:
.TP
.BR AT_EMPTY_PATH
.\" commit 65cfc6722361570bfe255698d9cd4dccaf47570d
If
.I pathname
is an empty string, operate on the file referred to by
.IR dirfd
(which may have been obtained from
.BR open "(2) with"
.BR O_PATH ", from " fsmount (2)
or from another
.BR open_tree ()).
If
.I dirfd
is
.BR AT_FDCWD ,
the call operates on the current working directory.
In this case,
.I dirfd
can refer to any type of file, not just a directory.
This flag is Linux-specific; define
.B _GNU_SOURCE
.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
to obtain its definition.
.TP
.BR AT_NO_AUTOMOUNT
Don't automount the terminal ("basename") component of
.I pathname
if it is a directory that is an automount point.  This flag allows the
automount point itself to be picked up or a mount cloned that is rooted on the
automount point.  The
.B AT_NO_AUTOMOUNT
flag has no effect if the mount point has already been mounted over.
This flag is Linux-specific; define
.B _GNU_SOURCE
.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
to obtain its definition.
.TP
.B AT_SYMLINK_NOFOLLOW
If
.I pathname
is a symbolic link, do not dereference it: instead pick up or clone a mount
rooted on the link itself.
.TP
.B OPEN_TREE_CLOEXEC
Set the close-on-exec flag for the new file descriptor.  This will cause the
file descriptor to be closed automatically when a process exec's.
.TP
.B OPEN_TREE_CLONE
Rather than directly attaching the selected object to the file descriptor,
clone the object, set the root of the new mount object to that point and
attach the clone to the file descriptor.
.TP
.B AT_RECURSIVE
This is only permitted in conjunction with OPEN_TREE_CLONE.  It causes the
entire mount subtree rooted at the selected spot to be cloned rather than just
that one mount object.


.SH EXAMPLE
The
.BR open_tree ()
function can be used like the following:
.PP
.RS
.nf
fd1 = open_tree(AT_FDCWD, "/mnt", 0);
fd2 = open_tree(fd1, "",
                AT_EMPTY_PATH | OPEN_TREE_CLONE | AT_RECURSIVE);
move_mount(fd2, "", AT_FDCWD, "/mnt2", MOVE_MOUNT_F_EMPTY_PATH);
.fi
.RE
.PP
This would attach the path point for "/mnt" to fd1, then it would copy the
entire subtree at the point referred to by fd1 and attach that to fd2; lastly,
it would attach the clone to "/mnt2".


.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SH RETURN VALUE
On success, the new file descriptor is returned.  On error, \-1 is returned,
and
.I errno
is set appropriately.
.SH ERRORS
.TP
.B EACCES
Search permission is denied for one of the directories
in the path prefix of
.IR pathname .
(See also
.BR path_resolution (7).)
.TP
.B EBADF
.I dirfd
is not a valid open file descriptor.
.TP
.B EFAULT
.I pathname
is NULL or
.IR pathname
point to a location outside the process's accessible address space.
.TP
.B EINVAL
Reserved flag specified in
.IR flags .
.TP
.B ELOOP
Too many symbolic links encountered while traversing the pathname.
.TP
.B ENAMETOOLONG
.I pathname
is too long.
.TP
.B ENOENT
A component of
.I pathname
does not exist, or
.I pathname
is an empty string and
.B AT_EMPTY_PATH
was not specified in
.IR flags .
.TP
.B ENOMEM
Out of memory (i.e., kernel memory).
.TP
.B ENOTDIR
A component of the path prefix of
.I pathname
is not a directory or
.I pathname
is relative and
.I dirfd
is a file descriptor referring to a file other than a directory.
.SH VERSIONS
.BR open_tree ()
was added to Linux in kernel 4.18.
.SH CONFORMING TO
.BR open_tree ()
is Linux-specific.
.SH NOTES
Glibc does not (yet) provide a wrapper for the
.BR open_tree ()
system call; call it using
.BR syscall (2).
.SH SEE ALSO
.BR fsmount (2),
.BR move_mount (2),
.BR open (2)
