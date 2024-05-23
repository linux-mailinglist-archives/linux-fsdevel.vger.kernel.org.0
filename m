Return-Path: <linux-fsdevel+bounces-20066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489DC8CD7C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 17:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF27FB21145
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793161401F;
	Thu, 23 May 2024 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="fIpnFnY8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71391400A;
	Thu, 23 May 2024 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479570; cv=none; b=Rqqk/emdFMRxAXdYtAYmzPGsLzySaTkkHqvICr1b4Xiuf0HWKtNDya28GAAcBn+1XNKEmQEk/W81hD7E6bGnFwHSlGT0YQrtxwv6CK8ZLfZNXirnc3ijt8e/dgmSH10t4v42ehVNgPyXe+uIYvlfpuxEo2CloOmTMm5t20kRclc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479570; c=relaxed/simple;
	bh=/P2HcR2ooZhn1XjwLLvuzHwEXJ0ilr94g/kPPiR6VCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR4RrNfwHD2yX5GxVgCcK0IcTQIfsP1ckMh8bJZw6LJUIqySxO1lquyMvIQ5HWuogW0P83EnG5yY+5kUXo40y6RZIKDdFAacPecE6P9NGoCpduxhQ/AJXri4LFleeqtSIhaSU49FwudsEG8ZZY/DFVI8qrBR8ZwkNc86haugZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=fIpnFnY8; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VlXkG3h3Rz9t81;
	Thu, 23 May 2024 17:52:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1716479558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/P2HcR2ooZhn1XjwLLvuzHwEXJ0ilr94g/kPPiR6VCw=;
	b=fIpnFnY8Of+uaqrowrMZSmQ6SiiP5GBVJw0uDc9zh0GwI+jVUVg+216elRHbMIZ8bkg+uG
	+xgbm8pWy0l3N5R6WOSnU6wB5yDjTO8bZpZV/yeI0dQmSz2CZPIEv8bOt4AQ/oqd0Q6ef8
	8LFQoIvc9NCfgBPONaO5XuEzuaeUK8UbdnoLOG0Ek5zTB5+u2yeOxSfRwahnKrJkcTyyLc
	8fkCb01Q8kV1kGX2bKDDjLGQmeWOo4tX/vmze+ThTQuTdfRk3YpuDwKrvN1XRiVAjxkMoP
	BtxHPv9Oods4ZcYbcYXbVhmWkuLcvfgf8SWDeK/QQB0ZF/cFBZQ/Qkm6grifvg==
Date: Thu, 23 May 2024 09:52:20 -0600
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Aring <alex.aring@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
Message-ID: <20240523.154320-nasty.dough.dark.swig-wIoXO62qiRSP@cyphar.com>
References: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
 <20240521-verplanen-fahrschein-392a610d9a0b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="syu4osmmxwp2aoki"
Content-Disposition: inline
In-Reply-To: <20240521-verplanen-fahrschein-392a610d9a0b@brauner>
X-Rspamd-Queue-Id: 4VlXkG3h3Rz9t81


--syu4osmmxwp2aoki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-21, Christian Brauner <brauner@kernel.org> wrote:
> On Mon, May 20, 2024 at 05:35:49PM -0400, Aleksa Sarai wrote:
> > Now that we have stabilised the unique 64-bit mount ID interface in
> > statx, we can now provide a race-free way for name_to_handle_at(2) to
> > provide a file handle and corresponding mount without needing to worry
> > about racing with /proc/mountinfo parsing.
> >=20
> > As with AT_HANDLE_FID, AT_HANDLE_UNIQUE_MNT_ID reuses a statx AT_* bit
> > that doesn't make sense for name_to_handle_at(2).
> >=20
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
>=20
> So I think overall this is probably fine (famous last words). If it's
> just about being able to retrieve the new mount id without having to
> take the hit of another statx system call it's indeed a bit much to
> add a revised system call for this. Althoug I did say earlier that I
> wouldn't rule that out.
>=20
> But if we'd that then it'll be a long discussion on the form of the new
> system call and the information it exposes.
>=20
> For example, I lack the grey hair needed to understand why
> name_to_handle_at() returns a mount id at all. The pitch in commit
> 990d6c2d7aee ("vfs: Add name to file handle conversion support") is that
> the (old) mount id can be used to "lookup file system specific
> information [...] in /proc/<pid>/mountinfo".

The logic was presumably to allow you to know what mount the resolved
file handle came from. If you use AT_EMPTY_PATH this is not needed
because you could just fstatfs (and now statx(AT_EMPTY_PATH)), but if
you just give name_to_handle_at() almost any path, there is no race-free
way to make sure that you know which filesystem the file handle came
=66rom.

I don't know if that could lead to security issues (I guess an attacker
could find a way to try to manipulate the file handle you get back, and
then try to trick you into operating on the wrong filesystem with
open_by_handle_at()) but it is definitely something you'd want to avoid.

> Granted, that's doable but it'll mean a lot of careful checking to avoid
> races for mount id recycling because they're not even allocated
> cyclically. With lots of containers it becomes even more of an issue. So
> it's doubtful whether exposing the mount id through name_to_handle_at()
> would be something that we'd still do.
>=20
> So really, if this is just about a use-case where you want to spare the
> additional system call for statx() and you need the mnt_id then
> overloading is probably ok.
>=20
> But it remains an unpleasant thing to look at.
>=20

Yeah, I agree it's ugly.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--syu4osmmxwp2aoki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZk9mMQAKCRAol/rSt+lE
bxctAP9Kw9bAXa2/Grr9P3qpouqY7GMqLfiI913pFPu5tLekugEAwV7BrDbtomln
wVmJGBZXmdwq6mW7zkaCbn0TqhB6ig0=
=JlY2
-----END PGP SIGNATURE-----

--syu4osmmxwp2aoki--

