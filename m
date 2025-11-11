Return-Path: <linux-fsdevel+bounces-67978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D70ACC4F6B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 19:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B0564EFE4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 18:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E44377EBB;
	Tue, 11 Nov 2025 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="KaLA4ii9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5128468C
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762885336; cv=none; b=izOFifcU0AnhVoHG4pOelYvWAUb+ne+9wUBPys1olnT/Yf3IpNehTJiaf2cxiC85sDl3iNuJZU4Vudjpz7E2l0R1KCpDolz/BGy2GCJmLn3Wntf/N/4kRe9wVECfznQJ8GegN9xdOcLD41nf64izUw96hj+BFwR2mxpqmQ8s+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762885336; c=relaxed/simple;
	bh=W2G/uBc8ytqTj5lPN7H9z5TUaPH7eCAAuu2DNPk50z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cffQ0kqWdsYNNoIgHnpX1zJrepFU0l0+kJVak8rtLz4C+g81fu9j3qsJhQ/aNcVaB7oO9eNtoYm30/wKBYax6//w4dv55YFmHbpx0GB++1F/AYuNSUgl4V8iM51SAfi5v+CS4Vz9o9Ikiu4mvnWgDWQ799jQSH0y6mIHBS3a9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=KaLA4ii9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2957850c63bso383445ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 10:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762885333; x=1763490133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WIB2H6PdyJ1SkmEweEXB/zVmO+ijAnVaHWzNPmEF0uQ=;
        b=KaLA4ii9hvT/UXkj+xZDvJyu78py5JOc5gjS2oLOtr710zuHANUfrzy9e7KvrrYIYC
         LFf1ENhPDD1ICp9N8LpjTxCTIGirfG/pOHWRogylubhbW2HN2TrRcpaAyBwBdaEmaQGQ
         gRdxyrNZ6KrIzSMJILR8KidQ+NHpbgFCDtlIxzoS8qgMoKufz9p2hUyQHgr4CNixN3YP
         J7uti8jaBKfGx7HcdL1DSHO8oJ+FyOtagz2Q6nQKi9lovme94id2UfWRBMLOkRbPZ5Kq
         N1l9pKaiQT8smFWfb5sULGqNokcVEJ052gbsrQ5Ba4740Ym5/UyRa3dZN6HwKjbU+XW/
         bHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762885333; x=1763490133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIB2H6PdyJ1SkmEweEXB/zVmO+ijAnVaHWzNPmEF0uQ=;
        b=Qv/MYUWUfEiRa9/IW4y5n94daQGv9duZiK9/DSf9BQXvCs2MWwmTlZHlHVgh+z/xeE
         wTAaC53Epxx3CsAJwD+6bvXEzVaKj8iqF1vSP2rzdj9FfBjI5m6IPBNTJqLP7eKGgpc2
         lXPkub4fgjB5Qcuidzr7pd4X7yjfcStPkd306DVvYgXofVhCqucht67k7tPVvCckLWq2
         tCKl2CLwltsc/cp+C8AUEEw8fsUa+ntH1y1YsgVl5TSDmW/QJwBOPHzxeYoIh2vbsBlV
         EnRABhKmbsfpLJKq+vQkIOlc936F2wknzzQAydwFDYEaIInlkj96fgt8Hx9F/stY6gaj
         E16Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfw3K1Fm2Y/F+Dkf4yaozAtOMldRQlfY0SsP+xcuchYaUJHNap/dm6Pdu6HGnIedioRXz1XMOYxiHuqsv8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv47dvTS1SlhpU+xjIIJWqYxuS0ZV8WYf7hMwDw7gT6mVpLc+C
	JNlKv5ur/gkIsVhpcfVXK+80V1p3FhXsUtC3FJQCYK+XWx5QttBp25fr9O2WfG2ZFhw=
X-Gm-Gg: ASbGncvpBTMx1j1Td60yXsC25sNm/0I3RTsezQdmc55dvnBR3rGYnbtjTM+R9l0J2QA
	5dDOBwUlafIhlee1cyyluEWJ1zzKxuCOZL0MONuRzWK9rUhLoUaxafBQR7pFGCMN83NstumKwQF
	tGeFi6D851on9BBL9/00YU2ABcSm08cRmaK4Fy4Pj10bQpeCDexerWjXWacJOueZfNumjv0YCzx
	p3uonalqZBmojSO8cBT1xP+v6wg9ZvZlO2QuOOmMFxHepgswyzDBUc9uGhqhp6XbU5YGFlD17eC
	7/fL/sNHPjFgIFt58h/YDlS0KOcByZKQvwdOQ+6c+e5+/6zas02CChHX0fa6lcG1XaQkBN1CYhB
	6Tqxrp2BvE+0i+04E5340aWxJoDN80tX3wbHWL3uRJ2IYFCjga9WFKynrT1gzKFC5EpH8ylwlA2
	dPBcdfgjCvcA==
X-Google-Smtp-Source: AGHT+IHgsZ6GDRjZreNqZqXrg+8gWBFkhsOds9i8Gem5eMBAg33B4vZazV1IYc7GtJj2mgzKsVOwwA==
X-Received: by 2002:a17:902:d551:b0:282:2c52:508e with SMTP id d9443c01a7336-2984ed41a29mr3269885ad.8.1762885333020;
        Tue, 11 Nov 2025 10:22:13 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dc9fc2csm3813175ad.53.2025.11.11.10.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 10:22:12 -0800 (PST)
Date: Tue, 11 Nov 2025 10:22:09 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Zong Li <zong.li@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
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
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v22 25/28] riscv: create a config for shadow stack and
 landing pad instr support
Message-ID: <aRN-0Z9MNeJ9IZf2@debug.ba.rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com>
 <20251023-v5_user_cfi_series-v22-25-1935270f7636@rivosinc.com>
 <CANXhq0oEpCow0G+KsJ6ZPuwsxmAFVqoKGEzygiwSmxFsmntiWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0oEpCow0G+KsJ6ZPuwsxmAFVqoKGEzygiwSmxFsmntiWg@mail.gmail.com>

On Tue, Nov 11, 2025 at 01:58:37PM +0800, Zong Li wrote:
>On Fri, Oct 24, 2025 at 12:51 AM Deepak Gupta via B4 Relay
><devnull+debug.rivosinc.com@kernel.org> wrote:
>>
>> From: Deepak Gupta <debug@rivosinc.com>
>>
>> This patch creates a config for shadow stack support and landing pad instr
>> support. Shadow stack support and landing instr support can be enabled by
>> selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
>> up path to enumerate CPU support and if cpu support exists, kernel will
>> support cpu assisted user mode cfi.
>>
>> If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
>> `ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.
>>
>> Reviewed-by: Zong Li <zong.li@sifive.com>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/Kconfig                  | 22 ++++++++++++++++++++++
>>  arch/riscv/configs/hardening.config |  4 ++++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 0c6038dc5dfd..4f9f9358e6e3 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -1146,6 +1146,28 @@ config RANDOMIZE_BASE
>>
>>            If unsure, say N.
>>
>> +config RISCV_USER_CFI
>> +       def_bool y
>> +       bool "riscv userspace control flow integrity"
>> +       depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss) && \
>> +                           $(cc-option,-fcf-protection=full)
>
>Hi Deepak,
>I noticed that you added a $(cc-option,-fcf-protection=full) check in
>this version. I think this check will fail by a cc1 warning when using
>a newer toolchain, because -fcf-protection cannot be used alone, it
>must be specified together with the appropriate -march option.
>For example:
>  1. -fcf-protection=branch requires -march=..._zicfilp
>  2. -fcf-protection=return requires -march=..._zicfiss
>  3. -fcf-protection=full requires -march=..._zicfilp_zicfiss

toolchain that I have from June doesn't require -march=..._zicfilp_zicfiss
for -fcf-protection=full. If that has changed, I think this will need a
revision.

>
>
>> +       depends on RISCV_ALTERNATIVE
>> +       select RISCV_SBI
>> +       select ARCH_HAS_USER_SHADOW_STACK
>> +       select ARCH_USES_HIGH_VMA_FLAGS
>> +       select DYNAMIC_SIGFRAME
>> +       help
>> +         Provides CPU assisted control flow integrity to userspace tasks.
>> +         Control flow integrity is provided by implementing shadow stack for
>> +         backward edge and indirect branch tracking for forward edge in program.
>> +         Shadow stack protection is a hardware feature that detects function
>> +         return address corruption. This helps mitigate ROP attacks.
>> +         Indirect branch tracking enforces that all indirect branches must land
>> +         on a landing pad instruction else CPU will fault. This mitigates against
>> +         JOP / COP attacks. Applications must be enabled to use it, and old user-
>> +         space does not get protection "for free".
>> +         default y.
>> +
>>  endmenu # "Kernel features"
>>
>>  menu "Boot options"
>> diff --git a/arch/riscv/configs/hardening.config b/arch/riscv/configs/hardening.config
>> new file mode 100644
>> index 000000000000..089f4cee82f4
>> --- /dev/null
>> +++ b/arch/riscv/configs/hardening.config
>> @@ -0,0 +1,4 @@
>> +# RISCV specific kernel hardening options
>> +
>> +# Enable control flow integrity support for usermode.
>> +CONFIG_RISCV_USER_CFI=y
>>
>> --
>> 2.43.0
>>
>>

