Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682947652DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 13:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjG0Lsf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 07:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjG0Lse (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:48:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071182122;
        Thu, 27 Jul 2023 04:48:33 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.218.24])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE4986607057;
        Thu, 27 Jul 2023 12:48:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690458511;
        bh=0qxwSBYd7sM3osQHdzQ9jmOETl5u5FVEVXpJCyozE18=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=VwWHBy4Fz+Uq2ZgEVfz/g6zrk+uiQW8i288WOCqoUeKyYOZPSWRGPswZH9S4GjmjI
         elJ4o1Nc21T6uGBpPA4OMaU79ukYjTR6EFOZ8oQNI5xWQmuPWq8XEXZKbbwoDecklx
         KzPKIBcZwJ52uDt6FZzv6w6igb7g2jUHUbx/IcsmVww4JYwgu6IBR1k8X4/wy6JA7e
         hXzWGNky+83m0plmg16KCcnWLGNr9AjJwFzOTWwqvO39CXzVojFzPmaJraVo5xAf1n
         AoZswvD8VYINa6Z/6qVIh+3XCYT+VdeiuiyV03TYf/cP9aTOzIbBfmZz+MgvsgnHRJ
         wvuG9pLLO8YeA==
Message-ID: <7f124303-660e-8350-4628-2340550637b0@collabora.com>
Date:   Thu, 27 Jul 2023 16:48:10 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v26 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230727093637.1262110-1-usama.anjum@collabora.com>
 <20230727093637.1262110-3-usama.anjum@collabora.com>
 <CABb0KFFtjTve+uM=CTPChzUbJvJ=Tr3Q8espo_Rr_hutZPPAiw@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFFtjTve+uM=CTPChzUbJvJ=Tr3Q8espo_Rr_hutZPPAiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/27/23 4:40 PM, Michał Mirosław wrote:
> On Thu, 27 Jul 2023 at 11:37, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
>> the info about page table entries. The following operations are supported
>> in this ioctl:
>> - Get the information if the pages have Async Write-Protection enabled
>>   (``PAGE_IS_WPALLOWED``), have been written to (``PAGE_IS_WRITTEN``), file
>>   mapped (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``), swapped
>>   (``PAGE_IS_SWAPPED``) or page has pfn zero (``PAGE_IS_PFNZERO``).
>> - Find pages which have been written to and/or write protect
>>   (atomic ``PM_SCAN_WP_MATCHING + PM_SCAN_CHECK_WPASYNC``) the pages
>>   atomically. The (``PM_SCAN_WP_MATCHING``) is used to WP the matched
>>   pages. The (``PM_SCAN_CHECK_WPASYNC``) aborts the operation if
>>   non-Async-Write-Protected pages are found. Get is automatically performed
>>   if output buffer is specified.
>>
>> This IOCTL can be extended to get information about more PTE bits. The
>> entire address range passed by user [start, end) is scanned until either
>> the user provided buffer is full or max_pages have been found.
>>
>> Reviewed-by: Andrei Vagin <avagin@gmail.com>
>> Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
>> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> Thanks for all the work!
> 
> Small request below.
> 
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
> [...]
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +static unsigned long pagemap_thp_category(pmd_t pmd)
>> +{
>> +       unsigned long categories = 0;
>> +
>> +       if (pmd_present(pmd)) {
>> +               categories |= PAGE_IS_PRESENT;
>> +               if (!pmd_uffd_wp(pmd))
>> +                       categories |= PAGE_IS_WRITTEN;
>> +               if (is_zero_pfn(pmd_pfn(pmd)))
>> +                       categories |= PAGE_IS_PFNZERO;
>> +       } else if (is_swap_pmd(pmd)) {
>> +               categories |= PAGE_IS_SWAPPED;
>> +               if (!pmd_swp_uffd_wp(pmd))
>> +                       categories |= PAGE_IS_WRITTEN;
>> +       }
>> +
>> +       return categories;
>> +}
> [...]
>> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>> +
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +static unsigned long pagemap_hugetlb_category(pte_t pte)
>> +{
>> +       unsigned long categories = 0;
>> +
>> +       if (pte_present(pte)) {
>> +               categories |= PAGE_IS_PRESENT;
>> +               if (!huge_pte_uffd_wp(pte))
>> +                       categories |= PAGE_IS_WRITTEN;
>> +               if (!PageAnon(pte_page(pte)))
>> +                       categories |= PAGE_IS_FILE;
>> +               if (is_zero_pfn(pte_pfn(pte)))
>> +                       categories |= PAGE_IS_PFNZERO;
>> +       } else if (is_swap_pte(pte)) {
>> +               categories |= PAGE_IS_SWAPPED;
>> +               if (!pte_swp_uffd_wp_any(pte))
>> +                       categories |= PAGE_IS_WRITTEN;
>> +       }
>> +
>> +       return categories;
>> +}
> 
> Could you add PAGE_IS_HUGE for THP and HugeTLB pages? This would help
> maintaining checkpointed process'es page sizes by CRIU when THP is
> used.
Can be done.

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
