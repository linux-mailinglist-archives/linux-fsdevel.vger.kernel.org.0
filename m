Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F0D53F0D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 22:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiFFUst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 16:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiFFUsB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:48:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0467D140418;
        Mon,  6 Jun 2022 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MljmBGg5QLNrlXQo2zoqyO/w7uyNryh0JirP0K7S3ag=; b=crx1P1AOzfaVjsIjKFsnW/dRPz
        BXw2ENLZjBS3Tf/K4vlxUvTW65vSWeLe4SK5T0Xn+T+dHDiJg0i+lSt2MU+wL0lJZ5+okWaxAgbc0
        Z/vst7YgLlz94wNZjneO8OUXYrNEJKVSQQicN17cN1YoPQTICS4bXGxyDlnzy9O5ahmISSxp7vpN/
        Hwqq/epOdfS0GN2mfRLkGMDSNsHzoUSO3A1kzb8obP6+oMgROyOVolsUsjhQaeGAY7SVGoFC37P39
        vXEmqMt5KDLiFuVK/vK6EVvywxX227bt9H9wiRu2WVwsFGhB7SVM3X8Mlqtvyz7jItHArnFsZxYgX
        ssmeGojg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyJWx-00B19c-AH; Mon, 06 Jun 2022 20:40:55 +0000
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
Subject: [PATCH 10/20] btrfs: Convert btrfs_migratepage to migrate_folio
Date:   Mon,  6 Jun 2022 21:40:40 +0100
Message-Id: <20220606204050.2625949-11-willy@infradead.org>
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

Use filemap_migrate_folio() to do the bulk of the work, and then copy
the ordered flag across if needed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/inode.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 81737eff92f3..5f41d869c648 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8255,30 +8255,24 @@ static bool btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 }
 
 #ifdef CONFIG_MIGRATION
-static int btrfs_migratepage(struct address_space *mapping,
-			     struct page *newpage, struct page *page,
+static int btrfs_migrate_folio(struct address_space *mapping,
+			     struct folio *dst, struct folio *src,
 			     enum migrate_mode mode)
 {
-	int ret;
+	int ret = filemap_migrate_folio(mapping, dst, src, mode);
 
-	ret = migrate_page_move_mapping(mapping, newpage, page, 0);
 	if (ret != MIGRATEPAGE_SUCCESS)
 		return ret;
 
-	if (page_has_private(page))
-		attach_page_private(newpage, detach_page_private(page));
-
-	if (PageOrdered(page)) {
-		ClearPageOrdered(page);
-		SetPageOrdered(newpage);
+	if (folio_test_ordered(src)) {
+		folio_clear_ordered(src);
+		folio_set_ordered(dst);
 	}
 
-	if (mode != MIGRATE_SYNC_NO_COPY)
-		migrate_page_copy(newpage, page);
-	else
-		migrate_page_states(newpage, page);
 	return MIGRATEPAGE_SUCCESS;
 }
+#else
+#define btrfs_migrate_folio NULL
 #endif
 
 static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
@@ -11422,9 +11416,7 @@ static const struct address_space_operations btrfs_aops = {
 	.direct_IO	= noop_direct_IO,
 	.invalidate_folio = btrfs_invalidate_folio,
 	.release_folio	= btrfs_release_folio,
-#ifdef CONFIG_MIGRATION
-	.migratepage	= btrfs_migratepage,
-#endif
+	.migrate_folio	= btrfs_migrate_folio,
 	.dirty_folio	= filemap_dirty_folio,
 	.error_remove_page = generic_error_remove_page,
 	.swap_activate	= btrfs_swap_activate,
-- 
2.35.1

