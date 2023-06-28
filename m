Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A87274150F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjF1PcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjF1Pb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:31:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E31A2110;
        Wed, 28 Jun 2023 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KsdBeZ20scZ+l4cg5+MIpGOwLSatgPbh99awfYXDByY=; b=VO3AYglIk3x3IpPAiRmRiuXKXB
        VdnsWQxrA8znWTTbdvHMqOVQvG8Pfm4qHtX14QXPOgDm6SL7CcOmb0LO4GxjJ5eOk9Uf7qbue6/oG
        NfZmUOCrThzlfwJazEdeLdx4bS/xQRxqsAQi5bL100N750Vy4fdzqFMosz764s1KRR7KwO74GP71Y
        dV6nqABjGdU59KaswNOl40MrPiSpFXTPudlqYz3Kfonw1Ff6CfqqssrBVX6wZg+Ka1iJz97njBXry
        FKLMM8b4SjusevfsaX9te+1+EYHJ7qpVNCTpjPLw3LEg+Uq2sbjhAvTdg8xUJ41KWBiiuuyKDnt3z
        Wy2x6yVw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX95-00G02d-2Y;
        Wed, 28 Jun 2023 15:31:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/23] btrfs: pass a flags argument to cow_file_range
Date:   Wed, 28 Jun 2023 17:31:22 +0200
Message-Id: <20230628153144.22834-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230628153144.22834-1-hch@lst.de>
References: <20230628153144.22834-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The int used as bool unlock is not a very good way to describe the
behavior, and the next patch will have to add another beahvior modifier.
Switch to pass a flag instead, with an inital CFR_KEEP_LOCKED flag that
specifies the pages should always be kept locked.  This is the inverse
of the old unlock argument for the reason that it requires a flag for
the exceptional behavior.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 51 ++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dbbb67293e345c..92a78940991fcb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -124,11 +124,13 @@ static struct kmem_cache *btrfs_inode_cachep;
 
 static int btrfs_setsize(struct inode *inode, struct iattr *attr);
 static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback);
+
+#define CFR_KEEP_LOCKED		(1 << 0)
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page,
 				   u64 start, u64 end, int *page_started,
-				   unsigned long *nr_written, int unlock,
-				   u64 *done_offset);
+				   unsigned long *nr_written, u64 *done_offset,
+				   u32 flags);
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
 				       u64 block_len, u64 orig_block_len,
@@ -1148,7 +1150,7 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 	 * can directly submit them without interruption.
 	 */
 	ret = cow_file_range(inode, locked_page, start, end, &page_started,
-			     &nr_written, 0, NULL);
+			     &nr_written, NULL, CFR_KEEP_LOCKED);
 	/* Inline extent inserted, page gets unlocked and everything is done */
 	if (page_started)
 		return 0;
@@ -1362,25 +1364,18 @@ static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
  * locked_page is the page that writepage had locked already.  We use
  * it to make sure we don't do extra locks or unlocks.
  *
- * *page_started is set to one if we unlock locked_page and do everything
- * required to start IO on it.  It may be clean and already done with
- * IO when we return.
- *
- * When unlock == 1, we unlock the pages in successfully allocated regions.
- * When unlock == 0, we leave them locked for writing them out.
+ * When this function fails, it unlocks all pages except @locked_page.
  *
- * However, we unlock all the pages except @locked_page in case of failure.
+ * When this function successfully creates an inline extent, it sets page_started
+ * to 1 and unlocks all pages including locked_page and starts I/O on them.
+ * (In reality inline extents are limited to a single page, so locked_page is
+ * the only page handled anyway).
  *
- * In summary, page locking state will be as follow:
+ * When this function succeed and creates a normal extent, the page locking
+ * status depends on the passed in flags:
  *
- * - page_started == 1 (return value)
- *     - All the pages are unlocked. IO is started.
- *     - Note that this can happen only on success
- * - unlock == 1
- *     - All the pages except @locked_page are unlocked in any case
- * - unlock == 0
- *     - On success, all the pages are locked for writing out them
- *     - On failure, all the pages except @locked_page are unlocked
+ * - If CFR_KEEP_LOCKED is set, all pages are kept locked.
+ * - Else all pages except for @locked_page are unlocked.
  *
  * When a failure happens in the second or later iteration of the
  * while-loop, the ordered extents created in previous iterations are kept
@@ -1391,8 +1386,8 @@ static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page,
 				   u64 start, u64 end, int *page_started,
-				   unsigned long *nr_written, int unlock,
-				   u64 *done_offset)
+				   unsigned long *nr_written, u64 *done_offset,
+				   u32 flags)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -1558,7 +1553,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		 * Do set the Ordered (Private2) bit so we know this page was
 		 * properly setup for writepage.
 		 */
-		page_ops = unlock ? PAGE_UNLOCK : 0;
+		page_ops = (flags & CFR_KEEP_LOCKED) ? 0 : PAGE_UNLOCK;
 		page_ops |= PAGE_SET_ORDERED;
 
 		extent_clear_unlock_delalloc(inode, start, start + ram_size - 1,
@@ -1627,10 +1622,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV are handled by the cleanup
 	 * function.
 	 *
-	 * However, in case of unlock == 0, we still need to unlock the pages
-	 * (except @locked_page) to ensure all the pages are unlocked.
+	 * However, in case of CFR_KEEP_LOCKED, we still need to unlock the
+	 * pages (except @locked_page) to ensure all the pages are unlocked.
 	 */
-	if (!unlock && orig_start < start) {
+	if ((flags & CFR_KEEP_LOCKED) && orig_start < start) {
 		if (!locked_page)
 			mapping_set_error(inode->vfs_inode.i_mapping, ret);
 		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
@@ -1836,7 +1831,7 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 
 	while (start <= end) {
 		ret = cow_file_range(inode, locked_page, start, end, page_started,
-				     nr_written, 0, &done_offset);
+				     nr_written, &done_offset, CFR_KEEP_LOCKED);
 		if (ret && ret != -EAGAIN)
 			return ret;
 
@@ -1956,7 +1951,7 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 	}
 
 	return cow_file_range(inode, locked_page, start, end, page_started,
-			      nr_written, 1, NULL);
+			      nr_written, NULL, 0);
 }
 
 struct can_nocow_file_extent_args {
@@ -2433,7 +2428,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 					 page_started, nr_written, wbc);
 	else
 		ret = cow_file_range(inode, locked_page, start, end,
-				     page_started, nr_written, 1, NULL);
+				     page_started, nr_written, NULL, 0);
 
 out:
 	ASSERT(ret <= 0);
-- 
2.39.2

