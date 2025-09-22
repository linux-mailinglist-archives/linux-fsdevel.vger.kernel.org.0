Return-Path: <linux-fsdevel+bounces-62380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE53B8FF10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 12:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A2B1881D77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 10:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426E62F5A08;
	Mon, 22 Sep 2025 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="K+/aPYPn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1414213E9C;
	Mon, 22 Sep 2025 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535816; cv=none; b=gPhxEn4DoYxNTahW0xc9qfO+fmPaOfIN/m4LkzSeXsqeR65hjm5BQZPa81xZqHDD7RvDsHSddhnupzXOtSD5V6UHMnw47eDdx+gEJh7HHus8oT4p42sdIkCZx/p26aIkUeRASplcbQgvhv+ckNHFb21QOZch0bolIeVQqjSqXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535816; c=relaxed/simple;
	bh=Gnl8d81npUmowlnMimOjhSPUdZifrwsWHCHqe1hZT34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBTynU8TvA4FW1zRXeVyYMzhsSOBStzHqUqPW5e1NhrwdMVMVj6pxFVdLTqM2gJ1enVsoYKS756LkPT5vf6BtV/9P4/VT/mI5CViItbFwEK0yKyIB7QD1dC2UY6wArXlHsYFQuzCbDZUbSDZjtqVAus7uEEOn/pZQfRiXtnmAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=K+/aPYPn; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cVf4941wwz9t4V;
	Mon, 22 Sep 2025 12:10:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758535801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7OkklCkeVDJf5W7aP+u5WY286GS1mgeg2/ZTMKUofh4=;
	b=K+/aPYPng2cx4gE4MKY/El23a/aYBzQ3peiFEmy7HoNoMqgIQmgzC+xgBUnCzdyv876zsf
	8DV09JOGj0n+r/0AnIGmJHnWub10zImj45HBkVySDeam6SKOOtCEyrf7J30KB6q2KMXEY7
	d+CI0DCI1xhgwhiF0UEV+DbPKgj3uUjKMP1JBi6/n6INjmF1AGunjOeHgnPAyrmOgCxnZq
	yq/cV1FvjzF1CyiiZFT7tz2hZEq1ENJnDspBAYTwsDb1xwfQOxvcu0ebqCo163ARrFXh9X
	lrjhVtTKcXlA8vdv+Z9f3Ws5X/mLAgHBU1Z+LMLEjflHTBgG1cu1OHRcKwldYA==
Date: Mon, 22 Sep 2025 20:09:47 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 07/10] man/man2/open_tree.2: document "new" mount API
Message-ID: <2025-09-22-sneaky-similar-mind-cilantro-u1EJJ2@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-7-1261201ab562@cyphar.com>
 <gyhtwwu7kgkaz5l5h46ll3voypfk74cahpfpmagbngj3va3x7c@pm3pssyst2al>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jaoc7bpsqumxw65g"
Content-Disposition: inline
In-Reply-To: <gyhtwwu7kgkaz5l5h46ll3voypfk74cahpfpmagbngj3va3x7c@pm3pssyst2al>


--jaoc7bpsqumxw65g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 07/10] man/man2/open_tree.2: document "new" mount API
MIME-Version: 1.0

On 2025-09-21, Alejandro Colomar <alx@kernel.org> wrote:
> Hi Aleksa,
>=20
> On Fri, Sep 19, 2025 at 11:59:48AM +1000, Aleksa Sarai wrote:
> > This is loosely based on the original documentation written by David
> > Howells and later maintained by Christian Brauner, but has been
> > rewritten to be more from a user perspective (as well as fixing a few
> > critical mistakes).
> >=20
> > Co-authored-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Co-authored-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  man/man2/open_tree.2 | 498 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 498 insertions(+)
> >=20
> > diff --git a/man/man2/open_tree.2 b/man/man2/open_tree.2
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..7f85df08b43c7b48a9d021d=
bbeb2c60092a2b2d4
> > --- /dev/null
> > +++ b/man/man2/open_tree.2
> > @@ -0,0 +1,498 @@
> > +.\" Copyright, the authors of the Linux man-pages project
> > +.\"
> > +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> > +.\"
> > +.TH open_tree 2 (date) "Linux man-pages (unreleased)"
> > +.SH NAME
> > +open_tree \- open path or create detached mount object and attach to fd
> > +.SH LIBRARY
> > +Standard C library
> > +.RI ( libc ,\~ \-lc )
> > +.SH SYNOPSIS
> > +.nf
> > +.BR "#define _GNU_SOURCE         " "/* See feature_test_macros(7) */"
> > +.BR "#include <fcntl.h>" "          /* Definition of " AT_* " constant=
s */"
> > +.B #include <sys/mount.h>
> > +.P
> > +.BI "int open_tree(int " dirfd ", const char *" path ", unsigned int "=
 flags );
> > +.fi
> > +.SH DESCRIPTION
> > +The
> > +.BR open_tree ()
> > +system call is part of
> > +the suite of file descriptor based mount facilities in Linux.
> > +.IP \[bu] 3
> > +If
> > +.I flags
> > +contains
> > +.BR \%OPEN_TREE_CLONE ,
> > +.BR open_tree ()
> > +creates a detached mount object
> > +which consists of a bind-mount of
> > +the path specified by the
> > +.IR path .
> > +A new file descriptor
> > +associated with the detached mount object
> > +is then returned.
> > +The mount object is equivalent to a bind-mount
> > +that would be created by
> > +.BR mount (2)
> > +called with
> > +.BR MS_BIND ,
> > +except that it is tied to a file descriptor
> > +and is not mounted onto the filesystem.
> > +.IP
> > +As with file descriptors returned from
> > +.BR fsmount (2),
> > +the resultant file descriptor can then be used with
> > +.BR move_mount (2),
> > +.BR mount_setattr (2),
> > +or other such system calls to do further mount operations.
> > +This mount object will be unmounted and destroyed
> > +when the file descriptor is closed
> > +if it was not otherwise attached to a mount point
> > +by calling
> > +.BR move_mount (2).
> > +(Note that the unmount operation on
>=20
> Maybe I would make this note a paragraph of its own; this would give it
> more visibility, I think.  And I'd remove 'Note that', and start
> directly with the noted contents (everything in a manual page must be
> noteworthy, in general).
>=20
> > +.BR close (2)
>=20
> I'm a bit confused by the reference to close(2).  The previous text
> mentions closing, but not close(2), so I'm not sure if this refers to
> that or if it is comparing it to close(2).  Would you mind having a look
> at the wording of this entire paragraph?

Well, it's more that these kinds of file descriptors are marked with
FMODE_NEEDS_UMOUNT which will cause dissolve_on_fput() to be called when
they have no more references.

So this could be through close(2) or any other condition that causes a
file descriptor to be closed (dup2(2), process death, execve with
O_CLOEXEC, etc). Maybe it's better to not mention close(2) explicitly...

> > +is lazy\[em]akin to calling
>=20
> I prefer em dashes in both sides of the parenthetical; it more clearly
> denotes where it ends.
>=20
> 	is lazy
> 	\[em]akin to calling
> 	.BR umount2 (2)
> 	with
> 	.BR MOUNT_DETACH \[em];

An \[em] next to a ";"? Let me see if I can rewrite it to avoid this...

> (I assume that's where it ends.)
>=20
> > +.BR umount2 (2)
> > +with
> > +.BR MOUNT_DETACH ;
> > +any existing open references to files
> > +from the mount object
> > +will continue to work,
> > +and the mount object will only be completely destroyed
> > +once it ceases to be busy.)
> > +.IP \[bu]
> > +If
> > +.I flags
> > +does not contain
> > +.BR \%OPEN_TREE_CLONE ,
> > +.BR open_tree ()
> > +returns a file descriptor
> > +that is exactly equivalent to
> > +one produced by
> > +.BR openat (2)
> > +when called with the same
> > +.I dirfd
> > +and
> > +.IR path .
> > +.P
> > +In either case, the resultant file descriptor
> > +acts the same as one produced by
> > +.BR open (2)
> > +with
> > +.BR O_PATH ,
> > +meaning it can also be used as a
> > +.I dirfd
> > +argument to
> > +"*at()" system calls.
> > +.P
> > +As with "*at()" system calls,
> > +.BR open_tree ()
> > +uses the
> > +.I dirfd
> > +argument in conjunction with the
> > +.I path
> > +argument to determine the path to operate on, as follows:
> > +.IP \[bu] 3
> > +If the pathname given in
> > +.I path
> > +is absolute, then
> > +.I dirfd
> > +is ignored.
> > +.IP \[bu]
> > +If the pathname given in
> > +.I path
> > +is relative and
> > +.I dirfd
> > +is the special value
> > +.BR \%AT_FDCWD ,
> > +then
> > +.I path
> > +is interpreted relative to
> > +the current working directory
> > +of the calling process (like
> > +.BR open (2)).
> > +.IP \[bu]
> > +If the pathname given in
> > +.I path
> > +is relative,
> > +then it is interpreted relative to
> > +the directory referred to by the file descriptor
> > +.I dirfd
> > +(rather than relative to
> > +the current working directory
> > +of the calling process,
> > +as is done by
> > +.BR open (2)
> > +for a relative pathname).
> > +In this case,
> > +.I dirfd
> > +must be a directory
> > +that was opened for reading
> > +.RB ( O_RDONLY )
> > +or using the
> > +.B O_PATH
> > +flag.
> > +.IP \[bu]
> > +If
> > +.I path
> > +is an empty string,
> > +and
> > +.I flags
> > +contains
> > +.BR \%AT_EMPTY_PATH ,
> > +then the file descriptor
> > +.I dirfd
> > +is operated on directly.
> > +In this case,
> > +.I dirfd
> > +may refer to any type of file,
> > +not just a directory.
> > +.P
> > +See
> > +.BR openat (2)
> > +for an explanation of why the
> > +.I dirfd
> > +argument is useful.
> > +.P
> > +.I flags
> > +can be used to control aspects of the path lookup
> > +and properties of the returned file descriptor.
> > +A value for
> > +.I flags
> > +is constructed by bitwise ORing
> > +zero or more of the following constants:
> > +.RS
> > +.TP
> > +.B \%AT_EMPTY_PATH
> > +If
> > +.I path
> > +is an empty string, operate on the file referred to by
> > +.I dirfd
> > +(which may have been obtained from
> > +.BR open (2),
> > +.BR fsmount(2),
> > +or from another
> > +.BR open_tree ()
> > +call).
> > +In this case,
> > +.I dirfd
> > +may refer to any type of file, not just a directory.
> > +If
> > +.I dirfd
> > +is
> > +.BR \%AT_FDCWD ,
> > +.BR open_tree ()
> > +will operate on the current working directory
> > +of the calling process.
> > +This flag is Linux-specific; define
> > +.B \%_GNU_SOURCE
> > +to obtain its definition.
> > +.TP
> > +.B \%AT_NO_AUTOMOUNT
> > +Do not automount the terminal ("basename") component of
> > +.I path
> > +if it is a directory that is an automount point.
> > +This allows you to create a handle to the automount point itself,
> > +rather than the location it would mount.
> > +This flag has no effect if the mount point has already been mounted ov=
er.
> > +This flag is Linux-specific; define
> > +.B \%_GNU_SOURCE
> > +to obtain its definition.
> > +.TP
> > +.B \%AT_SYMLINK_NOFOLLOW
> > +If
> > +.I path
> > +is a symbolic link, do not dereference it; instead,
> > +create either a handle to the link itself
> > +or a bind-mount of it.
> > +The resultant file descriptor is indistinguishable from one produced by
> > +.BR openat (2)
> > +with
> > +.BR \%O_PATH | O_NOFOLLLOW .
> > +.TP
> > +.B \%OPEN_TREE_CLOEXEC
> > +Set the close-on-exec
> > +.RB ( FD_CLOEXEC )
> > +flag on the new file descriptor.
> > +See the description of the
> > +.B O_CLOEXEC
> > +flag in
> > +.BR open (2)
> > +for reasons why this may be useful.
> > +.TP
> > +.B \%OPEN_TREE_CLONE
> > +Rather than creating an
> > +.BR openat (2)-style
> > +.B O_PATH
> > +file descriptor,
> > +create a bind-mount of
> > +.I path
> > +(akin to
> > +.IR "mount --bind" )
>=20
> You need to escape dashes in manual pages.  Otherwise, they're formatted
> as hyphens, which can't be pasted into the terminal (and another
> consequence is not being able to search for them in the man(1) reader
> with literal dashes).
>=20
> Depending on your system, you might be able to search for them or paste
> them to the terminal, because some distros patch this in
> /etc/local/an.tmac, at the expense of generating lower quality pages,
> but in general don't rely on that.
>=20
> I've noticed now, but this probably also happens in previous pages in
> this patch set.
>=20
> While at it, you should also use a non-breaking space, to keep the
> entire command in the same line.
>=20
> 	.IR \%mount\~\-\-bind )

My bad, I think my terminal font doesn't distinguish between them well
enough for it to be obvious. I'll go through and fix up all of these
cases.

Thanks.

> Cheers,
> Alex
>=20
> > +as a detached mount object.
> > +In order to do this operation,
> > +the calling process must have the
> > +.BR \%CAP_SYS_ADMIN
> > +capability.
> > +.TP
> > +.B \%AT_RECURSIVE
> > +Create a recursive bind-mount of the path
> > +(akin to
> > +.IR "mount --rbind" )
> > +as a detached mount object.
> > +This flag is only permitted in conjunction with
> > +.BR \%OPEN_TREE_CLONE .
> > +.SH RETURN VALUE
> > +On success, a new file descriptor is returned.
> > +On error, \-1 is returned, and
> > +.I errno
> > +is set to indicate the error.
> > +.SH ERRORS
> > +.TP
> > +.B EACCES
> > +Search permission is denied for one of the directories
> > +in the path prefix of
> > +.IR path .
> > +(See also
> > +.BR path_resolution (7).)
> > +.TP
> > +.B EBADF
> > +.I path
> > +is relative but
> > +.I dirfd
> > +is neither
> > +.B \%AT_FDCWD
> > +nor a valid file descriptor.
> > +.TP
> > +.B EFAULT
> > +.I path
> > +is NULL
> > +or a pointer to a location
> > +outside the calling process's accessible address space.
> > +.TP
> > +.B EINVAL
> > +Invalid flag specified in
> > +.IR flags .
> > +.TP
> > +.B ELOOP
> > +Too many symbolic links encountered when resolving
> > +.IR path .
> > +.TP
> > +.B EMFILE
> > +The calling process has too many open files to create more.
> > +.TP
> > +.B ENAMETOOLONG
> > +.I path
> > +is longer than
> > +.BR PATH_MAX .
> > +.TP
> > +.B ENFILE
> > +The system has too many open files to create more.
> > +.TP
> > +.B ENOENT
> > +A component of
> > +.I path
> > +does not exist, or is a dangling symbolic link.
> > +.TP
> > +.B ENOENT
> > +.I path
> > +is an empty string, but
> > +.B AT_EMPTY_PATH
> > +is not specified in
> > +.IR flags .
> > +.TP
> > +.B ENOTDIR
> > +A component of the path prefix of
> > +.I path
> > +is not a directory, or
> > +.I path
> > +is relative and
> > +.I dirfd
> > +is a file descriptor referring to a file other than a directory.
> > +.TP
> > +.B ENOSPC
> > +The "anonymous" mount namespace
> > +necessary to contain the
> > +.B \%OPEN_TREE_CLONE
> > +detached bind-mount mount object
> > +could not be allocated,
> > +as doing so would exceed
> > +the configured per-user limit on
> > +the number of mount namespaces in the current user namespace.
> > +(See also
> > +.BR namespaces (7).)
> > +.TP
> > +.B ENOMEM
> > +The kernel could not allocate sufficient memory to complete the operat=
ion.
> > +.TP
> > +.B EPERM
> > +.I flags
> > +contains
> > +.B \%OPEN_TREE_CLONE
> > +but the calling process does not have the required
> > +.B CAP_SYS_ADMIN
> > +capability.
> > +.SH STANDARDS
> > +Linux.
> > +.SH HISTORY
> > +Linux 5.2.
> > +.\" commit a07b20004793d8926f78d63eb5980559f7813404
> > +.\" commit 400913252d09f9cfb8cce33daee43167921fc343
> > +glibc 2.36.
> > +.SH NOTES
> > +.SS Mount propagation
> > +The bind-mount mount objects created by
> > +.BR open_tree ()
> > +with
> > +.B \%OPEN_TREE_CLONE
> > +are not associated with
> > +the mount namespace of the calling process.
> > +Instead, each mount object is placed
> > +in a newly allocated "anonymous" mount namespace
> > +associated with the calling process.
> > +.P
> > +One of the side-effects of this is that
> > +(unlike bind-mounts created with
> > +.BR mount (2)),
> > +mount propagation
> > +(as described in
> > +.BR mount_namespaces (7))
> > +will not be applied to bind-mounts created by
> > +.BR open_tree ()
> > +until the bind-mount is attached with
> > +.BR move_mount (2),
> > +at which point the mount object
> > +will be associated with the mount namespace
> > +where it was attached
> > +and mount propagation will resume.
> > +Note that any mount propagation events that occurred
> > +before the mount object was attached
> > +will
> > +.I not
> > +be propagated to the mount object,
> > +even after it is attached.
> > +.SH EXAMPLES
> > +The following examples show how
> > +.BR open_tree ()
> > +can be used in place of more traditional
> > +.BR mount (2)
> > +calls with
> > +.BR MS_BIND .
> > +.P
> > +.in +4n
> > +.EX
> > +int srcfd =3D open_tree(AT_FDCWD, "/var", OPEN_TREE_CLONE);
> > +move_mount(srcfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> > +.EE
> > +.in
> > +.P
> > +First,
> > +a detached bind-mount mount object of
> > +.I /var
> > +is created
> > +and associated with the file descriptor
> > +.IR srcfd .
> > +Then, the mount object is attached to
> > +.I /mnt
> > +using
> > +.BR move_mount (2)
> > +with
> > +.B \%MOVE_MOUNT_F_EMPTY_PATH
> > +to request that the detached mount object
> > +associated with the file descriptor
> > +.I srcfd
> > +be moved (and thus attached) to
> > +.IR /mnt .
> > +.P
> > +The above procedure is functionally equivalent to
> > +the following mount operation using
> > +.BR mount (2):
> > +.P
> > +.in +4n
> > +.EX
> > +mount("/var", "/mnt", NULL, MS_BIND, NULL);
> > +.EE
> > +.in
> > +.P
> > +.B \%OPEN_TREE_CLONE
> > +can be combined with
> > +.B \%AT_RECURSIVE
> > +to create recursive detached bind-mount mount objects,
> > +which in turn can be attached to mount points
> > +to create recursive bind-mounts.
> > +.P
> > +.in +4n
> > +.EX
> > +int srcfd =3D open_tree(AT_FDCWD, "/var", OPEN_TREE_CLONE | AT_RECURSI=
VE);
> > +move_mount(srcfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> > +.EE
> > +.in
> > +.P
> > +The above procedure is functionally equivalent to
> > +the following mount operation using
> > +.BR mount (2):
> > +.P
> > +.in +4n
> > +.EX
> > +mount("/var", "/mnt", NULL, MS_BIND | MS_REC, NULL);
> > +.EE
> > +.in
> > +.P
> > +One of the primary benefits of using
> > +.BR open_tree ()
> > +and
> > +.BR move_mount (2)
> > +over the traditional
> > +.BR mount (2)
> > +is that operating with
> > +.IR dirfd -style
> > +file descriptors is far easier and more intuitive.
> > +.P
> > +.in +4n
> > +.EX
> > +int srcfd =3D open_tree(100, "", AT_EMPTY_PATH | OPEN_TREE_CLONE);
> > +move_mount(srcfd, "", 200, "foo", MOVE_MOUNT_F_EMPTY_PATH);
> > +.EE
> > +.in
> > +.P
> > +The above procedure is roughly equivalent to
> > +the following mount operation using
> > +.BR mount (2):
> > +.P
> > +.in +4n
> > +.EX
> > +mount("/proc/self/fd/100", "/proc/self/fd/200/foo", NULL, MS_BIND, NUL=
L);
> > +.EE
> > +.in
> > +.P
> > +In addition, you can use the file descriptor returned by
> > +.BR open_tree ()
> > +as the
> > +.I dirfd
> > +argument to any "*at()" system calls:
> > +.P
> > +.in +4n
> > +.EX
> > +int dirfd, fd;
> > +\&
> > +dirfd =3D open_tree(AT_FDCWD, "/etc", OPEN_TREE_CLONE);
> > +fd =3D openat(dirfd, "passwd", O_RDONLY);
> > +fchmodat(dirfd, "shadow", 0000, 0);
> > +close(dirfd);
> > +close(fd);
> > +/* The bind-mount is now destroyed. */
> > +.EE
> > +.in
> > +.SH SEE ALSO
> > +.BR fsconfig (2),
> > +.BR fsmount (2),
> > +.BR fsopen (2),
> > +.BR fspick (2),
> > +.BR mount (2),
> > +.BR mount_setattr (2),
> > +.BR move_mount (2),
> > +.BR mount_namespaces (7)
> >=20
> > --=20
> > 2.51.0
> >=20
> >=20
>=20
> --=20
> <https://www.alejandro-colomar.es>
> Use port 80 (that is, <...:80/>).



--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--jaoc7bpsqumxw65g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaNEgaxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9+hgD/TuomhYqM0TM6TFs1fSNR
Bde7sq0gVnLRMyXZ2Z93saYA/1taQRvNF0c8zRE2hWfbiGHoOJf+sWEd5piCJ0tM
PxIA
=XJ+B
-----END PGP SIGNATURE-----

--jaoc7bpsqumxw65g--

