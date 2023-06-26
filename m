Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AFB73E69A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjFZRgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjFZRgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:36:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E542955;
        Mon, 26 Jun 2023 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DbRDOwy4aGYzGm5HeqIsIhOnoGhV3uqwtbzHnV71lmw=; b=W1PA+/Bi8v1fqLdsB7yl772V0f
        RgwlNsF3bvGRmX6GeWkooNi1wYpT1f3iUIzX4l7MUM38mQ9Zw5s7SQOuMEMB53KdS5tSL+OHJSisS
        K87JMB2fNoyImDp7TG+shhEPLoq4/BISTARhOn43kcMebEMFO3G44dQ5TWC3FZLmULKJjwLPoTUNq
        WUIpgwde5+sWTO8N2dyN3HIV4wxNNuQ+5Pvpm5cCn3mV9Sxw1bvQhXNl0ETOjQa+6UJarTN7j2N2A
        ahz+Xz2UCRm0wunSNn5GNma/A151vXBBaymuvJ4fLZ0+HcnPGNDiVY6mFsk/ZzC0yxz2xPztK9RUp
        bM2BXbXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDq7Y-001vVI-28; Mon, 26 Jun 2023 17:35:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: [PATCH 10/12] writeback: Add for_each_writeback_folio()
Date:   Mon, 26 Jun 2023 18:35:19 +0100
Message-Id: <20230626173521.459345-11-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230626173521.459345-1-willy@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wrap up the iterator with a nice bit of syntactic sugar.  Now the
caller doesn't need to know about wbc->err and can just return error,
not knowing that the iterator took care of storing errors correctly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/writeback.h | 14 +++++++++++---
 mm/page-writeback.c       | 11 ++++-------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 7dd050b40e4b..84d5306ef045 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -369,14 +369,22 @@ int balance_dirty_pages_ratelimited_flags(struct address_space *mapping,
 
 bool wb_over_bg_thresh(struct bdi_writeback *wb);
 
+struct folio *writeback_iter_init(struct address_space *mapping,
+		struct writeback_control *wbc);
+struct folio *writeback_iter_next(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio, int error);
+
+#define for_each_writeback_folio(mapping, wbc, folio, error)		\
+	for (folio = writeback_iter_init(mapping, wbc);			\
+	     folio || ((error = wbc->err), false);			\
+	     folio = writeback_iter_next(mapping, wbc, folio, error))
+
 typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
 				void *data);
-
-void tag_pages_for_writeback(struct address_space *mapping,
-			     pgoff_t start, pgoff_t end);
 int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data);
+
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 void writeback_set_ratelimit(void);
 void tag_pages_for_writeback(struct address_space *mapping,
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ef61d7006c5e..245d6318dfb2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2451,7 +2451,7 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 	return folio;
 }
 
-static struct folio *writeback_iter_init(struct address_space *mapping,
+struct folio *writeback_iter_init(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
 	if (wbc->range_cyclic) {
@@ -2473,7 +2473,7 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
 	return writeback_get_folio(mapping, wbc);
 }
 
-static struct folio *writeback_iter_next(struct address_space *mapping,
+struct folio *writeback_iter_next(struct address_space *mapping,
 		struct writeback_control *wbc, struct folio *folio, int error)
 {
 	if (unlikely(error)) {
@@ -2550,13 +2550,10 @@ int write_cache_pages(struct address_space *mapping,
 	struct folio *folio;
 	int error;
 
-	for (folio = writeback_iter_init(mapping, wbc);
-	     folio;
-	     folio = writeback_iter_next(mapping, wbc, folio, error)) {
+	for_each_writeback_folio(mapping, wbc, folio, error)
 		error = writepage(folio, wbc, data);
-	}
 
-	return wbc->err;
+	return error;
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-- 
2.39.2

