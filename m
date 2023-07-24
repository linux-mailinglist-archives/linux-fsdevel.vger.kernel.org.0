Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718D275F822
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 15:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGXNXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 09:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGXNXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:23:48 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8EBE0;
        Mon, 24 Jul 2023 06:23:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R8gph1hJ1z4f3nyV;
        Mon, 24 Jul 2023 21:23:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LNbe75kcavTOg--.2237S5;
        Mon, 24 Jul 2023 21:23:42 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/2] softirq: fix integer overflow in function show_stat()
Date:   Mon, 24 Jul 2023 21:22:23 +0800
Message-Id: <20230724132224.916-2-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230724132224.916-1-thunder.leizhen@huaweicloud.com>
References: <20230724132224.916-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LNbe75kcavTOg--.2237S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJryDGFy7KryxurWxWF4fAFb_yoW8WFy5pa
        43Kw1jvrW8Cw17XFs7JF1jgry8JF98JayavFyfG342qFyUJ3Z0gFyfKFZ0gFWjgrWrC3yr
        Aa17KryUurWDX3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4
        xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8qFAJUUUUU=
        =
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

The statistics function of softirq is supported by commit aa0ce5bbc2db
("softirq: introduce statistics for softirq") in 2009. At that time,
64-bit processors should not have many cores and would not face
significant count overflow problems. Now it's common for a processor to
have hundreds of cores. Assume that there are 100 cores and 10
TIMER_SOFTIRQ are generated per second, then the 32-bit sum will be
overflowed after 50 days.

For example:
seq_put_decimal_ull(p, "softirq ", (unsigned long long)sum_softirq);
for (i = 0; i < NR_SOFTIRQS; i++)
	seq_put_decimal_ull(p, " ", per_softirq_sums[i]);

$ cat /proc/stat | tail -n 1
softirq 22929066124 9 2963267579 4128150 2618598635 546358555 0 \
629391610 1326100278 74637 1956244783

Here, the sum of per_softirq_sums[] is 10044164236 and is not equal to
22929066124. Because integers overflowed.

Therefore, change the type of local variable per_softirq_sums[] to u64.

Fixes: d3d64df21d3d ("proc: export statistics for softirq to /proc")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/proc/stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index da60956b2915645..84aac577a50cabb 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -86,7 +86,7 @@ static int show_stat(struct seq_file *p, void *v)
 	u64 guest, guest_nice;
 	u64 sum = 0;
 	u64 sum_softirq = 0;
-	unsigned int per_softirq_sums[NR_SOFTIRQS] = {0};
+	u64 per_softirq_sums[NR_SOFTIRQS] = {0};
 	struct timespec64 boottime;
 
 	user = nice = system = idle = iowait =
-- 
2.25.1

