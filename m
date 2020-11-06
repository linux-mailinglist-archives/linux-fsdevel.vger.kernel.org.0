Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999262A962F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 13:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgKFMao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 07:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFMao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:30:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E8FC0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2020 04:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6tUINAMJjUdq6LPonn3cLBWKxJPktFDlylPf+keuUGY=; b=Rd5xXhJrZyFlBMKU+t+tU6YQBt
        DpB39P7+K4us9Xtob24m4tOMLG61acjJu8Hv08zmzE+LK1nRqxQ6q4HkjiPMg/SkNfhsWUQfAClH1
        /aueSdDKNGP2/6iTeZ9VWx+0NzonkHyVeHbejiDmj1StBj1PjMCFqqhvlvwPwt8SWK7Fvt/ywbNV8
        DVB9AQQ+rJepsrXGjz8SWa+PX9SfvZyEjqMDxsNAC2GijrUORkbDYCQ7iWaQvEGa3jkUICESEcVcI
        s8n/ojnT9sxCZX3clNWHCFZTjMakXfJvZ3jmVxiOi/AKhDSSWYfEc27s9JKAgu1kbMdMST5gqGk4M
        rM5DoKuA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb0t8-0007Qh-8Q; Fri, 06 Nov 2020 12:30:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/4] pagevec: Increase the size of LRU pagevecs
Date:   Fri,  6 Nov 2020 12:30:38 +0000
Message-Id: <20201106123040.28451-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201106123040.28451-1-willy@infradead.org>
References: <20201106080815.GC31585@lst.de>
 <20201106123040.28451-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tim Chen reports that increasing the size of LRU pagevecs is advantageous
with a workload he has:
https://lore.kernel.org/linux-mm/d1cc9f12a8ad6c2a52cb600d93b06b064f2bbc57.1593205965.git.tim.c.chen@linux.intel.com/

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagevec.h |  5 +++++
 mm/swap.c               | 27 +++++++++++++++------------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index ee5d3c4da8da..4dc45392d776 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -29,6 +29,11 @@ struct pagevec {
 	};
 };
 
+#define declare_pagevec(name, size) union {				\
+	struct pagevec name;						\
+	void *__p ##name [size + 1];					\
+}
+
 void __pagevec_release(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
 void pagevec_remove_exceptionals(struct pagevec *pvec);
diff --git a/mm/swap.c b/mm/swap.c
index d093fb30f038..1e6f50b312ea 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -45,14 +45,17 @@
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
 
+#define LRU_PAGEVEC_SIZE 63
+#define lru_pagevec(name)	declare_pagevec(name, LRU_PAGEVEC_SIZE)
+
 /* Protecting only lru_rotate.pvec which requires disabling interrupts */
 struct lru_rotate {
 	local_lock_t lock;
-	struct pagevec pvec;
+	lru_pagevec(pvec);
 };
 static DEFINE_PER_CPU(struct lru_rotate, lru_rotate) = {
 	.lock = INIT_LOCAL_LOCK(lock),
-	.pvec.sz = PAGEVEC_SIZE,
+	.pvec.sz = LRU_PAGEVEC_SIZE,
 };
 
 /*
@@ -61,22 +64,22 @@ static DEFINE_PER_CPU(struct lru_rotate, lru_rotate) = {
  */
 struct lru_pvecs {
 	local_lock_t lock;
-	struct pagevec lru_add;
-	struct pagevec lru_deactivate_file;
-	struct pagevec lru_deactivate;
-	struct pagevec lru_lazyfree;
+	lru_pagevec(lru_add);
+	lru_pagevec(lru_deactivate_file);
+	lru_pagevec(lru_deactivate);
+	lru_pagevec(lru_lazyfree);
 #ifdef CONFIG_SMP
-	struct pagevec activate_page;
+	lru_pagevec(activate_page);
 #endif
 };
 static DEFINE_PER_CPU(struct lru_pvecs, lru_pvecs) = {
 	.lock = INIT_LOCAL_LOCK(lock),
-	.lru_add.sz = PAGEVEC_SIZE,
-	.lru_deactivate_file.sz = PAGEVEC_SIZE,
-	.lru_deactivate.sz = PAGEVEC_SIZE,
-	.lru_lazyfree.sz = PAGEVEC_SIZE,
+	.lru_add.sz = LRU_PAGEVEC_SIZE,
+	.lru_deactivate_file.sz = LRU_PAGEVEC_SIZE,
+	.lru_deactivate.sz = LRU_PAGEVEC_SIZE,
+	.lru_lazyfree.sz = LRU_PAGEVEC_SIZE,
 #ifdef CONFIG_SMP
-	.activate_page.sz = PAGEVEC_SIZE,
+	.activate_page.sz = LRU_PAGEVEC_SIZE,
 #endif
 };
 
-- 
2.28.0

