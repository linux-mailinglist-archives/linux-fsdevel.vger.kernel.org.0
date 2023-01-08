Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E483E6618C5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 20:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbjAHTnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 14:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjAHTnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:43:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65032B872
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 11:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673206855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BqMvh0Gi+M6F9VlbFl9SjHjThwMLqrjKqYzFu/lMZTs=;
        b=atSEAPMPZAbRlDvhzwznHs4e9VEsB0GQpIIdDH/NNAmIS5bLMs7fPTK/X1K0YhPqIhW0Wd
        gNIDY645i6+xczSJqubYiFgzzmWlgQHiy2l3+LLQ5J3D49jXne52hyv1XWY/wjL9IftH6M
        YEgf7vMeA3BeBcdQBcO7UCSvCbMcKBY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-AskoVgNoO-2c9H5KtYN6bQ-1; Sun, 08 Jan 2023 14:40:53 -0500
X-MC-Unique: AskoVgNoO-2c9H5KtYN6bQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B82B729AB434;
        Sun,  8 Jan 2023 19:40:52 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-3.brq.redhat.com [10.40.192.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4372A492B06;
        Sun,  8 Jan 2023 19:40:50 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: [RFC v6 05/10] iomap/gfs2: Get page in page_prepare handler
Date:   Sun,  8 Jan 2023 20:40:29 +0100
Message-Id: <20230108194034.1444764-6-agruenba@redhat.com>
In-Reply-To: <20230108194034.1444764-1-agruenba@redhat.com>
References: <20230108194034.1444764-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change the iomap ->page_prepare() handler to get and return a locked
folio instead of doing that in iomap_write_begin().  This allows to
recover from out-of-memory situations in ->page_prepare(), which
eliminates the corresponding error handling code in iomap_write_begin().
The ->put_folio() handler now also isn't called with NULL as the folio
value anymore.

Filesystems are expected to use the iomap_get_folio() helper for getting
locked folios in their ->page_prepare() handlers.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/bmap.c         | 21 +++++++++++++--------
 fs/iomap/buffered-io.c | 17 ++++++-----------
 include/linux/iomap.h  |  9 +++++----
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 0c041459677b..41349e09558b 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -956,15 +956,25 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 	goto out;
 }
 
-static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
-				   unsigned len)
+static struct folio *
+gfs2_iomap_page_prepare(struct iomap_iter *iter, loff_t pos, unsigned len)
 {
+	struct inode *inode = iter->inode;
 	unsigned int blockmask = i_blocksize(inode) - 1;
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	unsigned int blocks;
+	struct folio *folio;
+	int status;
 
 	blocks = ((pos & blockmask) + len + blockmask) >> inode->i_blkbits;
-	return gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
+	status = gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
+	if (status)
+		return ERR_PTR(status);
+
+	folio = iomap_get_folio(iter, pos);
+	if (IS_ERR(folio))
+		gfs2_trans_end(sdp);
+	return folio;
 }
 
 static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
@@ -974,11 +984,6 @@ static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
-	if (!folio) {
-		gfs2_trans_end(sdp);
-		return;
-	}
-
 	if (!gfs2_is_stuffed(ip))
 		gfs2_page_add_databufs(ip, &folio->page, offset_in_page(pos),
 				       copied);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index de4a8e5f721a..418519dea2ce 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -609,7 +609,7 @@ static void __iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
 
 	if (page_ops && page_ops->put_folio) {
 		page_ops->put_folio(iter->inode, pos, ret, folio);
-	} else if (folio) {
+	} else {
 		folio_unlock(folio);
 		folio_put(folio);
 	}
@@ -642,17 +642,12 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	if (!mapping_large_folio_support(iter->inode->i_mapping))
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
-	if (page_ops && page_ops->page_prepare) {
-		status = page_ops->page_prepare(iter->inode, pos, len);
-		if (status)
-			return status;
-	}
-
-	folio = iomap_get_folio(iter, pos);
-	if (IS_ERR(folio)) {
-		__iomap_put_folio(iter, pos, 0, NULL);
+	if (page_ops && page_ops->page_prepare)
+		folio = page_ops->page_prepare(iter, pos, len);
+	else
+		folio = iomap_get_folio(iter, pos);
+	if (IS_ERR(folio))
 		return PTR_ERR(folio);
-	}
 
 	/*
 	 * Now we have a locked folio, before we do anything with it we need to
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 188d14e786a4..d50501781856 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -13,6 +13,7 @@
 struct address_space;
 struct fiemap_extent_info;
 struct inode;
+struct iomap_iter;
 struct iomap_dio;
 struct iomap_writepage_ctx;
 struct iov_iter;
@@ -131,12 +132,12 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
  * associated with them.
  *
  * When page_prepare succeeds, put_folio will always be called to do any
- * cleanup work necessary.  In that put_folio call, @folio will be NULL if the
- * associated folio could not be obtained.  When folio is not NULL, put_folio
- * is responsible for unlocking and putting the folio.
+ * cleanup work necessary.  put_folio is responsible for unlocking and putting
+ * @folio.
  */
 struct iomap_page_ops {
-	int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len);
+	struct folio *(*page_prepare)(struct iomap_iter *iter, loff_t pos,
+			unsigned len);
 	void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
 			struct folio *folio);
 
-- 
2.38.1

