Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B70E70BBBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjEVL1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 07:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjEVL1j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 07:27:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A709A3;
        Mon, 22 May 2023 04:26:23 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.155.11.156])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2957166031C5;
        Mon, 22 May 2023 12:26:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684754778;
        bh=LQG2IlUMjHSbgYMY07PFPfmnRDnifZ4ZmeuWipX+Des=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=UDra9+daVWN3ILIqe8Nvyz4bfNp2gNAq+NWv458WpSCRF3UqLR4qak0MSucQAed0G
         IP5gAf1sUCB6OeenfcuLa+uX3RZpgsCZRhpsJGg8j63MNAZ70bKIVVib/CF+0xdF9b
         DJk+wDhGVQ7BT1ht1hPNLeXN/vLTYotqPAttoDeHUs9HvIdNjapqRURe/coyuUyHil
         FKsdHGlj1gaD+fKcrxLAT1e5sIv6H/Js32UArp95cqBHxOhByMWq7Wg1EuGycodHdB
         D/DsELoIgNwdjqGMyumWPBoiDldhwQ30UHl+b8a3gWUBuYDfE6A1nD8dln8sfjgtVJ
         kCwTivpdmn1oQ==
Message-ID: <0edfaf12-66f2-86d3-df1c-f5dff10fb743@collabora.com>
Date:   Mon, 22 May 2023 16:26:07 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH RESEND v15 2/5] fs/proc/task_mmu: Implement IOCTL to get
 and optionally clear info about PTEs
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org
References: <20230420060156.895881-1-usama.anjum@collabora.com>
 <20230420060156.895881-3-usama.anjum@collabora.com>
 <fd9ddd43-6737-88bd-4054-3d5b94534271@collabora.com> <ZEkxh6dbnAOuYuJj@x1n>
 <ff17a13f-ccc2-fc39-7731-6d794c7dd980@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ff17a13f-ccc2-fc39-7731-6d794c7dd980@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/23 3:24 PM, Muhammad Usama Anjum wrote:
> On 4/26/23 7:13 PM, Peter Xu wrote:
>> Hi, Muhammad,
>>
>> On Wed, Apr 26, 2023 at 12:06:23PM +0500, Muhammad Usama Anjum wrote:
>>> On 4/20/23 11:01 AM, Muhammad Usama Anjum wrote:
>>>> +/* Supported flags */
>>>> +#define PM_SCAN_OP_GET	(1 << 0)
>>>> +#define PM_SCAN_OP_WP	(1 << 1)
>>> We have only these flag options available in PAGEMAP_SCAN IOCTL.
>>> PM_SCAN_OP_GET must always be specified for this IOCTL. PM_SCAN_OP_WP can
>>> be specified as need. But PM_SCAN_OP_WP cannot be specified without
>>> PM_SCAN_OP_GET. (This was removed after you had asked me to not duplicate
>>> functionality which can be achieved by UFFDIO_WRITEPROTECT.)
>>>
>>> 1) PM_SCAN_OP_GET | PM_SCAN_OP_WP
>>> vs
>>> 2) UFFDIO_WRITEPROTECT
>>>
>>> After removing the usage of uffd_wp_range() from PAGEMAP_SCAN IOCTL, we are
>>> getting really good performance which is comparable just like we are
>>> depending on SOFT_DIRTY flags in the PTE. But when we want to perform wp,
>>> PM_SCAN_OP_GET | PM_SCAN_OP_WP is more desirable than UFFDIO_WRITEPROTECT
>>> performance and behavior wise.
>>>
>>> I've got the results from someone else that UFFDIO_WRITEPROTECT block
>>> pagefaults somehow which PAGEMAP_IOCTL doesn't. I still need to verify this
>>> as I don't have tests comparing them one-to-one.
>>>
>>> What are your thoughts about it? Have you thought about making
>>> UFFDIO_WRITEPROTECT perform better?
>>>
>>> I'm sorry to mention the word "performance" here. Actually we want better
>>> performance to emulate Windows syscall. That is why we are adding this
>>> functionality. So either we need to see what can be improved in
>>> UFFDIO_WRITEPROTECT or can I please add only PM_SCAN_OP_WP back in
>>> pagemap_ioctl?
>>
>> I'm fine if you want to add it back if it works for you.  Though before
>> that, could you remind me why there can be a difference on performance?
> I've looked at the code again and I think I've found something. Lets look
> at exact performance numbers:
> 
> I've run 2 different tests. In first test UFFDIO_WRITEPROTECT is being used
> for engaging WP. In second test PM_SCAN_OP_WP is being used. I've measured
> the average write time to the same memory which is being WP-ed and total
> time of execution of these APIs:
> 
> **avg write time:**
> | No of pages            | 2000 | 8192 | 100000 | 500000 |
> |------------------------|------|------|--------|--------|
> | UFFDIO_WRITEPROTECT    | 2200 | 2300 | 4100   | 4200   |
> | PM_SCAN_OP_WP          | 2000 | 2300 | 2500   | 2800   |
> 
> **Execution time measured in rdtsc:**
> | No of pages            | 2000 | 8192  | 100000 | 500000 |
> |------------------------|------|-------|--------|--------|
> | UFFDIO_WRITEPROTECT    | 3200 | 14000 | 59000  | 58000  |
> | PM_SCAN_OP_WP          | 1900 | 7000  | 38000  | 40000  |
> 
> Avg write time for UFFDIO_WRITEPROTECT is 1.3 times slow. The execution
> time is 1.5 times slower in the case of UFFDIO_WRITEPROTECT. So
> UFFDIO_WRITEPROTECT is making writes slower to the pages and execution time
> is also slower.
> 
> This proves that PM_SCAN_OP_WP is better than UFFDIO_WRITEPROTECT. Although
> PM_SCAN_OP_WP and UFFDIO_WRITEPROTECT have been implemented differently. We
> should have seen no difference in performance. But we have quite a lot of
> difference in performance here. PM_SCAN_OP_WP takes read mm lock, uses
> walk_page_range() to walk over pages which finds VMAs from address ranges
> to walk over them and pagemap_scan_pmd_entry() is handling most of the work
> including tlb flushing. UFFDIO_WRITEPROTECT is also taking the mm lock and
> iterating from all the different page directories until a pte is found and
> then flags are updated there and tlb is flushed for every pte.
> 
> My next deduction would be that we are getting worse performance as we are
> flushing tlb for one page at a time in case of UFFDIO_WRITEPROTECT. While
> we flush tlb for 512 pages (moslty) at a time in case of PM_SCAN_OP_WP.
> I've just verified this by adding some logs to the change_pte_range() and
> pagemap_scan_pmd_entry(). Logs are attached. I've allocated memory of 1000
> pages and write-protected it with UFFDIO_WRITEPROTECT and PM_SCAN_OP_WP.
> The logs show that UFFDIO_WRITEPROTECT has flushed tlb 1000 times of size 1
> page each time. While PM_SCAN_OP_WP has flushed only 3 times of bigger
> sizes. I've learned over my last experience that tlb flush is very
> expensive. Probably this is what we need to improve if we don't want to add
> PM_SCAN_OP_WP?
> 
> The UFFDIO_WRITEPROTECT uses change_pte_range() which is very generic
> function and I'm not sure if can try to not do tlb flushes if uffd_wp is
> true. We can try to do flush somewhere else and hopefully we should do only
> one flush if possible. It will not be so straight forward to move away from
> generic fundtion. Thoughts?
I've just tested this theory of not doing per pte flushes and only did one
flush on entire range in uffd_wp_range(). But it didn't improve the
situation either. I was wrong that tlb flushes may be the cause.


> 
> 
>> Thanks,
>>
> 

-- 
BR,
Muhammad Usama Anjum
