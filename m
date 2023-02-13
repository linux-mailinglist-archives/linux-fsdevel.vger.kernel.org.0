Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9484693F6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 09:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjBMIT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 03:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBMIT1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:19:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6199DD51F;
        Mon, 13 Feb 2023 00:19:19 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.179.179])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7E8686602111;
        Mon, 13 Feb 2023 08:19:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676276357;
        bh=HcrRqQGTLDavaisdiDBAWZL7DbjBX2aS5kmcVSQao9Q=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=RUj+x5+hhHCs3+pYxQ5m7xQYA5s4//MWmZV4sAdJYmHle5VjOFUndXl1IARCprau9
         4D78YmxFNBexbqZdeuK3bDJa44gajzUkLybaGpDtGXnG0BTueF2iOeO7ECQLHLGvc9
         KB4Yu+kA26B5mf5CDFUlpOR+14iEiCtL3GknqNMCW1DU3E64WuKugoCV3aLgIimmrY
         wFurCzXK5sasmdjFS9oOixnYXyXFoP32BaL8oGQgvB1ezXe69nBGEVop2qJPrx+Y2I
         EpzrosGLYPHaIhrUhmj+3a/DyjJwZ3pA+2x0yvVlYRWB3v806AYcTtG4X3LG37kVBz
         JmBh1fhE7MOZA==
Message-ID: <355ef60e-0918-13a5-196a-97e4e793edd4@collabora.com>
Date:   Mon, 13 Feb 2023 13:19:06 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
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
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Content-Language: en-US
To:     Cyrill Gorcunov <gorcunov@gmail.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com> <Y+QgtVSEl4w2NgtJ@grain>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y+QgtVSEl4w2NgtJ@grain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Cyrill,

Thank you for your time and review.

On 2/9/23 3:22 AM, Cyrill Gorcunov wrote:
> On Thu, Feb 02, 2023 at 04:29:12PM +0500, Muhammad Usama Anjum wrote:
> ...
> Hi Muhammad! I'm really sorry for not commenting this code, just out of time and i
> fear cant look with precise care at least for some time, hopefully other CRIU guys
> pick it up. Anyway, here a few comment from a glance.
> 
>> +
>> +static inline int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
>> +				      struct pagemap_scan_private *p, unsigned long addr,
>> +				      unsigned int len)
>> +{
> 
> This is a big function and usually it's a flag to not declare it as "inline" until
> there very serious reson to.
I'll remove all these inline in next revision.

> 
>> +	unsigned long bitmap, cur = PAGEMAP_SCAN_BITMAP(wt, file, pres, swap);
>> +	bool cpy = true;
>> +	struct page_region *prev = &p->prev;
>> +
>> +	if (HAS_NO_SPACE(p))
>> +		return -ENOSPC;
>> +
>> +	if (p->max_pages && p->found_pages + len >= p->max_pages)
>> +		len = p->max_pages - p->found_pages;
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
> 
> You can exit early here simply
> 
> 	if (!cpy || !bitmap)
> 		return 0;
I'm avoiding an extra return here.

> 
> saving one tab for the code below.
> 
>> +		if ((prev->len) && (prev->bitmap == bitmap) &&
>> +		    (prev->start + prev->len * PAGE_SIZE == addr)) {
>> +			prev->len += len;
>> +			p->found_pages += len;
>> +		} else if (p->vec_index < p->vec_len) {
>> +			if (prev->len) {
>> +				memcpy(&p->vec[p->vec_index], prev, sizeof(struct page_region));
>> +				p->vec_index++;
>> +			}
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
> 
> No need for inline either.
> 
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
> 
> Same, no need for inline. I've a few comments more in my mind will try to
> collect them tomorrow.
Your review would be much appreciated.

-- 
BR,
Muhammad Usama Anjum
