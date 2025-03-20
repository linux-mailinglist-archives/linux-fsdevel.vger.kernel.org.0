Return-Path: <linux-fsdevel+bounces-44650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9D7A6AFE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 22:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4061896812
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 21:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76291221F0F;
	Thu, 20 Mar 2025 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="G5JYC3jm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86E1EC01E
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506559; cv=none; b=FGA2xtVekTlWZ4XCnkykpxvG/1uHKdct7kUUypge9Usr/OdrpHsTQueZ+znYPaGom254msdaoGVkxcXSD6G1SPXUhSAmbBaI26ppGGEE+npKZjhSoTjPYmtH+ocBFbPz7qKTyHvL9GXcMaGeIkwbIpeepe0bRfBsmxJMx/m1wTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506559; c=relaxed/simple;
	bh=0gasMJ9MwLFF9X4TIJDjjd2uvTa8ezZ/DrhvXflVu0E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=WfdyemYFq2lZ6pgfw1V6js9yqjrn6/WMQ46QwHJ6feRAnLT5rtL12idQeVS7vHKeQ2riLGSnEb/gndHnxVEuVyW3i7AfEvnc0cgbvDESK2XX86Iaf9qjG10pgQzImgTpvpYS/D92fyA5faS6/m1BjvV/r/8v+z4NuYK9Kvj7BWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=G5JYC3jm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d4ff56136so474675e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 14:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742506555; x=1743111355; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqJgAERJO0hWodgjO+O6nsJOj3YPTpObkXEvNBlmG3c=;
        b=G5JYC3jmOb6Ff6mrYC1Qo26ZnarpsB81DQV9Kc+bUEWnMhXaly+qjZvxG0p0KjOBum
         ryIRnFQu2RO/iEP8XJxRypNekFqA6IpYfSuR0MFKfnHCq6V8wQKpjyhE2jclV1S18efO
         MJCiKZA+53oolojvPRJ450/cEsJjjlLB2RfSTJhuEgIQarg+KPK1c6akJARSSsofNfPD
         Rd0HCwzfE4hUr/3VHKKPvGGVSg4m65k7DJmu9iAGCezSGjYisxglBwUQ/tGTEjhO0oBC
         Y7WtOA/EUh2856lqJ7qx/EgRq3IetHW4JjNIf0sQkNzF1dSt+r92eZ8w/xK63tTQw2bc
         fXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742506555; x=1743111355;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JqJgAERJO0hWodgjO+O6nsJOj3YPTpObkXEvNBlmG3c=;
        b=q/CFwLK+hp8ZReKLlSrOEd86hoTfiO4ykfEHa6E7pNCGbuREkY96sSItYFEDFo+nfU
         yPez5NBEKR/j8sWGWc+jntYx+Sf8UOJllMsx6MbRogwb1vRM2gjiQGfVAkP9xTcGa7qI
         654Lcjs0onJjqkjyjmpyDzyCAKFkKIPHfXIKOn5AvT5NncozQDksWEdIi/fDIDdtDpa+
         8c1YLjn0jbnSjIKll0VG9FJ/8/3RS/T0zMDZEsCzjHpmfKBnVtD8159wLdDCixFa0UXl
         LqcSdy/IutRE0pTole6TH+YtlnlF67kIKcvkId0x8u4jX5rCZbqu6cOjpAviv7yLuA1h
         cMoA==
X-Forwarded-Encrypted: i=1; AJvYcCULA2/Cf3SAuwuIL/i/Dwoi0PC90PukdwNoouhkR5f3y0LB+ktwgVh+KE8cRztdfoEfBU/KhlxYJxX4OiYa@vger.kernel.org
X-Gm-Message-State: AOJu0YwSNyJ5uSY9UxuFfiHuxImlB3oxcfkfsVbrxU4s/QO4XjLaqtN9
	c7kSdNX/pboH1PDNazjfuMF7M8Kw42CFtZ57M4OKoX9EHG+MsWTgfxILav+HAfs=
X-Gm-Gg: ASbGncsas9pDjgDX5+M5/UuznS4hIJNV/04uUOQJXj0RwsxoBZwdepnKgiAw+KrigtD
	DuUDm6to3VfGvXzB0Xo4YHj3XsZZO58SPW/jCexsijboG7GXXFN/TwN58hOs3U94XMtx83i+JYx
	iwnDagucAj3K+MQc0uq+AZvkljdX2LjrMfSXCXgLNIqUOZ6SgyPcuNCCkvRyRrZAIiUtkYF+PYv
	Q1E7iqmmdgWvQwxBaXcDXg8LqMSQlP9g4GyryPxEnkPb5GVrQccmYL7iJibGDHLxxI01NuoXSot
	gb3Cvf2qqkGhyDNrHKFH+Zh4dvkDvzWH3Zm18qjyXriph0vIwf4YS+9Owlp+0JKOSqSSYrGFNcH
	Crghl
X-Google-Smtp-Source: AGHT+IHQLBHBcxn45pDMJ6mBe7Q5GjHdSOzikTUHc7bZFFqM3IvCF49MKGgOPWFCY1ifjxDw5fxebw==
X-Received: by 2002:a05:600c:3552:b0:439:9a40:aa1a with SMTP id 5b1f17b1804b1-43d5170c622mr550105e9.6.1742506555439;
        Thu, 20 Mar 2025 14:35:55 -0700 (PDT)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef16csm605211f8f.86.2025.03.20.14.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 14:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Mar 2025 22:35:52 +0100
Message-Id: <D8LF0RDZ6809.1I3MCCVSHRSQ2@ventanamicro.com>
Subject: Re: [PATCH v12 23/28] riscv: kernel command line option to opt out
 of user cfi
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Deepak Gupta" <debug@rivosinc.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov"
 <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Conor Dooley" <conor@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Arnd Bergmann"
 <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>, "Eric Biederman"
 <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann Horn"
 <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-23-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-23-e51202b53138@rivosinc.com>

2025-03-14T14:39:42-07:00, Deepak Gupta <debug@rivosinc.com>:
> This commit adds a kernel command line option using which user cfi can be
> disabled.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/kernel/usercfi.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> index d31d89618763..813162ce4f15 100644
> --- a/arch/riscv/kernel/usercfi.c
> +++ b/arch/riscv/kernel/usercfi.c
> @@ -17,6 +17,8 @@
>  #include <asm/csr.h>
>  #include <asm/usercfi.h>
> =20
> +bool disable_riscv_usercfi;
> +
>  #define SHSTK_ENTRY_SIZE sizeof(void *)
> =20
>  bool is_shstk_enabled(struct task_struct *task)
> @@ -396,6 +398,9 @@ int arch_set_shadow_stack_status(struct task_struct *=
t, unsigned long status)
>  	unsigned long size =3D 0, addr =3D 0;
>  	bool enable_shstk =3D false;
> =20
> +	if (disable_riscv_usercfi)
> +		return 0;
> +
>  	if (!cpu_supports_shadow_stack())
>  		return -EINVAL;
> =20
> @@ -475,6 +480,9 @@ int arch_set_indir_br_lp_status(struct task_struct *t=
, unsigned long status)
>  {
>  	bool enable_indir_lp =3D false;
> =20
> +	if (disable_riscv_usercfi)
> +		return 0;
> +
>  	if (!cpu_supports_indirect_br_lp_instr())
>  		return -EINVAL;
> =20
> @@ -507,3 +515,16 @@ int arch_lock_indir_br_lp_status(struct task_struct =
*task,
> =20
>  	return 0;
>  }
> +
> +static int __init setup_global_riscv_enable(char *str)
> +{
> +	if (strcmp(str, "true") =3D=3D 0)
> +		disable_riscv_usercfi =3D true;
> +
> +	pr_info("Setting riscv usercfi to be %s\n",
> +		(disable_riscv_usercfi ? "disabled" : "enabled"));
> +
> +	return 1;
> +}
> +
> +__setup("disable_riscv_usercfi=3D", setup_global_riscv_enable);

I'd prefer two command line options instead.

In any case, I think we still document params in kernel-parameters.txt.

