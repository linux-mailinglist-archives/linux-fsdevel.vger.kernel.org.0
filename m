Return-Path: <linux-fsdevel+bounces-58380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAE0B2DABC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 13:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0185C1593
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 11:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027D42E5402;
	Wed, 20 Aug 2025 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Efe/jID8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD6E2E3AE8
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688797; cv=none; b=ePEQYcCIot+/U271Gl2Ok2u0vxsaam2hF10UnKBdvLXWBlqsIG3OJbTJEFC8fagH5mjqnuqprWJBlNtsNa1M/0wHaWxdugvKIH4bK1j4FLQoRy6amzVirD2864PInxXr6U3eFC1SPIWL0gyJlxv+oH7Un7o9Bw45p5Mhq68pyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688797; c=relaxed/simple;
	bh=Ll09qK4uxzqN8tfTDENp2btM81EVtcyb+7pYC4wn0aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b6hU56q6wHD7ivudWdq+uryBkqh57HQxW1MJsSHG0Is+2oWa+eIyztXwy6APjGIRSPBmEDbT/eTYtkRQsg40aqD1FgVqAr5QPOsEIBTl+Iexgh88F4HE83U3C0E/P5+wooVImxGITe0dQLydECRgirmZIfrjKvn0Wmme+kuDGnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Efe/jID8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-245f5213679so2791575ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 04:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755688795; x=1756293595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0sra2AN3siCOY/j4YATSW1j6v/rnanIT2GxrMhLaB8=;
        b=Efe/jID8+D2OzMnxjNkuGcle/bkw+dUqdhBD6VlFt01tfJ87ujNyvlQ08F9yp2CAk5
         Oj9j1PQF6RGkaRQWh3jI78QHMdxQ5hke7HxJoGlNVV62w1SIH6ArqyKiGSdBKdBwnmS4
         76YZUVcDYnW6BYni/aSNMDBlG+OqM9NzRJJDdx6EOE/yeSOOVXFnfI7vbQdia8YkfrAJ
         OHo3NNIZVnDvAb54d6Pfzo6IxlHgvsY922581KGPY11brXpNKw+wCkDFFHaCxNycnPlM
         7G25AkCcHOS+B1wehBkSbImWIGUCE6jCKJvzWG0l3UhD+Oc3ZfnAoQ5wP3j58u0fwUuv
         T2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755688795; x=1756293595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0sra2AN3siCOY/j4YATSW1j6v/rnanIT2GxrMhLaB8=;
        b=gfyA3z3wWMPnfg/BWNFvC0Ek+PLSC+jCmVKzhFVWErVo2BJV+DmYKYZgjP1lJ43rvG
         jKm9IgPoCVGtvARvipZmiJtiPcpnWZan2R9EImbsJI2XxPdsVn3EQQ1qlnaIEUrYmwVp
         jeNnKeGJQlLhiH3q+clyGnMWjQfZPfLHG3YyPnpxIT+K4LuH/vI7ObRHwQm+ZjlqPSDw
         f4oWbQbI6qIu0+0czTsAPg42YBfzAr0j5O4EJgvxUvQ5lbSZwdWRf8Tsr9YGLzp7r7ps
         76/S7fk3XHnZYmW/KLnYqQleC85MBb7llayuAzhucN7ekbY5YXUzCuaKHgfw3YcIe376
         061Q==
X-Gm-Message-State: AOJu0YxJ/tB+xmyuVfH7wXKDgj6PB2HwNsdtVyxdVTRHAcXAllDWZdlt
	JduSUm8z6q9ASlCLsnEjnW0xvJj1YqlTS0qfYKARPcgK8gfMbl7LB1J5bXz/8mi7C+5HSlKu4ak
	7jRQDR6w=
X-Gm-Gg: ASbGncvaBMomJLbKYiEUZofQAwowBaECCrCQqpj5ek76S8CiXeC2oKKAtKIWnyMCeiF
	aQIhZOL5OBFPdrexaUP1IJcIhHdw83EjpzYhuBwy4TFUCmeJHiBoPL+uPjXfQpRtuZ7xsE/cAG3
	ot7PuWXwc94g8TwDcXkMF8ywKPnz6e20XuCCGfTFw4yT7HWdR6HdrkceJWjFOJIGeTs6idWChA1
	Y2tGyYEE6pGz/2duTI0SG16SYSJRbrtS7OEw86F65uIax4+d+hICq993RCXiNXYWGtWyK5O78Uv
	3ydbbJyOFo3vlTzuvsdcKsLYmBQB+5IC6rJLqcWWm2aBkMAa54hNcyGRb3aFZOhyvh1J1wZwaSN
	a6DcNe48MUjj3LkWPbXuL0xvtdGmOdT0=
X-Google-Smtp-Source: AGHT+IFElDAZuo1wYAZ9DSpXz5PMAnw229u8a3n2AOhgQWMMLXXcL79GdXnqls6Uh8xCnu+cW2L85w==
X-Received: by 2002:a17:903:248:b0:235:15f3:ef16 with SMTP id d9443c01a7336-245ef11112amr30391975ad.13.1755688794886;
        Wed, 20 Aug 2025 04:19:54 -0700 (PDT)
Received: from localhost ([106.38.226.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33a76asm24187645ad.32.2025.08.20.04.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:19:54 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	axboe@kernel.dk,
	tj@kernel.org
Subject: [PATCH] memcg: Don't wait writeback completion when release memcg.
Date: Wed, 20 Aug 2025 19:19:40 +0800
Message-Id: <20250820111940.4105766-4-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250820111940.4105766-1-sunjunchao@bytedance.com>
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, we encountered the following hung task:

INFO: task kworker/4:1:1334558 blocked for more than 1720 seconds.
[Wed Jul 30 17:47:45 2025] Workqueue: cgroup_destroy css_free_rwork_fn
[Wed Jul 30 17:47:45 2025] Call Trace:
[Wed Jul 30 17:47:45 2025]  __schedule+0x934/0xe10
[Wed Jul 30 17:47:45 2025]  ? complete+0x3b/0x50
[Wed Jul 30 17:47:45 2025]  ? _cond_resched+0x15/0x30
[Wed Jul 30 17:47:45 2025]  schedule+0x40/0xb0
[Wed Jul 30 17:47:45 2025]  wb_wait_for_completion+0x52/0x80
[Wed Jul 30 17:47:45 2025]  ? finish_wait+0x80/0x80
[Wed Jul 30 17:47:45 2025]  mem_cgroup_css_free+0x22/0x1b0
[Wed Jul 30 17:47:45 2025]  css_free_rwork_fn+0x42/0x380
[Wed Jul 30 17:47:45 2025]  process_one_work+0x1a2/0x360
[Wed Jul 30 17:47:45 2025]  worker_thread+0x30/0x390
[Wed Jul 30 17:47:45 2025]  ? create_worker+0x1a0/0x1a0
[Wed Jul 30 17:47:45 2025]  kthread+0x110/0x130
[Wed Jul 30 17:47:45 2025]  ? __kthread_cancel_work+0x40/0x40
[Wed Jul 30 17:47:45 2025]  ret_from_fork+0x1f/0x30

The direct cause is that memcg spends a long time waiting for dirty page
writeback of foreign memcgs during release.

The root causes are:
    a. The wb may have multiple writeback tasks, containing hundreds of
       thousands of dirty pages, as shown below:

>>> for work in list_for_each_entry("struct wb_writeback_work", \
				    wb.work_list.address_of_(), "list"):
...     print(work.nr_pages, work.reason, hex(work))
...
900628  WB_REASON_FOREIGN_FLUSH 0xffff969e8d956b40
1116521 WB_REASON_FOREIGN_FLUSH 0xffff9698332a9540
1275228 WB_REASON_FOREIGN_FLUSH 0xffff969d9b444bc0
1099673 WB_REASON_FOREIGN_FLUSH 0xffff969f0954d6c0
1351522 WB_REASON_FOREIGN_FLUSH 0xffff969e76713340
2567437 WB_REASON_FOREIGN_FLUSH 0xffff9694ae208400
2954033 WB_REASON_FOREIGN_FLUSH 0xffff96a22d62cbc0
3008860 WB_REASON_FOREIGN_FLUSH 0xffff969eee8ce3c0
3337932 WB_REASON_FOREIGN_FLUSH 0xffff9695b45156c0
3348916 WB_REASON_FOREIGN_FLUSH 0xffff96a22c7a4f40
3345363 WB_REASON_FOREIGN_FLUSH 0xffff969e5d872800
3333581 WB_REASON_FOREIGN_FLUSH 0xffff969efd0f4600
3382225 WB_REASON_FOREIGN_FLUSH 0xffff969e770edcc0
3418770 WB_REASON_FOREIGN_FLUSH 0xffff96a252ceea40
3387648 WB_REASON_FOREIGN_FLUSH 0xffff96a3bda86340
3385420 WB_REASON_FOREIGN_FLUSH 0xffff969efc6eb280
3418730 WB_REASON_FOREIGN_FLUSH 0xffff96a348ab1040
3426155 WB_REASON_FOREIGN_FLUSH 0xffff969d90beac00
3397995 WB_REASON_FOREIGN_FLUSH 0xffff96a2d7288800
3293095 WB_REASON_FOREIGN_FLUSH 0xffff969dab423240
3293595 WB_REASON_FOREIGN_FLUSH 0xffff969c765ff400
3199511 WB_REASON_FOREIGN_FLUSH 0xffff969a72d5e680
3085016 WB_REASON_FOREIGN_FLUSH 0xffff969f0455e000
3035712 WB_REASON_FOREIGN_FLUSH 0xffff969d9bbf4b00

    b. The writeback might severely throttled by wbt, with a speed
       possibly less than 100kb/s, leading to a very long writeback time.

>>> wb.write_bandwidth
(unsigned long)24
>>> wb.write_bandwidth
(unsigned long)13

The wb_wait_for_completion() here is probably only used to prevent
use-after-free. Therefore, we manage 'done' separately and automatically
free this memory in finish_writeback_work().

This allows us to remove wb_wait_for_completion() while preventing
the use-after-free issue.

Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/fs-writeback.c                |  1 +
 include/linux/backing-dev-defs.h |  6 ++++++
 include/linux/memcontrol.h       |  2 +-
 mm/memcontrol.c                  | 31 ++++++++++++++++++++++---------
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 56faf5c3d064..fac3ef7e95ae 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1136,6 +1136,7 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 		work->reason = reason;
 		work->done = done;
 		work->free_work = 1;
+		work->free_done = 1;
 		wb_queue_work(wb, work);
 		ret = 0;
 	} else {
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2ad261082bba..bf28dd9a4783 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -208,6 +208,12 @@ struct wb_lock_cookie {
 	unsigned long flags;
 };
 
+static inline void wb_completion_init(struct wb_completion *done, struct wait_queue_head *waitq)
+{
+	atomic_set(&done->cnt, 1);
+	done->waitq = waitq;
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 /**
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 785173aa0739..80a6bafbb24a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -161,7 +161,7 @@ struct memcg_cgwb_frn {
 	u64 bdi_id;			/* bdi->id of the foreign inode */
 	int memcg_id;			/* memcg->css.id of foreign inode */
 	u64 at;				/* jiffies_64 at the time of dirtying */
-	struct wb_completion done;	/* tracks in-flight foreign writebacks */
+	struct wb_completion *done;	/* tracks in-flight foreign writebacks */
 };
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..6e6a1ce7589a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3459,7 +3459,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 		    frn->memcg_id == wb->memcg_css->id)
 			break;
 		if (time_before64(frn->at, oldest_at) &&
-		    atomic_read(&frn->done.cnt) == 1) {
+		    atomic_read(&frn->done->cnt) == 1) {
 			oldest = i;
 			oldest_at = frn->at;
 		}
@@ -3506,12 +3506,12 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 		 * already one in flight.
 		 */
 		if (time_after64(frn->at, now - intv) &&
-		    atomic_read(&frn->done.cnt) == 1) {
+		    atomic_read(&frn->done->cnt) == 1) {
 			frn->at = 0;
 			trace_flush_foreign(wb, frn->bdi_id, frn->memcg_id);
 			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id,
 					       WB_REASON_FOREIGN_FLUSH,
-					       &frn->done);
+					       frn->done);
 		}
 	}
 }
@@ -3708,7 +3708,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	struct memcg_vmstats_percpu __percpu *pstatc_pcpu;
 	struct mem_cgroup *memcg;
 	int node, cpu;
-	int __maybe_unused i;
+	int __maybe_unused i = 0;
 	long error;
 
 	memcg = kmem_cache_zalloc(memcg_cachep, GFP_KERNEL);
@@ -3763,9 +3763,14 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	INIT_LIST_HEAD(&memcg->objcg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		memcg->cgwb_frn[i].done =
-			__WB_COMPLETION_INIT(&memcg_cgwb_frn_waitq);
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		struct memcg_cgwb_frn *frn = &memcg->cgwb_frn[i];
+
+		frn->done = kmalloc(sizeof(struct wb_completion), GFP_KERNEL);
+		if (!frn->done)
+			goto fail;
+		wb_completion_init(frn->done, &memcg_cgwb_frn_waitq);
+	}
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
@@ -3775,6 +3780,10 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	lru_gen_init_memcg(memcg);
 	return memcg;
 fail:
+#ifdef CONFIG_CGROUP_WRITEBACK
+	while (i--)
+		kfree(memcg->cgwb_frn[i].done);
+#endif
 	mem_cgroup_id_remove(memcg);
 	__mem_cgroup_free(memcg);
 	return ERR_PTR(error);
@@ -3912,8 +3921,12 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	int __maybe_unused i;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		struct wb_completion *done = memcg->cgwb_frn[i].done;
+
+		if (atomic_dec_and_test(&done->cnt))
+			kfree(done);
+	}
 #endif
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_dec(&memcg_sockets_enabled_key);
-- 
2.20.1


