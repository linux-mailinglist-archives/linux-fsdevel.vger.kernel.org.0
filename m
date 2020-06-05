Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDAB1F0131
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 22:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgFEUsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 16:48:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:47762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbgFEUsw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:48:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43E26ABE4;
        Fri,  5 Jun 2020 20:48:53 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     darrick.wong@oracle.com
Cc:     linux-btrfs@vger.kernel.org, fdmanana@gmail.com,
        linux-fsdevel@vger.kernel.org, hch@lst.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs: Wait for extent bits to release page
Date:   Fri,  5 Jun 2020 15:48:37 -0500
Message-Id: <20200605204838.10765-3-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200605204838.10765-1-rgoldwyn@suse.de>
References: <20200605204838.10765-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

While trying to release a page, the extent containing the page may be locked
which would stop the page from being released. Wait for the
extent lock to be cleared, if blocking is allowed and then clear
the bits.

While we are at it, clean the code of try_release_extent_state() to make
it simpler.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 37 ++++++++++++++++---------------------
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     |  4 ++--
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c59e07360083..0ab444d2028d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4466,33 +4466,28 @@ int extent_invalidatepage(struct extent_io_tree *tree,
  * are locked or under IO and drops the related state bits if it is safe
  * to drop the page.
  */
-static int try_release_extent_state(struct extent_io_tree *tree,
+static bool try_release_extent_state(struct extent_io_tree *tree,
 				    struct page *page, gfp_t mask)
 {
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	int ret = 1;
 
 	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
-		ret = 0;
-	} else {
-		/*
-		 * at this point we can safely clear everything except the
-		 * locked bit and the nodatasum bit
-		 */
-		ret = __clear_extent_bit(tree, start, end,
-				 ~(EXTENT_LOCKED | EXTENT_NODATASUM),
-				 0, 0, NULL, mask, NULL);
-
-		/* if clear_extent_bit failed for enomem reasons,
-		 * we can't allow the release to continue.
-		 */
-		if (ret < 0)
-			ret = 0;
-		else
-			ret = 1;
+		if (!gfpflags_allow_blocking(mask))
+			return false;
+		wait_extent_bit(tree, start, end, EXTENT_LOCKED);
 	}
-	return ret;
+	/*
+	 * At this point we can safely clear everything except the locked and
+	 * nodatasum bits. If clear_extent_bit failed due to -ENOMEM,
+	 * don't allow release.
+	 */
+	if (__clear_extent_bit(tree, start, end,
+				~(EXTENT_LOCKED | EXTENT_NODATASUM), 0, 0,
+				NULL, mask, NULL) < 0)
+		return false;
+
+	return true;
 }
 
 /*
@@ -4500,7 +4495,7 @@ static int try_release_extent_state(struct extent_io_tree *tree,
  * in the range corresponding to the page, both state records and extent
  * map records are removed
  */
-int try_release_extent_mapping(struct page *page, gfp_t mask)
+bool try_release_extent_mapping(struct page *page, gfp_t mask)
 {
 	struct extent_map *em;
 	u64 start = page_offset(page);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 9a10681b12bf..6cba4ad6ebc1 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -189,7 +189,7 @@ typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
 					  struct page *page, size_t pg_offset,
 					  u64 start, u64 len);
 
-int try_release_extent_mapping(struct page *page, gfp_t mask);
+bool try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
 int extent_read_full_page(struct page *page, get_extent_t *get_extent,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1242d0aa108d..8cb44c49c1d2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7887,8 +7887,8 @@ btrfs_readpages(struct file *file, struct address_space *mapping,
 
 static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
 {
-	int ret = try_release_extent_mapping(page, gfp_flags);
-	if (ret == 1) {
+	bool ret = try_release_extent_mapping(page, gfp_flags);
+	if (ret) {
 		ClearPagePrivate(page);
 		set_page_private(page, 0);
 		put_page(page);
-- 
2.25.0

