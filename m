Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72D21CEA8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 04:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgELCLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 22:11:19 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:18612 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727892AbgELCLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 22:11:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589249477; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=QNYQNyInAghRaEYuVraZ7NwiX9YVEOfA+XK0Ft46+dA=; b=kJii45J+fTasiNiquEW/U11xnKWaASc/F2rl2Wwp3X4iFS/oO35YJ6Liesg1FyFQRRW7/Tns
 BW89qXSzsbKnPOLatz2orRen5NCUVHqbCCBW5hqrhKXrTuL1nz6JDrMS1N76B/gPZp1FYzpf
 a/QXXWNJHUvTnAQNdx32TXp0nFE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba05bb.7f2dc19e9c38-smtp-out-n03;
 Tue, 12 May 2020 02:11:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DDD58C433BA; Tue, 12 May 2020 02:11:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CE62C433CB;
        Tue, 12 May 2020 02:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CE62C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 12 May 2020 07:40:56 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Qais Yousef <qais.yousef@arm.com>
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
Message-ID: <20200512021056.GA31725@codeaurora.org>
References: <20200511154053.7822-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511154053.7822-1-qais.yousef@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 04:40:52PM +0100, Qais Yousef wrote:
> RT tasks by default run at the highest capacity/performance level. When
> uclamp is selected this default behavior is retained by enforcing the
> requested uclamp.min (p->uclamp_req[UCLAMP_MIN]) of the RT tasks to be
> uclamp_none(UCLAMP_MAX), which is SCHED_CAPACITY_SCALE; the maximum
> value.
> 
> This is also referred to as 'the default boost value of RT tasks'.
> 
> See commit 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks").
> 
> On battery powered devices, it is desired to control this default
> (currently hardcoded) behavior at runtime to reduce energy consumed by
> RT tasks.
> 
> For example, a mobile device manufacturer where big.LITTLE architecture
> is dominant, the performance of the little cores varies across SoCs, and
> on high end ones the big cores could be too power hungry.
> 
> Given the diversity of SoCs, the new knob allows manufactures to tune
> the best performance/power for RT tasks for the particular hardware they
> run on.
> 
> They could opt to further tune the value when the user selects
> a different power saving mode or when the device is actively charging.
> 
> The runtime aspect of it further helps in creating a single kernel image
> that can be run on multiple devices that require different tuning.
> 
> Keep in mind that a lot of RT tasks in the system are created by the
> kernel. On Android for instance I can see over 50 RT tasks, only
> a handful of which created by the Android framework.
> 
> To control the default behavior globally by system admins and device
> integrators, introduce the new sysctl_sched_uclamp_util_min_rt_default
> to change the default boost value of the RT tasks.
> 
> I anticipate this to be mostly in the form of modifying the init script
> of a particular device.
> 
> Whenever the new default changes, it'd be applied lazily on the next
> opportunity the scheduler needs to calculate the effective uclamp.min
> value for the task, assuming that it still uses the system default value
> and not a user applied one.
> 
> Tested on Juno-r2 in combination with the RT capacity awareness [1].
> By default an RT task will go to the highest capacity CPU and run at the
> maximum frequency, which is particularly energy inefficient on high end
> mobile devices because the biggest core[s] are 'huge' and power hungry.
> 
> With this patch the RT task can be controlled to run anywhere by
> default, and doesn't cause the frequency to be maximum all the time.
> Yet any task that really needs to be boosted can easily escape this
> default behavior by modifying its requested uclamp.min value
> (p->uclamp_req[UCLAMP_MIN]) via sched_setattr() syscall.
> 
> [1] 804d402fb6f6: ("sched/rt: Make RT capacity-aware")
> 

I have tested this patch on SDM845 running V5.7-rc4 and it works as expected.

Default: i.e /proc/sys/kernel/sched_util_clamp_min_rt_default = 1024.

RT task runs on BIG cluster every time at max frequency. Both effective
and requested uclamp.min are set to 1024

With /proc/sys/kernel/sched_util_clamp_min_rt_default = 128

RT task runs on Little cluster (max capacity is 404) and frequency scaling
happens as per the change in utilization. Both effective and requested
uclamp are set to 128.

Feel free to add

Tested-by: Pavankumar Kondeti <pkondeti@codeaurora.org>

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
