Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF172D0B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 22:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbjFLUjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 16:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjFLUj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:39:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AED13E;
        Mon, 12 Jun 2023 13:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y1wWS1OQ/HLUe2A+9l4XTUm8jeKJuf95z9T7/th56+o=; b=G6XsM81vR1q+slu7YqpB3UY7W6
        QGLd1t9eZdHBlrY90rwprCoM6qvqz1toS1ek3Zdt/HwZhgPklkuDD4e/UOgLJXrAkjrT0/TKADgyY
        gpND+BwgD2LoP5vIr2D0Q1OAXE6vaczeRYaOeJbh/eL/uq5BYPYGzjAdaEYYrnazXdP8lZmW4tuYY
        PHftS6GBHnU11G4t4hJpfy31ArpZfsmCn+SkXsI8KW0SGIs84T9HJfmW4J8EwkaJPGCV9aT6ufgmz
        1Kz8rvk1az8CkclfzlV6HaYEXslQNk1P+RZyV4oSZLuYIjaexi+cSlrDxH2k2NmZ7V92d1Xj1ZBGN
        SD9UHfqw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8oJl-0032Sk-V7; Mon, 12 Jun 2023 20:39:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 7/8] iomap: Create large folios in the buffered write path
Date:   Mon, 12 Jun 2023 21:39:09 +0100
Message-Id: <20230612203910.724378-8-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230612203910.724378-1-willy@infradead.org>
References: <20230612203910.724378-1-willy@infradead.org>
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

Use the size of the write as a hint for the size of the folio to create.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/bmap.c         | 2 +-
 fs/iomap/buffered-io.c | 6 ++++--
 include/linux/iomap.h  | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index c739b258a2d9..3702e5e47b0f 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -971,7 +971,7 @@ gfs2_iomap_get_folio(struct iomap_iter *iter, loff_t pos, unsigned len)
 	if (status)
 		return ERR_PTR(status);
 
-	folio = iomap_get_folio(iter, pos);
+	folio = iomap_get_folio(iter, pos, len);
 	if (IS_ERR(folio))
 		gfs2_trans_end(sdp);
 	return folio;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9af357d52e56..a5d62c9640cf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -461,16 +461,18 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
  * iomap_get_folio - get a folio reference for writing
  * @iter: iteration structure
  * @pos: start offset of write
+ * @len: length of write
  *
  * Returns a locked reference to the folio at @pos, or an error pointer if the
  * folio could not be obtained.
  */
-struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
+struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
 {
 	fgf_t fgp = FGP_WRITEBEGIN | FGP_NOFS;
 
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
+	fgp |= fgf_set_order(len);
 
 	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
 			fgp, mapping_gfp_mask(iter->inode->i_mapping));
@@ -596,7 +598,7 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter, loff_t pos,
 	if (folio_ops && folio_ops->get_folio)
 		return folio_ops->get_folio(iter, pos, len);
 	else
-		return iomap_get_folio(iter, pos);
+		return iomap_get_folio(iter, pos, len);
 }
 
 static void __iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e2b836c2e119..80facb9c9e5b 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -261,7 +261,7 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
-struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos);
+struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
-- 
2.39.2

