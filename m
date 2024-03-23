Return-Path: <linux-fsdevel+bounces-15162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DC78879E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 19:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2247281A42
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 18:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E855E56B78;
	Sat, 23 Mar 2024 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+ZA0Yzp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85853361;
	Sat, 23 Mar 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711217113; cv=none; b=cYg//07lnlanypNtcmHy3ES7kTSdADfQKP+yd/x7ZLYpO8XeP/LE92aZ0Dhl6YxuTyvb8Ajw40XPGXJ0DL47ZuS0kgoINlv1VvmdywgTSbOMZOb9/GKRzG+NxUhONCR8thIilAugIDsC+iXO4JkFQwWtjn/3n/S08z7duDBl9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711217113; c=relaxed/simple;
	bh=8MD7U6zh9lyFjW+z+tQZUZgTREWPu5nzXq2/F8h+Xk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NlsOdXNsWxiY6ukleSXoFxAaAcz0nOdZD445c5NZ18v87926XFNtcgYUFflcYz9qk9Gw36xF2roRHAcrkX/A2FavarJcMODG7Jxq4BbDwM43FDteUv1Jtn9bfo85Wn7S7iG3lNcFRbvEk5Y5LFcobTzJU+i3bNsSDTu+EV4edF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+ZA0Yzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B207C433F1;
	Sat, 23 Mar 2024 18:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711217112;
	bh=8MD7U6zh9lyFjW+z+tQZUZgTREWPu5nzXq2/F8h+Xk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+ZA0YzpWODCG/jdhV3lf4Tsz6S9/bKHiI6l5BUilmluqoSPmNKOehZEZzxSzBg6h
	 SPp9amNDbawTtaWRcfx8vUWcwkdawQd1h3lKqBsrlgYqdzCgy664gKqI+N5pVYs3F7
	 I+jg1g4zn1I3q4ACwTq5GOCs8ZakkLpf4i9TdI6XmeQZ42qNUbUmxpul10A22fQf+e
	 YHVeEGB6Z+AeKf/NJKsA/vg4HRORp6vxaJpqDIH9d6lUwUjoqSF6lI3IErkXIw9ihg
	 ilNklz8EX7BTfYeiCqKmsDu0pwwdCwYx9TYJXZq5y4dJQGxKVxg53WdTWk6XrIi2hc
	 cPtgOEYfmrkhA==
From: SeongJae Park <sj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org,
	mhocko@suse.com,
	vbabka@suse.cz,
	hannes@cmpxchg.org,
	roman.gushchin@linux.dev,
	mgorman@suse.de,
	dave@stgolabs.net,
	willy@infradead.org,
	liam.howlett@oracle.com,
	penguin-kernel@i-love.sakura.ne.jp,
	corbet@lwn.net,
	void@manifault.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	peterx@redhat.com,
	david@redhat.com,
	axboe@kernel.dk,
	mcgrof@kernel.org,
	masahiroy@kernel.org,
	nathan@kernel.org,
	dennis@kernel.org,
	jhubbard@nvidia.com,
	tj@kernel.org,
	muchun.song@linux.dev,
	rppt@kernel.org,
	paulmck@kernel.org,
	pasha.tatashin@soleen.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	dhowells@redhat.com,
	hughd@google.com,
	andreyknvl@gmail.com,
	keescook@chromium.org,
	ndesaulniers@google.com,
	vvvvvv@google.com,
	gregkh@linuxfoundation.org,
	ebiggers@google.com,
	ytcoode@gmail.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	bristot@redhat.com,
	vschneid@redhat.com,
	cl@linux.com,
	penberg@kernel.org,
	iamjoonsoo.kim@lge.com,
	42.hyeyoo@gmail.com,
	glider@google.com,
	elver@google.com,
	dvyukov@google.com,
	songmuchun@bytedance.com,
	jbaron@akamai.com,
	aliceryhl@google.com,
	rientjes@google.com,
	minchan@google.com,
	kaleshsingh@google.com,
	kernel-team@android.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v6 30/37] mm: vmalloc: Enable memory allocation profiling
Date: Sat, 23 Mar 2024 11:05:06 -0700
Message-Id: <20240323180506.195396-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240321163705.3067592-31-surenb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Suren and Kent,

On Thu, 21 Mar 2024 09:36:52 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> This wrapps all external vmalloc allocation functions with the
> alloc_hooks() wrapper, and switches internal allocations to _noprof
> variants where appropriate, for the new memory allocation profiling
> feature.

I just noticed latest mm-unstable fails running kunit on my machine as below.
'git-bisect' says this is the first commit of the failure.

    $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
    [10:59:53] Configuring KUnit Kernel ...
    [10:59:53] Building KUnit Kernel ...
    Populating config with:
    $ make ARCH=um O=../kunit.out/ olddefconfig
    Building with:
    $ make ARCH=um O=../kunit.out/ --jobs=36
    ERROR:root:/usr/bin/ld: arch/um/os-Linux/main.o: in function `__wrap_malloc':
    main.c:(.text+0x10b): undefined reference to `vmalloc'
    collect2: error: ld returned 1 exit status

Haven't looked into the code yet, but reporting first.  May I ask your idea?


Thanks,
SJ

> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  drivers/staging/media/atomisp/pci/hmm/hmm.c |  2 +-
>  include/linux/vmalloc.h                     | 60 ++++++++++----
>  kernel/kallsyms_selftest.c                  |  2 +-
>  mm/nommu.c                                  | 64 +++++++--------
>  mm/util.c                                   | 24 +++---
>  mm/vmalloc.c                                | 88 ++++++++++-----------
>  6 files changed, 135 insertions(+), 105 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> index bb12644fd033..3e2899ad8517 100644
> --- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
> +++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> @@ -205,7 +205,7 @@ static ia_css_ptr __hmm_alloc(size_t bytes, enum hmm_bo_type type,
>  	}
>  
>  	dev_dbg(atomisp_dev, "pages: 0x%08x (%zu bytes), type: %d, vmalloc %p\n",
> -		bo->start, bytes, type, vmalloc);
> +		bo->start, bytes, type, vmalloc_noprof);
>  
>  	return bo->start;
>  
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 98ea90e90439..e4a631ec430b 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_VMALLOC_H
>  #define _LINUX_VMALLOC_H
>  
> +#include <linux/alloc_tag.h>
> +#include <linux/sched.h>
>  #include <linux/spinlock.h>
>  #include <linux/init.h>
>  #include <linux/list.h>
> @@ -138,26 +140,54 @@ extern unsigned long vmalloc_nr_pages(void);
>  static inline unsigned long vmalloc_nr_pages(void) { return 0; }
>  #endif
>  
> -extern void *vmalloc(unsigned long size) __alloc_size(1);
> -extern void *vzalloc(unsigned long size) __alloc_size(1);
> -extern void *vmalloc_user(unsigned long size) __alloc_size(1);
> -extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1);
> -extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
> -extern void *vmalloc_32(unsigned long size) __alloc_size(1);
> -extern void *vmalloc_32_user(unsigned long size) __alloc_size(1);
> -extern void *__vmalloc(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
> -extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
> +extern void *vmalloc_noprof(unsigned long size) __alloc_size(1);
> +#define vmalloc(...)		alloc_hooks(vmalloc_noprof(__VA_ARGS__))
> +
> +extern void *vzalloc_noprof(unsigned long size) __alloc_size(1);
> +#define vzalloc(...)		alloc_hooks(vzalloc_noprof(__VA_ARGS__))
> +
> +extern void *vmalloc_user_noprof(unsigned long size) __alloc_size(1);
> +#define vmalloc_user(...)	alloc_hooks(vmalloc_user_noprof(__VA_ARGS__))
> +
> +extern void *vmalloc_node_noprof(unsigned long size, int node) __alloc_size(1);
> +#define vmalloc_node(...)	alloc_hooks(vmalloc_node_noprof(__VA_ARGS__))
> +
> +extern void *vzalloc_node_noprof(unsigned long size, int node) __alloc_size(1);
> +#define vzalloc_node(...)	alloc_hooks(vzalloc_node_noprof(__VA_ARGS__))
> +
> +extern void *vmalloc_32_noprof(unsigned long size) __alloc_size(1);
> +#define vmalloc_32(...)		alloc_hooks(vmalloc_32_noprof(__VA_ARGS__))
> +
> +extern void *vmalloc_32_user_noprof(unsigned long size) __alloc_size(1);
> +#define vmalloc_32_user(...)	alloc_hooks(vmalloc_32_user_noprof(__VA_ARGS__))
> +
> +extern void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
> +#define __vmalloc(...)		alloc_hooks(__vmalloc_noprof(__VA_ARGS__))
> +
> +extern void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  			unsigned long start, unsigned long end, gfp_t gfp_mask,
>  			pgprot_t prot, unsigned long vm_flags, int node,
>  			const void *caller) __alloc_size(1);
> -void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
> +#define __vmalloc_node_range(...)	alloc_hooks(__vmalloc_node_range_noprof(__VA_ARGS__))
> +
> +void *__vmalloc_node_noprof(unsigned long size, unsigned long align, gfp_t gfp_mask,
>  		int node, const void *caller) __alloc_size(1);
> -void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
> +#define __vmalloc_node(...)	alloc_hooks(__vmalloc_node_noprof(__VA_ARGS__))
> +
> +void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
> +#define vmalloc_huge(...)	alloc_hooks(vmalloc_huge_noprof(__VA_ARGS__))
> +
> +extern void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
> +#define __vmalloc_array(...)	alloc_hooks(__vmalloc_array_noprof(__VA_ARGS__))
> +
> +extern void *vmalloc_array_noprof(size_t n, size_t size) __alloc_size(1, 2);
> +#define vmalloc_array(...)	alloc_hooks(vmalloc_array_noprof(__VA_ARGS__))
> +
> +extern void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
> +#define __vcalloc(...)		alloc_hooks(__vcalloc_noprof(__VA_ARGS__))
>  
> -extern void *__vmalloc_array(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
> -extern void *vmalloc_array(size_t n, size_t size) __alloc_size(1, 2);
> -extern void *__vcalloc(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
> -extern void *vcalloc(size_t n, size_t size) __alloc_size(1, 2);
> +extern void *vcalloc_noprof(size_t n, size_t size) __alloc_size(1, 2);
> +#define vcalloc(...)		alloc_hooks(vcalloc_noprof(__VA_ARGS__))
>  
>  extern void vfree(const void *addr);
>  extern void vfree_atomic(const void *addr);
> diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
> index 8a689b4ff4f9..2f84896a7bcb 100644
> --- a/kernel/kallsyms_selftest.c
> +++ b/kernel/kallsyms_selftest.c
> @@ -82,7 +82,7 @@ static struct test_item test_items[] = {
>  	ITEM_FUNC(kallsyms_test_func_static),
>  	ITEM_FUNC(kallsyms_test_func),
>  	ITEM_FUNC(kallsyms_test_func_weak),
> -	ITEM_FUNC(vmalloc),
> +	ITEM_FUNC(vmalloc_noprof),
>  	ITEM_FUNC(vfree),
>  #ifdef CONFIG_KALLSYMS_ALL
>  	ITEM_DATA(kallsyms_test_var_bss_static),
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 5ec8f44e7ce9..69a6f3b4d156 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -137,28 +137,28 @@ void vfree(const void *addr)
>  }
>  EXPORT_SYMBOL(vfree);
>  
> -void *__vmalloc(unsigned long size, gfp_t gfp_mask)
> +void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
>  {
>  	/*
>  	 *  You can't specify __GFP_HIGHMEM with kmalloc() since kmalloc()
>  	 * returns only a logical address.
>  	 */
> -	return kmalloc(size, (gfp_mask | __GFP_COMP) & ~__GFP_HIGHMEM);
> +	return kmalloc_noprof(size, (gfp_mask | __GFP_COMP) & ~__GFP_HIGHMEM);
>  }
> -EXPORT_SYMBOL(__vmalloc);
> +EXPORT_SYMBOL(__vmalloc_noprof);
>  
> -void *__vmalloc_node_range(unsigned long size, unsigned long align,
> +void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  		unsigned long start, unsigned long end, gfp_t gfp_mask,
>  		pgprot_t prot, unsigned long vm_flags, int node,
>  		const void *caller)
>  {
> -	return __vmalloc(size, gfp_mask);
> +	return __vmalloc_noprof(size, gfp_mask);
>  }
>  
> -void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
> +void *__vmalloc_node_noprof(unsigned long size, unsigned long align, gfp_t gfp_mask,
>  		int node, const void *caller)
>  {
> -	return __vmalloc(size, gfp_mask);
> +	return __vmalloc_noprof(size, gfp_mask);
>  }
>  
>  static void *__vmalloc_user_flags(unsigned long size, gfp_t flags)
> @@ -179,11 +179,11 @@ static void *__vmalloc_user_flags(unsigned long size, gfp_t flags)
>  	return ret;
>  }
>  
> -void *vmalloc_user(unsigned long size)
> +void *vmalloc_user_noprof(unsigned long size)
>  {
>  	return __vmalloc_user_flags(size, GFP_KERNEL | __GFP_ZERO);
>  }
> -EXPORT_SYMBOL(vmalloc_user);
> +EXPORT_SYMBOL(vmalloc_user_noprof);
>  
>  struct page *vmalloc_to_page(const void *addr)
>  {
> @@ -217,13 +217,13 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
>   *	For tight control over page level allocator and protection flags
>   *	use __vmalloc() instead.
>   */
> -void *vmalloc(unsigned long size)
> +void *vmalloc_noprof(unsigned long size)
>  {
> -	return __vmalloc(size, GFP_KERNEL);
> +	return __vmalloc_noprof(size, GFP_KERNEL);
>  }
> -EXPORT_SYMBOL(vmalloc);
> +EXPORT_SYMBOL(vmalloc_noprof);
>  
> -void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __weak __alias(__vmalloc);
> +void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __weak __alias(__vmalloc_noprof);
>  
>  /*
>   *	vzalloc - allocate virtually contiguous memory with zero fill
> @@ -237,14 +237,14 @@ void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __weak __alias(__vmalloc)
>   *	For tight control over page level allocator and protection flags
>   *	use __vmalloc() instead.
>   */
> -void *vzalloc(unsigned long size)
> +void *vzalloc_noprof(unsigned long size)
>  {
> -	return __vmalloc(size, GFP_KERNEL | __GFP_ZERO);
> +	return __vmalloc_noprof(size, GFP_KERNEL | __GFP_ZERO);
>  }
> -EXPORT_SYMBOL(vzalloc);
> +EXPORT_SYMBOL(vzalloc_noprof);
>  
>  /**
> - * vmalloc_node - allocate memory on a specific node
> + * vmalloc_node_noprof - allocate memory on a specific node
>   * @size:	allocation size
>   * @node:	numa node
>   *
> @@ -254,14 +254,14 @@ EXPORT_SYMBOL(vzalloc);
>   * For tight control over page level allocator and protection flags
>   * use __vmalloc() instead.
>   */
> -void *vmalloc_node(unsigned long size, int node)
> +void *vmalloc_node_noprof(unsigned long size, int node)
>  {
> -	return vmalloc(size);
> +	return vmalloc_noprof(size);
>  }
> -EXPORT_SYMBOL(vmalloc_node);
> +EXPORT_SYMBOL(vmalloc_node_noprof);
>  
>  /**
> - * vzalloc_node - allocate memory on a specific node with zero fill
> + * vzalloc_node_noprof - allocate memory on a specific node with zero fill
>   * @size:	allocation size
>   * @node:	numa node
>   *
> @@ -272,27 +272,27 @@ EXPORT_SYMBOL(vmalloc_node);
>   * For tight control over page level allocator and protection flags
>   * use __vmalloc() instead.
>   */
> -void *vzalloc_node(unsigned long size, int node)
> +void *vzalloc_node_noprof(unsigned long size, int node)
>  {
> -	return vzalloc(size);
> +	return vzalloc_noprof(size);
>  }
> -EXPORT_SYMBOL(vzalloc_node);
> +EXPORT_SYMBOL(vzalloc_node_noprof);
>  
>  /**
> - * vmalloc_32  -  allocate virtually contiguous memory (32bit addressable)
> + * vmalloc_32_noprof  -  allocate virtually contiguous memory (32bit addressable)
>   *	@size:		allocation size
>   *
>   *	Allocate enough 32bit PA addressable pages to cover @size from the
>   *	page level allocator and map them into contiguous kernel virtual space.
>   */
> -void *vmalloc_32(unsigned long size)
> +void *vmalloc_32_noprof(unsigned long size)
>  {
> -	return __vmalloc(size, GFP_KERNEL);
> +	return __vmalloc_noprof(size, GFP_KERNEL);
>  }
> -EXPORT_SYMBOL(vmalloc_32);
> +EXPORT_SYMBOL(vmalloc_32_noprof);
>  
>  /**
> - * vmalloc_32_user - allocate zeroed virtually contiguous 32bit memory
> + * vmalloc_32_user_noprof - allocate zeroed virtually contiguous 32bit memory
>   *	@size:		allocation size
>   *
>   * The resulting memory area is 32bit addressable and zeroed so it can be
> @@ -301,15 +301,15 @@ EXPORT_SYMBOL(vmalloc_32);
>   * VM_USERMAP is set on the corresponding VMA so that subsequent calls to
>   * remap_vmalloc_range() are permissible.
>   */
> -void *vmalloc_32_user(unsigned long size)
> +void *vmalloc_32_user_noprof(unsigned long size)
>  {
>  	/*
>  	 * We'll have to sort out the ZONE_DMA bits for 64-bit,
>  	 * but for now this can simply use vmalloc_user() directly.
>  	 */
> -	return vmalloc_user(size);
> +	return vmalloc_user_noprof(size);
>  }
> -EXPORT_SYMBOL(vmalloc_32_user);
> +EXPORT_SYMBOL(vmalloc_32_user_noprof);
>  
>  void *vmap(struct page **pages, unsigned int count, unsigned long flags, pgprot_t prot)
>  {
> diff --git a/mm/util.c b/mm/util.c
> index a79dce7546f1..157b5edcba75 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -656,7 +656,7 @@ void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
>  	 * about the resulting pointer, and cannot play
>  	 * protection games.
>  	 */
> -	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> +	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
>  			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
>  			node, __builtin_return_address(0));
>  }
> @@ -715,12 +715,12 @@ void *kvrealloc_noprof(const void *p, size_t oldsize, size_t newsize, gfp_t flag
>  EXPORT_SYMBOL(kvrealloc_noprof);
>  
>  /**
> - * __vmalloc_array - allocate memory for a virtually contiguous array.
> + * __vmalloc_array_noprof - allocate memory for a virtually contiguous array.
>   * @n: number of elements.
>   * @size: element size.
>   * @flags: the type of memory to allocate (see kmalloc).
>   */
> -void *__vmalloc_array(size_t n, size_t size, gfp_t flags)
> +void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags)
>  {
>  	size_t bytes;
>  
> @@ -728,18 +728,18 @@ void *__vmalloc_array(size_t n, size_t size, gfp_t flags)
>  		return NULL;
>  	return __vmalloc(bytes, flags);
>  }
> -EXPORT_SYMBOL(__vmalloc_array);
> +EXPORT_SYMBOL(__vmalloc_array_noprof);
>  
>  /**
> - * vmalloc_array - allocate memory for a virtually contiguous array.
> + * vmalloc_array_noprof - allocate memory for a virtually contiguous array.
>   * @n: number of elements.
>   * @size: element size.
>   */
> -void *vmalloc_array(size_t n, size_t size)
> +void *vmalloc_array_noprof(size_t n, size_t size)
>  {
>  	return __vmalloc_array(n, size, GFP_KERNEL);
>  }
> -EXPORT_SYMBOL(vmalloc_array);
> +EXPORT_SYMBOL(vmalloc_array_noprof);
>  
>  /**
>   * __vcalloc - allocate and zero memory for a virtually contiguous array.
> @@ -747,22 +747,22 @@ EXPORT_SYMBOL(vmalloc_array);
>   * @size: element size.
>   * @flags: the type of memory to allocate (see kmalloc).
>   */
> -void *__vcalloc(size_t n, size_t size, gfp_t flags)
> +void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags)
>  {
>  	return __vmalloc_array(n, size, flags | __GFP_ZERO);
>  }
> -EXPORT_SYMBOL(__vcalloc);
> +EXPORT_SYMBOL(__vcalloc_noprof);
>  
>  /**
> - * vcalloc - allocate and zero memory for a virtually contiguous array.
> + * vcalloc_noprof - allocate and zero memory for a virtually contiguous array.
>   * @n: number of elements.
>   * @size: element size.
>   */
> -void *vcalloc(size_t n, size_t size)
> +void *vcalloc_noprof(size_t n, size_t size)
>  {
>  	return __vmalloc_array(n, size, GFP_KERNEL | __GFP_ZERO);
>  }
> -EXPORT_SYMBOL(vcalloc);
> +EXPORT_SYMBOL(vcalloc_noprof);
>  
>  struct anon_vma *folio_anon_vma(struct folio *folio)
>  {
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22aa63f4ef63..b2f2248d85a9 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3507,12 +3507,12 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			 * but mempolicy wants to alloc memory by interleaving.
>  			 */
>  			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
> -				nr = alloc_pages_bulk_array_mempolicy(bulk_gfp,
> +				nr = alloc_pages_bulk_array_mempolicy_noprof(bulk_gfp,
>  							nr_pages_request,
>  							pages + nr_allocated);
>  
>  			else
> -				nr = alloc_pages_bulk_array_node(bulk_gfp, nid,
> +				nr = alloc_pages_bulk_array_node_noprof(bulk_gfp, nid,
>  							nr_pages_request,
>  							pages + nr_allocated);
>  
> @@ -3542,9 +3542,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			break;
>  
>  		if (nid == NUMA_NO_NODE)
> -			page = alloc_pages(alloc_gfp, order);
> +			page = alloc_pages_noprof(alloc_gfp, order);
>  		else
> -			page = alloc_pages_node(nid, alloc_gfp, order);
> +			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
>  		if (unlikely(!page)) {
>  			if (!nofail)
>  				break;
> @@ -3601,10 +3601,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  
>  	/* Please note that the recursion is strictly bounded. */
>  	if (array_size > PAGE_SIZE) {
> -		area->pages = __vmalloc_node(array_size, 1, nested_gfp, node,
> +		area->pages = __vmalloc_node_noprof(array_size, 1, nested_gfp, node,
>  					area->caller);
>  	} else {
> -		area->pages = kmalloc_node(array_size, nested_gfp, node);
> +		area->pages = kmalloc_node_noprof(array_size, nested_gfp, node);
>  	}
>  
>  	if (!area->pages) {
> @@ -3687,7 +3687,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  }
>  
>  /**
> - * __vmalloc_node_range - allocate virtually contiguous memory
> + * __vmalloc_node_range_noprof - allocate virtually contiguous memory
>   * @size:		  allocation size
>   * @align:		  desired alignment
>   * @start:		  vm area range start
> @@ -3714,7 +3714,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>   *
>   * Return: the address of the area or %NULL on failure
>   */
> -void *__vmalloc_node_range(unsigned long size, unsigned long align,
> +void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  			unsigned long start, unsigned long end, gfp_t gfp_mask,
>  			pgprot_t prot, unsigned long vm_flags, int node,
>  			const void *caller)
> @@ -3843,7 +3843,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  }
>  
>  /**
> - * __vmalloc_node - allocate virtually contiguous memory
> + * __vmalloc_node_noprof - allocate virtually contiguous memory
>   * @size:	    allocation size
>   * @align:	    desired alignment
>   * @gfp_mask:	    flags for the page level allocator
> @@ -3861,10 +3861,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -void *__vmalloc_node(unsigned long size, unsigned long align,
> +void *__vmalloc_node_noprof(unsigned long size, unsigned long align,
>  			    gfp_t gfp_mask, int node, const void *caller)
>  {
> -	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
> +	return __vmalloc_node_range_noprof(size, align, VMALLOC_START, VMALLOC_END,
>  				gfp_mask, PAGE_KERNEL, 0, node, caller);
>  }
>  /*
> @@ -3873,15 +3873,15 @@ void *__vmalloc_node(unsigned long size, unsigned long align,
>   * than that.
>   */
>  #ifdef CONFIG_TEST_VMALLOC_MODULE
> -EXPORT_SYMBOL_GPL(__vmalloc_node);
> +EXPORT_SYMBOL_GPL(__vmalloc_node_noprof);
>  #endif
>  
> -void *__vmalloc(unsigned long size, gfp_t gfp_mask)
> +void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
>  {
> -	return __vmalloc_node(size, 1, gfp_mask, NUMA_NO_NODE,
> +	return __vmalloc_node_noprof(size, 1, gfp_mask, NUMA_NO_NODE,
>  				__builtin_return_address(0));
>  }
> -EXPORT_SYMBOL(__vmalloc);
> +EXPORT_SYMBOL(__vmalloc_noprof);
>  
>  /**
>   * vmalloc - allocate virtually contiguous memory
> @@ -3895,12 +3895,12 @@ EXPORT_SYMBOL(__vmalloc);
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -void *vmalloc(unsigned long size)
> +void *vmalloc_noprof(unsigned long size)
>  {
> -	return __vmalloc_node(size, 1, GFP_KERNEL, NUMA_NO_NODE,
> +	return __vmalloc_node_noprof(size, 1, GFP_KERNEL, NUMA_NO_NODE,
>  				__builtin_return_address(0));
>  }
> -EXPORT_SYMBOL(vmalloc);
> +EXPORT_SYMBOL(vmalloc_noprof);
>  
>  /**
>   * vmalloc_huge - allocate virtually contiguous memory, allow huge pages
> @@ -3914,16 +3914,16 @@ EXPORT_SYMBOL(vmalloc);
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -void *vmalloc_huge(unsigned long size, gfp_t gfp_mask)
> +void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask)
>  {
> -	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> +	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
>  				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
>  				    NUMA_NO_NODE, __builtin_return_address(0));
>  }
> -EXPORT_SYMBOL_GPL(vmalloc_huge);
> +EXPORT_SYMBOL_GPL(vmalloc_huge_noprof);
>  
>  /**
> - * vzalloc - allocate virtually contiguous memory with zero fill
> + * vzalloc_noprof - allocate virtually contiguous memory with zero fill
>   * @size:    allocation size
>   *
>   * Allocate enough pages to cover @size from the page level
> @@ -3935,12 +3935,12 @@ EXPORT_SYMBOL_GPL(vmalloc_huge);
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -void *vzalloc(unsigned long size)
> +void *vzalloc_noprof(unsigned long size)
>  {
> -	return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_ZERO, NUMA_NO_NODE,
> +	return __vmalloc_node_noprof(size, 1, GFP_KERNEL | __GFP_ZERO, NUMA_NO_NODE,
>  				__builtin_return_address(0));
>  }
> -EXPORT_SYMBOL(vzalloc);
> +EXPORT_SYMBOL(vzalloc_noprof);
>  
>  /**
>   * vmalloc_user - allocate zeroed virtually contiguous memory for userspace
> @@ -3951,17 +3951,17 @@ EXPORT_SYMBOL(vzalloc);
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -void *vmalloc_user(unsigned long size)
> +void *vmalloc_user_noprof(unsigned long size)
>  {
> -	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
> +	return __vmalloc_node_range_noprof(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
>  				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
>  				    VM_USERMAP, NUMA_NO_NODE,
>  				    __builtin_return_address(0));
>  }
> -EXPORT_SYMBOL(vmalloc_user);
> +EXPORT_SYMBOL(vmalloc_user_noprof);
>  
>  /**
> - * vmalloc_node - allocate memory on a specific node
> + * vmalloc_node_noprof - allocate memory on a specific node
>   * @size:	  allocation size
>   * @node:	  numa node
>   *
> @@ -3973,15 +3973,15 @@ EXPORT_SYMBOL(vmalloc_user);
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -void *vmalloc_node(unsigned long size, int node)
> +void *vmalloc_node_noprof(unsigned long size, int node)
>  {
> -	return __vmalloc_node(size, 1, GFP_KERNEL, node,
> +	return __vmalloc_node_noprof(size, 1, GFP_KERNEL, node,
>  			__builtin_return_address(0));
>  }
> -EXPORT_SYMBOL(vmalloc_node);
> +EXPORT_SYMBOL(vmalloc_node_noprof);
>  
>  /**
> - * vzalloc_node - allocate memory on a specific node with zero fill
> + * vzalloc_node_noprof - allocate memory on a specific node with zero fill
>   * @size:	allocation size
>   * @node:	numa node
>   *
> @@ -3991,12 +3991,12 @@ EXPORT_SYMBOL(vmalloc_node);
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -void *vzalloc_node(unsigned long size, int node)
> +void *vzalloc_node_noprof(unsigned long size, int node)
>  {
> -	return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_ZERO, node,
> +	return __vmalloc_node_noprof(size, 1, GFP_KERNEL | __GFP_ZERO, node,
>  				__builtin_return_address(0));
>  }
> -EXPORT_SYMBOL(vzalloc_node);
> +EXPORT_SYMBOL(vzalloc_node_noprof);
>  
>  #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
>  #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
> @@ -4011,7 +4011,7 @@ EXPORT_SYMBOL(vzalloc_node);
>  #endif
>  
>  /**
> - * vmalloc_32 - allocate virtually contiguous memory (32bit addressable)
> + * vmalloc_32_noprof - allocate virtually contiguous memory (32bit addressable)
>   * @size:	allocation size
>   *
>   * Allocate enough 32bit PA addressable pages to cover @size from the
> @@ -4019,15 +4019,15 @@ EXPORT_SYMBOL(vzalloc_node);
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -void *vmalloc_32(unsigned long size)
> +void *vmalloc_32_noprof(unsigned long size)
>  {
> -	return __vmalloc_node(size, 1, GFP_VMALLOC32, NUMA_NO_NODE,
> +	return __vmalloc_node_noprof(size, 1, GFP_VMALLOC32, NUMA_NO_NODE,
>  			__builtin_return_address(0));
>  }
> -EXPORT_SYMBOL(vmalloc_32);
> +EXPORT_SYMBOL(vmalloc_32_noprof);
>  
>  /**
> - * vmalloc_32_user - allocate zeroed virtually contiguous 32bit memory
> + * vmalloc_32_user_noprof - allocate zeroed virtually contiguous 32bit memory
>   * @size:	     allocation size
>   *
>   * The resulting memory area is 32bit addressable and zeroed so it can be
> @@ -4035,14 +4035,14 @@ EXPORT_SYMBOL(vmalloc_32);
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -void *vmalloc_32_user(unsigned long size)
> +void *vmalloc_32_user_noprof(unsigned long size)
>  {
> -	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
> +	return __vmalloc_node_range_noprof(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
>  				    GFP_VMALLOC32 | __GFP_ZERO, PAGE_KERNEL,
>  				    VM_USERMAP, NUMA_NO_NODE,
>  				    __builtin_return_address(0));
>  }
> -EXPORT_SYMBOL(vmalloc_32_user);
> +EXPORT_SYMBOL(vmalloc_32_user_noprof);
>  
>  /*
>   * Atomically zero bytes in the iterator.
> -- 
> 2.44.0.291.gc1ea87d7ee-goog

