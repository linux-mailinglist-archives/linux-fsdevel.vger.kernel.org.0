Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0CB6237BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 00:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiKIXyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 18:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiKIXya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:54:30 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A101E3CC;
        Wed,  9 Nov 2022 15:54:29 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p21so152638plr.7;
        Wed, 09 Nov 2022 15:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=svbokUsTGvaKrPTYe+iV+83WUpl4LfGM9newrGHW2AY=;
        b=NVJifqN9d/MXVsGOlKMwco45aTS6zns93fkFsZShX9ZakBfRXR6BgRtsfuWoo/nYjq
         Yh1+8777EkMrFbzOSF0trrWXepsvxK9UHYJ6z3eqXQvtTV2kJ5s3iBLSyTkeiVioDz/e
         XoJyGUaCRJbVvTIGht8jZSwfI/Zc6k+aFn9XEV+ZQMb0uxK0qeb5UxHU6aFYQdqDl+vS
         n0rkWkRLu9XENITtJL4BlxBWeVQKebZXYnDcdBCwnTHMQS3hlOBDENGsK1aNmgwIednE
         tm518RU7jeTzZmOAwl8dS/n8W/8RLsSBOlxBYJxGpDpu0FyIc7vEm9CNUV1qOmHG5xGo
         u1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svbokUsTGvaKrPTYe+iV+83WUpl4LfGM9newrGHW2AY=;
        b=vBGvqLo/OCsYB5YGHdoolI37zT97hum31V6S+AASOrX/1OV/SPn/ZPPlgFUuKThnCH
         1QK1ZEkUFu8vuv/E1PYunx5Fq+yHhshyONMobCzojIj7iMDcANLx5S8H61om9516lDzD
         UFm2N1wHg7w+a6dyy5jhyTfiqvHSmDS29PNtNxhUQzzTaesRx0NzxXkeXDnulY8tUOnq
         tqZin2uuMj5uwEpxTEOglpUIMjkuTCbKvXW30qsTPSZ1mZjNTapF40XONP9ZBvEFlPaj
         8aVW50454gHqCLTZbDej5P/GqfRCRcwFOy6jwFPK7SeQe8oLKqiInuDxiAeU6zyGwtuD
         z32Q==
X-Gm-Message-State: ACrzQf3wGJr5v4RCWrDj4azmTofOH3dbZWewMp4QRN4lxMgrF/Ls5utS
        DiWWK63YRfcsGiR/ZjLvvS0=
X-Google-Smtp-Source: AMsMyM7D3r025gafHPKVPQGDKYgSA7UYST+0IdiwK3iAeEhbEXKL7jeVlwMhxRs4ZWAd6LrKzl22ug==
X-Received: by 2002:a17:90a:c398:b0:214:6fd:90df with SMTP id h24-20020a17090ac39800b0021406fd90dfmr1226415pjt.35.1668038068786;
        Wed, 09 Nov 2022 15:54:28 -0800 (PST)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id ij22-20020a170902ab5600b0017f36638010sm9576409plb.276.2022.11.09.15.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 15:54:27 -0800 (PST)
Date:   Wed, 9 Nov 2022 15:54:25 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zach O'Keefe <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Paul Gofman <pgofman@codeweavers.com>
Subject: Re: [PATCH v6 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y2w9sWZf5mlNV7Z3@gmail.com>
References: <20221109102303.851281-1-usama.anjum@collabora.com>
 <20221109102303.851281-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20221109102303.851281-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

Here are a few inline comments.

On Wed, Nov 09, 2022 at 03:23:02PM +0500, Muhammad Usama Anjum wrote:
> This IOCTL, PAGEMAP_SCAN can be used to get and/or clear the info about
> page table entries. The following operations are supported in this ioctl:
> - Get the information if the pages are soft-dirty, file mapped, present
>   or swapped.
> - Clear the soft-dirty PTE bit of the pages.
> - Get and clear the soft-dirty PTE bit of the pages.
> 
> Only the soft-dirty bit can be read and cleared atomically. struct
> pagemap_sd_args is used as the argument of the IOCTL. In this struct:
> - The range is specified through start and len.
> - The output buffer and size is specified as vec and vec_len.
> - The optional maximum requested pages are specified in the max_pages.
> - The flags can be specified in the flags field. The PAGEMAP_SD_CLEAR
>   and PAGEMAP_SD_NO_REUSED_REGIONS are supported.
> - The masks are specified in rmask, amask, emask and return_mask.
> 
> This IOCTL can be extended to get information about more PTE bits.
> 
> This is based on a patch from Gabriel Krisman Bertazi.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in v6:
> - Rename variables and update comments
> - Make IOCTL independent of soft_dirty config
> - Change masks and bitmap type to _u64
> - Improve code quality
> 
> Changes in v5:
> - Remove tlb flushing even for clear operation
> 
> Changes in v4:
> - Update the interface and implementation
> 
> Changes in v3:
> - Tighten the user-kernel interface by using explicit types and add more
>   error checking
> 
> Changes in v2:
> - Convert the interface from syscall to ioctl
> - Remove pidfd support as it doesn't make sense in ioctl
> ---
>  fs/proc/task_mmu.c            | 328 ++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fs.h       |  56 ++++++
>  tools/include/uapi/linux/fs.h |  56 ++++++
>  3 files changed, 440 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 8235c536ac70..8d6a84ec5ef7 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -19,6 +19,9 @@
>  #include <linux/shmem_fs.h>
>  #include <linux/uaccess.h>
>  #include <linux/pkeys.h>
> +#include <uapi/linux/fs.h>
> +#include <linux/vmalloc.h>
> +#include <linux/minmax.h>
>  
>  #include <asm/elf.h>
>  #include <asm/tlb.h>
> @@ -1775,11 +1778,336 @@ static int pagemap_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +#define PAGEMAP_OP_MASK		(PAGE_IS_SOFTDIRTY | PAGE_IS_FILE |	\
> +				 PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
> +#define PAGEMAP_NONSD_OP_MASK	(PAGE_IS_FILE |	PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
> +#define PAGEMAP_SD_FLAGS	(PAGEMAP_SOFTDIRTY_CLEAR | PAGEMAP_NO_REUSED_REGIONS)
> +#define IS_CLEAR_OP(a)		(a->flags & PAGEMAP_SOFTDIRTY_CLEAR)
> +#define IS_GET_OP(a)		(a->vec)
> +#define IS_SD_OP(a)		(a->flags & PAGEMAP_SD_FLAGS)
> +
> +struct pagemap_scan_private {
> +	struct page_region *vec;
> +	unsigned long vec_len;
> +	unsigned long vec_index;
> +	unsigned int max_pages;
> +	unsigned int found_pages;
> +	unsigned int flags;
> +	unsigned long required_mask;
> +	unsigned long anyof_mask;
> +	unsigned long excluded_mask;
> +	unsigned long return_mask;
> +};
> +
> +static int pagemap_scan_pmd_test_walk(unsigned long start, unsigned long end, struct mm_walk *walk)
> +{
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +
> +	if (IS_GET_OP(p) && p->max_pages && (p->found_pages == p->max_pages))
> +		return -1;
> +
> +	if (vma->vm_flags & VM_PFNMAP)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int add_to_out(bool sd, bool file, bool pres, bool swap, struct pagemap_scan_private *p,
> +		      unsigned long addr, unsigned int len)
> +{
> +	unsigned long bitmap, cur = sd | file << 1 | pres << 2 | swap << 3;

Should we define contants for each of these bits?

> +	bool cpy = true;
> +
> +	if (p->required_mask)
> +		cpy = ((p->required_mask & cur) == p->required_mask);
> +	if (cpy && p->anyof_mask)
> +		cpy = (p->anyof_mask & cur);
> +	if (cpy && p->excluded_mask)
> +		cpy = !(p->excluded_mask & cur);
> +
> +	bitmap = cur & p->return_mask;
> +
> +	if (cpy && bitmap) {
> +		if ((p->vec_index) && (p->vec[p->vec_index - 1].bitmap == bitmap) &&
> +		    (p->vec[p->vec_index - 1].start + p->vec[p->vec_index - 1].len * PAGE_SIZE ==
> +		     addr)) {

I think it is better to define a variable for p->vec_index - 1.
nit: len can be in bytes rather than pages.

> +			p->vec[p->vec_index - 1].len += len;
> +			p->found_pages += len;
> +		} else if (p->vec_index < p->vec_len) {
> +			p->vec[p->vec_index].start = addr;
> +			p->vec[p->vec_index].len = len;
> +			p->found_pages += len;
> +			p->vec[p->vec_index].bitmap = bitmap;
> +			p->vec_index++;
> +		} else {
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long addr,
> +				  unsigned long end, struct mm_walk *walk)
> +{
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	unsigned int len;
> +	spinlock_t *ptl;
> +	int ret = 0;
> +	pte_t *pte;
> +	bool dirty_vma = (p->flags & PAGEMAP_NO_REUSED_REGIONS) ?
> +			 (false) : (vma->vm_flags & VM_SOFTDIRTY);
> +
> +	if ((walk->vma->vm_end < addr) || (p->max_pages && p->found_pages == p->max_pages))
> +		return 0;
> +
> +	end = min(end, walk->vma->vm_end);
> +
> +	ptl = pmd_trans_huge_lock(pmd, vma);
> +	if (ptl) {
> +		if (dirty_vma || check_soft_dirty_pmd(vma, addr, pmd, false)) {
> +			/*
> +			 * Break huge page into small pages if operation needs to be performed is
> +			 * on a portion of the huge page or the return buffer cannot store complete
> +			 * data.
> +			 */
> +			if ((IS_CLEAR_OP(p) && (end - addr < HPAGE_SIZE))) {
> +				spin_unlock(ptl);
> +				split_huge_pmd(vma, pmd, addr);
> +				goto process_smaller_pages;
> +			}
> +
> +			if (IS_GET_OP(p)) {
> +				len = (end - addr)/PAGE_SIZE;
> +				if (p->max_pages && p->found_pages + len > p->max_pages)
> +					len = p->max_pages - p->found_pages;
> +
> +				ret = add_to_out(dirty_vma ||
> +						 check_soft_dirty_pmd(vma, addr, pmd, false),

can we reuse a return code of the previous call of check_soft_dirty_pmd?

> +						 vma->vm_file, pmd_present(*pmd), is_swap_pmd(*pmd),
> +						 p, addr, len);
> +			}
> +			if (!ret && IS_CLEAR_OP(p))
> +				check_soft_dirty_pmd(vma, addr, pmd, true);

should we return a error in this case? We need to be sure that:
* we stop waking page tables after this point.
* return this error to the user-space if we are not able to add anything
  in the vector.

> +		}
> +		spin_unlock(ptl);
> +		return 0;
> +	}
> +
> +process_smaller_pages:
> +	if (pmd_trans_unstable(pmd))
> +		return 0;
> +
> +	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +	for (; addr < end && !ret && (!p->max_pages || (p->found_pages < p->max_pages))
> +	     ; pte++, addr += PAGE_SIZE) {
> +		if (IS_GET_OP(p))
> +			ret = add_to_out(dirty_vma || check_soft_dirty(vma, addr, pte, false),
> +					 vma->vm_file, pte_present(*pte),
> +					 is_swap_pte(*pte), p, addr, 1);
> +		if (!ret && IS_CLEAR_OP(p))
> +			check_soft_dirty(vma, addr, pte, true);
> +	}
> +	pte_unmap_unlock(pte - 1, ptl);
> +	cond_resched();
> +
> +	return 0;
> +}
> +
> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end, int depth,
> +				 struct mm_walk *walk)
> +{
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	unsigned int len;
> +	bool sd;
> +
> +	if (vma) {
> +		/* Individual pages haven't been allocated and written */
> +		sd = (p->flags & PAGEMAP_NO_REUSED_REGIONS) ? (false) :
> +		     (vma->vm_flags & VM_SOFTDIRTY);
> +
> +		len = (end - addr)/PAGE_SIZE;
> +		if (p->max_pages && p->found_pages + len > p->max_pages)
> +			len = p->max_pages - p->found_pages;
> +
> +		add_to_out(sd, vma->vm_file, false, false, p, addr, len);
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_MEM_SOFT_DIRTY
> +static int pagemap_scan_pre_vma(unsigned long start, unsigned long end, struct mm_walk *walk)
> +{
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	unsigned long end_cut = end;
> +	int ret;
> +
> +	if (!(p->flags & PAGEMAP_NO_REUSED_REGIONS) && IS_CLEAR_OP(p) &&
> +	    (vma->vm_flags & VM_SOFTDIRTY)) {
> +		if (vma->vm_start < start) {
> +			ret = split_vma(vma->vm_mm, vma, start, 1);
> +			if (ret)
> +				return ret;
> +		}
> +		/* Calculate end_cut because of max_pages */
> +		if (IS_GET_OP(p) && p->max_pages)
> +			end_cut = min(start + (p->max_pages - p->found_pages) * PAGE_SIZE, end);
> +
> +		if (vma->vm_end > end_cut) {
> +			ret = split_vma(vma->vm_mm, vma, end_cut, 0);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void pagemap_scan_post_vma(struct mm_walk *walk)
> +{
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +
> +	if (!(p->flags & PAGEMAP_NO_REUSED_REGIONS) && IS_CLEAR_OP(p) &&
> +	    (vma->vm_flags & VM_SOFTDIRTY)) {
> +		vma->vm_flags &= ~VM_SOFTDIRTY;
> +		vma_set_page_prot(vma);
> +	}
> +}
> +#endif /* CONFIG_MEM_SOFT_DIRTY */
> +
> +static const struct mm_walk_ops pagemap_scan_ops = {
> +	.test_walk = pagemap_scan_pmd_test_walk,
> +	.pmd_entry = pagemap_scan_pmd_entry,
> +	.pte_hole = pagemap_scan_pte_hole,
> +
> +#ifdef CONFIG_MEM_SOFT_DIRTY
> +	/* Only for clearing SD bit over VMAs */
> +	.pre_vma = pagemap_scan_pre_vma,
> +	.post_vma = pagemap_scan_post_vma,
> +#endif /* CONFIG_MEM_SOFT_DIRTY */
> +};
> +
> +static long do_pagemap_sd_cmd(struct mm_struct *mm, struct pagemap_scan_arg *arg)
> +{
> +	struct mmu_notifier_range range;
> +	unsigned long __user start, end;
> +	struct pagemap_scan_private p;
> +	int ret;
> +
> +	start = (unsigned long)untagged_addr(arg->start);
> +	if ((!IS_ALIGNED(start, PAGE_SIZE)) || (!access_ok((void __user *)start, arg->len)))
> +		return -EINVAL;
> +
> +	if (IS_GET_OP(arg) &&
> +	    ((arg->vec_len == 0) || (!access_ok((struct page_region *)arg->vec, arg->vec_len))))
> +		return -ENOMEM;
> +
> +#ifndef CONFIG_MEM_SOFT_DIRTY
> +	if (IS_SD_OP(arg) || (arg->required_mask & PAGE_IS_SOFTDIRTY) ||
> +	    (arg->anyof_mask & PAGE_IS_SOFTDIRTY))
> +		return -EINVAL;
> +#endif
> +
> +	if ((arg->flags & ~PAGEMAP_SD_FLAGS) || (arg->required_mask & ~PAGEMAP_OP_MASK) ||
> +	    (arg->anyof_mask & ~PAGEMAP_OP_MASK) || (arg->excluded_mask & ~PAGEMAP_OP_MASK) ||
> +	    (arg->return_mask & ~PAGEMAP_OP_MASK))
> +		return -EINVAL;
> +
> +	if ((!arg->required_mask && !arg->anyof_mask && !arg->excluded_mask) || !arg->return_mask)
> +		return -EINVAL;
> +
> +	if (IS_SD_OP(arg) && ((arg->required_mask & PAGEMAP_NONSD_OP_MASK) ||
> +	     (arg->anyof_mask & PAGEMAP_NONSD_OP_MASK)))
> +		return -EINVAL;
> +
> +	end = start + arg->len;
> +	p.max_pages = arg->max_pages;
> +	p.found_pages = 0;
> +	p.flags = arg->flags;
> +	p.required_mask = arg->required_mask;
> +	p.anyof_mask = arg->anyof_mask;
> +	p.excluded_mask = arg->excluded_mask;
> +	p.return_mask = arg->return_mask;
> +	p.vec_index = 0;
> +	p.vec_len = arg->vec_len;
> +
> +	if (IS_GET_OP(arg)) {
> +		p.vec = vzalloc(arg->vec_len * sizeof(struct page_region));

I think we need to set a reasonable limit for vec_len to avoid large
allocations on the kernel. We can consider to use kmalloc or kvmalloc
here.

Thanks,
Andrei
