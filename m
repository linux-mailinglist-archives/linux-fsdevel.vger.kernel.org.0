Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6EE1B044E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgDTIZc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 04:25:32 -0400
Received: from foss.arm.com ([217.140.110.172]:44962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTIZb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:25:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 291FA30E;
        Mon, 20 Apr 2020 01:25:31 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C41153F6CF;
        Mon, 20 Apr 2020 01:25:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
To:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        Qais Yousef <qais.yousef@arm.com>
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
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200403123020.13897-1-qais.yousef@arm.com>
 <20200414182152.GB20442@darkstar>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <54ac2709-54e5-7a33-a6af-0a07e272365c@arm.com>
Date:   Mon, 20 Apr 2020 10:24:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414182152.GB20442@darkstar>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/04/2020 20:21, Patrick Bellasi wrote:
> Hi Qais!
> 
> On 03-Apr 13:30, Qais Yousef wrote:

[...]

>> @@ -924,6 +945,14 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
>>  	return uc_req;
>>  }
>>  
>> +static void uclamp_rt_sync_default_util_min(struct task_struct *p)
>> +{
>> +	struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
> 
> Don't we have to filter for RT tasks only here?

I think so. It's probably because it got moved from rt.c to core.c.

[...]

>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index ad5b88a53c5a..0272ae8c6147 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -465,6 +465,13 @@ static struct ctl_table kern_table[] = {
>>  		.mode		= 0644,
>>  		.proc_handler	= sysctl_sched_uclamp_handler,
>>  	},
>> +	{
>> +		.procname	= "sched_rt_default_util_clamp_min",

root@h960:~# find / -name "*util_clamp*"
/proc/sys/kernel/sched_rt_default_util_clamp_min
/proc/sys/kernel/sched_util_clamp_max
/proc/sys/kernel/sched_util_clamp_min

IMHO, keeping the common 'sched_util_clamp_' would be helpful here, e.g.

/proc/sys/kernel/sched_util_clamp_rt_default_min

[...]
