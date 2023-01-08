Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36CB6618AE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 20:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjAHTmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 14:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjAHTmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:42:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72AD63EE
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 11:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673206849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PT14zPx5a4QI1wKUmKAWzmL+FBkRZkQR/RJK9Bzk7iQ=;
        b=DkRIQ5X/ug5GMqhpYDOKu522DbUoyLDkh+91jVbQa4AAOWD/96yknLG99aTEykSlkagfGc
        mfOTk1MS9SD9Hx7q+QSYAMurwHHpoayk/dyDhG3pulvRHk7hrwByD/6l2Uaqa6byAdfuOG
        vxvlMkkdvVMQunDaBo22ZHQX6xJNbpc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-j_dXx1AtPbeHu5kMaZbABw-1; Sun, 08 Jan 2023 14:40:44 -0500
X-MC-Unique: j_dXx1AtPbeHu5kMaZbABw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6320101A52E;
        Sun,  8 Jan 2023 19:40:43 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-3.brq.redhat.com [10.40.192.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28C01492B06;
        Sun,  8 Jan 2023 19:40:40 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: [RFC v6 02/10] iomap/gfs2: Unlock and put folio in page_done handler
Date:   Sun,  8 Jan 2023 20:40:26 +0100
Message-Id: <20230108194034.1444764-3-agruenba@redhat.com>
In-Reply-To: <20230108194034.1444764-1-agruenba@redhat.com>
References: <20230108194034.1444764-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When an iomap defines a ->page_done() handler in its page_ops, delegate
unlocking the folio and putting the folio reference to that handler.

This allows to fix a race between journaled data writes and folio
writeback in gfs2: before this change, gfs2_iomap_page_done() was called
after unlocking the folio, so writeback could start writing back the
folio's buffers before they could be marked for writing to the journal.
Also, try_to_free_buffers() could free the buffers before
gfs2_iomap_page_done() was done adding the buffers to the current
current transaction.  With this change, gfs2_iomap_page_done() adds the
buffers to the current transaction while the folio is still locked, so
the problems described above can no longer occur.

The only current user of ->page_done() is gfs2, so other filesystems are
not affected.  To catch out any out-of-tree users, switch from a page to
a folio in ->page_done().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/bmap.c         | 15 ++++++++++++---
 fs/iomap/buffered-io.c |  8 ++++----
 include/linux/iomap.h  |  7 ++++---
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index e7537fd305dd..46206286ad42 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -968,14 +968,23 @@ static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
 }
 
 static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
-				 unsigned copied, struct page *page)
+				 unsigned copied, struct folio *folio)
 {
 	struct gfs2_trans *tr = current->journal_info;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
-	if (page && !gfs2_is_stuffed(ip))
-		gfs2_page_add_databufs(ip, page, offset_in_page(pos), copied);
+	if (!folio) {
+		gfs2_trans_end(sdp);
+		return;
+	}
+
+	if (!gfs2_is_stuffed(ip))
+		gfs2_page_add_databufs(ip, &folio->page, offset_in_page(pos),
+				       copied);
+
+	folio_unlock(folio);
+	folio_put(folio);
 
 	if (tr->tr_num_buf_new)
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c045689b6af8..a9082078e4ed 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -580,12 +580,12 @@ static void __iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
 {
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
 
-	if (folio)
+	if (page_ops && page_ops->page_done) {
+		page_ops->page_done(iter->inode, pos, ret, folio);
+	} else if (folio) {
 		folio_unlock(folio);
-	if (page_ops && page_ops->page_done)
-		page_ops->page_done(iter->inode, pos, ret, &folio->page);
-	if (folio)
 		folio_put(folio);
+	}
 }
 
 static int iomap_write_begin_inline(const struct iomap_iter *iter,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0983dfc9a203..743e2a909162 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -131,13 +131,14 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
  * associated with them.
  *
  * When page_prepare succeeds, page_done will always be called to do any
- * cleanup work necessary.  In that page_done call, @page will be NULL if the
- * associated page could not be obtained.
+ * cleanup work necessary.  In that page_done call, @folio will be NULL if the
+ * associated folio could not be obtained.  When folio is not NULL, page_done
+ * is responsible for unlocking and putting the folio.
  */
 struct iomap_page_ops {
 	int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len);
 	void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
-			struct page *page);
+			struct folio *folio);
 
 	/*
 	 * Check that the cached iomap still maps correctly to the filesystem's
-- 
2.38.1

