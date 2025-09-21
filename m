Return-Path: <linux-fsdevel+bounces-62342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E38B8DD01
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 16:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B234B17A11F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 14:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD01B4257;
	Sun, 21 Sep 2025 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Y5TUP4/O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6325C2D1;
	Sun, 21 Sep 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758466545; cv=none; b=AfX4t0VIBWzAgzve+Zr5oqu8PF+TVT/N85XFM1g/8u356EwvjTzLjZNLgCrCp8ujJK8W2kL+dcCJ5GRAgXmIoOERfnMdts7DQPq8ocw8tRGTNHTTLAh3V1ZQq+GO0Motl5XbJG6IDDr81kXZJ0yMTPyC6Crr1xlkZSVAoplgYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758466545; c=relaxed/simple;
	bh=IuxgQBWxM9ygLmpOeoirh3f+NbyN1PvuH7cg3G+sDU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVwmSMut35BmiYOZgHYrR6/HZDjmzivJPpE4MUllkx5VcbJoHRvzPIl0shVHagbRbcILWAIYHuI5WjNtHiPXiLGm29zLIrZBEPywPxLUWvxA5DbR40112IP9k42XaOBkx/dt1x0KVYyj+vDZqLyYassvGC1Qs9ZehiC/Er5YNsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Y5TUP4/O; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cV8S53QSGz9smD;
	Sun, 21 Sep 2025 16:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758466533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUF9O+4P8gUoEzDJe6pIN7nXM72zkCCFOQ1IX97fyzw=;
	b=Y5TUP4/OdqGP0ychke2oPdLPCEuFmQe9oziw4bGzieyeywC5sBCVmz88tEChT0l+0PPsIR
	DisFYskSfJWf2ZAvyjZIxAuvsNFISdoVd+vS1kGTVzjV/Yf7Drcngtk/CclU3gQCL/Y6n8
	2EXVsI1RjwcjJXv7h0Qhm+fjJBXCu4c+bCybOS2PYjo6Aeuflzh0f12gGyF+ADUEZHvtxO
	6KMdcOEAboe1fEFXe4ftJ18MCeMP559fCM96UVPdEqaCLviN8p9eDCbxONxNpdpc7m7O9F
	hmraAkYDwGMQBnkOBNwgOxshggade4dFsYOJ1Mfvk/mRpcG1BFzKT7VRTVg5gA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Mon, 22 Sep 2025 00:55:13 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 03/10] man/man2/fspick.2: document "new" mount API
Message-ID: <2025-09-21-petite-busy-mucus-rite-01PHer@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-3-1261201ab562@cyphar.com>
 <y77zyujsduf5furdf2biphuszil63kftb44cs74ed2d2hf2gdr@hci7mzt6yh7b>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6etozccxc3u6ln2x"
Content-Disposition: inline
In-Reply-To: <y77zyujsduf5furdf2biphuszil63kftb44cs74ed2d2hf2gdr@hci7mzt6yh7b>
X-Rspamd-Queue-Id: 4cV8S53QSGz9smD


--6etozccxc3u6ln2x
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 03/10] man/man2/fspick.2: document "new" mount API
MIME-Version: 1.0

On 2025-09-21, Alejandro Colomar <alx@kernel.org> wrote:
> Hi Aleksa,
>=20
> On Fri, Sep 19, 2025 at 11:59:44AM +1000, Aleksa Sarai wrote:
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
> >  man/man2/fspick.2 | 342 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 342 insertions(+)
> >=20
> > diff --git a/man/man2/fspick.2 b/man/man2/fspick.2
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..1f87293f44658adeb7ab7cf=
febcac3174888f040
> > --- /dev/null
> > +++ b/man/man2/fspick.2
> > @@ -0,0 +1,342 @@
> > +.\" Copyright, the authors of the Linux man-pages project
> > +.\"
> > +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> > +.\"
> > +.TH fspick 2 (date) "Linux man-pages (unreleased)"
> > +.SH NAME
> > +fspick \- select filesystem for reconfiguration
> > +.SH LIBRARY
> > +Standard C library
> > +.RI ( libc ,\~ \-lc )
> > +.SH SYNOPSIS
> > +.nf
> > +.BR "#include <fcntl.h>" "          /* Definition of " AT_* " constant=
s */"
> > +.B #include <sys/mount.h>
> > +.P
> > +.BI "int fspick(int " dirfd ", const char *" path ", unsigned int " fl=
ags );
> > +.fi
> > +.SH DESCRIPTION
> > +The
> > +.BR fspick ()
> > +system call is part of
> > +the suite of file descriptor based mount facilities in Linux.
> > +.P
> > +.BR fspick()
> > +creates a new filesystem configuration context
> > +for the extant filesystem instance
> > +associated with the path described by
> > +.IR dirfd
> > +and
> > +.IR path ,
> > +places it into reconfiguration mode
> > +(similar to
> > +.BR mount (8)
> > +with the
> > +.I -o remount
> > +option).
> > +A new file descriptor
> > +associated with the filesystem configuration context
> > +is then returned.
> > +The calling process must have the
> > +.BR CAP_SYS_ADMIN
>=20
> This should use '.B. (Bold).  BR means alternating Bold and Roman, but
> this only has one token, so it can't alternate.
>=20
> If you run `make -R build-catman-troff`, this will trigger a diagnostic:
>=20
> 	an.tmac: <page>:<line>: style: .BR expects at least 2 arguments, got 1

Grr, I thought I fixed all of these. I must've changed it in a rework
and forgot to fix it.

> > +capability in order to create a new filesystem configuration context.
> > +.P
> > +The resultant file descriptor can be used with
> > +.BR fsconfig (2)
> > +to specify the desired set of changes to
> > +filesystem parameters of the filesystem instance.
> > +Once the desired set of changes have been configured,
> > +the changes can be effectuated by calling
> > +.BR fsconfig (2)
> > +with the
> > +.B \%FSCONFIG_CMD_RECONFIGURE
> > +command.
> > +Please note that\[em]in contrast to
> > +the behaviour of
> > +.B MS_REMOUNT
> > +with
> > +.BR mount (2)\[em] fspick ()
>=20
> Only have one important keyword per macro call.  In this case, I prefer
> em dashes to only be attached to one side, as if they were parentheses,
> so we don't need any tricks:
>=20
> 	Please note that
> 	\[em]in contrast to
> 	...
> 	.BR mount (2)\[em]
> 	.BR fspick ()

Based on my testing, doing it that way adds whitespace to one side of
the em dash and typographically em dashes should not have whitespace on
either side AFAIK. If there is a way to get the layout right without
breaking the "one macro per line" rule, I'd love to know! :D

> > +instantiates the filesystem configuration context
> > +with a copy of
> > +the extant filesystem's filesystem parameters,
> > +meaning that a subsequent
> > +.B \%FSCONFIG_CMD_RECONFIGURE
> > +operation
> > +will only update filesystem parameters
> > +explicitly modified with
> > +.BR fsconfig (2).
> > +.P
> > +As with "*at()" system calls,
> > +.BR fspick ()
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
> > +.BR \%FSPICK_EMPTY_PATH ,
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
> > +can be used to control aspects of how
> > +.I path
> > +is resolved and
> > +properties of the returned file descriptor.
> > +A value for
> > +.I flags
> > +is constructed by bitwise ORing
> > +zero or more of the following constants:
> > +.RS
> > +.TP
> > +.B FSPICK_CLOEXEC
> > +Set the close-on-exec
> > +.RB ( FD_CLOEXEC )
> > +flag on the new file descriptor.
> > +See the description of the
> > +.B O_CLOEXEC
> > +flag in
> > +.BR open (2)
> > +for reasons why this may be useful.
> > +.TP
> > +.B FSPICK_EMPTY_PATH
> > +If
> > +.I path
> > +is an empty string,
> > +operate on the file referred to by
> > +.I dirfd
> > +(which may have been obtained from
> > +.BR open (2),
> > +.BR fsmount (2),
> > +or
> > +.BR open_tree (2)).
> > +In this case,
> > +.I dirfd
> > +may refer to any type of file,
> > +not just a directory.
> > +If
> > +.I dirfd
> > +is
> > +.BR \%AT_FDCWD ,
> > +.BR fspick ()
> > +will operate on the current working directory
> > +of the calling process.
> > +.TP
> > +.B FSPICK_SYMLINK_NOFOLLOW
> > +Do not follow symbolic links
> > +in the terminal component of
> > +.IR path .
> > +If
> > +.I path
> > +references a symbolic link,
> > +the returned filesystem context will reference
> > +the filesystem that the symbolic link itself resides on.
> > +.TP
> > +.B FSPICK_NO_AUTOMOUNT
> > +Do not automount any automount points encountered
> > +while resolving
> > +.IR path .
> > +This allows you to reconfigure an automount point,
> > +rather than the location that would be mounted.
> > +This flag has no effect if
> > +the automount point has already been mounted over.
>=20
> I'll amend other similar issues if I find them, but in general, I'd put
> the 'if' in the next line, as it is more tied to that part of the
> sentence (think for example that if you reversed the sentence to say
> "if ..., then ...", you'd move the 'if' with what follows it.  You don't
> need to search for all of these and fix them; just keep it in mind for
> next time.  In general I like the break points you used.
>=20
>=20
> Have a lovely day!
> Alex
>=20
> > +.RE
> > +.P
> > +As with filesystem contexts created with
> > +.BR fsopen (2),
> > +the file descriptor returned by
> > +.BR fspick ()
> > +may be queried for message strings at any time by calling
> > +.BR read (2)
> > +on the file descriptor.
> > +(See the "Message retrieval interface" subsection in
> > +.BR fsopen (2)
> > +for more details on the message format.)
> > +.SH RETURN VALUE
> > +On success, a new file descriptor is returned.
> > +On error, \-1 is returned, and
> > +.I errno
> > +is set to indicate the error.
> > +.SH ERRORS
> > +.TP
> > +.B EACCES
> > +Search permission is denied
> > +for one of the directories
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
> > +does not exist,
> > +or is a dangling symbolic link.
> > +.TP
> > +.B ENOENT
> > +.I path
> > +is an empty string, but
> > +.B \%FSPICK_EMPTY_PATH
> > +is not specified in
> > +.IR flags .
> > +.TP
> > +.B ENOTDIR
> > +A component of the path prefix of
> > +.I path
> > +is not a directory;
> > +or
> > +.I path
> > +is relative and
> > +.I dirfd
> > +is a file descriptor referring to a file other than a directory.
> > +.TP
> > +.B ENOMEM
> > +The kernel could not allocate sufficient memory to complete the operat=
ion.
> > +.TP
> > +.B EPERM
> > +The calling process does not have the required
> > +.B \%CAP_SYS_ADMIN
> > +capability.
> > +.SH STANDARDS
> > +Linux.
> > +.SH HISTORY
> > +Linux 5.2.
> > +.\" commit cf3cba4a429be43e5527a3f78859b1bfd9ebc5fb
> > +.\" commit 400913252d09f9cfb8cce33daee43167921fc343
> > +glibc 2.36.
> > +.SH EXAMPLES
> > +The following example sets the read-only flag
> > +on the filesystem instance referenced by
> > +the mount object attached at
> > +.IR /tmp .
> > +.P
> > +.in +4n
> > +.EX
> > +int fsfd =3D fspick(AT_FDCWD, "/tmp", FSPICK_CLOEXEC);
> > +fsconfig(fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> > +fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);
> > +.EE
> > +.in
> > +.P
> > +The above procedure is roughly equivalent to
> > +the following mount operation using
> > +.BR mount (2):
> > +.P
> > +.in +4n
> > +.EX
> > +mount(NULL, "/tmp", NULL, MS_REMOUNT | MS_RDONLY, NULL);
> > +.EE
> > +.in
> > +.P
> > +With the notable caveat that
> > +in this example,
> > +.BR mount (2)
> > +will clear all other filesystem parameters
> > +(such as
> > +.B MS_NOSUID
> > +or
> > +.BR MS_NOEXEC );
> > +.BR fsconfig (2)
> > +will only modify the
> > +.I ro
> > +parameter.
> > +.SH SEE ALSO
> > +.BR fsconfig (2),
> > +.BR fsmount (2),
> > +.BR fsopen (2),
> > +.BR mount (2),
> > +.BR mount_setattr (2),
> > +.BR move_mount (2),
> > +.BR open_tree (2),
> > +.BR mount_namespaces (7)
> > +
> >=20
> > --=20
> > 2.51.0
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

--6etozccxc3u6ln2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaNAR0RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG++vgD/bcWK/b5PJ2VOEKGHRudy
SkeYLPfU56mIwvSta/B3tjsBANGKhHpshpyn/JzHawAswD5Lyyl8ThHRXoPkvaRy
hcoJ
=8xO8
-----END PGP SIGNATURE-----

--6etozccxc3u6ln2x--

