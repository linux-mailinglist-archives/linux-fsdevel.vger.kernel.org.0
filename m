Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3826760DFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 11:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjGYJJO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 05:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGYJJN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:09:13 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC37FD;
        Tue, 25 Jul 2023 02:09:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R9B6T3cgDz4f3nwh;
        Tue, 25 Jul 2023 17:09:05 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLMykb9k8EQTOw--.22011S3;
        Tue, 25 Jul 2023 17:09:07 +0800 (CST)
Subject: Re: [PATCH 1/2] softirq: fix integer overflow in function show_stat()
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
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
Message-ID: <3b1ba209-58c8-b2b6-115a-6c43cba80098@huaweicloud.com>
Date:   Tue, 25 Jul 2023 17:09:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6e38e31f-4413-1aff-8973-5c3d660bedea@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBXwLMykb9k8EQTOw--.22011S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar18JF1ftr4fCFyxury7GFg_yoW8Ar1rpF
        W7t3WUKr4kCFyIyrn2yr1kWr4Ikw48Jay3Zr15C340vFZ8Ar9IgF47KrWYga47ur9agw4F
        va12g3s7CFyUZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/25 10:00, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/7/24 21:50, Matthew Wilcox wrote:
>> On Mon, Jul 24, 2023 at 09:22:23PM +0800, thunder.leizhen@huaweicloud.com wrote:
>>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>>
>>> The statistics function of softirq is supported by commit aa0ce5bbc2db
>>> ("softirq: introduce statistics for softirq") in 2009. At that time,
>>> 64-bit processors should not have many cores and would not face
>>> significant count overflow problems. Now it's common for a processor to
>>> have hundreds of cores. Assume that there are 100 cores and 10
>>> TIMER_SOFTIRQ are generated per second, then the 32-bit sum will be
>>> overflowed after 50 days.
>>
>> 50 days is long enough to take a snapshot.  You should always be using
>> difference between, not absolute values, and understand that they can
>> wrap.  We only tend to change the size of a counter when it can wrap
>> sufficiently quickly that we might miss a wrap (eg tens of seconds).

Sometimes it can take a long time to view it again. For example, it is
possible to run a complete business test for hours or even days, and
then calculate the average.

> 
> Yes, I think patch 2/2 can be dropped. I reduced the number of soft
> interrupts generated in one second, and actually 100+ or 1000 is normal.
> But I think patch 1/2 is necessary. The sum of the output scattered values
> does not match the output sum. To solve this problem, we only need to
> adjust the type of a local variable.

However, it is important to consider that when the local variable is changed
to u64, the output string becomes longer. It is not clear if the user-mode
program parses it only by u32.

> 
> 
>>
>> .
>>
> 

-- 
Regards,
  Zhen Lei

