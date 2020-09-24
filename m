Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6CC27698B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 08:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgIXGwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 02:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgIXGwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:52:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D847EC0613DB;
        Wed, 23 Sep 2020 23:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XopQpzpw3KoIwQKF1nuIAvoWKkMjHrthqtRC/LQIsIM=; b=FUjCrvU6H2vva9OlbvPRBjueT5
        3WXeoJz7jDgz3iw1Mg+Iopz/QJv6nWDYq/GeZgV0pNiTlmEizWOs5noXGIap262ObPZLLRr7tvE8r
        JNstR6W2pQXp1QSypUIAUd6VajwetTYHmxREzhwHzIiglVM/1kYN8t+yrxAp2LIA9cOfWRrvBdCLS
        G605Ys2cGihmniidppqvKePiGkYbfjsW9VA/Aj55jf2UW1wyYJDiPsfLR3g1zI2EYw4T57DMfQJ+i
        gxrErAJDe9sH140Q+m+FmHzsKzsELzKsSi7UI7xmwOqgFxtavnbxKa6xUMzx4tWiinIxQeTWJ+g6u
        tHziqaFg==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLL6j-0001Bg-1R; Thu, 24 Sep 2020 06:51:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Coly Li <colyli@suse.de>, Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Justin Sanders <justin@coraid.com>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 12/13] bdi: invert BDI_CAP_NO_ACCT_WB
Date:   Thu, 24 Sep 2020 08:51:39 +0200
Message-Id: <20200924065140.726436-13-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924065140.726436-1-hch@lst.de>
References: <20200924065140.726436-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace BDI_CAP_NO_ACCT_WB with a positive BDI_CAP_WRITEBACK_ACCT to
make the checks more obvious.  Also remove the pointless
bdi_cap_account_writeback wrapper that just obsfucates the check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
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
index 8e3802bf03a968..df18f0088dd3f5 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -745,6 +745,7 @@ struct backing_dev_info *bdi_alloc(int node_id)
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

