Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA277A25ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjIOSht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbjIOShc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:37:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD55115;
        Fri, 15 Sep 2023 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sq3juwAyx/kGuC+9AEnQhgmCbLKhgaGhWILandlCIyQ=; b=lvm+93Zyyorgp8mPn2eE91Y0ck
        yXGQm7QiGVOUuyMWNgjTS4pNocHj7b8QyPTXC+m+yEougBY7HK7uxFHF4R9PMWFw5lNWvO5FMUXSH
        KIzHlaINvKtugaNxW5bmu6PFryvnw6AuavKx7Gy7vVWCxhZcRsnwoACLM/O8Wb9L980gJmemiBQa2
        RYXD+V0C8B8y522E/iE9I3d+7qlSebZrsVo6lAVMgf7AHAKWHH9+etiPvc2BBDqeSvQw6x3P1E2Cn
        FxdZGaWZEZikCcoccFyIlsW8Hn04rypDvS97Z3PmKp904uOpHsAYHM9FqZxLoe6HM0XVRthvC8PXs
        PLyYU16Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDgj-00BMIW-8u; Fri, 15 Sep 2023 18:37:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 03/17] mm: Add folio_end_read()
Date:   Fri, 15 Sep 2023 19:36:53 +0100
Message-Id: <20230915183707.2707298-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230915183707.2707298-1-willy@infradead.org>
References: <20230915183707.2707298-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a function for filesystems to call when they have finished
reading an entire folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 351c3b7f93a1..5bb2f5f802bc 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1129,6 +1129,7 @@ static inline void wait_on_page_locked(struct page *page)
 	folio_wait_locked(page_folio(page));
 }
 
+void folio_end_read(struct folio *folio, bool success);
 void wait_on_page_writeback(struct page *page);
 void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
diff --git a/mm/filemap.c b/mm/filemap.c
index 582f5317ff71..e3843cf1d8e1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1527,6 +1527,28 @@ void folio_unlock(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_unlock);
 
+/**
+ * folio_end_read - End read on a folio.
+ * @folio: The folio.
+ * @success: True if all reads completed successfully.
+ *
+ * When all reads against a folio have completed, filesystems should
+ * call this function to let the pagecache know that no more reads
+ * are outstanding.  This will unlock the folio and wake up any thread
+ * sleeping on the lock.  The folio will also be marked uptodate if all
+ * reads succeeded.
+ *
+ * Context: May be called from interrupt or process context.  May not be
+ * called from NMI context.
+ */
+void folio_end_read(struct folio *folio, bool success)
+{
+	if (success)
+		folio_mark_uptodate(folio);
+	folio_unlock(folio);
+}
+EXPORT_SYMBOL(folio_end_read);
+
 /**
  * folio_end_private_2 - Clear PG_private_2 and wake any waiters.
  * @folio: The folio.
-- 
2.40.1

