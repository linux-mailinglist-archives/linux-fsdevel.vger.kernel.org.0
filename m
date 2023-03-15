Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5516BBA4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 17:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjCOQzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 12:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCOQzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:55:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B595A193;
        Wed, 15 Mar 2023 09:54:54 -0700 (PDT)
Received: from [192.168.10.39] (unknown [39.37.168.222])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3BBA56602065;
        Wed, 15 Mar 2023 16:54:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678899292;
        bh=EyXR2YxwFVjBAcx1rUVLdzVeq5GifyBb6Z8dID0brCk=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=SHQ3SHGgunZCD9CQKxkcMrkNu82y/hn/LXDp+BkqMXc7hJnD5qh+gIhMIMTiEOxR7
         EkaldNLGjTXTymZH3QmhQwWDCVW4Jeb9n47yKYEdRiLYkghf+cXEAC/nsxUXsFOU2Y
         m/EqUEI/mHPFRT+cSK436ppqmBN5zq99BRVK8+99lGAz0dYSBatwE8U9psqRXg6OLB
         XOXxGInAuGnjbKNFohYXlKgAy4J29WtLirHCECYN9Iz1eno/uOz+mTJgqF8rDdp3F6
         UevrNe3irtE7kpeBmhfQ8nWRofKmCdG/rCgthAST7DOfk8vKWFLJRi7wtbLiQFdarr
         GzoyGjH6cfBCw==
Message-ID: <3d2d1ba4-bfab-6b3d-f0d6-ae0920ebdcb0@collabora.com>
Date:   Wed, 15 Mar 2023 21:54:40 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
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
Subject: Re: [PATCH v11 4/7] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309135718.1490461-5-usama.anjum@collabora.com> <ZBHqjBjj6nn1xeTM@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZBHqjBjj6nn1xeTM@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/15/23 8:55 PM, Peter Xu wrote:
> On Thu, Mar 09, 2023 at 06:57:15PM +0500, Muhammad Usama Anjum wrote:
>> +	for (addr = start; !ret && addr < end; pte++, addr += PAGE_SIZE) {
>> +		pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
>> +
>> +		is_writ = !is_pte_uffd_wp(*pte);
>> +		is_file = vma->vm_file;
>> +		is_pres = pte_present(*pte);
>> +		is_swap = is_swap_pte(*pte);
>> +
>> +		pte_unmap_unlock(pte, ptl);
>> +
>> +		ret = pagemap_scan_output(is_writ, is_file, is_pres, is_swap,
>> +					  p, addr, 1);
>> +		if (ret)
>> +			break;
>> +
>> +		if (PM_SCAN_OP_IS_WP(p) && is_writ &&
>> +		    uffd_wp_range(walk->mm, vma, addr, PAGE_SIZE, true) < 0)
>> +			ret = -EINVAL;
>> +	}
> 
> This is not real atomic..
> 
> Taking the spinlock for eacy pte is not only overkill but wrong in
> atomicity because the pte can change right after spinlock unlocked.
Let me explain. It seems like wrong, but it isn't. In my rigorous testing,
it didn't show any side-effect.  Here we are finding out if a page is
written. If page is written, only then we clear it. Lets look at the
different possibilities here:
- If a page isn't written, we'll not clear it.
- If a page is written and there isn't any race, we'll clear written-to
flag by write protecting it.
- If a page is written but before clearing it, data is written again to the
page. The page would remain written and we'll clear it.
- If a page is written but before clearing it, it gets write protected,
we'll still write protected it. There is double right protection here, but
no side-effect.

Lets turn this into a truth table for easier understanding. Here first
coulmn and thrid column represents this above code. 2nd column represents
any other thread interacting with the page.

If page is written/dirty	some other task interacts	wp_page
no				does nothing			no
no				writes to page			no
no				wp the page			no
yes				does nothing			yes
yes				write to page			yes
yes				wp the page			yes

As you can see there isn't any side-effect happening. We aren't over doing
the wp or under-doing the write-protect.

Even if we were doing something wrong here and I bring the lock over all of
this, the pages get become written or wp just after unlocking. It is
expected. This current implementation doesn't seem to be breaking this.

Is my understanding wrong somewhere here? Can you point out?

Previous to this current locking design were either buggy or slower when
multiple threads were working on same pages. Current implementation removes
the limitations:
- The memcpy inside pagemap_scan_output is happening with pte unlocked.
- We are only wp a page if we have noted this page to be dirty
- No mm write lock is required. Only read lock works fine just like
userfaultfd_writeprotect() takes only read lock.

There is only one con here that we are locking and unlocking the pte lock
again and again.

Please have a look at my explanation and let me know what do you think.

> 
> Unfortunately you also cannot reuse uffd_wp_range() because that's not
> atomic either, my fault here.  Probably I was thinking mostly from
> soft-dirty pov on batching the collect+reset.
> 
> You need to take the spin lock, collect whatever bits, set/clear whatever
> bits, only until then release the spin lock.
> 
> "Not atomic" means you can have some page got dirtied but you could miss
> it.  Depending on how strict you want, I think it'll break apps like CRIU
> if strict atomicity needed for migrating a process.  If we want to have a
> new interface anyway, IMHO we'd better do that in the strict way.
In my rigorous multi-threaded testing where a lots of threads are working
on same set of pages, we aren't losing even a single update. I can share
the test if you want.

> 
> Same comment applies to the THP handling (where I cut from the context).
> 

-- 
BR,
Muhammad Usama Anjum
