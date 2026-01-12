Return-Path: <linux-fsdevel+bounces-73221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1719D1292D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 13:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A71763004C85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C823357A22;
	Mon, 12 Jan 2026 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TDq65CEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553CD356A0D
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768221513; cv=none; b=YVl0KwmfTBX/YRkZsNEUQW2g55YRmnGUcyHu1r8cuNU2AAE1g3CtMfFQOu/QFxGBz1epNuHSdUN1QS5Zvue6jBc74aaq7T6fujvh1mkCTBvX8O73jlUAd5NsnUkERRmUj920RFWMkNnnrnP8B1flGdYDtePjeO2yZK6ZFW9Ovcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768221513; c=relaxed/simple;
	bh=6nA956yGa0BghtyYESxhz9Ih4PxRdINWeXXn0MESRlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/u9W8aC5TyjK9dcm1nYHALFVSgSMlqzaDw9nMIuVNztBAZxA1Xaje8JoZgBJpLi7X7kJaY9nLFugyx4FeHFzzj12+nEjiK+8eTE07UgZsRemOyOvvd4e6FGtcnnjJgSkstVYzHn3e7F3kM5mRGAZN3O0j5SxU9UjEMrCdmkZi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TDq65CEt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47774d3536dso44941165e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 04:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768221511; x=1768826311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJPyM+iSl9+gUHGXGEFui1PKAGNb9Q5bbO0rp//iqF8=;
        b=TDq65CEt5sY1wwpVGBXlTYKQ1wly9GPG33SkGbiZU/1FSSkrzGNPa8t0ENJA0d8/ND
         we1nGniLMad0YWg62cBnPWImHNV/6GZjIYwhSkV7uBBzVuE89MnhLXZ6qxVfOEv3ugy6
         bOT4vy9AbwOakHaGbc2TOOnVCPOkqEvAZ6UZLzKYOtC+ccpPRzssvkXpdOfKIDD+YNNy
         pVF2yu/a2Q9+eEhTB21orOB9kDKZdGwzAAzijvabkUg8og2Mw7PPosBZ+2noHYVAf8HQ
         fl4zi0ymU8AOCMpU06Ba15xr481n17E8CONcHLCXcX58ellm/cbHP3hSYB8BLzLBG+1t
         CmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768221511; x=1768826311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJPyM+iSl9+gUHGXGEFui1PKAGNb9Q5bbO0rp//iqF8=;
        b=wNf2ECwLLZFE3oCMNhMMYFGXKBLPSeCbuOW2LyAKrvkcODLMR+rumzPjcvFAv+zGzc
         0M/60NJK6E/y0E0I+09+mgKhE03E6qobCdFyashgYGRN10KGCD5iWZxC7smpsZ9YcbzZ
         voOwlb/b2zRNjLwBzredoyTDfYMeo1+ZM/8TDH2o+6xbpSI/vHDjsoFdexy8zo4oVhue
         HveCH5wZKmBGNV6bBpCPT1aRauBhpKquYsRTVALPu9B5Z3f3YSQAiIO43gARsGbewwGZ
         fd3GFk8gY0GBgcXqtCHJEzaS89g5S7Dx8bT8ObvIwF4FFQIewSjV2cqbpeyMnyaCvtcq
         larg==
X-Forwarded-Encrypted: i=1; AJvYcCXyobybVvuUTOR307P21kuhxa48ZzSvfS+HXneqCI727S0psU46+9Z5sS7z4yyednOTAlarFVdhOY33kykK@vger.kernel.org
X-Gm-Message-State: AOJu0YyNvIzN79v8hLBNpKeJwGlFE/Rfl/egmggbCUc75+N2iQUAlhA+
	lh8ElwjHgAhPCvgJSLlJ1aRsaryxxhI+16AiHkLJebw1Q1n5CxNV6NPlbNaFOiUD0RM=
X-Gm-Gg: AY/fxX5edQUoHv6wPGJ6zUkDjmJ14C+x7qc/q5DO6GBsDWnLUbVFYE/Su9aJU9I2vzi
	v/JeVZpU2jAsmVLOPXNdI2zcAift7fZyJkV/9eXkA5P7sFh3LlBYJiWggSRLL/dEtDc/+/lA2jj
	PFhpOcu2kpAG19GHRkLqbKP35jOFlVPehXy9IZYqjjJE0yxzjRZkca4ek0F0D6srwVvfZVm4hTV
	In9ZhejKOTXF+jCC2Glbce6ZOfqbtHDSf8wqfmn/8uqXZtd4CijhXQcXdGKXPpKa+05QX5G1Z4S
	9OBpPw6EA9xGVz4VOI6QQ4Jn8WNEE+TPtcYH2FcFsnDniOb43r7oXAY8GEWIPp0pF6/lmObnBsm
	mG4vpKArNz/RuZwQpjQD49BuIWoTUCP+0dnUFPas9/K7ZKJh1dX3A/xc67dtjtb0ofz7H9ccIie
	82+pv0Ge5DcPXMRBBgkrQM5v6TVYbOMdw=
X-Google-Smtp-Source: AGHT+IEBX9O7r4RZ13L+NusGM/ZK0yEzZLDAA/V+uZ60+JG+kl3g0xr47hSKM+50E8bFxfdYpRdsWw==
X-Received: by 2002:a05:600c:681b:b0:477:a219:cdc3 with SMTP id 5b1f17b1804b1-47d8486d5e6mr184013565e9.12.1768221510694;
        Mon, 12 Jan 2026 04:38:30 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df9afsm40784010f8f.24.2026.01.12.04.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:38:30 -0800 (PST)
Date: Mon, 12 Jan 2026 13:38:28 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Ridong <chenridong@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Mark Brown <broonie@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 1/3] binfmt_elf_fdpic: fix AUXV size calculation for
 ELF_HWCAP3 and ELF_HWCAP4
Message-ID: <zt6p77wtnc2rrw3hko3ppl2sruy64fhrz2mhgyahvpjuzitpga@tpjsfhxmwrep>
References: <20260108050748.520792-1-avagin@google.com>
 <20260108050748.520792-2-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s2pgxkol6rb2nun4"
Content-Disposition: inline
In-Reply-To: <20260108050748.520792-2-avagin@google.com>


--s2pgxkol6rb2nun4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] binfmt_elf_fdpic: fix AUXV size calculation for
 ELF_HWCAP3 and ELF_HWCAP4
MIME-Version: 1.0

On Thu, Jan 08, 2026 at 05:07:46AM +0000, Andrei Vagin <avagin@google.com> =
wrote:
> Commit 4e6e8c2b757f ("binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4") added
> support for AT_HWCAP3 and AT_HWCAP4, but it missed updating the AUX
> vector size calculation in create_elf_fdpic_tables() and
> AT_VECTOR_SIZE_BASE in include/linux/auxvec.h.
>=20
> Similar to the fix for ELF_HWCAP2 in commit c6a09e342f8e
> ("binfmt_elf_fdpic: fix AUXV size calculation when ELF_HWCAP2 is defined"=
),
> this omission leads to a mismatch between the reserved space and the
> actual number of AUX entries, eventually triggering a kernel BUG_ON(csp !=
=3D sp).
>=20
> Fix this by incrementing nitems when ELF_HWCAP3 or ELF_HWCAP4 are defined
> and updating AT_VECTOR_SIZE_BASE.
>=20
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Fixes: 4e6e8c2b757f ("binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4")
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  fs/binfmt_elf_fdpic.c  | 6 ++++++
>  include/linux/auxvec.h | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Good catch.
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--s2pgxkol6rb2nun4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWTrPhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgZTQD/fZEPNQXq4wayVRf5UJeP
yCKrUVfm0ZVJbogI5yyUiKsBAPYaPoop6oDIbDmy08Fmb8Y8MICFtI5C8agrNBfO
CYYM
=f8Iv
-----END PGP SIGNATURE-----

--s2pgxkol6rb2nun4--

