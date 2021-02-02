Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B819730B82C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 08:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhBBG5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 01:57:54 -0500
Received: from so15.mailgun.net ([198.61.254.15]:45442 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232234AbhBBG4w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 01:56:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612248987; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=0GJGgAjAx2/rdTTd5QE4pvrmTTzFGOM9WmXIW06Tfs4=; b=ceCCugG9+tKCo2/OYajxfYO5e8DZ/wbetRdTvT/BVhUmWg1TARogmkEB6a3+JW+eLikg4Qpc
 kShvgPCsCCjglE5QZQ2H0cH9z6ui7v3OqaDEGEpJmsiYtS8Waa7oAWWxzX0cdgzhFKYNuafj
 3vDLynnMs+oZ9YwYU171c8eOX5E=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6018f77e6776573488581598 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Feb 2021 06:55:58
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D1A24C43465; Tue,  2 Feb 2021 06:55:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 00D56C433C6;
        Tue,  2 Feb 2021 06:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00D56C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH] [RFC] mm: fs: Invalidate BH LRU during page migration
Date:   Mon,  1 Feb 2021 22:55:47 -0800
Message-Id: <695193a165bf538f35de84334b4da2cc3544abe0.1612248395.git.cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612248395.git.cgoldswo@codeaurora.org>
References: <cover.1612248395.git.cgoldswo@codeaurora.org>
In-Reply-To: <cover.1612248395.git.cgoldswo@codeaurora.org>
References: <cover.1612248395.git.cgoldswo@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pages containing buffer_heads that are in the buffer_head LRU cache
will be pinned and thus cannot be migrated.  Correspondingly,
invalidate the BH LRU before a migration starts and stop any
buffer_head from being cached in the LRU, until migration has
finished.

Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
---
 fs/buffer.c                 |  6 ++++++
 include/linux/buffer_head.h |  3 +++
 include/linux/migrate.h     |  2 ++
 mm/migrate.c                | 18 ++++++++++++++++++
 mm/page_alloc.c             |  3 +++
 mm/swap.c                   |  3 +++
 6 files changed, 35 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 96c7604..39ec4ec 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1289,6 +1289,8 @@ static inline void check_irqs_on(void)
 #endif
 }
 
+bool bh_migration_done = true;
+
 /*
  * Install a buffer_head into this cpu's LRU.  If not already in the LRU, it is
  * inserted at the front, and the buffer_head at the back if any is evicted.
@@ -1303,6 +1305,9 @@ static void bh_lru_install(struct buffer_head *bh)
 	check_irqs_on();
 	bh_lru_lock();
 
+	if (!bh_migration_done)
+		goto out;
+
 	b = this_cpu_ptr(&bh_lrus);
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		swap(evictee, b->bhs[i]);
@@ -1313,6 +1318,7 @@ static void bh_lru_install(struct buffer_head *bh)
 	}
 
 	get_bh(bh);
+out:
 	bh_lru_unlock();
 	brelse(evictee);
 }
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6b47f94..ae4eb6d 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -193,6 +193,9 @@ void __breadahead_gfp(struct block_device *, sector_t block, unsigned int size,
 		  gfp_t gfp);
 struct buffer_head *__bread_gfp(struct block_device *,
 				sector_t block, unsigned size, gfp_t gfp);
+
+extern bool bh_migration_done;
+
 void invalidate_bh_lrus(void);
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3a38963..9e4a2dc 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -46,6 +46,7 @@ extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
 extern void migrate_prep(void);
+extern void migrate_finish(void);
 extern void migrate_prep_local(void);
 extern void migrate_page_states(struct page *newpage, struct page *page);
 extern void migrate_page_copy(struct page *newpage, struct page *page);
@@ -67,6 +68,7 @@ static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
 
 static inline int migrate_prep(void) { return -ENOSYS; }
+static inline int migrate_finish(void) { return -ENOSYS; }
 static inline int migrate_prep_local(void) { return -ENOSYS; }
 
 static inline void migrate_page_states(struct page *newpage, struct page *page)
diff --git a/mm/migrate.c b/mm/migrate.c
index a69da8a..08c981d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -64,6 +64,19 @@
  */
 void migrate_prep(void)
 {
+	bh_migration_done = false;
+
+	/*
+	 * This barrier ensures that callers of bh_lru_install() between
+	 * the barrier and the call to invalidate_bh_lrus() read
+	 *  bh_migration_done() as false.
+	 */
+	/*
+	 * TODO: Remove me? lru_add_drain_all() already has an smp_mb(),
+	 * but it would be good to ensure that the barrier isn't forgotten.
+	 */
+	smp_mb();
+
 	/*
 	 * Clear the LRU lists so pages can be isolated.
 	 * Note that pages may be moved off the LRU after we have
@@ -73,6 +86,11 @@ void migrate_prep(void)
 	lru_add_drain_all();
 }
 
+void migrate_finish(void)
+{
+	bh_migration_done = true;
+}
+
 /* Do the necessary work of migrate_prep but not if it involves other CPUs */
 void migrate_prep_local(void)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6446778..e4cb959 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8493,6 +8493,9 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
 	}
+
+	migrate_finish();
+
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
 		return ret;
diff --git a/mm/swap.c b/mm/swap.c
index 31b844d..97efc49 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -36,6 +36,7 @@
 #include <linux/hugetlb.h>
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
+#include <linux/buffer_head.h>
 
 #include "internal.h"
 
@@ -759,6 +760,8 @@ void lru_add_drain_all(void)
 	if (WARN_ON(!mm_percpu_wq))
 		return;
 
+	invalidate_bh_lrus();
+
 	/*
 	 * Guarantee pagevec counter stores visible by this CPU are visible to
 	 * other CPUs before loading the current drain generation.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

