Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAB263F737
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 19:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiLASLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 13:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiLASLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:11:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A11A1C0A
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 10:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669918213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4wpGn5ZS2+dyBPI2xOTo6pp4/bLux152wPskgwYzHs=;
        b=bpEuVYXCkJ3p9jLJZewoOOl/AKTa6LyibgVIa94RrXmrfaod+7ZAW6TQzyO9V/8ntBZHzx
        UQmeYJIttsg9APkQUjWVWhophd/ZbbD8Y+SluzbehweuQup+8zIO8KU4PIFNS4DXJppul7
        VlzZ//C9UbPdW0cYLTQIffLdKMozKko=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-lPeyQ7tHNp6F5-oZuvgMwA-1; Thu, 01 Dec 2022 13:10:09 -0500
X-MC-Unique: lPeyQ7tHNp6F5-oZuvgMwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9845D1010431;
        Thu,  1 Dec 2022 18:10:05 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-141.brq.redhat.com [10.40.192.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A27AFC15BB4;
        Thu,  1 Dec 2022 18:10:03 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [RFC v2 2/3] iomap: Turn iomap_page_ops into iomap_folio_ops
Date:   Thu,  1 Dec 2022 19:09:56 +0100
Message-Id: <20221201180957.1268079-3-agruenba@redhat.com>
In-Reply-To: <20221201160619.1247788-1-agruenba@redhat.com>
References: <20221201160619.1247788-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename the iomap page_ops into folio_ops, and rename the operations
accordingly.  Move looking up the folio into ->folio_prepare(), and
unlocking and putting the folio into ->folio_done().  We'll need the
added flexibility in gfs2.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c         | 40 +++++++++++++++++++++++++----------
 fs/iomap/buffered-io.c | 48 +++++++++++++++++++++++-------------------
 include/linux/iomap.h  | 24 ++++++++++-----------
 3 files changed, 67 insertions(+), 45 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 3bdb2c668a71..18dcaa95408e 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -959,36 +959,54 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 	goto out;
 }
 
-static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
-				   unsigned len)
+static struct folio *
+gfs2_iomap_folio_prepare(struct inode *inode, unsigned fgp,
+			 loff_t pos, unsigned len)
 {
 	unsigned int blockmask = i_blocksize(inode) - 1;
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	unsigned int blocks;
+	struct folio *folio;
+	int ret;
 
 	blocks = ((pos & blockmask) + len + blockmask) >> inode->i_blkbits;
-	return gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
+	ret = gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
+	if (ret)
+		return ERR_PTR(ret);
+
+	folio = __filemap_get_folio(inode->i_mapping, pos >> PAGE_SHIFT, fgp,
+				    mapping_gfp_mask(inode->i_mapping));
+	if (!folio)
+		gfs2_trans_end(sdp);
+
+	return folio;
 }
 
-static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
-				 unsigned copied, struct page *page)
+static void
+gfs2_iomap_folio_done(struct inode *inode, struct folio *folio,
+		      loff_t pos, unsigned copied)
 {
 	struct gfs2_trans *tr = current->journal_info;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
-	if (page && !gfs2_is_stuffed(ip))
-		gfs2_page_add_databufs(ip, page, offset_in_page(pos), copied);
+	folio_unlock(folio);
+
+	if (!gfs2_is_stuffed(ip))
+		gfs2_page_add_databufs(ip, &folio->page, offset_in_page(pos),
+				       copied);
 
 	if (tr->tr_num_buf_new)
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 
 	gfs2_trans_end(sdp);
+
+	folio_put(folio);
 }
 
-static const struct iomap_page_ops gfs2_iomap_page_ops = {
-	.page_prepare = gfs2_iomap_page_prepare,
-	.page_done = gfs2_iomap_page_done,
+static const struct iomap_folio_ops gfs2_iomap_folio_ops = {
+	.folio_prepare = gfs2_iomap_folio_prepare,
+	.folio_done = gfs2_iomap_folio_done,
 };
 
 static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
@@ -1064,7 +1082,7 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
 	}
 
 	if (gfs2_is_stuffed(ip) || gfs2_is_jdata(ip))
-		iomap->page_ops = &gfs2_iomap_page_ops;
+		iomap->folio_ops = &gfs2_iomap_folio_ops;
 	return 0;
 
 out_trans_end:
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 96e643de32a0..9f1656f3df17 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -587,7 +587,7 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
 static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		size_t len, struct folio **foliop)
 {
-	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
+	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct folio *folio;
 	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
@@ -606,17 +606,18 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	if (!mapping_large_folio_support(iter->inode->i_mapping))
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
-	if (page_ops && page_ops->page_prepare) {
-		status = page_ops->page_prepare(iter->inode, pos, len);
-		if (status)
-			return status;
+	if (folio_ops && folio_ops->folio_prepare) {
+		folio = folio_ops->folio_prepare(iter->inode, fgp, pos, len);
+	} else {
+		folio = __filemap_get_folio(iter->inode->i_mapping,
+				pos >> PAGE_SHIFT, fgp,
+				mapping_gfp_mask(iter->inode->i_mapping));
 	}
-
-	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
-			fgp, mapping_gfp_mask(iter->inode->i_mapping));
-	if (!folio) {
-		status = (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
-		goto out_no_page;
+	if (IS_ERR_OR_NULL(folio)) {
+		status = PTR_ERR(folio);
+		if (folio == NULL)
+			status = (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
+		return status;
 	}
 	if (pos + len > folio_pos(folio) + folio_size(folio))
 		len = folio_pos(folio) + folio_size(folio) - pos;
@@ -635,13 +636,13 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	return 0;
 
 out_unlock:
-	folio_unlock(folio);
-	folio_put(folio);
+	if (folio_ops && folio_ops->folio_done) {
+		folio_ops->folio_done(iter->inode, folio, pos, 0);
+	} else {
+		folio_unlock(folio);
+		folio_put(folio);
+	}
 	iomap_write_failed(iter->inode, pos, len);
-
-out_no_page:
-	if (page_ops && page_ops->page_done)
-		page_ops->page_done(iter->inode, pos, 0, NULL);
 	return status;
 }
 
@@ -691,7 +692,7 @@ static size_t iomap_write_end_inline(const struct iomap_iter *iter,
 static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
-	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
+	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t old_size = iter->inode->i_size;
 	size_t ret;
@@ -715,10 +716,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
 		folio_may_straddle_isize(iter->inode, folio, old_size, pos);
 	}
-	folio_unlock(folio);
-	if (page_ops && page_ops->page_done)
-		page_ops->page_done(iter->inode, pos, ret, &folio->page);
-	folio_put(folio);
+	if (folio_ops && folio_ops->folio_done) {
+		folio_ops->folio_done(iter->inode, folio, pos, ret);
+	} else {
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
 	if (ret < len)
 		iomap_write_failed(iter->inode, pos + ret, len - ret);
 	return ret;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 238a03087e17..9d3a6ad222cc 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -76,7 +76,7 @@ struct vm_fault;
  */
 #define IOMAP_NULL_ADDR -1ULL	/* addr is not valid */
 
-struct iomap_page_ops;
+struct iomap_folio_ops;
 
 struct iomap {
 	u64			addr; /* disk offset of mapping, bytes */
@@ -88,7 +88,7 @@ struct iomap {
 	struct dax_device	*dax_dev; /* dax_dev for dax operations */
 	void			*inline_data;
 	void			*private; /* filesystem private */
-	const struct iomap_page_ops *page_ops;
+	const struct iomap_folio_ops *folio_ops;
 };
 
 static inline sector_t iomap_sector(const struct iomap *iomap, loff_t pos)
@@ -115,19 +115,19 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
 }
 
 /*
- * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
- * and page_done will be called for each page written to.  This only applies to
- * buffered writes as unbuffered writes will not typically have pages
+ * When a filesystem sets folio_ops in an iomap mapping it returns, folio_prepare
+ * and folio_done will be called for each folio written to.  This only applies to
+ * buffered writes as unbuffered writes will not typically have folios
  * associated with them.
  *
- * When page_prepare succeeds, page_done will always be called to do any
- * cleanup work necessary.  In that page_done call, @page will be NULL if the
- * associated page could not be obtained.
+ * When folio_prepare succeeds, folio_done will always be called to do any
+ * cleanup work necessary.
  */
-struct iomap_page_ops {
-	int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len);
-	void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
-			struct page *page);
+struct iomap_folio_ops {
+	struct folio *(*folio_prepare)(struct inode *inode, unsigned fgp,
+				       loff_t pos, unsigned len);
+	void (*folio_done)(struct inode *inode, struct folio *folio,
+			   loff_t pos, unsigned copied);
 };
 
 /*
-- 
2.38.1

