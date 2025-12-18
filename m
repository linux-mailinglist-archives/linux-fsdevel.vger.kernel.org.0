Return-Path: <linux-fsdevel+bounces-71624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AD6CCA881
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 07:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF5C93014DC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888472BDC16;
	Thu, 18 Dec 2025 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHgEDXb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B251287247
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040494; cv=none; b=UyQtApuK9SJgKzJvsuQZoD/rDiNmnyJL+iFx/9iy2fXnwjkmk3COQeTWF1qIJA/juy/KrqBdiEi/yarGDIi8CPD+czF75LSQpvco0ofXAMm1qDM8+SD5lNjX5qSk2PTnyA/KliHZ0+zH8P7TeZF8oS7tstVMrUxy+b8dXhdEX7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040494; c=relaxed/simple;
	bh=td8xmgm4oJowkjY1lKI/qY96vQyQyG8ueEn/fs67KAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+HkAal17Tx0ZzFo+llf3TvoVMwiP81ZKcfJfs195MtHbqWXUa1lEL6Pd+4eMzYiZTC8EfCJ70Cpf332NvE6EoYBgIJ9ous8Thh/zQM51qTixEZgZTyukLtrsG34Ad2kuUsH8agZX5p2gFsZP6lqb927aH6086X/fBvR+0F6YdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHgEDXb7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so283212b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 22:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766040492; x=1766645292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KUxz6sONf+HZLPjB86zqBHi/K/XXAV3eK81uWskGSZg=;
        b=UHgEDXb7R5DJFfDRO2wgJTnHYjIJkuu+ftW/SPy/X2qVYmeM5GgAIbtCuUbq74/DZR
         MPvUyMifpLwZSBmdsWJ4Fdo9bTH80M+4Xp7Cyj1qQmTccPdlS90SQbBTKhrv9oqnfo70
         JtzeMhFCThg6dcGZGL0kpO+yEQxCeDqTG17zaS+e+5wTDNFwctjdfFrStayDcL1fdU5c
         uBzWNnq99nS916QNBC8A7fYj6pKGt9XdtA9Ap9uQ6e2iHAwizamd/VoKj9xOhTLM3W+5
         YpbCta8i9efWA6svknrr1vwm1ylH6ulh9LwFnxJEL2IA5ZaEPP92sWBku9qbM5GW0zuH
         hJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766040492; x=1766645292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUxz6sONf+HZLPjB86zqBHi/K/XXAV3eK81uWskGSZg=;
        b=rao2H4Ghj4xYsNVISMss5Ank/Ynlt0CzL3fu/jFg3J+GF3D/q/PZtExplW9Xjz2l1L
         ldObkIyQ5oILmA6Td5D0RrcRy+6958mnE4yETWjMOfb6vOVieFuM0fGRp4gq/hdGcqqM
         ag8pLpy7LjRwCyuVTrphvlF2mmN27kpQjzepmKzVr9dkoCSNNXzgwZvdvqPQwE3G6/cT
         Ggx9IXgIwsU+1khlG7HKtOqj2q7QdpjLuoB2oMM5HqpBFd1cEWl1XPnFHvP+928bjuR3
         VISjnaVXv7iBF3FN8INiohGfKbKhIvJbx7YxAy3Uame6fR7eNCOQdhDca433Bi8WmQ4g
         +oYg==
X-Forwarded-Encrypted: i=1; AJvYcCXF1/E19uXJYSiIw9bdSwQc7RJ+VZq0HgCDU7imquZIRPWeRFbkbFDPnjZ3JBfnlW0n+aBtTH3N9YJEPQ0P@vger.kernel.org
X-Gm-Message-State: AOJu0YwJEmFZB/NlHzxb8B7BWDv6lQ0RfMQ6bT+e8NCyGUFr8Sf3NBi6
	2GKjMyNuTfZ4ND3cUX71HY3Gyey9RTAds+9ZfgM0qzmdVHjIlAmIF3uT
X-Gm-Gg: AY/fxX4fGrOhMd0CGoXqOzFVmc2oE0CALYt4YMAvjNKvmNxIesCWZ16YrwIJrRlkAbr
	6aekKisN2a7WFs6yW1LZ5vNSW5zCfQt+29OhcmmLo8Qlo2lUDXF6bpmBv5Y2oYNJW3XK4e8v/Ad
	HJviNS7s51JYse4bwoq3o3llokcOug+qWNeIACulcMXge8tDyXDzHDZrOOKw+Y7pGCHnNYt/0x+
	YbT5LeJRKQlJJ259SAHMNjwwnJ6jWkKavOPwgoR/ynpJsEqzjad/Q2sxYx4OePijix72gAVwhLp
	/VMFpv3kI6T48EdS7xUKLpMBQoHC3K515I1FBzeVed/k7ZxWNgYtYFVdoQj/3XC2+L0OB84uzj5
	TBf0ZFn1Fy3h/O/94+HK7gnTQLauGHFQiR+2Mn6YTMTrCfmknQItArDNp9L8nXUpwKdcOkJIxOz
	OauTNMsoxrQKjlbRZ4+F6eNA==
X-Google-Smtp-Source: AGHT+IE1EUTfc3RHMoZuxgRWP284FPbaxm9m4v53pjNa4O1GscTUkbq2OlLpW3Q1DGw168AFk3Fk4A==
X-Received: by 2002:aa7:82cf:0:b0:7f7:4f81:dbe9 with SMTP id d2e1a72fcca58-7f77578b86emr13250422b3a.3.1766040491643;
        Wed, 17 Dec 2025 22:48:11 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe11d3e004sm1501654b3a.15.2025.12.17.22.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 22:48:10 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 7109241E8D52; Thu, 18 Dec 2025 13:48:08 +0700 (WIB)
Date: Thu, 18 Dec 2025 13:48:08 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] VFS: fix dentry_create() kernel-doc comment
Message-ID: <aUOjqBtYX-rafsvU@archie.me>
References: <20251218-dentry-inline-v1-1-0107f4cd8246@gmail.com>
 <20251218061056.GX1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XWovl0DpE9Qdn2d4"
Content-Disposition: inline
In-Reply-To: <20251218061056.GX1712166@ZenIV>


--XWovl0DpE9Qdn2d4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 06:10:56AM +0000, Al Viro wrote:
> The first one might be borderline sane (I'd probably go for O_... instead
> of O_, but whatever); the second is not.

Or O_\* flags?

>=20
> Forget kernel-doc; what is that phrase supposed to mean in the
> first place?  "struct file *" (in quotes, for whatever reason)
> would presumably imply a value of mentioned type; a function
> declared as
> struct file *dentry_create(const struct path *path, int flags, umode_t mo=
de,
>                            const struct cred *cred)
> *always* returns a value of that type, TYVM.
>=20
> I'm not a native speaker, but I'd suggest something along the lines
> of "a pointer to opened file" as replacement for that (without
> quote marks, obviously).

Ack. Will apply your suggestions in v2.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--XWovl0DpE9Qdn2d4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaUOjpAAKCRD2uYlJVVFO
o9wjAP9s47v0VZwoRBG9DpaaL9dBGqlOnxGjDkvGRaz9Nb+TRQEAoI96mcpvczA3
FUtlAPDHZp3k1ghybZd8RBfLc9Hqyw4=
=wsfH
-----END PGP SIGNATURE-----

--XWovl0DpE9Qdn2d4--

