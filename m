Return-Path: <linux-fsdevel+bounces-53785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA3CAF71C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 13:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677F61C26193
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9BC266B59;
	Thu,  3 Jul 2025 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clytzNWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D0172632
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541060; cv=none; b=TKVlEspUg6UGYSrRI7RsOasQf2btXxhwHfWMWmZsia+lbz450N4kEAIXW3Dr6I+Qe98wSjUY/XbSoSQFwPYHdOIgejjntolNqFmJmqBy3bDMnphPWlscfbkgImujiJXpAYeZPkspULbH9mHxdZxe985gHHXmXQDJpHXrjJulQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541060; c=relaxed/simple;
	bh=ZABOK8b+QwzZbmAhKCAKLBxM5FjbV2MkqXCb7Nc3FP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWv9BQQdlwpepPZIwBmuRfHAAkniiC0igzSUdgrmkRzBeJyxYWzCHKLdNJovrU/ZmX7j60u9DH6pLb3LtQT/L6rI8kHj2mn/T9lGdMzr1GOiYEochYvIL2Qd9nVQdHYzyuomcUR7GaLF4vByVtDc4+4MYMpNsECmjY1IqvBjZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clytzNWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D6BC4CEE3;
	Thu,  3 Jul 2025 11:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751541059;
	bh=ZABOK8b+QwzZbmAhKCAKLBxM5FjbV2MkqXCb7Nc3FP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clytzNWRUzM7fGRu1a0TdGEmSiAxxpwTm9eFWndrSiBjb/4SqqSfxQyKSdJi9hwqM
	 x6k+Rz+o/uBd/VZjkx/yWx7DH7knP2tuJD56Fi46tOzPJX1nJBo1c6M9IIEn+KgOZW
	 BtQd7aUKyAYgcVNunZrjSrW6pt8hbyAz878IfkPHbQv+BOzlGHUJk8MYN8Amhrhkvc
	 M3/72GEujIo9yzbYEPU6yqVAmedeKqxuDCYSVrBvUZs5w3+6LC039HMBjdLKOYkzbw
	 A52hBG61aZwuJnPaK2J2TpZbYUugN30phe2zm7jUqnMG1eNWTJPqFnKZtp8On3bfWG
	 xpQCWW+NUM53A==
Date: Thu, 3 Jul 2025 12:10:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/11] regmap: get rid of redundant
 debugfs_file_{get,put}()
Message-ID: <636f1d77-ebfa-406a-b428-8491dc95dfb7@sirena.org.uk>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
 <20250702211602.GC3406663@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T//lWT/MR1DKxAEr"
Content-Disposition: inline
In-Reply-To: <20250702211602.GC3406663@ZenIV>
X-Cookie: Uh-oh!!  I'm having TOO MUCH FUN!!


--T//lWT/MR1DKxAEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 02, 2025 at 10:16:02PM +0100, Al Viro wrote:
> pointless in ->read()/->write() of file_operations used only via
> debugfs_create_file()

What's the story with dependencies here - does this need to go with the
rest of the series?  I don't have the cover letter or the rest of the
series.

--T//lWT/MR1DKxAEr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhmZT0ACgkQJNaLcl1U
h9BEPAf8DB0LFqL5NdaFCsjUFaVUZAtNha6izHLsAORR8wvZ6E3XL4BZIm8qitBt
JCCHm6wU50gQ/rZlrj2rEqULoLT+OC4JKB/kr7WQy/15mvdZ/HNgPKMwUlbIJ+lO
47s5rhTkIAcKwmk7wyHooSbw3clpTZS+vEfigkKo8FM6TUe8ZaK1XLqhZkkTQoLj
652+AyJTsyBgWFuIuwPgIvpko/WhAxc5oJTwaCRBBauxe1DSNno07xK1G7ChGhL2
IFENR9cvsmnOzaoMo5y61Qcn+0vBjdxOOlG2PPDrAjQ+stmaadx2Q9hzuUv/HphJ
fDRAb6ViWkWIqa7LoTf8hzYNYa1y4A==
=XWgq
-----END PGP SIGNATURE-----

--T//lWT/MR1DKxAEr--

