Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56CEF602C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 11:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfGEJBX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 5 Jul 2019 05:01:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbfGEJBW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:01:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7E78C18B2E2;
        Fri,  5 Jul 2019 09:01:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-9.rdu2.redhat.com [10.10.120.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36C5868C78;
        Fri,  5 Jul 2019 09:01:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190702182258.GB110306@gmail.com>
References: <20190702182258.GB110306@gmail.com> <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com> <20190629202744.12396-1-ebiggers@kernel.org> <20190701164536.GA202431@gmail.com> <20190701182239.GA17978@ZenIV.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: move_mount.2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17706.1562317273.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 05 Jul 2019 10:01:13 +0100
Message-ID: <17707.1562317273@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 05 Jul 2019 09:01:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:

> Also, since the case of a fd with an internal mount was overlooked, probably
> the man page needs to be updated clarify that move_mount(2) fails with
> EINVAL in this case.  Where is the man page?

See below.  I'm in the middle of updating the manpages I need to push.

David
---
'\" t
.\" Copyright (c) 2018 David Howells <dhowells@redhat.com>
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
.TH MOVE_MOUNT 2 2018-06-08 "Linux" "Linux Programmer's Manual"
.SH NAME
move_mount \- Move mount objects around the filesystem topology
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
.BI "int move_mount(int " from_dirfd ", const char *" from_pathname ","
.BI "               int " to_dirfd ", const char *" to_pathname ","
.BI "               unsigned int " flags );
.fi
.PP
.IR Note :
There are no glibc wrappers for these system calls.
.SH DESCRIPTION
The
.BR move_mount ()
call moves a mount from one place to another; it can also be used to attach an
unattached mount created by
.BR fsmount "() or " open_tree "() with " OPEN_TREE_CLONE .
.PP
If
.BR move_mount ()
is called repeatedly with a file descriptor that refers to a mount object,
then the object will be attached/moved the first time and then moved again and
again and again, detaching it from the previous mountpoint each time.
.PP
To access the source mount object or the destination mountpoint, no
permissions are required on the object itself, but if either pathname is
supplied, execute (search) permission is required on all of the directories
specified in
.IR from_pathname " or " to_pathname .
.PP
The caller does, however, require the appropriate capabilities or permission
to effect a mount.
.PP
.BR move_mount ()
uses
.IR from_pathname ", " from_dirfd " and some " flags
to locate the mount object to be moved and
.IR to_pathname ", " to_dirfd " and some other " flags
to locate the destination mountpoint.  Each lookup can be done in one of a
variety of ways:
.TP
[*] By absolute path.
The pathname points to an absolute path and the dirfd is ignored.  The file is
looked up by name, starting from the root of the filesystem as seen by the
calling process.
.TP
[*] By cwd-relative path.
The pathname points to a relative path and the dirfd is
.IR AT_FDCWD .
The file is looked up by name, starting from the current working directory.
.TP
[*] By dir-relative path.
The pathname points to relative path and the dirfd indicates a file descriptor
pointing to a directory.  The file is looked up by name, starting from the
directory specified by
.IR dirfd .
.TP
[*] By file descriptor.
The pathname points to "", the dirfd points directly to the mount object to
move or the destination mount point and the appropriate
.B *_EMPTY_PATH
flag is set.
.PP
.I flags
can be used to influence a path-based lookup.  A value for
.I flags
is constructed by OR'ing together zero or more of the following constants:
.TP
.BR MOVE_MOUNT_F_EMPTY_PATH
.\" commit 65cfc6722361570bfe255698d9cd4dccaf47570d
If
.I from_pathname
is an empty string, operate on the file referred to by
.IR from_dirfd
(which may have been obtained using the
.BR open (2)
.B O_PATH
flag or
.BR open_tree ())
If
.I from_dirfd
is
.BR AT_FDCWD ,
the call operates on the current working directory.
In this case,
.I from_dirfd
can refer to any type of file, not just a directory.
This flag is Linux-specific; define
.B _GNU_SOURCE
.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
to obtain its definition.
.TP
.B MOVE_MOUNT_T_EMPTY_PATH
As above, but operating on
.IR to_pathname " and " to_dirfd .
.TP
.B MOVE_MOUNT_F_NO_AUTOMOUNT
Don't automount the terminal ("basename") component of
.I from_pathname
if it is a directory that is an automount point.  This allows a mount object
that has an automount point at its root to be moved and prevents unintended
triggering of an automount point.
The
.B MOVE_MOUNT_F_NO_AUTOMOUNT
flag has no effect if the automount point has already been mounted over.  This
flag is Linux-specific; define
.B _GNU_SOURCE
.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
to obtain its definition.
.TP
.B MOVE_MOUNT_T_NO_AUTOMOUNT
As above, but operating on
.IR to_pathname " and " to_dirfd .
This allows an automount point to be manually mounted over.
.TP
.B MOVE_MOUNT_F_SYMLINKS
If
.I from_pathname
is a symbolic link, then dereference it.  The default for
.BR move_mount ()
is to not follow symlinks.
.TP
.B MOVE_MOUNT_T_SYMLINKS
As above, but operating on
.IR to_pathname " and " to_dirfd .

.SH EXAMPLES
The
.BR move_mount ()
function can be used like the following:
.PP
.RS
.nf
move_mount(AT_FDCWD, "/a", AT_FDCWD, "/b", 0);
.fi
.RE
.PP
This would move the object mounted on "/a" to "/b".  It can also be used in
conjunction with
.BR open_tree "(2) or " open "(2) with " O_PATH :
.PP
.RS
.nf
fd = open_tree(AT_FDCWD, "/mnt", 0);
move_mount(fd, "", AT_FDCWD, "/mnt2", MOVE_MOUNT_F_EMPTY_PATH);
move_mount(fd, "", AT_FDCWD, "/mnt3", MOVE_MOUNT_F_EMPTY_PATH);
move_mount(fd, "", AT_FDCWD, "/mnt4", MOVE_MOUNT_F_EMPTY_PATH);
.fi
.RE
.PP
This would attach the path point for "/mnt" to fd, then it would move the
mount to "/mnt2", then move it to "/mnt3" and finally to "/mnt4".
.PP
It can also be used to attach new mounts:
.PP
.RS
.nf
sfd = fsopen("ext4", FSOPEN_CLOEXEC);
write(sfd, "s /dev/sda1");
write(sfd, "o user_xattr");
mfd = fsmount(sfd, FSMOUNT_CLOEXEC, MS_NODEV);
move_mount(mfd, "", AT_FDCWD, "/home", MOVE_MOUNT_F_EMPTY_PATH);
.fi
.RE
.PP
Which would open the Ext4 filesystem mounted on "/dev/sda1", turn on user
extended attribute support and create a mount object for it.  Finally, the new
mount object would be attached with
.BR move_mount ()
to "/home".


.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
.SH RETURN VALUE
On success, 0 is returned.  On error, \-1 is returned, and
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
.IR from_dirfd " or " to_dirfd
is not a valid open file descriptor.
.TP
.B EFAULT
.IR from_pathname " or " to_pathname
is NULL or either one point to a location outside the process's accessible
address space.
.TP
.B EINVAL
Reserved flag specified in
.IR flags .
.TP
.B ELOOP
Too many symbolic links encountered while traversing the pathname.
.TP
.B ENAMETOOLONG
.IR from_pathname " or " to_pathname
is too long.
.TP
.B ENOENT
A component of
.IR from_pathname " or " to_pathname
does not exist, or one is an empty string and the appropriate
.B *_EMPTY_PATH
was not specified in
.IR flags .
.TP
.B ENOMEM
Out of memory (i.e., kernel memory).
.TP
.B ENOTDIR
A component of the path prefix of
.IR from_pathname " or " to_pathname
is not a directory or one or the other is relative and the appropriate
.I *_dirfd
is a file descriptor referring to a file other than a directory.
.SH VERSIONS
.BR move_mount ()
was added to Linux in kernel 4.18.
.SH CONFORMING TO
.BR move_mount ()
is Linux-specific.
.SH NOTES
Glibc does not (yet) provide a wrapper for the
.BR move_mount ()
system call; call it using
.BR syscall (2).
.SH SEE ALSO
.BR fsmount (2),
.BR fsopen (2),
.BR open_tree (2)
