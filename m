Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1125353F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 21:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348492AbiEZT3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 15:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347357AbiEZT30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 15:29:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C68DFF5C
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Tw57enbumz2FqWsQdoAMcuYQfaSu50lDHkdYyxdjVvc=; b=mZkwFP1W1F/ieBE7sEmtWtJ3C0
        w0nJNDnxeKp2HzI7Cv/e9gK23H5h4BVxnlb6+CRgTp8RKSjE6qF88TJURwhiGIBYn01Rg18XZOjn8
        HOb/n3k/1+r/wfjIyVfrvnX/HIJmihq/ptYU2hsIQyn7TReD7H54NP42N4nVcsPexzrIX5j8hh10u
        gaXgWBiO3gKgx6w2439KRi/2wZQ8hwh54cEidhA0Yec11/1oZit/P7aBhfYBRkhwqWzdCwMU2KdHF
        3rQ9drTfCA+T4VdntjuGv2gUml9uGFdEa7fBc4XPx3uvV6fkvXophgxNlDGuuFu6s4VVOl2TUQfZ8
        yl9L8JpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuJAb-001Uur-C0; Thu, 26 May 2022 19:29:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 8/9] jfs: Write quota through the page cache
Date:   Thu, 26 May 2022 20:29:09 +0100
Message-Id: <20220526192910.357055-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220526192910.357055-1-willy@infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
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

Remove call to jfs_get_block() and use the page cache directly instead
of wrapping it in a buffer_head.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/super.c | 71 ++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 1e7d117b555d..151c62e2a08f 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -14,7 +14,6 @@
 #include <linux/moduleparam.h>
 #include <linux/kthread.h>
 #include <linux/posix_acl.h>
-#include <linux/buffer_head.h>
 #include <linux/exportfs.h>
 #include <linux/crc32.h>
 #include <linux/slab.h>
@@ -760,54 +759,58 @@ static ssize_t jfs_quota_read(struct super_block *sb, int type, char *data,
 
 /* Write to quotafile */
 static ssize_t jfs_quota_write(struct super_block *sb, int type,
-			       const char *data, size_t len, loff_t off)
+			       const char *data, size_t len, loff_t pos)
 {
 	struct inode *inode = sb_dqopt(sb)->files[type];
-	sector_t blk = off >> sb->s_blocksize_bits;
+	struct address_space *mapping = inode->i_mapping;
 	int err = 0;
-	int offset = off & (sb->s_blocksize - 1);
-	int tocopy;
 	size_t towrite = len;
-	struct buffer_head tmp_bh;
-	struct buffer_head *bh;
 
 	inode_lock(inode);
 	while (towrite > 0) {
-		tocopy = sb->s_blocksize - offset < towrite ?
-				sb->s_blocksize - offset : towrite;
-
-		tmp_bh.b_state = 0;
-		tmp_bh.b_size = i_blocksize(inode);
-		err = jfs_get_block(inode, blk, &tmp_bh, 1);
-		if (err)
-			goto out;
-		if (offset || tocopy != sb->s_blocksize)
-			bh = sb_bread(sb, tmp_bh.b_blocknr);
-		else
-			bh = sb_getblk(sb, tmp_bh.b_blocknr);
-		if (!bh) {
-			err = -EIO;
-			goto out;
+		pgoff_t index = pos / PAGE_SIZE;
+		size_t tocopy = min(PAGE_SIZE - offset_in_page(pos), towrite);
+		struct folio *folio;
+		void *dst;
+
+		if (offset_in_page(pos) ||
+		    (towrite < PAGE_SIZE && (pos + towrite < inode->i_size))) {
+			folio = read_mapping_folio(mapping, index, NULL);
+			if (IS_ERR(folio)) {
+				err = PTR_ERR(folio);
+				break;
+			}
+		} else {
+			folio = __filemap_get_folio(mapping, index,
+					FGP_CREAT|FGP_WRITE, GFP_KERNEL);
+			if (!folio) {
+				err = -ENOMEM;
+				break;
+			}
 		}
-		lock_buffer(bh);
-		memcpy(bh->b_data+offset, data, tocopy);
-		flush_dcache_page(bh->b_page);
-		set_buffer_uptodate(bh);
-		mark_buffer_dirty(bh);
-		unlock_buffer(bh);
-		brelse(bh);
-		offset = 0;
+
+		folio_lock(folio);
+		dst = kmap_local_folio(folio, offset_in_folio(folio, pos));
+		memcpy(dst, data, tocopy);
 		towrite -= tocopy;
 		data += tocopy;
-		blk++;
+		pos += tocopy;
+		if (!towrite && pos >= inode->i_size)
+			memset(dst + tocopy, 0, PAGE_SIZE - tocopy);
+		kunmap_local(dst);
+
+		folio_mark_uptodate(folio);
+		folio_mark_dirty(folio);
+		folio_unlock(folio);
+		folio_put(folio);
 	}
-out:
+
 	if (len == towrite) {
 		inode_unlock(inode);
 		return err;
 	}
-	if (inode->i_size < off+len-towrite)
-		i_size_write(inode, off+len-towrite);
+	if (inode->i_size < pos + len - towrite)
+		i_size_write(inode, pos + len - towrite);
 	inode->i_mtime = inode->i_ctime = current_time(inode);
 	mark_inode_dirty(inode);
 	inode_unlock(inode);
-- 
2.34.1

