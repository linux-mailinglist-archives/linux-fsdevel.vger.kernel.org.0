Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E343D7751F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 06:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjHIEbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 00:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjHIEb3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:31:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D94A1BDA;
        Tue,  8 Aug 2023 21:31:28 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.218.230])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A65296607193;
        Wed,  9 Aug 2023 05:31:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691555486;
        bh=xGTOVBf346p5z7gNl1KYsQVdZ1a5kLLBqA30qKLUwLk=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=nCzWb4J3wzCCrxjFs9KzjZu7S+A0zBSNj0abZIZQiqxXmLJdf/8OYdTkD8AkSHq55
         8YEL9f/3M1+EuVWhryjVnX/jKuTQlpudcZrrlS1+/oRx0HPQBNbKIDOva/d90sU/5Q
         LqCI5WWJxwlA+lhzD04b7IPIETpF6et+ddKWYlW5TdxZiiveoHdDevHJ5gCNgL7E6Y
         GBWr5AG3OcbOD7vJyYeJbJwqP9BgB6WjIvRJ8ZfYZ9hCpHjc7i9wvmePInqQvFOqgK
         afBzw2NwqrvsYSRR3BGya817C3Pd5oShlxGV6GGOEe6WJ9yZ3mUdThWd7eOvDTZS1y
         tGyyCHoAGs2Wg==
Message-ID: <e2967189-84b1-6bcb-9d7f-4c528c06c4bc@collabora.com>
Date:   Wed, 9 Aug 2023 09:31:14 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Danylo Mocherniuk <mdanylo@google.com>,
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v27 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     Andrei Vagin <avagin@gmail.com>
References: <20230808104309.357852-1-usama.anjum@collabora.com>
 <20230808104309.357852-3-usama.anjum@collabora.com>
 <CANaxB-ww6AcO4QThubYw62Mdeid4e3FOQAXvA_GZ=wu4J60-AQ@mail.gmail.com>
 <624cfa26-5650-ee0d-8e0a-1d844175bcaf@collabora.com>
 <CANaxB-yhCcvc9W6POFR8SNjECeD_WNGidnuxXrHKT2if=CgyrA@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CANaxB-yhCcvc9W6POFR8SNjECeD_WNGidnuxXrHKT2if=CgyrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/9/23 12:55 AM, Andrei Vagin wrote:
> On Tue, Aug 8, 2023 at 12:35 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 8/9/23 12:21 AM, Andrei Vagin wrote:
>>> On Tue, Aug 8, 2023 at 3:43 AM Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>
>>> ....
>>>
>>>> +static int pagemap_scan_output(unsigned long categories,
>>>> +                              struct pagemap_scan_private *p,
>>>> +                              unsigned long addr, unsigned long *end)
>>>> +{
>>>> +       unsigned long n_pages, total_pages;
>>>> +       int ret = 0;
>>>> +
>>>> +       if (!p->vec_buf)
>>>> +               return 0;
>>>> +
>>>> +       categories &= p->arg.return_mask;
>>>> +
>>>> +       n_pages = (*end - addr) / PAGE_SIZE;
>>>> +       if (check_add_overflow(p->found_pages, n_pages, &total_pages) || //TODO
>>>
>>> Need to fix this TODO.
>> Sorry, I forgot to remove the "//TODO". As far as I've understood, the last
>> discussion ended in keeping the check_add_overflow(). [1] I'll just remove
>> the TODO.
>>
>> https://lore.kernel.org/all/CABb0KFEfmRz+Z_-7GygTL12E5Y254dvoUfWe4uSv9-wOx+Cs8w@mail.gmail.com
>>
>>
>>>
>>>> +           total_pages > p->arg.max_pages) {
>>>> +               size_t n_too_much = total_pages - p->arg.max_pages;
>>>> +               *end -= n_too_much * PAGE_SIZE;
>>>> +               n_pages -= n_too_much;
>>>> +               ret = -ENOSPC;
>>>> +       }
>>>> +
>>>> +       if (!pagemap_scan_push_range(categories, p, addr, *end)) {
>>>> +               *end = addr;
>>>> +               n_pages = 0;
>>>> +               ret = -ENOSPC;
>>>> +       }
>>>> +
>>>> +       p->found_pages += n_pages;
>>>> +       if (ret)
>>>> +               p->walk_end_addr = *end;
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +
>>>
>>> ...
>>>
>>>> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
>>>> +{
>>>> +       struct mmu_notifier_range range;
>>>> +       struct pagemap_scan_private p;
>>>> +       unsigned long walk_start;
>>>> +       size_t n_ranges_out = 0;
>>>> +       int ret;
>>>> +
>>>> +       memset(&p, 0, sizeof(p));
>>>> +       ret = pagemap_scan_get_args(&p.arg, uarg);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       p.masks_of_interest = MASKS_OF_INTEREST(p.arg);
>>>> +       ret = pagemap_scan_init_bounce_buffer(&p);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       /* Protection change for the range is going to happen. */
>>>> +       if (p.arg.flags & PM_SCAN_WP_MATCHING) {
>>>> +               mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
>>>> +                                       mm, p.arg.start, p.arg.end);
>>>> +               mmu_notifier_invalidate_range_start(&range);
>>>> +       }
>>>> +
>>>> +       walk_start = p.arg.start;
>>>> +       for (; walk_start < p.arg.end; walk_start = p.arg.walk_end) {
>>>> +               int n_out;
>>>> +
>>>> +               if (fatal_signal_pending(current)) {
>>>> +                       ret = -EINTR;
>>>> +                       break;
>>>> +               }
>>>> +
>>>> +               ret = mmap_read_lock_killable(mm);
>>>> +               if (ret)
>>>> +                       break;
>>>> +               ret = walk_page_range(mm, walk_start, p.arg.end,
>>>> +                                     &pagemap_scan_ops, &p);
>>>> +               mmap_read_unlock(mm);
>>>> +
>>>> +               n_out = pagemap_scan_flush_buffer(&p);
>>>> +               if (n_out < 0)
>>>> +                       ret = n_out;
>>>> +               else
>>>> +                       n_ranges_out += n_out;
>>>> +
>>>> +               if (ret != -ENOSPC || p.arg.vec_len - 1 == 0 ||
>>>> +                   p.found_pages == p.arg.max_pages) {
>>>> +                       p.walk_end_addr = p.arg.end;
>>>
>>> You should not change p.walk_end_addr If ret is ENOSPC. Pls add a test
>>> case to check this.
>> Yeah, I'm not setting walk_end_addr if ret is ENOSPC.
>>
>> I'm setting walk_end_addr only when ret = 0. I'd added this as a result of
>> a test case in my local test application. I can look at adding some tests
>> in pagemap_ioctl.c kselftest as well.
> 
> I am not sure that I understand what you mean here. ENOSPC can be returned
> when the vec array is full and in this case, walk_end_addr should be
> the address when it stops scanning.
I'll copy a test case in kselftest to prove or dis-prove the correctness of
walk_end address.

> 
>>
>>>
>>>> +                       break;
>>>> +               }
>>>> +       }
>>>> +
>>>> +       if (p.cur_buf.start != p.cur_buf.end) {
>>>> +               if (copy_to_user(p.vec_out, &p.cur_buf, sizeof(p.cur_buf)))
>>>> +                       ret = -EFAULT;
>>>> +               else
>>>> +                       ++n_ranges_out;
>>>> +       }
>>>> +
>>>> +       /* ENOSPC signifies early stop (buffer full) from the walk. */
>>>> +       if (!ret || ret == -ENOSPC)
>>>> +               ret = n_ranges_out;
>>>> +
>>>> +       p.arg.walk_end = p.walk_end_addr ? p.walk_end_addr : walk_start;
>>>> +       if (pagemap_scan_writeback_args(&p.arg, uarg))
>>>> +               ret = -EFAULT;
>>>> +
>>>> +       if (p.arg.flags & PM_SCAN_WP_MATCHING)
>>>> +               mmu_notifier_invalidate_range_end(&range);
>>>> +
>>>> +       kfree(p.vec_buf);
>>>> +       return ret;
>>>> +}
>>>
>>> Thanks,
>>> Andrei
>>
>> --
>> BR,
>> Muhammad Usama Anjum

-- 
BR,
Muhammad Usama Anjum
