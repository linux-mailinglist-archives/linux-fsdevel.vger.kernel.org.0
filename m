Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B07C4AFE4F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiBIUXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D74FE040CBE
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wnSFsM6jEKXUTZCjqZ7h+5gdV8z+9GybpOw6JV2wacs=; b=q1sL077Z4S2SPuDUwYS1fnRtNn
        FXkM+/DDG2MqK+1HF6ziTuWIntIWaXU9ykMj4mm8bd8S2HRlyIHU6jdei5shrWwPpaSEZMcth3N4u
        nCVlZQpUP2y+JKO4cpeHT3pqjTa/d2ONeo/ldksVryV8lxRrlWWJrp3K7IQ371FjF3+xieyloKRVA
        V4zFA8A42u9kSInwS1OE4jUzwmqEM8kDz66YomNmWqz5EOttL79qf8tk+OB/He9EYgMTpQXWWXljn
        qr/MMgP/mKpg2FI85fqu2gmY3ld0HN2vUggGI9dzsbCw+XTB79bekzkDfHaxBZ4Zg4Y2yB7kR8zTn
        6SowtL+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTu-008crl-OL; Wed, 09 Feb 2022 20:22:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 33/56] fs: Add aops->launder_folio
Date:   Wed,  9 Feb 2022 20:21:52 +0000
Message-Id: <20220209202215.2055748-34-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

Since the only difference between ->launder_page and ->launder_folio
is the type of the pointer, these can safely use a union without
affecting bisectability.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst | 10 +++++-----
 Documentation/filesystems/vfs.rst     |  8 ++++----
 include/linux/fs.h                    |  5 ++++-
 mm/truncate.c                         |  8 ++++----
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 8e9cbc0fb70f..dee512efb458 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -257,7 +257,7 @@ prototypes::
 	bool (*isolate_page) (struct page *, isolate_mode_t);
 	int (*migratepage)(struct address_space *, struct page *, struct page *);
 	void (*putback_page) (struct page *);
-	int (*launder_page)(struct page *);
+	int (*launder_folio)(struct folio *);
 	bool (*is_partially_uptodate)(struct folio *, size_t from, size_t count);
 	int (*error_remove_page)(struct address_space *, struct page *);
 	int (*swap_activate)(struct file *);
@@ -285,7 +285,7 @@ direct_IO:
 isolate_page:		yes
 migratepage:		yes (both)
 putback_page:		yes
-launder_page:		yes
+launder_folio:		yes
 is_partially_uptodate:	yes
 error_remove_page:	yes
 swap_activate:		no
@@ -385,9 +385,9 @@ the kernel assumes that the fs has no private interest in the buffers.
 ->freepage() is called when the kernel is done dropping the page
 from the page cache.
 
-->launder_page() may be called prior to releasing a page if
-it is still found to be dirty. It returns zero if the page was successfully
-cleaned, or an error value if not. Note that in order to prevent the page
+->launder_folio() may be called prior to releasing a folio if
+it is still found to be dirty. It returns zero if the folio was successfully
+cleaned, or an error value if not. Note that in order to prevent the folio
 getting mapped back in and redirtied, it needs to be kept locked
 across the entire operation.
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 28704831652c..c54ca4d88ed6 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -745,7 +745,7 @@ cache in your filesystem.  The following members are defined:
 		int (*migratepage) (struct page *, struct page *);
 		/* put migration-failed page back to right list */
 		void (*putback_page) (struct page *);
-		int (*launder_page) (struct page *);
+		int (*launder_folio) (struct folio *);
 
 		bool (*is_partially_uptodate) (struct folio *, size_t from,
 					       size_t count);
@@ -930,9 +930,9 @@ cache in your filesystem.  The following members are defined:
 ``putback_page``
 	Called by the VM when isolated page's migration fails.
 
-``launder_page``
-	Called before freeing a page - it writes back the dirty page.
-	To prevent redirtying the page, it is kept locked during the
+``launder_folio``
+	Called before freeing a folio - it writes back the dirty folio.
+	To prevent redirtying the folio, it is kept locked during the
 	whole operation.
 
 ``is_partially_uptodate``
diff --git a/include/linux/fs.h b/include/linux/fs.h
index af9ae091bd82..0af3075cdff2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -399,7 +399,10 @@ struct address_space_operations {
 			struct page *, struct page *, enum migrate_mode);
 	bool (*isolate_page)(struct page *, isolate_mode_t);
 	void (*putback_page)(struct page *);
-	int (*launder_page) (struct page *);
+	union {
+		int (*launder_page) (struct page *);
+		int (*launder_folio) (struct folio *);
+	};
 	bool (*is_partially_uptodate) (struct folio *, size_t from,
 			size_t count);
 	void (*is_dirty_writeback) (struct page *, bool *, bool *);
diff --git a/mm/truncate.c b/mm/truncate.c
index 8010461a59bd..6ad44b546dff 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -614,13 +614,13 @@ static int invalidate_complete_folio2(struct address_space *mapping,
 	return 0;
 }
 
-static int do_launder_folio(struct address_space *mapping, struct folio *folio)
+static int folio_launder(struct address_space *mapping, struct folio *folio)
 {
 	if (!folio_test_dirty(folio))
 		return 0;
-	if (folio->mapping != mapping || mapping->a_ops->launder_page == NULL)
+	if (folio->mapping != mapping || mapping->a_ops->launder_folio == NULL)
 		return 0;
-	return mapping->a_ops->launder_page(&folio->page);
+	return mapping->a_ops->launder_folio(folio);
 }
 
 /**
@@ -686,7 +686,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				unmap_mapping_folio(folio);
 			BUG_ON(folio_mapped(folio));
 
-			ret2 = do_launder_folio(mapping, folio);
+			ret2 = folio_launder(mapping, folio);
 			if (ret2 == 0) {
 				if (!invalidate_complete_folio2(mapping, folio))
 					ret2 = -EBUSY;
-- 
2.34.1

