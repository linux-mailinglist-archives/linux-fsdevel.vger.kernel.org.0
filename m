Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738CC694668
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 13:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjBMMzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 07:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjBMMzh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:55:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D708018E;
        Mon, 13 Feb 2023 04:55:31 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.179.179])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B67AC660206C;
        Mon, 13 Feb 2023 12:55:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676292930;
        bh=Xh/0dTNyLEOzCUIY4Do2zwkRqk+8BrgdVwpM3hddolc=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=R7Ji19SrAUUX4edPOh5y4RpUa5zZtHfvGJNGjCRevsL4kzL5T35VtXcXXxJs6NW6t
         +I50Su34voWtp2VNTZdjQnUYvs6NU2R3KN5+YBSIJGnJIMtlMHakkj/e7r5zHSrsPK
         Oa2hNiM9LZVcT8D4+T4pfQqAJDbvhDNrfZPvXPEw4GJ1qvA/gzYPtYJob/0vtwdmsI
         qKACR/mssr2+XA6S4pq/emwRrrirgwMdTL+7EPMHu9i6bCXGzKeg6qDUzwhiXb+5ls
         34/MPOwpAgTaxovXVt2TWfnapi5PbyEsqgHnG/179TzhSNCIz3IkLwD+/ySl10eUtb
         YU6RV5Ib8UfGQ==
Message-ID: <8b2959fb-2a74-0a1f-8833-0b18eab142dc@collabora.com>
Date:   Mon, 13 Feb 2023 17:55:19 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
To:     Peter Xu <peterx@redhat.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
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
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com> <Y+QfDN4Y5Q10x8GQ@x1n>
In-Reply-To: <Y+QfDN4Y5Q10x8GQ@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/23 3:15 AM, Peter Xu wrote:
> On Thu, Feb 02, 2023 at 04:29:12PM +0500, Muhammad Usama Anjum wrote:
>> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
>> the info about page table entries. The following operations are supported
>> in this ioctl:
>> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
>>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>>   (PAGE_IS_SWAPPED).
>> - Write-protect the pages (PAGEMAP_WP_ENGAGE) to start finding which
>>   pages have been written-to.
>> - Find pages which have been written-to and write protect the pages
>>   (atomic PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE)
>>
>> To get information about which pages have been written-to and/or write
>> protect the pages, following must be performed first in order:
>> - The userfaultfd file descriptor is created with userfaultfd syscall.
>> - The UFFD_FEATURE_WP_ASYNC feature is set by UFFDIO_API IOCTL.
>> - The memory range is registered with UFFDIO_REGISTER_MODE_WP mode
>>   through UFFDIO_REGISTER IOCTL.
>> Then the any part of the registered memory or the whole memory region
>> can be write protected using the UFFDIO_WRITEPROTECT IOCTL or
>> PAGEMAP_SCAN IOCTL.
>>
>> struct pagemap_scan_args is used as the argument of the IOCTL. In this
>> struct:
>> - The range is specified through start and len.
>> - The output buffer of struct page_region array and size is specified as
>>   vec and vec_len.
>> - The optional maximum requested pages are specified in the max_pages.
>> - The flags can be specified in the flags field. The PAGEMAP_WP_ENGAGE
>>   is the only added flag at this time.
>> - The masks are specified in required_mask, anyof_mask, excluded_ mask
>>   and return_mask.
>>
>> This IOCTL can be extended to get information about more PTE bits. This
>> IOCTL doesn't support hugetlbs at the moment. No information about
>> hugetlb can be obtained. This patch has evolved from a basic patch from
>> Gabriel Krisman Bertazi.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes in v10:
>> - move changes in tools/include/uapi/linux/fs.h to separate patch
>> - update commit message
>>
>> Change in v8:
>> - Correct is_pte_uffd_wp()
>> - Improve readability and error checks
>> - Remove some un-needed code
>>
>> Changes in v7:
>> - Rebase on top of latest next
>> - Fix some corner cases
>> - Base soft-dirty on the uffd wp async
>> - Update the terminologies
>> - Optimize the memory usage inside the ioctl
>>
>> Changes in v6:
>> - Rename variables and update comments
>> - Make IOCTL independent of soft_dirty config
>> - Change masks and bitmap type to _u64
>> - Improve code quality
>>
>> Changes in v5:
>> - Remove tlb flushing even for clear operation
>>
>> Changes in v4:
>> - Update the interface and implementation
>>
>> Changes in v3:
>> - Tighten the user-kernel interface by using explicit types and add more
>>   error checking
>>
>> Changes in v2:
>> - Convert the interface from syscall to ioctl
>> - Remove pidfd support as it doesn't make sense in ioctl
>> ---
>>  fs/proc/task_mmu.c      | 290 ++++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/fs.h |  50 +++++++
>>  2 files changed, 340 insertions(+)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index e35a0398db63..c6bde19d63d9 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/shmem_fs.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/pkeys.h>
>> +#include <linux/minmax.h>
>>  
>>  #include <asm/elf.h>
>>  #include <asm/tlb.h>
>> @@ -1135,6 +1136,22 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
>>  }
>>  #endif
>>  
>> +static inline bool is_pte_uffd_wp(pte_t pte)
>> +{
>> +	if ((pte_present(pte) && pte_uffd_wp(pte)) ||
>> +	    (pte_swp_uffd_wp_any(pte)))
>> +		return true;
>> +	return false;
> 
> Sorry I should have mentioned this earlier: you can directly return here.
No problem at all. I'm replacing these two helper functions with following
in next version so that !present pages don't show as dirty:

static inline bool is_pte_written(pte_t pte)
{
	if ((pte_present(pte) && pte_uffd_wp(pte)) ||
	    (pte_swp_uffd_wp_any(pte)))
		return false;
	return (pte_present(pte) || is_swap_pte(pte));
}

static inline bool is_pmd_written(pmd_t pmd)
{
	if ((pmd_present(pmd) && pmd_uffd_wp(pmd)) ||
	    (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd)))
		return false;
	return (pmd_present(pmd) || is_swap_pmd(pmd));
}

> 
>   return (pte_present(pte) && pte_uffd_wp(pte)) || pte_swp_uffd_wp_any(pte);
> 
>> +}
>> +
>> +static inline bool is_pmd_uffd_wp(pmd_t pmd)
>> +{
>> +	if ((pmd_present(pmd) && pmd_uffd_wp(pmd)) ||
>> +	    (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd)))
>> +		return true;
>> +	return false;
> 
> Same here.
> 
>> +}
>> +
>>  #if defined(CONFIG_MEM_SOFT_DIRTY) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
>>  static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
>>  		unsigned long addr, pmd_t *pmdp)
>> @@ -1763,11 +1780,284 @@ static int pagemap_release(struct inode *inode, struct file *file)
>>  	return 0;
>>  }
>>  
>> +#define PAGEMAP_BITS_ALL		(PAGE_IS_WRITTEN | PAGE_IS_FILE |	\
>> +					 PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
>> +#define PAGEMAP_NON_WRITTEN_BITS	(PAGE_IS_FILE |	PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
>> +#define IS_WP_ENGAGE_OP(a)		(a->flags & PAGEMAP_WP_ENGAGE)
>> +#define IS_GET_OP(a)			(a->vec)
>> +#define HAS_NO_SPACE(p)			(p->max_pages && (p->found_pages == p->max_pages))
>> +
>> +#define PAGEMAP_SCAN_BITMAP(wt, file, present, swap)	\
>> +	(wt | file << 1 | present << 2 | swap << 3)
>> +#define IS_WT_REQUIRED(a)				\
>> +	((a->required_mask & PAGE_IS_WRITTEN) ||	\
>> +	 (a->anyof_mask & PAGE_IS_WRITTEN))
>> +
>> +struct pagemap_scan_private {
>> +	struct page_region *vec;
>> +	struct page_region prev;
>> +	unsigned long vec_len, vec_index;
>> +	unsigned int max_pages, found_pages, flags;
>> +	unsigned long required_mask, anyof_mask, excluded_mask, return_mask;
>> +};
>> +
>> +static int pagemap_scan_test_walk(unsigned long start, unsigned long end, struct mm_walk *walk)
>> +{
>> +	struct pagemap_scan_private *p = walk->private;
>> +	struct vm_area_struct *vma = walk->vma;
>> +
>> +	if (IS_WT_REQUIRED(p) && !userfaultfd_wp(vma) && !userfaultfd_wp_async(vma))
> 
> Should this be:
> 
>        (IS_WT_REQUIRED(p) && (!userfaultfd_wp(vma) || !userfaultfd_wp_async(vma)))
> 
> Instead?
Correct. I'll fix this.

> 
>> +		return -EPERM;
>> +	if (vma->vm_flags & VM_PFNMAP)
>> +		return 1;
>> +	return 0;
>> +}
>> +
>> +static inline int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
>> +				      struct pagemap_scan_private *p, unsigned long addr,
>> +				      unsigned int len)
>> +{
>> +	unsigned long bitmap, cur = PAGEMAP_SCAN_BITMAP(wt, file, pres, swap);
>> +	bool cpy = true;
>> +	struct page_region *prev = &p->prev;
> 
> Nit: switch the above two lines?
I'll fix this.

> 
>> +
>> +	if (HAS_NO_SPACE(p))
>> +		return -ENOSPC;
>> +
>> +	if (p->max_pages && p->found_pages + len >= p->max_pages)
>> +		len = p->max_pages - p->found_pages;
> 
> If "p->found_pages + len >= p->max_pages", shouldn't this already return -ENOSPC?
Length calculation is happening in the funtions calling this function. I'll
move this out of here to make things logically better.

> 
>> +	if (!len)
>> +		return -EINVAL;
>> +
>> +	if (p->required_mask)
>> +		cpy = ((p->required_mask & cur) == p->required_mask);
>> +	if (cpy && p->anyof_mask)
>> +		cpy = (p->anyof_mask & cur);
>> +	if (cpy && p->excluded_mask)
>> +		cpy = !(p->excluded_mask & cur);
>> +	bitmap = cur & p->return_mask;
>> +	if (cpy && bitmap) {
>> +		if ((prev->len) && (prev->bitmap == bitmap) &&
>> +		    (prev->start + prev->len * PAGE_SIZE == addr)) {
>> +			prev->len += len;
>> +			p->found_pages += len;
>> +		} else if (p->vec_index < p->vec_len) {
>> +			if (prev->len) {
>> +				memcpy(&p->vec[p->vec_index], prev, sizeof(struct page_region));
>> +				p->vec_index++;
>> +			}
> 
> IIUC you can have:
> 
>   int pagemap_scan_deposit(p)
>   {
>         if (p->vec_index >= p->vec_len)
>                 return -ENOSPC;
> 
>         if (p->prev->len) {
>                 memcpy(&p->vec[p->vec_index], prev, sizeof(struct page_region));
>                 p->vec_index++;
>         }
> 
>         return 0;
>   }
> 
> Then call it here.  I think it can also be called below to replace
> export_prev_to_out().
No this isn't possible. We fill up prev until the next range doesn't merge
with it. At that point, we put prev into the output buffer and new range is
put into prev. Now that we have shifted to smaller page walks of <= 512
entries. We want to visit all ranges before finally putting the prev to
output. Sorry to have this some what complex method. The problem is that we
want to merge the consective matching regions into one entry in the output.
So to achieve this among multiple different page walks, the prev is being used.

Lets suppose we want to visit memory from 0x7FFF00000000 to 7FFF00400000
having length of 1024 pages and all of the memory has been written.
walk_page_range() will be called 2 times. In the first call, prev will be
set having length of 512. In second call, prev will be updated to 1024 as
the previous range stored in prev could be extended. After this, the prev
will be stored to the user output buffer consuming only 1 struct of page_range.

If we store prev back to output memory in every walk_page_range() call, we
wouldn't get 1 struct of page_range with length 1024. Instead we would get
2 elements of page_range structs with half the length.

> 
>> +			prev->start = addr;
>> +			prev->len = len;
>> +			prev->bitmap = bitmap;
>> +			p->found_pages += len;
>> +		} else {
>> +			return -ENOSPC;
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>> +static inline int export_prev_to_out(struct pagemap_scan_private *p, struct page_region __user *vec,
>> +				     unsigned long *vec_index)
>> +{
>> +	struct page_region *prev = &p->prev;
>> +
>> +	if (prev->len) {
>> +		if (copy_to_user(&vec[*vec_index], prev, sizeof(struct page_region)))
>> +			return -EFAULT;
>> +		p->vec_index++;
>> +		(*vec_index)++;
>> +		prev->len = 0;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static inline int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>> +					 unsigned long end, struct mm_walk *walk)
>> +{
>> +	struct pagemap_scan_private *p = walk->private;
>> +	struct vm_area_struct *vma = walk->vma;
>> +	unsigned long addr = end;
> 
> This assignment is useless?
No, this assignement gets used when only the WP_ENGAGE operation is used on
normal size pages.

> 
>> +	spinlock_t *ptl;
>> +	int ret = 0;
>> +	pte_t *pte;
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +	ptl = pmd_trans_huge_lock(pmd, vma);
>> +	if (ptl) {
>> +		bool pmd_wt;
>> +
>> +		pmd_wt = !is_pmd_uffd_wp(*pmd);
>> +		/*
>> +		 * Break huge page into small pages if operation needs to be performed is
>> +		 * on a portion of the huge page.
>> +		 */
>> +		if (pmd_wt && IS_WP_ENGAGE_OP(p) && (end - start < HPAGE_SIZE)) {
>> +			spin_unlock(ptl);
>> +			split_huge_pmd(vma, pmd, start);
>> +			goto process_smaller_pages;
>> +		}
>> +		if (IS_GET_OP(p))
>> +			ret = pagemap_scan_output(pmd_wt, vma->vm_file, pmd_present(*pmd),
>> +						  is_swap_pmd(*pmd), p, start,
>> +						  (end - start)/PAGE_SIZE);
>> +		spin_unlock(ptl);
>> +		if (!ret) {
>> +			if (pmd_wt && IS_WP_ENGAGE_OP(p))
>> +				uffd_wp_range(walk->mm, vma, start, HPAGE_SIZE, true);
>> +		}
>> +		return ret;
>> +	}
>> +process_smaller_pages:
>> +	if (pmd_trans_unstable(pmd))
>> +		return 0;
>> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>> +
>> +	pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
>> +	if (IS_GET_OP(p)) {
>> +		for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
>> +			ret = pagemap_scan_output(!is_pte_uffd_wp(*pte), vma->vm_file,
>> +						  pte_present(*pte), is_swap_pte(*pte), p, addr, 1);
>> +			if (ret)
>> +				break;
>> +		}
>> +	}
>> +	pte_unmap_unlock(pte - 1, ptl);
>> +	if ((!ret || ret == -ENOSPC) && IS_WP_ENGAGE_OP(p) && (addr - start))
>> +		uffd_wp_range(walk->mm, vma, start, addr - start, true);
>> +
>> +	cond_resched();
>> +	return ret;
>> +}
>> +
>> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end, int depth,
>> +				 struct mm_walk *walk)
>> +{
>> +	struct pagemap_scan_private *p = walk->private;
>> +	struct vm_area_struct *vma = walk->vma;
>> +	int ret = 0;
>> +
>> +	if (vma)
>> +		ret = pagemap_scan_output(false, vma->vm_file, false, false, p, addr,
>> +					  (end - addr)/PAGE_SIZE);
>> +	return ret;
>> +}
>> +
>> +/* No hugetlb support is present. */
>> +static const struct mm_walk_ops pagemap_scan_ops = {
>> +	.test_walk = pagemap_scan_test_walk,
>> +	.pmd_entry = pagemap_scan_pmd_entry,
>> +	.pte_hole = pagemap_scan_pte_hole,
>> +};
>> +
>> +static long do_pagemap_cmd(struct mm_struct *mm, struct pagemap_scan_arg *arg)
>> +{
>> +	unsigned long empty_slots, vec_index = 0;
>> +	unsigned long __user start, end;
>> +	unsigned long __start, __end;
>> +	struct page_region __user *vec;
>> +	struct pagemap_scan_private p;
>> +	int ret = 0;
>> +
>> +	start = (unsigned long)untagged_addr(arg->start);
>> +	vec = (struct page_region *)(unsigned long)untagged_addr(arg->vec);
>> +
>> +	/* Validate memory ranges */
>> +	if ((!IS_ALIGNED(start, PAGE_SIZE)) || (!access_ok((void __user *)start, arg->len)))
>> +		return -EINVAL;
>> +	if (IS_GET_OP(arg) && ((arg->vec_len == 0) ||
>> +	    (!access_ok((void __user *)vec, arg->vec_len * sizeof(struct page_region)))))
>> +		return -EINVAL;
>> +
>> +	/* Detect illegal flags and masks */
>> +	if ((arg->flags & ~PAGEMAP_WP_ENGAGE) || (arg->required_mask & ~PAGEMAP_BITS_ALL) ||
>> +	    (arg->anyof_mask & ~PAGEMAP_BITS_ALL) || (arg->excluded_mask & ~PAGEMAP_BITS_ALL) ||
>> +	    (arg->return_mask & ~PAGEMAP_BITS_ALL))
>> +		return -EINVAL;
>> +	if (IS_GET_OP(arg) && ((!arg->required_mask && !arg->anyof_mask && !arg->excluded_mask) ||
>> +				!arg->return_mask))
>> +		return -EINVAL;
>> +	/* The non-WT flags cannot be obtained if PAGEMAP_WP_ENGAGE is also specified. */
>> +	if (IS_WP_ENGAGE_OP(arg) && ((arg->required_mask & PAGEMAP_NON_WRITTEN_BITS) ||
>> +	    (arg->anyof_mask & PAGEMAP_NON_WRITTEN_BITS)))
>> +		return -EINVAL;
> 
> I think you said you'll clean this up a bit.  I don't think so..
You had showed a really clean way to put all these error checking
conditions. But I wasn't able to put the current error checking conditions
in that much nice way. I'd done at least something to make them look
better. Sorry, I'll revisit and try to come up with easier to follow error
checking conditions.

-- 
BR,
Muhammad Usama Anjum
