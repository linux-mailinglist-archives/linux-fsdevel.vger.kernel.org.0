Return-Path: <linux-fsdevel+bounces-49280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5724EAB9FF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 17:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3162165F99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 15:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03071C84A1;
	Fri, 16 May 2025 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aNHk+Il8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB41B87EB
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409672; cv=none; b=YxwTLkrEc4238LKxMBzpSVTKeUGKEXkS4cDNlEnKB3GXz4z7VrR3XsT0hML2dAxdFzbnqPjyxxpO6hV5IN3BpXtbVcu/0RYSGSIvZZX3h+tOd8tvGMw2NLV2N6UgZyWUu7LBd7hT+GPMl49CyN+oX0fySFB2BH/VeWgdvpV9OQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409672; c=relaxed/simple;
	bh=s7M35uwjD+aYg6o9dTgcW1bTJu8deexw+cwFb2Q66d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIR52hyzPXRxVs05gf/Ym36uB6ckcxIWcF0xsnhOKAmt5HA5B6OYkTvn/c5CV93n3x9aG0myzBeWW25NG1ZajxOmcuG9CC5qJulqRO2LUHFpvw2OjAIq95tDQyfjH/ZS6yPmu7AT3zkZvseKFxf83/w73nCnH45O79wocJSlZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aNHk+Il8; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b0b2d1f2845so1673001a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 08:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747409669; x=1748014469; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VTPOMqT5C2feU2knCk6fA/APYFa11AZmawpB2cqaoDc=;
        b=aNHk+Il8tY3wKlYMt8MKNZwFti/luK9M6uD2PQ9xQyLCJ7vcDjw+Wm7wBS2XdpfWpx
         KoKTdTtSvvxRzxBne9UFxCgPm/Iy49WKNu5yLRr0R3MJKgV75/6SmCD6a6E1AMcwpswu
         etbcgE59S7n6ZSjhDUCiZbdLQOYRPse4bgKHsAfDLRrmOzlLTSlgtzsS7/ckO2yiYzB5
         g2adbQQxOrSxb9ZFDXSNYbYeKjMQGP3ta60NYFjtxLTRW3qg/fVMeFT7nfEv8JJn0hUQ
         coACE1nXsn/3uSg1AtNGtRpja+tGJeajxJ0IApyD2tUvF6kZ7h7BRTqBWIKs704bpsI7
         HhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747409669; x=1748014469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTPOMqT5C2feU2knCk6fA/APYFa11AZmawpB2cqaoDc=;
        b=vMoKLRjmgyE+L46rM9Cvc7pc1Q1XJW9JX4VnPvksv1+GEdiY1Y93SjYjzRd+kM5PM4
         j8QwlnImw6AxOrustmrWEYDUj2xApQ3mvGwwuG00Eun45IOW2mlaQAaFjU2bcseeVajn
         odn2/OBrgF4Jm0pk58FPhpt4vjzetVXeBD18gaqDgMNxpM2YLbnQbHCDlInngskFkeNJ
         heRxbnjr+kREeZKgWTv40G8zZG+5/EHxwQ9rJ2FcOAb4Dajlbje/UCsSCLU7B7BQI/f7
         MvOLmK8p9PLpzVQ2RlX4Jt+phZgm8GKgr30Do9KbDvVsxg8IXnn8XVIes7BUrxm1Wx2U
         yIkw==
X-Forwarded-Encrypted: i=1; AJvYcCV18peWdvBhnGmgwQs87yW3UcRxhXjuD38YMe0N5cjh8bETiTlSu0kNGWSW7JJP15yJzs+khlKVttiPaOgF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xZxIcDo3eECuECSd90deRWlFANhIdqxnz83raxkvrOL9BbAh
	O8Ly1PWgTd7A68iB0MJfTi5yMBjmh/HhbUwvDpT4yvtw9CuRy/WUxoQsjY/0aQFEMS4=
X-Gm-Gg: ASbGncvZX4fvp41oWsLAJ8yDCy/HBhvbVEi0VNLuzzE10CRxshN9pr5O5GAWUyWe7dD
	sFSW4rStiQgYPRDZt5ijbRQu57AfKQpB/QD10B1n7SNi3uOBc8sqH5fibyxVcGenuET1JA0+EBc
	GQLKtg9OipeazyMDIHqC3/s5A8BXId9QedmD1cy9vWnORAGKs1R+m5UpgcHkZQPJORT6GBsUHBT
	UMbrTCpBfV++a3G1GdJuR/ZUTSKL6u8lJA6qNKrRbNMFHlS6RKlWHPS2aLRJ+Tj4AHghFZcfysG
	7QguMXMnul17vnpwhraGwSjE1VAPZGMYbDNjJy5SX/WazXgHxMiN0CKYMRbJTQ==
X-Google-Smtp-Source: AGHT+IFZckSqO5+1mOJ5q3W7tqhvvuTMvoIraIWCKDFfhzREKyJxJcIAzKyffAUquxEcLFZdJvL5nQ==
X-Received: by 2002:a17:902:f60a:b0:22e:17ee:aa69 with SMTP id d9443c01a7336-231d45740d0mr41158275ad.50.1747409669319;
        Fri, 16 May 2025 08:34:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac944esm15870145ad.49.2025.05.16.08.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 08:34:28 -0700 (PDT)
Date: Fri, 16 May 2025 08:34:25 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Zong Li <zong.li@sifive.com>,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v15 05/27] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
Message-ID: <aCdbASlCyqhid82c@debug.ba.rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
 <20250502-v5_user_cfi_series-v15-5-914966471885@rivosinc.com>
 <D9OZVNOGLU4T.2XOUPX27HN0W8@ventanamicro.com>
 <122fc6cd-2e21-4fca-979d-bcf558107b81@ghiti.fr>
 <D9WLRSAB63M5.3DZD4ND3WVZ6F@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9WLRSAB63M5.3DZD4ND3WVZ6F@ventanamicro.com>

On Thu, May 15, 2025 at 10:48:35AM +0200, Radim Krčmář wrote:
>2025-05-15T09:28:25+02:00, Alexandre Ghiti <alex@ghiti.fr>:
>> On 06/05/2025 12:10, Radim Krčmář wrote:
>>> 2025-05-02T16:30:36-07:00, Deepak Gupta <debug@rivosinc.com>:
>>>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>>>> @@ -91,6 +91,32 @@
>>>> +.macro restore_userssp tmp
>>>> +	ALTERNATIVE("nops(2)",
>>>> +		__stringify(				\
>>>> +		REG_L \tmp, TASK_TI_USER_SSP(tp);	\
>>>> +		csrw CSR_SSP, \tmp),
>>>> +		0,
>>>> +		RISCV_ISA_EXT_ZICFISS,
>>>> +		CONFIG_RISCV_USER_CFI)
>>>> +.endm
>>> Do we need to emit the nops when CONFIG_RISCV_USER_CFI isn't selected?
>>>
>>> (Why not put #ifdef CONFIG_RISCV_USER_CFI around the ALTERNATIVES?)
>>
>> The alternatives are used to create a generic kernel that contains the
>> code for a large number of extensions and only enable it at runtime
>> depending on the platform capabilities. This way distros can ship a
>> single kernel that works on all platforms.
>
>Yup, and if a kernel is compiled without CONFIG_RISCV_USER_CFI, the nops
>will only enlarge the binary and potentially slow down execution.
>In other words, why we don't do something like this
>
> (!CONFIG_RISCV_USER_CFI ? "" :
>   (RISCV_ISA_EXT_ZICFISS ? __stringify(...) : "nops(x)"))
>
>instead of the current
>
> (CONFIG_RISCV_USER_CFI &&
>    RISCV_ISA_EXT_ZICFISS ? __stringify(...) : "nops(x)")
>
>It could be a new preprocessor macro in case we wanted to make it nice,
>but it's probably not a common case, so an ifdef could work as well.
>
>Do we just generally not care about such minor optimizations?

On its own just for this series, I am not sure if I would call it even a
minor optimization.

But sure, it may (or may not) have noticeable effect if someone were
to go around and muck with ALTERNATIVES macro and emit `old_c` only
if config were selected. That should be a patch set on its own with
data providing benefits from it.

>
>(If we wanted to go an extra mile, we could also keep the nops when both
> CONFIG_RISCV_USER_CFI and RISCV_ISA_EXT_ZICFISS are present, but
> command line riscv_nousercfi disabled backward cfi.)
>
>Thanks.

