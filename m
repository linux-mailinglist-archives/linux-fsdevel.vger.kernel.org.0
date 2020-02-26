Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAD916FE38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 12:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgBZLtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 06:49:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:40082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgBZLtB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:49:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16876AC44;
        Wed, 26 Feb 2020 11:48:57 +0000 (UTC)
Date:   Wed, 26 Feb 2020 12:48:55 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Zorro Lang <zlang@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Add manpages for move_mount(2) and open_tree(2)
Message-ID: <20200226114855.GA25595@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200207174236.18882-1-pvorel@suse.cz>
 <20200207174236.18882-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207174236.18882-2-pvorel@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

gentle ping. Could these 2 patches be merged?

Kind regards,
Petr

> From: David Howells <dhowells@redhat.com>

> Add manual pages to document the move_mount and open_tree() system calls.

> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,

> * man2/move_mount.2
> fixed MOVE_MOUNT_F_NO_AUTOMOUNT => MOVE_MOUNT_F_AUTOMOUNTS
> and MOVE_MOUNT_T_NO_AUTOMOUNT => MOVE_MOUNT_T_AUTOMOUNTS
> maybe mention -EPERM on !may_mount() ?

> * man2/open_tree.2
> maybe mention -EPERM on (detached && !may_mount()) ?

> Kind regards,
> Petr

>  man2/move_mount.2 | 271 ++++++++++++++++++++++++++++++++++++++++++++++
>  man2/open_tree.2  | 260 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 531 insertions(+)
>  create mode 100644 man2/move_mount.2
>  create mode 100644 man2/open_tree.2

> diff --git a/man2/move_mount.2 b/man2/move_mount.2
> new file mode 100644
> index 000000000..bca352ad3
> --- /dev/null
> +++ b/man2/move_mount.2
> @@ -0,0 +1,271 @@
> +'\" t
> +.\" Copyright (c) 2019 David Howells <dhowells@redhat.com>
> +.\"
> +.\" %%%LICENSE_START(VERBATIM)
> +.\" Permission is granted to make and distribute verbatim copies of this
> +.\" manual provided the copyright notice and this permission notice are
> +.\" preserved on all copies.
> +.\"
> +.\" Permission is granted to copy and distribute modified versions of this
> +.\" manual under the conditions for verbatim copying, provided that the
> +.\" entire resulting derived work is distributed under the terms of a
> +.\" permission notice identical to this one.
> +.\"
> +.\" Since the Linux kernel and libraries are constantly changing, this
> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
> +.\" responsibility for errors or omissions, or for damages resulting from
> +.\" the use of the information contained herein.  The author(s) may not
> +.\" have taken the same level of care in the production of this manual,
> +.\" which is licensed free of charge, as they might when working
> +.\" professionally.
> +.\"
> +.\" Formatted or processed versions of this manual, if unaccompanied by
> +.\" the source, must acknowledge the copyright and authors of this work.
> +.\" %%%LICENSE_END
> +.\"
> +.TH MOVE_MOUNT 2 2019-10-10 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +move_mount \- Move mount objects around the filesystem topology
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/types.h>
> +.br
> +.B #include <sys/mount.h>
> +.br
> +.B #include <unistd.h>
> +.br
> +.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
> +.PP
> +.BI "int move_mount(int " from_dirfd ", const char *" from_pathname ","
> +.BI "               int " to_dirfd ", const char *" to_pathname ","
> +.BI "               unsigned int " flags );
> +.fi
> +.PP
> +.IR Note :
> +There is no glibc wrapper for this system call.
> +.SH DESCRIPTION
> +The
> +.BR move_mount ()
> +call moves a mount from one place to another; it can also be used to attach an
> +unattached mount created by
> +.BR fsmount "() or " open_tree "() with " OPEN_TREE_CLONE .
> +.PP
> +If
> +.BR move_mount ()
> +is called repeatedly with a file descriptor that refers to a mount object,
> +then the object will be attached/moved the first time and then moved again and
> +again and again, detaching it from the previous mountpoint each time.
> +.PP
> +To access the source mount object or the destination mountpoint, no
> +permissions are required on the object itself, but if either pathname is
> +supplied, execute (search) permission is required on all of the directories
> +specified in
> +.IR from_pathname " or " to_pathname .
> +.PP
> +The caller does, however, require the appropriate capabilities or permission
> +to effect a mount.
> +.PP
> +.BR move_mount ()
> +uses
> +.IR from_pathname ", " from_dirfd " and part of " flags
> +to locate the mount object to be moved and
> +.IR to_pathname ", " to_dirfd " and another part of " flags
> +to locate the destination mountpoint.  Each lookup can be done in one of a
> +variety of ways:
> +.TP
> +[*] By absolute path.
> +The pathname points to an absolute path and the dirfd is ignored.  The file is
> +looked up by name, starting from the root of the filesystem as seen by the
> +calling process.
> +.TP
> +[*] By cwd-relative path.
> +The pathname points to a relative path and the dirfd is
> +.IR AT_FDCWD .
> +The file is looked up by name, starting from the current working directory.
> +.TP
> +[*] By dir-relative path.
> +The pathname points to relative path and the dirfd indicates a file descriptor
> +pointing to a directory.  The file is looked up by name, starting from the
> +directory specified by
> +.IR dirfd .
> +.TP
> +[*] By file descriptor.
> +The pathname points to "", the dirfd points directly to the mount object to
> +move or the destination mount point and the appropriate
> +.B *_EMPTY_PATH
> +flag is set.
> +.PP
> +.I flags
> +can be used to influence a path-based lookup.  A value for
> +.I flags
> +is constructed by OR'ing together zero or more of the following constants:
> +.TP
> +.BR MOVE_MOUNT_F_EMPTY_PATH
> +.\" commit 65cfc6722361570bfe255698d9cd4dccaf47570d
> +If
> +.I from_pathname
> +is an empty string, operate on the file referred to by
> +.IR from_dirfd
> +(which may have been obtained using the
> +.BR open (2)
> +.B O_PATH
> +flag or
> +.BR open_tree ()).
> +If
> +.I from_dirfd
> +is
> +.BR AT_FDCWD ,
> +the call operates on the current working directory.
> +In this case,
> +.I from_dirfd
> +can refer to any type of file, not just a directory.
> +This flag is Linux-specific; define
> +.B _GNU_SOURCE
> +.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
> +to obtain its definition.
> +.TP
> +.B MOVE_MOUNT_T_EMPTY_PATH
> +As above, but operating on
> +.IR to_pathname " and " to_dirfd .
> +.TP
> +.B MOVE_MOUNT_F_AUTOMOUNTS
> +Don't automount the terminal ("basename") component of
> +.I from_pathname
> +if it is a directory that is an automount point.  This allows a mount object
> +that has an automount point at its root to be moved and prevents unintended
> +triggering of an automount point.
> +The
> +.B MOVE_MOUNT_F_AUTOMOUNTS
> +flag has no effect if the automount point has already been mounted over.
> +.TP
> +.B MOVE_MOUNT_T_AUTOMOUNTS
> +As above, but operating on
> +.IR to_pathname " and " to_dirfd .
> +This allows an automount point to be manually mounted over.
> +.TP
> +.B MOVE_MOUNT_F_SYMLINKS
> +If
> +.I from_pathname
> +is a symbolic link, then dereference it.  The default for
> +.BR move_mount ()
> +is to not follow symlinks.
> +.TP
> +.B MOVE_MOUNT_T_SYMLINKS
> +As above, but operating on
> +.IR to_pathname " and " to_dirfd .
> +
> +.SH EXAMPLES
> +The
> +.BR move_mount ()
> +function can be used like the following:
> +.PP
> +.RS
> +.nf
> +move_mount(AT_FDCWD, "/a", AT_FDCWD, "/b", 0);
> +.fi
> +.RE
> +.PP
> +This would move the object mounted on "/a" to "/b".  It can also be used in
> +conjunction with
> +.BR open_tree "(2) or " open "(2) with " O_PATH :
> +.PP
> +.RS
> +.nf
> +fd = open_tree(AT_FDCWD, "/mnt", 0);
> +move_mount(fd, "", AT_FDCWD, "/mnt2", MOVE_MOUNT_F_EMPTY_PATH);
> +move_mount(fd, "", AT_FDCWD, "/mnt3", MOVE_MOUNT_F_EMPTY_PATH);
> +move_mount(fd, "", AT_FDCWD, "/mnt4", MOVE_MOUNT_F_EMPTY_PATH);
> +.fi
> +.RE
> +.PP
> +This would attach the path point for "/mnt" to fd, then it would move the
> +mount to "/mnt2", then move it to "/mnt3" and finally to "/mnt4".
> +.PP
> +It can also be used to attach new mounts:
> +.PP
> +.RS
> +.nf
> +sfd = fsopen("ext4", FSOPEN_CLOEXEC);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "source", "/dev/sda1", 0);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "user_xattr", NULL, 0);
> +fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +mfd = fsmount(sfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_NODEV);
> +move_mount(mfd, "", AT_FDCWD, "/home", MOVE_MOUNT_F_EMPTY_PATH);
> +.fi
> +.RE
> +.PP
> +Which would open the Ext4 filesystem mounted on "/dev/sda1", turn on user
> +extended attribute support and create a mount object for it.  Finally, the new
> +mount object would be attached with
> +.BR move_mount ()
> +to "/home".
> +
> +
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.SH RETURN VALUE
> +On success, 0 is returned.  On error, \-1 is returned, and
> +.I errno
> +is set appropriately.
> +.SH ERRORS
> +.TP
> +.B EACCES
> +Search permission is denied for one of the directories
> +in the path prefix of
> +.IR pathname .
> +(See also
> +.BR path_resolution (7).)
> +.TP
> +.B EBADF
> +.IR from_dirfd " or " to_dirfd
> +is not a valid open file descriptor.
> +.TP
> +.B EFAULT
> +.IR from_pathname " or " to_pathname
> +is NULL or either one point to a location outside the process's accessible
> +address space.
> +.TP
> +.B EINVAL
> +Reserved flag specified in
> +.IR flags .
> +.TP
> +.B ELOOP
> +Too many symbolic links encountered while traversing the pathname.
> +.TP
> +.B ENAMETOOLONG
> +.IR from_pathname " or " to_pathname
> +is too long.
> +.TP
> +.B ENOENT
> +A component of
> +.IR from_pathname " or " to_pathname
> +does not exist, or one is an empty string and the appropriate
> +.B *_EMPTY_PATH
> +was not specified in
> +.IR flags .
> +.TP
> +.B ENOMEM
> +Out of memory (i.e., kernel memory).
> +.TP
> +.B ENOTDIR
> +A component of the path prefix of
> +.IR from_pathname " or " to_pathname
> +is not a directory or one or the other is relative and the appropriate
> +.I *_dirfd
> +is a file descriptor referring to a file other than a directory.
> +.SH VERSIONS
> +.BR move_mount ()
> +was added to Linux in kernel 5.2.
> +.SH CONFORMING TO
> +.BR move_mount ()
> +is Linux-specific.
> +.SH NOTES
> +Glibc does not (yet) provide a wrapper for the
> +.BR move_mount ()
> +system call; call it using
> +.BR syscall (2).
> +.SH SEE ALSO
> +.BR fsmount (2),
> +.BR fsopen (2),
> +.BR open_tree (2)
> diff --git a/man2/open_tree.2 b/man2/open_tree.2
> new file mode 100644
> index 000000000..56783898f
> --- /dev/null
> +++ b/man2/open_tree.2
> @@ -0,0 +1,260 @@
> +'\" t
> +.\" Copyright (c) 2019 David Howells <dhowells@redhat.com>
> +.\"
> +.\" %%%LICENSE_START(VERBATIM)
> +.\" Permission is granted to make and distribute verbatim copies of this
> +.\" manual provided the copyright notice and this permission notice are
> +.\" preserved on all copies.
> +.\"
> +.\" Permission is granted to copy and distribute modified versions of this
> +.\" manual under the conditions for verbatim copying, provided that the
> +.\" entire resulting derived work is distributed under the terms of a
> +.\" permission notice identical to this one.
> +.\"
> +.\" Since the Linux kernel and libraries are constantly changing, this
> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
> +.\" responsibility for errors or omissions, or for damages resulting from
> +.\" the use of the information contained herein.  The author(s) may not
> +.\" have taken the same level of care in the production of this manual,
> +.\" which is licensed free of charge, as they might when working
> +.\" professionally.
> +.\"
> +.\" Formatted or processed versions of this manual, if unaccompanied by
> +.\" the source, must acknowledge the copyright and authors of this work.
> +.\" %%%LICENSE_END
> +.\"
> +.TH OPEN_TREE 2 2019-10-10 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +open_tree \- Pick or clone mount object and attach to fd
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/types.h>
> +.br
> +.B #include <sys/mount.h>
> +.br
> +.B #include <unistd.h>
> +.br
> +.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
> +.PP
> +.BI "int open_tree(int " dirfd ", const char *" pathname ", unsigned int " flags );
> +.fi
> +.PP
> +.IR Note :
> +There are no glibc wrappers for these system calls.
> +.SH DESCRIPTION
> +.BR open_tree ()
> +picks the mount object specified by the pathname and attaches it to a new file
> +descriptor or clones it and attaches the clone to the file descriptor.  The
> +resultant file descriptor is indistinguishable from one produced by
> +.BR open "(2) with " O_PATH .
> +.PP
> +In the case that the mount object is cloned, the clone will be "unmounted" and
> +destroyed when the file descriptor is closed if it is not otherwise mounted
> +somewhere by calling
> +.BR move_mount (2).
> +.PP
> +To select a mount object, no permissions are required on the object referred
> +to by the path, but execute (search) permission is required on all of the
> +directories in
> +.I pathname
> +that lead to the object.
> +.PP
> +To clone an object, however, the caller must have mount capabilities and
> +permissions.
> +.PP
> +.BR open_tree ()
> +uses
> +.IR pathname ", " dirfd " and " flags
> +to locate the target object in one of a variety of ways:
> +.TP
> +[*] By absolute path.
> +.I pathname
> +points to an absolute path and
> +.I dirfd
> +is ignored.  The object is looked up by name, starting from the root of the
> +filesystem as seen by the calling process.
> +.TP
> +[*] By cwd-relative path.
> +.I pathname
> +points to a relative path and
> +.IR dirfd " is " AT_FDCWD .
> +The object is looked up by name, starting from the current working directory.
> +.TP
> +[*] By dir-relative path.
> +.I pathname
> +points to relative path and
> +.I dirfd
> +indicates a file descriptor pointing to a directory.  The object is looked up
> +by name, starting from the directory specified by
> +.IR dirfd .
> +.TP
> +[*] By file descriptor.
> +.I pathname
> +is "",
> +.I dirfd
> +indicates a file descriptor and
> +.B AT_EMPTY_PATH
> +is set in
> +.IR flags .
> +The mount attached to the file descriptor is queried directly.  The file
> +descriptor may point to any type of file, not just a directory.
> +
> +.\"______________________________________________________________
> +.PP
> +.I flags
> +can be used to control the operation of the function and to influence a
> +path-based lookup.  A value for
> +.I flags
> +is constructed by OR'ing together zero or more of the following constants:
> +.TP
> +.BR AT_EMPTY_PATH
> +.\" commit 65cfc6722361570bfe255698d9cd4dccaf47570d
> +If
> +.I pathname
> +is an empty string, operate on the file referred to by
> +.IR dirfd
> +(which may have been obtained from
> +.BR open "(2) with"
> +.BR O_PATH ", from " fsmount (2)
> +or from another
> +.BR open_tree ()).
> +If
> +.I dirfd
> +is
> +.BR AT_FDCWD ,
> +the call operates on the current working directory.
> +In this case,
> +.I dirfd
> +can refer to any type of file, not just a directory.
> +This flag is Linux-specific; define
> +.B _GNU_SOURCE
> +.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
> +to obtain its definition.
> +.TP
> +.BR AT_NO_AUTOMOUNT
> +Don't automount the terminal ("basename") component of
> +.I pathname
> +if it is a directory that is an automount point.  This flag allows the
> +automount point itself to be picked up or a mount cloned that is rooted on the
> +automount point.  The
> +.B AT_NO_AUTOMOUNT
> +flag has no effect if the mount point has already been mounted over.
> +This flag is Linux-specific; define
> +.B _GNU_SOURCE
> +.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
> +to obtain its definition.
> +.TP
> +.B AT_SYMLINK_NOFOLLOW
> +If
> +.I pathname
> +is a symbolic link, do not dereference it: instead pick up or clone a mount
> +rooted on the link itself.
> +.TP
> +.B OPEN_TREE_CLOEXEC
> +Set the close-on-exec flag for the new file descriptor.  This will cause the
> +file descriptor to be closed automatically when a process exec's.
> +.TP
> +.B OPEN_TREE_CLONE
> +Rather than directly attaching the selected object to the file descriptor,
> +clone the object, set the root of the new mount object to that point and
> +attach the clone to the file descriptor.
> +.TP
> +.B AT_RECURSIVE
> +This is only permitted in conjunction with OPEN_TREE_CLONE.  It causes the
> +entire mount subtree rooted at the selected spot to be cloned rather than just
> +that one mount object.
> +
> +
> +.SH EXAMPLE
> +The
> +.BR open_tree ()
> +function can be used like the following:
> +.PP
> +.RS
> +.nf
> +fd1 = open_tree(AT_FDCWD, "/mnt", 0);
> +fd2 = open_tree(fd1, "",
> +                AT_EMPTY_PATH | OPEN_TREE_CLONE | AT_RECURSIVE);
> +move_mount(fd2, "", AT_FDCWD, "/mnt2", MOVE_MOUNT_F_EMPTY_PATH);
> +.fi
> +.RE
> +.PP
> +This would attach the path point for "/mnt" to fd1, then it would copy the
> +entire subtree at the point referred to by fd1 and attach that to fd2; lastly,
> +it would attach the clone to "/mnt2".
> +
> +
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.SH RETURN VALUE
> +On success, the new file descriptor is returned.  On error, \-1 is returned,
> +and
> +.I errno
> +is set appropriately.
> +.SH ERRORS
> +.TP
> +.B EACCES
> +Search permission is denied for one of the directories
> +in the path prefix of
> +.IR pathname .
> +(See also
> +.BR path_resolution (7).)
> +.TP
> +.B EBADF
> +.I dirfd
> +is not a valid open file descriptor.
> +.TP
> +.B EFAULT
> +.I pathname
> +is NULL or
> +.IR pathname
> +point to a location outside the process's accessible address space.
> +.TP
> +.B EINVAL
> +Reserved flag specified in
> +.IR flags .
> +.TP
> +.B ELOOP
> +Too many symbolic links encountered while traversing the pathname.
> +.TP
> +.B ENAMETOOLONG
> +.I pathname
> +is too long.
> +.TP
> +.B ENOENT
> +A component of
> +.I pathname
> +does not exist, or
> +.I pathname
> +is an empty string and
> +.B AT_EMPTY_PATH
> +was not specified in
> +.IR flags .
> +.TP
> +.B ENOMEM
> +Out of memory (i.e., kernel memory).
> +.TP
> +.B ENOTDIR
> +A component of the path prefix of
> +.I pathname
> +is not a directory or
> +.I pathname
> +is relative and
> +.I dirfd
> +is a file descriptor referring to a file other than a directory.
> +.SH VERSIONS
> +.BR open_tree ()
> +was added to Linux in kernel 5.2.
> +.SH CONFORMING TO
> +.BR open_tree ()
> +is Linux-specific.
> +.SH NOTES
> +Glibc does not (yet) provide a wrapper for the
> +.BR open_tree ()
> +system call; call it using
> +.BR syscall (2).
> +.SH SEE ALSO
> +.BR fsmount (2),
> +.BR move_mount (2),
> +.BR open (2)
