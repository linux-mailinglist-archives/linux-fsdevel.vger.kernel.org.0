Return-Path: <linux-fsdevel+bounces-20859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AB28D8A83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 21:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61FF1C2377F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 19:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB4913A879;
	Mon,  3 Jun 2024 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="PA53yrNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B49E13A3E0
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444334; cv=none; b=eO3b30e/8Zh/QK9d4Nw2weSvjM/QIC5vnFUYPBk4Hm61gaInS/GXI84WijiBy0mDmTUR6iHIQaaVHLgLFNtGGFqEzC6cBuF+7LSNwwbd9CQXsTEf00odfbuliBP6F7kf8Lln7kT8p9k6jTgph/w4SS/PE5ICudAwDKlyyjk/l04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444334; c=relaxed/simple;
	bh=ycipNAyZv8lr2sKL8eIKshyoPFGMPBYVwhKD907X/n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHSN0C7rNMGqDyKIovDEhFphOelseUE9589TFXKqNEbpp8OJJD5oHt5hkhFkLkpyP7Vg6IYzq3GyON7rTsnNvw0mrrku3hLZ1P6T9GcJtJIrune/EvwRBVYktOKpFQV3ogDKaHSnFWgpU5H5Bl0Ju2bg14aM1Ww7vqreYJtHOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=PA53yrNX; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ycip
	NAyZv8lr2sKL8eIKshyoPFGMPBYVwhKD907X/n0=; b=PA53yrNXqMk2P8wnc/yj
	klnm/zcqtv71pnkyA8u8tI+1iVJ0zb1yk4IMt+Pb6csg71t2khz0qX7vFSQxXVsM
	/d3gxm3EBf9oGP7n2vvJetrQp2+8W3QR5MsgRymzFunSXCqfalLNGvCb9b91bRS4
	B62Lpjv0+NQ5lMLQwmzylf5WuYxtjupj8J/uRyDneJ3920uLL5xI1hK7QFx/M7s9
	MCJmQh8PQMBG7Onj05y52D4+E712/XVtZnKjNDNXChVHXoHYk64iNr4Y7bCV+7k0
	0tg0TYtPRNgOAiEBESttVWLY24t+IlgJHRgZ40xt8Txgx5WAwuV3x43PuGFkWyAR
	3Q==
Received: (qmail 2061899 invoked from network); 3 Jun 2024 21:52:07 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 21:52:07 +0200
X-UD-Smtp-Session: l3s3148p1@IlQQqwEa/OVehhtB
Date: Mon, 3 Jun 2024 21:52:07 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: ignore auto and noauto options if given
Message-ID: <clozc33lz7y4audw2nkgvuehqjbpurqr2ematmjs4vgxvnct3l@4wxkkmhjke54>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Eric Sandeen <sandeen@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
 <20240524-glasfaser-gerede-fdff887f8ae2@brauner>
 <20240527100618.np2wqiw5mz7as3vk@ninjato>
 <20240527-pittoresk-kneipen-652000baed56@brauner>
 <nr46caxz7tgxo6q6t2puoj36onat65pt7fcgsvjikyaid5x2lt@gnw5rkhq2p5r>
 <20240603-holzschnitt-abwaschen-2f5261637ca8@brauner>
 <7e8f8a6c-0f8e-4237-9048-a504c8174363@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uv5iqsmng6shuhb3"
Content-Disposition: inline
In-Reply-To: <7e8f8a6c-0f8e-4237-9048-a504c8174363@redhat.com>


--uv5iqsmng6shuhb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> See my other reply, are you sure we should make this change? From a
> "keep the old behavior" POV maybe so, but this looks to me like a
> bug in busybox, passing fstab hint "options" like "auto" as actual mount
> options being the root cause of the problem. debugfs isn't uniquely
> affected by this behavior.

For the record, I plan to fix busybox. However, there are still a lot of
old versions around...


--uv5iqsmng6shuhb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZeHuMACgkQFA3kzBSg
KbZBARAAo4+DwSklHeObgKZ3QYHcKwh3O9XQefTdCw0cmV/UXijzCw8OKj5pwQN7
Jx1vU/YMnODQ1WO2+HhAC7DpTLFXhctfzqqNxLbww05x4UH7rH74mTaLOIyHQ/ad
THTfAKC8Ig5H437eQpikKsQC3fUW0lgCjqaYbTP1JLQu5Eohyl67JenjCRf04O0S
vAko8vvPOjc/pgst970csJQrrCvIgQS/uFlXDZjxjWSK8Yz2tUzRNPH+1OKvoqNB
XYf4Q/78IhTjv8iktMkQDNfshLxi9dFDKqwWaIicInyldsjIZGwB9+gygrJUkF+m
wcuNAHobiF5OGE4Acco9LREKp/LXS9AyGhUwq8ZZFy7dEiQKA4tu5QVheMWpAyAb
f5x5w2FM8kx2cHbivNGKvB0EjZ4JOVZP+nwa34FOjrpIuaT3W4cPNyhOMpICLFZi
XKtjmGFwM/y06O6rjz5ys7AwLWB0IOqkCWpythVKl2wrp1fYg4ckFGQ9j2fAg4Gq
Q8W4pZulKbqhew1OIXSUynwsiTaplxUkASq/Umh06YyT7FwMbbuNljT71Acia4Ue
FPD6a1Vp6G8ZiiLvKZLrNoW9GxJDuRE213hEdFHjcz0faxW89KIIgrRJpxXXTO4O
+YExcbUUiXSAYAhnNVu1De2k458U5K+z00tBA++k2OO60yR9lYs=
=wj9/
-----END PGP SIGNATURE-----

--uv5iqsmng6shuhb3--

