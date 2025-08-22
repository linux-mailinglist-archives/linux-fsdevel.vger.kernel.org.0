Return-Path: <linux-fsdevel+bounces-58806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBEDB31A1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54EF6430FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E13074A0;
	Fri, 22 Aug 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="h3UKFvvl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00254305E09;
	Fri, 22 Aug 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870042; cv=none; b=lIWzU/pjq2e3iYuRUcTdQ/yIWGAHbCRpxq2kXWaIrXHaBHjOrTnMCC+9u7GMiZTGQ4saEB3z0/IqhbnPvl87mF1GRdORZ74Kj/A2firpCXFdx5johPvo0x/WPDHBuhe3Y0NXRkPFsfkc6qjJD1vhuNALqEcjrgHO+D2et4Ggd5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870042; c=relaxed/simple;
	bh=IJWIGIWhtotLUWotdqd8nRsSvuMdXJn1nhcCa7NTXUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjbtyiwOibBWfEkPwMcgDCM5pL70qsve0q/UNut03jyZdI99Jgmv3Q//1/d435XzGG5e2/GRQUsd6UUUVPhNo8YcyrYfCCOzlfUgfpIkWOjc7uFG7bsk37fCIekh6TLJWR4PJmMqPnEbhBEraoKHCLkkl7DMGZx7+wlmPmYZjsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=h3UKFvvl; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c7hCL6gZ3z9sc0;
	Fri, 22 Aug 2025 15:40:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755870031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JEaDy/HwvudjoMZ9P0+cm9wmOJj1YOgE04BPCdqAPJc=;
	b=h3UKFvvlRjQtaVH8f1xwN27+2d7BfgRwJDYTYhIH8brCj+oL38l+q93k1vIau7o9Y0EuAV
	EJqcTs3QoKDqmbjgo8a1OFhhGFw5DjnYqK7Abic0Al98QlWxOXkMhFfDtg0bm3E0plXz7D
	ReUstieiXJsi37Ksk4/Pc3FQ1IEBzfplCIULDJ3mVBelwTR1u61ZmG+lVbg3bg/0Letjhe
	hvUN10U80iADFn7zihKNnKDNiPGSbQAxTs8QtcdnBGybsqQFv9wAtMhQWB6OvZOPaqgS8v
	Y/A6AHjfRPUDaOFqUsbf3gUO2DCI8XlKC0CV1+vYO+BBUNGoQtJLe8JAXp/DGw==
Date: Fri, 22 Aug 2025 23:40:18 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 05/12] man/man2/fspick.2: document "new" mount API
Message-ID: <2025-08-22.1755869779-quirky-demur-grunts-mace-Hoxz0h@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-5-f61405c80f34@cyphar.com>
 <198d1f2e189.11dbac16b2998.3847935512688537521@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d35aefnxaxx5k4cs"
Content-Disposition: inline
In-Reply-To: <198d1f2e189.11dbac16b2998.3847935512688537521@zohomail.com>


--d35aefnxaxx5k4cs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 05/12] man/man2/fspick.2: document "new" mount API
MIME-Version: 1.0

On 2025-08-22, Askar Safin <safinaskar@zohomail.com> wrote:
>  ---- On Sat, 09 Aug 2025 00:39:49 +0400  Aleksa Sarai <cyphar@cyphar.com=
> wrote ---=20
>  > +The above procedure is functionally equivalent to
>  > +the following mount operation using
>  > +.BR mount (2):
>=20
> This is not true.
>=20
> fspick adds options to superblock. It doesn't remove existing ones.

fspick "copies the existing parameters" would be more accurate. I can
reword this, but it's an example and I don't think it makes sense to add
a large amount of clarifying text for each example.

The comparisons to mount(2) are meant to be indicative, but if you I can
also just remove them (David's versions didn't include them).

> mount(MS_REMOUNT) replaces options. I. e. mount(2) call provided in
> example will unset all other options.
>=20
> In the end of this message you will find C code, which proves this.

Yes, I am already keenly aware of this behaviour.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--d35aefnxaxx5k4cs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKhzQhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9k4gD/e02Wlo7uivjAukBykCD/
WpCTMqmDLJmVfEkBY3azb0oBAPH2UtoDmh7TGfW2YpYiOBfQE8sSfisu0M7CMwDo
X8wJ
=4dwy
-----END PGP SIGNATURE-----

--d35aefnxaxx5k4cs--

