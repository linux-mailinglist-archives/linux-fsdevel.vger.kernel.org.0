Return-Path: <linux-fsdevel+bounces-64799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAA3BF421B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 02:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3F0C4ECB37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ED01C862F;
	Tue, 21 Oct 2025 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQZ35ovK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04A1684B4
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005871; cv=none; b=aqtpBRiaV5Q1I1lFER0Gpus20FE9esh2R/60W+GIvQhLbGZ2O4oko0RZgWmFveM+Z7s0Nr+vRwpOpsARCHrmI1P7HP00MXVPpdInyN32pZT3NvOOOpxVFmaB30Xxii0iTx/PcI0ODlF+wCugcfuLgLLnCEvLIbfayWaKlVCOd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005871; c=relaxed/simple;
	bh=vFA5jWjJwG3KGfKV3NylgtBNOpUzMJeaJAuNwrifEf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtRt8KbNgObYTfLqtDazT32g66JPMRKvuO0QXzD+r8+rFQkGzzgD22usVEpgmKPdH8p6gEw0mt3NfzxemhashcR2ln2HqxbeaV6lVDBF2tHcaUiNeEfZqTfk5ew+fA2zX3f4e2tHMVw80eNgE/EiIYis7Bgt69dpLsENNGvxrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQZ35ovK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7841da939deso4616884b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 17:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761005869; x=1761610669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0k2HQYaXzdk1lCw7ANhIJpf6VwtFRwHqSy2iFVshPF4=;
        b=XQZ35ovKbtFv10dM1xiwElksah3Sa8SWTq2nXAnYRFWLxCm0Z45KDHZ+apOYxNky6G
         t4O78JWNzv+3eFsPxUbF6E0wcGWWqobJFxRVHkwvKUIuEurYCqvr6SopmgEsRhcW9Sf0
         iMOzNzJ8KruYe7SL0ic/3p92epng4ei6ZrRvjHfsGZYGwcEIFM3WOLP/Hjw8kcSnO9+m
         rFAzVfdfFRCuOK2MnX2k9p3bwdKwrMGKjRRkek01iUrOkSjuHFnsqqkPUtahcQUsz05Q
         Usq0LYFAjzJ7OnxmZ/0GVEl1R9Sju5wapOt/Zo/cjRtBp7e8I2uXT34hjZGFta201v+A
         ZGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761005869; x=1761610669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k2HQYaXzdk1lCw7ANhIJpf6VwtFRwHqSy2iFVshPF4=;
        b=gXvFPGLaTiTaSxasKZjgXIcSY1R9iYJGA/OfSarBpiI1EhgNbJNmlZ0+278EiwOj6b
         77hktajyY2PlPutU5MIh9RwLz42jvepgAdBIwtZowBoCPw5u1NNGFv8CIf6355L8WA4c
         mxLgTf1+iLxU3EUBik944+RKbv/tRE+ZCAo6sr6Q3KH56iRM8yKnTs/4zNwAHmsOG3i+
         yQrosbiXd0uvPx+AFcYB5jA47eQhjB6lplepfE5eTqkHl1Xbnv0fxx9kcpwW+6rwIeSu
         /o5UVl9fRUpvVeXdAmYZ8yrtomD99Wa13b+u2WJtD1qwnVYrZtQEeFdb3soViPMLLYEO
         3/Kg==
X-Gm-Message-State: AOJu0YyuI6KQ2mWTsFK0mqqXv9olilq5BilgBTKj7vpwI4nO4z/keSLI
	OUKYCvCGV6KOb/wZqD28JAWF+uyTjoGccXjtZU8uD0Oa/pxiP0YxWLrU
X-Gm-Gg: ASbGncuNObL6EDVqWGt88RIRmg7rWXR8Xz/ZPXM+t8/d60an4qvejCe7vqBmK9a3Crs
	ETurlXjF1ZvYh/OZZCoqyZzTKwaThgK1b5kr7v1AW7cGY0bnS11PBFfw8EY2P08uZc2EhlkOfRm
	U8eyYMBiYS8FsK/mK52D8pK8uHz4cW7SEQ7h+9LTr4xmd6NE0JsrykfxLBIcqbgCrJjT0KDfg91
	krU6vBWkzBxrSTbOAb44GMB8a0zg3lGW2H+bsvUBhs3BfeGTXyi7sLQor1DDmzbT3nfsqeFGDso
	AhZYlh/tI2FZZNkqnVSquTxvYhbjXH7UlYQStE75Jz7i56HaDUoTQPvoE4YLwxVMgdVaQziWSv8
	dox68CAGR6+gxF0iytRJHo98ZFZcwaX7dttbv/YWQqFpkwaKUIUEbi46ghbkJf21zW6rypVa0q5
	AGWJGOFJZya6idYg==
X-Google-Smtp-Source: AGHT+IFq++y4W80Ih2jHmrfYp10BD40l7TzjNSqxSnI9I0d7jWklXwTwil0r3CdzGN6TUJib1z/iKA==
X-Received: by 2002:a05:6a00:9508:b0:781:2272:b704 with SMTP id d2e1a72fcca58-7a2208fcf14mr19313733b3a.5.1761005868811;
        Mon, 20 Oct 2025 17:17:48 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34b8bsm9532381b3a.22.2025.10.20.17.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:17:47 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id EE0BF412B0A6; Tue, 21 Oct 2025 07:17:45 +0700 (WIB)
Date: Tue, 21 Oct 2025 07:17:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@infradead.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH 00/11] ntfsplus: ntfs filesystem remake
Message-ID: <aPbRKScRgkxUDYew@archie.me>
References: <20251020020749.5522-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ur+dtA2G+9wRct2L"
Content-Disposition: inline
In-Reply-To: <20251020020749.5522-1-linkinjeon@kernel.org>


--ur+dtA2G+9wRct2L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:07:38AM +0900, Namjae Jeon wrote:
> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Can you write the documentation at least in
Documentation/filesystems/ntfsplus.rst?

=20
> - Journaling support:
>    ntfs3 does not provide full journaling support. It only implement jour=
nal
>    replay[4], which in our testing did not function correctly. My next ta=
sk
>    after upstreaming will be to add full journal support to ntfsplus.

What's the plan for journaling? Mirroring the Windows implementation AFAIK?

For the timeline: I guess you plan to submit journaling patches right after
ntfsplus is merged (at least applied to the filesystem tree or direct PR to
Linus), or would it be done for the subsequent release cycle (6.n+1)?

Regarding stability: As it is a new filesystem, shouldn't it be marked
experimental (and be stabilized for a few cycles) first?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ur+dtA2G+9wRct2L
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPbRJAAKCRD2uYlJVVFO
o4fLAQC9ziCngS89WuEfqTocrRXlfW6dZ4CSfXOgRPLqmBXt8wD9ESIhxlphKnHL
WSd7sZPRU/pLFxr2Jyn+0gNvGzkDCQk=
=zCxj
-----END PGP SIGNATURE-----

--ur+dtA2G+9wRct2L--

