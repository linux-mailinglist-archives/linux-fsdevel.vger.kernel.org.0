Return-Path: <linux-fsdevel+bounces-49403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5B9ABBE16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 14:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589F63BA93B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 12:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DC2279334;
	Mon, 19 May 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="c0asuxeh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9598D27467F
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658353; cv=none; b=idX6StqpU1wEZ324LhwlphnQM66mpEKRq5fELCOAQUkiLrylapmmMBuC3jO8E2anuazjxWWYvW8i46jNFnIQREYxOFPkpIyFXzJvBRmXwItA81+kkYg8SR2dmD1C5/cx7gsEJc9btk4N2Z5miuiCoZSyhCH235SyZwFyuogJiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658353; c=relaxed/simple;
	bh=wAgE1d1Nn9Gs3icpp4n2PghbKllsJSUIZKEeigydyr0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=bRklg4CJ8c+juI9HlUOYxBfD5/+fnM6CRO6/6IsfLIZT7v2W1MbBuuzCcSlubSdSj5ITxvn87RL6W+UEX1DmlDo33o87tfEO/3AN/josG//8eLcAG/XhYgHvAQYTsg1rwGyIalvbkDY6Y+xjSo+J0heXE7rOgufc3p25QmccE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=c0asuxeh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d4ff56136so3475565e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 05:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1747658350; x=1748263150; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TID/8Or9YAzKWADzCmDKYmYbQ3PtBl4rxavpksxXcw=;
        b=c0asuxeh9zKDI4BFM+0+N/0QABL/hv9jgthEHTsCykJZ49PXAo5NS4AbsKwWngXmAP
         XUSqAurvr+cBeuW9/QQotGhmFmgPGhn+d6Ja/1dA8PBwkUcBy8CC2B6VeGNshgTdK6Pw
         tcaZU8hVqAxZaK4Ca5Nih6cf3qFBrNvw0fSbId0IPZZxi//uKN5+xqRuG2TtIfzxzYun
         F2Pv86q84JNAlfLHK2+scX0atyD/IwnGhwqe9AlZlqwfGNiW3jScfqEuzgkvlPIvlu9s
         LafrHDMlIQymbeapTyTmKUweUd38786lwxgaaJWyenB/0Z+5jDAYxkMK3BAs9NMI+z21
         2hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747658350; x=1748263150;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8TID/8Or9YAzKWADzCmDKYmYbQ3PtBl4rxavpksxXcw=;
        b=KsWH0wH0KDDaxMmF4+n0kzQjEMOv8OaAEKoTmAK7n5lZH5qBzyAwIPPrlKDwJZy/3D
         CR/cxxYrXISu76SDdadOcHwZu039+80XoACb8FVaKRMJBCIOvvjpwSO6t9idvb7DVT57
         8HgNEl0xC98lH8FshB2P/KuEbFTZQrFrB5jUayfyBEaF2UWbwhA/qrbYWWgJzu7wb6h4
         ye+yulOJzKYXyzq3hJjdJQ9ik03YSlXtD9MbVZftZc2BV2F+R8pQOoTudEg9HUEaa63k
         1hpen600+JCPALOVwZh983eBfWlPf5hvuVIFhHrAJJ1bvPNJ4GgP44VSYMXuMgDa0Fk+
         PiTA==
X-Forwarded-Encrypted: i=1; AJvYcCVSqzFz0W3ZWLGQp27lqqg6TTYD9CxqCRfjOoEP8e4r8ZhshGcPe4lqJx7qbOnMgdN8MNE7CDxji/F3f97C@vger.kernel.org
X-Gm-Message-State: AOJu0YyhMbjijiPOzvVKprbCZoryTOfj3cNjav0IurYXfrK7kpCBDxgk
	9NQglyc3KVk8BMhOwXXYfO4Xb7K4xGqujhpWoV0xRv7nwPQtbm9ezNcT7rU1osw8in8=
X-Gm-Gg: ASbGncvECo6TfRO0uoD/imlHO9wCRAuYbzwuQCWUAY/YYTSpRTY17QHAajYO+9se5rF
	On3Dg9ydbNw5PLOe3QHx2xAd0y/hm63t4wpF5EqjEdoh2JgoE3uqW+71ugNlcpuFaYdcqmFIOSo
	I9Y5c8KO3qn1iPfGUme8iG/GVyzZvHN/aGOWVt0V3MsS64dGih/Igw7MRU83Y77gEBbvETzGmoa
	wQascj9yKKiJXNKucMgpTwha5UJNWpq6GjdQIdZ0kR2AlLhIC2g8mu9f0yjYKjjrIULSI8CHtgO
	18y6Bj8jXnDUHSJHRlplQCuKgrslw0vWA0DhrtaXt64zPLpWk33zNR5FuKw=
X-Google-Smtp-Source: AGHT+IFfWi9oi0Jcra9sXbpqrxyg3hOkHnBuCeesfYKMaPVxn3iQR7mctJDpcqzl/F4hYBE/NRWxrg==
X-Received: by 2002:a05:600d:108:10b0:43b:c0fa:f9bf with SMTP id 5b1f17b1804b1-442fd7165b7mr23100365e9.3.1747658349729;
        Mon, 19 May 2025 05:39:09 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:29b7:4911:a29c:2135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd583f20sm136362615e9.28.2025.05.19.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 05:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 14:39:08 +0200
Message-Id: <DA056HQ5G6S6.2B1OITOT8LLWS@ventanamicro.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH v15 05/27] riscv: usercfi state for task and
 save/restore of CSR_SSP on trap entry/exit
Cc: "Alexandre Ghiti" <alex@ghiti.fr>, "Thomas Gleixner"
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
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
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
To: "Deepak Gupta" <debug@rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
 <20250502-v5_user_cfi_series-v15-5-914966471885@rivosinc.com>
 <D9OZVNOGLU4T.2XOUPX27HN0W8@ventanamicro.com>
 <122fc6cd-2e21-4fca-979d-bcf558107b81@ghiti.fr>
 <D9WLRSAB63M5.3DZD4ND3WVZ6F@ventanamicro.com>
 <aCdbASlCyqhid82c@debug.ba.rivosinc.com>
In-Reply-To: <aCdbASlCyqhid82c@debug.ba.rivosinc.com>

2025-05-16T08:34:25-07:00, Deepak Gupta <debug@rivosinc.com>:
> On Thu, May 15, 2025 at 10:48:35AM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
>>2025-05-15T09:28:25+02:00, Alexandre Ghiti <alex@ghiti.fr>:
>>> On 06/05/2025 12:10, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
>>>> 2025-05-02T16:30:36-07:00, Deepak Gupta <debug@rivosinc.com>:
>>>>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>>>>> @@ -91,6 +91,32 @@
>>>>> +.macro restore_userssp tmp
>>>>> +	ALTERNATIVE("nops(2)",
>>>>> +		__stringify(				\
>>>>> +		REG_L \tmp, TASK_TI_USER_SSP(tp);	\
>>>>> +		csrw CSR_SSP, \tmp),
>>>>> +		0,
>>>>> +		RISCV_ISA_EXT_ZICFISS,
>>>>> +		CONFIG_RISCV_USER_CFI)
>>>>> +.endm
>>>> Do we need to emit the nops when CONFIG_RISCV_USER_CFI isn't selected?
>>>>
>>>> (Why not put #ifdef CONFIG_RISCV_USER_CFI around the ALTERNATIVES?)
>>>
>>> The alternatives are used to create a generic kernel that contains the
>>> code for a large number of extensions and only enable it at runtime
>>> depending on the platform capabilities. This way distros can ship a
>>> single kernel that works on all platforms.
>>
>>Yup, and if a kernel is compiled without CONFIG_RISCV_USER_CFI, the nops
>>will only enlarge the binary and potentially slow down execution.
>>In other words, why we don't do something like this
>>
>> (!CONFIG_RISCV_USER_CFI ? "" :
>>   (RISCV_ISA_EXT_ZICFISS ? __stringify(...) : "nops(x)"))
>>
>>instead of the current
>>
>> (CONFIG_RISCV_USER_CFI &&
>>    RISCV_ISA_EXT_ZICFISS ? __stringify(...) : "nops(x)")
>>
>>It could be a new preprocessor macro in case we wanted to make it nice,
>>but it's probably not a common case, so an ifdef could work as well.
>>
>>Do we just generally not care about such minor optimizations?
>
> On its own just for this series, I am not sure if I would call it even a
> minor optimization.

This patch uses ifdef in thread_info, but not here.

Both places minimize the runtime impact on kernels that don't have
CONFIG_RISCV_USER_CFI, so I would like to understand the reasoning
behind the decision to include one and not the other.

> But sure, it may (or may not) have noticeable effect if someone were
> to go around and muck with ALTERNATIVES macro and emit `old_c` only
> if config were selected. That should be a patch set on its own with
> data providing benefits from it.

The difference is small and each build and implementation can behave
differently, so code analysis seems the most appropriate tool here.
We must still do a lot of subjective guesswork, because it is hard to
predict the future development.

We should be moving on the pareto front and there are 3 roughly
optimization parameters in this case: the C code, the binary code, and
the work done by the programmer.
The current patch is forgoing the binary quality (nops are strictly
worse).
The ifdef and the macro solutions prefer binary quality, and then differ
if they consider work minimization (ifdef) or nice C (macro).

Does the current patch represent the ideal compromise?
(I can just recalibrate my values for future reviews...)

Thanks.

