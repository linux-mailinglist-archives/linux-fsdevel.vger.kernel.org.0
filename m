Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD8769ED03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 03:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjBVCkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 21:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBVCkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 21:40:16 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047012CC48;
        Tue, 21 Feb 2023 18:40:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VcEfCHA_1677033609;
Received: from 30.97.49.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcEfCHA_1677033609)
          by smtp.aliyun-inc.com;
          Wed, 22 Feb 2023 10:40:10 +0800
Message-ID: <a328da48-a5aa-c31b-074c-d52132997afd@linux.alibaba.com>
Date:   Wed, 22 Feb 2023 10:40:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
To:     Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org
References: <Y9KtCc+4n5uANB2f@casper.infradead.org>
 <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
 <CAHbLzkqsyv6rw-RRvNcB0PoEE75qS9ZtmywhJYZbVA05d5tj5A@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAHbLzkqsyv6rw-RRvNcB0PoEE75qS9ZtmywhJYZbVA05d5tj5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/2/22 03:09, Yang Shi wrote:
> On Tue, Feb 21, 2023 at 10:08 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2023/1/27 00:40, Matthew Wilcox wrote:
>>> I'd like to do another session on how the struct page dismemberment
>>> is going and what remains to be done.  Given how widely struct page is
>>> used, I think there will be interest from more than just MM, so I'd
>>> suggest a plenary session.
>>>
>>> If I were hosting this session today, topics would include:
>>>
>>> Splitting out users:
>>>
>>>    - slab (done!)
>>>    - netmem (in progress)
>>>    - hugetlb (in akpm)
>>>    - tail pages (in akpm)
>>>    - page tables
>>>    - ZONE_DEVICE
>>>
>>> Users that really should have their own types:
>>>
>>>    - zsmalloc
>>>    - bootmem
>>>    - percpu
>>>    - buddy
>>>    - vmalloc
>>>
>>> Converting filesystems to folios:
>>>
>>>    - XFS (done)
>>>    - AFS (done)
>>>    - NFS (in progress)
>>>    - ext4 (in progress)
>>>    - f2fs (in progress)
>>>    - ... others?
>>>
>>> Unresolved challenges:
>>>
>>>    - mapcount
>>>    - AnonExclusive
>>>    - Splitting anon & file folios apart
>>>    - Removing PG_error & PG_private
>>
>> I'm interested in this topic too, also I'd like to get some idea of the
>> future of the page dismemberment timeline so that I can have time to keep
>> the pace with it since some embedded use cases like Android are
>> memory-sensitive all the time.
>>
>> Minor, it seems some apis still use ->lru field to chain bulk pages,
>> perhaps it needs some changes as well:
>> https://lore.kernel.org/r/20221222124412.rpnl2vojnx7izoow@techsingularity.net
>> https://lore.kernel.org/r/20230214190221.1156876-2-shy828301@gmail.com
> 
> The dm-crypt patches don't use list anymore. The bulk allocator still
> supports the list version, but so far there is no user, so it may be
> gone soon.

Thanks, it's just a detailed minor stuff relating to page->lru.  Currently
I'm no rush to evaluate/use it.

> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> This will probably all change before May.
>>>
>>> I'd like to nominate Vishal Moola & Sidhartha Kumar as invitees based on
>>> their work to convert various functions from pages to folios.
>>
