Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9DA412B090
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 03:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfL0CXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 21:23:18 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:34816 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfL0CXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 21:23:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Tm.XzN1_1577413365;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Tm.XzN1_1577413365)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 Dec 2019 10:22:46 +0800
Subject: Re: [PATCH v6 0/2] sched/numa: introduce numa locality
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
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <040def80-9c38-4bcc-e4a8-8a0d10f131ed@linux.alibaba.com>
 <25cf7ef5-e37e-7578-eea7-29ad0b76c4ea@linux.alibaba.com>
 <443641e7-f968-0954-5ff6-3b7e7fed0e83@linux.alibaba.com>
 <d2c4cace-623a-9317-c957-807e3875aa4a@linux.alibaba.com>
Message-ID: <42800224-ed45-2e37-1960-0da29eb3bc38@linux.alibaba.com>
Date:   Fri, 27 Dec 2019 10:22:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d2c4cace-623a-9317-c957-807e3875aa4a@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks, is there any more comments?

Regards,
Michael Wang

On 2019/12/13 上午9:43, 王贇 wrote:
> Since v5:
>   * fix compile failure when NUMA disabled
> Since v4:
>   * improved documentation
> Since v3:
>   * fix comments and improved documentation
> Since v2:
>   * simplified the locality concept & implementation
> Since v1:
>   * improved documentation
> 
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
> We need to notice such problems, then we got chance to fix it before
> there are too much damages, however, there are no good monitoring
> approach yet to help catch the mouse who introduced the remote access.
> 
> This patch set is trying to fill in the missing pieces， by introduce
> the per-cgroup NUMA locality info, with this new statistics, we could
> achieve the daily monitoring on NUMA efficiency, to give warning when
> things going too wrong.
> 
> Please check the second patch for more details.
> 
> Michael Wang (2):
>   sched/numa: introduce per-cgroup NUMA locality info
>   sched/numa: documentation for per-cgroup numa statistics
> 
>  Documentation/admin-guide/cg-numa-stat.rst      | 178 ++++++++++++++++++++++++
>  Documentation/admin-guide/index.rst             |   1 +
>  Documentation/admin-guide/kernel-parameters.txt |   4 +
>  Documentation/admin-guide/sysctl/kernel.rst     |   9 ++
>  include/linux/sched.h                           |  15 ++
>  include/linux/sched/sysctl.h                    |   6 +
>  init/Kconfig                                    |  11 ++
>  kernel/sched/core.c                             |  75 ++++++++++
>  kernel/sched/fair.c                             |  62 +++++++++
>  kernel/sched/sched.h                            |  12 ++
>  kernel/sysctl.c                                 |  11 ++
>  11 files changed, 384 insertions(+)
>  create mode 100644 Documentation/admin-guide/cg-numa-stat.rst
> 
