Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270E2543693
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 17:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243889AbiFHPMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 11:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242465AbiFHPLu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:11:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0704A0038;
        Wed,  8 Jun 2022 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GbYk6WOt1dmTqgVV6yE5r+zIsB4v0sAfl69wEExYZVA=; b=Avm4ohsfCHV3ITlqMqf2jpVpw0
        IMOZj7fyZbC5iV7nTa3UiJKE6MY3T5i/uCrkDUsFF4AHwZozCQI/jezfAirc4Rt7lV10DpHdXgpVv
        HwvO3PQ82Ljpfj+bVRM9nX+FqP5at4G8638Lf/Y23JZBOfbCSUVhSfGzlTCXeJ412NWBXtTRK4tPV
        l5nw5SoD+S2LeVACUshYo3NXuTXLJgcnVCt8pC7bTFlOs1hz2JEx+tlk60ClyMU/daGv1TEYDSIYc
        3CGKxaOONIbpGJeCBheEf/lTy+OxqCrdvV8s5fcYLlnAxJzahzGG9Rz01UBxjf+ktT1m08pyVoDQI
        fQR1vsVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyxCv-00CjFk-6D; Wed, 08 Jun 2022 15:02:53 +0000
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
Subject: [PATCH v2 16/19] hugetlb: Convert to migrate_folio
Date:   Wed,  8 Jun 2022 16:02:46 +0100
Message-Id: <20220608150249.3033815-17-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220608150249.3033815-1-willy@infradead.org>
References: <20220608150249.3033815-1-willy@infradead.org>
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

This involves converting migrate_huge_page_move_mapping().  We also need a
folio variant of hugetlb_set_page_subpool(), but that's for a later patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hugetlbfs/inode.c    | 23 ++++++++++++++---------
 include/linux/migrate.h |  6 +++---
 mm/migrate.c            | 18 +++++++++---------
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 14d33f725e05..eca1d0fabd7e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -954,28 +954,33 @@ static int hugetlbfs_symlink(struct user_namespace *mnt_userns,
 	return error;
 }
 
-static int hugetlbfs_migrate_page(struct address_space *mapping,
-				struct page *newpage, struct page *page,
+#ifdef CONFIG_MIGRATION
+static int hugetlbfs_migrate_folio(struct address_space *mapping,
+				struct folio *dst, struct folio *src,
 				enum migrate_mode mode)
 {
 	int rc;
 
-	rc = migrate_huge_page_move_mapping(mapping, newpage, page);
+	rc = migrate_huge_page_move_mapping(mapping, dst, src);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
 
-	if (hugetlb_page_subpool(page)) {
-		hugetlb_set_page_subpool(newpage, hugetlb_page_subpool(page));
-		hugetlb_set_page_subpool(page, NULL);
+	if (hugetlb_page_subpool(&src->page)) {
+		hugetlb_set_page_subpool(&dst->page,
+					hugetlb_page_subpool(&src->page));
+		hugetlb_set_page_subpool(&src->page, NULL);
 	}
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
-		migrate_page_copy(newpage, page);
+		folio_migrate_copy(dst, src);
 	else
-		migrate_page_states(newpage, page);
+		folio_migrate_flags(dst, src);
 
 	return MIGRATEPAGE_SUCCESS;
 }
+#else
+#define hugetlbfs_migrate_folio NULL
+#endif
 
 static int hugetlbfs_error_remove_page(struct address_space *mapping,
 				struct page *page)
@@ -1142,7 +1147,7 @@ static const struct address_space_operations hugetlbfs_aops = {
 	.write_begin	= hugetlbfs_write_begin,
 	.write_end	= hugetlbfs_write_end,
 	.dirty_folio	= noop_dirty_folio,
-	.migratepage    = hugetlbfs_migrate_page,
+	.migrate_folio  = hugetlbfs_migrate_folio,
 	.error_remove_page	= hugetlbfs_error_remove_page,
 };
 
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 82f00ad69a54..59d64a1e6b4b 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -42,8 +42,8 @@ extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 
 extern void migrate_page_states(struct page *newpage, struct page *page);
 extern void migrate_page_copy(struct page *newpage, struct page *page);
-extern int migrate_huge_page_move_mapping(struct address_space *mapping,
-				  struct page *newpage, struct page *page);
+int migrate_huge_page_move_mapping(struct address_space *mapping,
+		struct folio *dst, struct folio *src);
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
 void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
@@ -74,7 +74,7 @@ static inline void migrate_page_copy(struct page *newpage,
 				     struct page *page) {}
 
 static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
-				  struct page *newpage, struct page *page)
+				  struct folio *dst, struct folio *src)
 {
 	return -ENOSYS;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 4d8115ca93bb..bed0de86f3ae 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -474,26 +474,26 @@ EXPORT_SYMBOL(folio_migrate_mapping);
  * of folio_migrate_mapping().
  */
 int migrate_huge_page_move_mapping(struct address_space *mapping,
-				   struct page *newpage, struct page *page)
+				   struct folio *dst, struct folio *src)
 {
-	XA_STATE(xas, &mapping->i_pages, page_index(page));
+	XA_STATE(xas, &mapping->i_pages, folio_index(src));
 	int expected_count;
 
 	xas_lock_irq(&xas);
-	expected_count = 2 + page_has_private(page);
-	if (!page_ref_freeze(page, expected_count)) {
+	expected_count = 2 + folio_has_private(src);
+	if (!folio_ref_freeze(src, expected_count)) {
 		xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
 
-	newpage->index = page->index;
-	newpage->mapping = page->mapping;
+	dst->index = src->index;
+	dst->mapping = src->mapping;
 
-	get_page(newpage);
+	folio_get(dst);
 
-	xas_store(&xas, newpage);
+	xas_store(&xas, dst);
 
-	page_ref_unfreeze(page, expected_count - 1);
+	folio_ref_unfreeze(src, expected_count - 1);
 
 	xas_unlock_irq(&xas);
 
-- 
2.35.1

