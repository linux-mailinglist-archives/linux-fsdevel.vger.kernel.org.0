Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262EB5DCE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 05:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfGCD0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 23:26:37 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51202 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727142AbfGCD0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:26:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TVvT.Sc_1562124377;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TVvT.Sc_1562124377)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Jul 2019 11:26:33 +0800
Subject: [PATCH 0/4] per cpu cgroup numa suite
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
Message-ID: <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
Date:   Wed, 3 Jul 2019 11:26:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

During our torturing on numa stuff, we found problems like:

  * missing per-cgroup information about the per-node execution status
  * missing per-cgroup information about the numa locality

That is when we have a cpu cgroup running with bunch of tasks, no good
way to tell how it's tasks are dealing with numa.

The first two patches are trying to complete the missing pieces, but
more problems appeared after monitoring these status:

  * tasks not always running on the preferred numa node
  * tasks from same cgroup running on different nodes

The task numa group handler will always check if tasks are sharing pages
and try to pack them into a single numa group, so they will have chance to
settle down on the same node, but this failed in some cases:

  * workloads share page caches rather than share mappings
  * workloads got too many wakeup across nodes

Since page caches are not traced by numa balancing, there are no way to
realize such kind of relationship, and when there are too many wakeup,
task will be drag from the preferred node and then migrate back by numa
balancing, repeatedly.

Here the third patch try to address the first issue, we could now give hint
to kernel about the relationship of tasks, and pack them into single numa
group.

And the forth patch introduced numa cling, which try to address the wakup
issue, now we try to make task stay on the preferred node on wakeup in fast
path, in order to address the unbalancing risk, we monitoring the numa
migration failure ratio, and pause numa cling when it reach the specified
degree.

Michael Wang (4):
  numa: introduce per-cgroup numa balancing locality statistic
  numa: append per-node execution info in memory.numa_stat
  numa: introduce numa group per task group
  numa: introduce numa cling feature

 include/linux/memcontrol.h   |  37 ++++
 include/linux/sched.h        |   8 +-
 include/linux/sched/sysctl.h |   3 +
 kernel/sched/core.c          |  37 ++++
 kernel/sched/debug.c         |   7 +
 kernel/sched/fair.c          | 455 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h         |  14 ++
 kernel/sysctl.c              |   9 +
 mm/memcontrol.c              |  66 +++++++
 9 files changed, 628 insertions(+), 8 deletions(-)

-- 
2.14.4.44.g2045bb6

