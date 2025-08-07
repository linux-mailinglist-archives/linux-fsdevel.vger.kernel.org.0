Return-Path: <linux-fsdevel+bounces-56990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD62B1D900
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 15:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C591AA4198
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B53525B301;
	Thu,  7 Aug 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="qVlx1/iP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCED125A651;
	Thu,  7 Aug 2025 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573246; cv=none; b=fehUPYJVQTw1REye0xiMuNmCX1DouT4pDWv1vUrnfqVXdrOdq/d7ZhwP2iot3gNw8ppIc/GKJwf57K2Ru62c9OoaOkWRZHfL1e/AwpjYZMis2Kde+xoj5kNG0qjFSR+g8REgiZAwUOJ0FkFJ6EsmXNcoPs7C+IXMKVtJcD0DL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573246; c=relaxed/simple;
	bh=Qgm/CoBXz9/v65bDenOiZDHQRF1Z+MIZvPWdIYHKQ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvoUGhWd9qWHO7dazDaAPzK1R59A872t3XjxIOjy8yW7l0p/x1weA0ZrjMgRJ94unlza7nifY5/r6b3FnwjLmRpiM4XevXY2aMliSzHZ4zSuzZmceIxLQNlYGAaMYjo5SGq0BN4RDZdq1NF7ewrnMzUdHGbEfNFia9L5ycDilaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=qVlx1/iP; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4byScy2tLWz9slS;
	Thu,  7 Aug 2025 15:27:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754573234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NO5QCtHZzAMHBYWasek+5fB0e7+ik5UZbIZzML+V7Jo=;
	b=qVlx1/iPREyLHtn+aOlB0f5N9+QLXqEc6K9q4TOzqjkj8z84vJH83LCEfmqOLZW+rGtSSX
	sudYa4Kqp001uv81W5UgTAmEHivuPw4QsC+Rwn1O2iP6uM9F/g0uVOxLTgcQnDbn4snCfL
	hxxxMTzc0/VgWtPkEMHKYv/rn1k172zp3iuaG/Vjf9q/T/PKig2c6YzmF6hP/gXKQKPFcn
	jIIloM64pXa4l5wYbvc0dKKns8cvQxkQpQZJVMJWnINbi1rX9WD2aQKYvPZOBfOofFYNv4
	SpUBTWSvA/QYjzwuTUVFVpz3ll8cPaXH7nX0tuhq4Hq34OC18qaeUBVLIe3NMA==
Date: Thu, 7 Aug 2025 23:27:04 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 03/11] fsopen.2: document 'new' mount api
Message-ID: <2025-08-07.1754572878-gory-flags-frail-rant-breezy-habits-pRuwdA@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-3-558a27b8068c@cyphar.com>
 <afty6mfpowwj3kzzbn3p7s4j4ovmput34dtqfzzwa57ocaita4@2jj4qandbnw3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nrgzgbvfs774uita"
Content-Disposition: inline
In-Reply-To: <afty6mfpowwj3kzzbn3p7s4j4ovmput34dtqfzzwa57ocaita4@2jj4qandbnw3>


--nrgzgbvfs774uita
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 03/11] fsopen.2: document 'new' mount api
MIME-Version: 1.0

On 2025-08-07, Alejandro Colomar <alx@kernel.org> wrote:
> Hi Aleksa,
>=20
> On Thu, Aug 07, 2025 at 03:44:37AM +1000, Aleksa Sarai wrote:
> > This is loosely based on the original documentation written by David
> > Howells and later maintained by Christian Brauner, but has been
> > rewritten to be more from a user perspective (as well as fixing a few
> > critical mistakes).
> >=20
> > Co-developed-by: David Howells <dhowells@redhat.com>
> > Co-developed-by: Christian Brauner <brauner@kernel.org>
>=20
> Please use Co-authored-by.  It's documented under CONTRIBUTING.d/:
>=20
> 	$ cat CONTRIBUTING.d/patches/description | grep -A99 Trailer;
> 	    Trailer
> 		Sign your patch with "Signed-off-by:".  Read about the
> 		"Developer's Certificate of Origin" at
> 		<https://www.kernel.org/doc/Documentation/process/submitting-patches.rs=
t>.
> 		When appropriate, other tags documented in that file, such as
> 		"Reported-by:", "Reviewed-by:", "Acked-by:", and "Suggested-by:"
> 		can be added to the patch.  We use "Co-authored-by:" instead of
> 		"Co-developed-by:".  Example:
>=20
> 			Signed-off-by: Alejandro Colomar <alx@kernel.org>
>=20
> I think 'author' is more appropriate than 'developer' for documentation.
> It is also more consistent with the Copyright notice, which assigns
> copyright to the authors (documented in AUTHORS).  And ironically, even
> the kernel documentation about Co-authored-by talks about authorship
> instead of development:
>=20
> 	Co-developed-by: states that the patch was co-created by
> 	multiple developers; it is used to give attribution to
> 	co-authors (in addition to the author attributed by the From:
> 	tag) when several people work on a single patch.

Sure, fixed.

Can you also clarify whether CONTRIBUTING.d/patches/range-diff is
required for submissions? I don't think b4 supports including it (and I
really would prefer to not have to use raw git-send-email again just for
man-pages -- b4 has so many benefits over raw git-send-email). Is the
b4-style changelog I include in the cover-letter sufficient?

I like to think of myself as a fairly prolific git user, but I don't
think I've ever seen --range-diff=3D output in a git-send-email patch
before...

> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  man/man2/fsopen.2 | 319 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 319 insertions(+)
> >=20
> > diff --git a/man/man2/fsopen.2 b/man/man2/fsopen.2
> > new file mode 100644
> > index 000000000000..ad38ef0782be
> > --- /dev/null
> > +++ b/man/man2/fsopen.2
> > @@ -0,0 +1,319 @@
> > +.\" Copyright, the authors of the Linux man-pages project
> > +.\"
> > +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> > +.\"
> > +.TH fsopen 2 (date) "Linux man-pages (unreleased)"
> > +.SH NAME
> > +fsopen \- create a new filesystem context
> > +.SH LIBRARY
> > +Standard C library
> > +.RI ( libc ,\~ \-lc )
> > +.SH SYNOPSIS
> > +.nf
> > +.BR "#include <sys/mount.h>"
> > +.P
> > +.BI "int fsopen(const char *" fsname ", unsigned int " flags ");"
> > +.fi
> > +.SH DESCRIPTION
> > +The
> > +.BR fsopen ()
> > +system call is part of the suite of file descriptor based mount facili=
ties in
> > +Linux.
> > +.P
> > +.BR fsopen ()
> > +creates a blank filesystem configuration context within the kernel
> > +for the filesystem named by
> > +.IR fsname ,
> > +puts the context into creation mode and attaches it to a file descript=
or,
> > +which is then returned.
> > +The calling process must have the
> > +.B \%CAP_SYS_ADMIN
> > +capability in order to create a new filesystem configuration context.
> > +.P
> > +A filesystem configuration context is an in-kernel representation of a=
 pending
> > +transaction,
>=20
> This page still needs semantic newlines.  (Please review all pages
> regarding that.)  (In this specific sentence, I'd break after 'is'.)
>=20
> > +containing a set of configuration parameters that are to be applied
> > +when creating a new instance of a filesystem
> > +(or modifying the configuration of an existing filesystem instance,
> > +such as when using
> > +.BR fspick (2)).
> > +.P
> > +After obtaining a filesystem configuration context with
> > +.BR fsopen (),
> > +the general workflow for operating on the context looks like the follo=
wing:
> > +.IP (1) 5
> > +Pass the filesystem context file descriptor to
> > +.BR fsconfig (2)
> > +to specify any desired filesystem parameters.
> > +This may be done as many times as necessary.
> > +.IP (2)
> > +Pass the same filesystem context file descriptor to
>=20
> Do we need to say "same"?  I guess it's obvious.  Or do you expect
> any confusion if we don't?
>=20
> > +.BR fsconfig (2)
> > +with
> > +.B \%FSCONFIG_CMD_CREATE
> > +to create an instance of the configured filesystem.
> > +.IP (3)
> > +Pass the same filesystem context file descriptor to
> > +.BR fsmount (2)
> > +to create a new mount object for the root of the filesystem,
> > +which is then attached to a new file descriptor.
> > +This also places the filesystem context file descriptor into reconfigu=
ration
> > +mode,
> > +similar to the mode produced by
> > +.BR fspick (2).
> > +.IP (4)
> > +Use the mount object file descriptor as a
> > +.I dirfd
> > +argument to "*at()" system calls;
> > +or attach the mount object to a mount point
> > +by passing the mount object file descriptor to
> > +.BR move_mount (2).
> > +.P
> > +A filesystem context will move between different modes throughout its
> > +lifecycle
> > +(such as the creation phase when created with
> > +.BR fsopen (),
> > +the reconfiguration phase when an existing filesystem instance is sele=
cted by
> > +.BR fspick (2),
> > +and the intermediate "needs-mount" phase between
> > +.\" FS_CONTEXT_NEEDS_MOUNT is the term the kernel uses for this.
> > +.BR \%FSCONFIG_CMD_CREATE
> > +and
> > +.BR fsmount (2)),
> > +which has an impact on what operations are permitted on the filesystem=
 context.
> > +.P
> > +The file descriptor returned by
> > +.BR fsopen ()
> > +also acts as a channel for filesystem drivers to provide more comprehe=
nsive
> > +error, warning, and information messages
>=20
> Should we just say "diagnostic messages" to avoid explicitly mentioning
> all the levels?
>=20
> > +than are normally provided through the standard
> > +.BR errno (3)
> > +interface for system calls.
> > +If an error occurs at any time during the workflow mentioned above,
> > +calling
> > +.BR read (2)
> > +on the filesystem context file descriptor will retrieve any ancillary
> > +information about the encountered errors.
> > +(See the "Message retrieval interface" section for more details on the=
 message
> > +format.)
> > +.P
> > +.I flags
> > +can be used to control aspects of the creation of the filesystem confi=
guration
> > +context file descriptor.
> > +A value for
> > +.I flags
> > +is constructed by bitwise ORing
> > +zero or more of the following constants:
> > +.RS
> > +.TP
> > +.B FSOPEN_CLOEXEC
> > +Set the close-on-exec
> > +.RB ( FD_CLOEXEC )
> > +flag on the new file descriptor.
> > +See the description of the
> > +.B O_CLOEXEC
> > +flag in
> > +.BR open (2)
> > +for reasons why this may be useful.
> > +.RE
> > +.P
> > +A list of filesystems supported by the running kernel
> > +(and thus a list of valid values for
> > +.IR fsname )
> > +can be obtained from
> > +.IR /proc/filesystems .
> > +(See also
> > +.BR proc_filesystems (5).)
> > +.SS Message retrieval interface
> > +When doing operations on a filesystem configuration context,
> > +the filesystem driver may choose to provide ancillary information to u=
serspace
> > +in the form of message strings.
> > +.P
> > +The filesystem context file descriptors returned by
> > +.BR fsopen ()
> > +and
> > +.BR fspick (2)
> > +may be queried for message strings at any time by calling
> > +.BR read (2)
> > +on the file descriptor.
> > +Each call to
> > +.BR read (2)
> > +will return a single message,
> > +prefixed to indicate its class:
> > +.RS
> > +.TP
> > +.B "e <message>"
> > +An error message was logged.
> > +This is usually associated with an error being returned from the corre=
sponding
> > +system call which triggered this message.
> > +.TP
> > +.B "w <message>"
> > +A warning message was logged.
> > +.TP
> > +.B "i <message>"
> > +An informational message was logged.
> > +.RE
> > +.P
> > +Messages are removed from the queue as they are read.
> > +Note that the message queue has limited depth,
> > +so it is possible for messages to get lost.
> > +If there are no messages in the message queue,
> > +.B read(2)
> > +will return no data and
> > +.I errno
> > +will be set to
> > +.BR \%ENODATA .
> > +If the
> > +.I buf
> > +argument to
> > +.BR read (2)
> > +is not large enough to contain the message,
> > +.BR read (2)
> > +will return no data and
> > +.I errno
> > +will be set to
> > +.BR \%EMSGSIZE .
> > +.P
> > +If there are multiple filesystem context file descriptors referencing =
the same
> > +filesystem instance
> > +(such as if you call
> > +.BR fspick (2)
> > +multiple times for the same mount),
> > +each one gets its own independent message queue.
> > +This does not apply to file descriptors that were duplicated with
> > +.BR dup (2).
> > +.P
> > +Messages strings will usually be prefixed by the filesystem driver tha=
t logged
>=20
> s/Messages/Message/
>=20
> BTW, here, I'd break after 'prefixed', and then after the ','.
>=20
> > +the message, though this may not always be the case.
> > +See the Linux kernel source code for details.
> > +.SH RETURN VALUE
> > +On success, a new file descriptor is returned.
> > +On error, \-1 is returned, and
> > +.I errno
> > +is set to indicate the error.
> > +.SH ERRORS
> > +.TP
> > +.B EFAULT
> > +.I fsname
> > +is NULL
> > +or a pointer to a location
> > +outside the calling process's accessible address space.
> > +.TP
> > +.B EINVAL
> > +.I flags
> > +had an invalid flag set.
> > +.TP
> > +.B EMFILE
> > +The calling process has too many open files to create more.
> > +.TP
> > +.B ENFILE
> > +The system has too many open files to create more.
> > +.TP
> > +.B ENODEV
> > +The filesystem named by
> > +.I fsname
> > +is not supported by the kernel.
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
> > +.\" commit 24dcb3d90a1f67fe08c68a004af37df059d74005
> > +glibc 2.36.
> > +.SH EXAMPLES
> > +To illustrate the workflow for creating a new mount,
> > +the following is an example of how to mount an
> > +.BR ext4 (5)
> > +filesystem stored on
> > +.I /dev/sdb1
> > +onto
> > +.IR /mnt .
> > +.P
> > +.in +4n
> > +.EX
> > +int fsfd, mntfd;
> > +\&
> > +fsfd =3D fsopen("ext4", FSOPEN_CLOEXEC);
> > +fsconfig(fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> > +fsconfig(fsfd, FSCONFIG_SET_PATH, "source", "/dev/sdb1", AT_FDCWD);
> > +fsconfig(fsfd, FSCONFIG_SET_FLAG, "noatime", NULL, 0);
> > +fsconfig(fsfd, FSCONFIG_SET_FLAG, "acl", NULL, 0);
> > +fsconfig(fsfd, FSCONFIG_SET_FLAG, "user_xattr", NULL, 0);
> > +fsconfig(fsfd, FSCONFIG_SET_FLAG, "iversion", NULL, 0)
> > +fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> > +mntfd =3D fsmount(fsfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_RELATIME);
> > +move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> > +.EE
> > +.in
> > +.P
> > +First, an ext4 configuration context is created and attached to the fi=
le
>=20
> Here, I'd break after the ',', and if you need to break again, after
> 'created'.
>=20
> > +descriptor
> > +.IR fsfd .
> > +Then, a series of parameters
> > +(such as the source of the filesystem)
> > +are provided using
> > +.BR fsconfig (2),
> > +followed by the filesystem instance being created with
> > +.BR \%FSCONFIG_CMD_CREATE .
> > +.BR fsmount (2)
> > +is then used to create a new mount object attached to the file descrip=
tor
> > +.IR mntfd ,
> > +which is then attached to the intended mount point using
> > +.BR move_mount (2).
> > +.P
> > +The above procedure is functionally equivalent to the following mount =
operation
> > +using
> > +.BR mount (2):
> > +.P
> > +.in +4n
> > +.EX
> > +mount("/dev/sdb1", "/mnt", "ext4", MS_RELATIME,
> > +      "ro,noatime,acl,user_xattr,iversion");
> > +.EE
> > +.in
> > +.P
> > +And here's an example of creating a mount object
> > +of an NFS server share
> > +and setting a Smack security module label.
> > +However, instead of attaching it to a mount point,
> > +the program uses the mount object directly
> > +to open a file from the NFS share.
> > +.P
> > +.in +4n
> > +.EX
> > +int fsfd, mntfd, fd;
> > +\&
> > +fsfd =3D fsopen("nfs", 0);
> > +fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "example.com/pub/linux",=
 0);
> > +fsconfig(fsfd, FSCONFIG_SET_STRING, "nfsvers", "3", 0);
> > +fsconfig(fsfd, FSCONFIG_SET_STRING, "rsize", "65536", 0);
> > +fsconfig(fsfd, FSCONFIG_SET_STRING, "wsize", "65536", 0);
> > +fsconfig(fsfd, FSCONFIG_SET_STRING, "smackfsdef", "foolabel", 0);
> > +fsconfig(fsfd, FSCONFIG_SET_FLAG, "rdma", NULL, 0);
> > +fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> > +mntfd =3D fsmount(fsfd, 0, MOUNT_ATTR_NODEV);
> > +fd =3D openat(mntfd, "src/linux-5.2.tar.xz", O_RDONLY);
> > +.EE
> > +.in
> > +.P
> > +Unlike the previous example,
> > +this operation has no trivial equivalent with
> > +.BR mount (2),
> > +as it was not previously possible to create a mount object
> > +that is not attached to any mount point.
> > +.SH SEE ALSO
> > +.BR fsconfig (2),
> > +.BR fsmount (2),
> > +.BR fspick (2),
> > +.BR mount (2),
> > +.BR mount_setattr (2),
> > +.BR move_mount (2),
> > +.BR open_tree (2),
> > +.BR mount_namespaces (7)
>=20
> Other than those minor comments, the text LGTM.
>=20
>=20
> Cheers,
> Alex
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--nrgzgbvfs774uita
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJSpqAAKCRAol/rSt+lE
bzTYAQCqxIzinyGCOblF9xLs1te7iQ+cOVNWc+eTfYBE1MBoqwEAsadokQXTARx4
e6jQ8dlqT2ybYU3p9hn07YmGtd9cyAY=
=4MzU
-----END PGP SIGNATURE-----

--nrgzgbvfs774uita--

