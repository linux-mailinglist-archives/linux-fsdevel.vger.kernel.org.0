Return-Path: <linux-fsdevel+bounces-47148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 556B4A99D3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 02:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E911942ADD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 00:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427377111;
	Thu, 24 Apr 2025 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fjSpfiQ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D62FC23
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745455560; cv=none; b=DvlQU8R7MDr+IJvNQ8M7yvfEbEliNa4vQfy/AS7J/0bxP9vHnHc0AYp3usIlYhUoIbReKs5K0R09M6CCxqcREJZHlpN2ONarT7pw4rciXcVDIufuN1TFG8u9XLaXeXXfpK9YyS3jtXWdCqgvGJGj77t4Wyi1CaJ2eq8/5lTMHl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745455560; c=relaxed/simple;
	bh=Oe1WMqLBDyQWCK+DSdDYKohiPHkUJKKI27mpm+YppJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToqpMZsIEV1zbEI/162EQ74TTLJkLR7Pfhd5JPvvk7YjIr7O8HtwhRUAQpED+sJHLG8vGbJ73Eg0kF/Ufckn8uvDqV5EPRgrpIXG9V6FQ1a4Bz7r8VzI1btJvioxxBPqQ5iDZN1tuQ3ntBa/rrun2guP2Tik+vGhDKcB58C8AGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fjSpfiQ0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso333618b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 17:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745455557; x=1746060357; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CC8T5V5ETxB3aI46jMwjb5xUFdEfDSmv/WDvLTa/TKM=;
        b=fjSpfiQ0jb0rg/Iv97V6TVHy0ZixEk5tF/NG5IuJtd4x71GOt6/Zl0K5IjL4BEbLos
         7erQ19j1Vahx1AdqHbNPlfFK7zAvylLSYxMXWexB69NxhdptjkS+O2Zi7ucN/mbKfdbz
         GbTd2Vnog+pixLx4WnEeIE5mjqp/wvwdLYAMAz99gvtkAa0cSfOBj8xyx0tOCm2tdqgF
         mZquaBAqbgJBZAFT3wR7J3r9u9u630YvWTjil1DZXAhWqIwgaAhDc1QPUPhI5LuVN97j
         roPDGL2gcn0n+pCwutY4XrMWmmt+9TYT9YaJF27K9fPs2p3FVeir6qUi65x28uuOs18S
         SqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745455557; x=1746060357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CC8T5V5ETxB3aI46jMwjb5xUFdEfDSmv/WDvLTa/TKM=;
        b=mGFChVvGrXN25dR3PzkQVvr7Ae6RKAZc/lS+bSj6yUJ3x5ZQTiPxRoqd5d+lv0KXqG
         FpPRIYAIYwZ5vOk8QMqAL74t3v2kFtIYcJjTIWXdbRJDsJ+V4ttQgjB3woS49DMgHdAl
         JR+oCRF+7OR0Sjli+YyETn1D7bNqy/MtcWMzKHo8UOQftT8ZBK4EKKDljnJlUI//M0j3
         jaXk8/KDX7ghhqch9iGmxpUZFKqMppChErapgox0crTEO/VjpoNn561AFyG1+DT2zutw
         BZxXDlSataJ6M0n4QyXSKS9na8PpElAU6jGJM+TXkfBnyncpTJwtE4XnrAACfkOpotTB
         SWvg==
X-Forwarded-Encrypted: i=1; AJvYcCXjuBkY/A9+MHmqT2ETPcDQlWu+rutikEtk5aMwEUUigeHO83Pl5wVT4viI470ovY021KjuFnS8Ie9+wUDI@vger.kernel.org
X-Gm-Message-State: AOJu0YxWL9f1wtbuEFM2L9XXW7+XWoqA4npkbXV+vm1laf/xaWnO0P14
	w8DDL377iCkoiwAwpawGdiH2QRt9tjH0hy2yrHmBViwj8wpDoHTHeh4KrJ3h39M=
X-Gm-Gg: ASbGncs1SP3thIc3E0vzXj/vZ62l6w8/CpUDILrJKvIbd3xZyUMdLTvV+u5Xd3XPEId
	Hj8ANgFYQfZzme0rNQ0Vdv6WF12ym3qUYONA/nJf22itgWtW0Bb3iPLEM+1a+hzj70b6VyWeAFF
	hUfmBNzIqCfN1IfVHNxXt3aDTw4gBXJvHmpPg6Jng0nAK4AavWOFNsU+uqfk3UQQBJJYCsP7iE8
	GcktKLfHZHo+9EhXTLO/CVL4neKPpWWCN//S8ZOMOyPFVCwoSzO4C6ErbmN78jpJ4axihiuZqlu
	22hKiJuhIwIlrEsK0MQQ0X6PkHjdAvGKX1evDFBC4Vj4ZQqKkrM=
X-Google-Smtp-Source: AGHT+IFSRc4jFZIKl/995vivdy0v1krVWENkLmQTo2FqdjSK7VIBAtsfvTZB7Ln0D+cPb89ZAHZGNw==
X-Received: by 2002:a05:6a21:9984:b0:1f5:8f65:a6e6 with SMTP id adf61e73a8af0-20444f6b564mr805436637.27.1745455557578;
        Wed, 23 Apr 2025 17:45:57 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15fadec8c0sm113497a12.68.2025.04.23.17.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 17:45:57 -0700 (PDT)
Date: Wed, 23 Apr 2025 17:45:53 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
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
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v12 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ
 | VM_WRITE
Message-ID: <aAmJweehK4ntbVoO@debug.ba.rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-6-e51202b53138@rivosinc.com>
 <D92VG9GT3W5D.2B71FBI67EYJ6@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D92VG9GT3W5D.2B71FBI67EYJ6@ventanamicro.com>

On Thu, Apr 10, 2025 at 12:03:44PM +0200, Radim Krčmář wrote:
>2025-03-14T14:39:25-07:00, Deepak Gupta <debug@rivosinc.com>:
>> diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
>> +static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>> +						   unsigned long pkey __always_unused)
>> +{
>> +	unsigned long ret = 0;
>> +
>> +	/*
>> +	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
>> +	 * Only VM_WRITE means shadow stack.
>> +	 */
>
>This function also changes PROT_WX to VM_RWX, which is effectively not
>changing anything, but I think it deserves an explicit intent.
>(At least in the commit message.)

Will do that.

>
>> +	if (prot & PROT_WRITE)
>> +		ret = (VM_READ | VM_WRITE);
>> +	return ret;
>> +}
>> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
>> @@ -16,6 +17,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>> +	/*
>> +	 * If PROT_WRITE is specified then extend that to PROT_READ
>> +	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
>> +	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
>> +	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
>> +	 */
>> +	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
>> +		prot |= PROT_READ;
>
>Why isn't the previous hunk be enough?  (Or why don't we do just this?)
>
>riscv_sys_mmap() eventually calls arch_calc_vm_prot_bits(), so I'd
>rather fix each code path just once.

You're right. Above hunk (arch/riscv/include/asm/mman.h) alone should be enough.
I did this change in `sys_riscv.c` out of caution. If it feels like un-necessary,
I'll remove it. No hard feelings either way.

>
>Thanks.

