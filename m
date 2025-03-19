Return-Path: <linux-fsdevel+bounces-44466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE0A69693
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 18:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0BBE7A117F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 17:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7161C1F4C88;
	Wed, 19 Mar 2025 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="14SzsrK6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DwdkMSHG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862841E2843;
	Wed, 19 Mar 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405584; cv=none; b=s2rcpgVouZru248PEMKTRJLuskPOXY6BSgGhz/u6f25Zfw+c4sRHwgAEh5O2i2S8x+pV9RJC5lm9ycglkdq0lP3AM2ANgZFBxKxKZTOxhiw365W4x5hW+imn2KLgqc6hoOi1jbBJvL92/qXV1mXhAi7NAPLeXi4Un/xEzRlBqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405584; c=relaxed/simple;
	bh=6Y8lKosEonEt9mOvS2dUocjAldCIqdF/gl1BDda+8oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzprgkLx/clYiqtc1Je8GHWEKNvkVqHNB2VQLkttsB4+2bqbr9fImepx4m4A3CgdOkNKdTZT7oOOM86n9KTBlshFtqgtOenzVb7eMIXSSjq96FEX7JU2M7J9yHUbQtVVD5obxdpENbluk7xykLz3tHgLbsy+eptQBPfpko+hhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=14SzsrK6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DwdkMSHG; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 26FC4114010C;
	Wed, 19 Mar 2025 13:33:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 19 Mar 2025 13:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742405581;
	 x=1742491981; bh=QQLK+HGaKYUjPDFCEGEkAaT8dCDL56Up7CPAP5sHsXY=; b=
	14SzsrK6acdqUuyoW2oiboS7i1i8z90T98p7kxLRWPra0Sce+dRljsTi4OTqQJDt
	TjQL6w/kmh6nppvxWkmnrfA0V0CKsC6Y3ke0clT2YUNfGQ5FoDm0LfGhQBtF/wg6
	ZyXWqnm5OZ+JXB5DKHyRmwero6mH1gf390F4AvNVwKAHf0qW8WFlz8HZ5jiWOGZT
	1y1rPCDQzV22bPu8tJuWgGjIs5ziigjfrxLScyDUE1byqTSx4Ie+b2fU8wg1e4R6
	3Wbs82rmL4y+y4r5/Ws8L9r4kRI1Jzrp1xYw7lMo0ei7AUALtFkPiIDW1ZtXUni3
	NvxpNaBnkN81V/8ZS6Hiiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742405581; x=1742491981; bh=QQLK+HGaKYUjPDFCEGEkAaT8dCDL56Up7CP
	AP5sHsXY=; b=DwdkMSHG4FYqR9W+G2crufXm7REiKnQv57THYyZ7v7tKOQ4WDhm
	AL4EkCu70ZfvL6rlOul+dOmmpWAN/JgngJyGqyWbbG1MqRFI3Jug8VniWjIDxwgp
	ckPnJYNkJSs7kj6zeroxEYvQ6LO4wkqWz+y2+gVGNeE4PGKlOfwiyDD1g8A/cDYI
	w+SJm7HMTlHU2g1yOGv6CjLjuWfF+zji1OAXhuuNnIKhXvmkifOslRJVnBzOK4/N
	Z1heMP/Zp3NjRYWHlVoLkHVhpEiduzGnoqk3Zcglzakad1A2jI3OHM0h26kLovZ+
	mNHAGFDRQ7EYhhR+TKg01KTrURE4BAVVH+Q==
X-ME-Sender: <xms:zP_aZ3AKeMsZqqbngikQqKzQ9CKXW9YrHLI1rssD9DEPG_yYKi03UA>
    <xme:zP_aZ9gts4I-kctNGYU-6MP6_Ql639rfYFlEo5_Hb9ieoMEIrtWv6LBiB0JIMWHc3
    VhlUOLHEfiDWSc>
X-ME-Received: <xmr:zP_aZynt-itFV3aU2nyZotqfU5hWzMZFay1Fb9-G16UEuzi7fZOJcNwQ2SECU_Ze-L2s48Ea8K-TdeN1RWwO7sQ9a864CYrAyXdmjbz-KFaf50xz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghmihcuofgrrhhivgcu
    qfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeduuedvkeffffeiudehtdekveekudefvdekieehffdv
    geeuteethefgfeeitedugfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhv
    ihhsihgslhgvthhhihhnghhslhgrsgdrtghomhdpnhgspghrtghpthhtohepuddupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehthihtshhosehmihhtrdgvughupdhrtghp
    thhtohepuggrvhhiugesfhhrohhmohhrsghithdrtghomhdprhgtphhtthhopegtvhgvse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpd
    hrtghpthhtohepkhgvnhhtrdhovhgvrhhsthhrvggvtheslhhinhhugidruggvvhdprhgt
    phhtthhopehlihhnuhigqdgstggrtghhvghfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zP_aZ5w8mZ8f7M-haIg6nPi6bvsQ-Wen06AEVerQTcerqyfWLVpLCg>
    <xmx:zP_aZ8S6xgTtA2NRY5kKkUeKTowezzxMssTjq7yFWHSNX2JphyVFRw>
    <xmx:zP_aZ8Y5ADrjT2sYGd6J0bhc3aTbc1n357qzH6mhp0lWoHw6dbRppQ>
    <xmx:zP_aZ9QOJk9hOl7Hps_FClWtYtcSv_p-h7JCcY-A_uNnrbGCAoW24A>
    <xmx:zP_aZwZK0GadxYxNsLTDHUPaAY0tsCcWF3TV7_9sGWwoZbAEXuNsisWF>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 13:32:59 -0400 (EDT)
Date: Wed, 19 Mar 2025 13:32:59 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, cve@kernel.org, gnoack@google.com,
	gregkh@linuxfoundation.org, kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <Z9r_19pcJCbDxPIQ@itl-email>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
 <Z9CYzjpQUH8Bn4AL@itl-email>
 <Z9kC7MKTGS_RB-2Q@dread.disaster.area>
 <Z9rbDdLr0ai-UFE_@itl-email>
 <20250319165931.GD1061595@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+1wLITY2sYmmXbNW"
Content-Disposition: inline
In-Reply-To: <20250319165931.GD1061595@mit.edu>


--+1wLITY2sYmmXbNW
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Mar 2025 13:32:59 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, cve@kernel.org, gnoack@google.com,
	gregkh@linuxfoundation.org, kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts

On Wed, Mar 19, 2025 at 12:59:31PM -0400, Theodore Ts'o wrote:
> On Wed, Mar 19, 2025 at 10:55:39AM -0400, Demi Marie Obenour wrote:
> > What kind of performance do the existing solutions (libguestfs, lklfuse)
> > have?
>=20
> For most of the use cases that I'm aware of, which is to support
> occasional file transfers through crappy USB thumb drives (the kind
> which a nation state actor would to scatter in the parking lot of
> their target), the performance doesn't really matter.  Certainly these
> are the ones which apply for the Android and ChromeOS use cases.

Would this have sufficient performance for backups?

> I suppose there is the use case of people who are running Adobe
> Lightroom Classic on their Macbook Air where they are using an
> external SSD because Apple's storage pricing is highway robbery, but
> (a) it's MacOS, not Linux, and (b) this is arguably a much smaller
> percentage of the use case cases in terms of millions and millions of
> Android and Chrome Users.  Most of the more naive Mac users probably
> just pay $$$ to Apple and don't use external storage anyway.  :-)
>=20
> > There are other options, like "run the filesystem in a tightly sandboxed
> > userspace process, especially compiled through WebAssembly".  The
> > difficulty is making them sufficiently performant for distributions to
> > actually use them.
>=20
> I suspect that using a kernel file system running in a guest VM and
> then making it available via 9pfs would be far more performant than
> something involving FUSE.  But the details would all be in the
> implementation, and the skill level of the engineer doing the work.

Why do you suspect this?  I'm genuinely curious, especially because my
understanding is that virtiofs (which uses the FUSE protocol internally)
is considered faster than 9pfs.

> I'll also note that since you are mentioning Chrome OS and Android a
> lot, there seems to be a lot of interest in using VM's as a security
> boundary (see CrosVM[1] which is a Rust-based VMM).  So it's likely
> that this infrastructure would be available to you if you are doing
> work in this area.
>=20
> [1] https://github.com/google/crosvm

The need to resort to virtualization as a security boundary makes me
wonder if Linux is designed for outdated threat models and security
paradigms.  Sadly, changing the threat model would be extremely
expensive today.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--+1wLITY2sYmmXbNW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmfa/9MACgkQszaHOrMp
8lO0fA/+MLGh1WmWjQHMdceGaq91jmXQd3EESWKECVgQ4zKkalk84dWf7OsDkknA
njSQsASfww7IZE+KhmMF1iOh7x2E4Zkbo8o9kxc1tbYmqekWa7HK6SkdkD8vpkuf
ClUzlfZmSKMsArZFuIfVlg6wVJK8kzcsCs/SvnwWJLXeFQ2RAHph9fiXAE8UuqjT
72WDMw8bHychf6LoHGoyaFlbEvISSXqqT1DROwd3KjXxYPWw+GRlULYBleMFFoq4
JqG07dvK1s+XZ9XXj03uF1O+/HE/iIjPoBCnXnDbck/dK8rnz0URmUoiIjgVyKGe
FG6lHoHncVlT28EbZ7e35Wo+lSh2ez6Ca/CmKXZ8h6nhTha8QWtol0yeInT8qffb
UvJiNL++IcZeURyhVvie13hA4kV7oaKURWrEOgioHYLq01q8kkP74nbgjSiU9BAW
xvvyjgcckXvNkqchOaI1+9FGtneG7fWuy/Qy/I3PIoEEjyt2HsBmXVPGXw/Tw44U
eRAZAaFzdU+wiEPeN/qsb3VQ+STKG/hD+nyPN748dOlPdV8XNRv6Agjr1U8Prm4r
UYa9Ma/xVGYo0W+LuCZNkkhsR3OsKV11PHu6qlfwYLymPLLhl2Ux7ta+ijaAt0Vs
dhCX8mzBwSqbytd15x3EDpMy4TvsRdPVdZeYTb7RcOILd88pLog=
=L+Ux
-----END PGP SIGNATURE-----

--+1wLITY2sYmmXbNW--

