Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5876C1C049B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgD3SVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 14:21:37 -0400
Received: from foss.arm.com ([217.140.110.172]:60060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgD3SVg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 14:21:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C649C101E;
        Thu, 30 Apr 2020 11:21:35 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E45CC3F73D;
        Thu, 30 Apr 2020 11:21:32 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] sched/uclamp: Add a new sysctl to control RT
 default boost value
To:     Qais Yousef <qais.yousef@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200428164134.5588-1-qais.yousef@arm.com>
 <20200429113255.GA19464@codeaurora.org>
 <20200429123056.otyedhljlugyf5we@e107158-lin>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d3916860-6ee8-4d17-55ea-be5cada1302a@arm.com>
Date:   Thu, 30 Apr 2020 20:21:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429123056.otyedhljlugyf5we@e107158-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/04/2020 14:30, Qais Yousef wrote:
> Hi Pavan
> 
> On 04/29/20 17:02, Pavan Kondeti wrote:
>> Hi Qais,
>>
>> On Tue, Apr 28, 2020 at 05:41:33PM +0100, Qais Yousef wrote:

[...]

>>> @@ -907,8 +935,15 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
>>>  static inline struct uclamp_se
>>>  uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
>>>  {
>>> -	struct uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id);
>>> -	struct uclamp_se uc_max = uclamp_default[clamp_id];
>>> +	struct uclamp_se uc_req, uc_max;
>>> +
>>> +	/*
>>> +	 * Sync up any change to sysctl_sched_uclamp_util_min_rt_default value.
>>> +	 */
>>> +	uclamp_sync_util_min_rt_default(p);
>>> +
>>> +	uc_req = uclamp_tg_restrict(p, clamp_id);
>>> +	uc_max = uclamp_default[clamp_id];
>>
>> We are calling uclamp_sync_util_min_rt_default() unnecessarily for
>> clamp_id == UCLAMP_MAX case. Would it be better to have a separate
> 
> It was actually intentional to make sure we update the value ASAP. I didn't
> think it's a lot of overhead. I can further protect with a check to verify
> whether the value has changed if it seems heavy handed.

Users of uclamp_eff_value()->uclamp_eff_get() ((like
rt_task_fits_capacity())) always call both ids.

So calling uclamp_sync_util_min_rt_default() only for UCLAMP_MIN would
make sense. It's overhead in the fast path for rt tasks.

Since changes to sched_util_clamp_min_rt_default will be fairly rare,
you might even want to consider only doing the uclamp_se_set(...,
min_rt_default, ...) in case

  uc_se->value != sysctl_sched_uclamp_util_min_rt_default

[...]
