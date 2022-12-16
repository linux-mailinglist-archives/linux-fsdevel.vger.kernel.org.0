Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0751E64ED85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiLPPIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiLPPHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:07:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50770E6
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671203206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QI72j2XrdosgKnSLpRZ/7ZEOQEe2TrvWzPHFLuxiJBI=;
        b=ZgSy0lyRlGKzojMnfp6A4Gu53zkgOpftsFEiT7gbIgTrzHuUNjFG6hzH5cfnIE5dmj72QV
        gp4eLpZZz1vfKrH4yfkW0Nbp1wuiSFPx5qMLyq1G4YaC1Kua3s41CcWnwnTMrMYA0mQpo1
        Hb+r2dMuuwOA0I2zA7ye4eXdJXK/Hgg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-FL60E5LNN169iDjYzpHFjg-1; Fri, 16 Dec 2022 10:06:43 -0500
X-MC-Unique: FL60E5LNN169iDjYzpHFjg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC1E2886066;
        Fri, 16 Dec 2022 15:06:42 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-182.brq.redhat.com [10.40.192.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BA0314171BE;
        Fri, 16 Dec 2022 15:06:40 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [RFC v3 5/7] iomap: Get page in page_prepare handler
Date:   Fri, 16 Dec 2022 16:06:24 +0100
Message-Id: <20221216150626.670312-6-agruenba@redhat.com>
In-Reply-To: <20221216150626.670312-1-agruenba@redhat.com>
References: <20221216150626.670312-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
The ->page_done() handler is now not called with a NULL folio anymore.

Filesystems are expected to use the iomap_folio_prepare() helper for
getting locked folios in their ->page_prepare() handlers.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c         | 16 +++++++++++++---
 fs/iomap/buffered-io.c | 21 +++++++++------------
 include/linux/iomap.h  |  9 +++++----
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 11115fce68cb..cd5984d3ba50 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -959,15 +959,25 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
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
+	folio = iomap_folio_prepare(iter, pos);
+	if (!folio)
+		gfs2_trans_end(sdp);
+	return folio;
 }
 
 static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f0f167ca1b2e..6b7c1a10b8ec 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -602,7 +602,7 @@ static void iomap_folio_done(struct iomap_iter *iter, loff_t pos, size_t ret,
 
 	if (page_ops && page_ops->page_done) {
 		page_ops->page_done(iter->inode, pos, ret, folio);
-	} else if (folio) {
+	} else {
 		folio_unlock(folio);
 		folio_put(folio);
 	}
@@ -635,17 +635,14 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	if (!mapping_large_folio_support(iter->inode->i_mapping))
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
-	if (page_ops && page_ops->page_prepare) {
-		status = page_ops->page_prepare(iter->inode, pos, len);
-		if (status)
-			return status;
-	}
-
-	folio = iomap_folio_prepare(iter, pos);
-	if (!folio) {
-		status = (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
-		iomap_folio_done(iter, pos, 0, NULL);
-		return status;
+	if (page_ops && page_ops->page_prepare)
+		folio = page_ops->page_prepare(iter, pos, len);
+	else
+		folio = iomap_folio_prepare(iter, pos);
+	if (IS_ERR_OR_NULL(folio)) {
+		if (!folio)
+			return (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
+		return PTR_ERR(folio);
 	}
 
 	/*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0bf16ef22d81..c74ab8c53b47 100644
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
  * When page_prepare succeeds, page_done will always be called to do any
- * cleanup work necessary.  In that page_done call, @folio will be NULL if the
- * associated folio could not be obtained.  When folio is not NULL, page_done
- * is responsible for unlocking and putting the folio.
+ * cleanup work necessary.  page_done is responsible for unlocking and putting
+ * @folio.
  */
 struct iomap_page_ops {
-	int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len);
+	struct folio *(*page_prepare)(struct iomap_iter *iter, loff_t pos,
+			unsigned len);
 	void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
 			struct folio *folio);
 
-- 
2.38.1

