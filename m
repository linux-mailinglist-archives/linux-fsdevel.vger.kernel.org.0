Return-Path: <linux-fsdevel+bounces-51206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57268AD461D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 00:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1DD07AB0B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C0A28B501;
	Tue, 10 Jun 2025 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nuwnk8MV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2D478F34;
	Tue, 10 Jun 2025 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749595815; cv=none; b=hPIf97UdCPAWP/vaI9KF2iqDDU7STysuL/QKtcmNmxJnj5IhIctDRi8TWYZOJY48BNz1D5tSOeH6NiZnrJi5zn0dfJhJqnsslzQ7LPRzr8+KcocF1o7okFfx0+4u2QS4AG3MLSEj8nEwbaj8J5b7aZ73DF7aSoM8lqYxAfr9m+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749595815; c=relaxed/simple;
	bh=fIZTCPSARKxpy7CGzYoZF6RYIr35LcsFBI2p7GEumAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrlTkJHMy5ph81d4zYO7HALNd7FPYNul1+iVvaHpjtiGP9B0F0ZRhlD6fnu5vo9Due16N7IBypK88B+EtA8CY9TZeAWCTcbn96JkwlSzMD0pH7LdD8MdydP9D98mcsi4L7x7TTnx1U91ysJxPp/mFrA5SpAlPqg/Ab3Q617PPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nuwnk8MV; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73c17c770a7so6653266b3a.2;
        Tue, 10 Jun 2025 15:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749595813; x=1750200613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMaN5CtVOZf+HFnSMc8Gruk/tIIqcD2xs0sOKADjgPg=;
        b=Nuwnk8MVS84ntpYl5EdJrKorWTfCEkqPi9X8xUM0bTvW7/kZGPlluL0ACfwnHjsnQm
         MxFmA3IP+6HwHrfxIbBNjeD5p67j2miAGyWVzPMH5gpR9UqtAP7Jx0Mjp6SH00/4r9I8
         WJ5wYdGedu14quZJv50ymFP4sSrfWMdwxR+kLafUhiKLdHOEkLqLqXs3MNs3se5kVaEn
         EU4tXVgPQOa1cfm06t9SVT08XukMvVdel02vZv4PQytRpMamLEnc1d1J3LkR82ItCdda
         bPDCa4ps/baSrXL+YuAgyhypjXIYMuJxSXGWWBwSp5SICTQ4ihByOvJN3FRx65md5Wt7
         lyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749595813; x=1750200613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMaN5CtVOZf+HFnSMc8Gruk/tIIqcD2xs0sOKADjgPg=;
        b=Hi2myWmCJ6OE7jt6iiz9o2+ek4JOzEcCwmz7PiUpZEote199WsSJnRCe4VZ1QjslNq
         b13lFIastQjv/tVMK7dDqSVqK3dL0OfsRTLrobhznCFwAQMkde2sMoKB607sxotUSxsJ
         TvVAzH0bYA0RAU9EguEOuKgo/yt1iNg4QJw7WUvaRId1EUBOtLbG6p6cZdpJ/giOA/+j
         ao2FZXnBag1/dK7QBvlfQKXqXI2spaSXE8+k1oHdI6n3wNqB8Sx+vaglRzU58O/LyZuJ
         CukPIIpgp+9Nb2OrB3Og71Ay2sWpvbSnGhZ4NK/5Va9H1gVrqOocmKJQAFP//j+Coohg
         wpng==
X-Forwarded-Encrypted: i=1; AJvYcCW8VVmWNSBGGSD9AKiyOTD3euhE3XavZ0wsSHEqTrOWimsHT6jQAHudsbqaPht0Fs7Bhw3dule4Ucc=@vger.kernel.org, AJvYcCWSffIioC/Lhva/1nLjSezklUaW01inFb8OHBBQo2hCrLg0XlRF8SiLWRQmtAzrlCQL2Arh9461dKev7NO/kA==@vger.kernel.org, AJvYcCWtyJ2fL5igUyuPJqdIy833nsAe6A5/suTHeAFwMEOcIbofbDGhxUSkIzWSuSRpI/6kvfnTRZ6fX0lArLw6@vger.kernel.org
X-Gm-Message-State: AOJu0YztB4zeDyzCTpiLQfPLRnoySY7pbLUh/1ME+GVZuXu3QTj1Q3/3
	NY/Rr2Wkm7QBOfugrCpuTn0L7IV54ONz3JvKIax0X8e5itQERNs2EPr26Gl3RQ==
X-Gm-Gg: ASbGncs0UjTGsTL/UmrQrTuz6i039BeC56G9sGvpb1GYPx0OkeYlYUscinepYIlYubb
	H7R88+obWDEednkm4w5LvIwxnKr0uNBLZA2uO6jT4U3XEkDYIgM+utL9Wxn8S3LYV0BT0VY/QZU
	F7cgt3BfmOtBGCjwlmnpVs5rgn9qEDZV7KFtVyjInpaOZIYoOhhS5/NFKmrdyyajKKJGSLIrHZp
	G1gC0xA7AL0WvNaIKLhRya+I+HfQ5rR2i8Na+mV9wAX8R/z0GeYiKUb1aoRUtVukgftoEyjm4VN
	i+m/GBMP6+vHe+IKtwt1UHdgk4/V+Q6X+3K7wiAwziBuuEU+CG9G90DCzFOGEg==
X-Google-Smtp-Source: AGHT+IE31JuZyP4Lqszx50ANjTakcQMRLueFIwYYJxebv8ZQtcAk5srkqZe+w6aDFy9a35XDsPfOxw==
X-Received: by 2002:a05:6a21:6daa:b0:215:efe1:a680 with SMTP id adf61e73a8af0-21f8664772amr1668153637.16.1749595813059;
        Tue, 10 Jun 2025 15:50:13 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f67505asm7360525a12.45.2025.06.10.15.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 15:50:12 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 08301420AA82; Wed, 11 Jun 2025 05:50:08 +0700 (WIB)
Date: Wed, 11 Jun 2025 05:50:08 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Chen Linxuan <chenlinxuan@uniontech.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jonathan Corbet <corbet@lwn.net>
Cc: zhanjun@uniontech.com, niecheng1@uniontech.com,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] doc: fuse: Add max_background and
 congestion_threshold
Message-ID: <aEi2oPUdTUiRkzSl@archie.me>
References: <20250610021124.2800951-2-chenlinxuan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M/CU2qPWiXAOhvhs"
Content-Disposition: inline
In-Reply-To: <20250610021124.2800951-2-chenlinxuan@uniontech.com>


--M/CU2qPWiXAOhvhs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 10:11:25AM +0800, Chen Linxuan wrote:
> +        max_background
> +          The maximum number of background requests that can be outstand=
ing
                                   outstanding background requests
> +          at a time. When the number of background requests reaches this=
 limit,
> +          further requests will be blocked until some are completed, pot=
entially
> +          causing I/O operations to stall.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--M/CU2qPWiXAOhvhs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaEi2nQAKCRD2uYlJVVFO
o/SbAP9n70Sh81jc5otTVcPOmm03/0gxJcu58hAnES7USTRPoAEAv/yiEqcSe/AZ
gu/KY9E+FQPGaOGGhT3Uzi4jTyFJ3wE=
=XnIT
-----END PGP SIGNATURE-----

--M/CU2qPWiXAOhvhs--

