Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43758249AFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 12:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgHSKt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 06:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728071AbgHSKtX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597834161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=fnMpmNkiQKFSMD4o4Zix40+pSX62ZQNzQSZ6IbxQ3p8=;
        b=PncHqiQCk1zVCG6GHDOjFrKjv3SKWRWZ90CpSGBuQKsvUzPPaqdgktZBOnkQod/mbcZRMS
        zpIfEwRksaWyLtGNEcufKymn4qa6Q4kFQQkfdtzpyPhDPtzVh/ohptRTtLULB1LFi40EGq
        Jrho0bjT5nlQ2ohJWvPV45N/+m/SU8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-0zOlRlG-MXyHJMcMdVzMpQ-1; Wed, 19 Aug 2020 06:49:17 -0400
X-MC-Unique: 0zOlRlG-MXyHJMcMdVzMpQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 042BF81F02C;
        Wed, 19 Aug 2020 10:49:13 +0000 (UTC)
Received: from [10.36.114.11] (ovpn-114-11.ams2.redhat.com [10.36.114.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AED557AEC0;
        Wed, 19 Aug 2020 10:49:06 +0000 (UTC)
Subject: Re: [PATCH v4 6/6] mm: secretmem: add ability to reserve memory at
 boot
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
References: <20200818141554.13945-1-rppt@kernel.org>
 <20200818141554.13945-7-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <03ec586d-c00c-c57e-3118-7186acb7b823@redhat.com>
Date:   Wed, 19 Aug 2020 12:49:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818141554.13945-7-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18.08.20 16:15, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Taking pages out from the direct map and bringing them back may create
> undesired fragmentation and usage of the smaller pages in the direct
> mapping of the physical memory.
> 
> This can be avoided if a significantly large area of the physical memory
> would be reserved for secretmem purposes at boot time.
> 
> Add ability to reserve physical memory for secretmem at boot time using
> "secretmem" kernel parameter and then use that reserved memory as a global
> pool for secret memory needs.

Wouldn't something like CMA be the better fit? Just wondering. Then, the
memory can actually be reused for something else while not needed.

> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/secretmem.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 126 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 333eb18fb483..54067ea62b2d 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -14,6 +14,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/genalloc.h>
>  #include <linux/syscalls.h>
> +#include <linux/memblock.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/set_memory.h>
>  #include <linux/sched/signal.h>
> @@ -45,6 +46,39 @@ struct secretmem_ctx {
>  	unsigned int mode;
>  };
>  
> +struct secretmem_pool {
> +	struct gen_pool *pool;
> +	unsigned long reserved_size;
> +	void *reserved;
> +};
> +
> +static struct secretmem_pool secretmem_pool;
> +
> +static struct page *secretmem_alloc_huge_page(gfp_t gfp)
> +{
> +	struct gen_pool *pool = secretmem_pool.pool;
> +	unsigned long addr = 0;
> +	struct page *page = NULL;
> +
> +	if (pool) {
> +		if (gen_pool_avail(pool) < PMD_SIZE)
> +			return NULL;
> +
> +		addr = gen_pool_alloc(pool, PMD_SIZE);
> +		if (!addr)
> +			return NULL;
> +
> +		page = virt_to_page(addr);
> +	} else {
> +		page = alloc_pages(gfp, PMD_PAGE_ORDER);
> +
> +		if (page)
> +			split_page(page, PMD_PAGE_ORDER);
> +	}
> +
> +	return page;
> +}
> +
>  static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>  {
>  	unsigned long nr_pages = (1 << PMD_PAGE_ORDER);
> @@ -53,12 +87,11 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>  	struct page *page;
>  	int err;
>  
> -	page = alloc_pages(gfp, PMD_PAGE_ORDER);
> +	page = secretmem_alloc_huge_page(gfp);
>  	if (!page)
>  		return -ENOMEM;
>  
>  	addr = (unsigned long)page_address(page);
> -	split_page(page, PMD_PAGE_ORDER);
>  
>  	err = gen_pool_add(pool, addr, PMD_SIZE, NUMA_NO_NODE);
>  	if (err) {
> @@ -267,11 +300,13 @@ SYSCALL_DEFINE1(memfd_secret, unsigned long, flags)
>  	return err;
>  }
>  
> -static void secretmem_cleanup_chunk(struct gen_pool *pool,
> -				    struct gen_pool_chunk *chunk, void *data)
> +static void secretmem_recycle_range(unsigned long start, unsigned long end)
> +{
> +	gen_pool_free(secretmem_pool.pool, start, PMD_SIZE);
> +}
> +
> +static void secretmem_release_range(unsigned long start, unsigned long end)
>  {
> -	unsigned long start = chunk->start_addr;
> -	unsigned long end = chunk->end_addr;
>  	unsigned long nr_pages, addr;
>  
>  	nr_pages = (end - start + 1) / PAGE_SIZE;
> @@ -281,6 +316,18 @@ static void secretmem_cleanup_chunk(struct gen_pool *pool,
>  		put_page(virt_to_page(addr));
>  }
>  
> +static void secretmem_cleanup_chunk(struct gen_pool *pool,
> +				    struct gen_pool_chunk *chunk, void *data)
> +{
> +	unsigned long start = chunk->start_addr;
> +	unsigned long end = chunk->end_addr;
> +
> +	if (secretmem_pool.pool)
> +		secretmem_recycle_range(start, end);
> +	else
> +		secretmem_release_range(start, end);
> +}
> +
>  static void secretmem_cleanup_pool(struct secretmem_ctx *ctx)
>  {
>  	struct gen_pool *pool = ctx->pool;
> @@ -320,14 +367,85 @@ static struct file_system_type secretmem_fs = {
>  	.kill_sb	= kill_anon_super,
>  };
>  
> +static int secretmem_reserved_mem_init(void)
> +{
> +	struct gen_pool *pool;
> +	struct page *page;
> +	void *addr;
> +	int err;
> +
> +	if (!secretmem_pool.reserved)
> +		return 0;
> +
> +	pool = gen_pool_create(PMD_SHIFT, NUMA_NO_NODE);
> +	if (!pool)
> +		return -ENOMEM;
> +
> +	err = gen_pool_add(pool, (unsigned long)secretmem_pool.reserved,
> +			   secretmem_pool.reserved_size, NUMA_NO_NODE);
> +	if (err)
> +		goto err_destroy_pool;
> +
> +	for (addr = secretmem_pool.reserved;
> +	     addr < secretmem_pool.reserved + secretmem_pool.reserved_size;
> +	     addr += PAGE_SIZE) {
> +		page = virt_to_page(addr);
> +		__ClearPageReserved(page);
> +		set_page_count(page, 1);
> +	}
> +
> +	secretmem_pool.pool = pool;
> +	page = virt_to_page(secretmem_pool.reserved);
> +	__kernel_map_pages(page, secretmem_pool.reserved_size / PAGE_SIZE, 0);
> +	return 0;
> +
> +err_destroy_pool:
> +	gen_pool_destroy(pool);
> +	return err;
> +}
> +
>  static int secretmem_init(void)
>  {
> -	int ret = 0;
> +	int ret;
> +
> +	ret = secretmem_reserved_mem_init();
> +	if (ret)
> +		return ret;
>  
>  	secretmem_mnt = kern_mount(&secretmem_fs);
> -	if (IS_ERR(secretmem_mnt))
> +	if (IS_ERR(secretmem_mnt)) {
> +		gen_pool_destroy(secretmem_pool.pool);
>  		ret = PTR_ERR(secretmem_mnt);
> +	}
>  
>  	return ret;
>  }
>  fs_initcall(secretmem_init);
> +
> +static int __init secretmem_setup(char *str)
> +{
> +	phys_addr_t align = PMD_SIZE;
> +	unsigned long reserved_size;
> +	void *reserved;
> +
> +	reserved_size = memparse(str, NULL);
> +	if (!reserved_size)
> +		return 0;
> +
> +	if (reserved_size * 2 > PUD_SIZE)
> +		align = PUD_SIZE;
> +
> +	reserved = memblock_alloc(reserved_size, align);
> +	if (!reserved) {
> +		pr_err("failed to reserve %lu bytes\n", secretmem_pool.reserved_size);
> +		return 0;
> +	}
> +
> +	secretmem_pool.reserved_size = reserved_size;
> +	secretmem_pool.reserved = reserved;
> +
> +	pr_info("reserved %luM\n", reserved_size >> 20);
> +
> +	return 1;
> +}
> +__setup("secretmem=", secretmem_setup);
> 


-- 
Thanks,

David / dhildenb

