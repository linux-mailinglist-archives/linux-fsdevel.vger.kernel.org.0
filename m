Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1956453F093
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 22:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiFFUrY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 16:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiFFUqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:46:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CD513B8F2;
        Mon,  6 Jun 2022 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dRkMHaR981UE2djNCVPW4MUdY2rPYJAa6UnQ1arpxn4=; b=VhRq5mA6U/Le0FhZhCp9BX9vX0
        eEJWByASrVCSrm9WetxXqV0UXZBjF0SuYe4mFnGXMFsUgOilHz8p+squ/1rM4gM36CwhSe5BBEQp6
        i1dQyrlxzSUP+hK9Ax4brjnRi7zxuvpEv+ymkWeCRkQK8HkgmO0y7Vc+lYVUA7Hlj90Pkf8iPWxqv
        CYXqz3bl8ul96I36GIcF4ldupbg1VWOjM55w+RuDYjPUC/TOKQiKqMH+XKBjwoHp0p03NK+LpBfPw
        iNV++FmUm87jwl9SX46KBPV+Ri5X6qeVBMjICnW8mirhgRNBkbRKdvNkLwdTh42fXKSQ5I7volu41
        cllWb9Yg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyJWw-00B19O-PM; Mon, 06 Jun 2022 20:40:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 03/20] mm/migrate: Convert writeout() to take a folio
Date:   Mon,  6 Jun 2022 21:40:33 +0100
Message-Id: <20220606204050.2625949-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606204050.2625949-1-willy@infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
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

Use a folio throughout this function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/migrate.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d772ce63d7e2..f19246c12fe9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -762,11 +762,10 @@ int buffer_migrate_page_norefs(struct address_space *mapping,
 #endif
 
 /*
- * Writeback a page to clean the dirty state
+ * Writeback a folio to clean the dirty state
  */
-static int writeout(struct address_space *mapping, struct page *page)
+static int writeout(struct address_space *mapping, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
 		.nr_to_write = 1,
@@ -780,25 +779,25 @@ static int writeout(struct address_space *mapping, struct page *page)
 		/* No write method for the address space */
 		return -EINVAL;
 
-	if (!clear_page_dirty_for_io(page))
+	if (!folio_clear_dirty_for_io(folio))
 		/* Someone else already triggered a write */
 		return -EAGAIN;
 
 	/*
-	 * A dirty page may imply that the underlying filesystem has
-	 * the page on some queue. So the page must be clean for
-	 * migration. Writeout may mean we loose the lock and the
-	 * page state is no longer what we checked for earlier.
+	 * A dirty folio may imply that the underlying filesystem has
+	 * the folio on some queue. So the folio must be clean for
+	 * migration. Writeout may mean we lose the lock and the
+	 * folio state is no longer what we checked for earlier.
 	 * At this point we know that the migration attempt cannot
 	 * be successful.
 	 */
 	remove_migration_ptes(folio, folio, false);
 
-	rc = mapping->a_ops->writepage(page, &wbc);
+	rc = mapping->a_ops->writepage(&folio->page, &wbc);
 
 	if (rc != AOP_WRITEPAGE_ACTIVATE)
 		/* unlocked. Relock */
-		lock_page(page);
+		folio_lock(folio);
 
 	return (rc < 0) ? -EIO : -EAGAIN;
 }
@@ -818,7 +817,7 @@ static int fallback_migrate_folio(struct address_space *mapping,
 		default:
 			return -EBUSY;
 		}
-		return writeout(mapping, &src->page);
+		return writeout(mapping, src);
 	}
 
 	/*
-- 
2.35.1

