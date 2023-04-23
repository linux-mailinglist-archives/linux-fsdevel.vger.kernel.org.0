Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254506EBE07
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Apr 2023 10:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjDWIfi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Apr 2023 04:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDWIfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Apr 2023 04:35:36 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1037B1BD1;
        Sun, 23 Apr 2023 01:35:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VgjFNh3_1682238926;
Received: from 30.97.49.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VgjFNh3_1682238926)
          by smtp.aliyun-inc.com;
          Sun, 23 Apr 2023 16:35:29 +0800
Message-ID: <d3ef39e8-3ef4-f6f5-7405-328f72d42bb7@linux.alibaba.com>
Date:   Sun, 23 Apr 2023 16:35:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, ying.huang@intel.com
References: <20230421221249.1616168-1-dianders@chromium.org>
 <20230422051858.1696-1-hdanton@sina.com>
 <20230423081203.1812-1-hdanton@sina.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230423081203.1812-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Hillf,

On 2023/4/23 16:12, Hillf Danton wrote:
> On 23 Apr 2023 14:08:49 +0800 Gao Xiang <hsiangkao@linux.alibaba.com>
>> On 2023/4/22 13:18, Hillf Danton wrote:
>>> On 21 Apr 2023 15:12:45 -0700 Douglas Anderson <dianders@chromium.org>
>>>> Add a variant of folio_lock() that can timeout. This is useful to
>>>> avoid unbounded waits for the page lock in kcompactd.
>>>
>>> Given no mutex_lock_timeout() (perhaps because timeout makes no sense for
>>> spinlock), I suspect your fix lies in the right layer. If waiting for
>>> page under IO causes trouble for you, another simpler option is make
>>> IO faster (perhaps all you can do) for instance. If kcompactd is waken
>>> up by kswapd, waiting for slow IO is the right thing to do.
>>
>> A bit out of topic.  That is almost our original inital use scenarios for
> 
> Thanks for taking a look.
> 
>> EROFS [1] although we didn't actually test Chrome OS, there lies four
>> points:
>>
>>    1) 128kb compressed size unit is not suitable for memory constraint
>>       workload, especially memory pressure scenarios, that amplify both I/Os
>>       and memory footprints (EROFS was initially optimized with 4KiB
>>       pclusters);
> 
> Feel free to take another one at 2M THP [1].
> 
> [1] https://lore.kernel.org/lkml/20230418191313.268131-1-hannes@cmpxchg.org/

Honestly I don't catch your point here, does THP has some relationship with
this?  Almost all smartphones (but I don't know Chromebook honestly) didn't
use THP at that time.

>>
>>    2) If you turn into a small compressed size (e.g. 4 KiB), some fs behaves
>>       ineffective since its on-disk compressed index isn't designed to be
>>       random accessed (another in-memory cache for random access) so you have
>>       to count one by one to calculate physical data offset if cache miss;
>>
>>    3) compressed data needs to take extra memory during I/O (especially
>>       low-ended devices) that makes the cases worse and our camera app
>>       workloads once cannot be properly launched under heavy memory pressure,
>>       but in order to keep user best experience we have to keep as many as
>>       apps active so that it's hard to kill apps directly.  So inplace I/O +
>>       decompression is needed in addition to small compressed sizes for
>>       overall performance.
> 
> Frankly nowadays I have no interest in running linux with <16M RAM for example.

Our cases are tested on 2016-2018 devices under 3 to 6 GB memory if you
take a glance at the original ATC paper, the page 9 (section 5.1) wrote:
"However, it costed too much CPU and memory resources, and when trying to
  run a camera application, the phone froze for tens of seconds before it
  finally failed."

I have no idea how 16M RAM here comes from but smartphones doesn't have
such limited memory.  In brief, if you runs few app, you have few problem.
but as long as you keeps more apps in background (and running), then the
memory will eventually suffer pressure.

>>
>>    4) If considering real-time performance, some algorithms are not quite
>>       suitable for extreme pressure cases;
> 
> Neither in considering any perf under extreme memory pressure (16M or 64G RAM)
> because of crystally pure waste of time.

Personally I don't think so, if you'd like to land an effective compression
approach for end users and avoid user complaints (app lagging, app frozen,
etc).  I think these all need to be considered in practice.

Thanks,
Gao Xiang

>>
>>    etc.
>>
>> I could give more details on this year LSF/MM about this, although it's not
>> a new topic and I'm not a Android guy now.
> 
> Did you book the air ticket? How many bucks?
>>
>> [1] https://www.usenix.org/conference/atc19/presentation/gao
>>
>> Thanks,
>> Gao Xiang
