Return-Path: <linux-fsdevel+bounces-20703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09CB8D6EC5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 10:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC951F26451
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 08:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FB51CD15;
	Sat,  1 Jun 2024 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="SxrpDJHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88514182AE;
	Sat,  1 Jun 2024 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717229573; cv=none; b=Pnx+Ussx7d18479wVODtTlMiiNh7GtXZLc1GRu2tEZOuTaEHYS9S66LZA9LVxqTLuza06SbcevEfY/KoENAE5piB3IGPuigP32uFSIqtVXg33RiqGtOaQn2iOYDzdem/YK6eeTY9TZ74NxwsJJYbzQ3RvWQhYScv0fUnKqFq3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717229573; c=relaxed/simple;
	bh=LMFNHZx2OS+11E4fqkCWlelAlM1P1mIosQaCLmNtFR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/OL2TG/YbIdp0q9mVeTnYErYBMFx2Zpyo7b0leAjOUyLB3WHL0G8a8sG8IstCkiAAi+MOPDjlliTm1Jkc1CqbJ64clp3I4Dg+2tkCSiMpnknwPCE0AtZ5yjBagxetKVLytU7Uk79qP7IgYgOnT/O72hl9xmT2H34tBjMnYUDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=SxrpDJHg; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Vrt5W24kgz9scH;
	Sat,  1 Jun 2024 10:12:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1717229567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LMFNHZx2OS+11E4fqkCWlelAlM1P1mIosQaCLmNtFR4=;
	b=SxrpDJHgUtluler1JGk8nbuRCkNIYoh0Mb/8TDntRHxtK43Cm2m4Th+NayLYW4zcvtubsW
	PQi0yAPSfjNhLRBnbqG+BwmkG/cfJjS1FH604dZBWW4WJEpUzSmicvpHkbLQH8pw4q21uR
	O7ZlC6qz0k4osz+EjXLbCgXwaiVKN013z+8iLNX4s4veQbcPXMWsO573P0TJ4Xp5gEABN6
	M6G7tXCBbsAw8HSMNjqImCyev+JjsB3Zz+nqirjstRIsJLRNuIZSPOxLT8ASSAeS+toaXR
	yGFdSlNYew44o2RnsYC+0193surm6O19EYSlbw6N20+/IPRJVmp6bkfkFIgpNA==
Date: Sat, 1 Jun 2024 01:12:31 -0700
From: Aleksa Sarai <cyphar@cyphar.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240529.013815-fishy.value.nervous.brutes-FzobWXrzoo2@cyphar.com>
References: <ZlRy7EBaV04F2UaI@infradead.org>
 <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org>
 <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
 <ZlWVkJwwJ0-B-Zyl@infradead.org>
 <20240528-gesell-evakuieren-899c08cbfa06@brauner>
 <ZlW4IWMYxtwbeI7I@infradead.org>
 <20240528-gipfel-dilemma-948a590a36fd@brauner>
 <ZlXaj9Qv0bm9PAjX@infradead.org>
 <CAJfpegvznUGTYxxTzB5QQHWtNrCfSkWvGscacfZ67Gn+6XoD8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vqvnbffrehhkwad2"
Content-Disposition: inline
In-Reply-To: <CAJfpegvznUGTYxxTzB5QQHWtNrCfSkWvGscacfZ67Gn+6XoD8w@mail.gmail.com>


--vqvnbffrehhkwad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-28, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Tue, 28 May 2024 at 15:24, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, May 28, 2024 at 02:04:16PM +0200, Christian Brauner wrote:
> > > Can you please explain how opening an fd based on a handle returned f=
rom
> > > name_to_handle_at() and not using a mount file descriptor for
> > > open_by_handle_at() would work?
> >
> > Same as NFS file handles:
> >
> > name_to_handle_at returns a handle that includes a file system
> > identifier.
> >
> > open_by_handle_at looks up the superblock based on that identifier.
>=20
> The open file needs a specific mount, holding the superblock is not suffi=
cient.

Not to mention that providing a mount fd is what allows for extensions
like Christian's proposed method of allowing restricted forms of
open_by_handle_at() to be used by unprivileged users.

If file handles really are going to end up being the "correct" mechanism
of referencing inodes by userspace, then future API designs really need
to stop assuming that the user is capable(CAP_DAC_READ_SEARCH). Being
able to open any file in any superblock the kernel knows about
(presumably using a kernel-internal mount if we are getting rid of the
mount fd) is also capable(CAP_SYS_ADMIN) territory.

Would the idea be to sign or MAC every file handle to avoid userspace
being able to brute-force the file handle of anything the system sees?
What happens if the key has to change? Then the handles aren't globally
unique anymore...

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--vqvnbffrehhkwad2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZlrX6wAKCRAol/rSt+lE
b2bqAP0T/6Iuty/9sh3poXGM+BjEe4lGjwd3ua5vliIiOVnAAwD4hT34tVHtbEh1
ROagk+0w0w57LSeHB7EhfS36MZ0YAQ==
=MuBc
-----END PGP SIGNATURE-----

--vqvnbffrehhkwad2--

