Return-Path: <linux-fsdevel+bounces-20495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3BD8D4110
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 00:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDC01F23F0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 22:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC861C9EC2;
	Wed, 29 May 2024 22:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DeGLxYgb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039121A0B06
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020355; cv=none; b=ji9hCWXEMUZAj1tZ2Q3M5eJHJ/MWRSNdzK62dXNY2Pc/lf0gYflAedYQGbKkhsHd0XSYpjlv3pByki4vUaOGpUHg5Sq0Ba2/25FKJr9mAmo5L6xZZw5e/3agskGrW9gn3rWvyEHd8D5msyq//00ht51Izh0ti37atGBEXiXU+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020355; c=relaxed/simple;
	bh=xQfxlntEhOnUqYKxCNx6748gaa9Y/uZ9w5LTJjm+WfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE7Nz/hXXNibPi25/VP4oZK7+dRuR82y5qM4YSFMRzpRabvUkZ0+fsfue/9Acq2Z6P4s6PVQu2uHBt4FsbKfqTsz8MavDfMNi0SuwvOVCXUyNfWLAz6Bt57DXMEGmDs6gqk/xIyQoWtW0/TCbJVmwFRb7PJdZCv6NQIsowgCc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DeGLxYgb; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=GUVf
	bGqeub1hGLlaQpOnhPVaLkv4E2Iynp2aZXzbj7I=; b=DeGLxYgbSJyISNxm64j6
	MdFrSDLXvP+UDwG2gC9S1LKl2vUu4J8oziyeWqlY1bL6E0r0AODhwSg0aETx5+8j
	2CVt1SfK4pGBDRStLBChJA+ryCUMkh9rKE1jXFxczgOg5tnEr+nC9zRUwcdTLb2E
	EOILBeNmyzGDI0jWg8FkqttTPcbGOwzHl2PtxyJnWaYQ6xpwYFAsXs/f/adjBjZE
	wG8LTKLtNIAzB5v3DzfAc3DScqlodpnU3X2gcAQnGWSwqOm+UmSewhLLXA7bLXUb
	Lh4EkhGeYHwRJBAuziEZBrKktnd0U1Y+EcS3mY1u7NqxJVwZbSAfgnWfeNp3tF6a
	sQ==
Received: (qmail 701299 invoked from network); 30 May 2024 00:05:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 May 2024 00:05:49 +0200
X-UD-Smtp-Session: l3s3148p1@w2H0854Z1INehhYM
Date: Thu, 30 May 2024 00:05:48 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Christian Brauner <brauner@kernel.org>, 
	Eric Sandeen <sandeen@redhat.com>, linux-renesas-soc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: ignore auto and noauto options if given
Message-ID: <oste3glol4affqkftofn6hgnldurnn4ghutsdmfl5bjgzwz66o@i4fneiudgzmu>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Eric Sandeen <sandeen@sandeen.net>, Christian Brauner <brauner@kernel.org>, 
	Eric Sandeen <sandeen@redhat.com>, linux-renesas-soc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
 <20240524-glasfaser-gerede-fdff887f8ae2@brauner>
 <39a2d0a7-20f3-4a51-b2e0-1ade3eab14c5@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v5nus3utufq5lujr"
Content-Disposition: inline
In-Reply-To: <39a2d0a7-20f3-4a51-b2e0-1ade3eab14c5@sandeen.net>


--v5nus3utufq5lujr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Eric,

thanks for replying!

> @Wolfram, what did your actual fstab line look like? I wonder what is actually
> trying to pass auto as a mount option, and why...

My fstab entry looks like this:

debugfs /sys/kernel/debug       debugfs auto            0       0

This happened on an embedded system using busybox 1.33.0. strace is
currently not installed but I can try adding it if that is needed.

Happy hacking,

   Wolfram


--v5nus3utufq5lujr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZXprcACgkQFA3kzBSg
KbbGww//ZLdzgw891psYTdFhPNOK9YNtV7Xce/sxjIf89qMZCLQp+o8cBJYedmhb
74lxIS8bK7xMtBwL7QEDOSY0z7iPJfx2OKup4zP4xCou+5v7FDMD45Nt4gpSRkAt
hP1iJFN0I+oFe8s8nOODOjo7B8zoKU3L4dfc9bHt9gscBiDTZNWe8ZdfNoXdELYJ
tXoFci4zXOIDT8djRpazuOH/S+LQ8pV1/LkgWJqp6Zmx+v55iSQb3nqK0nX4asYT
ZhLkmMc9UNLK1lWppL232zy+/cazoNvZuiT3Btbjj2vJailxUHNHBLbJTAWqfF4r
Kqy6NsfLLJEPArIS12QcuSPKkX/5HkcMWbiFgDECA5uNJtQf4ildxk+YlaC5ByLr
0VFpiFUPM6O6TsNdgIPhx0VfgKr3s15DsAnNbj7tSjjSOnwpqZ/VI39rsAbQzWuC
G9EbyVKuDSW78i+vV/TUFQBum+TZHe+eDfavf/dAhswTUavjaKHG5VZV9pK0bu7P
zaFe4zqfABSko5iPmzfmK0OjpwChT/Xzuf+hs2dYJjierMZY3xWOhMyfPM7w0dpI
ZmO1TX5s9AuwsTWj9LncNwslmKOx/VLN9j/n9+w14m3CM5c7mfPs95I+uEjxTHe8
zKNMvUtuHDMeNosNkVw99hmtwrutJsTUkew/ZfbLyG+p26zi7gk=
=ZBlb
-----END PGP SIGNATURE-----

--v5nus3utufq5lujr--

