Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25711CF397
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 13:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgELLrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 07:47:04 -0400
Received: from foss.arm.com ([217.140.110.172]:53196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgELLrE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 07:47:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A53430E;
        Tue, 12 May 2020 04:47:03 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E88BA3F71E;
        Tue, 12 May 2020 04:47:00 -0700 (PDT)
Date:   Tue, 12 May 2020 12:46:58 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200512114657.phb3rx7jeebd5i3w@e107158-lin.cambridge.arm.com>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200512021056.GA31725@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200512021056.GA31725@codeaurora.org>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/12/20 07:40, Pavan Kondeti wrote:
> On Mon, May 11, 2020 at 04:40:52PM +0100, Qais Yousef wrote:
> > RT tasks by default run at the highest capacity/performance level. When
> > uclamp is selected this default behavior is retained by enforcing the
> > requested uclamp.min (p->uclamp_req[UCLAMP_MIN]) of the RT tasks to be
> > uclamp_none(UCLAMP_MAX), which is SCHED_CAPACITY_SCALE; the maximum
> > value.
> > 
> > This is also referred to as 'the default boost value of RT tasks'.
> > 
> > See commit 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks").
> > 
> > On battery powered devices, it is desired to control this default
> > (currently hardcoded) behavior at runtime to reduce energy consumed by
> > RT tasks.
> > 
> > For example, a mobile device manufacturer where big.LITTLE architecture
> > is dominant, the performance of the little cores varies across SoCs, and
> > on high end ones the big cores could be too power hungry.
> > 
> > Given the diversity of SoCs, the new knob allows manufactures to tune
> > the best performance/power for RT tasks for the particular hardware they
> > run on.
> > 
> > They could opt to further tune the value when the user selects
> > a different power saving mode or when the device is actively charging.
> > 
> > The runtime aspect of it further helps in creating a single kernel image
> > that can be run on multiple devices that require different tuning.
> > 
> > Keep in mind that a lot of RT tasks in the system are created by the
> > kernel. On Android for instance I can see over 50 RT tasks, only
> > a handful of which created by the Android framework.
> > 
> > To control the default behavior globally by system admins and device
> > integrators, introduce the new sysctl_sched_uclamp_util_min_rt_default
> > to change the default boost value of the RT tasks.
> > 
> > I anticipate this to be mostly in the form of modifying the init script
> > of a particular device.
> > 
> > Whenever the new default changes, it'd be applied lazily on the next
> > opportunity the scheduler needs to calculate the effective uclamp.min
> > value for the task, assuming that it still uses the system default value
> > and not a user applied one.
> > 
> > Tested on Juno-r2 in combination with the RT capacity awareness [1].
> > By default an RT task will go to the highest capacity CPU and run at the
> > maximum frequency, which is particularly energy inefficient on high end
> > mobile devices because the biggest core[s] are 'huge' and power hungry.
> > 
> > With this patch the RT task can be controlled to run anywhere by
> > default, and doesn't cause the frequency to be maximum all the time.
> > Yet any task that really needs to be boosted can easily escape this
> > default behavior by modifying its requested uclamp.min value
> > (p->uclamp_req[UCLAMP_MIN]) via sched_setattr() syscall.
> > 
> > [1] 804d402fb6f6: ("sched/rt: Make RT capacity-aware")
> > 
> 
> I have tested this patch on SDM845 running V5.7-rc4 and it works as expected.
> 
> Default: i.e /proc/sys/kernel/sched_util_clamp_min_rt_default = 1024.
> 
> RT task runs on BIG cluster every time at max frequency. Both effective
> and requested uclamp.min are set to 1024
> 
> With /proc/sys/kernel/sched_util_clamp_min_rt_default = 128
> 
> RT task runs on Little cluster (max capacity is 404) and frequency scaling
> happens as per the change in utilization. Both effective and requested
> uclamp are set to 128.
> 
> Feel free to add
> 
> Tested-by: Pavankumar Kondeti <pkondeti@codeaurora.org>

Thanks Pavan!

--
Qais Yousef
