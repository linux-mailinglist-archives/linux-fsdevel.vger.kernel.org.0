Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F1B7627EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 02:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGZA7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 20:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGZA7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 20:59:20 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15FCBC;
        Tue, 25 Jul 2023 17:59:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R9bBp5Pnhz4f3kkW;
        Wed, 26 Jul 2023 08:59:14 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rHhb8Bk5rZFOw--.10487S3;
        Wed, 26 Jul 2023 08:59:15 +0800 (CST)
Subject: Re: [PATCH 1/2] softirq: fix integer overflow in function show_stat()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>
References: <20230724132224.916-1-thunder.leizhen@huaweicloud.com>
 <20230724132224.916-2-thunder.leizhen@huaweicloud.com>
 <ZL6BwiHhvQneJZYH@casper.infradead.org>
 <6e38e31f-4413-1aff-8973-5c3d660bedea@huaweicloud.com>
 <3b1ba209-58c8-b2b6-115a-6c43cba80098@huaweicloud.com>
 <ZL/pvjMMtlxvBSCm@casper.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <d6f00e09-757a-9935-bc22-c2a1d9c99c52@huaweicloud.com>
Date:   Wed, 26 Jul 2023 08:59:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZL/pvjMMtlxvBSCm@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBH_rHhb8Bk5rZFOw--.10487S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kAF4ftF1kWrWDuFWfZrb_yoW5JFWfpF
        W7t3Wjkr4kCFyIyrn2qrn7Xr12yw48J345Zrn8C3y8AFZ5Z3sagF47Kr4Y9Fyxur1Sgw4F
        vayjg3s7CFyDZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/25 23:26, Matthew Wilcox wrote:
> On Tue, Jul 25, 2023 at 05:09:05PM +0800, Leizhen (ThunderTown) wrote:
>> On 2023/7/25 10:00, Leizhen (ThunderTown) wrote:
>>> On 2023/7/24 21:50, Matthew Wilcox wrote:
>>>> On Mon, Jul 24, 2023 at 09:22:23PM +0800, thunder.leizhen@huaweicloud.com wrote:
>>>>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>>>>
>>>>> The statistics function of softirq is supported by commit aa0ce5bbc2db
>>>>> ("softirq: introduce statistics for softirq") in 2009. At that time,
>>>>> 64-bit processors should not have many cores and would not face
>>>>> significant count overflow problems. Now it's common for a processor to
>>>>> have hundreds of cores. Assume that there are 100 cores and 10
>>>>> TIMER_SOFTIRQ are generated per second, then the 32-bit sum will be
>>>>> overflowed after 50 days.
>>>>
>>>> 50 days is long enough to take a snapshot.  You should always be using
>>>> difference between, not absolute values, and understand that they can
>>>> wrap.  We only tend to change the size of a counter when it can wrap
>>>> sufficiently quickly that we might miss a wrap (eg tens of seconds).
>>
>> Sometimes it can take a long time to view it again. For example, it is
>> possible to run a complete business test for hours or even days, and
>> then calculate the average.
> 
> I've been part of teams which have done such multi-hour tests.  That
> isn't how monitoring was performed.  Instead snapshots were taken every
> minute or even more frequently, because we wanted to know how these
> counters were fluctuating during the test -- were there time periods
> when the number of sortirqs spiked, or was it constant during the test?
> 
>>> Yes, I think patch 2/2 can be dropped. I reduced the number of soft
>>> interrupts generated in one second, and actually 100+ or 1000 is normal.
>>> But I think patch 1/2 is necessary. The sum of the output scattered values
>>> does not match the output sum. To solve this problem, we only need to
>>> adjust the type of a local variable.
>>
>> However, it is important to consider that when the local variable is changed
>> to u64, the output string becomes longer. It is not clear if the user-mode
>> program parses it only by u32.
> 
> There's no need for the numbers to add up.  They won't anyway, because
> summing them is racy , so they'll always be a little off.

Okay, thanks for the reply. I got it. I just summed it up temporarily to
prove that integer overflow is possible, and there's no actual requirement.

> 
> .
> 

-- 
Regards,
  Zhen Lei

