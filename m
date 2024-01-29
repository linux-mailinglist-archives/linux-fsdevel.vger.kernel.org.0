Return-Path: <linux-fsdevel+bounces-9386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29007840921
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C086DB22E09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777E51534FA;
	Mon, 29 Jan 2024 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ZI+aRyxb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8298C151CF5;
	Mon, 29 Jan 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540225; cv=none; b=amZxfLk5HknCPP4f4CHnPv27q6qqY/l1Ec99QlejyQ++eAm3P8oj0mWNaakJZZbDFL4BTMztqpZQOzfKinSng1cGCR7Iuh8tLOkyA3xvUhLl4ETrPFYjjs6WXPGZljCeqdjkBHZchAJ7KDArmUx9JQYSLncZpO7mqljkyaGSnHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540225; c=relaxed/simple;
	bh=vojW5fK18zKG7CTpJFdUoZSw70bfqoyRn6Md9NRWvyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbNWsWMe6jylo8lZmMoCoEwKzomLKBoZm7ZgvQUxsM5jiU0LFwZDp6cysrP2pZzXPVqFyIx2riVGTluch6+DpmU74DIqiN1WrgRWBsySDnWY1pc9IAKYllWsFiz4Du1DqbyFX9wb+srROO/PYhudQNrFC+v2dSVUwzXo+ODg0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ZI+aRyxb; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TNrx70q9xz9sWq;
	Mon, 29 Jan 2024 15:56:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1706540219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LSy8Y2RKVEfJHAxTckSyU8TwlR6K+8Rc0NJSkTl9BMI=;
	b=ZI+aRyxbTixzKdtk7CIMSskSNT98AvY80z+GFGBR77B3sPzYC+5hIpQzUP+W7LPiyzrp5s
	HPVNXUwt4+JA6OWSuNQt6nUEKcglUqTpEapISpJBKJSrlAN5CgfITUectwCJ0FcQAQQO8M
	3bTwyr2FZ1ekB65WYMWf51McF2v7VdXFhTkYBXALhGjYnc91AudxFqUk8LELh73qDdQUBb
	XDLicYuNRFdfBTPFxQbamLrhpnv8IJtXFHchVhcPB5TNZo8jtz8hEhp6oRMRxb9W53rk+Z
	DRtB1qA48/d+HAqAlDE0bUyu2fdcE/Cnpw5dpVwNrYhxO0IyNUrR5GFPbuqhdQ==
Date: Tue, 30 Jan 2024 01:56:47 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: =?utf-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Identified Redundant Capability Check in File Access under
 /proc/sys
Message-ID: <20240129.145132-coarse.snow.stunned.whim-FB0Em3Z0Yuv@cyphar.com>
References: <30b59a4.19708.18d4f3f3620.Coremail.mengjingzi@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vo4uela55g3d7y46"
Content-Disposition: inline
In-Reply-To: <30b59a4.19708.18d4f3f3620.Coremail.mengjingzi@iie.ac.cn>
X-Rspamd-Queue-Id: 4TNrx70q9xz9sWq


--vo4uela55g3d7y46
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-01-28, =E5=AD=9F=E6=95=AC=E5=A7=BF <mengjingzi@iie.ac.cn> wrote:
> Hello developers,
>=20
> I hope this message finds you well. I wanted to bring to your
> attention an observation regarding file access under /proc/sys in the
> kernel source code.
>=20
> Upon review, it appears that certain files are protected by
> capabilities in the kernel source code; however, the capability check
> does not seem to be effectively enforced during file access.
>=20
> For example, I noticed this inconsistency in the access functions of some=
 special files:
> 1. The access function mmap_min_addr_handler() in /proc/sys/vm/mmap_min_a=
ddr utilizes the CAP_SYS_RAWIO check.
> 2. The access function proc_dointvec_minmax_sysadmin() in /proc/sys/kerne=
l/kptr_restrict requires the CAP_SYS_ADMIN check.
>=20
> Despite these capability checks in the source code, when accessing a
> file, it undergoes a UGO permission check before triggering these
> specialized file access functions. The UGO permissions for these files
> are configured as root:root rw- r-- r--, meaning only the root user
> can pass the UGO check.
>=20
> As a result, to access these files, one must be the root user, who
> inherently possesses all capabilities. Consequently, the capabilities
> check in the file access function seems redundant.
>=20
> Please consider reviewing and adjusting the capability checks in the
> mentioned access functions for better alignment with the UGO
> permissions.

These are not redundant -- opening a file and writing to a file
descriptor are different operations that can be done by:

 1. The same process with the same credential set (what you're
    describing);
 2. The same process but with the write operation happening after a
    setuid() or similar operation that changed its credentials; or
 3. A different process that has been given access to the file
    descriptor (passing it as an open file to a subprocess, SCM_RIGHTS,
	etc.)

On Unix, access checks when opening a file for writing are different to
access checks when doing a write operation. For some sysctls, it is
prudent to restrict both the open and write operations to privileged
users.

> Thank you for your attention to this matter.
>=20
> Best regards,
> Jingzi Meng

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--vo4uela55g3d7y46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZbe8pwAKCRAol/rSt+lE
b03fAP9VH1smXUs1qIwNgPTer9MEUBsfNyy+gb3uI+c1f4aS4wD/f65WIy2NbxTm
3VSOsgoc5IKkS2GKXtl9+06x4L55gg8=
=IQ1h
-----END PGP SIGNATURE-----

--vo4uela55g3d7y46--

