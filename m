Return-Path: <linux-fsdevel+bounces-48219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D4DAAC0F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 12:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C403B7BD90E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9A8278175;
	Tue,  6 May 2025 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="k3yezd4p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2CE2749FB
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526239; cv=none; b=U3XBZWc5zgdd79sLPAC+etUHqy2hF8JQFP5BOdv+1QC5HlAtrdA/aBvg1mHwC/4g2U1TJTLQusBzw+jGer6Xpl313XzelWninpXWED/zxLTzddGsgcVRtLo+2cCMzsJZ9osyfqsiUwG85j3ZGOI+5ZuJI6xFqZR9zVH9ilF4l2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526239; c=relaxed/simple;
	bh=/HBE0X80tekKwVpe/I6rSG6afei1xLRG1IopLTv4b90=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZSXmBJiRqLw6Hc2HMNX58oNn5pLFQj17Ets/ndKwKRuYyGyVZfuKx0EX5uQdfJWBsDozqdt+i+Zx1oOr4AY6I1GV91dOZHJx3GhuaBLQdjprTftuyX4HFjjt9fTPi/7s098oZKj8chQhC6eKN9y2ectZg1xLTBKYXcQj6hO/Fjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=k3yezd4p; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a0b28d9251so19826f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1746526235; x=1747131035; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDlCPukG676ZkXDqA7+irYPpUi8ypltoa/WLU7iYTZw=;
        b=k3yezd4pHOP993DCvnJYvnnrLQ1mQCRimlX6KF3OwLBGIjRxOc3HI5AcNZB8pZhuWj
         pzuW1eppoxocBCntG/gAypFjNT0c2K33klUSjcfO5TClCnm76dz3JLIX/z5ESFhaprPT
         nRwfLtrtLlpz8HVBl5tXVu+qSANl+Vudwd5La9yJ9av/tFmsKPxcvsVmai85Yg9S0G2j
         gBYB/Q3FrSGMB3QfoQs0HpjGJymi73TUlgOsy1VraKjWGcyD6teiRQxVunD8dpEx3FX4
         iAKFmr0MeOH735cMF502s277NyhW/SvQIBLSEPUkrR6JYMN+955NaiHnc5d/DcCc8Z9d
         C91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746526235; x=1747131035;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MDlCPukG676ZkXDqA7+irYPpUi8ypltoa/WLU7iYTZw=;
        b=Wg0BxP0Fo4rgWDuCe4nlyQl5atsY3mQBlWGLP7nJPw84SWJ0DzpMnuXiUHvdwnh0CN
         1QKgBLF2T+NJ3EGXgKczT/2EPGFE4pPZ6UrfdX9XV5qpbEiFOKxXJpK1PFH15SIGEnrl
         xw99L585RHNqxN8rh0KadqPqJ0Ktn/UftZPSZx9En1MrZai2RFocWSYKcliyD6j6Gn4P
         wRqQeT4tXq54UfZ9mOxACHv4ZJw/hFNf2tol+s1N9ChLOBvgdnvI73dsDpMY4DRemeBD
         y9nlzREL8z23PLts/554KVy8FLG0I10A/0DW86pZiOvzMQYcsCmdrV3rCpfQqRK/v7nU
         z4aA==
X-Forwarded-Encrypted: i=1; AJvYcCWEeKvjL5noa62lmIMws8sz1b1k6/QC9uatIhV2pwaPucLByhKl3Wm+MCVMzKvb7DK64/9N9l/qWdaQSSAK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35AyI3AHvrHaxD1Vr9llDlRt95WXe0RlroZlIiDxM3EBM4OE7
	ZsQlABGEuF18i6w2H4DyJCByAie+Rvs+e2pmn3kRwjRLyy+AnDzQujLiPdIGNYM=
X-Gm-Gg: ASbGncszOdcq+xhCZzNcm8c2C4mbVcPdWizjsumB9ggZRMxtW/sus6lXZ1k+j8NTUia
	IRXH4XCF9/UzYiJAlMV530pm3LLjAdyXPE3F0KRLmipsGVdDrHTyUYTs/a/ANJ0N1rD5o+wQBc+
	KcatIyBFQTVwJHI0WKJmMsfOSn9RTXodZbZpcAbuTxwpbywUXjFDzH5Wo2vjJxxa0RwdwJ/AANz
	S3RzBC3NefboMDExCjHI+wpCu9AhvZ3bPKCuS6HGRlS4il+Ar4dEVooEpxvXNKjAuvwFKyGjMto
	KbePFj+Z96rSYJEKTPHFiQVsFIyBPcZqQxPX6Q4DVfFtZqg+
X-Google-Smtp-Source: AGHT+IEUjKjGwlmMCjrKZvF7YuhMUsrs5D+dPoN1CPSaPd4oD3QBATAQzTQqUOqU1bgynoQlRYwsyA==
X-Received: by 2002:a05:6000:144a:b0:3a0:9f28:2e53 with SMTP id ffacd0b85a97d-3a09f282ec4mr3244079f8f.0.1746526235363;
        Tue, 06 May 2025 03:10:35 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:d5f0:7802:c94b:10f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc441sm166448565e9.3.2025.05.06.03.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 03:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 May 2025 12:10:34 +0200
Message-Id: <D9OZVNOGLU4T.2XOUPX27HN0W8@ventanamicro.com>
Subject: Re: [PATCH v15 05/27] riscv: usercfi state for task and
 save/restore of CSR_SSP on trap entry/exit
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>,
 <rust-for-linux@vger.kernel.org>, "Zong Li" <zong.li@sifive.com>,
 "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
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
 <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
 <20250502-v5_user_cfi_series-v15-5-914966471885@rivosinc.com>
In-Reply-To: <20250502-v5_user_cfi_series-v15-5-914966471885@rivosinc.com>

[Ah, I missed v13 and v14, feel free to Cc me on next versions.]

2025-05-02T16:30:36-07:00, Deepak Gupta <debug@rivosinc.com>:
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> @@ -91,6 +91,32 @@
> +.macro save_userssp tmp, status
> +	ALTERNATIVE("nops(4)",
> +		__stringify(				\
> +		andi \tmp, \status, SR_SPP;		\
> +		bnez \tmp, skip_ssp_save;		\
> +		csrrw \tmp, CSR_SSP, x0;		\
> +		REG_S \tmp, TASK_TI_USER_SSP(tp);	\
> +		skip_ssp_save:),
> +		0,
> +		RISCV_ISA_EXT_ZICFISS,
> +		CONFIG_RISCV_USER_CFI)
> +.endm
> +
> +.macro restore_userssp tmp
> +	ALTERNATIVE("nops(2)",
> +		__stringify(				\
> +		REG_L \tmp, TASK_TI_USER_SSP(tp);	\
> +		csrw CSR_SSP, \tmp),
> +		0,
> +		RISCV_ISA_EXT_ZICFISS,
> +		CONFIG_RISCV_USER_CFI)
> +.endm

Do we need to emit the nops when CONFIG_RISCV_USER_CFI isn't selected?

(Why not put #ifdef CONFIG_RISCV_USER_CFI around the ALTERNATIVES?)

Thanks.

