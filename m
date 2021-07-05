Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9C03BC196
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 18:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhGEQ0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 12:26:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51690 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhGEQ0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 12:26:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8152022618;
        Mon,  5 Jul 2021 16:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625502208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0OFyCHiVncRr2KeW7uXE977wDdgye+jCGc9PldO8qwQ=;
        b=ft78QLARSsp7Vmy3WCkXXEDpERjxsN8yW5PyXMpLx7+BDuQ2fSNNQVBG4t9RNSHcp9shn0
        N6c2X3vsV2T5BgVodcXuO4Ua/5qKUmM8Dj8OsYMwgebiMQQpEWx/NQlgyKQ+CCWZJVT5Ca
        7dFO1+o/LdmE090/diP/W+e4qgrAVTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625502208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0OFyCHiVncRr2KeW7uXE977wDdgye+jCGc9PldO8qwQ=;
        b=2iUOKLeEB8kRjozv0hedR3Waoyb5TAGl2/zIZi1/nMXM9mkOrUL+29l9klD0ByPFUBYUA9
        W/6vl62jYF0pOBAA==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 6EE76A3BA5;
        Mon,  5 Jul 2021 16:23:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3FB091E053D; Mon,  5 Jul 2021 18:23:28 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Michael Stapelberg <stapelberg+linux@google.com>,
        <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/5] writeback: Track number of inodes under writeback
Date:   Mon,  5 Jul 2021 18:23:15 +0200
Message-Id: <20210705162328.28366-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210705161610.19406-1-jack@suse.cz>
References: <20210705161610.19406-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3595; h=from:subject; bh=k6CGYCogJu3IEkHdSZkpTAfQ0gTbB+GaRTJkEGSCe18=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg4zHzvi2Nt0j8x6Oj7z8i0T3FfqmJBTHlLuvSgFVp H5zPdcuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOMx8wAKCRCcnaoHP2RA2cGQCA CFQMAkHrC6pHpDME2hNtzfbzEklvZFsN0MmKdtsaIEyCccojUNYmjXKLdb+Hc640mU56Uw2AOh48Da yopo1mp8bbdxwl1s2q7ZEtplNZUfhnGrvCAS92Y69JBKhoj8ywvV32CcROUJKJtBKmJTB4HCVz5y8o hZGQ0NmH4Wy0mFma+b1K5uXQLphPdujMBUAsqoYvMS97n+c8ZDA1y5SxrTNPZLDk/lMpW1cBsH+7f6 2EcoL4AONrUpeI4qR0fVIreKmFORB58Tg/MHWQILXZq6GuR65aNE7iLo2IFf2Zlz+t5n5qeDGWHjxM iPodotr/q2LpgMIMepAZZLQ26urJaO
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Track number of inodes under writeback for each bdi_writeback structure.
We will use this to decide whether wb does any IO and so we can estimate
its writeback throughput. In principle we could use number of pages
under writeback (WB_WRITEBACK counter) for this however normal percpu
counter reads are too inaccurate for our purposes and summing the
counter is too expensive.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c                |  5 +++++
 include/linux/backing-dev-defs.h |  1 +
 mm/backing-dev.c                 |  1 +
 mm/page-writeback.c              | 22 ++++++++++++++++++++--
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e91980f49388..475681362b1c 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -416,6 +416,11 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 		inc_wb_stat(new_wb, WB_WRITEBACK);
 	}
 
+	if (mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
+		atomic_dec(&old_wb->writeback_inodes);
+		atomic_inc(&new_wb->writeback_inodes);
+	}
+
 	wb_get(new_wb);
 
 	/*
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index fff9367a6348..148d889f2f7f 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -116,6 +116,7 @@ struct bdi_writeback {
 	struct list_head b_dirty_time;	/* time stamps are dirty */
 	spinlock_t list_lock;		/* protects the b_* lists */
 
+	atomic_t writeback_inodes;	/* number of inodes under writeback */
 	struct percpu_counter stat[NR_WB_STAT_ITEMS];
 
 	unsigned long congested;	/* WB_[a]sync_congested flags */
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 576220acd686..342394ef1e02 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -293,6 +293,7 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	INIT_LIST_HEAD(&wb->b_dirty_time);
 	spin_lock_init(&wb->list_lock);
 
+	atomic_set(&wb->writeback_inodes, 0);
 	wb->bw_time_stamp = jiffies;
 	wb->balanced_dirty_ratelimit = INIT_BW;
 	wb->dirty_ratelimit = INIT_BW;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0062d5c57d41..1560f6626a3b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2719,6 +2719,16 @@ int clear_page_dirty_for_io(struct page *page)
 }
 EXPORT_SYMBOL(clear_page_dirty_for_io);
 
+static void wb_inode_writeback_start(struct bdi_writeback *wb)
+{
+	atomic_inc(&wb->writeback_inodes);
+}
+
+static void wb_inode_writeback_end(struct bdi_writeback *wb)
+{
+	atomic_dec(&wb->writeback_inodes);
+}
+
 int test_clear_page_writeback(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
@@ -2740,6 +2750,9 @@ int test_clear_page_writeback(struct page *page)
 
 				dec_wb_stat(wb, WB_WRITEBACK);
 				__wb_writeout_inc(wb);
+				if (!mapping_tagged(mapping,
+						    PAGECACHE_TAG_WRITEBACK))
+					wb_inode_writeback_end(wb);
 			}
 		}
 
@@ -2782,8 +2795,13 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 						   PAGECACHE_TAG_WRITEBACK);
 
 			xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
-			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT)
-				inc_wb_stat(inode_to_wb(inode), WB_WRITEBACK);
+			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
+				struct bdi_writeback *wb = inode_to_wb(inode);
+
+				inc_wb_stat(wb, WB_WRITEBACK);
+				if (!on_wblist)
+					wb_inode_writeback_start(wb);
+			}
 
 			/*
 			 * We can come through here when swapping anonymous
-- 
2.26.2

