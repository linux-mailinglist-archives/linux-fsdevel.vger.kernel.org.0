Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191AF672B4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 23:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjARWac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 17:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjARW3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:29:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F4547EE2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 14:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674080944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xZdbxU7U6Cq2n8pjRxmWipD5AezhqaGVZdCMLeOSIq0=;
        b=EKO8XnNLP5SlzcIaqKJIGPNeVqvJgf6ZlIolszKjQ88PzDQX57LicmYXoqEi/34WQE8ab7
        B3F7Xl4MmJzoXhs0cAeJ402aXn8bItZebH3JOdCtCdVOkjMQI4E2nBPupApw4+drxFQptB
        +IeGmvpBn8l4MCo5/Ou4vvKfoFV1CoY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-424-CUR6_5jYP2auuok-NcIMIQ-1; Wed, 18 Jan 2023 17:29:03 -0500
X-MC-Unique: CUR6_5jYP2auuok-NcIMIQ-1
Received: by mail-qt1-f200.google.com with SMTP id r24-20020ac85e98000000b003b68b691996so57085qtx.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 14:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZdbxU7U6Cq2n8pjRxmWipD5AezhqaGVZdCMLeOSIq0=;
        b=AntSualyu7ShSVGNuo8Mjz+vK8G9UaMghoH7tbd0hCWiT4SwppINeuwSHAmQ9ipA+G
         enqdwLBZO5tYlL89eg1LAkQGwnSPz0f9ROlRArA4N+V+6oQvM9Ea2WiHwS4o9IA4GreY
         i5LUiSWdzqYBPU/vjZhXnHZ8SGkTC/CMjtmxIZLflNgaO0E8sHdpYwKcsAFhppARwD/n
         T5JVhxhxHaF1YsJfqjuCVtq9rbEnTjvc2h0l/bHjrpxMuqvTFVtKPBmirtHED7ANQH89
         LXtrHaSdCg4KJOq6BbMEwKoUxK8m+DoaHKynYhq0YsJSxCoeZSXFcXOqNS/gLxxPGbR1
         UIXw==
X-Gm-Message-State: AFqh2kozNXQfv9Y+i/T4Ux+0vgCIoCbd1Rio7/gtI74eiQnzi2HBzaw1
        sxr4YvOG7kkKg5BnnnhuOJNJhLj6eXK6xqJqNp6txnJHMncvl8RI6ZMNS6vy7LNQxOzVshHCjvl
        wmrjc32ZIIwHClor6Fl778Zq2qQ==
X-Received: by 2002:a05:622a:6027:b0:3a5:264c:5f38 with SMTP id he39-20020a05622a602700b003a5264c5f38mr41792380qtb.63.1674080942322;
        Wed, 18 Jan 2023 14:29:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsl9OIsfPXCScNAje7vE8rqb3VJvdYvO/ETOWbzggmAZM3fZJJf/SErl3b5gRWagnicf2gKWw==
X-Received: by 2002:a05:622a:6027:b0:3a5:264c:5f38 with SMTP id he39-20020a05622a602700b003a5264c5f38mr41792335qtb.63.1674080941983;
        Wed, 18 Jan 2023 14:29:01 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id j9-20020ac806c9000000b003ab5d6cd6c5sm18027439qth.16.2023.01.18.14.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 14:29:01 -0800 (PST)
Date:   Wed, 18 Jan 2023 17:28:58 -0500
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
Subject: Re: [PATCH v7 3/4] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y8hyqhgx41/ET7bC@x1n>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
 <20230109064519.3555250-4-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230109064519.3555250-4-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 11:45:18AM +0500, Muhammad Usama Anjum wrote:
> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
> the info about page table entries. The following operations are supported
> in this ioctl:
> - Get the information if the pages have been written-to (PAGE_IS_Wt),
>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>   (PAGE_IS_SWAPPED).
> - Write-protect the pages (PAGEMAP_WP_ENGAGE) to start finding which
>   pages have been written-to.
> - Find pages which have been written-to and write protect the pages
>   (atomic PAGE_IS_NOT_WP + PAGEMAP_WP_ENGAGE)
> 
> The uffd should have been registered on the memory range before performing
> any WP/WT (Write Protect/Writtern-To) related operations with the IOCTL.
> 
> struct pagemap_scan_args is used as the argument of the IOCTL. In this
> struct:
> - The range is specified through start and len.
> - The output buffer and size is specified as vec and vec_len.
> - The optional maximum requested pages are specified in the max_pages.
> - The flags can be specified in the flags field. The PAGEMAP_WP_ENGAGE
>   is the only added flag at this time.
> - The masks are specified in required_mask, anyof_mask, excluded_ mask
>   and return_mask.
> 
> This IOCTL can be extended to get information about more PTE bits. This
> patch has evolved from a basic patch from Gabriel Krisman Bertazi.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
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
>  fs/proc/task_mmu.c            | 300 ++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fs.h       |  50 ++++++
>  tools/include/uapi/linux/fs.h |  50 ++++++
>  3 files changed, 400 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e35a0398db63..ba70faadf403 100644
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
> +	    (is_swap_pte(pte) && pte_swp_uffd_wp(pte)))
> +		return true;

This is an interesting way to detect whether the page is written..  I would
have thought you would reuse soft-dirty bit.

For swap case, you missed the pte markers (which can exist for !anon
memory).  You can have a look at pte_swp_uffd_wp_any().

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
> @@ -1763,11 +1780,294 @@ static int pagemap_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +#define PAGEMAP_OP_MASK		(PAGE_IS_WT | PAGE_IS_FILE |	\
> +				 PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
> +#define PAGEMAP_NONWT_OP_MASK	(PAGE_IS_FILE |	PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
> +#define IS_WP_ENGAGE_OP(a)	(a->flags & PAGEMAP_WP_ENGAGE)
> +#define IS_GET_OP(a)		(a->vec)
> +#define PAGEMAP_SCAN_BITMAP(wt, file, present, swap)	\
> +	(wt | file << 1 | present << 2 | swap << 3)
> +#define IS_WT_REQUIRED(a)				\
> +	((a->required_mask & PAGE_IS_WT) ||	\
> +	 (a->anyof_mask & PAGE_IS_WT))
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
> +	if (IS_WT_REQUIRED(p) && !vma_can_userfault(vma, vma->vm_flags))
> +		return -EPERM;

vma_can_userfault() is too coarse.  Maybe what you wanted to check is
userfaultfd_wp(vma)?

> +	if (IS_GET_OP(p) && p->max_pages && (p->found_pages == p->max_pages))
> +		return -ENOSPC;

This is the function to test "whether the walker should walk the vma
specified".  This check should IIUC be meaningless because found_pages
doesn't boost during vma switching, while OTOH your pmd walker fn should do
proper check when increasing found_pages and return -ENOSPC properly when
the same condition met.  That should be enough, IMHO.

I saw it already a few times in this patch, I think maybe you want a helper
for this one taking *p as argument.

> +	if (vma->vm_flags & VM_PFNMAP)
> +		return 1;
> +	return 0;
> +}
> +
> +static inline int add_to_out(bool wt, bool file, bool pres, bool swap,
> +			     struct pagemap_scan_private *p, unsigned long addr, unsigned int len)
> +{
> +	unsigned long bitmap, cur = PAGEMAP_SCAN_BITMAP(wt, file, pres, swap);
> +	bool cpy = true;
> +	struct page_region *prev = &p->prev;
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

I'd rather not have this helper; it doesn't really help a lot.

> +
> +static inline int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long addr,
> +					 unsigned long end, struct mm_walk *walk)
> +{
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	unsigned long start = addr;
> +	unsigned int len;
> +	spinlock_t *ptl;
> +	int ret = 0;
> +	pte_t *pte;
> +	bool pmd_wt;
> +
> +	if ((walk->vma->vm_end < addr) || (p->max_pages && p->found_pages == p->max_pages))
> +		return 0;
> +	end = min(end, walk->vma->vm_end);

None of the check above is needed, I think..

vma ranges are checked before pmd_entry() called.  found_pages should be
checked when increased (I think it's [1] above).

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
> +		if (pmd_wt && (IS_WP_ENGAGE_OP(p) && (end - addr < HPAGE_SIZE))) {
> +			spin_unlock(ptl);
> +			split_huge_pmd(vma, pmd, addr);
> +			goto process_smaller_pages;
> +		}
> +		if (IS_GET_OP(p)) {
> +			len = (end - addr)/PAGE_SIZE;
> +			if (p->max_pages && p->found_pages + len > p->max_pages)
> +				len = p->max_pages - p->found_pages;
> +
> +			ret = add_to_out(pmd_wt, vma->vm_file, pmd_present(*pmd),
> +					 is_swap_pmd(*pmd), p, addr, len);
> +			if (ret) {
> +				spin_unlock(ptl);
> +				return ret;
> +			}
> +		}
> +		spin_unlock(ptl);
> +		if (IS_WP_ENGAGE_OP(p) && pmd_wt) {
> +			BUG_ON(start & ~HPAGE_MASK);
> +
> +			ret = wp_range_async(vma, addr, HPAGE_SIZE);
> +		}
> +		return ret;
> +	}
> +process_smaller_pages:
> +	if (pmd_trans_unstable(pmd))
> +		return 0;
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +	for (; addr < end && !ret && (!p->max_pages || (p->found_pages < p->max_pages))
> +	     ; pte++, addr += PAGE_SIZE) {
> +		if (IS_GET_OP(p)) {

This 'if' should be out - skip loop if not needed.

> +			ret = add_to_out(!is_pte_uffd_wp(*pte), vma->vm_file, pte_present(*pte),
> +					 is_swap_pte(*pte), p, addr, 1);
> +			if (ret)
> +				break;
> +		}
> +	}
> +	pte_unmap_unlock(pte - 1, ptl);
> +	if (IS_WP_ENGAGE_OP(p)) {
> +		BUG_ON(start & ~PAGE_MASK);
> +		ret = wp_range_async(vma, start, addr - start);
> +	}
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
> +
> +	return ret;
> +}
> +
> +static const struct mm_walk_ops pagemap_scan_ops = {
> +	.test_walk = pagemap_scan_test_walk,
> +	.pmd_entry = pagemap_scan_pmd_entry,

Do we care about hugetlb at all?  So far it seems you don't.  It's fine,
then if you decided to go the uffd-wp way you can explicit declare no
support on hugetlb, as uffd-wp sync supports it so it should be by default
supported otherwise.

> +	.pte_hole = pagemap_scan_pte_hole,
> +};

-- 
Peter Xu

