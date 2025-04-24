Return-Path: <linux-fsdevel+bounces-47227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D79A9AD41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FB216FFE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1723027C;
	Thu, 24 Apr 2025 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mhvDkXpr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB86322F742
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497421; cv=none; b=CoT9lhSek5ti+slPVcRJIiEpq3qIr133MSWi4HjbgcqHDsCNp8R/PkTet+abu2PoGMptcLrqLnAsVkMOHiACtG4GU6uPQnS4ohgvrUztZjxpVD2V3xB8PA4IrqXN0zbzGDHPQv3AxLaDFJ4lmromAEniQGXKIEBAr3dRX9Mokd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497421; c=relaxed/simple;
	bh=mb4owV23IIKFPA0348nV5wGPHZz3gEvC8g/fsUHVCgA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=I6MVUxAtqMrsX+04yTQ7z1b1k4yl9Vb+m/+Qj1KzTC49ee7z4vxgj7TJWzDQrNGfzFbE+LbLQdxYYAb5JE4gPyy8NPQGrHvMiN2FyxPRRjUGOg9/uin9aRGGHgVRKJoiamWeg4c4r5IM98lKXQutbvF6vAhG9i0uV/9OvnzEClU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mhvDkXpr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-440668acbf3so1423165e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 05:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745497418; x=1746102218; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nffUUxHQRUxihyV+Es46LKx5IUoFWP6+nxUCQrf1fjs=;
        b=mhvDkXprQtheM2R2TQkjwyIwHPj/Flc53DbFs1ggfPvNPOtZUwTMqHejND99lMyASB
         fJ+W3zMl4kYtmyflhE1ioeLlZ6kaIY7kKgDir8C70ev2fNC0wK1H2EwP9socGF7QuLlg
         q7KmZ/sZk6bFZzhY4F7EbEpDDWV55SaAgKcC4UB54UnLjqEL4KCxIBDeCMywZAVwg0f2
         qS7wd/HTrDCoS/ZU9yL9RoJVeeH+X08FFKG2j8ErtQ69Oz2V/0+3d4QcaIJYLKQ+RXNs
         mzePApqiRMFNVnJ28teIBT+uUUkqv7p5hMMyLkS537fu3ufE4owY0a5pG2E6a4D4UKiq
         LL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745497418; x=1746102218;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nffUUxHQRUxihyV+Es46LKx5IUoFWP6+nxUCQrf1fjs=;
        b=PQiTcTd/1Brl1FNQ69IycVcbGvlYbyUqLEHw3xlOLZrut4AbUXL+JihV8dlqDAEWld
         AQBotJ+XgCl5Kul9hJ83suHbF978USskeQiP1z47gkO231o1k8FKNQ8+Z9XTA3DNrIi9
         BWV+v1sTGiB4rymsnIJ6KVXTpGNXbB7cRo4AcBcgPZOsvSdVveDzmxZtfhSR9MBNxf/V
         hyF3kOrXcdYw0EjEXE1UWYWg2kw0IPDXPU0llvL5Pt712iGz/NfZGQA6WUmqzSNdaV++
         TrKLKOSQFJuNasKNiKSCHnAQGmjAALgaKHP0ximZRLeMCbzgvmYVAcNm4syEfaBbXqpF
         cRpg==
X-Forwarded-Encrypted: i=1; AJvYcCWRB3Ir2cOYxrUFGIbvY2Uc0f1KDHZy/22CIjfvHiuqBPeJmxop1bjcwo1pk/yV7k4O3H1sMP1/HK4pyTP+@vger.kernel.org
X-Gm-Message-State: AOJu0YyWvdHH+1eQzDoIB70F4CyYxpg4ARYw54TWqFmRU/1OceqK/tnh
	/q+ZOrcHH3nsp8wN+c4GCJ7U3TqBx1JvZcQsC0NR/ZiKlRTBOSOn2A/pXDLvvJM=
X-Gm-Gg: ASbGncvqhmJNHx9EBwpyY9D1u41Gn51g/1xg3hzuUJA8GAr8P8k3xf6pPCUdPGjS1hJ
	iVQjuau0SDgXadhKtfpZrucbjbWvv0meT2OYJwGSukDQoiz+QY6KVfZGXMuj6Ak9t8d+KgCEVgN
	CwOVscVKkPXREWiepNuztwre+b8Yb1bHh2Lj1wrcJHHCI7yzH6dYv/VbBWrWM0IwO/wkA2a566x
	DSOrAUuD85cb4xFCWb4BW2QuYa/jS++hBeEh/Qiu1ThRBBTc2NCkb6UTzhENB3Hj1fKxFq1AVMC
	oJduY+dhX60tVSmuhaRboDHl6Igio0CsmYhjXWqhmSdjsX0HFDtL5Vg/uCU=
X-Google-Smtp-Source: AGHT+IFvpk8fVElfDmbD5bbQ4KBSF4oRicSe9nZGd6eQAPt/95H7RizUp5Ju8acqfaiZr/JLSD9aIA==
X-Received: by 2002:a05:600c:3516:b0:440:58d1:7ec3 with SMTP id 5b1f17b1804b1-4409bda5fadmr8020715e9.6.1745497417906;
        Thu, 24 Apr 2025 05:23:37 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:b30c:ee4d:9e10:6a46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d29bfc4sm20203525e9.8.2025.04.24.05.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Apr 2025 14:23:37 +0200
Message-Id: <D9EV6ZHETDM6.36DJZQTQ487O1@ventanamicro.com>
To: "Deepak Gupta" <debug@rivosinc.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH v12 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ
 | VM_WRITE
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Conor Dooley" <conor@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Eric Biederman" <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann
 Horn" <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "Zong Li"
 <zong.li@sifive.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-6-e51202b53138@rivosinc.com>
 <D92VG9GT3W5D.2B71FBI67EYJ6@ventanamicro.com>
 <aAmJweehK4ntbVoO@debug.ba.rivosinc.com>
In-Reply-To: <aAmJweehK4ntbVoO@debug.ba.rivosinc.com>

2025-04-23T17:45:53-07:00, Deepak Gupta <debug@rivosinc.com>:
> On Thu, Apr 10, 2025 at 12:03:44PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
>>2025-03-14T14:39:25-07:00, Deepak Gupta <debug@rivosinc.com>:
>>> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_risc=
v.c
>>> @@ -16,6 +17,15 @@ static long riscv_sys_mmap(unsigned long addr, unsig=
ned long len,
>>> +	/*
>>> +	 * If PROT_WRITE is specified then extend that to PROT_READ
>>> +	 * protection_map[VM_WRITE] is now going to select shadow stack encod=
ings.
>>> +	 * So specifying PROT_WRITE actually should select protection_map [VM=
_WRITE | VM_READ]
>>> +	 * If user wants to create shadow stack then they should use `map_sha=
dow_stack` syscall.
>>> +	 */
>>> +	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
>>> +		prot |=3D PROT_READ;
>>
>>Why isn't the previous hunk be enough?  (Or why don't we do just this?)
>>
>>riscv_sys_mmap() eventually calls arch_calc_vm_prot_bits(), so I'd
>>rather fix each code path just once.
>
> You're right. Above hunk (arch/riscv/include/asm/mman.h) alone should be =
enough.
> I did this change in `sys_riscv.c` out of caution. If it feels like un-ne=
cessary,
> I'll remove it. No hard feelings either way.

I think it makes the code harder to reason about.  Here it is not clear
why this caller of ksys_mmap_pgoff() has to do this, while others don't.

