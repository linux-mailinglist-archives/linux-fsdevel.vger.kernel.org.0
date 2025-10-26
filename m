Return-Path: <linux-fsdevel+bounces-65639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D09C0A313
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 06:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C933B0C5D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 05:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661FC25BF14;
	Sun, 26 Oct 2025 05:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUT5bTFy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A31EFF80
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 05:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761457077; cv=none; b=kApsCL+TFlMXCOUOr1SKpHlMxQg17Ca8uQfkYcOXq2n58CgCGquZlpNBI9siPr2GAkZkrau9wIuRFKxPvPiMII+t7vVYJiLhM0b01LLMZ7p91mDOzYJNtyCydndjhrjK8qwT0Gq8MsDVKuuF791eWRatRjUBtoY5OV5eDQBA5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761457077; c=relaxed/simple;
	bh=ZFlH9WUZ20Qv2TIGfBwrErznTHyKYhCP0gxINTNVu00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHpjQvbuKNB5m4RXkFcirG77wGGEltardHc4bZMaotcM/y09FqpPtBpx084RXLSfYynjXaV/e1a69/Gx2166Q4squNLNtAtaBba0PZxdUtn+svS9iNwwD3P5XrTk8oHbBIROMtkfFOcFTJoqRr7haZhiLuXIxL0bUAf7vVkYG1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUT5bTFy; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33be037cf73so3723917a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Oct 2025 22:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761457076; x=1762061876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5uL0IOiz0DxVb8nciIZAOczYuSM8Tw4kuGT7Ar8ZkBY=;
        b=hUT5bTFyUaowyKPVlvKQ9Z5oZfT09g801lJAiS4fQYCoWLe4y0WPaBDhxTf4QMmv9c
         YYf5ai6xYMn4UzEspl0/xNEA0zWeIGc2us3EfPwUJITJV4uChq/j98HR4Ps3fYa4rirN
         Hrq0CtXaWKJ2KYwyePIz33YbYnC4hFzHnt4uMEB6Ny4RArCjpBS7SWTX/dEdTzjPmLVb
         aHkSUqvhH3m8fjzhmL2s9LLsNTtRT0yY6p1Gf9Yl5nFUavEMd4b4YxuwBHopckHL1ZW1
         syJAbrLjv/+WupBXxtdihm81vuxkGtj3pa/flJrYSLzjPB5zQ7ZwpUW+miKI1+9wB/9u
         MZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761457076; x=1762061876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uL0IOiz0DxVb8nciIZAOczYuSM8Tw4kuGT7Ar8ZkBY=;
        b=MTa9fowb4LB74MCAbiqlVR2XYf/AjXNz9PeF9k02OeQEI+Vx6Bgicuo1lILxYnFmkC
         p5Xi5lDZeXj1lAy19FZIAPCRimGD0egO3Bl0v0Maf2rVyDNQg7an4xyNuitGB8re096b
         ujYkoW/ZVF0VOzIJzWJPJzE8Wyim9oUgEBB11xUC+L9+N1z1Q3784vhOWM0kkj90gFen
         PYMTMq7PZHxUioVYsvJMOducdWEPg4nbhNAMiRQ1jhD8FViD8n5ej1QtXwA51bcImyca
         kbBM1g3SuZWN1e8vmUH2/qVKAu5sDZFLudYsdiSEtc0SnhRlBAB1oJRPbjJJe8lrNcHJ
         fTQw==
X-Forwarded-Encrypted: i=1; AJvYcCUqZ5PsoSbofgAd8NWgF8/RKb4swyRlM3A9ZGT/NJ4M7h3kVK6CsHBz+6TJWZXeHo7x1io7R2Ah/OCaXcnY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42a1CYRXmMy2A1OnVqf0yURVUQYJYr+dDmXG50nDwF3Z0IWYD
	iTyD5tbt7Ppaab3XZBqBWxA+CAbn4KJevLedvzgchWDX2q5WPY/EEIn9
X-Gm-Gg: ASbGncsCG6GUiAGLrP5Pu+pAtWIOuuh/yhIYrQ9PkuvJeVXSfHrQdWAbVqZaWYSr9Af
	wXZKTsW3BMfPBeQWR2P+uyeaCPciiggdoV9HtZbw3tXjqD2c304aRCnnY/lo4hGjxWjSFA9CYRm
	BEQyO0Ih19OGNSqykUTR7+NIo6KCzXCalpOOko7zzIawlTCemrNKIQb+VQ4pOkGSc7z6ap1j482
	wHAQOK+6moCdSIZ4sOGQGnJHQDBV7Bsdbgu5sGIz/Qso2ZQyvPY9pFHoqgOZdb/ND1wRQEZkV8V
	ILUkVRrR532itPKxQfYWqe7yIncWqd4PzBKdVQbBEVrrB8DzPxxM2CFF7GaQ5YN6wx36ZCxj5Iu
	xx99E8HYQ/aEYmtuBpBAPTRJWoOy3HA4K5hpXxE7qbDlRMeFp6Qw+B9f6Ct9dO2cg9GyEAkoPP3
	yzRHpIFSe+PSU=
X-Google-Smtp-Source: AGHT+IHj7SryY7YoS8KQmCzR1SuQHT107m/7rZiaD7gMTEJtxD/FrqtwdEP4m1SECcbzmcvUsN7PIw==
X-Received: by 2002:a17:90a:d60f:b0:32e:d600:4fdb with SMTP id 98e67ed59e1d1-33bcf8e61b8mr38801244a91.18.1761457075472;
        Sat, 25 Oct 2025 22:37:55 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7bd393sm4098427a91.2.2025.10.25.22.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 22:37:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8B52541E486C; Sun, 26 Oct 2025 12:37:47 +0700 (WIB)
Date: Sun, 26 Oct 2025 12:37:47 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	hch@lst.de, tytso@mit.edu, willy@infradead.org, jack@suse.cz,
	djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH 00/11] ntfsplus: ntfs filesystem remake
Message-ID: <aP2zqz9aCUcMjHhm@archie.me>
References: <20251020020749.5522-1-linkinjeon@kernel.org>
 <aPbRKScRgkxUDYew@archie.me>
 <CAKYAXd-qMVaorDLzfDBTMvf80WrrmTAt7wGzWBqzfD2bMh3RAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="va4ln/HqevdwWmZ8"
Content-Disposition: inline
In-Reply-To: <CAKYAXd-qMVaorDLzfDBTMvf80WrrmTAt7wGzWBqzfD2bMh3RAg@mail.gmail.com>


--va4ln/HqevdwWmZ8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 10:55:15AM +0900, Namjae Jeon wrote:
> On Tue, Oct 21, 2025 at 9:17=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> >
> > On Mon, Oct 20, 2025 at 11:07:38AM +0900, Namjae Jeon wrote:
> > > Introduction
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Can you write the documentation at least in
> > Documentation/filesystems/ntfsplus.rst?
> Okay, I will add it on the next version.
> >
> >
> > > - Journaling support:
> > >    ntfs3 does not provide full journaling support. It only implement =
journal
> > >    replay[4], which in our testing did not function correctly. My nex=
t task
> > >    after upstreaming will be to add full journal support to ntfsplus.
> >
> > What's the plan for journaling? Mirroring the Windows implementation AF=
AIK?
> Yes. It would be best to first obtain the NTFS journal specification,
> and I'll try that.
> >
> > For the timeline: I guess you plan to submit journaling patches right a=
fter
> > ntfsplus is merged (at least applied to the filesystem tree or direct P=
R to
> > Linus), or would it be done for the subsequent release cycle (6.n+1)?
> It will probably take about a year to implement and stabilize it.

I didn't understand. You mean ntfsplus will be non-journaling fs for a while
after upstreaming, right?

>=20
> >
> > Regarding stability: As it is a new filesystem, shouldn't it be marked
> > experimental (and be stabilized for a few cycles) first?
> I heard from Chrisitan's email that he was considering adding fs/staging =
trees.
> In my opinion, it would be a good idea to promote ntfsplus after it's
> been tested
> there for a few cycles. And an experimental mark is also possible.

Ack.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--va4ln/HqevdwWmZ8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaP2zpAAKCRD2uYlJVVFO
o3nUAQDj7fiZwVXlgFI61A1qgbueFCw7r0u8mPIfpG0zXaHLrwD9GR2KyMhEVv9V
woUArWYD8T4NcfqWOEk4qPTFMx6uQQI=
=APhK
-----END PGP SIGNATURE-----

--va4ln/HqevdwWmZ8--

