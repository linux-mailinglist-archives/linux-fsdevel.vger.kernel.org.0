Return-Path: <linux-fsdevel+bounces-47218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05020A9A960
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 12:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCE3175B6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC1B22170B;
	Thu, 24 Apr 2025 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9VIUzC4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3C221293;
	Thu, 24 Apr 2025 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489113; cv=none; b=WY02tkq3SDQw7bshysTLO6avuXlcy4Pjyigs49kdnlG7DcVJrXL5QKmAw/qWWgtOfCoYgPo0XG8gPCdsDvK/xiYQbMCSDq1t3vTWAeE8aVzRe0mK5MueKTTn1qjHYNL6ixkOjiqxV/8QkKVyWbQ0NRsW/6+8IqRNzfGcW7WUIjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489113; c=relaxed/simple;
	bh=mWVeHiPGYUguH8fvx/E8hT4+JBANZnv7XHKFn5RtBkE=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=Fb2aR+EZB87pQkPGn+Z9IrCBtuDoVZMPRKv9HI4jxp4vCMV8QNwgBV5771rzvUatviDIGuaOLd72dZE8X5sANGumanPmw4xacqbp46gUQszoMZsSrFpkh2DogOipA9MnbDAUXwvG3wFaUF1b2RWrM6ruonkHXBkwPP5m+TuRe+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9VIUzC4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so5367925e9.0;
        Thu, 24 Apr 2025 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745489110; x=1746093910; darn=vger.kernel.org;
        h=mime-version:date:user-agent:references:organization:in-reply-to
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5AFW0Sl5/PIEX/fz2VgnHx4IggLIWYC9XsMAjjZFis=;
        b=F9VIUzC4R1x3wRb1Q/2Cfv0SWEsNZMg03PKo8AAlHQxW+5sHDl4uFy/znkWTll6yd8
         Gzd/FRJGot0iAXm2i6Lum/PFQlFa+SYuJe7BCn3/zh8axbi37tf6okQ9qGp57oXpTEpx
         PiYPwKotu/BPYEULRhWX8/59NkoSA59cDo4VWSsqnfMYvDW4qRZedUd0VmT5KFBfLM1b
         6kMWeX/aJd7yUReOo6LoL4pE5qBdJPO7c/cORJSvE0fk9qa37hey3aAOBKC0FGfX7kVk
         Ksm43w/y6qBYfKYCrY2z1fgn7grLI5V9igtc+31ypKM84UbQdci1jZJ4pTaKxJx5XSj5
         EC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745489110; x=1746093910;
        h=mime-version:date:user-agent:references:organization:in-reply-to
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c5AFW0Sl5/PIEX/fz2VgnHx4IggLIWYC9XsMAjjZFis=;
        b=inBJqQS8/yvqvBEOOo7c8+fOmF4FjopJZ/MBeS5+L1pKrQHUsD/bWyd+QwBVYeBDnF
         pA/LeHU0wBXEXmQgqoVj88qDqy19OA9y5UA+t6iXxz41hwm1al19JonCqJu1PKAp7u3W
         Z4T+fRaOpFz8Lo15U1GkWHCJY4yfUenb9M2NvR3UKcdR382rY77QR9OHJT6bJ8O6uDLe
         AIvyldj3Rhem7Dr2sgPJZp1nwhkrHkcUpOTqjT4FyL1rBbma86SLXm8cjxwZ8P/1eHCh
         0HJJUenF6GchPksQcy+ZDXDdYgnTsYcBXZr1s+D0BxbTuh8QSuB/BMRZCsExuMFVJLxv
         VVpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5EEfr4AVLDNzkLtr6irmJTjFfXGwKfVwI6vPPz2EpgLeZM9KZrmmtyPl6B/OmrBzjU1camv6t+xrakO/7vSQ=@vger.kernel.org, AJvYcCUMlnS1PP4QXF1CBLbopM7lRZfcDr480B/W+ccHZeSUBmxpMRaU+zKfEO/oDJBAteEAa96hZkHXQKej@vger.kernel.org, AJvYcCV9U0xoqkALseM9fkTGjSmErY/ZY/sInwY9jUwOU5AX0dVG88XDAplRSUPzJGZEDwxeUJnAK9ecs9zj7Q==@vger.kernel.org, AJvYcCVktqAIYuuOrCPmAfHtXM6/iN748RO6WuzFo/uLbZygrEcIx5qaGJrHdjNbaDI2U/rp9gSa3gA/AYcIySo3@vger.kernel.org, AJvYcCVlUkdd0THXRsoxM69gyxNYTsfzwvkaVeAlRLNwdhpX/IvYxiBuNMgUmqd16l5oc2cNAnp4g7L18c2toK8CjaGH@vger.kernel.org, AJvYcCW+gnvYhcVrAdxmRmZIj3lZmGXAKVg8xHs8RkyuvwZJ9+vukY+XDJnzsbW4+xu84+I4MojZVYcAkLBhV8xFzA==@vger.kernel.org, AJvYcCWT26vfHXuxf4ZdkGUnR0Fwep0u6pIVYxTGIRy79hG3zka7ozAicBbrnsX5MhJxulqu2/6V32ssVyKy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9gYh1pOmzAaKRQv64pHb4wl02Vk569heqiCyyvEduVOmAKXj
	QUspaPsUSBXYs396FzBJ3YztaHBpqPG//7EhyTG07peTSlbb36Cr
X-Gm-Gg: ASbGnctNUvv4/ZeKyBFenOpUmxle3iJx97Dl7Xj/h+D1ZWowwG0iKl74TB/oIxmY5w6
	otu4eYqoJbVV5Bxf4SwgjgQe1Yk2BE5EtpGf3yROmPIghCsTBaofZpJn1jlOew1/fZKk4bkfh8M
	jFBebWBsfswGIc3Z59nJIt3R+/Uw+fewmt/WopX+fV9ry+EVqwIGcoZaK0JKOrrD1KNO86XHYJF
	rwYB43uas5dlrK+PtlNoN5NL2/KwUZXt0QrWx9Cub9un+oUhlSyRFrdnRkkNXqPncRbgB86z9fQ
	MihP9QnaEcil8CSIDHQBWuz9ezM5mjPIBGylLKbzKJjW
X-Google-Smtp-Source: AGHT+IFyhtL9Ef7Md+k5uRJ2uRcIXFYfZUHtQ6CdgOkpuVG7jZDLW9qm2lmSxi2HeBkY7L0FMNMN5g==
X-Received: by 2002:a05:600c:1913:b0:43b:d0fe:b8ac with SMTP id 5b1f17b1804b1-4409bdaac04mr20233865e9.30.1745489109241;
        Thu, 24 Apr 2025 03:05:09 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4409d29bf8fsm14517845e9.1.2025.04.24.03.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:05:08 -0700 (PDT)
Message-ID: <680a0cd4.050a0220.296475.3867@mx.google.com>
X-Google-Original-Message-ID: <87ecxhg9in.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,
  Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  x86@kernel.org,  "H. Peter Anvin"
 <hpa@zytor.com>,  Andrew Morton <akpm@linux-foundation.org>,  "Liam R.
 Howlett" <Liam.Howlett@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,
  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,  Albert
 Ou <aou@eecs.berkeley.edu>,  Conor Dooley <conor@kernel.org>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Arnd
 Bergmann <arnd@arndb.de>,  Christian Brauner <brauner@kernel.org>,  Peter
 Zijlstra <peterz@infradead.org>,  Oleg Nesterov <oleg@redhat.com>,  Eric
 Biederman <ebiederm@xmission.com>,  Kees Cook <kees@kernel.org>,  Jonathan
 Corbet <corbet@lwn.net>,  Shuah Khan <shuah@kernel.org>,  Jann Horn
 <jannh@google.com>,  Conor Dooley <conor+dt@kernel.org>,  Miguel Ojeda
 <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
 <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,
  Andreas Hindborg <a.hindborg@kernel.org>,  Alice Ryhl
 <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-mm@kvack.org,  linux-riscv@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-arch@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  alistair.francis@wdc.com,  richard.henderson@linaro.org,
  jim.shu@sifive.com,  andybnac@gmail.com,  kito.cheng@sifive.com,
  charlie@rivosinc.com,  atishp@rivosinc.com,  evan@rivosinc.com,
  cleger@rivosinc.com,  alexghiti@rivosinc.com,  samitolvanen@google.com,
  broonie@kernel.org,  rick.p.edgecombe@intel.com,
  rust-for-linux@vger.kernel.org,  Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v13 20/28] riscv/hwprobe: zicfilp / zicfiss enumeration
 in hwprobe
In-Reply-To: <20250424-v5_user_cfi_series-v13-20-971437de586a@rivosinc.com>
	(Deepak Gupta's message of "Thu, 24 Apr 2025 00:20:35 -0700")
Organization: Linux Private Site
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
	<20250424-v5_user_cfi_series-v13-20-971437de586a@rivosinc.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 24 Apr 2025 12:05:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On dj., d=E2=80=99abr. 24 2025, Deepak Gupta wrote:

Hello,

> Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.
>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
>  arch/riscv/kernel/sys_hwprobe.c       | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index c3c1cc951cb9..c1b537b50158 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -73,6 +73,8 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
>  #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
>  #define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
> +#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 50)
> +#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 51)

Notice that, as it stands in Linux v6.15-rc, this will conflict with the
values for Zicntr and Zihpm. See 4458b8f68dc7 ("riscv: hwprobe: export
Zicntr and Zihpm extensions"). I'd say that you should update these
values.

>  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index bcd3b816306c..d802ff707913 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -108,6 +108,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pa=
ir,
>  		EXT_KEY(ZCB);
>  		EXT_KEY(ZCMOP);
>  		EXT_KEY(ZICBOZ);
> +		EXT_KEY(ZICFILP);
> +		EXT_KEY(ZICFISS);
>  		EXT_KEY(ZICOND);
>  		EXT_KEY(ZIHINTNTL);
>  		EXT_KEY(ZIHINTPAUSE);

Greetings,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmgKDNAVHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVlMe8P/3GWvWsJksgXvOwVEdZk24vFu0lQ
heUgo5llXNYRxNaU0iBfZ3qVuWR1WIoDsFnd6EzvAM4/miQK/jOfgb4/xOXls+Ah
qzj0dMvXuLWIRfEom5PhWxW9Tevfl90Pk/TkkzvmaA0t4D/eEvKOsFEFpLFFnP+t
/fCiUbrVg7ahnA0Z9vBA7oLJt9NNks7FOSFH3ZmiJLI82sTMOnQKxGe+GHy0bUc+
0pwUt3aeugR6ZciXnDq4Gfj5m8zBxHgCpGnSNk9eQTtrXXPHcrRBDHAIFESssje8
TaZzLO4+jKovhY6jicjetbtiLYyldXkOz01R49CcxwVlAD5fxgNYpcHu3jnjx+Hw
wSHeMcyjabQHhBop019M9OAFIBQPIKS1B6y570G+M+t19H22083cwGIdLqIYAOfv
3Gml165o3Sl0NPVV/SnNaW/0mxlZq4Y9wXHbnNEJ1JMJlbNYJJeKPvvcPGD9xsgb
iqT5gFNPh4w6OWM34Pb25D6Q1PNlKy8BX9DPgaRlKyRNNutuqJg5x7PK6LN7t4gR
gjrvXyVDQ2rWt1JnR6lq87uVLvuwRC6YEZJIOZ59k4bWzhwvl23a93wACN0PJyKg
yUcHgDHSscAYTxSkOSAWX6Kkh7pg9aiZ3hHYyeI4wKuot02nuZzZZ1/iigfX0X8x
PAoq2NET1dRPiyaZ
=JubY
-----END PGP SIGNATURE-----
--=-=-=--

