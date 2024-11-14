Return-Path: <linux-fsdevel+bounces-34821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51569C8ED5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD2A1F22F3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBD7183088;
	Thu, 14 Nov 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JPFbtK8n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1771717D346
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599451; cv=none; b=kt5NtihNXMziJ4bkbSdmwHmTcVlqU1Vg5oSORWL13Ayrvniz+i9SXTmjdVod3GLI3E0+4KG7AcFhEjwjSG9FF/JGPRIeikY0rCgmOVPZ8Rc2qYoXSXKUhz/8fX5NnAvzwgjZQGFhZ8E/2DQHV0GMev1s5+pJhGLoYNlfCTzcw00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599451; c=relaxed/simple;
	bh=I4+lQoZDoE5obNmbEbXZVyNC16ObpAZr7xb70Tlb8u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrkI9xaFDZ2O+v8wiP+gqftETt7Q1poBSddX2kRrEyrHWgQ0gZyOMM5iN/RwJBvSYjzYEE4OTjiaTmkI1ZaGEa9PQs6ANhiRPMSrl23QAONZ0y9rS6x6UJxq29tpJ5rXZyFSguUF+gccGNaLQJAj6mbTB/gjaetHTYu5YsVfyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JPFbtK8n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c693b68f5so9070735ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 07:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731599449; x=1732204249; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AuaBMTy+AeJsJU9fm4AZ56hQq3E5HBpfOKLhTwWZNeQ=;
        b=JPFbtK8n7vK10qMiAGMkQV5oP3XPC9tk5kf0Yp9MIPs17610Qb1uCn89HsVtQzaU22
         h9zEtSMYEtG1Elkl3rFfMQ97UWJmk5oSH3FZPP3s89GSMpOu74Bu0oUycIlyW2fLSdz/
         f1eYv/zgXfwUg6yhxLhAbuNjA9EkECLHJ7v2+n98V9COIfVH8BP2HxSQbHLTHIZf+na9
         0+S7dj7kMIpeq0kaxAg9apWL7qk2BLtbryl3e1Ps1/fy9NBbGGAxoF8MEStP+BEtfPGC
         SUQgQuDW3t3ryMxvZf2sZ6pB9jM+/r6DA4NexLQ337PtsDdSrJttdx4iSkQ/mn7xasny
         RVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731599449; x=1732204249;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuaBMTy+AeJsJU9fm4AZ56hQq3E5HBpfOKLhTwWZNeQ=;
        b=uKaTKMFrw++JDpwcRBVXlu+YTVdel2LYjmXYw+WbckQ/6sZEIFluMdRFSGjBSMaOU7
         st/kF7RSOSVzQkzsKjb36RZCxonQZQvOrVaMwJbSX2tkSXMtYa3kCYCWKAZzN4IRGH/I
         TvJeTDeOmQHbh2QZnp39uvr/ODmNgOed49IKQPvAP0Lf0g0LkPeQ0o2ktckTynJ5H02r
         6x5p+a9oMSHTMlx38SAk1s73HT99k89nSFS107e/2vgCRhDMQUtWr0dYahRqzhB5JwHv
         G1wNdoD8pjWXS+RxBZMqpHlR3qaV+mGXOhhYdgR6iJDQlYB9ABiQ4mp2rhFKy3dJT8yX
         X+CA==
X-Forwarded-Encrypted: i=1; AJvYcCU6HpnXxTlTx/P1yc5xXsItFZo8rdZxlDuxtcURtF11jtp9F8SoHlpAwG4sjc7mjYpb9zGkxs4k/HdJTeS5@vger.kernel.org
X-Gm-Message-State: AOJu0YyjiuKpdGvdgMHAGR3MyxbcMGQ1AsZWoTaQ4j9tAjI7M3aKQZoy
	F8H1p+jqoaAr5bNiXz5loTAZMLUWM4vq8KAtpIqp8eWp/XqCYRot4J3vHIoPaWg=
X-Google-Smtp-Source: AGHT+IHTSbLYPW9H6IMMv3J9GeiSG052ik1ZNbE+SJ7zga3eJUIE3+gCfX95oRz+I+/KI8Ko3d5rzw==
X-Received: by 2002:a17:902:cec7:b0:20c:7d4c:64db with SMTP id d9443c01a7336-211b5d542aemr85459765ad.49.1731599449294;
        Thu, 14 Nov 2024 07:50:49 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d377ecsm12256145ad.265.2024.11.14.07.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:50:48 -0800 (PST)
Date: Thu, 14 Nov 2024 07:50:45 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Nick Hu <nick.hu@sifive.com>
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
Subject: Re: [PATCH v8 24/29] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Message-ID: <ZzYcVW/4M0jab1T4@debug.ba.rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
 <20241111-v5_user_cfi_series-v8-24-dce14aa30207@rivosinc.com>
 <CAKddAkCCVjNHUinPWtOiK8Ki_ZkdoUCawfv1-+0B69J_1aJv5Q@mail.gmail.com>
 <ZzVNKvCu4MOs7O5z@debug.ba.rivosinc.com>
 <CAKddAkDbGYeONaksq6fzLzx47BHZo3Ar7Sog3MOgf7Y+Birovw@mail.gmail.com>
 <ZzVRbCZP9N4Os8Bj@debug.ba.rivosinc.com>
 <CAKddAkBCByf570PXfz798FtBbeGQWe2LJpdzxkE+jv3Zd3ZV1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKddAkBCByf570PXfz798FtBbeGQWe2LJpdzxkE+jv3Zd3ZV1w@mail.gmail.com>


Hi Nick,

Thanks for reviewing and helping.

On Thu, Nov 14, 2024 at 02:17:30PM +0800, Nick Hu wrote:
>Hi Deepak
>
>On Thu, Nov 14, 2024 at 9:25 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> On Thu, Nov 14, 2024 at 09:20:14AM +0800, Nick Hu wrote:
>> >Hi Deepak
>> >
>> >On Thu, Nov 14, 2024 at 9:06 AM Deepak Gupta <debug@rivosinc.com> wrote:
>> >> >> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> >> >> index 356d5397b2a2..6244408ca917 100644
>> >> >> --- a/arch/riscv/kernel/head.S
>> >> >> +++ b/arch/riscv/kernel/head.S
>> >> >> @@ -164,6 +164,12 @@ secondary_start_sbi:
>> >> >>         call relocate_enable_mmu
>> >> >>  #endif
>> >> >>         call .Lsetup_trap_vector
>> >> >> +       li a7, SBI_EXT_FWFT
>> >> >> +       li a6, SBI_EXT_FWFT_SET
>> >> >> +       li a0, SBI_FWFT_SHADOW_STACK
>> >> >> +       li a1, 1 /* enable supervisor to access shadow stack access */
>> >> >> +       li a2, SBI_FWFT_SET_FLAG_LOCK
>> >> >> +       ecall
>> >> >>         scs_load_current
>> >> >>         call smp_callin
>> >> >>  #endif /* CONFIG_SMP */
>> >> >> @@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
>> >> >>         la tp, init_task
>> >> >>         la sp, init_thread_union + THREAD_SIZE
>> >> >>         addi sp, sp, -PT_SIZE_ON_STACK
>> >> >> +       li a7, SBI_EXT_FWFT
>> >> >> +       li a6, SBI_EXT_FWFT_SET
>> >> >> +       li a0, SBI_FWFT_SHADOW_STACK
>> >> >> +       li a1, 1 /* enable supervisor to access shadow stack access */
>> >> >> +       li a2, SBI_FWFT_SET_FLAG_LOCK
>> >> >> +       ecall
>> >> >>         scs_load_current
>> >> >>
>> >> >>  #ifdef CONFIG_KASAN
>> >> >>
>> >> >> --
>> >> >> 2.45.0
>> >> >>
>> >> >Should we clear the SBI_FWFT_SET_FLAG_LOCK before the cpu hotplug
>> >> >otherwise the menvcfg.sse won't be set by the fwft set sbi call when
>> >> >the hotplug cpu back to kernel?
>> >>
>> >> Hmm...
>> >>
>> >> An incoming hotplug CPU has no features setup on it.
>> >> I see that `sbi_cpu_start` will supply `secondary_start_sbi` as start
>> >> up code for incoming CPU. `secondary_start_sbi` is in head.S which converges
>> >> in `.Lsecondary_start_common`. And thus hotplugged CPU should be
>> >> issuing shadow stack set FWFT sbi as well.
>> >>
>> >> Am I missing something ?
>> >>
>> >This is the correct flow. However the opensbi will deny it due to the
>> >SBI_FWFT_SET_FLAG_LOCK already being set.
>> >So the menvcfg.sse will not set by this flow.
>> >
>> >if (conf->flags & SBI_FWFT_SET_FLAG_LOCK)
>> >                return SBI_EDENIED;
>> >
>>
>> hmm... Why?
>>
>> `conf` is pointing to per-hart state in firmware.
>>
>> On this incoming cpu, opensbi (or equivalent) firmware must have
>> ensured that this per-hart state doesn't have lock set.
>>
>> Am I missing something?
>>
>Current OpenSBI doesn't clear the lock in the warm init of the hotplug path.
>It seems like we need a patch to address it.

Got it thanks.
Since you already know what's the problem, can you send a patch to opensbi.
If you want rather have me do it, let me know. Thanks.

>
>Regards,
>Nick
>> >Regards,
>> >Nick
>> >> >
>> >> >Regards,
>> >> >Nick
>> >> >>
>> >> >> _______________________________________________
>> >> >> linux-riscv mailing list
>> >> >> linux-riscv@lists.infradead.org
>> >> >> http://lists.infradead.org/mailman/listinfo/linux-riscv

