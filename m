Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8918777A58D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Aug 2023 10:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjHMIOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Aug 2023 04:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHMIOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Aug 2023 04:14:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34780E7;
        Sun, 13 Aug 2023 01:14:41 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.188.71])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1E3DF6607122;
        Sun, 13 Aug 2023 09:14:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691914479;
        bh=BChGkJRkjZWgzyQFOCbWXa50jj06kVV10+dAvRN9voo=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=FCjVfVG7uidfPv4zBprM+S9bPUpZPT4QO+5p6F/iyUYonAtFmweBtVQnsE41tO6AT
         iYGrXnHeRy8PaUESj4Yy8QykXZvZR5wwXxRvBf5l4d1tFCLOqnhyUcuIGWcoBKKv8p
         J9hnsOO/1lt0xJoVb0NXw7zvGwf9NLV0NyKYw5BaWW4DGnEamKQKhkUocsYlUTpAZF
         dJ3zBOMRho7KbqY2qS65pmtOOIGaMBcwtdrkF/YGKNkG01ys1nml0itErhrF3/Sl59
         vlNDWVHqWxQXa3Rq7trUFSTtL2YBUF47GKSDBACjCQoopInUfZf85qfIVSVS8x7yw8
         +Ec9weZFL4DSw==
Message-ID: <be42f268-a52a-6ae0-619a-7c8ca5bb58ae@collabora.com>
Date:   Sun, 13 Aug 2023 13:14:28 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
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
Subject: Re: [PATCH v29 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20230811180842.3141781-1-usama.anjum@collabora.com>
 <20230811180842.3141781-3-usama.anjum@collabora.com>
 <ZNeqHj//Rt0MIa8s@qmqm.qmqm.pl>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZNeqHj//Rt0MIa8s@qmqm.qmqm.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/12/23 8:49 PM, Michał Mirosław wrote:
> On Fri, Aug 11, 2023 at 11:08:38PM +0500, Muhammad Usama Anjum wrote:
>> The PAGEMAP_SCAN IOCTL on the pagemap file can be used to get or optionally
>> clear the info about page table entries. The following operations are supported
>> in this IOCTL:
>> - Scan the address range and get the memory ranges matching the provided criteria.
>>   This is performed by default when the output buffer is specified.
> 
> Nit: This is actually performed always, but you can disable the output part
> by passing {NULL, 0} for the buffer.
I'll update it to:
"This is performed when the output buffer is specified."

> 
> [...]
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -19,6 +19,8 @@
>>  #include <linux/shmem_fs.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/pkeys.h>
>> +#include <linux/minmax.h>
>> +#include <linux/overflow.h>
>>  
>>  #include <asm/elf.h>
>>  #include <asm/tlb.h>
>> @@ -1749,11 +1751,682 @@ static int pagemap_release(struct inode *inode, struct file *file)
>>  	return 0;
>>  }
>>  
>> +#define PM_SCAN_CATEGORIES	(PAGE_IS_WPALLOWED | PAGE_IS_WRITTEN |	\
>> +				 PAGE_IS_FILE |	PAGE_IS_PRESENT |	\
>> +				 PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |	\
>> +				 PAGE_IS_HUGE)
>> +#define PM_SCAN_FLAGS		(PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC)
>> +
>> +struct pagemap_scan_private {
>> +	struct pm_scan_arg arg;
>> +	unsigned long masks_of_interest, cur_vma_category;
>> +	struct page_region *vec_buf;
>> +	unsigned long vec_buf_len, vec_buf_index, found_pages, walk_end_addr;
>> +	struct page_region __user *vec_out;
>> +};
> [...]
>> +static unsigned long pagemap_thp_category(pmd_t pmd)
>> +{
>> +	unsigned long categories = PAGE_IS_HUGE;
>> +
>> +	/*
>> +	 * THPs don't support file-backed memory. So PAGE_IS_FILE
>> +	 * hasn't been checked here.
> 
> "hasn't been" -> "is not"
> (same for HugeTLB comment)
I'll update.

> 
>> +static bool pagemap_scan_push_range(unsigned long categories,
>> +				    struct pagemap_scan_private *p,
>> +				    unsigned long addr, unsigned long end)
>> +{
>> +	struct page_region *cur_buf = &p->vec_buf[p->vec_buf_index];
>> +
>> +	/*
>> +	 * When there is no output buffer provided at all, the sentinel values
>> +	 * won't match here. There is no other way for `cur_buf->end` to be
>> +	 * non-zero other than it being non-empty.
>> +	 */
>> +	if (addr == cur_buf->end && categories == cur_buf->categories) {
>> +		cur_buf->end = end;
>> +		return true;
>> +	}
>> +
>> +	if (cur_buf->end) {
>> +		if (p->vec_buf_index >= p->vec_buf_len - 1)
>> +			return false;
>> +
>> +		cur_buf = &p->vec_buf[++p->vec_buf_index];
>> +	}
>> +
>> +	cur_buf->start = addr;
>> +	cur_buf->end = end;
>> +	cur_buf->categories = categories;
>> +
>> +	return true;
>> +}
>> +
>> +static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
>> +				       unsigned long addr, unsigned long end)
>> +{
>> +	struct page_region *cur_buf = &p->vec_buf[p->vec_buf_index];
>> +
>> +	if (cur_buf->start != addr) {
>> +		cur_buf->end = addr;
>> +	} else {
>> +		cur_buf->start = cur_buf->end = 0;
>> +		if (p->vec_buf_index > 0)
>> +			p->vec_buf_index--;
> 
> There is no need to move to the previous index, as if the walk ends at
> this moment, the flush_buffer() code will ignore the empty last range.
Yeah, I'll update.

> 
>> +	}
>> +
>> +	p->found_pages -= (end - addr) / PAGE_SIZE;
>> +}
>> +
>> +static int pagemap_scan_output(unsigned long categories,
>> +			       struct pagemap_scan_private *p,
>> +			       unsigned long addr, unsigned long *end)
>> +{
>> +	unsigned long n_pages, total_pages;
>> +	int ret = 0;
>> +
>> +	if (!p->vec_buf)
>> +		return 0;
>> +
>> +	categories &= p->arg.return_mask;
>> +
>> +	n_pages = (*end - addr) / PAGE_SIZE;
>> +	if (check_add_overflow(p->found_pages, n_pages, &total_pages) ||
>> +	    total_pages > p->arg.max_pages) {
>> +		size_t n_too_much = total_pages - p->arg.max_pages;
>> +		*end -= n_too_much * PAGE_SIZE;
>> +		n_pages -= n_too_much;
>> +		ret = -ENOSPC;
>> +	}
>> +
>> +	if (!pagemap_scan_push_range(categories, p, addr, *end)) {
>> +		*end = addr;
>> +		n_pages = 0;
>> +		ret = -ENOSPC;
>> +	}
>> +
>> +	p->found_pages += n_pages;
>> +	if (ret)
>> +		p->walk_end_addr = *end;
>> +
>> +	return ret;
>> +}
> [...]
>> +static int pagemap_scan_init_bounce_buffer(struct pagemap_scan_private *p)
>> +{
>> +	if (!p->arg.vec_len)
>> +		return 0;
> 
> The removal of `cur_buf` lost the case of empty non-NULL output buffer
> passed in args.  That was requesting the walk to stop at first matching
> page (with the address returned in `walk_end`).  The push_range() call
> is still checking that, but since neither the buffer nor the sentinel
> values are set, the case is not possible to invoke.
Yeah, this is why I've removed all that logic here. The vec_len is set to 0
and vec_buf to NULL. This handles all the cases.

> 
>> +	/*
>> +	 * Allocate a smaller buffer to get output from inside the page
>> +	 * walk functions and walk the range in PAGEMAP_WALK_SIZE chunks.
>> +	 */
> 
> I think this is no longer true? We can now allocate arbitrary number of
> entries, but should probably have at least 512 to cover one PMD of pages.
> So it would be better to have a constant that holds the number of
> entries in the bounce buffer.
I'll remove the comment. PAGEMAP_WALK_SIZE >> PAGE_SHIFT is a constant
already, just a fancy one.

Altough if we can increase 512 to bigger number, it'll be better in terms
of performance. I'm not sure how much we can increase it.

> 
>> +	p->vec_buf_len = min_t(size_t, PAGEMAP_WALK_SIZE >> PAGE_SHIFT,
>> +			       p->arg.vec_len);
>> +	p->vec_buf = kmalloc_array(p->vec_buf_len, sizeof(*p->vec_buf),
>> +				   GFP_KERNEL);
>> +	if (!p->vec_buf)
>> +		return -ENOMEM;
>> +
>> +	p->vec_buf[0].end = 0;
> 
> p->vec_buf->start = p->vec_buf->end = 0;
Sure.

> 
>> +	p->vec_out = (struct page_region __user *)p->arg.vec;
>> +
>> +	return 0;
>> +}
>> +
>> +static int pagemap_scan_flush_buffer(struct pagemap_scan_private *p)
>> +{
>> +	const struct page_region *buf = p->vec_buf;
>> +	int n = (int)p->vec_buf_index;
> 
> Why do you need an `int` here (requiring a cast)?
Just looked at it, n and return code of pagemap_scan_flush_buffer() should
be long. Changed.

> 
>> +	if (p->arg.vec_len == 0)
>> +		return 0;
> 
> This should be actually `if (!buf)` as this notes that we don't have any
> buffer allocated (due to no output requested).
I'll update. !buf seems more reasonable.

> 
>> +	if (buf[n].end && buf[n].end != buf[n].start)
>> +		n++;
> 
> Testing `buf[n].end` is redundant, as the range is nonempty if
> `end != start`.
Sure.

> 
>> +	if (!n)
>> +		return 0;
>> +
>> +	if (copy_to_user(p->vec_out, buf, n * sizeof(*buf)))
>> +		return -EFAULT;
>> +
>> +	p->arg.vec_len -= n;
>> +	p->vec_out += n;
>> +
>> +	p->vec_buf_index = 0;
>> +	p->vec_buf_len = min_t(size_t, p->vec_buf_len, p->arg.vec_len);
>> +	p->vec_buf[0].end = 0;
> 
> buf->start = buf->end = 0;
Sure.

> 
>> +	return n;
>> +}
>> +
>> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
>> +{
>> +	struct mmu_notifier_range range;
>> +	struct pagemap_scan_private p = {0};
>> +	unsigned long walk_start;
>> +	size_t n_ranges_out = 0;
>> +	int ret;
>> +
>> +	ret = pagemap_scan_get_args(&p.arg, uarg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	p.masks_of_interest = p.arg.category_inverted | p.arg.category_mask |
>> +			      p.arg.category_anyof_mask | p.arg.return_mask;
> 
> `category_inverted` can be left out, because if a set bit it is not also in one
> of the masks, then its value is going to be ignored.
Okay.

> 
> [...]
>> +	for (walk_start = p.arg.start; walk_start < p.arg.end;
>> +			walk_start = p.arg.walk_end) {
>> +		int n_out;
>> +
>> +		if (fatal_signal_pending(current)) {
>> +			ret = -EINTR;
>> +			break;
>> +		}
>> +
>> +		ret = mmap_read_lock_killable(mm);
>> +		if (ret)
>> +			break;
>> +		ret = walk_page_range(mm, walk_start, p.arg.end,
>> +				      &pagemap_scan_ops, &p);
>> +		mmap_read_unlock(mm);
>> +
>> +		n_out = pagemap_scan_flush_buffer(&p);
>> +		if (n_out < 0)
>> +			ret = n_out;
>> +		else
>> +			n_ranges_out += n_out;
>> +
>> +		p.walk_end_addr = p.walk_end_addr ? p.walk_end_addr : p.arg.end;
> 
> Why is `p.walk_end_addr` needed? It is not used in the loop code. Shoudn't
> it be `p.arg.walk_end` as used in the `for` loop continuation statement?
It isn't needed for the loop. But we need to note down the ending address
of walk. We can switch to using p.arg.walk_end for better logical reason.
I'll update code.

> 
>> +		if (ret != -ENOSPC || p.arg.vec_len == 0 ||
>> +		    p.found_pages == p.arg.max_pages)
>> +			break;
> 
> Nit: I think you could split this into two or three separate `if (x)
> break;` for easier reading. The `vec_len` and `found_pages` are
> buffer-full tests, so could go along, but `ret != ENOSPC` is checking an
> error condition aborting the scan before it ends.
Can be done.

> 
>> +	}
>> +
>> +	/* ENOSPC signifies early stop (buffer full) from the walk. */
>> +	if (!ret || ret == -ENOSPC)
>> +		ret = n_ranges_out;
>> +
>> +	p.arg.walk_end = p.walk_end_addr ? p.walk_end_addr : walk_start;
>> +	if (pagemap_scan_writeback_args(&p.arg, uarg))
>> +		ret = -EFAULT;
> [...]
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
> [...]
>> +/*
>> + * struct pm_scan_arg - Pagemap ioctl argument
>> + * @size:		Size of the structure
>> + * @flags:		Flags for the IOCTL
>> + * @start:		Starting address of the region
>> + * @end:		Ending address of the region
>> + * @walk_end		Address where the scan stopped (written by kernel).
>> + *			walk_end == end (tag removed) informs that the scan completed on entire range.
> 
> I'm not sure `tag removed` is enough to know what tag was removed.
> Maybe something like "with address tags cleared" would fit?
Okay.

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
