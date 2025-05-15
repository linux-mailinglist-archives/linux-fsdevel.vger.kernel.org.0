Return-Path: <linux-fsdevel+bounces-49096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B71AB7ECD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 09:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF883173B68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 07:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBAB281537;
	Thu, 15 May 2025 07:28:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AD71FDE1E;
	Thu, 15 May 2025 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294133; cv=none; b=b4Xes3SqPltlGbkrFg7OdSzN0ZQKxM0BRtPtIckF3Z+gGQ2x2WrRD7VR8kqjy+CoosFeJ3jF+HmAN29h/8T5OTpnQv9MI/dn6uD6e8u5qYdNQ0nK58ME22epng8LQqT2gR1MbrHI8T2kkL1/Ww5WA0SL/tVvbXmMGTNfmfPxi+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294133; c=relaxed/simple;
	bh=nglzcgSSePNXWyINmtN9UWa6zBcKeqo8R3tUcJJt4P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtRwi9fK1UhFjeislLwQk/yHbZMZ5K5BJhmLf0LUAhFNsrwkOOBJTjqp6UcsKagPriT/R5StadhgGesLtnYQ9iHFLp4wQgWkThLTFWdJz+VoJG5jFB8CFhm9zMUjuzl/AdzVTc0YXsbhIgGf/+UsBc1EH7i7zKXlt8yG9uNXKZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB84144380;
	Thu, 15 May 2025 07:28:26 +0000 (UTC)
Message-ID: <122fc6cd-2e21-4fca-979d-bcf558107b81@ghiti.fr>
Date: Thu, 15 May 2025 09:28:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 05/27] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
Content-Language: en-US
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
 Zong Li <zong.li@sifive.com>,
 linux-riscv <linux-riscv-bounces@lists.infradead.org>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
 <20250502-v5_user_cfi_series-v15-5-914966471885@rivosinc.com>
 <D9OZVNOGLU4T.2XOUPX27HN0W8@ventanamicro.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <D9OZVNOGLU4T.2XOUPX27HN0W8@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedvleeivdevgeekudefjeeigeeuvdekueeiuedufeethffhiedvleeileduuddtgfenucffohhmrghinhepvghnthhrhidrshgspdhinhhfrhgruggvrggurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemgegsjedumeegvggtieemjehfhegsmeejsgdtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemgegsjedumeegvggtieemjehfhegsmeejsgdtuddphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemgegsjedumeegvggtieemjehfhegsmeejsgdtudgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepiedupdhrtghpthhtoheprhhkrhgtmhgrrhesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtohepuggvsghughesrhhivhhoshhinhgtr
 dgtohhmpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Radim,

On 06/05/2025 12:10, Radim Krčmář wrote:
> [Ah, I missed v13 and v14, feel free to Cc me on next versions.]
>
> 2025-05-02T16:30:36-07:00, Deepak Gupta <debug@rivosinc.com>:
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> @@ -91,6 +91,32 @@
>> +.macro save_userssp tmp, status
>> +	ALTERNATIVE("nops(4)",
>> +		__stringify(				\
>> +		andi \tmp, \status, SR_SPP;		\
>> +		bnez \tmp, skip_ssp_save;		\
>> +		csrrw \tmp, CSR_SSP, x0;		\
>> +		REG_S \tmp, TASK_TI_USER_SSP(tp);	\
>> +		skip_ssp_save:),
>> +		0,
>> +		RISCV_ISA_EXT_ZICFISS,
>> +		CONFIG_RISCV_USER_CFI)
>> +.endm
>> +
>> +.macro restore_userssp tmp
>> +	ALTERNATIVE("nops(2)",
>> +		__stringify(				\
>> +		REG_L \tmp, TASK_TI_USER_SSP(tp);	\
>> +		csrw CSR_SSP, \tmp),
>> +		0,
>> +		RISCV_ISA_EXT_ZICFISS,
>> +		CONFIG_RISCV_USER_CFI)
>> +.endm
> Do we need to emit the nops when CONFIG_RISCV_USER_CFI isn't selected?
>
> (Why not put #ifdef CONFIG_RISCV_USER_CFI around the ALTERNATIVES?)


The alternatives are used to create a generic kernel that contains the 
code for a large number of extensions and only enable it at runtime 
depending on the platform capabilities. This way distros can ship a 
single kernel that works on all platforms.

Thanks for your reviews on this series,

Alex


>
> Thanks.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

