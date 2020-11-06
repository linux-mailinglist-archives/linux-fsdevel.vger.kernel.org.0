Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFB12A9632
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 13:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgKFMar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 07:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgKFMar (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:30:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C77C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2020 04:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gsFgv0Jl3de0Za5CmEKC4EBbImhC0dOH10o2Itd6Aww=; b=HxehHPhHIHgDisPrPQVHGR9MDh
        QfBCP5dd9cFAPqMH7DW0DISdB1wbDhIPt9vKrjfM0Y2ncdPxkMNEIR95+DVEz1eXMrUdBkojrvqK6
        nL5JIGu4OJDQQ7gV5fBbK2kOLZZu3DmuFhyT6TvvCQ/3a7pA700k11XLFVPnIteswTXpfQBaPZl35
        vCyxa4JjrD/MLlENUCe0XTrL5e8sq+klrZsC7KsXrAZJRANhexckf/RnxioTr+uXIRaob6UOUuZMU
        nnfGIIFXuUq910SEcQlyyxmjl+xf4TiDTkSpnwazY4Pur67y/86cvo1DdnEYhTUHcmR4mTeStbQbS
        7yzwOcew==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb0t8-0007Qe-0t; Fri, 06 Nov 2020 12:30:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/4] pagevec: Allow pagevecs to be different sizes
Date:   Fri,  6 Nov 2020 12:30:37 +0000
Message-Id: <20201106123040.28451-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201106080815.GC31585@lst.de>
References: <20201106080815.GC31585@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Declaring a pagevec continues to create a pagevec which is the same size,
but functions which manipulate pagevecs no longer rely on this.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagevec.h | 20 ++++++++++++++++----
 mm/swap.c               |  8 ++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 875a3f0d9dd2..ee5d3c4da8da 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -18,9 +18,15 @@ struct page;
 struct address_space;
 
 struct pagevec {
-	unsigned char nr;
-	bool percpu_pvec_drained;
-	struct page *pages[PAGEVEC_SIZE];
+	union {
+		struct {
+			unsigned char sz;
+			unsigned char nr;
+			bool percpu_pvec_drained;
+			struct page *pages[PAGEVEC_SIZE];
+		};
+		void *__p[PAGEVEC_SIZE + 1];
+	};
 };
 
 void __pagevec_release(struct pagevec *pvec);
@@ -41,6 +47,7 @@ static inline unsigned pagevec_lookup_tag(struct pagevec *pvec,
 
 static inline void pagevec_init(struct pagevec *pvec)
 {
+	pvec->sz = PAGEVEC_SIZE;
 	pvec->nr = 0;
 	pvec->percpu_pvec_drained = false;
 }
@@ -50,6 +57,11 @@ static inline void pagevec_reinit(struct pagevec *pvec)
 	pvec->nr = 0;
 }
 
+static inline unsigned pagevec_size(struct pagevec *pvec)
+{
+	return pvec->sz;
+}
+
 static inline unsigned pagevec_count(struct pagevec *pvec)
 {
 	return pvec->nr;
@@ -57,7 +69,7 @@ static inline unsigned pagevec_count(struct pagevec *pvec)
 
 static inline unsigned pagevec_space(struct pagevec *pvec)
 {
-	return PAGEVEC_SIZE - pvec->nr;
+	return pvec->sz - pvec->nr;
 }
 
 /*
diff --git a/mm/swap.c b/mm/swap.c
index 2ee3522a7170..d093fb30f038 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -52,6 +52,7 @@ struct lru_rotate {
 };
 static DEFINE_PER_CPU(struct lru_rotate, lru_rotate) = {
 	.lock = INIT_LOCAL_LOCK(lock),
+	.pvec.sz = PAGEVEC_SIZE,
 };
 
 /*
@@ -70,6 +71,13 @@ struct lru_pvecs {
 };
 static DEFINE_PER_CPU(struct lru_pvecs, lru_pvecs) = {
 	.lock = INIT_LOCAL_LOCK(lock),
+	.lru_add.sz = PAGEVEC_SIZE,
+	.lru_deactivate_file.sz = PAGEVEC_SIZE,
+	.lru_deactivate.sz = PAGEVEC_SIZE,
+	.lru_lazyfree.sz = PAGEVEC_SIZE,
+#ifdef CONFIG_SMP
+	.activate_page.sz = PAGEVEC_SIZE,
+#endif
 };
 
 /*
-- 
2.28.0

