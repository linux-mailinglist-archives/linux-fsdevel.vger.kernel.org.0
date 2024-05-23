Return-Path: <linux-fsdevel+bounces-20071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D94C8CDABE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 21:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500DA1C22D9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 19:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC9683A14;
	Thu, 23 May 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="kTSDAl7v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101FEC7;
	Thu, 23 May 2024 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491828; cv=none; b=ZzSZ2l34AMS8PXDupLgBGvSv0AqCOYh1hiL3q8AT4YTxNpSuGclpGXoqI2rNmhi/Q3C8P4y6mNWxaMESMp8qq8wVpXvy780Eo+0EqN+FpFbc4JA6KcM1IkQBSvZLkBe+5iqiaXomjTjOZdRQ5fxSaHtIi4At7lG5NySGnsuEDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491828; c=relaxed/simple;
	bh=uNGUNQ9KsgsDZadcwyQlZ1D5JgSmqisnB6q4PPRM+co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otfuWsHBO2xls9Bzi+BZm98p5o363imXQjA6vfjW8NGKjYZMOPLuCNoyrdtECIbCmMbW9qtwMS2UyMNPV9qXdY0raBh+iEOSeQP81IlY8uyBRkZSOu2QZmwJzn5HMqvkZHCBwxu0BpaMTG2Lcs5CYDhxRm34lvZ2d5gsHLjr8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=kTSDAl7v; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VldG44NCDz9sqJ;
	Thu, 23 May 2024 21:17:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1716491820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNGUNQ9KsgsDZadcwyQlZ1D5JgSmqisnB6q4PPRM+co=;
	b=kTSDAl7vHeF57kcnonDRQSc3BeqErTPPT6cDqYrdAkfygq+3nVu7aBINjkNaa6sA92i71Q
	bCJwynKZkXM07tVt6/NJeu3c5YaWiiEOb8/rWep3kIN4bTHmL8ZuqVZcEN+8g3huITrzF1
	XfDWYqnQxLaBTsgJory/gvVRMTuGZvJ99V5UVp+nsFM7xLeyRTsV6lVIqC6vsFRPCgfA0k
	Xtn2AK87xA/mSlJPglyPUOdXuxGbEMDNZK1DNL/vyCC985nIbT1F7bqnCGp+regWjB2oLn
	oa0Z7IbTCoABUna5UUEvLCQ4/95+rwrWVAcwCNbKp/K8YW9v6h5ZrYw1qPW88g==
Date: Thu, 23 May 2024 13:16:53 -0600
From: Aleksa Sarai <cyphar@cyphar.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
Message-ID: <20240523.173855-tight.bourbon.gnarly.guest-p8Vv3g4JQ9A9@cyphar.com>
References: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
 <20240521-verplanen-fahrschein-392a610d9a0b@brauner>
 <20240521-patentfrei-weswegen-0395678c9f9a@brauner>
 <d225561221f558fe917e5554102394ce778a3758.camel@kernel.org>
 <CAOQ4uxhbOzzawKeCNSCbFtPZAfiZFDXCqK4b_VSXeNyHxpbQsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="koyebb3xfqadvath"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhbOzzawKeCNSCbFtPZAfiZFDXCqK4b_VSXeNyHxpbQsw@mail.gmail.com>


--koyebb3xfqadvath
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-21, Amir Goldstein <amir73il@gmail.com> wrote:
> On Tue, May 21, 2024 at 5:27=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >
> > On Tue, 2024-05-21 at 16:11 +0200, Christian Brauner wrote:
> > > On Tue, May 21, 2024 at 03:46:06PM +0200, Christian Brauner wrote:
> > > > On Mon, May 20, 2024 at 05:35:49PM -0400, Aleksa Sarai wrote:
> > > > > Now that we have stabilised the unique 64-bit mount ID interface =
in
> > > > > statx, we can now provide a race-free way for name_to_handle_at(2=
) to
> > > > > provide a file handle and corresponding mount without needing to =
worry
> > > > > about racing with /proc/mountinfo parsing.
> > > > >
> > > > > As with AT_HANDLE_FID, AT_HANDLE_UNIQUE_MNT_ID reuses a statx AT_=
* bit
> > > > > that doesn't make sense for name_to_handle_at(2).
> > > > >
> > > > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > > ---
> > > >
> > > > So I think overall this is probably fine (famous last words). If it=
's
> > > > just about being able to retrieve the new mount id without having to
> > > > take the hit of another statx system call it's indeed a bit much to
> > > > add a revised system call for this. Althoug I did say earlier that I
> > > > wouldn't rule that out.
> > > >
> > > > But if we'd that then it'll be a long discussion on the form of the=
 new
> > > > system call and the information it exposes.
> > > >
> > > > For example, I lack the grey hair needed to understand why
> > > > name_to_handle_at() returns a mount id at all. The pitch in commit
> > > > 990d6c2d7aee ("vfs: Add name to file handle conversion support") is=
 that
> > > > the (old) mount id can be used to "lookup file system specific
> > > > information [...] in /proc/<pid>/mountinfo".
> > > >
> > > > Granted, that's doable but it'll mean a lot of careful checking to =
avoid
> > > > races for mount id recycling because they're not even allocated
> > > > cyclically. With lots of containers it becomes even more of an issu=
e. So
> > > > it's doubtful whether exposing the mount id through name_to_handle_=
at()
> > > > would be something that we'd still do.
> > > >
> > > > So really, if this is just about a use-case where you want to spare=
 the
> > > > additional system call for statx() and you need the mnt_id then
> > > > overloading is probably ok.
> > > >
> > > > But it remains an unpleasant thing to look at.
> > >
> > > And I'd like an ok from Jeff and Amir if we're going to try this. :)
> >
> > I don't have strong feelings about it other than "it looks sort of
> > ugly", so I'm OK with doing this.
> >
> > I suspect we will eventually need name_to_handle_at2, or something
> > similar, as it seems like we're starting to grow some new use-cases for
> > filehandles, and hitting the limits of the old syscall. I don't have a
> > good feel for what that should look like though, so I'm happy to put
> > that off for a while.
>=20
> I'm ok with it, but we cannot possibly allow it without any bikeshedding.=
=2E.
>=20
> Please call it AT_HANDLE_MNT_ID_UNIQUE to align with
> STATX_MNT_ID_UNIQUE
>=20
> and as I wrote, I do not like overloading the AT_*_SYNC flags
> and as there is no other obvious candidate to overload, so
> I think that it is best to at least declare in a comment that
>=20
> /* 0x00ff flags are reserved for per-syscall flags */
>=20
> and use one of those bits for AT_HANDLE_MNT_ID_UNIQUE.

I can switch the flag to use 0x80, but given there are already
exceptions to that rule, it seems unlikely that this is going to be a
strong guarantee going forward. I will add a comment though.

Note that this will mean that we are planning to only have 15 remaining
generic AT_* flags.

> It does not matter whether we decide to unify the AT_ flags
> namespace with RENAME_ flags namespace or not.
>=20
> The fact that there is a syscall named renameat2() with a flags
> argument, means that someone is bound to pass in an AT_ flags
> in this syscall sooner or later, so the least we can do is try to
> delay the day that this will not result in EINVAL.

While there is a risk this could happen, in theory a user could also
incorrectly pass AT_* to open(). While ergonomics is important, I think
that most users generally read the docs when figuring out how to use
flags for syscalls (mainly because we don't have a unified flag
namespace for all syscalls) so I don't think this is a huge problem.

(But I'm sure I was part of making this problem worse with RESOLVE_*
flags.)

> Thanks,
> Amir.
>=20
> P.S.: As I mentioned to Jeff in LSFMM, I have a patch in my tree
> to add AT_HANDLE_CONNECTABLE which I have not yet
> decided if it is upstream worthy.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--koyebb3xfqadvath
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZk+WJQAKCRAol/rSt+lE
by4TAQCQNUX2D7HCh+NV0JF21tYfwHBNUcQ/1BWdJAddqW2nqgD9Hwc/zOJ0PXj2
huGbDPFBr/cHKpn0xPi/6A7iy0pjuAU=
=2vgL
-----END PGP SIGNATURE-----

--koyebb3xfqadvath--

