Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A926257AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 11:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiKKKKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 05:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiKKKKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:10:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1227EE20;
        Fri, 11 Nov 2022 02:10:21 -0800 (PST)
Received: from [192.168.10.9] (unknown [39.45.244.84])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B18396602A53;
        Fri, 11 Nov 2022 10:10:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668161420;
        bh=DB1GesM2rck4OsDAS8g+B+IHbx5lDoa3Do4KleeFlws=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=IDEPl4xDPWN1Mmh4XfPO+WNoKkG1xF8LGiBIMFbdST0NW+6Tb7ppH24M1kWslKPh0
         W6uRkBomgqS9FBcRvNy+BWecuwnzTrlmM+iAFwghYXhUOB3JCPlBzX6DdY9Yk/Kweh
         BmQ6znY1PeIE2+/MNQHEbAEaluhBkUItUwpx9VUFKPKvj0FgHNVMJPV5emU4Myc//6
         sOYwBER1RCM2k/4OvboWkxid9qFSuZMQ4cJSbwy0ABzOyE0alr2Vc3UtXznfQPoNad
         dkXkaDXtMgVXDj5JpHGqAJHbliUcNylbD4ncGcPwPiNvdV5rIeAC/zBiaRuHIKqCDM
         AFkNsqNFSuyKg==
Message-ID: <b5a67c87-e901-4d0c-8367-d1bf1293d5c4@collabora.com>
Date:   Fri, 11 Nov 2022 15:10:01 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
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
Content-Language: en-US
To:     Andrei Vagin <avagin@gmail.com>
References: <20221109102303.851281-1-usama.anjum@collabora.com>
 <20221109102303.851281-3-usama.anjum@collabora.com>
 <Y2w9sWZf5mlNV7Z3@gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y2w9sWZf5mlNV7Z3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Andrei,

Thank you for reviewing.

On 11/10/22 4:54 AM, Andrei Vagin wrote:
[...]
>> +static int add_to_out(bool sd, bool file, bool pres, bool swap, struct pagemap_scan_private *p,
>> +		      unsigned long addr, unsigned int len)
>> +{
>> +	unsigned long bitmap, cur = sd | file << 1 | pres << 2 | swap << 3;
> 
> Should we define contants for each of these bits?
I think I can define a macro to hide this dirty bit shifting in the function.

> 
>> +	bool cpy = true;
>> +
>> +	if (p->required_mask)
>> +		cpy = ((p->required_mask & cur) == p->required_mask);
>> +	if (cpy && p->anyof_mask)
>> +		cpy = (p->anyof_mask & cur);
>> +	if (cpy && p->excluded_mask)
>> +		cpy = !(p->excluded_mask & cur);
>> +
>> +	bitmap = cur & p->return_mask;
>> +
>> +	if (cpy && bitmap) {
>> +		if ((p->vec_index) && (p->vec[p->vec_index - 1].bitmap == bitmap) &&
>> +		    (p->vec[p->vec_index - 1].start + p->vec[p->vec_index - 1].len * PAGE_SIZE ==
>> +		     addr)) {
> 
> I think it is better to define a variable for p->vec_index - 1.
Will do in the next revision.

> nit: len can be in bytes rather than pages.
We are considering memory in the page units. The memory given to this IOCTL
must have PAGE_SIZE alignment. Oterwise we error out (picked this from
mincore()).

>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long addr,
>> +				  unsigned long end, struct mm_walk *walk)
>> +{
>> +	struct pagemap_scan_private *p = walk->private;
>> +	struct vm_area_struct *vma = walk->vma;
>> +	unsigned int len;
>> +	spinlock_t *ptl;
>> +	int ret = 0;
>> +	pte_t *pte;
>> +	bool dirty_vma = (p->flags & PAGEMAP_NO_REUSED_REGIONS) ?
>> +			 (false) : (vma->vm_flags & VM_SOFTDIRTY);
>> +
>> +	if ((walk->vma->vm_end < addr) || (p->max_pages && p->found_pages == p->max_pages))
>> +		return 0;
>> +
>> +	end = min(end, walk->vma->vm_end);
>> +
>> +	ptl = pmd_trans_huge_lock(pmd, vma);
>> +	if (ptl) {
>> +		if (dirty_vma || check_soft_dirty_pmd(vma, addr, pmd, false)) {
>> +			/*
>> +			 * Break huge page into small pages if operation needs to be performed is
>> +			 * on a portion of the huge page or the return buffer cannot store complete
>> +			 * data.
>> +			 */
>> +			if ((IS_CLEAR_OP(p) && (end - addr < HPAGE_SIZE))) {
>> +				spin_unlock(ptl);
>> +				split_huge_pmd(vma, pmd, addr);
>> +				goto process_smaller_pages;
>> +			}
>> +
>> +			if (IS_GET_OP(p)) {
>> +				len = (end - addr)/PAGE_SIZE;
>> +				if (p->max_pages && p->found_pages + len > p->max_pages)
>> +					len = p->max_pages - p->found_pages;
>> +
>> +				ret = add_to_out(dirty_vma ||
>> +						 check_soft_dirty_pmd(vma, addr, pmd, false),
> 
> can we reuse a return code of the previous call of check_soft_dirty_pmd?
Yes, will do.

> 
>> +						 vma->vm_file, pmd_present(*pmd), is_swap_pmd(*pmd),
>> +						 p, addr, len);
>> +			}
>> +			if (!ret && IS_CLEAR_OP(p))
>> +				check_soft_dirty_pmd(vma, addr, pmd, true);
> 
> should we return a error in this case? We need to be sure that:
> * we stop waking page tables after this point.
I'll update the implementation to return error. It immediately terminates
the walk as well.
> * return this error to the user-space if we are not able to add anything
>   in the vector.
I'm not returning error to userspace if we found no page matching the
masks. The total number of filled page_region are returned from the IOCTL.
If IOCTL returns 0, it means no page found has found, but the IOCTL
executed successfully.

[...]
>> +static long do_pagemap_sd_cmd(struct mm_struct *mm, struct pagemap_scan_arg *arg)
>> +{
>> +	struct mmu_notifier_range range;
>> +	unsigned long __user start, end;
>> +	struct pagemap_scan_private p;
>> +	int ret;
>> +
>> +	start = (unsigned long)untagged_addr(arg->start);
>> +	if ((!IS_ALIGNED(start, PAGE_SIZE)) || (!access_ok((void __user *)start, arg->len)))
>> +		return -EINVAL;
>> +
>> +	if (IS_GET_OP(arg) &&
>> +	    ((arg->vec_len == 0) || (!access_ok((struct page_region *)arg->vec, arg->vec_len))))
>> +		return -ENOMEM;
>> +
>> +#ifndef CONFIG_MEM_SOFT_DIRTY
>> +	if (IS_SD_OP(arg) || (arg->required_mask & PAGE_IS_SOFTDIRTY) ||
>> +	    (arg->anyof_mask & PAGE_IS_SOFTDIRTY))
>> +		return -EINVAL;
>> +#endif
>> +
>> +	if ((arg->flags & ~PAGEMAP_SD_FLAGS) || (arg->required_mask & ~PAGEMAP_OP_MASK) ||
>> +	    (arg->anyof_mask & ~PAGEMAP_OP_MASK) || (arg->excluded_mask & ~PAGEMAP_OP_MASK) ||
>> +	    (arg->return_mask & ~PAGEMAP_OP_MASK))
>> +		return -EINVAL;
>> +
>> +	if ((!arg->required_mask && !arg->anyof_mask && !arg->excluded_mask) || !arg->return_mask)
>> +		return -EINVAL;
>> +
>> +	if (IS_SD_OP(arg) && ((arg->required_mask & PAGEMAP_NONSD_OP_MASK) ||
>> +	     (arg->anyof_mask & PAGEMAP_NONSD_OP_MASK)))
>> +		return -EINVAL;
>> +
>> +	end = start + arg->len;
>> +	p.max_pages = arg->max_pages;
>> +	p.found_pages = 0;
>> +	p.flags = arg->flags;
>> +	p.required_mask = arg->required_mask;
>> +	p.anyof_mask = arg->anyof_mask;
>> +	p.excluded_mask = arg->excluded_mask;
>> +	p.return_mask = arg->return_mask;
>> +	p.vec_index = 0;
>> +	p.vec_len = arg->vec_len;
>> +
>> +	if (IS_GET_OP(arg)) {
>> +		p.vec = vzalloc(arg->vec_len * sizeof(struct page_region));
> 
> I think we need to set a reasonable limit for vec_len to avoid large
> allocations on the kernel. We can consider to use kmalloc or kvmalloc
> here.
I'll update to kvzalloc which uses vmalloc if kmalloc fails. It'll use
kmalloc for smaller allocations. Thanks for suggesting it. But it'll not
limit the memory allocation.

> 
> Thanks,
> Andrei

-- 
BR,
Muhammad Usama Anjum
