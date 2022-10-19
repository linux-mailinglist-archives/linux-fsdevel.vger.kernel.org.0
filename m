Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB77603A80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 09:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJSHSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 03:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJSHSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:18:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D21374E1B;
        Wed, 19 Oct 2022 00:18:47 -0700 (PDT)
Received: from [192.168.10.9] (unknown [39.45.244.84])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 80F14660226D;
        Wed, 19 Oct 2022 08:18:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666163924;
        bh=VkDI5i/Pl22E2KtCN0nS9Ker+LE1+QgT4B4a/b4pNiU=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=KpMUYZnkeOXjo9ePOz2KK7EL4Sd7Hkj5/HJRtjKwS6a74QNNvjRd1AsbUnnAN+Ywe
         kq9jMcrfo9ib19uyd99/GVyzVcwKh2csKeNN6z+/JgCYp3jQkZ8OTrBosbXFjX1z/F
         o2AL9hhyJ3aB6wisCTdvcmlhRdp4ZFAQ/B5nKwNr+owmBUZNXfMHQZwbDfAvLUmPge
         ut6xmas4kVfGXADhb6ofOMpf21Wf9O35VFgIHt0wjO6UMFB0wdJuVdS/Ytf1uddomQ
         zr4FoJ4jLp1HsJetxT/Nxt/NsJqoc3TnJavlt2cZASXfPLPd2/IZniD0rZ5u6COQhF
         rteXrp2M7KDPQ==
Message-ID: <5725c4e2-e0b3-7573-5198-da6bb9637f3b@collabora.com>
Date:   Wed, 19 Oct 2022 12:18:35 +0500
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
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <Y0T2l3HaH2MU8M9m@gmail.com>
 <20221014134802.1361436-1-mdanylo@google.com>
 <474513c0-4ff9-7978-9d77-839fe775d04c@collabora.com>
 <CABb0KFGCm=K2X3-O=y3BJN85sT2C-y+XZRtLxnuabuOg+OrHwQ@mail.gmail.com>
 <17d7d6f5-21dc-37e1-6843-29c77a0e14b6@collabora.com>
 <CABb0KFFGRgy9D212skxxFMsHV5n3qjqUP9d-bQaWLUmtH46H3A@mail.gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFFGRgy9D212skxxFMsHV5n3qjqUP9d-bQaWLUmtH46H3A@mail.gmail.com>
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

On 10/18/22 10:17 PM, Michał Mirosław wrote:
> On Tue, 18 Oct 2022 at 15:23, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 10/18/22 4:11 PM, Michał Mirosław wrote:
>>> On Tue, 18 Oct 2022 at 12:36, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
> [...]
>>>>     * @start:             Starting address
>>>>     * @len:               Length of the region
>>>>     * @vec:               Output page_region struct array
>>>>     * @vec_len:           Length of the page_region struct array
>>>>     * @max_out_page:      Optional max output pages (It must be less than
>>>> vec_len if specified)
>>>
>>> Why is it required to be less than vec_len? vec_len effectively
>>> specifies max number of ranges to find, and this new additional field
>>> counts pages, I suppose?
>>> BTW, if we count pages, then what size of them? Maybe using bytes
>>> (matching start/len fields) would be more consistent?
>> Yes, it if for counting pages. As the regions can have multiple pages,
>> user cannot specify through the number of regions that how many pages
>> does he need. Page size is used here as well like the start and len.
>> This is optional argument as this is only needed to emulate the Windows
>> syscall getWriteWatch.
> 
> I'm wondering about the condition that max_out_page < vec_len. Since
> both count different things (pages vs ranges) I would expect there is
> no strict relation between them and information returned is as much as
> fits both (IOW: at most vec_len ranges spanning not more than
> max_out_page pages). The field's name and description I'd suggest
> improving: maybe 'max_pages' with a comment that 0 = unlimited?
Correct, max_pages with this comment is what I want. I'll update. 
vec_len represents the total number of the page_range array elements. If 
the pages which we want to return are sparse or the consective pages 
have different flags, we'll only return one page in one page_range 
struct. In this case if someone has specified max_pages to be 10, 
vec_len must be at least 10 to keep store the 10 pages. So max_pages <= 
vec_len.

> 
> [...]
>>>> /* Special flags */
>>>> #define PAGEMAP_NO_REUSED_REGIONS       0x1
>>>
>>> What does this flag do?
>> Some non-dirty pages get marked as dirty because of the kernel's
>> internal activity. The dirty bit of the pages is stored in the VMA flags
>> and in the per page flags. If any of these two bits are set, the page is
>> considered to be dirty. Suppose you have cleared the dirty bit of half
>> of VMA which will be done by splitting the VMA and clearing dirty flag
>> in the half VMA and the pages in it. Now kernel may decide to merge the
>> VMAs again as dirty bit of VMAs isn't considered if the VMAs should be
>> merged. So the half VMA becomes dirty again. This splitting/merging
>> costs performance. The application receives a lot of pages which aren't
>> dirty in reality but marked as dirty. Performance is lost again here.
>>
>> This PAGEMAP_NO_REUSED_REGIONS flag is used to don't depend on the dirty
>> flag in the VMA flags. It only depends on the individual page dirty bit.
>> With doing this, the new memory regions which are just created, doesn't
>> look like dirty when seen with the IOCTL, but look dirty when seen from
>> pagemap. This seems okay as the user of this flag know the implication
>> of using it.
> 
> Thanks for explaining! Could you include this as a comment in the patch?
Will do.

> 
> Best Regards
> Michał Mirosław
