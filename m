Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748953BC19B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 18:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhGEQ0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 12:26:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55202 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhGEQ0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 12:26:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A6B06203A4;
        Mon,  5 Jul 2021 16:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625502208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9B+bgNZjQ9mvr7D5XuowXLwKzGqWg6Ae4fG3Ijnk9bw=;
        b=j5ktUEHBJESw3YjHB5x3BLocw6tftKpTOuqXLtMSy/4lOJAdlymgKUR9aDjfauwPAXCMDz
        kGIC2XVyDgt6rTD3LtYZZcm5UnpgRmC3qKZE3DGyuNm2mvcSVHSGyErNBYbHI7HPDkUmHm
        h4I5uq2iYWgfndOw6oIInwBaRS5Fbu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625502208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9B+bgNZjQ9mvr7D5XuowXLwKzGqWg6Ae4fG3Ijnk9bw=;
        b=dkem4QSlkxhlOcBwoEoZtDBX73LeVFKgFbZGLeedy6RM3UMatmnCJNksQYYNBZ+G1CT5as
        gPhMErHbLSce1cAw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 97468A3BAB;
        Mon,  5 Jul 2021 16:23:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4E3FA1F2CCA; Mon,  5 Jul 2021 18:23:28 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Michael Stapelberg <stapelberg+linux@google.com>,
        <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/5] writeback: Use READ_ONCE for unlocked reads of writeback stats
Date:   Mon,  5 Jul 2021 18:23:19 +0200
Message-Id: <20210705162328.28366-5-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210705161610.19406-1-jack@suse.cz>
References: <20210705161610.19406-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4091; h=from:subject; bh=Y/DQCwhnMO5kfzvgrvnfAdARRzMVl5z0DoIWDYazekc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg4zH3EMQbDh1mvMvpxuRuIsTSbPfutv/A8hcuf62c DxCBt6eJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOMx9wAKCRCcnaoHP2RA2cTSB/ 4urNVq5zYQxslNsCJ3vf1hIEFCLtpSXihiz2jSSfjVZ22lI0pRJZu3MdYKDKwy9ys0o1to4aS4wQ+U DETSRej5aZQI7wF6RMJUD2pNiSAHQMx2276BS/OsxkB442F7MCV/j+gwvmtAqWRl4Kqn0YvcnQIrgE MzW4HObTGfI3WUE154Qm2UY6wDTSMfq9HsrSB3WUdpA61Hmtfb315VaRtiZWk6cxdBuV0bvuCxRnKA yLxFBVODagpadfdfF5J0ETyFzgsGRMmuFTINkT4IRMjwTYXwqbjuITbPSQcaqMiRA3iGulOpiHAOXU dAVcfl0QhXHvLEjQMXQOqGDpZ5nrCE
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We do some unlocked reads of writeback statistics like
avg_write_bandwidth, dirty_ratelimit, or bw_time_stamp. Generally we are
fine with getting somewhat out-of-date values but actually getting
different values in various parts of the functions because the compiler
decided to reload value from original memory location could confuse
calculations. Use READ_ONCE for these unlocked accesses to be on the
safe side.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/page-writeback.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 95abae9eecaf..736d9e996191 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -189,7 +189,7 @@ static struct fprop_local_percpu *wb_memcg_completions(struct bdi_writeback *wb)
 static void wb_min_max_ratio(struct bdi_writeback *wb,
 			     unsigned long *minp, unsigned long *maxp)
 {
-	unsigned long this_bw = wb->avg_write_bandwidth;
+	unsigned long this_bw = READ_ONCE(wb->avg_write_bandwidth);
 	unsigned long tot_bw = atomic_long_read(&wb->bdi->tot_write_bandwidth);
 	unsigned long long min = wb->bdi->min_ratio;
 	unsigned long long max = wb->bdi->max_ratio;
@@ -898,7 +898,7 @@ static long long pos_ratio_polynom(unsigned long setpoint,
 static void wb_position_ratio(struct dirty_throttle_control *dtc)
 {
 	struct bdi_writeback *wb = dtc->wb;
-	unsigned long write_bw = wb->avg_write_bandwidth;
+	unsigned long write_bw = READ_ONCE(wb->avg_write_bandwidth);
 	unsigned long freerun = dirty_freerun_ceiling(dtc->thresh, dtc->bg_thresh);
 	unsigned long limit = hard_dirty_limit(dtc_dom(dtc), dtc->thresh);
 	unsigned long wb_thresh = dtc->wb_thresh;
@@ -1342,11 +1342,12 @@ static void __wb_update_bandwidth(struct dirty_throttle_control *gdtc,
 {
 	struct bdi_writeback *wb = gdtc->wb;
 	unsigned long now = jiffies;
-	unsigned long elapsed = now - wb->bw_time_stamp;
+	unsigned long elapsed;
 	unsigned long dirtied;
 	unsigned long written;
 
 	spin_lock(&wb->list_lock);
+	elapsed = now - wb->bw_time_stamp;
 	dirtied = percpu_counter_read(&wb->stat[WB_DIRTIED]);
 	written = percpu_counter_read(&wb->stat[WB_WRITTEN]);
 
@@ -1416,7 +1417,7 @@ static unsigned long dirty_poll_interval(unsigned long dirty,
 static unsigned long wb_max_pause(struct bdi_writeback *wb,
 				  unsigned long wb_dirty)
 {
-	unsigned long bw = wb->avg_write_bandwidth;
+	unsigned long bw = READ_ONCE(wb->avg_write_bandwidth);
 	unsigned long t;
 
 	/*
@@ -1438,8 +1439,8 @@ static long wb_min_pause(struct bdi_writeback *wb,
 			 unsigned long dirty_ratelimit,
 			 int *nr_dirtied_pause)
 {
-	long hi = ilog2(wb->avg_write_bandwidth);
-	long lo = ilog2(wb->dirty_ratelimit);
+	long hi = ilog2(READ_ONCE(wb->avg_write_bandwidth));
+	long lo = ilog2(READ_ONCE(wb->dirty_ratelimit));
 	long t;		/* target pause */
 	long pause;	/* estimated next pause */
 	int pages;	/* target nr_dirtied_pause */
@@ -1719,12 +1720,12 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
 		if (dirty_exceeded && !wb->dirty_exceeded)
 			wb->dirty_exceeded = 1;
 
-		if (time_is_before_jiffies(wb->bw_time_stamp +
+		if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
 					   BANDWIDTH_INTERVAL))
 			__wb_update_bandwidth(gdtc, mdtc, true);
 
 		/* throttle according to the chosen dtc */
-		dirty_ratelimit = wb->dirty_ratelimit;
+		dirty_ratelimit = READ_ONCE(wb->dirty_ratelimit);
 		task_ratelimit = ((u64)dirty_ratelimit * sdtc->pos_ratio) >>
 							RATELIMIT_CALC_SHIFT;
 		max_pause = wb_max_pause(wb, sdtc->wb_dirty);
@@ -2365,7 +2366,8 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 	 * but if there's constant writeback being submitted, this makes sure
 	 * writeback bandwidth is updated once in a while.
 	 */
-	if (time_is_before_jiffies(wb->bw_time_stamp + BANDWIDTH_INTERVAL))
+	if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
+				   BANDWIDTH_INTERVAL))
 		wb_update_bandwidth(wb);
 	return ret;
 }
-- 
2.26.2

