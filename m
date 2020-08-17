Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F99246814
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 16:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgHQOKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 10:10:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60191 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728852AbgHQOKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597673405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=lMSQ3zYe5JdMkN7xyyD+27PUqcIN4NvxLvoYzin94RU=;
        b=Lh2beVP8U2MYUcABT48pLfJbGguURkli87Xtj8GlBzXc5G98m/ssC1G53DvP98r4k0Pgb2
        oI3hw6sLMHCKyo5FR5jA8XO9Pokzubw37oV2rBVF5B/cGhlEvn+r3DaVY1pZJd5V6KtON5
        zd9WuDL5aL1MdNspkrx0ywoN+AHgncM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-zyuWZt46PtifejKTk5r3ZA-1; Mon, 17 Aug 2020 10:10:01 -0400
X-MC-Unique: zyuWZt46PtifejKTk5r3ZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF50918686C4;
        Mon, 17 Aug 2020 14:09:59 +0000 (UTC)
Received: from llong.com (ovpn-118-35.rdu2.redhat.com [10.10.118.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AED9821E8F;
        Mon, 17 Aug 2020 14:09:57 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 6/8] memcg: Introduce additional memory control slowdown if needed
Date:   Mon, 17 Aug 2020 10:08:29 -0400
Message-Id: <20200817140831.30260-7-longman@redhat.com>
In-Reply-To: <20200817140831.30260-1-longman@redhat.com>
References: <20200817140831.30260-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For fast cpus on slow disks, yielding the cpus repeatedly with
PR_MEMACT_SLOWDOWN may not be able to slow down memory allocation enough
for memory reclaim to catch up. In case a large memory block is mmap'ed
and the pages are faulted in one-by-one, the syscall delays won't be
activated during this process.

To be safe, an additional variable delay of 20-5000 us will be added
to __mem_cgroup_over_high_action() if the excess memory used is more
than 1/256 of the memory limit.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6488f8a10d66..bddf3e659469 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2643,11 +2643,10 @@ get_rss_counter(struct mm_struct *mm, int mm_bit, u16 flags, int rss_bit)
 static bool __mem_cgroup_over_high_action(struct mem_cgroup *memcg, u8 action,
 					  u16 flags)
 {
-	unsigned long mem = 0;
+	unsigned long mem = 0, limit = 0, excess = 0;
 	bool ret = false;
 	struct mm_struct *mm = get_task_mm(current);
 	u8  signal = READ_ONCE(current->memcg_over_high_signal);
-	u32 limit;
 
 	if (!mm)
 		return true;	/* No more check is needed */
@@ -2657,9 +2656,10 @@ static bool __mem_cgroup_over_high_action(struct mem_cgroup *memcg, u8 action,
 
 	if (memcg) {
 		mem = page_counter_read(&memcg->memory);
-		limit = READ_ONCE(current->memcg_over_high_climit);
-		if (mem <= memcg->memory.high + limit)
+		limit = READ_ONCE(current->memcg_over_high_climit) + memcg->memory.high;
+		if (mem <= limit)
 			goto out;
+		excess = mem - limit;
 	}
 
 	/*
@@ -2676,6 +2676,7 @@ static bool __mem_cgroup_over_high_action(struct mem_cgroup *memcg, u8 action,
 		limit = READ_ONCE(current->memcg_over_high_plimit);
 		if (mem <= limit)
 			goto out;
+		excess = mem - limit;
 	}
 
 	ret = true;
@@ -2685,10 +2686,19 @@ static bool __mem_cgroup_over_high_action(struct mem_cgroup *memcg, u8 action,
 		break;
 	case PR_MEMACT_SLOWDOWN:
 		/*
-		 * Slow down by yielding the cpu & adding delay to
-		 * memory allocation syscalls.
+		 * Slow down by yielding the cpu & adding delay to memory
+		 * allocation syscalls.
+		 *
+		 * An additional 20-5000 us of delay is added in case the
+		 * excess memory is more than 1/256 of the limit.
 		 */
 		WRITE_ONCE(current->memcg_over_limit, true);
+		limit >>= 8;
+		if (limit && (excess > limit)) {
+			int delay = min(5000UL, excess/limit * 20UL);
+
+			udelay(delay);
+		}
 		set_tsk_need_resched(current);
 		set_preempt_need_resched();
 		break;
-- 
2.18.1

