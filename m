Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAEF720BE6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 00:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjFBWZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 18:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbjFBWZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:25:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272779D;
        Fri,  2 Jun 2023 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TGMalEYO1ErQ54h43Guq5ImxIk0N+4z7/wR3wP91NUQ=; b=lNrsg9mcNam2PCMiHWIauhJ8D9
        6NU5XdNfGnjUBBEcvMSJp9NyocNQmqJYcvP+CxTP8WklmjZSR3tyG80NI2mTS+aDZRx5q9zbdd0jm
        Iztfdl9mIOq2Cqq/XKF8JWPHviGbeR5cIULDKRPhLtbHUoufX7TNtgvwljCefQC90TRa+PSSpS9Af
        kgJhb2v18Dx0z1DWlZKY8gBeizJIrF859inorkkJm0rPyFY4HBL/WyaPs8Taxn8E2YsVoNdHFMUsF
        MZU2g3Y19HrNmbAA89oB+tAalNsVF/FiyDGP87ArObbH8i80eJfBzB0kmipqNk54CHuqTq9oKD9Kd
        OSc+Eo5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q5DCR-009aPS-5H; Fri, 02 Jun 2023 22:24:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 6/7] iomap: Create large folios in the buffered write path
Date:   Fri,  2 Jun 2023 23:24:43 +0100
Message-Id: <20230602222445.2284892-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230602222445.2284892-1-willy@infradead.org>
References: <20230602222445.2284892-1-willy@infradead.org>
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
index 30d53b50ee0f..a10f9c037515 100644
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
 	fgp_t fgp = FGP_WRITEBEGIN | FGP_NOFS;
 
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
+	fgp |= fgp_set_order(len);
 
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

