Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6601D303C06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 12:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405437AbhAZLr6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 06:47:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:43692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405076AbhAZLrs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:47:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611661619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X81IYN5y/8BMmeU8/Rgh30d0tqPTvK6kqEf1fYUDV3w=;
        b=sq1leGL022ICcKNl09OvlD5U/wIWaeG6SUVpxeOJLIMfsr+7ogWgg4bN/WP0jD4PC9nAhS
        EpYmIjwliqX/XIgVw4TD/owfGJdXRmjwzlmBuErtuQnoie6ip/iUIODAbFepqzB1YsT4M0
        JyOrOHB3FHdTc42wuzD1Is/XjiOGpQM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F652AD24;
        Tue, 26 Jan 2021 11:46:58 +0000 (UTC)
Date:   Tue, 26 Jan 2021 12:46:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20210126114657.GL827@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-8-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121122723.3446-8-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-01-21 14:27:19, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Removing a PAGE_SIZE page from the direct map every time such page is
> allocated for a secret memory mapping will cause severe fragmentation of
> the direct map. This fragmentation can be reduced by using PMD-size pages
> as a pool for small pages for secret memory mappings.
> 
> Add a gen_pool per secretmem inode and lazily populate this pool with
> PMD-size pages.
> 
> As pages allocated by secretmem become unmovable, use CMA to back large
> page caches so that page allocator won't be surprised by failing attempt to
> migrate these pages.
> 
> The CMA area used by secretmem is controlled by the "secretmem=" kernel
> parameter. This allows explicit control over the memory available for
> secretmem and provides upper hard limit for secretmem consumption.

OK, so I have finally had a look at this closer and this is really not
acceptable. I have already mentioned that in a response to other patch
but any task is able to deprive access to secret memory to other tasks
and cause OOM killer which wouldn't really recover ever and potentially
panic the system. Now you could be less drastic and only make SIGBUS on
fault but that would be still quite terrible. There is a very good
reason why hugetlb implements is non-trivial reservation system to avoid
exactly these problems.

So unless I am really misreading the code
Nacked-by: Michal Hocko <mhocko@suse.com>

That doesn't mean I reject the whole idea. There are some details to
sort out as mentioned elsewhere but you cannot really depend on
pre-allocated pool which can fail at a fault time like that.

> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: Hagen Paul Pfeifer <hagen@jauu.net>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tycho Andersen <tycho@tycho.ws>
> Cc: Will Deacon <will@kernel.org>
> ---
>  mm/Kconfig     |   2 +
>  mm/secretmem.c | 175 +++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 150 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 5f8243442f66..ec35bf406439 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -874,5 +874,7 @@ config KMAP_LOCAL
>  
>  config SECRETMEM
>  	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
> +	select GENERIC_ALLOCATOR
> +	select CMA
>  
>  endmenu
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 904351d12c33..469211c7cc3a 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -7,12 +7,15 @@
>  
>  #include <linux/mm.h>
>  #include <linux/fs.h>
> +#include <linux/cma.h>
>  #include <linux/mount.h>
>  #include <linux/memfd.h>
>  #include <linux/bitops.h>
>  #include <linux/printk.h>
>  #include <linux/pagemap.h>
> +#include <linux/genalloc.h>
>  #include <linux/syscalls.h>
> +#include <linux/memblock.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/secretmem.h>
>  #include <linux/set_memory.h>
> @@ -35,24 +38,94 @@
>  #define SECRETMEM_FLAGS_MASK	SECRETMEM_MODE_MASK
>  
>  struct secretmem_ctx {
> +	struct gen_pool *pool;
>  	unsigned int mode;
>  };
>  
> -static struct page *secretmem_alloc_page(gfp_t gfp)
> +static struct cma *secretmem_cma;
> +
> +static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>  {
> +	unsigned long nr_pages = (1 << PMD_PAGE_ORDER);
> +	struct gen_pool *pool = ctx->pool;
> +	unsigned long addr;
> +	struct page *page;
> +	int i, err;
> +
> +	page = cma_alloc(secretmem_cma, nr_pages, PMD_SIZE, gfp & __GFP_NOWARN);
> +	if (!page)
> +		return -ENOMEM;
> +
>  	/*
> -	 * FIXME: use a cache of large pages to reduce the direct map
> -	 * fragmentation
> +	 * clear the data left from the prevoius user before dropping the
> +	 * pages from the direct map
>  	 */
> -	return alloc_page(gfp | __GFP_ZERO);
> +	for (i = 0; i < nr_pages; i++)
> +		clear_highpage(page + i);
> +
> +	err = set_direct_map_invalid_noflush(page, nr_pages);
> +	if (err)
> +		goto err_cma_release;
> +
> +	addr = (unsigned long)page_address(page);
> +	err = gen_pool_add(pool, addr, PMD_SIZE, NUMA_NO_NODE);
> +	if (err)
> +		goto err_set_direct_map;
> +
> +	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> +
> +	return 0;
> +
> +err_set_direct_map:
> +	/*
> +	 * If a split of PUD-size page was required, it already happened
> +	 * when we marked the pages invalid which guarantees that this call
> +	 * won't fail
> +	 */
> +	set_direct_map_default_noflush(page, nr_pages);
> +err_cma_release:
> +	cma_release(secretmem_cma, page, nr_pages);
> +	return err;
> +}
> +
> +static void secretmem_free_page(struct secretmem_ctx *ctx, struct page *page)
> +{
> +	unsigned long addr = (unsigned long)page_address(page);
> +	struct gen_pool *pool = ctx->pool;
> +
> +	gen_pool_free(pool, addr, PAGE_SIZE);
> +}
> +
> +static struct page *secretmem_alloc_page(struct secretmem_ctx *ctx,
> +					 gfp_t gfp)
> +{
> +	struct gen_pool *pool = ctx->pool;
> +	unsigned long addr;
> +	struct page *page;
> +	int err;
> +
> +	if (gen_pool_avail(pool) < PAGE_SIZE) {
> +		err = secretmem_pool_increase(ctx, gfp);
> +		if (err)
> +			return NULL;
> +	}
> +
> +	addr = gen_pool_alloc(pool, PAGE_SIZE);
> +	if (!addr)
> +		return NULL;
> +
> +	page = virt_to_page(addr);
> +	get_page(page);
> +
> +	return page;
>  }
>  
>  static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  {
> +	struct secretmem_ctx *ctx = vmf->vma->vm_file->private_data;
>  	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
>  	pgoff_t offset = vmf->pgoff;
> -	unsigned long addr;
>  	struct page *page;
>  	int err;
>  
> @@ -62,40 +135,25 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  retry:
>  	page = find_lock_page(mapping, offset);
>  	if (!page) {
> -		page = secretmem_alloc_page(vmf->gfp_mask);
> +		page = secretmem_alloc_page(ctx, vmf->gfp_mask);
>  		if (!page)
>  			return VM_FAULT_OOM;
>  
> -		err = set_direct_map_invalid_noflush(page, 1);
> -		if (err) {
> -			put_page(page);
> -			return vmf_error(err);
> -		}
> -
>  		__SetPageUptodate(page);
>  		err = add_to_page_cache(page, mapping, offset, vmf->gfp_mask);
>  		if (unlikely(err)) {
> +			secretmem_free_page(ctx, page);
>  			put_page(page);
>  			if (err == -EEXIST)
>  				goto retry;
> -			goto err_restore_direct_map;
> +			return vmf_error(err);
>  		}
>  
> -		addr = (unsigned long)page_address(page);
> -		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +		set_page_private(page, (unsigned long)ctx);
>  	}
>  
>  	vmf->page = page;
>  	return VM_FAULT_LOCKED;
> -
> -err_restore_direct_map:
> -	/*
> -	 * If a split of large page was required, it already happened
> -	 * when we marked the page invalid which guarantees that this call
> -	 * won't fail
> -	 */
> -	set_direct_map_default_noflush(page, 1);
> -	return vmf_error(err);
>  }
>  
>  static const struct vm_operations_struct secretmem_vm_ops = {
> @@ -141,8 +199,9 @@ static int secretmem_migratepage(struct address_space *mapping,
>  
>  static void secretmem_freepage(struct page *page)
>  {
> -	set_direct_map_default_noflush(page, 1);
> -	clear_highpage(page);
> +	struct secretmem_ctx *ctx = (struct secretmem_ctx *)page_private(page);
> +
> +	secretmem_free_page(ctx, page);
>  }
>  
>  static const struct address_space_operations secretmem_aops = {
> @@ -177,13 +236,18 @@ static struct file *secretmem_file_create(unsigned long flags)
>  	if (!ctx)
>  		goto err_free_inode;
>  
> +	ctx->pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> +	if (!ctx->pool)
> +		goto err_free_ctx;
> +
>  	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
>  				 O_RDWR, &secretmem_fops);
>  	if (IS_ERR(file))
> -		goto err_free_ctx;
> +		goto err_free_pool;
>  
>  	mapping_set_unevictable(inode->i_mapping);
>  
> +	inode->i_private = ctx;
>  	inode->i_mapping->private_data = ctx;
>  	inode->i_mapping->a_ops = &secretmem_aops;
>  
> @@ -197,6 +261,8 @@ static struct file *secretmem_file_create(unsigned long flags)
>  
>  	return file;
>  
> +err_free_pool:
> +	gen_pool_destroy(ctx->pool);
>  err_free_ctx:
>  	kfree(ctx);
>  err_free_inode:
> @@ -215,6 +281,9 @@ SYSCALL_DEFINE1(memfd_secret, unsigned long, flags)
>  	if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
>  		return -EINVAL;
>  
> +	if (!secretmem_cma)
> +		return -ENOMEM;
> +
>  	fd = get_unused_fd_flags(flags & O_CLOEXEC);
>  	if (fd < 0)
>  		return fd;
> @@ -235,11 +304,37 @@ SYSCALL_DEFINE1(memfd_secret, unsigned long, flags)
>  	return err;
>  }
>  
> +static void secretmem_cleanup_chunk(struct gen_pool *pool,
> +				    struct gen_pool_chunk *chunk, void *data)
> +{
> +	unsigned long start = chunk->start_addr;
> +	unsigned long end = chunk->end_addr;
> +	struct page *page = virt_to_page(start);
> +	unsigned long nr_pages = (end - start + 1) / PAGE_SIZE;
> +	int i;
> +
> +	set_direct_map_default_noflush(page, nr_pages);
> +
> +	for (i = 0; i < nr_pages; i++)
> +		clear_highpage(page + i);
> +
> +	cma_release(secretmem_cma, page, nr_pages);
> +}
> +
> +static void secretmem_cleanup_pool(struct secretmem_ctx *ctx)
> +{
> +	struct gen_pool *pool = ctx->pool;
> +
> +	gen_pool_for_each_chunk(pool, secretmem_cleanup_chunk, ctx);
> +	gen_pool_destroy(pool);
> +}
> +
>  static void secretmem_evict_inode(struct inode *inode)
>  {
>  	struct secretmem_ctx *ctx = inode->i_private;
>  
>  	truncate_inode_pages_final(&inode->i_data);
> +	secretmem_cleanup_pool(ctx);
>  	clear_inode(inode);
>  	kfree(ctx);
>  }
> @@ -276,3 +371,29 @@ static int secretmem_init(void)
>  	return ret;
>  }
>  fs_initcall(secretmem_init);
> +
> +static int __init secretmem_setup(char *str)
> +{
> +	phys_addr_t align = PMD_SIZE;
> +	unsigned long reserved_size;
> +	int err;
> +
> +	reserved_size = memparse(str, NULL);
> +	if (!reserved_size)
> +		return 0;
> +
> +	if (reserved_size * 2 > PUD_SIZE)
> +		align = PUD_SIZE;
> +
> +	err = cma_declare_contiguous(0, reserved_size, 0, align, 0, false,
> +				     "secretmem", &secretmem_cma);
> +	if (err) {
> +		pr_err("failed to create CMA: %d\n", err);
> +		return err;
> +	}
> +
> +	pr_info("reserved %luM\n", reserved_size >> 20);
> +
> +	return 0;
> +}
> +__setup("secretmem=", secretmem_setup);
> -- 
> 2.28.0
> 

-- 
Michal Hocko
SUSE Labs
