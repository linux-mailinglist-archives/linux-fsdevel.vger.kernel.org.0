Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B76167EC97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 18:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjA0Rha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 12:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjA0Rh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:37:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795637C700
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 09:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674841006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8fesrJI7dLSow2JQ+uByqGD/Cl3UGWC2eB7ulTUJmf0=;
        b=e/dSLKV/83AAhnTvlIJLok0lz8RXlds4ViEEL6KCbXg6PB83u10tSpKtPdpL0T/QgNvaQq
        kC+JRx+SaeW81ufmZYcGk7uuhy0qg8sJtYBRAFfE56c3ka7V3H9SudnwLDvHUegCg53EEw
        Fnw1nXRqKlEsLDbCQGVq8nVXXiWwTco=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-180-ZwSw8JrJMFuL7kn658onIA-1; Fri, 27 Jan 2023 12:36:45 -0500
X-MC-Unique: ZwSw8JrJMFuL7kn658onIA-1
Received: by mail-vs1-f71.google.com with SMTP id bg11-20020a056102366b00b003ee879ded02so502436vsb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 09:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fesrJI7dLSow2JQ+uByqGD/Cl3UGWC2eB7ulTUJmf0=;
        b=UUK+Q9wokNrQ8iKp74lD7T0HqTjXvOLkZctq5FbtHpnY5AnWrnl7C2bZR9u5+ndHFJ
         Jm8NXoZOdGhhxQTRgMIKb9Ww7Y/11vvFtUXJS+rXBH8bFdNO5/AFfN0+zkZt5YTr2quk
         GVvUYxXGNubP5BZ5w8fCEGKvsZkl/TA1AaWkeV+b8VZjo9kb/snU3Q+r/Ki9h6z4P27N
         In9d9HqbiDonxGKOc7dQVUTV113z2+gzvxaquhHUHrHbI+awNJ1OVkvjSbcPD6qLW4+N
         c+tlUf5IzQ+NakV0A+DVtB3Eejm2Abc4Ub+cx9qn1s+KjFXtBIYgDOBtALHr6jsQMIrp
         t9/g==
X-Gm-Message-State: AO0yUKV/EY3prQG7RwP32RdRQqErNLiFZSjQ7aPXrV4N3PbF7pmja3Gk
        mMQFK4+rlhSRajYIHajIOz4ptIixvKvkEnpVgEYB0g66rzY5/7dAf9F+iN60NaoJeVCZabJx7i3
        /684MbxaB9wH9sITCt0gxxOuUJg==
X-Received: by 2002:a1f:3297:0:b0:3e9:88d0:50e9 with SMTP id y145-20020a1f3297000000b003e988d050e9mr1756068vky.9.1674841004593;
        Fri, 27 Jan 2023 09:36:44 -0800 (PST)
X-Google-Smtp-Source: AK7set/XDMfg3uN2vdsQqgq8lAF4/2pUxF8HCh0YqrBhPnDeOOLwLbvR+pT4ltBEDNofvPnOaTFSlg==
X-Received: by 2002:a1f:3297:0:b0:3e9:88d0:50e9 with SMTP id y145-20020a1f3297000000b003e988d050e9mr1756054vky.9.1674841004163;
        Fri, 27 Jan 2023 09:36:44 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id c139-20020ae9ed91000000b00704a9942708sm3249793qkg.73.2023.01.27.09.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:36:43 -0800 (PST)
Date:   Fri, 27 Jan 2023 12:36:41 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v8 3/4] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y9QLqY0mQ6eD6Zm+@x1n>
References: <20230124084323.1363825-1-usama.anjum@collabora.com>
 <20230124084323.1363825-4-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230124084323.1363825-4-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:43:22PM +0500, Muhammad Usama Anjum wrote:
> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
> the info about page table entries. The following operations are supported
> in this ioctl:
> - Get the information if the pages have been written-to (PAGE_IS_WT),
>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>   (PAGE_IS_SWAPPED).
> - Write-protect the pages (PAGEMAP_WP_ENGAGE) to start finding which
>   pages have been written-to.
> - Find pages which have been written-to and write protect the pages
>   (atomic PAGE_IS_WT + PAGEMAP_WP_ENGAGE)
> 
> The uffd should have been registered on the memory range before performing
> any WP/WT (Write Protect/Writtern-To) related operations with the IOCTL.
> 
> struct pagemap_scan_args is used as the argument of the IOCTL. In this
> struct:
> - The range is specified through start and len.
> - The output buffer of struct page_region array and size is specified as
>   vec and vec_len.
> - The optional maximum requested pages are specified in the max_pages.
> - The flags can be specified in the flags field. The PAGEMAP_WP_ENGAGE
>   is the only added flag at this time.
> - The masks are specified in required_mask, anyof_mask, excluded_ mask
>   and return_mask.
> 
> This IOCTL can be extended to get information about more PTE bits. This
> IOCTL doesn't support hugetlbs at the moment. No information about
> hugetlb can be obtained. This patch has evolved from a basic patch from
> Gabriel Krisman Bertazi.

I think you mentioned you need hugetlb support, here it says it doesn't.
Which one is true?

> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Change in v8:
> - Correct is_pte_uffd_wp()
> - Improve readability and error checks
> - Remove some un-needed code
> 
> Changes in v7:
> - Rebase on top of latest next
> - Fix some corner cases
> - Base soft-dirty on the uffd wp async
> - Update the terminologies
> - Optimize the memory usage inside the ioctl
> 
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
>  fs/proc/task_mmu.c            | 294 ++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fs.h       |  50 ++++++
>  tools/include/uapi/linux/fs.h |  50 ++++++
>  3 files changed, 394 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e35a0398db63..f9fbda00eb5c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -19,6 +19,7 @@
>  #include <linux/shmem_fs.h>
>  #include <linux/uaccess.h>
>  #include <linux/pkeys.h>
> +#include <linux/minmax.h>
>  
>  #include <asm/elf.h>
>  #include <asm/tlb.h>
> @@ -1135,6 +1136,22 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
>  }
>  #endif
>  
> +static inline bool is_pte_uffd_wp(pte_t pte)
> +{
> +	if ((pte_present(pte) && pte_uffd_wp(pte)) ||
> +	    (is_swap_pte(pte) && pte_swp_uffd_wp_any(pte)))

is_swap_pte() not needed, because pte_swp_uffd_wp_any() covers that.

> +		return true;
> +	return false;
> +}
> +
> +static inline bool is_pmd_uffd_wp(pmd_t pmd)
> +{
> +	if ((pmd_present(pmd) && pmd_uffd_wp(pmd)) ||
> +	    (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd)))
> +		return true;
> +	return false;
> +}
> +
>  #if defined(CONFIG_MEM_SOFT_DIRTY) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
>  static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
>  		unsigned long addr, pmd_t *pmdp)
> @@ -1763,11 +1780,288 @@ static int pagemap_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +#define PAGEMAP_OP_MASK		(PAGE_IS_WT | PAGE_IS_FILE |	\
> +				 PAGE_IS_PRESENT | PAGE_IS_SWAPPED)

The name is confusing.  It's not a mask of OPs, it's a mask of bits that
are supported.

Maybe PAGEMAP_BITS_ALL?

I would also slightly prefer spelling WT out to be PAGE_IS_WRITTEN.

> +#define PAGEMAP_NONWT_OP_MASK	(PAGE_IS_FILE |	PAGE_IS_PRESENT | PAGE_IS_SWAPPED)

Maybe PAGEMAP_BITS_WP_SUPPORTED?

> +#define IS_WP_ENGAGE_OP(a)	(a->flags & PAGEMAP_WP_ENGAGE)
> +#define IS_GET_OP(a)		(a->vec)

Having a->vec to imply the GET is fine, but IMHO not as clean as having
each OP a bit in the flags.

How about:

#define  PAGEMAP_OP_GET       (1UL << 0)
#define  PAGEMAP_OP_WP        (1UL << 1)
#define  PAGEMAP_OP_MASK      (PAGEMAP_OP_GET | PAGEMAP_OP_WP)

?

Then a->vec requried for PAGEMAP_OP_GET.

> +#define PAGEMAP_SCAN_BITMAP(wt, file, present, swap)	\
> +	(wt | file << 1 | present << 2 | swap << 3)
> +#define IS_WT_REQUIRED(a)				\
> +	((a->required_mask & PAGE_IS_WT) ||	\
> +	 (a->anyof_mask & PAGE_IS_WT))
> +#define HAS_NO_SPACE(p)		(p->max_pages && (p->found_pages == p->max_pages))
> +
> +struct pagemap_scan_private {
> +	struct page_region *vec;
> +	struct page_region prev;
> +	unsigned long vec_len, vec_index;
> +	unsigned int max_pages, found_pages, flags;
> +	unsigned long required_mask, anyof_mask, excluded_mask, return_mask;
> +};
> +
> +static int pagemap_scan_test_walk(unsigned long start, unsigned long end, struct mm_walk *walk)
> +{
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +
> +	if (IS_WT_REQUIRED(p) && !userfaultfd_wp(vma) && !userfaultfd_wp_async(vma))
> +		return -EPERM;
> +	if (IS_GET_OP(p) && HAS_NO_SPACE(p))
> +		return -ENOSPC;

As commented before, I think this can be dropped because it should never
trigger.

> +	if (vma->vm_flags & VM_PFNMAP)
> +		return 1;
> +	return 0;
> +}
> +
> +static inline int add_to_out(bool wt, bool file, bool pres, bool swap,

There're too many names that are too general to me.  I suggest some better
one.  For this one, perhaps pagemap_scan_output()?

> +			     struct pagemap_scan_private *p, unsigned long addr, unsigned int len)
> +{
> +	unsigned long bitmap, cur = PAGEMAP_SCAN_BITMAP(wt, file, pres, swap);
> +	bool cpy = true;
> +	struct page_region *prev = &p->prev;
> +
> +	if (HAS_NO_SPACE(p))
> +		return -ENOSPC;

This can be moved to below [1], we should stop scanning immediately if the
condition met.

> +
> +	if (p->required_mask)
> +		cpy = ((p->required_mask & cur) == p->required_mask);
> +	if (cpy && p->anyof_mask)
> +		cpy = (p->anyof_mask & cur);
> +	if (cpy && p->excluded_mask)
> +		cpy = !(p->excluded_mask & cur);
> +	bitmap = cur & p->return_mask;
> +	if (cpy && bitmap) {
> +		if ((prev->len) && (prev->bitmap == bitmap) &&
> +		    (prev->start + prev->len * PAGE_SIZE == addr)) {
> +			prev->len += len;
> +			p->found_pages += len;
> +		} else if (p->vec_index < p->vec_len) {
> +			if (prev->len) {
> +				memcpy(&p->vec[p->vec_index], prev, sizeof(struct page_region));
> +				p->vec_index++;
> +			}
> +			prev->start = addr;
> +			prev->len = len;
> +			prev->bitmap = bitmap;
> +			p->found_pages += len;
> +		} else {
> +			return -ENOSPC;
> +		}

[1]

Here is the only place found_pages got boosted, so checking here only
should be enough, IIUC.

> +	}
> +	return 0;
> +}
> +
> +static inline int export_prev_to_out(struct pagemap_scan_private *p, struct page_region __user *vec,
> +				     unsigned long *vec_index)
> +{
> +	struct page_region *prev = &p->prev;
> +
> +	if (prev->len) {
> +		if (copy_to_user(&vec[*vec_index], prev, sizeof(struct page_region)))
> +			return -EFAULT;
> +		p->vec_index++;
> +		(*vec_index)++;
> +		prev->len = 0;
> +	}
> +	return 0;
> +}
> +
> +static inline int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> +					 unsigned long end, struct mm_walk *walk)
> +{
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	unsigned long addr = end;
> +	unsigned int len;
> +	spinlock_t *ptl;
> +	int ret = 0;
> +	pte_t *pte;
> +	bool pmd_wt;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	ptl = pmd_trans_huge_lock(pmd, vma);
> +	if (ptl) {
> +		pmd_wt = !is_pmd_uffd_wp(*pmd);
> +		/*
> +		 * Break huge page into small pages if operation needs to be performed is
> +		 * on a portion of the huge page or the return buffer cannot store complete
> +		 * data.
> +		 */
> +		if (pmd_wt && (IS_WP_ENGAGE_OP(p) && (end - start < HPAGE_SIZE))) {
> +			spin_unlock(ptl);
> +			split_huge_pmd(vma, pmd, start);
> +			goto process_smaller_pages;
> +		}
> +		if (IS_GET_OP(p)) {
> +			len = (end - start)/PAGE_SIZE;
> +			if (p->max_pages && p->found_pages + len > p->max_pages)
> +				len = p->max_pages - p->found_pages;
> +
> +			ret = add_to_out(pmd_wt, vma->vm_file, pmd_present(*pmd),
> +					 is_swap_pmd(*pmd), p, start, len);
> +			if (ret) {
> +				spin_unlock(ptl);
> +				return ret;
> +			}
> +		}
> +		spin_unlock(ptl);
> +		if (IS_WP_ENGAGE_OP(p) && pmd_wt)
> +			ret = wp_range_async(vma, start, HPAGE_SIZE);
> +		return ret;
> +	}
> +process_smaller_pages:
> +	if (pmd_trans_unstable(pmd))
> +		return 0;
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +	pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
> +	if (IS_GET_OP(p)) {
> +		for (addr = start;
> +		     addr < end && !ret && (!p->max_pages || (p->found_pages < p->max_pages));
> +		     pte++, addr += PAGE_SIZE) {
> +			ret = add_to_out(!is_pte_uffd_wp(*pte), vma->vm_file, pte_present(*pte),
> +					 is_swap_pte(*pte), p, addr, 1);
> +			if (ret)
> +				break;
> +		}
> +	}
> +	pte_unmap_unlock(pte - 1, ptl);
> +	if (!ret && IS_WP_ENGAGE_OP(p))
> +		ret = wp_range_async(vma, start, addr - start);

IIUC you wanted to cover the case where e.g. the output buffer is full or
max_pages specified, so the partial pages still got wr-protected
atomically.

In that case I think we need to at least allow ret==-ENOSPC here.

> +
> +	cond_resched();
> +	return ret;
> +}
> +
> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end, int depth,
> +				 struct mm_walk *walk)
> +{
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	unsigned int len;
> +	int ret = 0;
> +
> +	if (vma) {
> +		len = (end - addr)/PAGE_SIZE;
> +		if (p->max_pages && p->found_pages + len > p->max_pages)
> +			len = p->max_pages - p->found_pages;
> +		ret = add_to_out(false, vma->vm_file, false, false, p, addr, len);
> +	}
> +	return ret;
> +}
> +
> +/* No hugetlb support is present. */
> +static const struct mm_walk_ops pagemap_scan_ops = {
> +	.test_walk = pagemap_scan_test_walk,
> +	.pmd_entry = pagemap_scan_pmd_entry,
> +	.pte_hole = pagemap_scan_pte_hole,
> +};
> +
> +static long do_pagemap_cmd(struct mm_struct *mm, struct pagemap_scan_arg *arg)
> +{
> +	unsigned long empty_slots, vec_index = 0;
> +	unsigned long __user start, end;
> +	unsigned long __start, __end;
> +	struct page_region __user *vec;
> +	struct pagemap_scan_private p;
> +	int ret;
> +
> +	start = (unsigned long)untagged_addr(arg->start);
> +	vec = (struct page_region *)untagged_addr(arg->vec);
> +	if ((!IS_ALIGNED(start, PAGE_SIZE)) || (!access_ok((void __user *)start, arg->len)))
> +		return -EINVAL;
> +	if (IS_GET_OP(arg) && ((arg->vec_len == 0) ||
> +	    (!access_ok((void __user *)vec, arg->vec_len * sizeof(struct page_region)))))
> +		return -ENOMEM;

Is ENOMEM the right error code?  I think -EINVAL seems more proper.

> +	if ((arg->flags & ~PAGEMAP_WP_ENGAGE) || (arg->required_mask & ~PAGEMAP_OP_MASK) ||
> +	    (arg->anyof_mask & ~PAGEMAP_OP_MASK) || (arg->excluded_mask & ~PAGEMAP_OP_MASK) ||
> +	    (arg->return_mask & ~PAGEMAP_OP_MASK))
> +		return -EINVAL;
> +	if (IS_GET_OP(arg) && ((!arg->required_mask && !arg->anyof_mask && !arg->excluded_mask) ||
> +				!arg->return_mask))
> +		return -EINVAL;
> +	/* The non-WT flags cannot be obtained if PAGEMAP_WP_ENGAGE is also specified. */
> +	if (IS_WP_ENGAGE_OP(arg) && ((arg->required_mask & PAGEMAP_NONWT_OP_MASK) ||
> +	    (arg->anyof_mask & PAGEMAP_NONWT_OP_MASK)))
> +		return -EINVAL;

The whole chunk is not very readable.  Some emptly lines would be nice to
have here and there, and some groupings.  No need to keep the condition so
long.  How about something like:

	start = (unsigned long)untagged_addr(arg->start);
	vec = (struct page_region *)untagged_addr(arg->vec);

        /* Detect illegal cmds */
        if ((arg->flags & ~PAGEMAP_OP_MASK))
                return -EINVAL;

        /* Validate common parameters */
	if ((!IS_ALIGNED(start, PAGE_SIZE)) || (!access_ok((void __user *)start, arg->len)))
		return -EINVAL;

        /* Validate parameters for each cmd */
	if (PAGEMAP_OP_GET(arg)) {
                ...
        }

        if (PAGEMAP_OP_WP(arg)) {
                ...
        }

> +
> +	end = start + arg->len;
> +	p.max_pages = arg->max_pages;
> +	p.found_pages = 0;
> +	p.flags = arg->flags;
> +	p.required_mask = arg->required_mask;
> +	p.anyof_mask = arg->anyof_mask;
> +	p.excluded_mask = arg->excluded_mask;
> +	p.return_mask = arg->return_mask;
> +	p.prev.len = 0;
> +	p.vec_len = (PAGEMAP_WALK_SIZE >> PAGE_SHIFT);
> +
> +	if (IS_GET_OP(arg)) {
> +		p.vec = kmalloc_array(p.vec_len, sizeof(struct page_region), GFP_KERNEL);
> +		if (!p.vec)
> +			return -ENOMEM;
> +	} else {
> +		p.vec = NULL;
> +	}
> +	__start = __end = start;
> +	while (__end < end) {
> +		p.vec_index = 0;
> +		empty_slots = arg->vec_len - vec_index;
> +		if (p.vec_len > empty_slots)
> +			p.vec_len = empty_slots;
> +
> +		__end = (__start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK;
> +		if (__end > end)
> +			__end = end;
> +
> +		mmap_read_lock(mm);
> +		ret = walk_page_range(mm, __start, __end, &pagemap_scan_ops, &p);
> +		mmap_read_unlock(mm);
> +		if (!(!ret || ret == -ENOSPC))
> +			goto free_data;
> +
> +		__start = __end;
> +		if (IS_GET_OP(arg) && p.vec_index) {
> +			if (copy_to_user(&vec[vec_index], p.vec,
> +					 p.vec_index * sizeof(struct page_region))) {
> +				ret = -EFAULT;
> +				goto free_data;
> +			}
> +			vec_index += p.vec_index;
> +		}
> +	}
> +	ret = export_prev_to_out(&p, vec, &vec_index);
> +	if (!ret)
> +		ret = vec_index;
> +free_data:
> +	if (IS_GET_OP(arg))
> +		kfree(p.vec);
> +
> +	return ret;
> +}
> +
> +static long pagemap_scan_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct pagemap_scan_arg __user *uarg = (struct pagemap_scan_arg __user *)arg;
> +	struct mm_struct *mm = file->private_data;
> +	struct pagemap_scan_arg argument;
> +
> +	if (cmd == PAGEMAP_SCAN) {
> +		if (copy_from_user(&argument, uarg, sizeof(struct pagemap_scan_arg)))
> +			return -EFAULT;
> +		return do_pagemap_cmd(mm, &argument);
> +	}
> +	return -EINVAL;
> +}
> +
>  const struct file_operations proc_pagemap_operations = {
>  	.llseek		= mem_lseek, /* borrow this */
>  	.read		= pagemap_read,
>  	.open		= pagemap_open,
>  	.release	= pagemap_release,
> +	.unlocked_ioctl = pagemap_scan_ioctl,
> +	.compat_ioctl	= pagemap_scan_ioctl,
>  };
>  #endif /* CONFIG_PROC_PAGE_MONITOR */
>  
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c..6d03a903a745 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -305,4 +305,54 @@ typedef int __bitwise __kernel_rwf_t;
>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>  			 RWF_APPEND)
>  
> +/* Pagemap ioctl */
> +#define PAGEMAP_SCAN	_IOWR('f', 16, struct pagemap_scan_arg)
> +
> +/* Bits are set in the bitmap of the page_region and masks in pagemap_scan_args */
> +#define PAGE_IS_WT		(1 << 0)
> +#define PAGE_IS_FILE		(1 << 1)
> +#define PAGE_IS_PRESENT		(1 << 2)
> +#define PAGE_IS_SWAPPED		(1 << 3)
> +
> +/*
> + * struct page_region - Page region with bitmap flags
> + * @start:	Start of the region
> + * @len:	Length of the region
> + * bitmap:	Bits sets for the region
> + */
> +struct page_region {
> +	__u64 start;
> +	__u64 len;
> +	__u64 bitmap;
> +};
> +
> +/*
> + * struct pagemap_scan_arg - Pagemap ioctl argument
> + * @start:		Starting address of the region
> + * @len:		Length of the region (All the pages in this length are included)
> + * @vec:		Address of page_region struct array for output
> + * @vec_len:		Length of the page_region struct array
> + * @max_pages:		Optional max return pages
> + * @flags:		Flags for the IOCTL
> + * @required_mask:	Required mask - All of these bits have to be set in the PTE
> + * @anyof_mask:		Any mask - Any of these bits are set in the PTE
> + * @excluded_mask:	Exclude mask - None of these bits are set in the PTE
> + * @return_mask:	Bits that are to be reported in page_region
> + */
> +struct pagemap_scan_arg {
> +	__u64 start;
> +	__u64 len;
> +	__u64 vec;
> +	__u64 vec_len;
> +	__u32 max_pages;
> +	__u32 flags;
> +	__u64 required_mask;
> +	__u64 anyof_mask;
> +	__u64 excluded_mask;
> +	__u64 return_mask;
> +};
> +
> +/* Special flags */
> +#define PAGEMAP_WP_ENGAGE	(1 << 0)
> +
>  #endif /* _UAPI_LINUX_FS_H */
> diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
> index b7b56871029c..6d03a903a745 100644
> --- a/tools/include/uapi/linux/fs.h
> +++ b/tools/include/uapi/linux/fs.h
> @@ -305,4 +305,54 @@ typedef int __bitwise __kernel_rwf_t;
>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>  			 RWF_APPEND)
>  
> +/* Pagemap ioctl */
> +#define PAGEMAP_SCAN	_IOWR('f', 16, struct pagemap_scan_arg)
> +
> +/* Bits are set in the bitmap of the page_region and masks in pagemap_scan_args */
> +#define PAGE_IS_WT		(1 << 0)
> +#define PAGE_IS_FILE		(1 << 1)
> +#define PAGE_IS_PRESENT		(1 << 2)
> +#define PAGE_IS_SWAPPED		(1 << 3)
> +
> +/*
> + * struct page_region - Page region with bitmap flags
> + * @start:	Start of the region
> + * @len:	Length of the region
> + * bitmap:	Bits sets for the region
> + */
> +struct page_region {
> +	__u64 start;
> +	__u64 len;
> +	__u64 bitmap;
> +};
> +
> +/*
> + * struct pagemap_scan_arg - Pagemap ioctl argument
> + * @start:		Starting address of the region
> + * @len:		Length of the region (All the pages in this length are included)
> + * @vec:		Address of page_region struct array for output
> + * @vec_len:		Length of the page_region struct array
> + * @max_pages:		Optional max return pages
> + * @flags:		Flags for the IOCTL
> + * @required_mask:	Required mask - All of these bits have to be set in the PTE
> + * @anyof_mask:		Any mask - Any of these bits are set in the PTE
> + * @excluded_mask:	Exclude mask - None of these bits are set in the PTE
> + * @return_mask:	Bits that are to be reported in page_region
> + */
> +struct pagemap_scan_arg {
> +	__u64 start;
> +	__u64 len;
> +	__u64 vec;
> +	__u64 vec_len;
> +	__u32 max_pages;
> +	__u32 flags;
> +	__u64 required_mask;
> +	__u64 anyof_mask;
> +	__u64 excluded_mask;
> +	__u64 return_mask;
> +};
> +
> +/* Special flags */
> +#define PAGEMAP_WP_ENGAGE	(1 << 0)
> +
>  #endif /* _UAPI_LINUX_FS_H */

Better move the tools/ change out of the core changes, probably can be
squashed into the selftest patch later.

Thanks,

> -- 
> 2.30.2
> 

-- 
Peter Xu

