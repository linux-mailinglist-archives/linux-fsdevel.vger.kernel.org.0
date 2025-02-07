Return-Path: <linux-fsdevel+bounces-41273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14338A2D198
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 00:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2714F3ACCC7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 23:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD93B1DC9A8;
	Fri,  7 Feb 2025 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IjycdCkM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D82198E92
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971874; cv=none; b=SBHIHCJW0Vbhn3pYDYG+VFYVZcemEki8oLv3cJ95czezLWCbttzRV9f4InEtSDs73qZjvw+zGF0CMSUyQqzqzGryRY/0olyv0Kjp0GPu8oxewb69RHBzM9rcMlqCK84rJEISX6q0kGEzC1FirQWC9ELVRZFe3vkUslnkIEjKLyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971874; c=relaxed/simple;
	bh=OV/hDOXoEY3RmBaaBXVJAqarimoMv+Fe1fAMJGktYVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq1eEjgackc1DeIeFROU9rxsAl/Xn+tVHyA103d1yPuNzuW/yqBUEI/8sMlvg+fVqbCrAJK0Q9dn5/GY9uFhe740kS527Km7byemnortFjnTq0BoTOiebVbgVBFzSt642cqr3+CTn+EAcxorLqSsl+bIRInAEGarQrk22unwYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IjycdCkM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso4233997a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 15:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738971871; x=1739576671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sFQiCNrm30AFPGwQY6ts0jjT1ZeITQwhTZXh/92SdFM=;
        b=IjycdCkMxe6NfxYLAUVF/dGww4zeQhOE0GDVA/Ywk0p6EWl/iBFz+YZR+ecx/4mjBo
         O6QBK6kkPc8QMSiuOlcY0LJvedvrwPgoozln14XLSVxdqPhdE+ek8Wm2mE+PBXP2bOim
         lROjhOXiK8i3e/Q1i++JAUK/5qyOMEFUwHKulzrzlDf2bxUPbxcRs2rRjdj0+K/gYLug
         4Np5mGYCtk+aqRlMAk6+Q0T0iHMV1S8pOLwKXem/FvYS5BtDo+q7o8CyQ4n9ba1nR8cc
         p7qp/uIfdptzbrMPcouDb5f01x1AiRve2ZX1eQqSz1GKTjZEqK9f+hwrw9vAAVgVCHxY
         F4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738971871; x=1739576671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFQiCNrm30AFPGwQY6ts0jjT1ZeITQwhTZXh/92SdFM=;
        b=H1JhTvHFjb+QjA6Xz0qkbto+3Mz1Jl3EL+sowfwtkK1LIvHUnO/mxGHOu6D13yBnYd
         iX4GWJA5qMvmkRTHNKaKlbaeU8RQ5bwsDBaRyKKTbUKKPuxmE0K5MJF/Fbp7rItCY/z+
         mpKYlnLCGlLd+UIY9o0uf6OiHgId5l7sLFYuZFuQJsswk8qYCLQD99vHOVnb4Dw8VQ9H
         Krhjla2Y8Z1zFtBK49jkN3TsqQZbMaZsQt4Nc2YE//sQ04LempDb8PmP5pyFKU8UrsBw
         cNfyaNGc4vliF0Ow497Dhku72CCgNopTWVp5J+t7q6e0RoiVX2qjZ26+Cl02bFy+V4e0
         pzXg==
X-Forwarded-Encrypted: i=1; AJvYcCVgULk4RY+ES2yBtB5B9XotsZU4o0dg6oC15azGaZV3YLkB+rqZrjoN10oi8EJfFUFb9gxwFi/KCYpdQR4C@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDUMQUOn2Zx8kj/RerZ+TBb/VU0J/U5ZeLawD3MN1+9joXYjx
	w0AF6LD2Hl4zMUrLxJUdeADV0mv6zdPDcT0QMXZV6OJUaQAuZZ2l9wEzPZcjIms=
X-Gm-Gg: ASbGncsx9BCY1Ilr5G9ckrJOZT6tNurrpG0iDOIjw9MOnDGzKXV6y3MAhF6Po00Yv/a
	bYs+we5w5IIdIV4ByWtOBukwl/Z7ldxr3XDEDE6mb4lLFZOnmT5AvSC96YkoamD2KyyWoTkit94
	DAk6SS0/W2rvJBQUeQdWiGQDVJp6UhM5bGGyDgiIY2SSPdbcyjzqCoFOvwR7CaCw2iZhvWEItYB
	WiTItLyTaj7RTK79X9+bxeoiSevu/7npFMmMZtIlVSuLzhRZtY9gb0/9g8RAHyfhcVUme3Bl37l
	mquA5twQK9hGvtAULNOKwWB97g==
X-Google-Smtp-Source: AGHT+IEu/BmgD+AgLAp2nKonkfG6/YX8d0cZZKASE/tVvqPiMWzUevWv2BoO4p6W9X0pvQWJ2zpYLw==
X-Received: by 2002:a17:90b:380e:b0:2fa:2133:bc87 with SMTP id 98e67ed59e1d1-2fa2133bf2amr8657814a91.6.1738971870845;
        Fri, 07 Feb 2025 15:44:30 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687d169sm36049505ad.202.2025.02.07.15.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 15:44:30 -0800 (PST)
Date: Fri, 7 Feb 2025 15:44:27 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH v9 01/26] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Message-ID: <Z6aa24/5M5Xdhe/A@debug.ba.rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
 <20250204-v5_user_cfi_series-v9-1-b37a49c5205c@rivosinc.com>
 <6543c6b6-da86-4c10-9b8c-e5fe6f6f7da9@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6543c6b6-da86-4c10-9b8c-e5fe6f6f7da9@suse.cz>

On Fri, Feb 07, 2025 at 10:27:10AM +0100, Vlastimil Babka wrote:
>On 2/5/25 02:21, Deepak Gupta wrote:
>> VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
>
>I see that arm GCS uses VM_HIGH_ARCH_6.
>
>> VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
>
>And RISC-V doesn't define it at all, not even in this patchset, or did I
>miss it somewhere?
>

hmm...
Something wrong in my workflow and rebasing.
Thanks for catching this.

>> stack). In case architecture doesn't implement shadow stack, it's VM_NONE
>> Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
>> or not.
>
>This looks like an unfinished sentence. As if it was to continue with "...
>will allow us to ..." what?
>
>I'm not against a helper but this changelog is rather confusing and also
>code in arch/x86 and arch/arm64 isn't converted to the helper but testing
>VM_SHADOW_STACK still.
>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> ---
>>  mm/gup.c  |  2 +-
>>  mm/mmap.c |  2 +-
>>  mm/vma.h  | 10 +++++++---
>>  3 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 3883b307780e..8c64f3ff34ab 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -1291,7 +1291,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>>  		    !writable_file_mapping_allowed(vma, gup_flags))
>>  			return -EFAULT;
>>
>> -		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
>> +		if (!(vm_flags & VM_WRITE) || is_shadow_stack_vma(vm_flags)) {
>>  			if (!(gup_flags & FOLL_FORCE))
>>  				return -EFAULT;
>>  			/*
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index cda01071c7b1..7b6be4eec35d 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -648,7 +648,7 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
>>   */
>>  static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
>>  {
>> -	if (vm_flags & VM_SHADOW_STACK)
>> +	if (is_shadow_stack_vma(vm_flags))
>>  		return PAGE_SIZE;
>>
>>  	return 0;
>> diff --git a/mm/vma.h b/mm/vma.h
>> index a2e8710b8c47..47482a25f5c3 100644
>> --- a/mm/vma.h
>> +++ b/mm/vma.h
>> @@ -278,7 +278,7 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
>>  }
>>
>>  /*
>> - * These three helpers classifies VMAs for virtual memory accounting.
>> + * These four helpers classifies VMAs for virtual memory accounting.
>>   */
>>
>>  /*
>> @@ -289,6 +289,11 @@ static inline bool is_exec_mapping(vm_flags_t flags)
>>  	return (flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC;
>>  }
>>
>> +static inline bool is_shadow_stack_vma(vm_flags_t vm_flags)
>> +{
>> +	return !!(vm_flags & VM_SHADOW_STACK);
>> +}
>> +
>>  /*
>>   * Stack area (including shadow stacks)
>>   *
>> @@ -297,7 +302,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
>>   */
>>  static inline bool is_stack_mapping(vm_flags_t flags)
>>  {
>> -	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
>> +	return ((flags & VM_STACK) == VM_STACK) || is_shadow_stack_vma(flags);
>>  }
>>
>>  /*
>> @@ -308,7 +313,6 @@ static inline bool is_data_mapping(vm_flags_t flags)
>>  	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
>>  }
>>
>> -
>>  static inline void vma_iter_config(struct vma_iterator *vmi,
>>  		unsigned long index, unsigned long last)
>>  {
>>
>

