Return-Path: <linux-fsdevel+bounces-19560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943228C704E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 04:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59651C21D90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 02:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A375441D;
	Thu, 16 May 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmEo1gSu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0275320C;
	Thu, 16 May 2024 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715826623; cv=none; b=sohsqQJ0thzmQ0CajHpL3cLSgXgaWInPHt5yHU/wHhPG66VpFt9f7OMBZRGqQtyurusrTJ5dwEjXGDeGwMT2BSfMEBv7yle5amMcm3PZNOSpXogZCcVOP8JGuQSxl8ZPrjc6ZIELBvxXAoh3UCHtMErO3LYn04T5D/yu4YsbcrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715826623; c=relaxed/simple;
	bh=luuZCOwHRQzcsKdhemBb69s42Jy1t33jiaLSTq1qmrE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q5bREzB58fOmSZRU8fFgi0syBYbuAJ9FMNpIByPks8B7JfmUczxKpEAG3w3V3KwEym8pM9O4ls3/tefMRVIHfgNP2Fbbu21ik0TcoeG+ZXJ+im/+HPeXztD8lC/gIpztVx9WRKsbtOAEehucQy5HFVht6LlmukebfGaRRWix8lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmEo1gSu; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f0f728d373so2862143a34.0;
        Wed, 15 May 2024 19:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715826621; x=1716431421; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3HxxeZ7mdHwDKn/7AQjzq+Cq5PG4lChvk4r41U5858=;
        b=fmEo1gSuX1Xv8Ud55q8VFFvnPJrsgQsgITZB3XFvxDqGwNm0jZ9+Jmk7mJT5avud8G
         L3E8nrSpCRXnWLu/wJOp5srKtT4n+9GkPHnuoSnBBQR7+LAEbQcJRyoSAAr0gWIXR9Eo
         vr7bRnFnFVfi8nV3NfFi/dpjEUA+dkxNlQB5KsvnnKUPFGP2bSmM/1Z5lPiseFZT5nw+
         ddUtckKTf83MbKZLg2qj1Td5njZk5fIHqu2VY+hk+GqJemBbmtt2IwEdMpBSKuO89c5K
         TgQmx93XJVYP0tmXq35KUg0tgE1oEZr9YRJxQNJ085JPL2VcHMHjh+epKCijwt/umBb6
         VmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715826621; x=1716431421;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3HxxeZ7mdHwDKn/7AQjzq+Cq5PG4lChvk4r41U5858=;
        b=JW9fPoYhychNaaV80aip8uV0a7FzfguN+bnJJlszboe+XYUxlq1HzKTtHq0j2F84Lb
         20R0Kxp8TsYr8OKonKC6HydI+hRHdYxprV1dB0WouUZIZuO3VxP3ppWPA5ZXCX0DC8W4
         Pm7LoQO74t7/I8YbsWhVTNbtzSa98H4NeGZS55E7IJ03qQWVu3Qj6+Z+6DaEQ7V6fpNv
         j6dzJZVv1N9Hn340iBcSN7dWxMvSBs6DdnqbMjBIc4UNRcS8DDdpRMiwKB930Ia9fz6b
         04CiVTER6n+fmqbOr/w1LMalhcp+dk8qc9lzuvrIVPcmsItePgyD4ggbCUW71EfZmXQy
         uqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ymq5zde05+dq3P6Dt2nK9hHOZVQUlcYMx5HQK76ASReQYaMWFVTY0hMsMncZCfm2N0tggeK/y/BIWGF2J88d6Qie5oq/ba5NfR3F1OkeOYVUAT/QA/k2QXWQQg733Tn1pPj0b120
X-Gm-Message-State: AOJu0Yx52DZVpmtoPj2322tU/eFq5aLZK8rWCvbEyv4VP8CVGy/GmmPJ
	ojnABzcj4a2nNrYEsbEHxCG4krq73SmLIGz2UkoQpFCT7QTgQms1
X-Google-Smtp-Source: AGHT+IH2iA6yNkrsVaY3XeU7OEvrXCvN9AWyyvM6DuW9wN2hXlgxsVnnbClBjcPlY6k+FYVy0uUNyg==
X-Received: by 2002:a05:6870:7096:b0:23d:49b4:6788 with SMTP id 586e51a60fabf-24172aa2c2dmr25778539fac.21.1715826620560;
        Wed, 15 May 2024 19:30:20 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ade2c9sm11827127b3a.125.2024.05.15.19.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 19:30:19 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D409E186C082D; Thu, 16 May 2024 09:30:16 +0700 (WIB)
Date: Thu, 16 May 2024 09:30:16 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Petri Kaukasoina <petri.kaukasoina@tuni.fi>
Subject: Fwd: Kernel panic in 6.9.0 after changes in kernel/power/swap.c
Message-ID: <ZkVvuKHV-jdOMnB1@archie.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OHWfg0fovwQn+CBZ"
Content-Disposition: inline


--OHWfg0fovwQn+CBZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Petri Kaukasoina <petri.kaukasoina@tuni.fi> reported on Bugzilla
(https://bugzilla.kernel.org/show_bug.cgi?id=3D218845) VFS kernel panic
regression when reading hibernation image. He wrote:

> 6.9.0 crashes on boot while 6.8.0 is ok.
>=20
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block=
(8,1)
>=20
> bisect result:
>=20
> 4379f91172f39d999919c8e8b2b5e1d665d8972d is the first bad commit
> commit 4379f91172f39d999919c8e8b2b5e1d665d8972d
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Tue Jan 23 14:26:23 2024 +0100
>=20
>     power: port block device access to file
>    =20
>     Link: https://lore.kernel.org/r/20240123-vfs-bdev-file-v2-6-adbd023e1=
9cc@kernel.org
>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Jan Kara <jack@suse.cz>
>     Signed-off-by: Christian Brauner <brauner@kernel.org>
>=20
>  kernel/power/swap.c | 28 ++++++++++++++--------------
>=20
> 6.9.0 with only this reverted did not compile. This has something to do w=
ith reading a hibernation image from disk. I use a swap file, not a partiti=
on. The system was not hibernated, though. After I removed resume=3D and re=
sume_offset=3D from the kernel command line, even 6.9.0 boots without panic.
>=20

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--OHWfg0fovwQn+CBZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkVvswAKCRD2uYlJVVFO
o/SxAP4sikhakMMJf5TMjw7SN2qc2KZ893jwWhW0TXgeTMCRqgD+MpgwZ0zPaRfe
EbWTwhe0+C4ChDxW8nBIE+Nf24OQNQE=
=8S11
-----END PGP SIGNATURE-----

--OHWfg0fovwQn+CBZ--

