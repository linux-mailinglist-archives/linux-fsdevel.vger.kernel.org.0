Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8FA4851E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 12:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbiAELdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 06:33:55 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:45607 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239769AbiAELdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:33:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V111xbZ_1641382428;
Received: from 30.21.164.223(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0V111xbZ_1641382428)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jan 2022 19:33:49 +0800
Message-ID: <8be4679f-632b-97e5-9e48-1e1a37727ddf@linux.alibaba.com>
Date:   Wed, 5 Jan 2022 19:33:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 2/2] sched/core: Uncookied force idle accounting per cpu
Content-Language: en-US
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1640262603-19339-3-git-send-email-CruzZhao@linux.alibaba.com>
 <CABk29NsP+sMQPRwS2e3zoeBsX1+p2aevFFO+i9GdB5VQ0ujEbA@mail.gmail.com>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <CABk29NsP+sMQPRwS2e3zoeBsX1+p2aevFFO+i9GdB5VQ0ujEbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/1/5 上午9:56, Josh Don 写道:
> Hi Cruz,
> 
> On Thu, Dec 23, 2021 at 4:30 AM Cruz Zhao <CruzZhao@linux.alibaba.com> wrote:
>>
>> Forced idle can be divided into two types, forced idle with cookie'd task
>> running on it SMT sibling, and forced idle with uncookie'd task running
>> on it SMT sibling, which should be accounting to measure the cost of
>> enabling core scheduling too.
>>
>> This patch accounts the forced idle time with uncookie'd task, and the
>> sum of both.
>>
>> A few details:
>>  - Uncookied forceidle time and total forceidle time is displayed via
>>    the last two columns of /proc/stat.
>>  - Uncookied forceidle time is ony accounted when this cpu is forced
>>    idle and a sibling hyperthread is running with an uncookie'd task.
> 
When we care about capacity loss, we care about all but not some of it.
The forced idle time from uncookie'd task is actually caused by the
cookie'd task in runqueue indirectly, and it's more accurate to measure
the capacity loss with the sum of cookie'd forced idle time and
uncookie'd forced idle time, as far as I'm concerned.

Assuming cpu x and cpu y are a pair of smt siblings, consider the
following scenarios:
1. There's a cookie'd task A running on cpu x, and there're 4 uncookie'd
tasks B~E running on cpu y. For cpu x, there will be 80% forced idle
time(from uncookie'd task); for cpu y, there will be 20% forced idle
time(from cookie'd task).
2. There's a uncookie'd task A running on cpu x, and there're 4 cookie'd
tasks B~E running on cpu y. For cpu x, there will be 80% forced idle
time(from cookie'd task); for cpu y, there will be 20% forced idle
time(from uncookie'd task).
The scenario1 can recurrent by stress-ng(scenario2 can recurrent similary):
(cookie'd)taskset -c x stress-ng -c 1 -l 100
(uncookie'd)taskset -c y stress-ng -c 4 -l 100

In the above two scenarios, the capacity loss is 1 cpu, but in
scenario1, the cookie'd forced idle time tells us 20%cpu loss, in
scenario2, the cookie'd forced idle time tells us 80% forced idle time,
which are not accurate. It'll be more accurate with the sum of cookie'd
forced idle time and uncookie'd forced idle time.

Best,
Cruz Zhao

> What is the purpose/use-case to account the forced idle from
> uncookie'd tasks? The forced-idle from cookie'd tasks represents
> capacity loss due to adding in some cookie'd tasks. If forced idle is
> high, that can be rectified by making some changes to the cookie'd
> tasks (ie. their affinity, cpu budget, etc.).
