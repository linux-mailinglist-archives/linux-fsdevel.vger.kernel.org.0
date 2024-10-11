Return-Path: <linux-fsdevel+bounces-31738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5D799A968
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 19:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056C01F2298C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EACD1A070E;
	Fri, 11 Oct 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FM2rH5Tt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0D194C75
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666355; cv=none; b=KO2yG00o/GtHhtH5hUENt8S5xO3lejTAFMTOfXLU4LIVXPHPH8aimr7SC7XaTT/ZY5TT2LQ7pJCX56WL1TBc1hDt7g7eSgx/xs7i6Ij80bdn2uhNAQmW4Lk5cNy4tl+z51tF7F64zujHzcIM1R/7+9XfZfTtXWw9upqjYxLH9E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666355; c=relaxed/simple;
	bh=Ivb13btRLkZd311JHLcxllqxjyNjmMc5lCWUcQ6aXkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3nLSVghiZh5/1j3F8PFGAQzeiU1ZTYWS73+npg+na3woy30KK8wSXlx24sdlbT277lj/h0d/Dte+uQ34dDp2LuCYqUaOBWGKVP1QH1BrbjbLzHpPu73nJmJW0Fm6JjMO4SgJmPlvhD1/XaS6+SbmBQP1YDlnUpWEKniehOgEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FM2rH5Tt; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso1882493a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728666353; x=1729271153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GX97w9CZORz9pwsb2g6R6nhW/kmsArAb0VPRjnUPWTE=;
        b=FM2rH5TtimuWZfImhR8/IuMu5Gbow+Y1AdKnn1tyEf3GK7h7jCqbt6Px6HGnB0HhZ1
         fSjK0umzOpA49XT2/YVkm7VBbbvpprvAxhmJUlEqG5FBRIsCBXYomY1gvdRh4oFxI7+W
         dYmYJukgDPMfSVfddmDqNpC7PBflBJwZQO4mKP6zMXChyhsPdY2NM/hRIhTscG9IVD00
         gicf2aW7idCn71mkxHK8A6ADYM5lWnT4hUOpXj2sTYatqoTs+dYs318ePjMczdp3wIMW
         oq95fpFGhmM3KDaxnEH/chPC+BRRgDJxrB+r4YxdG+EfFot2dDt6jSAvxnluigA3ggft
         reqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666353; x=1729271153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX97w9CZORz9pwsb2g6R6nhW/kmsArAb0VPRjnUPWTE=;
        b=iy7POAfvLuJorvNnIpPin4O4eMP6+boAwE1rYzHqln3k6HK79O+WhcM2bhfb0dE1NU
         EGj+NnVDZOCfuxnVfpngJkT/HyiGxei5B3IhoGB6LJPB+1vG47TtQxA9r8OYsWlXoMeN
         uKTvW36mVTlyxft/GXIvaxL6GqKElfmqLvIf9vtdldfQNhqOnzKmHTwwmuwXZ9g4JoJ0
         yoiVJhUJT3ZujIs81TnK2v4K6JMS0qnEZVgSTsGTwvO1cMJ9WJJEZvGJq0L+CGdLtBZ9
         VeFPWT3Djy3bmgj9E2Vh/6fJxM2cXNxK4Y7p05qU+0xg50viVIqwtS6SvIKMYoT1gr/W
         sYOw==
X-Forwarded-Encrypted: i=1; AJvYcCUjdLKDjHm+Y/CSMV0I57aM45IjI7lmMbu2GwlWA1T1RslMt5Mv3L8wTxRUvv322eqNJ7AmnGDrHqtKFLgd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5gDI0ZaO4C78gLfPdoeFje0nWcW6vyNxC5oNnDYHx27FwnYW6
	nbUUIurG4WWc6sns+bsB+vnmwrRJlkZ+lHYzfaTDc1C3j/Gw8Kw1uP/PQp6D4LE=
X-Google-Smtp-Source: AGHT+IHeKLAKX34MOiFH+9aZBGmNB0XIEjZvnsN4hA9hIXNt7UoKkhvVG/Qf7QZjmPERRc/yqeydag==
X-Received: by 2002:a05:6a21:e8a:b0:1d8:b11e:19b9 with SMTP id adf61e73a8af0-1d8bcfb3d9cmr5518442637.47.1728666352605;
        Fri, 11 Oct 2024 10:05:52 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f522esm2810481b3a.69.2024.10.11.10.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:05:52 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:05:50 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH RFC/RFT 3/3] kernel: converge common shadow stack flow
 agnostic to arch
Message-ID: <Zwla7gBxyPOK0yBC@debug.ba.rivosinc.com>
References: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
 <20241010-shstk_converge-v1-3-631beca676e7@rivosinc.com>
 <ZwkbAauYGhtldtW6@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZwkbAauYGhtldtW6@finisterre.sirena.org.uk>

On Fri, Oct 11, 2024 at 01:33:05PM +0100, Mark Brown wrote:
>On Thu, Oct 10, 2024 at 05:32:05PM -0700, Deepak Gupta wrote:
>
>> +unsigned long alloc_shstk(unsigned long addr, unsigned long size,
>> +				 unsigned long token_offset, bool set_res_tok);
>> +int shstk_setup(void);
>> +int create_rstor_token(unsigned long ssp, unsigned long *token_addr);
>> +bool cpu_supports_shadow_stack(void);
>
>The cpu_ naming is confusing in an arm64 context, we use cpu_ for
>functions that report if a feature is supported on the current CPU and
>system_ for functions that report if a feature is enabled on the system.
>

hmm...
Curious. What's the difference between cpu and system?
We can ditch both cpu and system and call it
`user_shstk_supported()`. Again not a great name but all we are looking for
is whether user shadow stack is supported or not.

>> +void set_thread_shstk_status(bool enable);
>
>It might be better if this took the flags that the prctl() takes?  It
>feels like

hmm we can do that. But I imagine it might get invoked from other flow as well.
Although instead of `bool`, we can take `unsigned long` here. It would work for now
for `prctl` and future users get options to chisel around it.
I'll do that.

>
>> +/* Flags for map_shadow_stack(2) */
>> +#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
>> +
>
>We've also got SHADOW_STACK_SET_MARKER now.
>

Sorry, I missed it.

>> +bool cpu_supports_shadow_stack(void)
>> +{
>> +	return arch_cpu_supports_shadow_stack();
>> +}
>> +
>> +bool is_shstk_enabled(struct task_struct *task)
>> +{
>> +	return arch_is_shstk_enabled(task);
>> +}
>
>Do we need these wrappers (or could they just be static inlines in the
>header)?

As I started doing this exercise, I ran into some headers and multiple
definitions issue due to both modules (arch specific shstk.c and generic
usershstk.c) need to call into each other independently and need to include
each other headers, so took path of least resistence.

But now that it settling a bit and I've better picture, I'll give it a try
again.

>
>> +void set_thread_shstk_status(bool enable)
>> +{
>> +	arch_set_thread_shstk_status(enable);
>> +}
>
>arm64 can return an error here, we reject a bunch of conditions like 32
>bit threads and locked enable status.

Ok.
You would like this error to be `bool` or an `int`?

>
>> +unsigned long adjust_shstk_size(unsigned long size)
>> +{
>> +	if (size)
>> +		return PAGE_ALIGN(size);
>> +
>> +	return PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G));
>> +}
>
>static?

Yes this can be static.

>
>> +/*
>> + * VM_SHADOW_STACK will have a guard page. This helps userspace protect
>> + * itself from attacks. The reasoning is as follows:
>> + *
>> + * The shadow stack pointer(SSP) is moved by CALL, RET, and INCSSPQ. The
>> + * INCSSP instruction can increment the shadow stack pointer. It is the
>> + * shadow stack analog of an instruction like:
>> + *
>> + *   addq $0x80, %rsp
>> + *
>> + * However, there is one important difference between an ADD on %rsp
>> + * and INCSSP. In addition to modifying SSP, INCSSP also reads from the
>> + * memory of the first and last elements that were "popped". It can be
>> + * thought of as acting like this:
>> + *
>> + * READ_ONCE(ssp);       // read+discard top element on stack
>> + * ssp += nr_to_pop * 8; // move the shadow stack
>> + * READ_ONCE(ssp-8);     // read+discard last popped stack element
>> + *
>> + * The maximum distance INCSSP can move the SSP is 2040 bytes, before
>> + * it would read the memory. Therefore a single page gap will be enough
>> + * to prevent any operation from shifting the SSP to an adjacent stack,
>> + * since it would have to land in the gap at least once, causing a
>> + * fault.
>
>This is all very x86 centric...

Yes I am aware and likely will be removed, assuming no objections from x86 on
removing it.

>
>> +	if (create_rstor_token(mapped_addr + token_offset, NULL)) {
>> +		vm_munmap(mapped_addr, size);
>> +		return -EINVAL;
>> +	}
>
>Bikeshedding but can we call the function create_shstk_token() instead?
>The rstor means absolutely nothing in an arm64 context.

`create_shstk_token` it is. Much better name. Thanks.

>
>> +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
>> +{
>> +	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
>> +	unsigned long aligned_size;
>> +
>> +	if (!cpu_supports_shadow_stack())
>> +		return -EOPNOTSUPP;
>> +
>> +	if (flags & ~SHADOW_STACK_SET_TOKEN)
>> +		return -EINVAL;
>
>This needs SHADOW_STACK_SET_MARKER for arm64.

Ack.

>
>> +	if (addr && (addr & (PAGE_SIZE - 1)))
>> +		return -EINVAL;
>
>	if (!PAGE_ALIGNED(addr))
>
>> +int shstk_setup(void)
>> +{
>
>This is half of the implementation of the prctl() for enabling shadow
>stacks.  Looking at the arm64 implementation this rafactoring feels a
>bit awkward, we don't have the one flag at a time requiremet that x86
>has and we structure things rather differently.  I'm not sure that the
>arch_prctl() and prctl() are going to line up comfortably...
>

Yes I was in two minds as well. In x86 case, its anyways arch specific
so, you will land up in arch specific code and then later land in generic
code. In case of arm64 and riscv as well, each will have arch specific
implementation.

I'll give a try on making prctl handling arch agnostic. If it becomes too
kludgy and ugly, may be its best that prctl handling and first time shadow
stack setup is all arch specific.

>> +	struct thread_shstk *shstk = &current->thread.shstk;

Note for myself, this ^ is not needed. It's x86 specific and I missed this
clean up.

>> +	unsigned long addr, size;
>> +
>> +	/* Already enabled */
>> +	if (is_shstk_enabled(current))
>> +		return 0;
>> +
>> +	/* Also not supported for 32 bit */
>> +	if (!cpu_supports_shadow_stack() ||
>> +		(IS_ENABLED(CONFIG_X86_64) && in_ia32_syscall()))
>> +		return -EOPNOTSUPP;
>
>We probably need a thread_supports_shstk(), 

`is_shstk_enabled(current)` doesn't work?

> arm64 has a similar check
>for not 32 bit threads and I noted an issue with needing this check
>elsewhere.

hmm May be that's why we need `is_shskt_enabled(current)` and another
`thread_supports_shstk` (probably some better name here from someone on list)

And in case we end up having no commonalities in prctl handling (as mentioned
in comment above), may be then its not needed to have a `thread_supports_shstk`
because its needed during prctl
handling.

>
>> +	/*
>> +	 * For CLONE_VFORK the child will share the parents shadow stack.
>> +	 * Make sure to clear the internal tracking of the thread shadow
>> +	 * stack so the freeing logic run for child knows to leave it alone.
>> +	 */
>> +	if (clone_flags & CLONE_VFORK) {
>> +		set_shstk_base_size(tsk, 0, 0);
>> +		return 0;
>> +	}
>
>On arm64 we set the new thread's shadow stack pointer here, the logic
>around that can probably also be usefully factored out.

Ok I'll take a look.

>
>> +	/*
>> +	 * For !CLONE_VM the child will use a copy of the parents shadow
>> +	 * stack.
>> +	 */
>> +	if (!(clone_flags & CLONE_VM))
>> +		return 0;
>
>Here also.

Same comment as above.



