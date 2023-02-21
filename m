Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB22B69E724
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 19:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBUSKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 13:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjBUSJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:09:38 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EF92B63B;
        Tue, 21 Feb 2023 10:09:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VcDHv8z_1677002908;
Received: from 30.120.135.227(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcDHv8z_1677002908)
          by smtp.aliyun-inc.com;
          Wed, 22 Feb 2023 02:08:30 +0800
Message-ID: <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
Date:   Wed, 22 Feb 2023 02:08:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
To:     Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        bpf@vger.kernel.org
References: <Y9KtCc+4n5uANB2f@casper.infradead.org>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Y9KtCc+4n5uANB2f@casper.infradead.org>
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



On 2023/1/27 00:40, Matthew Wilcox wrote:
> I'd like to do another session on how the struct page dismemberment
> is going and what remains to be done.  Given how widely struct page is
> used, I think there will be interest from more than just MM, so I'd
> suggest a plenary session.
> 
> If I were hosting this session today, topics would include:
> 
> Splitting out users:
> 
>   - slab (done!)
>   - netmem (in progress)
>   - hugetlb (in akpm)
>   - tail pages (in akpm)
>   - page tables
>   - ZONE_DEVICE
> 
> Users that really should have their own types:
> 
>   - zsmalloc
>   - bootmem
>   - percpu
>   - buddy
>   - vmalloc
> 
> Converting filesystems to folios:
> 
>   - XFS (done)
>   - AFS (done)
>   - NFS (in progress)
>   - ext4 (in progress)
>   - f2fs (in progress)
>   - ... others?
> 
> Unresolved challenges:
> 
>   - mapcount
>   - AnonExclusive
>   - Splitting anon & file folios apart
>   - Removing PG_error & PG_private

I'm interested in this topic too, also I'd like to get some idea of the
future of the page dismemberment timeline so that I can have time to keep
the pace with it since some embedded use cases like Android are
memory-sensitive all the time.

Minor, it seems some apis still use ->lru field to chain bulk pages,
perhaps it needs some changes as well:
https://lore.kernel.org/r/20221222124412.rpnl2vojnx7izoow@techsingularity.net
https://lore.kernel.org/r/20230214190221.1156876-2-shy828301@gmail.com

Thanks,
Gao Xiang

> 
> This will probably all change before May.
> 
> I'd like to nominate Vishal Moola & Sidhartha Kumar as invitees based on
> their work to convert various functions from pages to folios.
