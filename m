Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 397F110865F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 02:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfKYBgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 20:36:31 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:45359 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727072AbfKYBgb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 20:36:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Tiyc3wU_1574645775;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Tiyc3wU_1574645775)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Nov 2019 09:36:16 +0800
Subject: Re: [PATCH 0/3] sched/numa: introduce advanced numa statistic
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
Message-ID: <50f167ed-12b5-24b7-a2f7-38d32bf6647a@linux.alibaba.com>
Date:   Mon, 25 Nov 2019 09:35:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Peter

How do you think about this version, does it looks fine to you?

Regards,
Michael Wang

On 2019/11/13 上午11:43, 王贇 wrote:
> Modern production environment could use hundreds of cgroup to control
> the resources for different workloads, along with the complicated
> resource binding.
> 
> On NUMA platforms where we have multiple nodes, things become even more
> complicated, we hope there are more local memory access to improve the
> performance, and NUMA Balancing keep working hard to achieve that,
> however, wrong memory policy or node binding could easily waste the
> effort, result a lot of remote page accessing.
> 
> We need to perceive such problems, then we got chance to fix it before
> there are too much damages, however, there are no good approach yet to
> help catch the mouse who introduced the remote access.
> 
> This patch set is trying to fill in the missing pieces， by introduce
> the per-cgroup NUMA locality/exectime statistics, and expose the per-task
> page migration failure counter, with these statistics, we could achieve
> the daily monitoring on NUMA efficiency, to give warning when things going
> too wrong.
> 
> Please check the third patch for more details.
> 
> Thanks to Peter, Mel and Michal for the good advices :-)
> 
> Michael Wang (3):
>   sched/numa: advanced per-cgroup numa statistic
>   sched/numa: expose per-task pages-migration-failure counter
>   sched/numa: documentation for per-cgroup numa stat
> 
>  Documentation/admin-guide/cg-numa-stat.rst      | 161 ++++++++++++++++++++++++
>  Documentation/admin-guide/kernel-parameters.txt |   4 +
>  Documentation/admin-guide/sysctl/kernel.rst     |   9 ++
>  include/linux/sched.h                           |  18 ++-
>  include/linux/sched/sysctl.h                    |   6 +
>  init/Kconfig                                    |   9 ++
>  kernel/sched/core.c                             |  91 ++++++++++++++
>  kernel/sched/debug.c                            |   1 +
>  kernel/sched/fair.c                             |  33 +++++
>  kernel/sched/sched.h                            |  17 +++
>  kernel/sysctl.c                                 |  11 ++
>  11 files changed, 359 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/cg-numa-stat.rst
> 
> 
