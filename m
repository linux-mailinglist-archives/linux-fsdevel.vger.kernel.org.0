Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6DC69ECF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 03:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjBVCiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 21:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBVCiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 21:38:20 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D522594B;
        Tue, 21 Feb 2023 18:38:17 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VcEEUep_1677033493;
Received: from 30.97.49.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcEEUep_1677033493)
          by smtp.aliyun-inc.com;
          Wed, 22 Feb 2023 10:38:14 +0800
Message-ID: <874be627-cb9e-bca6-4845-18dcd65f0f3f@linux.alibaba.com>
Date:   Wed, 22 Feb 2023 10:38:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org
References: <Y9KtCc+4n5uANB2f@casper.infradead.org>
 <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
 <Y/UiY/08MuA/tBku@casper.infradead.org>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Y/UiY/08MuA/tBku@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/2/22 03:58, Matthew Wilcox wrote:
> On Wed, Feb 22, 2023 at 02:08:28AM +0800, Gao Xiang wrote:
>> On 2023/1/27 00:40, Matthew Wilcox wrote:
>>> I'd like to do another session on how the struct page dismemberment
>>> is going and what remains to be done.  Given how widely struct page is
>>> used, I think there will be interest from more than just MM, so I'd
>>> suggest a plenary session.
>>
>> I'm interested in this topic too, also I'd like to get some idea of the
>> future of the page dismemberment timeline so that I can have time to keep
>> the pace with it since some embedded use cases like Android are
>> memory-sensitive all the time.
> 
> As you all know, I'm absolutely amazing at project management & planning
> and can tell you to the day when a feature will be ready ;-)

yeah, but this core stuff actually impacts various subsystems, it would
be better to get some in advance otherwise I'm not sure if I could have
extra slots to handle these.

> 
> My goal for 2023 is to get to a point where we (a) have struct page
> reduced to:
> 
> struct page {
> 	unsigned long flags;
> 	struct list_head lru;
> 	struct address_space *mapping;
> 	pgoff_t index;
> 	unsigned long private;
> 	atomic_t _mapcount;
> 	atomic_t _refcount;
> 	unsigned long memcg_data;
> #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> 	int _last_cpupid;
> #endif
> };
> 
> and (b) can build an allnoconfig kernel with:
> 
> struct page {
> 	unsigned long flags;
> 	unsigned long padding[5];
> 	atomic_t _mapcount;
> 	atomic_t _refcount;
> 	unsigned long padding2;
> #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> 	int _last_cpupid;
> #endif
> };

Okay, with the plan above, how to make it work with memdesc in the long
term?

Also in the future at least I'd like to know if it's possible / how to
get folio itself from page and how to know if some folio is actually
truncated or connected to some (or more) inodes.

Anyway, all of the above are interesting to me, and that could avoid
some extra useless folio adoption in the opposite direction.  Also I
could have more rough thoughts how to get page cache sharing work.

I could imagine many of them may be still in the preliminary form
for now, but some detailed plans would be much helpful.

> 
>> Minor, it seems some apis still use ->lru field to chain bulk pages,
>> perhaps it needs some changes as well:
>> https://lore.kernel.org/r/20221222124412.rpnl2vojnx7izoow@techsingularity.net
>> https://lore.kernel.org/r/20230214190221.1156876-2-shy828301@gmail.com
> 
> Yang Shi covered the actual (non-)use of the list version of the bulk
> allocator already, but perhaps more importantly, each page allocated
> by the bulk allocator is actually a separately tracked allocation.
> So the obvious translation of the bulk allocator from pages to folios
> is that it allocates N order-0 folios.
> 
> That may not be the best approach for all the users of the bulk allocator,
> so we may end up doing something different.  At any rate, use of page->lru
> isn't the problem here (yes, it's something that would need to change,
> but it's not a big conceptual problem).

Yes, I just would like to confirm how to use such apis in the long term.
Currently it's no rush for me but I tend to avoid using them in a vague
direction.

Thanks,
Gao Xiang

