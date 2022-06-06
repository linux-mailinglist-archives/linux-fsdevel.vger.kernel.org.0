Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CAE53F0D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 22:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiFFUr3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 16:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbiFFUrQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:47:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC7AAFB3B;
        Mon,  6 Jun 2022 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jShwzeL+5O6p6+KB8AXJd8QTjTM3rLlLO0YNnyhkzoU=; b=j8WB6rbesWftHu8QIJhuNjLLRv
        8UGF1DKSTdZLPDZ0Kov24duPgp8KMpi6m8VEsqm5e1sZdIO0hAb54JNjAbS00XQgXdsCx8+PvicwO
        rYdGhK7Gy6I6AX03/exLoIxL+gMZQDduaqInpnkGl13x/6LHcmOMXo+u8SO/crNY4L5fIgFOEe3TY
        clMZRMy11m0K44+Yi9a6EjLXZgw7NLEoTTdV/oEJbaeKVMorPM13Ba1mk7M/T/X6/bkJL+qWpRRnS
        1wANzqWwYhqp/CK739JNy4OmGeFkTAhy3sEt9IXLj+oIA+NjHnNm9hNBqc/doCVMUizMtdR2GOaOc
        gaaqEAJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyJWy-00B19u-3f; Mon, 06 Jun 2022 20:40:56 +0000
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
Subject: [PATCH 19/20] fs: Remove aops->migratepage()
Date:   Mon,  6 Jun 2022 21:40:49 +0100
Message-Id: <20220606204050.2625949-20-willy@infradead.org>
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

With all users converted to migrate_folio(), remove this operation.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h |  2 --
 mm/compaction.c    |  5 ++---
 mm/migrate.c       | 10 +---------
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5737c92ed286..95347cc035ae 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -367,8 +367,6 @@ struct address_space_operations {
 	 */
 	int (*migrate_folio)(struct address_space *, struct folio *dst,
 			struct folio *src, enum migrate_mode);
-	int (*migratepage) (struct address_space *,
-			struct page *, struct page *, enum migrate_mode);
 	bool (*isolate_page)(struct page *, isolate_mode_t);
 	void (*putback_page)(struct page *);
 	int (*launder_folio)(struct folio *);
diff --git a/mm/compaction.c b/mm/compaction.c
index db34b459e5d9..f0dc62159c0e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1034,7 +1034,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 			/*
 			 * Only pages without mappings or that have a
-			 * ->migratepage callback are possible to migrate
+			 * ->migrate_folio callback are possible to migrate
 			 * without blocking. However, we can be racing with
 			 * truncation so it's necessary to lock the page
 			 * to stabilise the mapping as truncation holds
@@ -1046,8 +1046,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 			mapping = page_mapping(page);
 			migrate_dirty = !mapping ||
-					mapping->a_ops->migrate_folio ||
-					mapping->a_ops->migratepage;
+					mapping->a_ops->migrate_folio;
 			unlock_page(page);
 			if (!migrate_dirty)
 				goto isolate_fail_put;
diff --git a/mm/migrate.c b/mm/migrate.c
index a8edd226c72d..c5560430dce4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -911,9 +911,6 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 			 */
 			rc = mapping->a_ops->migrate_folio(mapping, dst, src,
 								mode);
-		else if (mapping->a_ops->migratepage)
-			rc = mapping->a_ops->migratepage(mapping, &dst->page,
-							&src->page, mode);
 		else
 			rc = fallback_migrate_folio(mapping, dst, src, mode);
 	} else {
@@ -928,12 +925,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 			goto out;
 		}
 
-		if (mapping->a_ops->migrate_folio)
-			rc = mapping->a_ops->migrate_folio(mapping, dst, src,
-								mode);
-		else
-			rc = mapping->a_ops->migratepage(mapping, &dst->page,
-							&src->page, mode);
+		rc = mapping->a_ops->migrate_folio(mapping, dst, src, mode);
 		WARN_ON_ONCE(rc == MIGRATEPAGE_SUCCESS &&
 				!folio_test_isolated(src));
 	}
-- 
2.35.1

