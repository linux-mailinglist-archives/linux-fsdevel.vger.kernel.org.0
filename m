Return-Path: <linux-fsdevel+bounces-24430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2831193F470
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7401F227C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BDA145FFC;
	Mon, 29 Jul 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="CJV+M+DG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68AE145330;
	Mon, 29 Jul 2024 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253685; cv=none; b=a72gCVCizCt0Q4HPrqPu3AR3Cm2e+u5f9PCy9Kca5+qe/HltiOCONCyfuRyt4tzs8IfsxOwG3ch0j5iUuAuZYIKW1OlXAfmNG3GJWKYsDHYJ/++ANT743CpNPQUXUMhkSjRBRmLckPUPNVhp8y9l5lM2/s6WK40MOLnX9tr7/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253685; c=relaxed/simple;
	bh=s7SuT7s6DzAcQcWzZ2jfx/ybl6s6C2MUhjOmbc5bt5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdOsSZfepR2CeFjdTsD2DqhFl/rwzpd71fYbYpEJd1KmqrqWJQgMS15vh0r8f8Uo0lISYXbzzSA5Om1QKrdswZ2FHGuUZQv5h5wzP6pXU7by2ho87R6ycC7730CArsTQ7Yh4vRhWL5DH8+5aJJU5EL7oXgPi4BT/h4GrbPb4x3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=CJV+M+DG; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WXc701lzQz9syL;
	Mon, 29 Jul 2024 13:47:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1722253676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/XfU/uEXx6KZJxVwg4BEJQGboc/tjpnfUQOZKK0FRM=;
	b=CJV+M+DGwoMbn6eJPUn9AA1BCy1w5ZRvG8jRK+Y8uWgYOjkRjMoAveSklJQdYSWqib5edV
	xrMvQl9PIK2Diyv4urDLCVX9jmW2uNZUNh72oGMp3qY5Zz3Ev6i0nLx9fKoMTfo/tzUJon
	2EF2/Bm6KOaWWbrHe5TeIoP16HYADBtWUMxkU5sqageHNuJvHtEsoL/J1NGpea/je3CZw3
	mVB6buXnYS3Wg/c/BXwBpKe057aUwd4xTkbzHv8/AVesQVlrYnAlLs0LD/BNzZz9vaNUAg
	aTXIjojExYsXGQTWM27n0hUlNIaU95yUhpgjt/D+CsFWV6ciIeKUDYJ1qticaQ==
Date: Mon, 29 Jul 2024 21:47:47 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: Testing if two open descriptors refer to the same inode
Message-ID: <20240729.114221-bumpy.fronds.spare.forts-a2tVepJTDtVb@cyphar.com>
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
 <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
 <875xsoqy58.fsf@oldenburg.str.redhat.com>
 <vmjtzzz7sxctmf7qrf6mw5hdd653elsi423joiiusahei22bft@quvxy4kajtxt>
 <87sevspit1.fsf@oldenburg.str.redhat.com>
 <CAGudoHEBNRE+78n=WEY=Z0ZCnLmDFadisR-K2ah4SUO6uSm4TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uqrjwa2ur5ehxsxd"
Content-Disposition: inline
In-Reply-To: <CAGudoHEBNRE+78n=WEY=Z0ZCnLmDFadisR-K2ah4SUO6uSm4TA@mail.gmail.com>


--uqrjwa2ur5ehxsxd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-29, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On Mon, Jul 29, 2024 at 12:57=E2=80=AFPM Florian Weimer <fweimer@redhat.c=
om> wrote:
> >
> > * Mateusz Guzik:
> >
> > > On Mon, Jul 29, 2024 at 12:40:35PM +0200, Florian Weimer wrote:
> > >> * Mateusz Guzik:
> > >>
> > >> > On Mon, Jul 29, 2024 at 08:55:46AM +0200, Florian Weimer wrote:
> > >> >> It was pointed out to me that inode numbers on Linux are no longer
> > >> >> expected to be unique per file system, even for local file system=
s.
> > >> >
> > >> > I don't know if I'm parsing this correctly.
> > >> >
> > >> > Are you claiming on-disk inode numbers are not guaranteed unique p=
er
> > >> > filesystem? It sounds like utter breakage, with capital 'f'.
> > >>
> > >> Yes, POSIX semantics and traditional Linux semantics for POSIX-like
> > >> local file systems are different.
> > >
> > > Can you link me some threads about this?
> >
> > Sorry, it was an internal thread.  It's supposed to be common knowledge
> > among Linux file system developers.  Aleksa referenced LSF/MM
> > discussions.
> >
>=20
> So much for open development :-P
>=20
> > > I had this in mind (untested modulo compilation):
> > >
> > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > index 300e5d9ad913..5723c3e82eac 100644
> > > --- a/fs/fcntl.c
> > > +++ b/fs/fcntl.c
> > > @@ -343,6 +343,13 @@ static long f_dupfd_query(int fd, struct file *f=
ilp)
> > >       return f.file =3D=3D filp;
> > >  }
> > >
> > > +static long f_dupfd_query_inode(int fd, struct file *filp)
> > > +{
> > > +     CLASS(fd_raw, f)(fd);
> > > +
> > > +     return f.file->f_inode =3D=3D filp->f_inode;
> > > +}
> > > +
> > >  static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
> > >               struct file *filp)
> > >  {
> > > @@ -361,6 +368,9 @@ static long do_fcntl(int fd, unsigned int cmd, un=
signed long arg,
> > >       case F_DUPFD_QUERY:
> > >               err =3D f_dupfd_query(argi, filp);
> > >               break;
> > > +     case F_DUPFD_QUERY_INODE:
> > > +             err =3D f_dupfd_query_inode(argi, filp);
> > > +             break;
> > >       case F_GETFD:
> > >               err =3D get_close_on_exec(fd) ? FD_CLOEXEC : 0;
> > >               break;
> > > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > > index c0bcc185fa48..2e93dbdd8fd2 100644
> > > --- a/include/uapi/linux/fcntl.h
> > > +++ b/include/uapi/linux/fcntl.h
> > > @@ -16,6 +16,8 @@
> > >
> > >  #define F_DUPFD_QUERY        (F_LINUX_SPECIFIC_BASE + 3)
> > >
> > > +#define F_DUPFD_QUERY_INODE (F_LINUX_SPECIFIC_BASE + 4)
> > > +
> > >  /*
> > >   * Cancel a blocking posix lock; internal use only until we expose an
> > >   * asynchronous lock api to userspace:
> >
> > It's certainly much easier to use than name_to_handle_at, so it looks
> > like a useful option to have.
> >
> > Could we return a three-way comparison result for sorting?  Or would
> > that expose too much about kernel pointer values?
> >
>=20
> As is this would sort by inode *address* which I don't believe is of
> any use -- the order has to be assumed arbitrary.
>=20
> Perhaps there is something which is reliably the same and can be
> combined with something else to be unique system-wide (the magic
> handle thing?).
>=20
> But even then you would need to justify trying to sort by fcntl calls,
> which sounds pretty dodgey to me.

Programs need to key things by (dev, ino) currently, so you need to be
able to get some kind of ordinal that you can sort with.

If we really want to make an interface to let you do this without
exposing hashes in statx, then kcmp(2) makes more sense, but having to
keep a file descriptor for each entry in a hashtable would obviously
cause -EMFILE issues.

> Given that thing I *suspect* statx() may want to get extended with
> some guaranteed unique identifier. Then you can sort in userspace all
> you want.

Yeah, this is what the hashed fhandle patch I have does.

> Based on your opening mail I assumed you only need to check 2 files,
> for which the proposed fcntl does the trick.
>=20
> Or to put it differently: there seems to be more to the picture than
> in the opening mail, so perhaps you could outline what you are looking
> for.

Hardlink detection requires creating a hashmap of (dev, ino) to find
hardlinks. Pair-wise checking is not sufficient for that usecase (which
AFAIK is the most common thing people use inode numbers for -- it's at
least probably the most common thing people run in practice since
archive tools do this.)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--uqrjwa2ur5ehxsxd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZqeBYwAKCRAol/rSt+lE
bwnJAP4oTv51+RcPvDPBQrvKsTtuwox2qkQOMIVO+sTn9UNaLwEA6OMkdDb4Ei1Y
qLX2LagGezM1wrlKU42mk/RC13Bg/Q0=
=MCMx
-----END PGP SIGNATURE-----

--uqrjwa2ur5ehxsxd--

