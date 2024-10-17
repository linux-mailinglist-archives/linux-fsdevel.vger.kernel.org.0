Return-Path: <linux-fsdevel+bounces-32159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371E29A1733
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 02:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B131F26223
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 00:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6BC139;
	Thu, 17 Oct 2024 00:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv6oTeGZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D223A6;
	Thu, 17 Oct 2024 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729125272; cv=none; b=NFHp7mDqYMkWaX2Dz7NSZXVdVwLUARXG30ZIDOiMLpo0JXTTOYaoOmbIPQSZRtqPcCegu9a8FZ3Bu3UGSOQdSsK7Yr/Qv2GFW1lL4ahCISEcqLGexarHTJpc6PFd3hpZqCa/RexIPN8w0ClQSOSz5CFJczhiPjl2MD6YxsXdyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729125272; c=relaxed/simple;
	bh=XKExa5Lt3qO2vOeURE8GoyxM7Zo2JAwumIIS5/JGSB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t44nd7qBKwALHegRcm+Y98UM5145gkJDYpvoDje+S15zyMP3qWDsLSTfW3dRyf3uYOR90VuurunwuwNVgAECJnxLj9H/+LaItB+7iGFX4qlRrPh19/RR31nvEKwtZ9C8/TJ46bZNBYpHxv6EtqnP5UbJjGo2OTUBmInnh+0w3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv6oTeGZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-207115e3056so2930515ad.2;
        Wed, 16 Oct 2024 17:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729125270; x=1729730070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7RLBOqoD0JN/yes3gVZ4qulQhotL+c7cg1FJxv1m7M=;
        b=Fv6oTeGZXwZ15RknF+rtLZad2g+YJUjELfLYGdfqgqCWW7ugNL5Xdnv4LmSn+v+D4M
         SGB1lfI5Jg/keCOw+owhmK1A/Qt0ffUtnE39WzSZHgsXTB4Fx4dxp5NTApd+ZYLAG3ax
         HLsBEv+djf1/yFJfWI4zeRMYj/X9x53QbS8B3ke6js6vU3gQVrFhe0u7EIYmZ1Al05GG
         JNYUfFxwVllDf/wrnricSSf4gJNgadz8unXEhgR5O8uOA94NlQnMU3SuRH6VFlncIh9Z
         e/jnCGeneXIxM8FAs+wRLVfvz3H43YhayBQPRLAGE7NyO6rJKpMLVM2kVmnzD+UoxuCs
         Ft4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729125270; x=1729730070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7RLBOqoD0JN/yes3gVZ4qulQhotL+c7cg1FJxv1m7M=;
        b=VOSF87LJL1pJh/gmz3xGpBWFCqDtQd05QGfOnou2TijBMqeFpwbE7eUiNNNZ58ln2x
         B9whGoJZwGk39DPZxl3nfEVTfYB39UVUdKQuNQwBblY2HDI41FL5HUmmPqqFX+/ol0Wn
         HivV8PzsWw8/OiK3Rwav8ftw3+8Vtbn6cSxtnmaSLbfYJORUhJY8bLs6G6jLgbuTMOov
         6CHVoPAQRcdtFInVEwjhk12s8n4TRDfDaWQkuboX1NvQ+NZgDIntYBkZEKh8069/rrJ3
         +OGT+YVb3zemohWN1tENVMjM9Fz5dZU3Rsv/DXte1u8EbBWIfkGGw5jUvrrhsoE3lNVw
         b9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUwTrKjP6iHbM6Ta2K45fD98P9VUu0HHq//VUKHRiUloBJnQ3qIEfhTieNrufhY+PI2NZDhngOcu3EFn/kK5A==@vger.kernel.org, AJvYcCVZRPzoY4ZHGT77mXnSUeFjcnoQptA+iJgH2BOd5hj08GWpfbzCPNNXC1I6hE5rprur39OKXtTLat4h/rt8@vger.kernel.org, AJvYcCWIbiQ6jnq4vAuHbzuF+FEavMjKDs+VrACqDo+x0OGIvXJ8CurFDEUKI5RgmIDy9HCEaSkQW5lTSaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1OeY1N4//1k8BqCgqwkOLanE8PfDTG9JGFKy9kIP9/+qAPof1
	gTuNd+PvCde8maqb05oyro6Ptbjk6t/XIR1lS/3Q+yid3xwTJLucix97O3zK
X-Google-Smtp-Source: AGHT+IEKaTeHgiipsF8H/kEFa34wV6Oov3vsQpZwYXgTCCJo7q12qz7jhLQpMW65XUq8qj2Enq9Djg==
X-Received: by 2002:a17:903:1cc:b0:20c:8907:908 with SMTP id d9443c01a7336-20d27f1cc26mr72939835ad.44.1729125269660;
        Wed, 16 Oct 2024 17:34:29 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1806c6a9sm34112015ad.302.2024.10.16.17.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 17:34:28 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A379A41A3B24; Thu, 17 Oct 2024 07:34:25 +0700 (WIB)
Date: Thu, 17 Oct 2024 07:34:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] XArray: minor documentation improvements
Message-ID: <ZxBbka3aTzgEWgEP@archie.me>
References: <CAJ-ks9mz5deGSA_GNXyqVfW5BtK0+C5d+LT9y33U2OLj7+XSOw@mail.gmail.com>
 <20241010214150.52895-2-tamird@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="14kFThyEb3NINM6h"
Content-Disposition: inline
In-Reply-To: <20241010214150.52895-2-tamird@gmail.com>


--14kFThyEb3NINM6h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 05:41:51PM -0400, Tamir Duberstein wrote:
> - Replace "they" with "you" where "you" is used in the preceding
>   sentence fragment.
> - Mention `xa_erase` in discussion of multi-index entries.  Split this
>   into a separate sentence.
> - Add "call" parentheses on "xa_store" for consistency and
>   linkification.
> - Add caveat that `xa_store` and `xa_erase` are not equivalent in the
>   presence of `XA_FLAGS_ALLOC`.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--14kFThyEb3NINM6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxBbjAAKCRD2uYlJVVFO
o2KxAQDA50Zbc12+M1nDlaZIuk1lzysc9wi5v1hCsG1uGE/dAQD/VlGsfbjG3ihI
SXjP7Uh+ppXg5wUVD+8uwnkeo5lP8QI=
=BLF3
-----END PGP SIGNATURE-----

--14kFThyEb3NINM6h--

