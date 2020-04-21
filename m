Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B141B24BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 13:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgDULQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 07:16:20 -0400
Received: from foss.arm.com ([217.140.110.172]:33334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDULQT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:16:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B041AC14;
        Tue, 21 Apr 2020 04:16:18 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B19C93F73D;
        Tue, 21 Apr 2020 04:16:15 -0700 (PDT)
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
To:     Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
 <54ac2709-54e5-7a33-a6af-0a07e272365c@arm.com>
 <20200420151941.47ualxul5seqwdgh@e107158-lin.cambridge.arm.com>
 <20200420205210.7217651c@oasis.local.home>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1abbe4a5-61e6-a918-ff89-3dea0c7a277c@arm.com>
Date:   Tue, 21 Apr 2020 13:16:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420205210.7217651c@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/04/2020 02:52, Steven Rostedt wrote:
> On Mon, 20 Apr 2020 16:19:42 +0100
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
>>> root@h960:~# find / -name "*util_clamp*"
>>> /proc/sys/kernel/sched_rt_default_util_clamp_min
>>> /proc/sys/kernel/sched_util_clamp_max
>>> /proc/sys/kernel/sched_util_clamp_min
>>>
>>> IMHO, keeping the common 'sched_util_clamp_' would be helpful here, e.g.
>>>
>>> /proc/sys/kernel/sched_util_clamp_rt_default_min  
>>
>> All RT related knobs are prefixed with 'sched_rt'. I kept the 'util_clamp_min'
>> coherent with the current sysctl (sched_util_clamp_min). Quentin suggested
>> adding 'default' to be more obvious, so I ended up with
>>
>> 	'sched_rt' + '_default' + '_util_clamp_min'.
>>
>> I think this is the logical and most consistent form. Given that Patrick seems
>> to be okay with the 'default' now, does this look good to you too?
> 
> There's only two files with "sched_rt" and they are tightly coupled
> (they define how much an RT task may use the CPU).
> 
> My question is, is this "sched_rt_default_util_clamp_min" related in
> any way to those other two files that start with "sched_rt", or is it
> more related to the files that start with "sched_util_clamp"?
> 
> If the latter, then I would suggest using
> "sched_util_clamp_min_rt_default", as it looks to be more related to
> the "sched_util_clamp_min" than to anything else.

For me it's the latter.
