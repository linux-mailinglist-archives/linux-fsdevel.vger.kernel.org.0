Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243814851D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 12:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiAELdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 06:33:24 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45417 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233838AbiAELdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:33:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V11Gf1b_1641382399;
Received: from 30.21.164.223(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0V11Gf1b_1641382399)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jan 2022 19:33:20 +0800
Message-ID: <b02204ea-0683-2879-5843-4cfb31d44d27@linux.alibaba.com>
Date:   Wed, 5 Jan 2022 19:33:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] sched/core: Cookied forceidle accounting per cpu
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
 <1640262603-19339-2-git-send-email-CruzZhao@linux.alibaba.com>
 <CABk29NvPJ3S1xq5xm+52OoUGDyuMSxGOLJbopPa3+-QmLnVYeQ@mail.gmail.com>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <CABk29NvPJ3S1xq5xm+52OoUGDyuMSxGOLJbopPa3+-QmLnVYeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/1/5 上午9:48, Josh Don 写道:
> Hi Cruz,
> 
Firstly, attributing forced idle time to the specific cpus it happens on
can help us measure the effect of steal_cookie_task(). We found out that
steal_cookie_task() conflicts with load balance sometimes, for example,
a cookie'd task is stolen by steal_cookie_task(), but it'll be migrated
to another core by load balance soon. Secondly, a more convenient way of
summing forced idle instead of iterating cookie'd task is indeed what we
need. In the multi-rent scenario, it'll be complex to maintain the list
of cookie'd task and it'll cost a lot to iterate it.

> Could you add a bit more background to help me understand what case
> this patch solves? Is your issue that you want to be able to
> attribute forced idle time to the specific cpus it happens on, or do
> you simply want a more convenient way of summing forced idle without
> iterating your cookie'd tasks and summing the schedstat manually?
> 
>> @@ -190,6 +202,9 @@ static int show_stat(struct seq_file *p, void *v)
>>                 seq_put_decimal_ull(p, " ", nsec_to_clock_t(steal));
>>                 seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest));
>>                 seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
>> +#ifdef CONFIG_SCHED_CORE
>> +               seq_put_decimal_ull(p, " ", nsec_to_clock_t(cookied_forceidle));
>> +#endif
> 
I'll put this in /proc/schedstat and fix the problem that accounting
simply idle as force idle in the next version.

Many thanks for suggestions.

Best,
Cruz Zhao
> IMO it would be better to always print this stat, otherwise it sets a
> weird precedent for new stats added in the future (much more difficult
> for userspace to reason about which column corresponds with which
> field, since it would depend on kernel config).
> 
> Also, did you intend to put this in /proc/stat instead of
> /proc/schedstat (the latter of which would be more attractive to
> prevent calculation of these stats unless schestat was enabled)?
> 
>> diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
>> @@ -260,6 +261,21 @@ void __sched_core_account_forceidle(struct rq *rq)
>>
>>         rq->core->core_forceidle_start = now;
>>
>> +       for_each_cpu(i, smt_mask) {
>> +               rq_i = cpu_rq(i);
>> +               p = rq_i->core_pick ?: rq_i->curr;
>> +
>> +               if (!rq->core->core_cookie)
>> +                       continue;
> 
> I see this is temporary given your other patch, but just a note that
> if your other patch is dropped, this check can be pulled outside the
> loop.
> 
>> +               if (p == rq_i->idle && rq_i->nr_running) {
>> +                       cpustat = kcpustat_cpu(i).cpustat;
>> +                       cpustat[CPUTIME_COOKIED_FORCEIDLE] += delta;
>> +               }
>> +       }
> 
> I don't think this is right. If a cpu was simply idle while some other
> SMT sibling on its core was forced idle, and then a task happens to
> wake on the idle cpu, that cpu will now be charged the full delta here
> as forced idle (when actually it was never forced idle, we just
> haven't been through pick_next_task yet). One workaround would be to
> add a boolean to struct rq to cache whether the rq was in forced idle
> state.
> 
> Best,
> Josh
