Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB483BC197
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 18:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhGEQ0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 12:26:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55162 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhGEQ0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 12:26:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 813B61FEB7;
        Mon,  5 Jul 2021 16:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625502208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+b98YqRK+9Ac0JbTnwMPdtBA76rUD2t6b5cSzamRWx8=;
        b=zH/nFVVXUlozatZfDdmeXi2zntrIN1hqZd2kHvDHkjBOuYNlo5tZI0kXN1DTtgneW8rrvj
        Hfhv5uhO0IzoRJSdS+LfTdb9xQhTuCpUmvomtD/rQ0foZdrQ8IPPxmodTpiWRoyM+3b54F
        SH+bh3Jc4MIT5Ec1xLc5IdeAeYY7TYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625502208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+b98YqRK+9Ac0JbTnwMPdtBA76rUD2t6b5cSzamRWx8=;
        b=2YmTTMuo6f9Otcc71BzxdOFpJ55jzExThVuD7pahRzdJV26lkcDRo9M9wqxjfb5v4GZJd2
        WEGlYJiQySv/7aDA==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 74298A3BA8;
        Mon,  5 Jul 2021 16:23:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4688C1F2CBE; Mon,  5 Jul 2021 18:23:28 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Michael Stapelberg <stapelberg+linux@google.com>,
        <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/5] writeback: Fix bandwidth estimate for spiky workload
Date:   Mon,  5 Jul 2021 18:23:17 +0200
Message-Id: <20210705162328.28366-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210705161610.19406-1-jack@suse.cz>
References: <20210705161610.19406-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6394; h=from:subject; bh=cwzknGok4CQVfoRflzeLzyEd6Wpkt+t4xXEuAWf5TYU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg4zH1HdOWNBXDsim6a4WRVqlLbnqToymTmQcbpjdi REUOKhGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOMx9QAKCRCcnaoHP2RA2WpfCA CnQwiCTudal0/H7QmEavro3MRix5eU/3KiupMX6ItgTJZTnK3vsWKUFlql0YoxC0hzyvYvn37wsdkS 9QC36pXnctkor1BYDIZ5d+KcrCUgSsGj8/tFtGRtR/sozpNsEvFGPXX9luTQfaCoMG9KNvj+XTdVFb uw5GqnsqK76lV2+IDq2kmrQLTtijYYLcF/VYHcVk2UN2K0yCClakm6yIoeQYfIV1y7alQl1GLVVfhC NjO+wDessJiW7pmBh+CRjBeIlIGHbM+vtCYrKdcaOw0yq9sAzqEr2t6pVnn12lDmhGqBuMy44PcKJJ Dn1VKQb4x8hdp8xov9n1Coade+LvH7
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michael Stapelberg has reported that for workload with short big spikes
of writes (GCC linker seem to trigger this frequently) the write
throughput is heavily underestimated and tends to steadily sink until it
reaches zero. This has rather bad impact on writeback throttling
(causing stalls). The problem is that writeback throughput estimate gets
updated at most once per 200 ms. One update happens early after we
submit pages for writeback (at that point writeout of only small
fraction of pages is completed and thus observed throughput is tiny).
Next update happens only during the next write spike (updates happen
only from inode writeback and dirty throttling code) and if that is
more than 1s after previous spike, we decide system was idle and just
ignore whatever was written until this moment.

Fix the problem by making sure writeback throughput estimate is also
updated shortly after writeback completes to get reasonable estimate of
throughput for spiky workloads.

Link: https://lore.kernel.org/lkml/20210617095309.3542373-1-stapelberg+linux@google.com
Reported-by: Michael Stapelberg <stapelberg+linux@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/backing-dev-defs.h |  1 +
 include/linux/writeback.h        |  1 +
 mm/backing-dev.c                 | 10 ++++++++++
 mm/page-writeback.c              | 32 ++++++++++++++++----------------
 4 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 148d889f2f7f..57395f7bb192 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -143,6 +143,7 @@ struct bdi_writeback {
 	spinlock_t work_lock;		/* protects work_list & dwork scheduling */
 	struct list_head work_list;
 	struct delayed_work dwork;	/* work item used for writeback */
+	struct delayed_work bw_dwork;	/* work item used for bandwidth estimate */
 
 	unsigned long dirty_sleep;	/* last wait */
 
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 47cd732e012e..a45e09ed0711 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -379,6 +379,7 @@ int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
 void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
 unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh);
 
+void wb_update_bandwidth(struct bdi_writeback *wb);
 void balance_dirty_pages_ratelimited(struct address_space *mapping);
 bool wb_over_bg_thresh(struct bdi_writeback *wb);
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 342394ef1e02..9baa59d68110 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -271,6 +271,14 @@ void wb_wakeup_delayed(struct bdi_writeback *wb)
 	spin_unlock_bh(&wb->work_lock);
 }
 
+static void wb_update_bandwidth_workfn(struct work_struct *work)
+{
+	struct bdi_writeback *wb = container_of(to_delayed_work(work),
+						struct bdi_writeback, bw_dwork);
+
+	wb_update_bandwidth(wb);
+}
+
 /*
  * Initial write bandwidth: 100 MB/s
  */
@@ -303,6 +311,7 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	spin_lock_init(&wb->work_lock);
 	INIT_LIST_HEAD(&wb->work_list);
 	INIT_DELAYED_WORK(&wb->dwork, wb_workfn);
+	INIT_DELAYED_WORK(&wb->bw_dwork, wb_update_bandwidth_workfn);
 	wb->dirty_sleep = jiffies;
 
 	err = fprop_local_init_percpu(&wb->completions, gfp);
@@ -351,6 +360,7 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	mod_delayed_work(bdi_wq, &wb->dwork, 0);
 	flush_delayed_work(&wb->dwork);
 	WARN_ON(!list_empty(&wb->work_list));
+	flush_delayed_work(&wb->bw_dwork);
 }
 
 static void wb_exit(struct bdi_writeback *wb)
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 1fecf8ebadb0..6a99ddca95c0 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1346,14 +1346,7 @@ static void __wb_update_bandwidth(struct dirty_throttle_control *gdtc,
 	unsigned long dirtied;
 	unsigned long written;
 
-	lockdep_assert_held(&wb->list_lock);
-
-	/*
-	 * rate-limit, only update once every 200ms.
-	 */
-	if (elapsed < BANDWIDTH_INTERVAL)
-		return;
-
+	spin_lock(&wb->list_lock);
 	dirtied = percpu_counter_read(&wb->stat[WB_DIRTIED]);
 	written = percpu_counter_read(&wb->stat[WB_WRITTEN]);
 
@@ -1375,15 +1368,14 @@ static void __wb_update_bandwidth(struct dirty_throttle_control *gdtc,
 	wb->dirtied_stamp = dirtied;
 	wb->written_stamp = written;
 	wb->bw_time_stamp = now;
+	spin_unlock(&wb->list_lock);
 }
 
-static void wb_update_bandwidth(struct bdi_writeback *wb)
+void wb_update_bandwidth(struct bdi_writeback *wb)
 {
 	struct dirty_throttle_control gdtc = { GDTC_INIT(wb) };
 
-	spin_lock(&wb->list_lock);
 	__wb_update_bandwidth(&gdtc, NULL, false);
-	spin_unlock(&wb->list_lock);
 }
 
 /* Interval after which we consider wb idle and don't estimate bandwidth */
@@ -1728,11 +1720,8 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
 			wb->dirty_exceeded = 1;
 
 		if (time_is_before_jiffies(wb->bw_time_stamp +
-					   BANDWIDTH_INTERVAL)) {
-			spin_lock(&wb->list_lock);
+					   BANDWIDTH_INTERVAL))
 			__wb_update_bandwidth(gdtc, mdtc, true);
-			spin_unlock(&wb->list_lock);
-		}
 
 		/* throttle according to the chosen dtc */
 		dirty_ratelimit = wb->dirty_ratelimit;
@@ -2371,7 +2360,13 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 		cond_resched();
 		congestion_wait(BLK_RW_ASYNC, HZ/50);
 	}
-	wb_update_bandwidth(wb);
+	/*
+	 * Usually few pages are written by now from those we've just submitted
+	 * but if there's constant writeback being submitted, this makes sure
+	 * writeback bandwidth is updated once in a while.
+	 */
+	if (time_is_before_jiffies(wb->bw_time_stamp + BANDWIDTH_INTERVAL))
+		wb_update_bandwidth(wb);
 	return ret;
 }
 
@@ -2742,6 +2737,11 @@ static void wb_inode_writeback_start(struct bdi_writeback *wb)
 static void wb_inode_writeback_end(struct bdi_writeback *wb)
 {
 	atomic_dec(&wb->writeback_inodes);
+	/*
+	 * Make sure estimate of writeback throughput gets
+	 * updated after writeback completed.
+	 */
+	queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
 }
 
 int test_clear_page_writeback(struct page *page)
-- 
2.26.2

