Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A18C3D3C51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 17:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhGWOjN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 10:39:13 -0400
Received: from foss.arm.com ([217.140.110.172]:47308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235497AbhGWOjD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:39:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 371E012FC;
        Fri, 23 Jul 2021 08:19:23 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A79D33F73D;
        Fri, 23 Jul 2021 08:19:20 -0700 (PDT)
Subject: Re: [PATCH] sched/uclamp: Introduce a method to transform UCLAMP_MIN
 into BOOST
To:     Xuewen Yan <xuewen.yan94@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, pjt@google.com, qais.yousef@arm.com,
        qperret@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210721075751.542-1-xuewen.yan94@gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d8e14c3c-0eab-2d4d-693e-fb647c7f7c8c@arm.com>
Date:   Fri, 23 Jul 2021 17:19:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721075751.542-1-xuewen.yan94@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/07/2021 09:57, Xuewen Yan wrote:
> From: Xuewen Yan <xuewen.yan@unisoc.com>
> 
> The uclamp can clamp the util within uclamp_min and uclamp_max,
> it is benifit to some tasks with small util, but for those tasks
> with middle util, it is useless.
> 
> To speed up those tasks, convert UCLAMP_MIN to BOOST,
> the BOOST as schedtune does:

Maybe it's important to note here that schedtune is the `out-of-tree`
predecessor of uclamp used in some Android versions.

> boot = uclamp_min / SCHED_CAPACITY_SCALE;
> margin = boost * (uclamp_max - util)
> boost_util = util + margin;

This is essentially the functionality from schedtune_margin() in
Android, right?

So in your implementation, the margin (i.e. what is added to the task
util) not only depends on uclamp_min, but also on `uclamp_max`?

> Scenario:
> if the task_util = 200, {uclamp_min, uclamp_max} = {100, 1024}
> 
> without patch:
> clamp_util = 200;
> 
> with patch:
> clamp_util = 200 + (100 / 1024) * (1024 - 200) = 280;

The same could be achieved by using {uclamp_min, uclamp_max} = {280, 1024}?

Uclamp_min is meant to be the final `boost( = util + margin)`
information. You just have to set it appropriately to the task (via
per-task and/or per-cgroup interface).

Uclamp_min is for `boosting`, Uclamp max is for `capping` CPU frequency.

[...]
