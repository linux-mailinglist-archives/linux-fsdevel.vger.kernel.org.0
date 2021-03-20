Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A56342AF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 06:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhCTFmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 01:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTFlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:41:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3DFC061762;
        Fri, 19 Mar 2021 22:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WY9AwzDXhQrh1wUmtT12pwCP4qw29DMa0P2INwXXaHY=; b=JAmB7/OjetWwRvkK3OAosRstx8
        eRwHmaZM/8w1Z6YbwSWhEOEpnO21Wmg7LRGghn9Cs14zN+15pMnaY3w6tW5SBpeNDVGpe245XjQ9X
        RdzxkyjumSfo6Y/0ojYN6LvDlrhpaOl89O8pXHrFaO9oRC9k1NfE4F8Ie+EWm/Qei3PmBpqMLpIiy
        T4zKEg7DsCpe4qdEwOPwh6lyD95v0l7UbuGj7Xs40WPJX0xWkRDg4kr9FDrGAWVjjo9lddd9hiGkC
        +PK126LjV5DebBj2eswNbhe/XhmKMHaclS7GQC/+RaekJM9sIivvlGLDtH888aOVEFyNRboduTu+n
        p9z4JQug==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNUMX-005SQ8-4X; Sat, 20 Mar 2021 05:41:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v5 02/27] mm/writeback: Add wait_on_page_writeback_killable
Date:   Sat, 20 Mar 2021 05:40:39 +0000
Message-Id: <20210320054104.1300774-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210320054104.1300774-1-willy@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the killable version of wait_on_page_writeback.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  1 +
 mm/page-writeback.c     | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 139678f382ff..8c844ba67785 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -698,6 +698,7 @@ static inline int wait_on_page_locked_killable(struct page *page)
 
 int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
+int wait_on_page_writeback_killable(struct page *page);
 extern void end_page_writeback(struct page *page);
 void wait_for_stable_page(struct page *page);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f6c2c3165d4d..5e761fb62800 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2830,6 +2830,22 @@ void wait_on_page_writeback(struct page *page)
 }
 EXPORT_SYMBOL_GPL(wait_on_page_writeback);
 
+/*
+ * Wait for a page to complete writeback.  Returns -EINTR if we get a
+ * fatal signal while waiting.
+ */
+int wait_on_page_writeback_killable(struct page *page)
+{
+	while (PageWriteback(page)) {
+		trace_wait_on_page_writeback(page, page_mapping(page));
+		if (wait_on_page_bit_killable(page, PG_writeback))
+			return -EINTR;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wait_on_page_writeback_killable);
+
 /**
  * wait_for_stable_page() - wait for writeback to finish, if necessary.
  * @page:	The page to wait on.
-- 
2.30.2

