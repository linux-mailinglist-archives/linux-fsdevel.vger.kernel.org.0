Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4061E26B27D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgIOWsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 18:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgIOPox (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB112C06178B;
        Tue, 15 Sep 2020 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OuuyUbl6fRpyPuVA1h48uJIc/QfDHGM8Hj5cvHozx6E=; b=nWyXGSDHZdAP1YdTj9zwyd0An3
        MlMyHu4EDE7/jPKWVYoR4f3clD4hD7rNBWZsPW6grmE89shWB506PIGrbQrJxLCW559zwrIu/R78o
        CqR2JnObX2DO6f1pGA8X1IEkYGkbDjYrUq4at0c9bffQ3I7A2NyG4UXAyIhEY9JEDNNKdxrR8J6Is
        bqrbID/SSL25EpVj8LoJXQcl31wEfR0gi5DIahn3m1JJy+w0gB5eQBPPLNYsjQa7naDGwYWcbPgAl
        x03Ia1RtPhUSY1FHGhsoihUMlDW77O0vznKUCI3oPbR/jcyIgV7IIxqSKu2p0UQcMLjuOMp8CUIMX
        b3uHkfyQ==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kID8P-0002cx-H9; Tue, 15 Sep 2020 15:44:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 11/12] bdi: invert BDI_CAP_NO_ACCT_WB
Date:   Tue, 15 Sep 2020 17:18:28 +0200
Message-Id: <20200915151829.1767176-12-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915151829.1767176-1-hch@lst.de>
References: <20200915151829.1767176-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace BDI_CAP_NO_ACCT_WB with a positive BDI_CAP_WRITEBACK_ACCT to
make the checks more obvious.  Also remove the pointless
bdi_cap_account_writeback wrapper that just obsfucates the check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/fuse/inode.c             |  3 ++-
 include/linux/backing-dev.h | 13 +++----------
 mm/backing-dev.c            |  1 +
 mm/page-writeback.c         |  4 ++--
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 17b00670fb539e..581329203d6860 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1050,7 +1050,8 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 		return err;
 
 	/* fuse does it's own writeback accounting */
-	sb->s_bdi->capabilities = BDI_CAP_NO_ACCT_WB | BDI_CAP_STRICTLIMIT;
+	sb->s_bdi->capabilities &= ~BDI_CAP_WRITEBACK_ACCT;
+	sb->s_bdi->capabilities |= BDI_CAP_STRICTLIMIT;
 
 	/*
 	 * For a single fuse filesystem use max 1% of dirty +
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 5da4ea3dd0cc5c..b217344a2c63be 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -120,17 +120,17 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio);
  *
  * BDI_CAP_NO_ACCT_DIRTY:  Dirty pages shouldn't contribute to accounting
  * BDI_CAP_NO_WRITEBACK:   Don't write pages back
- * BDI_CAP_NO_ACCT_WB:     Don't automatically account writeback pages
+ * BDI_CAP_WRITEBACK_ACCT: Automatically account writeback pages
  * BDI_CAP_STRICTLIMIT:    Keep number of dirty pages below bdi threshold.
  */
 #define BDI_CAP_NO_ACCT_DIRTY	0x00000001
 #define BDI_CAP_NO_WRITEBACK	0x00000002
-#define BDI_CAP_NO_ACCT_WB	0x00000004
+#define BDI_CAP_WRITEBACK_ACCT	0x00000004
 #define BDI_CAP_STRICTLIMIT	0x00000010
 #define BDI_CAP_CGROUP_WRITEBACK 0x00000020
 
 #define BDI_CAP_NO_ACCT_AND_WRITEBACK \
-	(BDI_CAP_NO_WRITEBACK | BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_ACCT_WB)
+	(BDI_CAP_NO_WRITEBACK | BDI_CAP_NO_ACCT_DIRTY)
 
 extern struct backing_dev_info noop_backing_dev_info;
 
@@ -179,13 +179,6 @@ static inline bool bdi_cap_account_dirty(struct backing_dev_info *bdi)
 	return !(bdi->capabilities & BDI_CAP_NO_ACCT_DIRTY);
 }
 
-static inline bool bdi_cap_account_writeback(struct backing_dev_info *bdi)
-{
-	/* Paranoia: BDI_CAP_NO_WRITEBACK implies BDI_CAP_NO_ACCT_WB */
-	return !(bdi->capabilities & (BDI_CAP_NO_ACCT_WB |
-				      BDI_CAP_NO_WRITEBACK));
-}
-
 static inline bool mapping_cap_writeback_dirty(struct address_space *mapping)
 {
 	return bdi_cap_writeback_dirty(inode_to_bdi(mapping->host));
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index f9a2842bd81c3d..ab0415dde5c66c 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -744,6 +744,7 @@ struct backing_dev_info *bdi_alloc(int node_id)
 		kfree(bdi);
 		return NULL;
 	}
+	bdi->capabilities = BDI_CAP_WRITEBACK_ACCT;
 	bdi->ra_pages = VM_READAHEAD_PAGES;
 	bdi->io_pages = VM_READAHEAD_PAGES;
 	return bdi;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e9c36521461aaa..0139f9622a92da 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2738,7 +2738,7 @@ int test_clear_page_writeback(struct page *page)
 		if (ret) {
 			__xa_clear_mark(&mapping->i_pages, page_index(page),
 						PAGECACHE_TAG_WRITEBACK);
-			if (bdi_cap_account_writeback(bdi)) {
+			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
 				struct bdi_writeback *wb = inode_to_wb(inode);
 
 				dec_wb_stat(wb, WB_WRITEBACK);
@@ -2791,7 +2791,7 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 						   PAGECACHE_TAG_WRITEBACK);
 
 			xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
-			if (bdi_cap_account_writeback(bdi))
+			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT)
 				inc_wb_stat(inode_to_wb(inode), WB_WRITEBACK);
 
 			/*
-- 
2.28.0

