Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F7C6DAB4D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 12:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjDGKPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 06:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjDGKPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:15:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEFA8A5B;
        Fri,  7 Apr 2023 03:15:00 -0700 (PDT)
Received: from [192.168.10.39] (unknown [119.155.57.40])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 637A46603131;
        Fri,  7 Apr 2023 11:14:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680862498;
        bh=9WP6pUpBkOjkcvFCjLQ/X0oqCxKf/YO1tbGg0IwaD8g=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=cXZpGyfbBDqWqi9rMvJzyzWzubRZSu9ZlI+W4zmtflNBkvxlViQd2BU5RAr7Rb2Xb
         zgsym/vALXf5K1nMX2MfNXL6VmHmmDgVMTocbmjp2LTDUH4Xz43C+q5YYfHLYHz7ho
         9viO3eJkjQUYJvB8MB6IMDAWq0Xqn8UXep3s6yZTtXm1X9FbaJW0B5blLUvnpy6Zge
         aU5fIqi3eBVWRKrouL0yLn7dgictkTDyK0VYY1yyUVZaH52po+CYg5e0Mgs1M3PWmy
         wByDH8kZ/Qwiet4sxyGVYesTr62q6iKAr98uEPY6dzO4DUJJrmruewJ9traJ8MEioM
         X06VRpYxIA9LQ==
Message-ID: <b3e4d688-b96f-7c44-a6be-375d44263c85@collabora.com>
Date:   Fri, 7 Apr 2023 15:14:47 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
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
Subject: Re: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230406074005.1784728-1-usama.anjum@collabora.com>
 <20230406074005.1784728-3-usama.anjum@collabora.com>
 <CABb0KFFTb3LCbyPWLSodtntw=tizYki-pc4nSHBmQOFhKoNYfA@mail.gmail.com>
 <b737dceb-a228-7ffe-0758-421505f1a61d@collabora.com>
 <CABb0KFF+sKSv7jdxBbXpt5A2WO83tKb9viq-kKurXN_e1VcFhQ@mail.gmail.com>
 <c535ce4a-d7da-1ce2-9883-7cefb6dd88a2@collabora.com>
 <CABb0KFE8pn+VORr8c=HWzKzJ5L5ZBRZMg2Q1dEZGU9gLqGZNLQ@mail.gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFE8pn+VORr8c=HWzKzJ5L5ZBRZMg2Q1dEZGU9gLqGZNLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/7/23 3:04 PM, Michał Mirosław wrote:
> On Fri, 7 Apr 2023 at 11:35, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> On 4/7/23 12:23 PM, Michał Mirosław wrote:
>>> On Thu, 6 Apr 2023 at 23:12, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>> On 4/7/23 1:12 AM, Michał Mirosław wrote:
>>>>> On Thu, 6 Apr 2023 at 09:40, Muhammad Usama Anjum
>>>>> <usama.anjum@collabora.com> wrote:
>>>>> [...]
>>>>>> --- a/fs/proc/task_mmu.c
>>>>>> +++ b/fs/proc/task_mmu.c
>>>>> [...]
>>>>>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>>>>>> +                                 unsigned long end, struct mm_walk *walk)
>>>>>> +{
>>> [...]
>>>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>>> +       ptl = pmd_trans_huge_lock(pmd, vma);
>>>>>> +       if (ptl) {
>>>>> [...]
>>>>>> +               return ret;
>>>>>> +       }
>>>>>> +process_smaller_pages:
>>>>>> +       if (pmd_trans_unstable(pmd))
>>>>>> +               return 0;
>>>>>
>>>>> Why pmd_trans_unstable() is needed here and not only after split_huge_pmd()?
>>>> I'm not entirely sure. But the idea is if THP is unstable, we should
>>>> return. As it doesn't seem like after splitting THP can be unstable, we
>>>> should not check it. Do you agree with the following?
>>>
>>> The description of pmd_trans_unstable() [1] seems to indicate that it
>>> is needed only after split_huge_pmd().
>>>
>>> [1] https://elixir.bootlin.com/linux/v6.3-rc5/source/include/linux/pgtable.h#L1394
>> Sorry, yeah pmd_trans_unstable() is need after split. But it is also needed
>> in normal case when ptl is NULL to rule out the case if pmd is unstable
>> before performing operation on normal pages:
>>
>> ptl = pmd_trans_huge_lock(pmd, vma);
>> if (ptl) {
>> ...
>> }
>> if (pmd_trans_unstable(pmd))
>>         return 0;
>>
>> This file has usage examples of pmd_trans_unstable():
>>
>> https://elixir.bootlin.com/linux/v6.3-rc5/source/fs/proc/task_mmu.c#L634
>> https://elixir.bootlin.com/linux/v6.3-rc5/source/fs/proc/task_mmu.c#L1195
>> https://elixir.bootlin.com/linux/v6.3-rc5/source/fs/proc/task_mmu.c#L1543
>> https://elixir.bootlin.com/linux/v6.3-rc5/source/fs/proc/task_mmu.c#L1887
>>
>> So we are good with what we have in this patch.
> 
> Shouldn't we signal ACTION_AGAIN then in order to call .pte_hole?
I'm not sure. I've not done research on it if we need to signal
ACTION_AGAIN as this function pagemap_scan_pmd_entry() mimics how
pagemap_pmd_range() handles reads to the pagemap file. pagemap_pmd_range()
isn't doing anything if pmd is unstable. Hence we also not doing anything.

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
