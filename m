Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFB71B24D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 13:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgDULSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 07:18:39 -0400
Received: from foss.arm.com ([217.140.110.172]:33422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgDULSj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:18:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40554C14;
        Tue, 21 Apr 2020 04:18:38 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 508153F73D;
        Tue, 21 Apr 2020 04:18:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200403123020.13897-1-qais.yousef@arm.com>
 <292dbd54-e590-dc4f-41e6-5f86e478c0ee@arm.com>
 <20200420151341.7zni3bwroso2kpdc@e107158-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <de020088-3b06-3674-dab9-244ae577cc54@arm.com>
Date:   Tue, 21 Apr 2020 13:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420151341.7zni3bwroso2kpdc@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20/04/2020 17:13, Qais Yousef wrote:
> On 04/20/20 10:29, Dietmar Eggemann wrote:
>> On 03.04.20 14:30, Qais Yousef wrote:
>>
>> [...]
>>
>>> @@ -924,6 +945,14 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
>>>  	return uc_req;
>>>  }
>>>  
>>> +static void uclamp_rt_sync_default_util_min(struct task_struct *p)
>>> +{
>>> +	struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
>>> +
>>> +	if (!uc_se->user_defined)
>>> +		uclamp_se_set(uc_se, sysctl_sched_rt_default_uclamp_util_min, false);
>>> +}
>>> +
>>>  unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
>>>  {
>>>  	struct uclamp_se uc_eff;
>>> @@ -1030,6 +1059,12 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>>>  	if (unlikely(!p->sched_class->uclamp_enabled))
>>>  		return;
>>>  
>>> +	/*
>>> +	 * When sysctl_sched_rt_default_uclamp_util_min value is changed by the
>>> +	 * user, we apply any new value on the next wakeup, which is here.
>>> +	 */
>>> +	uclamp_rt_sync_default_util_min(p);
>>> +
>>
>> Does this have to be an extra function? Can we not reuse
>> uclamp_tg_restrict() by slightly rename it to uclamp_restrict()?
> 
> Hmm the thing is that we're not restricting here. In contrary we're boosting,
> so the name would be misleading.

I always thought that we're restricting p->uclamp_req[UCLAMP_MIN].value (default 1024) to
sysctl_sched_rt_default_uclamp_util_min (0-1024)?

root@h960:~# echo 999 > /proc/sys/kernel/sched_rt_default_util_clamp_min

[  118.028582] uclamp_eff_get() [rtkit-daemon 410] tag=0 uclamp_id=0 uc_req.value=1024
[  118.036290] uclamp_eff_get() [rtkit-daemon 410] tag=1 uclamp_id=0 uc_req.value=1024
[  125.181747] uclamp_eff_get() [rtkit-daemon 410] tag=0 uclamp_id=0 uc_req.value=1024
[  125.189443] uclamp_eff_get() [rtkit-daemon 410] tag=1 uclamp_id=0 uc_req.value=1024
[  131.213211] uclamp_restrict() [rtkit-daemon 410] p->uclamp_req[0].value=999
[  131.220201] uclamp_eff_get() [rtkit-daemon 410] tag=0 uclamp_id=0 uc_req.value=999
[  131.227792] uclamp_eff_get() [rtkit-daemon 410] tag=1 uclamp_id=0 uc_req.value=999
[  137.181544] uclamp_eff_get() [rtkit-daemon 410] tag=0 uclamp_id=0 uc_req.value=999
[  137.189170] uclamp_eff_get() [rtkit-daemon 410] tag=1 uclamp_id=0 uc_req.value=999

>> This function will then deal with enforcing restrictions, whether system
>> and taskgroup hierarchy related or default value (latter only for rt-min
>> right now since the others are fixed) related.
>>
>> uclamp_eff_get() -> uclamp_restrict() is called from:
>>
>>   'enqueue_task(), uclamp_update_active() -> uclamp_rq_inc() -> uclamp_rq_inc_id()' and
>>
>>   'task_fits_capacity() -> clamp_task_util(), rt_task_fits_capacity() -> uclamp_eff_value()' and
>>
>>   'schedutil_cpu_util(), find_energy_efficient_cpu() -> uclamp_rq_util_with() -> uclamp_eff_value()'
>>
>> so there would be more check-points than the one in 'enqueue_task() -> uclamp_rq_inc()' now.
> 
> I think you're revolving around the same idea that Patrick was suggesting.
> I think it is possible to do something in uclamp_eff_get() too.

Yeah, I read https://lore.kernel.org/linux-doc/20200415074600.GA26984@darkstar again.

Everything which moves enforcing sysctl_sched_rt_default_uclamp_util_min closer to 'uclamp_eff_get() -> 
uclamp_(tg_)restrict()' is fine with me.
