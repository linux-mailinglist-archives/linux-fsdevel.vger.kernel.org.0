Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0612D1E6A48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 21:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406297AbgE1TUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 15:20:42 -0400
Received: from foss.arm.com ([217.140.110.172]:56456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406225AbgE1TUk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 15:20:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AFA955D;
        Thu, 28 May 2020 12:20:39 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B88C3F6C4;
        Thu, 28 May 2020 12:20:36 -0700 (PDT)
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
To:     Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200528165130.m5unoewcncuvxynn@e107158-lin.cambridge.arm.com>
 <20200528182913.GQ2483@worktop.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f3081cf2-24f1-d0f9-e76b-d868538f3245@arm.com>
Date:   Thu, 28 May 2020 21:20:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528182913.GQ2483@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/05/2020 20:29, Peter Zijlstra wrote:
> On Thu, May 28, 2020 at 05:51:31PM +0100, Qais Yousef wrote:
> 
>> In my head, the simpler version of
>>
>> 	if (rt_task(p) && !uc->user_defined)
>> 		// update_uclamp_min
>>
>> Is a single branch and write to cache, so should be fast. I'm failing to see
>> how this could generate an overhead tbh, but will not argue about it :-)
> 
> Mostly true; but you also had a load of that sysctl in there, which is
> likely to be a miss, and those are expensive.
> 
> Also; if we're going to have to optimize this, less logic is in there,
> the less we need to take out. Esp. for stuff that 'never' changes, like
> this.
> 
>>> It's more code, but it is all outside of the normal paths where we care
>>> about performance.
>>
>> I am happy to take that direction if you think it's worth it. I'm thinking
>> task_woken_rt() is good. But again, maybe I am missing something.
> 
> Basic rule, if the state 'never' changes, don't touch fast paths.
> 
> Such little things can be very difficult to measure, but at some point
> they cause death-by-a-thousnd-cuts.
> 
>>> Indeed, that one. The fact that regular distros cannot enable this
>>> feature due to performance overhead is unfortunate. It means there is a
>>> lot less potential for this stuff.
>>
>> I had a humble try to catch the overhead but wasn't successful. The observation
>> wasn't missed by us too then.
> 
> Right, I remember us doing benchmarks when we introduced all this and
> clearly we missed something. I would be good if Mel can share which
> benchmark hurt most so we can go have a look.

IIRC, it was a local mmtests netperf-udp with various buffer sizes?

At least that's what we're trying to run right now on a '2 Sockets Xeon
E5 2x10-Cores (40 CPUs)' w/ 3 different kernel ((1) wo_clamp (2)
tsk_uclamp (3) tskgrp_uclamp).

We have currently Ubuntu Desktop on it. I think that systemd uses
cgroups (especially cpu controller) differently on a (Ubuntu) Server.
Maybe this has an influence here as well?
