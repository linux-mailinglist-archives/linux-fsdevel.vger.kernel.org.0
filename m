Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612612A8ABE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 00:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbgKEX2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 18:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732577AbgKEX2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:28:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8994C0613D3
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2020 15:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pFL+M6HtjcUDtRHTDpu2lDM6F4WkBnUB2GcZyuAE2/4=; b=EB5x//Loba6VdnTbxMax6ALOg6
        pu0ApAc+x8IDCQkk9qsik1pglSsE0UiIfXzfvO3ZaQaK7Defa5N/ddWMBLTZZ5Wh5/MzKLZH33z0e
        2Ksexz2U0jEE3Zhmj7eSi0ZNCD42dlTO2tjsKd1xh9iQPuI+41xwBxFQY1fMTNe+d+t/vVIhGUDzZ
        aHG8fsif6Abt3G17YBXZ1X10ODRuN/aITOBsUWubJzptEQjdsDEUEcev2e054fJtvbPM72WHyb/lr
        s7YY4HrcqQfZfX/TEgr2nfirTZfJMyADo1TqxILr4hSzmAZd3bItPMfUkqmSWO7tBkHNxRneIbV+q
        OIuVRMNg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaogN-00062i-Do; Thu, 05 Nov 2020 23:28:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 3/3] bcachefs: Use attach_page_private and detach_page_private
Date:   Thu,  5 Nov 2020 23:28:39 +0000
Message-Id: <20201105232839.23100-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201105232839.23100-1-willy@infradead.org>
References: <20201105232839.23100-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These recently added helpers simplify the code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/bcachefs/fs-io.c | 39 ++++++---------------------------------
 1 file changed, 6 insertions(+), 33 deletions(-)

diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index 46abf3bdf489..1eb69ed38b10 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -265,28 +265,13 @@ static inline struct bch_page_state *bch2_page_state(struct page *page)
 /* for newly allocated pages: */
 static void __bch2_page_state_release(struct page *page)
 {
-	struct bch_page_state *s = __bch2_page_state(page);
-
-	if (!s)
-		return;
-
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
-	kfree(s);
+	kfree(detach_page_private(page));
 }
 
 static void bch2_page_state_release(struct page *page)
 {
-	struct bch_page_state *s = bch2_page_state(page);
-
-	if (!s)
-		return;
-
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
-	kfree(s);
+	EBUG_ON(!PageLocked(page));
+	__bch2_page_state_release(page);
 }
 
 /* for newly allocated pages: */
@@ -300,13 +285,7 @@ static struct bch_page_state *__bch2_page_state_create(struct page *page,
 		return NULL;
 
 	spin_lock_init(&s->lock);
-	/*
-	 * migrate_page_move_mapping() assumes that pages with private data
-	 * have their count elevated by 1.
-	 */
-	get_page(page);
-	set_page_private(page, (unsigned long) s);
-	SetPagePrivate(page);
+	attach_page_private(page, s);
 	return s;
 }
 
@@ -608,14 +587,8 @@ int bch2_migrate_page(struct address_space *mapping, struct page *newpage,
 	if (ret != MIGRATEPAGE_SUCCESS)
 		return ret;
 
-	if (PagePrivate(page)) {
-		ClearPagePrivate(page);
-		get_page(newpage);
-		set_page_private(newpage, page_private(page));
-		set_page_private(page, 0);
-		put_page(page);
-		SetPagePrivate(newpage);
-	}
+	if (PagePrivate(page))
+		attach_page_private(newpage, detach_page_private(page));
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
 		migrate_page_copy(newpage, page);
-- 
2.28.0

