Return-Path: <linux-fsdevel+bounces-62332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E48EB8D8CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 11:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B46E7B1FCB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24137253B42;
	Sun, 21 Sep 2025 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lu2KfLFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C16189;
	Sun, 21 Sep 2025 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758448049; cv=none; b=eJ1Dpn25OoAdT55Jxsr5T4tAW7VCTjRwCWSCQZuEnm91TyKHP0B1z4Ws0Cl/mDyNUcNfbb5qRO4CQE254kWrhw8QPpsNyW71A4a0xyMhvmop7GdykZt/tF4xhuDf7bKvSzs+86YHY/c5OxxDeuDduEaEne6fP+nE14Ylu15kwx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758448049; c=relaxed/simple;
	bh=N3l8vMvcndbQ0tLN1fFLCV3mWuZhkVisnI3Nb5jd/hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRoQxB3gNWb5nIJYu21DURWIfSqo1laZwODSuSD6Z8IcOPfNY0fw6EjxH0rys0eeINH02y8kfeogmx7IZ3Kab7mm5Ti2a6jDa59wMZluaE0xm04yR6SLrLyxOYcI7FeefgNmageBKcs2/UnkWq8OfiHuu217/czbPWo1k/GAf7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lu2KfLFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE206C4CEE7;
	Sun, 21 Sep 2025 09:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758448048;
	bh=N3l8vMvcndbQ0tLN1fFLCV3mWuZhkVisnI3Nb5jd/hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lu2KfLFzAaxSdFnm5u9ZRv04G+byu8QU/4NyIRCxv1cXUaECcfQQgSPjT7cfPQ5OP
	 7iLhf0HC5M5vbEYKN6qE8f0kfSnLaUbUZjvFFSP/Ehsdd6qoiZp4NEuSJkl7orBAzX
	 AnGbme3U04KqJX1xy4MhxqZaXyD2caLCR53H3ohALwxXghmG6zqyVUP+aLrea4cbQX
	 WA9H4vz8bfGy2HEYWx8k6pJOJ/M3efQ9zHTe/XLYAcThFKUueOlSJ3Yvn2mwL2FeZY
	 19Cb0w4QXw0YbWKIwuQXuL98qUE7BKp+nODCHr+TpmDSID+qjsvqRCxa53l4oV12/8
	 lGIuJy2B71LTA==
Date: Sun, 21 Sep 2025 11:47:21 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 07/10] man/man2/open_tree.2: document "new" mount API
Message-ID: <gyhtwwu7kgkaz5l5h46ll3voypfk74cahpfpmagbngj3va3x7c@pm3pssyst2al>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-7-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uehd373huvo3ruit"
Content-Disposition: inline
In-Reply-To: <20250919-new-mount-api-v4-7-1261201ab562@cyphar.com>


--uehd373huvo3ruit
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 07/10] man/man2/open_tree.2: document "new" mount API
Message-ID: <gyhtwwu7kgkaz5l5h46ll3voypfk74cahpfpmagbngj3va3x7c@pm3pssyst2al>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-7-1261201ab562@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250919-new-mount-api-v4-7-1261201ab562@cyphar.com>

Hi Aleksa,

On Fri, Sep 19, 2025 at 11:59:48AM +1000, Aleksa Sarai wrote:
> This is loosely based on the original documentation written by David
> Howells and later maintained by Christian Brauner, but has been
> rewritten to be more from a user perspective (as well as fixing a few
> critical mistakes).
>=20
> Co-authored-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Co-authored-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  man/man2/open_tree.2 | 498 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 498 insertions(+)
>=20
> diff --git a/man/man2/open_tree.2 b/man/man2/open_tree.2
> new file mode 100644
> index 0000000000000000000000000000000000000000..7f85df08b43c7b48a9d021dbb=
eb2c60092a2b2d4
> --- /dev/null
> +++ b/man/man2/open_tree.2
> @@ -0,0 +1,498 @@
> +.\" Copyright, the authors of the Linux man-pages project
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH open_tree 2 (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +open_tree \- open path or create detached mount object and attach to fd
> +.SH LIBRARY
> +Standard C library
> +.RI ( libc ,\~ \-lc )
> +.SH SYNOPSIS
> +.nf
> +.BR "#define _GNU_SOURCE         " "/* See feature_test_macros(7) */"
> +.BR "#include <fcntl.h>" "          /* Definition of " AT_* " constants =
*/"
> +.B #include <sys/mount.h>
> +.P
> +.BI "int open_tree(int " dirfd ", const char *" path ", unsigned int " f=
lags );
> +.fi
> +.SH DESCRIPTION
> +The
> +.BR open_tree ()
> +system call is part of
> +the suite of file descriptor based mount facilities in Linux.
> +.IP \[bu] 3
> +If
> +.I flags
> +contains
> +.BR \%OPEN_TREE_CLONE ,
> +.BR open_tree ()
> +creates a detached mount object
> +which consists of a bind-mount of
> +the path specified by the
> +.IR path .
> +A new file descriptor
> +associated with the detached mount object
> +is then returned.
> +The mount object is equivalent to a bind-mount
> +that would be created by
> +.BR mount (2)
> +called with
> +.BR MS_BIND ,
> +except that it is tied to a file descriptor
> +and is not mounted onto the filesystem.
> +.IP
> +As with file descriptors returned from
> +.BR fsmount (2),
> +the resultant file descriptor can then be used with
> +.BR move_mount (2),
> +.BR mount_setattr (2),
> +or other such system calls to do further mount operations.
> +This mount object will be unmounted and destroyed
> +when the file descriptor is closed
> +if it was not otherwise attached to a mount point
> +by calling
> +.BR move_mount (2).
> +(Note that the unmount operation on

Maybe I would make this note a paragraph of its own; this would give it
more visibility, I think.  And I'd remove 'Note that', and start
directly with the noted contents (everything in a manual page must be
noteworthy, in general).

> +.BR close (2)

I'm a bit confused by the reference to close(2).  The previous text
mentions closing, but not close(2), so I'm not sure if this refers to
that or if it is comparing it to close(2).  Would you mind having a look
at the wording of this entire paragraph?

> +is lazy\[em]akin to calling

I prefer em dashes in both sides of the parenthetical; it more clearly
denotes where it ends.

	is lazy
	\[em]akin to calling
	.BR umount2 (2)
	with
	.BR MOUNT_DETACH \[em];

(I assume that's where it ends.)

> +.BR umount2 (2)
> +with
> +.BR MOUNT_DETACH ;
> +any existing open references to files
> +from the mount object
> +will continue to work,
> +and the mount object will only be completely destroyed
> +once it ceases to be busy.)
> +.IP \[bu]
> +If
> +.I flags
> +does not contain
> +.BR \%OPEN_TREE_CLONE ,
> +.BR open_tree ()
> +returns a file descriptor
> +that is exactly equivalent to
> +one produced by
> +.BR openat (2)
> +when called with the same
> +.I dirfd
> +and
> +.IR path .
> +.P
> +In either case, the resultant file descriptor
> +acts the same as one produced by
> +.BR open (2)
> +with
> +.BR O_PATH ,
> +meaning it can also be used as a
> +.I dirfd
> +argument to
> +"*at()" system calls.
> +.P
> +As with "*at()" system calls,
> +.BR open_tree ()
> +uses the
> +.I dirfd
> +argument in conjunction with the
> +.I path
> +argument to determine the path to operate on, as follows:
> +.IP \[bu] 3
> +If the pathname given in
> +.I path
> +is absolute, then
> +.I dirfd
> +is ignored.
> +.IP \[bu]
> +If the pathname given in
> +.I path
> +is relative and
> +.I dirfd
> +is the special value
> +.BR \%AT_FDCWD ,
> +then
> +.I path
> +is interpreted relative to
> +the current working directory
> +of the calling process (like
> +.BR open (2)).
> +.IP \[bu]
> +If the pathname given in
> +.I path
> +is relative,
> +then it is interpreted relative to
> +the directory referred to by the file descriptor
> +.I dirfd
> +(rather than relative to
> +the current working directory
> +of the calling process,
> +as is done by
> +.BR open (2)
> +for a relative pathname).
> +In this case,
> +.I dirfd
> +must be a directory
> +that was opened for reading
> +.RB ( O_RDONLY )
> +or using the
> +.B O_PATH
> +flag.
> +.IP \[bu]
> +If
> +.I path
> +is an empty string,
> +and
> +.I flags
> +contains
> +.BR \%AT_EMPTY_PATH ,
> +then the file descriptor
> +.I dirfd
> +is operated on directly.
> +In this case,
> +.I dirfd
> +may refer to any type of file,
> +not just a directory.
> +.P
> +See
> +.BR openat (2)
> +for an explanation of why the
> +.I dirfd
> +argument is useful.
> +.P
> +.I flags
> +can be used to control aspects of the path lookup
> +and properties of the returned file descriptor.
> +A value for
> +.I flags
> +is constructed by bitwise ORing
> +zero or more of the following constants:
> +.RS
> +.TP
> +.B \%AT_EMPTY_PATH
> +If
> +.I path
> +is an empty string, operate on the file referred to by
> +.I dirfd
> +(which may have been obtained from
> +.BR open (2),
> +.BR fsmount(2),
> +or from another
> +.BR open_tree ()
> +call).
> +In this case,
> +.I dirfd
> +may refer to any type of file, not just a directory.
> +If
> +.I dirfd
> +is
> +.BR \%AT_FDCWD ,
> +.BR open_tree ()
> +will operate on the current working directory
> +of the calling process.
> +This flag is Linux-specific; define
> +.B \%_GNU_SOURCE
> +to obtain its definition.
> +.TP
> +.B \%AT_NO_AUTOMOUNT
> +Do not automount the terminal ("basename") component of
> +.I path
> +if it is a directory that is an automount point.
> +This allows you to create a handle to the automount point itself,
> +rather than the location it would mount.
> +This flag has no effect if the mount point has already been mounted over.
> +This flag is Linux-specific; define
> +.B \%_GNU_SOURCE
> +to obtain its definition.
> +.TP
> +.B \%AT_SYMLINK_NOFOLLOW
> +If
> +.I path
> +is a symbolic link, do not dereference it; instead,
> +create either a handle to the link itself
> +or a bind-mount of it.
> +The resultant file descriptor is indistinguishable from one produced by
> +.BR openat (2)
> +with
> +.BR \%O_PATH | O_NOFOLLLOW .
> +.TP
> +.B \%OPEN_TREE_CLOEXEC
> +Set the close-on-exec
> +.RB ( FD_CLOEXEC )
> +flag on the new file descriptor.
> +See the description of the
> +.B O_CLOEXEC
> +flag in
> +.BR open (2)
> +for reasons why this may be useful.
> +.TP
> +.B \%OPEN_TREE_CLONE
> +Rather than creating an
> +.BR openat (2)-style
> +.B O_PATH
> +file descriptor,
> +create a bind-mount of
> +.I path
> +(akin to
> +.IR "mount --bind" )

You need to escape dashes in manual pages.  Otherwise, they're formatted
as hyphens, which can't be pasted into the terminal (and another
consequence is not being able to search for them in the man(1) reader
with literal dashes).

Depending on your system, you might be able to search for them or paste
them to the terminal, because some distros patch this in
/etc/local/an.tmac, at the expense of generating lower quality pages,
but in general don't rely on that.

I've noticed now, but this probably also happens in previous pages in
this patch set.

While at it, you should also use a non-breaking space, to keep the
entire command in the same line.

	.IR \%mount\~\-\-bind )


Cheers,
Alex

> +as a detached mount object.
> +In order to do this operation,
> +the calling process must have the
> +.BR \%CAP_SYS_ADMIN
> +capability.
> +.TP
> +.B \%AT_RECURSIVE
> +Create a recursive bind-mount of the path
> +(akin to
> +.IR "mount --rbind" )
> +as a detached mount object.
> +This flag is only permitted in conjunction with
> +.BR \%OPEN_TREE_CLONE .
> +.SH RETURN VALUE
> +On success, a new file descriptor is returned.
> +On error, \-1 is returned, and
> +.I errno
> +is set to indicate the error.
> +.SH ERRORS
> +.TP
> +.B EACCES
> +Search permission is denied for one of the directories
> +in the path prefix of
> +.IR path .
> +(See also
> +.BR path_resolution (7).)
> +.TP
> +.B EBADF
> +.I path
> +is relative but
> +.I dirfd
> +is neither
> +.B \%AT_FDCWD
> +nor a valid file descriptor.
> +.TP
> +.B EFAULT
> +.I path
> +is NULL
> +or a pointer to a location
> +outside the calling process's accessible address space.
> +.TP
> +.B EINVAL
> +Invalid flag specified in
> +.IR flags .
> +.TP
> +.B ELOOP
> +Too many symbolic links encountered when resolving
> +.IR path .
> +.TP
> +.B EMFILE
> +The calling process has too many open files to create more.
> +.TP
> +.B ENAMETOOLONG
> +.I path
> +is longer than
> +.BR PATH_MAX .
> +.TP
> +.B ENFILE
> +The system has too many open files to create more.
> +.TP
> +.B ENOENT
> +A component of
> +.I path
> +does not exist, or is a dangling symbolic link.
> +.TP
> +.B ENOENT
> +.I path
> +is an empty string, but
> +.B AT_EMPTY_PATH
> +is not specified in
> +.IR flags .
> +.TP
> +.B ENOTDIR
> +A component of the path prefix of
> +.I path
> +is not a directory, or
> +.I path
> +is relative and
> +.I dirfd
> +is a file descriptor referring to a file other than a directory.
> +.TP
> +.B ENOSPC
> +The "anonymous" mount namespace
> +necessary to contain the
> +.B \%OPEN_TREE_CLONE
> +detached bind-mount mount object
> +could not be allocated,
> +as doing so would exceed
> +the configured per-user limit on
> +the number of mount namespaces in the current user namespace.
> +(See also
> +.BR namespaces (7).)
> +.TP
> +.B ENOMEM
> +The kernel could not allocate sufficient memory to complete the operatio=
n.
> +.TP
> +.B EPERM
> +.I flags
> +contains
> +.B \%OPEN_TREE_CLONE
> +but the calling process does not have the required
> +.B CAP_SYS_ADMIN
> +capability.
> +.SH STANDARDS
> +Linux.
> +.SH HISTORY
> +Linux 5.2.
> +.\" commit a07b20004793d8926f78d63eb5980559f7813404
> +.\" commit 400913252d09f9cfb8cce33daee43167921fc343
> +glibc 2.36.
> +.SH NOTES
> +.SS Mount propagation
> +The bind-mount mount objects created by
> +.BR open_tree ()
> +with
> +.B \%OPEN_TREE_CLONE
> +are not associated with
> +the mount namespace of the calling process.
> +Instead, each mount object is placed
> +in a newly allocated "anonymous" mount namespace
> +associated with the calling process.
> +.P
> +One of the side-effects of this is that
> +(unlike bind-mounts created with
> +.BR mount (2)),
> +mount propagation
> +(as described in
> +.BR mount_namespaces (7))
> +will not be applied to bind-mounts created by
> +.BR open_tree ()
> +until the bind-mount is attached with
> +.BR move_mount (2),
> +at which point the mount object
> +will be associated with the mount namespace
> +where it was attached
> +and mount propagation will resume.
> +Note that any mount propagation events that occurred
> +before the mount object was attached
> +will
> +.I not
> +be propagated to the mount object,
> +even after it is attached.
> +.SH EXAMPLES
> +The following examples show how
> +.BR open_tree ()
> +can be used in place of more traditional
> +.BR mount (2)
> +calls with
> +.BR MS_BIND .
> +.P
> +.in +4n
> +.EX
> +int srcfd =3D open_tree(AT_FDCWD, "/var", OPEN_TREE_CLONE);
> +move_mount(srcfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> +.EE
> +.in
> +.P
> +First,
> +a detached bind-mount mount object of
> +.I /var
> +is created
> +and associated with the file descriptor
> +.IR srcfd .
> +Then, the mount object is attached to
> +.I /mnt
> +using
> +.BR move_mount (2)
> +with
> +.B \%MOVE_MOUNT_F_EMPTY_PATH
> +to request that the detached mount object
> +associated with the file descriptor
> +.I srcfd
> +be moved (and thus attached) to
> +.IR /mnt .
> +.P
> +The above procedure is functionally equivalent to
> +the following mount operation using
> +.BR mount (2):
> +.P
> +.in +4n
> +.EX
> +mount("/var", "/mnt", NULL, MS_BIND, NULL);
> +.EE
> +.in
> +.P
> +.B \%OPEN_TREE_CLONE
> +can be combined with
> +.B \%AT_RECURSIVE
> +to create recursive detached bind-mount mount objects,
> +which in turn can be attached to mount points
> +to create recursive bind-mounts.
> +.P
> +.in +4n
> +.EX
> +int srcfd =3D open_tree(AT_FDCWD, "/var", OPEN_TREE_CLONE | AT_RECURSIVE=
);
> +move_mount(srcfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> +.EE
> +.in
> +.P
> +The above procedure is functionally equivalent to
> +the following mount operation using
> +.BR mount (2):
> +.P
> +.in +4n
> +.EX
> +mount("/var", "/mnt", NULL, MS_BIND | MS_REC, NULL);
> +.EE
> +.in
> +.P
> +One of the primary benefits of using
> +.BR open_tree ()
> +and
> +.BR move_mount (2)
> +over the traditional
> +.BR mount (2)
> +is that operating with
> +.IR dirfd -style
> +file descriptors is far easier and more intuitive.
> +.P
> +.in +4n
> +.EX
> +int srcfd =3D open_tree(100, "", AT_EMPTY_PATH | OPEN_TREE_CLONE);
> +move_mount(srcfd, "", 200, "foo", MOVE_MOUNT_F_EMPTY_PATH);
> +.EE
> +.in
> +.P
> +The above procedure is roughly equivalent to
> +the following mount operation using
> +.BR mount (2):
> +.P
> +.in +4n
> +.EX
> +mount("/proc/self/fd/100", "/proc/self/fd/200/foo", NULL, MS_BIND, NULL);
> +.EE
> +.in
> +.P
> +In addition, you can use the file descriptor returned by
> +.BR open_tree ()
> +as the
> +.I dirfd
> +argument to any "*at()" system calls:
> +.P
> +.in +4n
> +.EX
> +int dirfd, fd;
> +\&
> +dirfd =3D open_tree(AT_FDCWD, "/etc", OPEN_TREE_CLONE);
> +fd =3D openat(dirfd, "passwd", O_RDONLY);
> +fchmodat(dirfd, "shadow", 0000, 0);
> +close(dirfd);
> +close(fd);
> +/* The bind-mount is now destroyed. */
> +.EE
> +.in
> +.SH SEE ALSO
> +.BR fsconfig (2),
> +.BR fsmount (2),
> +.BR fsopen (2),
> +.BR fspick (2),
> +.BR mount (2),
> +.BR mount_setattr (2),
> +.BR move_mount (2),
> +.BR mount_namespaces (7)
>=20
> --=20
> 2.51.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--uehd373huvo3ruit
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjPyaMACgkQ64mZXMKQ
wqlUyQ//Xyii1xOztQ4IilMY5soVdsJ6qA2Ed8ZAenh2pn9c7AJKFS2H/kUuJ8U8
LIXi2uA4P/yHwW0fEZyPAZM5ys+37yEK9y0Ik1WyY3JiWfy14yrSq/M54CdFRj6w
rr1QgyB9IxixnbrbzHjJM+zSESpcJZ5IYuJMlFVB74BqAC+ObTbuiQhdhMyUh9sl
ax3JFztTogoKcsYOjwIrBHmfhfB6OGaE/N9foNDDYTYYIqrnanPMO9RhTRPD/zCn
PLoL1FKxOYpq2WJvBueXsKUgAakY1KEyfX1n8dBfd75p4C5iADqWBwwSL40rci+8
vfx7Xiu+dqjOK887xywT6dzX2B6beu//l3axKpxJ8vHCNwa90VWzr/0eAYgi+sxP
x1nlSBy0zDiHKXIJbVwPJg2T7nnzcGj29alvfokRs8799V9YJ6oGSMZQCLwrT03D
Nte4USQztkDIUQzBdeoMe+ZwH4B29WSefPcHnGAVg2UUGavDSGLX/taI++BiCszm
UFWj3QkUfd/4WjE8Q4yFpYjJXT+ehjNJNo91QWh5xQHXrmeeN9gMyxPIbdmKYfBW
NOlWApYFgZBzdgC0smdHcCFjQ1V5Heayup+uosRFeLCR0hj/MVNWqfz+ZGzrxqlr
ENBcQ3jdZSuf5eHo8BbX9XWuUKKXWrC2ygXT/MCBazRC3J6bPA8=
=5GNW
-----END PGP SIGNATURE-----

--uehd373huvo3ruit--

