Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17209661E59
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 06:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjAIFSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 00:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjAIFST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:18:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC210DE9C;
        Sun,  8 Jan 2023 21:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vQF/XULxVm6847KaRqQbhdaohxHXi2nEuadxTiR1ZyE=; b=aRa6C07mcL3ngPuqUeUeiq9Ewx
        ojEY5TSS9TePzq8VcMu5ajWtwn4NiV+m5NNngSAtK9zTzdDs3q90VzpUCMIrSyZGbu7kEiTeRh619
        6q3IWbwiybuoZMlQU/vqIim43gIyzhp3Ph8+GVUVj/vWGpTU/+Vxfh6YkJL/frk+TJxlOamIQqcWt
        IzYn4QhNA4rFF0qJuAkxUWsHMRoGHusUQ/kdpMG6Wvwysl2pFmTgzmP41oczAMhe2Rntw6fQfNV5C
        y5mvfiSAJm2MwpIQYvhXFRsv37zIzK32GV2QCdxDA5nlXXnWl94CSidw9tcoy3HcxKd6KOir4+OTQ
        wQw0SzcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEkYE-0020xc-8n; Mon, 09 Jan 2023 05:18:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 11/11] mm: Remove filemap_fdatawait_keep_errors()
Date:   Mon,  9 Jan 2023 05:18:23 +0000
Message-Id: <20230109051823.480289-12-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230109051823.480289-1-willy@infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is now the same as filemap_fdatawait(), so change all
callers to use that instead.  Remove the comments which talk about keeping
the errors around for other callers as this is now the only behaviour.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/bdev.c            | 8 +-------
 fs/fs-writeback.c       | 7 +------
 fs/xfs/scrub/bmap.c     | 2 +-
 include/linux/pagemap.h | 2 --
 4 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index edc110d90df4..2fae19f0a5c2 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1053,13 +1053,7 @@ void sync_bdevs(bool wait)
 		if (!atomic_read(&bdev->bd_openers)) {
 			; /* skip */
 		} else if (wait) {
-			/*
-			 * We keep the error status of individual mapping so
-			 * that applications can catch the writeback error using
-			 * fsync(2). See filemap_fdatawait_keep_errors() for
-			 * details.
-			 */
-			filemap_fdatawait_keep_errors(inode->i_mapping);
+			filemap_fdatawait(inode->i_mapping);
 		} else {
 			filemap_fdatawrite(inode->i_mapping);
 		}
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6fba5a52127b..dc0158125e5d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2598,12 +2598,7 @@ static void wait_sb_inodes(struct super_block *sb)
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 
-		/*
-		 * We keep the error status of individual mapping so that
-		 * applications can catch the writeback error using fsync(2).
-		 * See filemap_fdatawait_keep_errors() for details.
-		 */
-		filemap_fdatawait_keep_errors(mapping);
+		filemap_fdatawait(mapping);
 
 		cond_resched();
 
diff --git a/fs/xfs/scrub/bmap.c b/fs/xfs/scrub/bmap.c
index d50d0eab196a..8f169047d410 100644
--- a/fs/xfs/scrub/bmap.c
+++ b/fs/xfs/scrub/bmap.c
@@ -64,7 +64,7 @@ xchk_setup_inode_bmap(
 		 */
 		error = filemap_fdatawrite(mapping);
 		if (!error)
-			error = filemap_fdatawait_keep_errors(mapping);
+			error = filemap_fdatawait(mapping);
 		if (error && (error != -ENOSPC && error != -EIO))
 			goto out;
 	}
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7fe2a5ec1c12..69190335deb1 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -40,8 +40,6 @@ static inline int filemap_fdatawait(struct address_space *mapping)
 	return filemap_fdatawait_range(mapping, 0, LLONG_MAX);
 }
 
-#define filemap_fdatawait_keep_errors(mapping)	filemap_fdatawait(mapping)
-
 bool filemap_range_has_page(struct address_space *, loff_t lstart, loff_t lend);
 int filemap_write_and_wait_range(struct address_space *mapping,
 		loff_t lstart, loff_t lend);
-- 
2.35.1

