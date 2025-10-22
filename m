Return-Path: <linux-fsdevel+bounces-65014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C283BF9B2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53A5D4FBCC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 02:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB69A1FDA89;
	Wed, 22 Oct 2025 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGvnAwwZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E13219E8C
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761099366; cv=none; b=SxgJpfcjqOhHTgqaeUh7wWjDMMT6Pb0tA84pqwGb9FKtjRrNm3qjvXSUb6le30DrBaG95YIYaWr8+CP+w0V3au7kfAVnlqgRovn7QZKmKtv+7TOmh32hyvDP8Cd3F0t7CgS09BG8sCfJr1xOXJ2ecS43vLNy+BrQp5tWrqz8ALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761099366; c=relaxed/simple;
	bh=ZNYpaJWfK2uX7fNuNpV/cydFuI7wkAz8CLs/mB6yfTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNLMcCd4Xl/k2icNdV9r+jEV86tHLQdwOSXtkceyThSdOUEuJ8t8ZoUrpUoiw56cGb+iL2KOC5Adnd+TuEdq2lJcEtJipyo/CPdmGgcVoneOhIiABYRvZzoMN57nf6bil1CmLPSRRwzMo9Cflc+z510QR4YJDJQJVUEZF2ogc88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGvnAwwZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-78af743c232so4973001b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 19:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761099363; x=1761704163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+yFbQwKVrg4ulSzHTYcdE0/YBPiD7WzPZ8N0zJ6yfUg=;
        b=dGvnAwwZt24nsiLUJRQ+UeeMvxr4qhMK7hbIRNA/JtjRZm+MyX5aOyGPmAE9+aG63s
         sIPjbmktHkBIYrux7vtL2hYmwgKy0ZO3SrjGJoinbBzGJ0vhWAzp3oFa2NwKF+6HSpaF
         U33/acgsn/aL38aB64HDrZvRVH3aNZwo/M+146H2/AR8b2/2Bsd1Sx4Ti5+ucnXNz4rP
         jDfYjgKGeoOKPPUszAjZK8/F2YJ5RlC+Z7nmDvQ5Hymjjng1sFkw+m7TSR13ClGpOhwb
         mWuP6aVNTUZKshV9RAdycFKEF39Uue+m3oIL87XatFOPv0ffaBxrpAiEi6kShMe0dkda
         r2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761099363; x=1761704163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yFbQwKVrg4ulSzHTYcdE0/YBPiD7WzPZ8N0zJ6yfUg=;
        b=KgQEPtUm4InxyD4vQUry03L9KNVoWb1PBfb+X8axGZJnCyF7jRL68pxVhTgLs+rRAc
         3gcNybU5e+OiMF1kJGgMJ/cO9OaL1i6c1pT1eeWF4ioPl5nN2CmLNS+jl6kD9EGTEi0N
         gGtLV7BfSKsad+BB42KoSfTm/Ek+g69VnQfS8tet8WVu9KT+yYL4WNtqs8gjCkrS5RLb
         9sT5IdHGB/AHmIuVc1GCA8RKPoNnHHcuNPub6KyLyB75lloFf07xXfSfzJ75ktG2aCar
         H9o6mWrsPF7GyKClrwxYCOgoUi4qUVkQc3sIzpFTQOZpj1wxB80y1uwPPmGRkF2QYzHL
         xN8A==
X-Forwarded-Encrypted: i=1; AJvYcCXsdW2qUYs+jBEH3GxnMQvkLxG9eiHJT2uCpS0kojQRnC6UxuaUbgE97gx5UC7s2I+uhqh/KD5cL1kTciLu@vger.kernel.org
X-Gm-Message-State: AOJu0YyWnXBdQy6M16uwpj5trduS38tXALq5Kwfcog8n3K3ziHDP2tzy
	fVYBtSQzGs2s9BjAiLOhv4vN23tCCa7QidKN8+mqqwkiORR5jqjAfuAb
X-Gm-Gg: ASbGncvwQxZF0kgfU+hudIiL+QjyKPEq6yerdpXkXyZNDejIcP0lsglZmRbogKIRr0i
	Iv7PvU1Kn4Ksn4gTG7z1r6syEVsqFUPIHQ9PEKcpjGR/guVhilZrntRaNQ9tQeCJnRWDJB8U3hY
	D8zLbIBakrKNsuHkAGAqMvsBXCHY0tFFC6I4g+hIOKscr4+u5dSKfmI0eiJswko0EDG0vJyo5Sb
	tpQdofXK64EKWUgaMyqpk+WVFp2S7g3pY3pX1HS7d9SqaLuMJre6VlTPQ71b09QifprWW976NPA
	btoKhZ1LWMeHNrhvd2alm/IcLNtPMUIvUDs7ldTHagv/6xjRqpES9CM8ojREdg7ccdMQVdwKaaN
	7QAdzqcmLbC2RMqFL69Z8CQxvF25GKitmWRzFpzWaVMvkMhFgiNvcKTLYimTKZhRV/2D0d7Lthl
	pplnCnmglqCcW1
X-Google-Smtp-Source: AGHT+IHgcLczGY0gNkz46ZH3wqYDdp+xytg9WZxLoXNNek71M0Z3I+LEtQXMo7LSXlQTlq9C1XGtow==
X-Received: by 2002:a05:6a20:5493:b0:304:4f7c:df90 with SMTP id adf61e73a8af0-334a861852amr26222250637.50.1761099363079;
        Tue, 21 Oct 2025 19:16:03 -0700 (PDT)
Received: from archie.me ([103.124.138.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010da0bsm12753936b3a.55.2025.10.21.19.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:16:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 48C344209E4B; Wed, 22 Oct 2025 09:16:00 +0700 (WIB)
Date: Wed, 22 Oct 2025 09:16:00 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org, linux-block@vger.kernel.org,
	initramfs@vger.kernel.org, linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Dave Young <dyoung@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>,
	Nicolas Schichan <nschichan@freebox.fr>,
	David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Subject: Re: [PATCH v3 2/3] initrd: remove deprecated code path (linuxrc)
Message-ID: <aPg-YF2pcyI-HusN@archie.me>
References: <20251017060956.1151347-1-safinaskar@gmail.com>
 <20251017060956.1151347-3-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m/ueW+980/ea0Wf8"
Content-Disposition: inline
In-Reply-To: <20251017060956.1151347-3-safinaskar@gmail.com>


--m/ueW+980/ea0Wf8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 06:09:55AM +0000, Askar Safin wrote:
> +		if (rd_load_image()) {
> +			pr_warn("using deprecated initrd support, will be removed in Septembe=
r 2026; "
> +				"use initramfs instead or (as a last resort) /sys/firmware/initrd; "
> +				"see section \"Workaround\" in "
> +				"https://lore.kernel.org/lkml/20251010094047.3111495-1-safinaskar@gm=
ail.com\n");
>  		}

Do you mean that initrd support will be removed in LTS kernel release of 20=
26?

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--m/ueW+980/ea0Wf8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPg+YAAKCRD2uYlJVVFO
o9OtAQCr/giTF4+FVt9hiDGkb1l4yn/kE0D0NKGYI1gigRnAqAEAhLIU0ssllGOB
IgSBphGX7ddV9bgZvHiqagtFYOgJwwo=
=plLG
-----END PGP SIGNATURE-----

--m/ueW+980/ea0Wf8--

