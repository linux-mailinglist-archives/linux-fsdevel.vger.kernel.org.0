Return-Path: <linux-fsdevel+bounces-64095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA6EBD80A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 09:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28171890806
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 07:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB5029C35A;
	Tue, 14 Oct 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST2brMWm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A692BDC0B
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428635; cv=none; b=IuNKJOtHfgTPsQFR9NBVvBo5w2I+5t1tWCpN0IihET15UfTTYqEU+ROitANiItGVpC0DcEnXstN7mB3ykb0k0vyd6HxHrHQXf5BQxhxrSOfx2Q8KDWVJXJtJEw74DXQfLyzGQTp1OEr4NM16A5l5QEBSJOnAd2kWbhRTyhILbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428635; c=relaxed/simple;
	bh=fEuw9BmVbevlm5d7M1J5zA/kuTWthYgdzEwCg9slGHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2e9EXqzC9c9xo2qKV8qZWqUDFxNnh1Z2R1Zl/RQFRaf65oqKmi/E9aIkRqe5aB09igz1qJd9DA58vC2/LUqsSLcaINeZSTYmuvPS/CxlAD47m6N5fSkFVLt+9ud8vvylBpOOcj0iXeJ7f0AMO+OvPL3Cx/ibjhQKJYehIZWLmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST2brMWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9285C4AF09
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 07:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760428634;
	bh=fEuw9BmVbevlm5d7M1J5zA/kuTWthYgdzEwCg9slGHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ST2brMWmt4nNGUfxbzAXdS70ncFlNeNLKvmk/cjfRH4atA81txSOr54hAqpsVuigh
	 LvOa1Nx39YcBoy13XevvFNNuKT5HnLqc2MJz6+G9FSqFOY302eYpoELpQm7TcexyHi
	 rCXUCUwxlta320AK+jGH/vQ9IzdmunaRRSbhPx5lX69YITjWHg2JuFm1x8IW2nmj7c
	 XKBHi/OupFdBk4otzPSH5XlFz48eeZnkoPGYSXkbtLzrCPWEvwpdDCvj3mmr0h6vf3
	 39s9lwAsmD0v/W172ahM/KAWpceWvZebuLd9z/+w2F5EH8s5x432pBvVHVwTwDmmRv
	 sFgJRRiPsyrRw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6502b1c3d72so853074eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 00:57:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULILmpBdp5ljz37vJGBOGUSSJMzdIAf6AwPJvnjL9Ibz1SHaG7uUuIHSyvEeMdcuyCtVtCoFFcjg4pcDBz@vger.kernel.org
X-Gm-Message-State: AOJu0YyWE55sCnDFU5VuItKUVUDhVpBaX2+SVCorZZrCI8Kytq4npGZM
	Gu4vfILZn68sRFXs7lwKCSkwUr0IstyihJ+wnLUogKdWD9xcnwSlBj3Bbq1oLCzOnA3mp3uxeCn
	09Q2H6qgNEdFkQSg2yoUdLwpcokdIxTw=
X-Google-Smtp-Source: AGHT+IFPfDnTf9zbEN9jReILv+Rc7NXW+rIBj5xxOTW4Icy7cI++nKtqurabUVrLb0jyQUr+3cyoo/uPc7hkMYCziko=
X-Received: by 2002:a05:6870:5247:b0:314:b6a6:688a with SMTP id
 586e51a60fabf-3c0fac56c8cmr9786164fac.42.1760428634196; Tue, 14 Oct 2025
 00:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011200010.193140-1-ebiggers@kernel.org>
In-Reply-To: <20251011200010.193140-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 14 Oct 2025 09:57:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFESWp8KjVoGhyXFwTXcZQ81f9P74ds7GnwVhkAR6SnmA@mail.gmail.com>
X-Gm-Features: AS18NWABRew3uh8RVpYgf0vAKaZkNB388gqZj2t9wvNfhwSofVyRAfdQ3BIpZNg
Message-ID: <CAMj1kXFESWp8KjVoGhyXFwTXcZQ81f9P74ds7GnwVhkAR6SnmA@mail.gmail.com>
Subject: Re: [PATCH] ecryptfs: Use MD5 library instead of crypto_shash
To: Eric Biggers <ebiggers@kernel.org>
Cc: ecryptfs@vger.kernel.org, linux-crypto@vger.kernel.org, 
	Tyler Hicks <code@tyhicks.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Oct 2025 at 22:02, Eric Biggers <ebiggers@kernel.org> wrote:
>
> eCryptfs uses MD5 for a couple unusual purposes: to "mix" the key into
> the IVs for file contents encryption (similar to ESSIV), and to prepend
> some key-dependent bytes to the plaintext when encrypting filenames
> (which is useless since eCryptfs encrypts the filenames with ECB).
>
> Currently, eCryptfs computes these MD5 hashes using the crypto_shash
> API.  Update it to instead use the MD5 library API.  This is simpler and
> faster: the library doesn't require memory allocations, can't fail, and
> provides direct access to MD5 without overhead such as indirect calls.
>
> To preserve the existing behavior of eCryptfs support being disabled
> when the kernel is booted with "fips=1", make ecryptfs_get_tree() check
> fips_enabled itself.  Previously it relied on crypto_alloc_shash("md5")
> failing.  I don't know for sure that this is actually needed; e.g., it
> could be argued that eCryptfs's use of MD5 isn't for a security purpose
> as far as FIPS is concerned.  But this preserves the existing behavior.
>
> Tested by verifying that an existing eCryptfs can still be mounted with
> a kernel that has this commit, with all the files matching.  Also tested
> creating a filesystem with this commit and mounting+reading it without.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>
> I can take this through the libcrypto tree if no one else volunteers.
> (It looks like eCryptfs doesn't have an active git tree anymore.)
>
>  fs/ecryptfs/Kconfig           |  2 +-
>  fs/ecryptfs/crypto.c          | 90 ++++-------------------------------
>  fs/ecryptfs/ecryptfs_kernel.h | 13 ++---
>  fs/ecryptfs/inode.c           |  7 +--
>  fs/ecryptfs/keystore.c        | 65 +++++--------------------
>  fs/ecryptfs/main.c            |  7 +++
>  fs/ecryptfs/super.c           |  5 +-
>  7 files changed, 35 insertions(+), 154 deletions(-)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

