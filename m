Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7752A82D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 16:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbgKEP6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 10:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgKEP6m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:58:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE093C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2020 07:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QROCfc/ys3ET3qemY2lfIAH57zhFKqiC0ZvHrXyWolY=; b=CXuWXviW3qo57OZ/wsnxNApAnb
        MoaMGK4pYNcqjpVyvhXkwilhBOUmXhNq+7EXkDOQmnmyYAyVvNGp9WPpeAUlL95HsZz9kFExyOqiK
        JQde4vTTQ86BfACBDEV4Yg8GuMaRbUQHdf7E3DWBrUTJqn+qKE8PYMGJ6wjGvUSe1kdsmnJLS9ojX
        dPeuitK5muTmu599Qli+5nQtKSECI8XRDEANaYNXr7bzfyhNZNoHFtSwL7nUFen6wbvPR9N4qjlar
        TPUluXgyhkcC/iOohtXBqnbQeLEiFD+PdAgEiVMUwaRcjcSuOFMj2LkZXZrVP+ee4L2YlNtWNtd3N
        WXuLfH9g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaheq-0002iz-KL; Thu, 05 Nov 2020 15:58:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 3/3] bcachefs: Use attach_page_private and detach_page_private
Date:   Thu,  5 Nov 2020 15:58:38 +0000
Message-Id: <20201105155838.10329-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201105155838.10329-1-willy@infradead.org>
References: <20201105155838.10329-1-willy@infradead.org>
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
index 98d61d5bc84b..43cc49986c26 100644
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

