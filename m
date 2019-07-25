Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B43D74354
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 04:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389181AbfGYCdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jul 2019 22:33:17 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59362 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388369AbfGYCdR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:33:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TXkJoVQ_1564021990;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TXkJoVQ_1564021990)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Jul 2019 10:33:11 +0800
Subject: Re: [PATCH v2 0/4] per-cgroup numa suite
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <65c1987f-bcce-2165-8c30-cf8cf3454591@linux.alibaba.com>
Message-ID: <2203b828-1458-5fec-f4f6-353f51091e2a@linux.alibaba.com>
Date:   Thu, 25 Jul 2019 10:33:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <65c1987f-bcce-2165-8c30-cf8cf3454591@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Peter

Now we have all these stuff in cpu cgroup, with the new statistic
folks should be able to estimate their per-cgroup workloads on
numa platform, and numa group + cling would help to address the
issue when their workloads can't be settled on one node.

How do you think about this version :-)

Regards,
Michael Wang

On 2019/7/16 上午11:38, 王贇 wrote:
> During our torturing on numa stuff, we found problems like:
> 
>   * missing per-cgroup information about the per-node execution status
>   * missing per-cgroup information about the numa locality
> 
> That is when we have a cpu cgroup running with bunch of tasks, no good
> way to tell how it's tasks are dealing with numa.
> 
> The first two patches are trying to complete the missing pieces, but
> more problems appeared after monitoring these status:
> 
>   * tasks not always running on the preferred numa node
>   * tasks from same cgroup running on different nodes
> 
> The task numa group handler will always check if tasks are sharing pages
> and try to pack them into a single numa group, so they will have chance to
> settle down on the same node, but this failed in some cases:
> 
>   * workloads share page caches rather than share mappings
>   * workloads got too many wakeup across nodes
> 
> Since page caches are not traced by numa balancing, there are no way to
> realize such kind of relationship, and when there are too many wakeup,
> task will be drag from the preferred node and then migrate back by numa
> balancing, repeatedly.
> 
> Here the third patch try to address the first issue, we could now give hint
> to kernel about the relationship of tasks, and pack them into single numa
> group.
> 
> And the forth patch introduced numa cling, which try to address the wakup
> issue, now we try to make task stay on the preferred node on wakeup in fast
> path, in order to address the unbalancing risk, we monitoring the numa
> migration failure ratio, and pause numa cling when it reach the specified
> degree.
> 
> Since v1:
>   * move statistics from memory cgroup into cpu group
>   * statistics now accounting in hierarchical way
>   * locality now accounted into 8 regions equally
>   * numa cling no longer override select_idle_sibling, instead we
>     prevent numa swap migration with tasks cling to dst-node, also
>     prevent wake affine to drag tasks away which already cling to
>     prev-cpu
>   * other refine on comments and names
> 
> Michael Wang (4):
>   v2 numa: introduce per-cgroup numa balancing locality statistic
>   v2 numa: append per-node execution time in cpu.numa_stat
>   v2 numa: introduce numa group per task group
>   v4 numa: introduce numa cling feature
> 
>  include/linux/sched.h        |   8 +-
>  include/linux/sched/sysctl.h |   3 +
>  kernel/sched/core.c          |  85 ++++++++
>  kernel/sched/debug.c         |   7 +
>  kernel/sched/fair.c          | 510 ++++++++++++++++++++++++++++++++++++++++++-
>  kernel/sched/sched.h         |  41 ++++
>  kernel/sysctl.c              |   9 +
>  7 files changed, 651 insertions(+), 12 deletions(-)
> 
