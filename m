Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B573F801
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 11:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjF0JAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 05:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjF0JAt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:00:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD6510D;
        Tue, 27 Jun 2023 02:00:47 -0700 (PDT)
Received: from [192.168.10.54] (unknown [182.179.162.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB2AC6606FB9;
        Tue, 27 Jun 2023 10:00:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687856445;
        bh=ZZEOEcN6MGUWVTuSEB2IAyBIdl1KP6UeSriBCZotg8Y=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=NkkDDHSanoM8JQ7TuqOfrGn+hxanopyFAnFePNxltuHzG8ApuyLjyZ2FboUyFkJXI
         2WMWh4TE4QKSFSU1hK6kUaFvyzTeMMrvR7LVPuzNpDqC6TZjX95fjT7/7rx6Pe6tDl
         m6ZErbjiU6lw11kW4DiKg+kNoctG/LCWJWxkMyDTa+WReaFcMg9xJqx/g9sjvYAmxh
         vMvxqge9uU+TBv8ELUxGB+N7Sf0kn4pWgQH0ydTyVXzvdzItG+Hla31yb0CuQYukPO
         otl1ApCibq45Oh2ZPRRnwf9981U8uTG3w5PDy4Dpht7DiTvnuL1mer8AgCUHNDt0Sc
         xlsOsm1rNihvQ==
Message-ID: <13ea54c0-25a3-285c-f47e-d6da11c91795@collabora.com>
Date:   Tue, 27 Jun 2023 14:00:31 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
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
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v21 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Andrei Vagin <avagin@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Peter Xu <peterx@redhat.com>
References: <20230626113156.1274521-1-usama.anjum@collabora.com>
 <20230626113156.1274521-3-usama.anjum@collabora.com>
 <ZJo/gOnTmwEQPLF8@gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZJo/gOnTmwEQPLF8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrei and Michal,

Lets resolve last two points. Please reply below.

On 6/27/23 6:46 AM, Andrei Vagin wrote:
...
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
>> +				      unsigned long start, unsigned long end,
>> +				      struct mm_walk *walk)
>> +{
>> +	unsigned long n_pages = (end - start)/PAGE_SIZE;
>> +	struct pagemap_scan_private *p = walk->private;
>> +	struct vm_area_struct *vma = walk->vma;
>> +	bool is_written, is_interesting = true;
>> +	struct hstate *h = hstate_vma(vma);
>> +	unsigned long bitmap;
>> +	spinlock_t *ptl;
>> +	int ret = 0;
>> +	pte_t ptent;
>> +
>> +	if (IS_PM_SCAN_WP(p->flags) && n_pages < HPAGE_SIZE/PAGE_SIZE)
>> +		return -EINVAL;
>> +
>> +	if (n_pages > p->max_pages - p->found_pages)
>> +		n_pages = p->max_pages - p->found_pages;
>> +
>> +	if (IS_PM_SCAN_WP(p->flags)) {
>> +		i_mmap_lock_write(vma->vm_file->f_mapping);
>> +		ptl = huge_pte_lock(h, vma->vm_mm, ptep);
>> +	}
>> +
>> +	ptent = huge_ptep_get(ptep);
>> +	is_written = !is_huge_pte_uffd_wp(ptent);
>> +
>> +	/*
>> +	 * Partial hugetlb page clear isn't supported
>> +	 */
>> +	if (is_written && IS_PM_SCAN_WP(p->flags) &&
>> +	    n_pages < HPAGE_SIZE/PAGE_SIZE) {
> 
> should it be done only if is_interesting is set?
This can be good optimization. We shouldn't return error before finding if
page is interesting. I'll update.

> 
>> +		ret = PM_SCAN_END_WALK;
>> +		goto unlock_and_return;
>> +	}
>> +
>> +	bitmap = PM_SCAN_FLAGS(is_written, pagemap_scan_is_huge_file(ptent),
>> +			       pte_present(ptent), is_swap_pte(ptent),
>> +			       pte_present(ptent) && is_zero_pfn(pte_pfn(ptent)));
>> +
>> +	if (IS_PM_SCAN_GET(p->flags)) {
>> +		is_interesting = pagemap_scan_is_interesting_page(bitmap, p);
>> +		if (is_interesting)
>> +			ret = pagemap_scan_output(bitmap, p, start, n_pages);
>> +	}
>> +
>> +	if (IS_PM_SCAN_WP(p->flags) && is_written && is_interesting &&
>> +	    ret >= 0) {
>> +		make_uffd_wp_huge_pte(vma, start, ptep, ptent);
>> +		flush_hugetlb_tlb_range(vma, start, end);
>> +	}
>> +
>> +unlock_and_return:
>> +	if (IS_PM_SCAN_WP(p->flags)) {
>> +		spin_unlock(ptl);
>> +		i_mmap_unlock_write(vma->vm_file->f_mapping);
>> +	}
>> +
>> +	return ret;
>> +}
...
>> +
>> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long __arg)
>> +{
>> +	struct pm_scan_arg __user *uarg = (struct pm_scan_arg __user *)__arg;
>> +	unsigned long long start, end, walk_start, walk_end;
>> +	unsigned long empty_slots, vec_index = 0;
>> +	struct mmu_notifier_range range;
>> +	struct page_region __user *vec;
>> +	struct pagemap_scan_private p;
>> +	struct pm_scan_arg arg;
>> +	int ret = 0;
>> +
>> +	if (copy_from_user(&arg, uarg, sizeof(arg)))
>> +		return -EFAULT;
>> +
>> +	start = untagged_addr((unsigned long)arg.start);
>> +	vec = (struct page_region *)untagged_addr((unsigned long)arg.vec);
>> +
>> +	ret = pagemap_scan_args_valid(&arg, start, vec);
>> +	if (ret)
>> +		return ret;
>> +
>> +	end = start + arg.len;
>> +	p.max_pages = (arg.max_pages) ? arg.max_pages : ULONG_MAX;
>> +	p.found_pages = 0;
>> +	p.required_mask = arg.required_mask;
>> +	p.anyof_mask = arg.anyof_mask;
>> +	p.excluded_mask = arg.excluded_mask;
>> +	p.return_mask = arg.return_mask;
>> +	p.flags = arg.flags;
>> +	p.flags |= ((p.required_mask | p.anyof_mask | p.excluded_mask) &
>> +		    PAGE_IS_WRITTEN) ? PM_SCAN_REQUIRE_UFFD : 0;
>> +	p.cur_buf.start = p.cur_buf.len = p.cur_buf.flags = 0;
>> +	p.vec_buf = NULL;
>> +	p.vec_buf_len = PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
>> +
>> +	/*
>> +	 * Allocate smaller buffer to get output from inside the page walk
>> +	 * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
>> +	 * we want to return output to user in compact form where no two
>> +	 * consecutive regions should be continuous and have the same flags.
>> +	 * So store the latest element in p.cur_buf between different walks and
>> +	 * store the p.cur_buf at the end of the walk to the user buffer.
>> +	 */
>> +	if (IS_PM_SCAN_GET(p.flags)) {
>> +		p.vec_buf = kmalloc_array(p.vec_buf_len, sizeof(*p.vec_buf),
>> +					  GFP_KERNEL);
>> +		if (!p.vec_buf)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	if (IS_PM_SCAN_WP(p.flags)) {
>> +		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
>> +					mm, start, end);
>> +		mmu_notifier_invalidate_range_start(&range);
>> +	}
>> +
>> +	walk_start = walk_end = start;
>> +	while (walk_end < end && !ret) {
>> +		if (IS_PM_SCAN_GET(p.flags)) {
>> +			p.vec_buf_index = 0;
>> +
>> +			/*
>> +			 * All data is copied to cur_buf first. When more data
>> +			 * is found, we push cur_buf to vec_buf and copy new
>> +			 * data to cur_buf. Subtract 1 from length as the
>> +			 * index of cur_buf isn't counted in length.
>> +			 */
>> +			empty_slots = arg.vec_len - vec_index;
>> +			p.vec_buf_len = min(p.vec_buf_len, empty_slots - 1);
>> +		}
>> +
>> +		walk_end = (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK;
>> +		if (walk_end > end)
>> +			walk_end = end;
>> +
> 
> If this loop can run for a long time, we need to interrupt it in case of
> pending signals.
> 
> If you think we don't need to do that, pls explain in the commit
> message, so that maintainers don't miss this part and double check that
> everything is alright here.
This can be done. I'll add to the commit message that we are walking over
entire range passed.

> 
>> +		ret = mmap_read_lock_killable(mm);
>> +		if (ret)
> 
> If any pages have been handled, we need to report them to user-space. It
> isn't acceptable to return a error in such cases.
This will return error only when task has gotten some serios signal and it
is giong to be killed. In this scenerio, we shouldn't care about returning
gracefully. Why do you think we should return gracefully in this case?

> 
> And we need to report an address where it stopped scanning.
> We can do that by adding zero length vector.
I don't want to do multiplexing the ending address in vec. Can we add
end_addr variable in struct pm_scan_arg to always return the ending address?

struct pm_scan_arg {
	...
	_u64 end_addr;
};


> 
> 
>> +			goto free_data;
>> +		ret = walk_page_range(mm, walk_start, walk_end,
>> +				      &pagemap_scan_ops, &p);
>> +		mmap_read_unlock(mm);
>> +
>> +		if (ret && ret != PM_SCAN_FOUND_MAX_PAGES &&
>> +		    ret != PM_SCAN_END_WALK)
>> +			goto free_data;
>> +
>> +		walk_start = walk_end;
>> +		if (IS_PM_SCAN_GET(p.flags) && p.vec_buf_index) {
>> +			if (copy_to_user(&vec[vec_index], p.vec_buf,
>> +					 p.vec_buf_index * sizeof(*p.vec_buf))) {
>> +				/*
>> +				 * Return error even though the OP succeeded
>> +				 */
>> +				ret = -EFAULT;
>> +				goto free_data;
>> +			}
>> +			vec_index += p.vec_buf_index;
> 
> Should we set ret to zero here if it is equal PM_SCAN_END_WALK.
No, PM_SCAN_END_WALK is just internal code to stop the page walk and return
immedtitely. When we get this return value, we stop this loop and return to
user with whatever data we have in user buffer.

> 
>> +		}
>> +	}
>> +
>> +	if (p.cur_buf.len) {
>> +		if (copy_to_user(&vec[vec_index], &p.cur_buf, sizeof(p.cur_buf))) {
>> +			ret = -EFAULT;
>> +			goto free_data;
>> +		}
>> +		vec_index++;
>> +	}
>> +
>> +	ret = vec_index;
>> +
>> +free_data:
>> +	if (IS_PM_SCAN_WP(p.flags))
>> +		mmu_notifier_invalidate_range_end(&range);
>> +
>> +	kfree(p.vec_buf);
>> +	return ret;
>> +}
>> +
...

-- 
BR,
Muhammad Usama Anjum
