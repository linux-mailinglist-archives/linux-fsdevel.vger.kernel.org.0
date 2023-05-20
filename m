Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAF870A93D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 18:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjETQgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 12:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjETQgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 12:36:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBA2125;
        Sat, 20 May 2023 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+5Gd20gnOfg2ptmyOVBLmZe5e2qIUOzp8yL1uT+bZ48=; b=LotIxHPyvImolSeRaIHOVRP9yQ
        AaWxiVmv7NfYHr3dO9Kre1oun7kXcG+cNt6koxqNq3+bMhv9ydK+/jZ4ELjTKWlqNFNHy+M33tN2A
        6j3eS4Je5FpEwZ5QnXiwqHcHxV4Z7FwKurHb6jJYKL22Zf51/QHAh2vu5cr3yfCyk5V9M6HS1P9qw
        1VCICjruIFJP8chNE9yYbnscuoAjS5O3YH7ZNUXAARoeWbqcveuP8ubEUvZdrW9NzCFvP7c04f2GK
        aq9xkZ17HXTXch/ulITTid5ihYlOITkDJTAvQJOmL9hCX23JBFw+qLv3ciR41ofn95LG3bIUUGjcL
        DHm93deQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q0PYr-007WmR-Iz; Sat, 20 May 2023 16:36:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 2/3] iomap: Create large folios in the buffered write path
Date:   Sat, 20 May 2023 17:36:02 +0100
Message-Id: <20230520163603.1794256-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230520163603.1794256-1-willy@infradead.org>
References: <20230520163603.1794256-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the size of the write as a hint for the size of the folio to create.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/bmap.c         |  2 +-
 fs/iomap/buffered-io.c | 10 ++++++----
 include/linux/iomap.h  |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

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
index 063133ec77f4..651af2d424ac 100644
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
 	unsigned fgp = FGP_WRITEBEGIN | FGP_NOFS;
 
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
+	fgp |= fgp_order(len);
 
 	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
 			fgp, mapping_gfp_mask(iter->inode->i_mapping));
@@ -510,8 +512,8 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 		iomap_page_release(folio);
 	} else if (folio_test_large(folio)) {
 		/* Must release the iop so the page can be split */
-		WARN_ON_ONCE(!folio_test_uptodate(folio) &&
-			     folio_test_dirty(folio));
+		VM_WARN_ON_ONCE_FOLIO(!folio_test_uptodate(folio) &&
+				folio_test_dirty(folio), folio);
 		iomap_page_release(folio);
 	}
 }
@@ -603,7 +605,7 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter, loff_t pos,
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

