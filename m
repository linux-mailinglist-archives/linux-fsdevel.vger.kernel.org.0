Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80639602CD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 15:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiJRNXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 09:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJRNXD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:23:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901F8C14AE;
        Tue, 18 Oct 2022 06:23:00 -0700 (PDT)
Received: from [192.168.10.9] (unknown [39.45.244.84])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DB6EF660038D;
        Tue, 18 Oct 2022 14:22:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666099379;
        bh=CrRA+AfW/H247GHc3iNeat2Pq8dFOUMFUrcmgZ+W+6Q=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Pez2BQqQFuDV+R76tOHBys8fij352NSWvkhmJbJSh5jYJKPrG+OBfzMqAgSkHR8GD
         j7374RrhW+mbgjaBj9iZAf6303tdxjl1X0X2V6HgnAoFNFtNxLGxmZnQ3KtZO+C+w1
         s/LRxJlnBWyA5e6pGd2vQY/lutek/yVnkmoChyyA1VTSUfJPxH9YKJ0dqREjqwrJ+L
         gJr/qAQXP5M/qRE8obN6x2Z7e/z8UUWuzWE9CQ3jNdr/vBXjPZMY341CNQt0r/NEet
         1KBRvpssImd1PxldEQDJ3nUAgDOQHLyE73bijKhoRxQ8O9r4m3X+9vCZ615QWcGAuK
         X3U13xoa6JkAg==
Message-ID: <17d7d6f5-21dc-37e1-6843-29c77a0e14b6@collabora.com>
Date:   Tue, 18 Oct 2022 18:22:48 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Danylo Mocherniuk <mdanylo@google.com>, avagin@gmail.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, corbet@lwn.net, david@redhat.com,
        kernel@collabora.com, krisman@collabora.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        peter.enderborg@sony.com, shuah@kernel.org,
        viro@zeniv.linux.org.uk, willy@infradead.org, figiel@google.com,
        kyurtsever@google.com, Paul Gofman <pgofman@codeweavers.com>,
        surenb@google.com
Subject: Re: [PATCH v3 0/4] Implement IOCTL to get and clear soft dirty PTE
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <Y0T2l3HaH2MU8M9m@gmail.com>
 <20221014134802.1361436-1-mdanylo@google.com>
 <474513c0-4ff9-7978-9d77-839fe775d04c@collabora.com>
 <CABb0KFGCm=K2X3-O=y3BJN85sT2C-y+XZRtLxnuabuOg+OrHwQ@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFGCm=K2X3-O=y3BJN85sT2C-y+XZRtLxnuabuOg+OrHwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/18/22 4:11 PM, Michał Mirosław wrote:
> On Tue, 18 Oct 2022 at 12:36, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> [...]
>> I've included the masks which the CRIU developers have specified.
>> max_out_page is another new optional variable which is needed to
>> terminate the operation without visiting all the pages after finding the
>> max_out_page number of desired pages. There is no way to terminate the
>> operation without this variable.
>>
>> How does the interface looks now? Please comment.
>>
>> /* PAGEMAP IOCTL */
>> #define PAGEMAP_GET             _IOWR('f', 16, struct pagemap_sd_args)
>> #define PAGEMAP_CLEAR           _IOWR('f', 17, struct pagemap_sd_args)
>> #define PAGEMAP_GET_AND_CLEAR   _IOWR('f', 18, struct pagemap_sd_args)
> 
> Why are three IOCTLs needed? Could CLEAR be a flag (like the
> PAGEMAP_NO_REUSED_REGIONS) or 'cmask' and GET be implied when vec !=
> NULL?
Makes sense. Yes, this can be done.

> 
>> /* Bits are set in the bitmap of the page_region and masks in
>> pagemap_sd_args */
>> #define PAGE_IS_SD      1 << 0
>> #define PAGE_IS_FILE    1 << 1
>> #define PAGE_IS_PRESENT 1 << 2
>> #define PAGE_IS_SWAPED  1 << 3
>>
>> /**
>>    * struct page_region - Page region with bitmap flags
>>    * @start:     Start of the region
>>    * @len:       Length of the region
>>    * bitmap:     Bits sets for the region
>>    */
>> struct page_region {
>>          __u64 start;
>>          __u64 len;
>>          __u64 bitmap;
>> };
> 
> Could you explain what units start and len are using? Are they bytes
> or pages (what size)?
These are page sizes. Start must be the starting address of the page. 
Length don't need to be the exact multiple of the page size. All the 
pages in the length are included just like mincore() syscall.

> 
>> /**
>>    * struct pagemap_sd_args - Soft-dirty IOCTL argument
> 
> Nit: it's not soft-dirty-specific anymore. Maybe "pagemap_scan_args"?
> 
>>    * @start:             Starting address
>>    * @len:               Length of the region
>>    * @vec:               Output page_region struct array
>>    * @vec_len:           Length of the page_region struct array
>>    * @max_out_page:      Optional max output pages (It must be less than
>> vec_len if specified)
> 
> Why is it required to be less than vec_len? vec_len effectively
> specifies max number of ranges to find, and this new additional field
> counts pages, I suppose?
> BTW, if we count pages, then what size of them? Maybe using bytes
> (matching start/len fields) would be more consistent?
Yes, it if for counting pages. As the regions can have multiple pages, 
user cannot specify through the number of regions that how many pages 
does he need. Page size is used here as well like the start and len. 
This is optional argument as this is only needed to emulate the Windows 
syscall getWriteWatch.

> 
>>    * @flags:             Special flags for the IOCTL
>>    * @rmask:             Special flags for the IOCTL
>>    * @amask:             Special flags for the IOCTL
>>    * @emask:             Special flags for the IOCTL
>>    * @__reserved:                Reserved member to preserve data alignment. Must be 0.
>>    */
>> struct pagemap_sd_args {
>>          __u64 __user start;
>>          __u64 len;
>>          __u64 __user vec; // page_region
>>          __u64 vec_len;    // sizeof(page_region)
>>          __u32 flags;      // special flags
>>          __u32 rmask;
>>          __u32 amask;
>>          __u32 emask;
>>          __u32 max_out_page;
>>          __u32 __reserved;
>> };
>>
>> /* Special flags */
>> #define PAGEMAP_NO_REUSED_REGIONS       0x1
> 
> What does this flag do?
Some non-dirty pages get marked as dirty because of the kernel's 
internal activity. The dirty bit of the pages is stored in the VMA flags 
and in the per page flags. If any of these two bits are set, the page is 
considered to be dirty. Suppose you have cleared the dirty bit of half 
of VMA which will be done by splitting the VMA and clearing dirty flag 
in the half VMA and the pages in it. Now kernel may decide to merge the 
VMAs again as dirty bit of VMAs isn't considered if the VMAs should be 
merged. So the half VMA becomes dirty again. This splitting/merging 
costs performance. The application receives a lot of pages which aren't 
dirty in reality but marked as dirty. Performance is lost again here.

This PAGEMAP_NO_REUSED_REGIONS flag is used to don't depend on the dirty 
flag in the VMA flags. It only depends on the individual page dirty bit. 
With doing this, the new memory regions which are just created, doesn't 
look like dirty when seen with the IOCTL, but look dirty when seen from 
pagemap. This seems okay as the user of this flag know the implication 
of using it.

> 
> Best Regards
> Michał Mirosław
