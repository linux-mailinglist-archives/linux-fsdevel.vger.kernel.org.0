Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB8065DCFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 05:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfGCD3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 23:29:20 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:54595 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727598AbfGCD3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:29:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TVvOVSB_1562124555;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TVvOVSB_1562124555)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Jul 2019 11:29:16 +0800
Subject: [PATCH 2/4] numa: append per-node execution info in memory.numa_stat
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
Message-ID: <825ebaf0-9f71-bbe1-f054-7fa585d61af1@linux.alibaba.com>
Date:   Wed, 3 Jul 2019 11:29:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduced numa execution information, to imply the numa
efficiency.

By doing 'cat /sys/fs/cgroup/memory/CGROUP_PATH/memory.numa_stat', we
see new output line heading with 'exectime', like:

  exectime 311900 407166

which means the tasks of this cgroup executed 311900 micro seconds on
node 0, and 407166 ms on node 1.

Combined with the memory node info, we can estimate the numa efficiency,
for example if the node memory info is:

  total=206892 N0=21933 N1=185171

By monitoring the increments, if the topology keep in this way and
locality is not nice, then it imply numa balancing can't help migrate
the memory from node 1 to 0 which is accessing by tasks on node 0, or
tasks can't migrate to node 1 for some reason, then you may consider
to bind the cgroup on the cpus of node 1.

Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0a30d14c9f43..deeca9db17d8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -190,6 +190,7 @@ enum memcg_numa_locality_interval {

 struct memcg_stat_numa {
 	u64 locality[NR_NL_INTERVAL];
+	u64 exectime;
 };

 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2edf3f5ac4b9..d5f48365770f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3575,6 +3575,18 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 		seq_printf(m, " %u", jiffies_to_msecs(sum));
 	}
 	seq_putc(m, '\n');
+
+	seq_puts(m, "exectime");
+	for_each_online_node(nr) {
+		int cpu;
+		u64 sum = 0;
+
+		for_each_cpu(cpu, cpumask_of_node(nr))
+			sum += per_cpu(memcg->stat_numa->exectime, cpu);
+
+		seq_printf(m, " %llu", jiffies_to_msecs(sum));
+	}
+	seq_putc(m, '\n');
 #endif

 	return 0;
@@ -3606,6 +3618,7 @@ void memcg_stat_numa_update(struct task_struct *p)
 	memcg = mem_cgroup_from_task(p);
 	if (idx != -1)
 		this_cpu_inc(memcg->stat_numa->locality[idx]);
+	this_cpu_inc(memcg->stat_numa->exectime);
 	rcu_read_unlock();
 }
 #endif
-- 
2.14.4.44.g2045bb6

