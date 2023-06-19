Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA127734F7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjFSJTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 05:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFSJTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:19:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92DBA83;
        Mon, 19 Jun 2023 02:19:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 279F612FC;
        Mon, 19 Jun 2023 02:19:49 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.28.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B0053F64C;
        Mon, 19 Jun 2023 02:19:03 -0700 (PDT)
Date:   Mon, 19 Jun 2023 10:19:00 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZJAdhBIvwFBOFQU/@FVFF77S0Q05N>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509165657.1735798-8-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 12:56:32PM -0400, Kent Overstreet wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> This is needed for bcachefs, which dynamically generates per-btree node
> unpack functions.

Much like Kees and Andy, I have concerns with adding new code generators to the
kernel. Even ignoring the actual code generation, there are a bunch of subtle
ordering/maintenance/synchronization concerns across architectures, and we
already have a fair amount of pain with the existing cases.

Can you share more detail on how you want to use this?

From a quick scan of your gitweb for the bcachefs-for-upstream branch I
couldn't spot the relevant patches.

Thanks,
Mark.

> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: linux-mm@kvack.org
> ---
>  include/linux/vmalloc.h |  1 +
>  kernel/module/main.c    |  4 +---
>  mm/nommu.c              | 18 ++++++++++++++++++
>  mm/vmalloc.c            | 21 +++++++++++++++++++++
>  4 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 69250efa03..ff147fe115 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -145,6 +145,7 @@ extern void *vzalloc(unsigned long size) __alloc_size(1);
>  extern void *vmalloc_user(unsigned long size) __alloc_size(1);
>  extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1);
>  extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
> +extern void *vmalloc_exec(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
>  extern void *vmalloc_32(unsigned long size) __alloc_size(1);
>  extern void *vmalloc_32_user(unsigned long size) __alloc_size(1);
>  extern void *__vmalloc(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d3be89de70..9eaa89e84c 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1607,9 +1607,7 @@ static void dynamic_debug_remove(struct module *mod, struct _ddebug_info *dyndbg
>  
>  void * __weak module_alloc(unsigned long size)
>  {
> -	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> -			GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
> -			NUMA_NO_NODE, __builtin_return_address(0));
> +	return vmalloc_exec(size, GFP_KERNEL);
>  }
>  
>  bool __weak module_init_section(const char *name)
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 57ba243c6a..8d9ab19e39 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -280,6 +280,24 @@ void *vzalloc_node(unsigned long size, int node)
>  }
>  EXPORT_SYMBOL(vzalloc_node);
>  
> +/**
> + *	vmalloc_exec  -  allocate virtually contiguous, executable memory
> + *	@size:		allocation size
> + *
> + *	Kernel-internal function to allocate enough pages to cover @size
> + *	the page level allocator and map them into contiguous and
> + *	executable kernel virtual space.
> + *
> + *	For tight control over page level allocator and protection flags
> + *	use __vmalloc() instead.
> + */
> +
> +void *vmalloc_exec(unsigned long size, gfp_t gfp_mask)
> +{
> +	return __vmalloc(size, gfp_mask);
> +}
> +EXPORT_SYMBOL_GPL(vmalloc_exec);
> +
>  /**
>   * vmalloc_32  -  allocate virtually contiguous memory (32bit addressable)
>   *	@size:		allocation size
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 31ff782d36..2ebb9ea7f0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3401,6 +3401,27 @@ void *vzalloc_node(unsigned long size, int node)
>  }
>  EXPORT_SYMBOL(vzalloc_node);
>  
> +/**
> + * vmalloc_exec - allocate virtually contiguous, executable memory
> + * @size:	  allocation size
> + *
> + * Kernel-internal function to allocate enough pages to cover @size
> + * the page level allocator and map them into contiguous and
> + * executable kernel virtual space.
> + *
> + * For tight control over page level allocator and protection flags
> + * use __vmalloc() instead.
> + *
> + * Return: pointer to the allocated memory or %NULL on error
> + */
> +void *vmalloc_exec(unsigned long size, gfp_t gfp_mask)
> +{
> +	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> +			gfp_mask, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
> +			NUMA_NO_NODE, __builtin_return_address(0));
> +}
> +EXPORT_SYMBOL_GPL(vmalloc_exec);
> +
>  #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
>  #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
>  #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
> -- 
> 2.40.1
> 
> 
