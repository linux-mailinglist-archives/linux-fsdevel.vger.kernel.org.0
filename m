Return-Path: <linux-fsdevel+bounces-51696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01736ADA48F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 01:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D443A3E3B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 23:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0E4280018;
	Sun, 15 Jun 2025 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/WSP6C9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E91E4BE;
	Sun, 15 Jun 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750029230; cv=none; b=LEvItq1pWFJbntZ+YIy1WipeCaBUhU+2PNxg/xp/gVaZIJ5Z+XDEr6aQGSNPTZsrH8IgBSipryCIDqHed42ZJfYeAyEoH+yxCtQ810W5x/Ix313UaAewZw9MzfLcusHH1JfaioFC2zrO64ftTki8JrxaIRhDr0FXu0bN/v7ja0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750029230; c=relaxed/simple;
	bh=5toCBH4bcEJPuw3IRfCjhudOj5I05Qfb62ssPo0moHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdcjZC7Bup1KVPsolDFWpIuixg693mVLdnLUxswOwKStV/zKLrESwXHDbs8uCsfXnZSF3ICu7dSY/P9nRGlxO1A4pXcvBmcjtkuH4TtrGnNvopBEqUklsvLU4zVUG/HTzQf/x1NSOrhsv53GIGnk5a7aN5C1ifXQVuyWCXo+Sq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/WSP6C9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c49373c15so2875962a12.3;
        Sun, 15 Jun 2025 16:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750029228; x=1750634028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLyMK5ruol9+9iNwat5WrtKnD5+vG87HPazjSYbAGP4=;
        b=S/WSP6C9hUG6yiUZdmOl9wigZ7ZrMbcx2IiijFH9ho0lwxI21ehMM3ocCxhA9tZiFp
         KhnWozTLI7J+S3auZ4OesIsBrsjtr8t/qR9zcSt/RKbvEMBmcSTEnGaPoUM1lalE6CHs
         ZDdYLBPqK+ngmELklyENBUlYu0+s7GTfDpFgjeRYHks6S4svWRC4Ii1fL+EQAHueiKLZ
         fy6mMwN6eAIhrCRNa3zUKIZvmwFa8cfzzlHY/0/x6GcH9tLMD3s5F6+wkQS3DjO2lV8Z
         YQkg9dVmx570auLYQbu44vRsXe6sdVg3eiLlcfqqCzJ9uHO79Btx+jjAZWsTZTDBZm3Y
         Sedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750029228; x=1750634028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLyMK5ruol9+9iNwat5WrtKnD5+vG87HPazjSYbAGP4=;
        b=ZU8KrXmNovsEvHUpEINEvk/T7GzNgLNpkD905gbwUhgOjEtEZK0Lujzxs7hn7QzW2q
         tZZqLn8hs+FiVasiEuiQsNjmhi9B8LfcLc6lI62h3SSdkQtjrS+t/gqBgR+8LIsriqlx
         yEZPhoUNXKAF7Qu1OTt6ZSM3SpgYI68f4VHmIt/ZPYOyaXcZhPY5Jfe6r194IC92eo6N
         sPFbfQkt1hovtEsQ/Hq3URewIleLgrmkosXfPen9MEJ75wgr0eQctwbejYNx8Pa1/Zj5
         lt8UaHk/IDv8pK4qIecVZHIFu2ACp3Wxv8itMRb/N5nft0THtFkbiy0RoPDpvV6pa0NH
         Uxaw==
X-Forwarded-Encrypted: i=1; AJvYcCVmEFcuJ06rklaobh76QH2TEORQ6QuuhMHawtiaKWrOdM/F1uB1rxxBqGQJhvR/dI3d/Mv8X5B//LLyoNEB@vger.kernel.org, AJvYcCW0QP40araeX8U82pFbmf+PXoxEc3rWW8PlRaGp1tRC05Bqqb+RRicxBXDM98B8J6S/wZG86E1oy0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXqJ3fZPEJ0mNXNgQOZ1+mlJaqiKXClFz2gSHtq1qKX/jU1Jp
	gd3r/P6txqxQOH5egrMcbMvSLAP2dTu885R1IalnYvONP8VtY539gqqE
X-Gm-Gg: ASbGncsBD0QdAPvkyiD0/A7jqiGBApOYsTmSH08wJm8EofEf9rpzOhFYgYvK3IQavNK
	gVXQphTS2tcgAwDTqtLziT5NShDxcm7eOtud6Iw7lYi8CLS7cvs5IUvXfBL9wyp89xBFOZXwBgU
	V0LfYjWeZIFigL68VnGFPzN7hgDhs5DuQbn/pLpPP/duhSiRXxvabYskru5WdYknoAaTKMwTx60
	GBZkuUxodhZcxgwXv+swgufmC/+71OwthEA5ghrQWfpHfhvUPo0z/2MHxB3kokqcpuyTT+cbmaU
	l41IdxA+p9MSJHtFpEvO/pXNPf6lXaJFS6si+o8GWdc/jZBYlmQifG/cw6lxgg==
X-Google-Smtp-Source: AGHT+IFEcPND5vwsqcSU5ddfDn6hXExeR+v39v06YQSQLuc8wHY+pdRuzg8eS8K4pOem5pussUPHDA==
X-Received: by 2002:a17:90b:5847:b0:312:1dc9:9f67 with SMTP id 98e67ed59e1d1-313f1c7c54amr11291125a91.2.1750029227901;
        Sun, 15 Jun 2025 16:13:47 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c61f60sm8140069a91.42.2025.06.15.16.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 16:13:46 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B5BA941F5620; Mon, 16 Jun 2025 06:13:44 +0700 (WIB)
Date: Mon, 16 Jun 2025 06:13:44 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Charalampos Mitrodimas <charmitro@posteo.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, neil@brown.name
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: filesystems: vfs: remove broken resource link
Message-ID: <aE9TqJdq397XIMOl@archie.me>
References: <20250616-vfs-docs-v2-1-70b82fbabdbe@posteo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bkwiZNqO9JFU4qbW"
Content-Disposition: inline
In-Reply-To: <20250616-vfs-docs-v2-1-70b82fbabdbe@posteo.net>


--bkwiZNqO9JFU4qbW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 10:51:53PM +0000, Charalampos Mitrodimas wrote:
> -The Linux Virtual File-system Layer by Neil Brown. 1999
> -    <http://www.cse.unsw.edu.au/~neilb/oss/linux-commentary/vfs.html>

It's archived in Wayback Machine [1].

Thanks.

[1]: https://web.archive.org/web/20071101000000*/http://www.cse.unsw.edu.au=
/~neilb/oss/linux-commentary/vfs.html

--=20
An old man doll... just what I always wanted! - Clara

--bkwiZNqO9JFU4qbW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaE9TowAKCRD2uYlJVVFO
o2dLAP46bAAm5O1wzccUknNgMoA9EZgSOR1d94cSqzVeCPOifgEAprXdhpr6PYzU
eBIWTc6sNJDICH4rgD8DUJg7Fj6Vhg4=
=Nukv
-----END PGP SIGNATURE-----

--bkwiZNqO9JFU4qbW--

