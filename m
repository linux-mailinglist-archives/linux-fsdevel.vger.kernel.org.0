Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC276EBEA8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Apr 2023 12:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjDWKph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Apr 2023 06:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWKpg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Apr 2023 06:45:36 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39669171F;
        Sun, 23 Apr 2023 03:45:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vgjcqv._1682246726;
Received: from 30.97.49.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vgjcqv._1682246726)
          by smtp.aliyun-inc.com;
          Sun, 23 Apr 2023 18:45:28 +0800
Message-ID: <02f7dcf5-1aad-0f8b-24e7-a22c0685fc42@linux.alibaba.com>
Date:   Sun, 23 Apr 2023 18:45:25 +0800
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
 <20230423094901.1867-1-hdanton@sina.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230423094901.1867-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/4/23 17:49, Hillf Danton wrote:
> On 23 Apr 2023 16:35:26 +0800 Gao Xiang <hsiangkao@linux.alibaba.com>
>> On 2023/4/23 16:12, Hillf Danton wrote:
>>> On 23 Apr 2023 14:08:49 +0800 Gao Xiang <hsiangkao@linux.alibaba.com>
>>>> On 2023/4/22 13:18, Hillf Danton wrote:
>>>>> On 21 Apr 2023 15:12:45 -0700 Douglas Anderson <dianders@chromium.org>
>>>>>> Add a variant of folio_lock() that can timeout. This is useful to
>>>>>> avoid unbounded waits for the page lock in kcompactd.
>>>>>
>>>>> Given no mutex_lock_timeout() (perhaps because timeout makes no sense for
>>>>> spinlock), I suspect your fix lies in the right layer. If waiting for
>>>>> page under IO causes trouble for you, another simpler option is make
>>>>> IO faster (perhaps all you can do) for instance. If kcompactd is waken
>>>>> up by kswapd, waiting for slow IO is the right thing to do.
>>>>
>>>> A bit out of topic.  That is almost our original inital use scenarios for
>>>
>>> Thanks for taking a look.
>>>
>>>> EROFS [1] although we didn't actually test Chrome OS, there lies four
>>>> points:
>>>>
>>>>     1) 128kb compressed size unit is not suitable for memory constraint
>>>>        workload, especially memory pressure scenarios, that amplify both I/Os
>>>>        and memory footprints (EROFS was initially optimized with 4KiB
>>>>        pclusters);
>>>
>>> Feel free to take another one at 2M THP [1].
>>>
>>> [1] https://lore.kernel.org/lkml/20230418191313.268131-1-hannes@cmpxchg.org/
>>
>> Honestly I don't catch your point here, does THP has some relationship with
> 
> THP tests ended without the help of timeout helpers.
> 
>> this?  Almost all smartphones (but I don't know Chromebook honestly) didn't
>> use THP at that time.
>>>>
>>>>     2) If you turn into a small compressed size (e.g. 4 KiB), some fs behaves
>>>>        ineffective since its on-disk compressed index isn't designed to be
>>>>        random accessed (another in-memory cache for random access) so you have
>>>>        to count one by one to calculate physical data offset if cache miss;
>>>>
>>>>     3) compressed data needs to take extra memory during I/O (especially
>>>>        low-ended devices) that makes the cases worse and our camera app
>>>>        workloads once cannot be properly launched under heavy memory pressure,
>>>>        but in order to keep user best experience we have to keep as many as
>>>>        apps active so that it's hard to kill apps directly.  So inplace I/O +
>>>>        decompression is needed in addition to small compressed sizes for
>>>>        overall performance.
>>>
>>> Frankly nowadays I have no interest in running linux with <16M RAM for example.
>>
>> Our cases are tested on 2016-2018 devices under 3 to 6 GB memory if you
>> take a glance at the original ATC paper, the page 9 (section 5.1) wrote:
>> "However, it costed too much CPU and memory resources, and when trying to
>>   run a camera application, the phone froze for tens of seconds before it
>>   finally failed."
>>
>> I have no idea how 16M RAM here comes from but smartphones doesn't have
>> such limited memory.  In brief, if you runs few app, you have few problem.
>> but as long as you keeps more apps in background (and running), then the
>> memory will eventually suffer pressure.
> 
> Given no complaints in case of running 16 apps with 1G RAM for instance,
> what is the point of running 256 apps with the same RAM? And adding changes

I don't think the `ill-designed` word is helpful to the overall topic.

I'm not sure if my description is confusing:

  1) First, I never said running 256 apps with the same RAM.  In fact, in 2018
     there are indeed some phones still with 1G RAM, if my memory is correct,
     such 1G phones couldn't run 16 latest mainstream super apps at the same time
     smoothly, and, previously compression will lead this worse.  Even such
     phones cannot use a full Android but a minimized Android Go [1] instead.
     The worst case I've heard on phones with 1G RAM would be "after you checked
     a new message from friends on a superapp by switch out, another previous
     one with some incomplete registeration form could be killed and you have
     to restart and refill the form."

  2) apps and baseos can be upgraded over time, especially apps, since Android
     ecosystem is open.  It's hard to get over it.

Thanks,
Gao Xiang

> because of ill designed phone products?

[1] https://developer.android.com/guide/topics/androidgo
