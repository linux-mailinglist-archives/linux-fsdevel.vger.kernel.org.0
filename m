Return-Path: <linux-fsdevel+bounces-8735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A074783A8F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AB11F22CD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C292664B9;
	Wed, 24 Jan 2024 12:00:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B97634E7;
	Wed, 24 Jan 2024 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097610; cv=none; b=OyISF8rXrVF8Amgwmp8QnyWHp5XVeHJkr3xdFpjYs7ms3sahCClTIr3EaSiRvcVEi14mbm7SvatpJxF8HxR80lg1xYrCiedC9T2csVkFOoJcPm4mj+VjJ5ouZ5FAR1ZqGfGBclfo9csN5+81E/jpXp23drO2HaHXxiOKLRvbM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097610; c=relaxed/simple;
	bh=t4Qh0s/9NGiebNos8RWbTI6PuT087Z/eTqnpXervcDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jhxmndNZ6Qr5he0SiJ8rDB7uj376EeUGfTawsjczY0cwYWRDHRWCJ/yPaRZTi+jLf9AFl3CqpD4h9t/Oi38NRYDwNmRGgYMbG1xMfED42Kbx9Uu4HuAx3Im6QG6esoeMigyP3jdSCiHLhCK6MWqaLUsMoCLqN2FMAq4oqUt4Evo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-35-65b0fbb6fc5a
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v11 15/26] dept: Apply sdt_might_sleep_{start,end}() to dma fence wait
Date: Wed, 24 Jan 2024 20:59:26 +0900
Message-Id: <20240124115938.80132-16-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSW1BMcRwHcP9zb7XmzLqdynXNjpmMyxrMT2PIA04PGoZB9cCODrujFhvV
	MlHaqFW5TUU3tbLWlsouKaxJphKVpYZsabRTdI/YRheXlvHym8/8Lt+nH4NLKkhvRqU+JmjU
	ijApJSJEA575S8vGS4UVjTo/uJS8AlzfEwnILimiwF5ciKDoXhwGPdVb4N1IP4Lxhlc4ZKTZ
	EeR3fMDhXk07ApvpDAVNndOg2TVEQV3aeQrib5RQ8LpvAoO29MsYFFq2wsuLBgwqRz8TkNFD
	QVZGPDZZujEYNZppMMbKwGnKpGGiQw517W9JsDmWwLXcNgoe2+oIqCl3YtD0MJuC9qLfJLys
	eU6A/VIKCXcGDRT0jRhxMLqGaHhTmYdBqW4y6Oy3XyTUplRicLbgLgbN7x8heJL4EQNL0VsK
	nrn6MbBa0nAYu1WNwJk6QENC8igNWXGpCM4npBPw6mctCbq21TD+I5vy9+Of9Q/hvM4axdtG
	8gj+hYHjKzI/0LzuiYPm8yzHeavJl7/xuAfj84ddJG8xJ1G8ZfgyzesHmjF+sLGR5p9fHSf4
	zuYMbJtPsGhdqBCmihQ0y9fvEylTWxvRkThxtOU6HYu6RHrkwXDsKi69tx79t6E6AXebYhdz
	LS2jfz2DXcBZUz6ReiRicPbcVM70pYHSI4aZzu7iTH073DsEK+MKvr6g3Raza7ghVy/+L3M+
	V1ha+dcek/071xyE2xJ2NffRfIF2Z3JsvAfXcdNJ/zvw4p6aWoiLSJyHppiRRKWODFeowlYt
	U2rVquhl+w+HW9DkQxljJkLK0bB9RxViGST1FPubSwQJqYiM0IZXIY7BpTPELV7FgkQcqtCe
	EDSH92qOhwkRVciHIaSzxStHokIl7EHFMeGQIBwRNP+nGOPhHYtSCwOaSkLG5FcOaNf6+Hnl
	dA5oF0Jgr+yBv+3rvpPBZdJ665hj02nrnk3MbbHBWRxU9z5Qbr/fqgv2PCWbrSuIDIq5Kquo
	LY6ex27flax2ytUBcaG5c4Wj7UmEsq90w/WbuYtyujbvnNetfOc/p2tmcGDAXt9p+vRZG2+d
	++GA3VIiQqmQ++KaCMUfAxQQ8EwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSf0yMcRwHcN/nd6ezx7nNI4admVUkm/hs0rLZPLMxw5gfm57pUaer7K6O
	DCt1J0eptiRFp3LO3alcNFKtdfo9iRpJWhqSfhzqmnMdivnns9c+78/ef30YXFZA+jHKuARR
	HSeoFJSEkOzclLqmylMhBrdML4fsy8HgmkwnoLDcRkFnmRWB7UEKBsON2+D11CgCz7PnOOTl
	diK49f4dDg+a+hHUms9T0PVhHnS7nBS05l6iILWknIIXI9MY9F3NwcBq3wHtWcUY1LuHCMgb
	pqAgLxWbGZ8xcJssNJiSV8Kg+ToN0+/XQWv/KxIcN1pJqO0NhPybfRTU1LYS0PRoEIOu6kIK
	+m2/SWhvaiGgMzuDhHvjxRSMTJlwMLmcNLysN2JQkTbTpp/4RUJzRj0G+tL7GHS/eYKgLn0A
	A7vtFQUO1ygGlfZcHH7eaUQwmDlGg+6ym4aClEwEl3RXCXjubSYhrS8EPD8KqfBNvGPUifNp
	lSf52ikjwbcVc/zj6+9oPq2ul+aN9kS+0hzAl9QMY/yt7y6St1suUrz9ew7NG8a6MX68o4Pm
	W655CP5Ddx62a8lBSWikqFJqRfXasAhJdObbDnQiRXrKXkQno48SA/JhOHY9V9yow2dNsau4
	nh73X8vZ5VxlxifSgCQMzl6Yy5m/PqMMiGEWsPs488ie2RuCXcmVfmujZy1lN3BO1xf8X+cy
	zlpR/9c+M/t7+b3ErGVsCDdguUJnIYkRzbEguTJOGysoVSFBmpjopDjlqaCj8bF2NPMyprPT
	2Y/QZNe2BsQySOErDbeUizJS0GqSYhsQx+AKubRnUZkok0YKSadFdfwRdaJK1DSgxQyhWCjd
	vl+MkLFRQoIYI4onRPX/FGN8/JLR/MNLI6u8+bvu6ir2/YzCgw9vVYX2h7qE8pGevf7Hgs+c
	G9dD1UWnPP7axv0Td7mh12FX3Hpv5u1Jw0S7XKJvPzdQV/3DI+R4OzYbDVmDhzYEhhWRCdXp
	q7V94Vbf7BV+x72yjT5hrjm7n24pPeKwObRj/gfGEsmhqtK3D/18JxWEJlpYF4CrNcIfhViG
	ai4DAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Makes Dept able to track dma fence waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/dma-buf/dma-fence.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 8aa8f8cb7071..76dba11f0dab 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -16,6 +16,7 @@
 #include <linux/dma-fence.h>
 #include <linux/sched/signal.h>
 #include <linux/seq_file.h>
+#include <linux/dept_sdt.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/dma_fence.h>
@@ -783,6 +784,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 	cb.task = current;
 	list_add(&cb.base.node, &fence->cb_list);
 
+	sdt_might_sleep_start(NULL);
 	while (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) && ret > 0) {
 		if (intr)
 			__set_current_state(TASK_INTERRUPTIBLE);
@@ -796,6 +798,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	if (!list_empty(&cb.base.node))
 		list_del(&cb.base.node);
@@ -885,6 +888,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		}
 	}
 
+	sdt_might_sleep_start(NULL);
 	while (ret > 0) {
 		if (intr)
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -899,6 +903,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	__set_current_state(TASK_RUNNING);
 
-- 
2.17.1


