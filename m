Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5DB1B4253
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 13:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbgDVLAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 07:00:08 -0400
Received: from foss.arm.com ([217.140.110.172]:47506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbgDVK7y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:59:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3768931B;
        Wed, 22 Apr 2020 03:59:53 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DDE83F6CF;
        Wed, 22 Apr 2020 03:59:49 -0700 (PDT)
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
 <de020088-3b06-3674-dab9-244ae577cc54@arm.com>
 <20200421112733.4jbguidgbqwzhv23@e107158-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <45236ccd-24d2-3b99-cd9b-bac13cfaceab@arm.com>
Date:   Wed, 22 Apr 2020 12:59:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421112733.4jbguidgbqwzhv23@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/04/2020 13:27, Qais Yousef wrote:
> On 04/21/20 13:18, Dietmar Eggemann wrote:
>> On 20/04/2020 17:13, Qais Yousef wrote:
>>> On 04/20/20 10:29, Dietmar Eggemann wrote:
>>>> On 03.04.20 14:30, Qais Yousef wrote:
>>>>
>>>> [...]
>>>>
>>>>> @@ -924,6 +945,14 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
>>>>>  	return uc_req;
>>>>>  }
>>>>>  
>>>>> +static void uclamp_rt_sync_default_util_min(struct task_struct *p)
>>>>> +{
>>>>> +	struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
>>>>> +
>>>>> +	if (!uc_se->user_defined)
>>>>> +		uclamp_se_set(uc_se, sysctl_sched_rt_default_uclamp_util_min, false);
>>>>> +}
>>>>> +
>>>>>  unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
>>>>>  {
>>>>>  	struct uclamp_se uc_eff;
>>>>> @@ -1030,6 +1059,12 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>>>>>  	if (unlikely(!p->sched_class->uclamp_enabled))
>>>>>  		return;
>>>>>  
>>>>> +	/*
>>>>> +	 * When sysctl_sched_rt_default_uclamp_util_min value is changed by the
>>>>> +	 * user, we apply any new value on the next wakeup, which is here.
>>>>> +	 */
>>>>> +	uclamp_rt_sync_default_util_min(p);
>>>>> +
>>>>
>>>> Does this have to be an extra function? Can we not reuse
>>>> uclamp_tg_restrict() by slightly rename it to uclamp_restrict()?

Btw, there was an issue in my little snippet. I used uc_req.user_defined
uninitialized in uclamp_restrict().


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f3706dad32ce..7e6b2b7cd1e5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -903,12 +903,11 @@ uclamp_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_req, __maybe_unused uc_max;
 
-	if (unlikely(rt_task(p)) && clamp_id == UCLAMP_MIN &&
-	    !uc_req.user_defined) {
+	if (unlikely(rt_task(p)) && clamp_id == UCLAMP_MIN) {
 		struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
 		int rt_min = sysctl_sched_rt_default_uclamp_util_min;
 
-		if (uc_se->value != rt_min) {
+		if (!uc_se->user_defined && uc_se->value != rt_min) {
 			uclamp_se_set(uc_se, rt_min, false);
 			printk("uclamp_restrict() [%s %d] p->uclamp_req[%d].value=%d\n",
 			       p->comm, p->pid, clamp_id, uc_se->value);

>>> Hmm the thing is that we're not restricting here. In contrary we're boosting,
>>> so the name would be misleading.
>>
>> I always thought that we're restricting p->uclamp_req[UCLAMP_MIN].value (default 1024) to
>> sysctl_sched_rt_default_uclamp_util_min (0-1024)?
> 
> The way I look at it is that we're *setting* it to
> sysctl_sched_rt_default_uclamp_util_min if !user_defined.
> 
> The restriction mechanism that ensures this set value doesn't escape
> cgroup/global restrictions setup.

I guess we overall agree here. 

I see 3 restriction levels: (!user_defined) task -> taskgroup -> system

I see sysctl_sched_rt_default_uclamp_util_min (min_rt_default) as a
restriction on task level.

It's true that the task level restriction is setting the value at the same time.

For CFS (id=UCLAMP_[MIN\|MAX]) and RT (id=UCLAMP_MAX) we use
uclamp_none(id) and those values (0, 1024) are fixed so these task level
values don't need to be further restricted.

For RT (id=UCLAMP_MIN) we use 'min_rt_default' and since it can change
we have to check the task level restriction in 'uclamp_eff_get() ->
uclamp_(tg)_restrict()'.

root@h960:~# echo 999 > /proc/sys/kernel/sched_rt_default_util_clamp_min

[ 2540.507236] uclamp_eff_get() [rtkit-daemon 419] tag=0 uclamp_id=0 uc_req.value=1024
[ 2540.514947] uclamp_eff_get() [rtkit-daemon 419] tag=1 uclamp_id=0 uc_req.value=1024
[ 2548.015208] uclamp_restrict() [rtkit-daemon 419] p->uclamp_req[0].value=999

root@h960:~# echo 666 > /proc/sys/kernel/sched_util_clamp_min

[ 2548.022219] uclamp_eff_get() [rtkit-daemon 419] tag=0 uclamp_id=0 uc_req.value=999
[ 2548.029825] uclamp_eff_get() [rtkit-daemon 419] tag=1 uclamp_id=0 uc_req.value=999
[ 2553.479509] uclamp_eff_get() [rtkit-daemon 419] tag=0 uclamp_id=0 uc_max.value=666
[ 2553.487131] uclamp_eff_get() [rtkit-daemon 419] tag=1 uclamp_id=0 uc_max.value=666

Haven't tried to put an rt task into a taskgroup other than root.
