Return-Path: <linux-fsdevel+bounces-31815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99D499B867
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 07:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDA3282948
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 05:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EE277F10;
	Sun, 13 Oct 2024 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="j+Jssuon"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F21870;
	Sun, 13 Oct 2024 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728799066; cv=none; b=Z/t41HUUlRdQ/hBfnBMpHFtWLcErhDT20ZbCY6wY9pEXXkPnX5WhL+2r2gN/mkodKvOFEdR384fsIkWWM9sDBau4jOYYOVCkkf8TvFwGYB5smC5pp0X8mJ4N4JtbPnqk5EaeZvu1OyJXC4l/AsC16iNHBU0jWuGcMdcLzGl5Ykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728799066; c=relaxed/simple;
	bh=hbnHy3CM893xXthutfl6xjPVYnVPszH8zqS1CvCrTJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on4FzHJG5FmAinmwyliv09uz9XI8jKlneAjkJIbiXBxAGKgcB6jOb+YBCznKRrKOWgIddQwmdNvFc+N3Qh672M+GSx4qQFmPXtabCiWFIbWibBoPjE/N255AXP727UwBU3xtx++HCXyuw0SHt7Ebqgj7MAaCjMRWTmf1Qlw3MFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=j+Jssuon; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XR8lf2JBpz9thy;
	Sun, 13 Oct 2024 07:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1728799054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hbnHy3CM893xXthutfl6xjPVYnVPszH8zqS1CvCrTJo=;
	b=j+JssuonmqvEuh4alQQ41RBn+8QW67fQ2wLdAkJXIDyKRvfzgQKXPVwrs0X1vzpdzjL2X/
	jTqoUFfihzNHBSKsOYDd0dfmbgVHAzTKwmqx+/MCV7yWTpjoMWLI760LK50+9xkiN1CPIW
	RFRji4v0VajgbwEaQP0tmztQ1bA4aR948Hpi2c6AN0XxwCSmk7ullkUGN7X1HTnwxcKFi7
	mQtC/gRAgF+EqFlxbJYX1gjLoZcxjw6Mi/stsQk4LY2dEU8hXkvfiMtl3bHuLBAs8ZrXYK
	YKS/m5ipzp7BCzqJ68GVqHit8slKGyEeU5xAmRxaEm/JVF8Ycyu0Dl68zonwkg==
Date: Sun, 13 Oct 2024 16:57:21 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: luca.boccassi@gmail.com, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
Message-ID: <20241013.055429-secure.silencer.dark.pedicure-WXX4G1ZqtUcP@cyphar.com>
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
 <87msjd9j7n.fsf@trenco.lwn.net>
 <20241009.205256-lucid.nag.fast.fountain-SP1kB7k0eW1@cyphar.com>
 <20241009.210353-murky.mole.elite.putt-JnYGYHfGrAtK@cyphar.com>
 <87y12x7wzt.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ointlgaftsxrbtmi"
Content-Disposition: inline
In-Reply-To: <87y12x7wzt.fsf@trenco.lwn.net>
X-Rspamd-Queue-Id: 4XR8lf2JBpz9thy


--ointlgaftsxrbtmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-09, Jonathan Corbet <corbet@lwn.net> wrote:
> Aleksa Sarai <cyphar@cyphar.com> writes:
>=20
> >> In fairness, this is how statx works and statx does this to not require
> >> syscall retries to figure out what flags the current kernel supports a=
nd
> >> instead defers that to stx_mask.
> >>=20
> >> However, I think verifying the value is slightly less fragile -- as lo=
ng
> >> as we get a cheap way for userspace to check what flags are supported
> >> (such as CHECK_FIELDS[1]). It would kind of suck if userspace would ha=
ve
> >> to do 50 syscalls to figure out what request_mask values are valid.
> >
> > Unfortunately, we probably need to find a different way to do
> > CHECK_FIELDS for extensible-struct ioctls because CHECK_FIELDS uses the
> > top bit in a u64 but we can't set a size that large with ioctl
> > numbers...
>=20
> Add a separate PIDFD_GET_VALID_REQUEST_MASK ioctl()?
>=20
> But then I'm bad at designing interfaces...

This might be a good argument for making CHECK_FIELDS just (-size)
instead of setting the highest bit because that would work for any bit
size (though admittedly, doing (-size) for a 14-bit number would still
be a little weird).

>=20
> jon

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ointlgaftsxrbtmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZwthQQAKCRAol/rSt+lE
b+0uAP4wasxgG46nfzxxYQ3fkwaDytplrluwSVkOwxZKCEmbVQEAg3mO/cDK5/sN
XAfXnKsBY0VGpVjQyiZIaNUPGx3lwAQ=
=MrRZ
-----END PGP SIGNATURE-----

--ointlgaftsxrbtmi--

