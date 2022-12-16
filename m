Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E1264ED81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiLPPH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiLPPHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:07:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB76713DF6
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671203202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nz1ABIr9FX4nrBYSQ3w8yAlDY1zba1m15vCTBuzyx8=;
        b=Y3OqzWsRwbqGm2WbD9yi5wnkzkpa3a7ftP/m9oCYkQePiIBPHRWUWbmJzfv+4ygVev+4l/
        o6JmIRwzJahrL9YHPEtgRJEMYYcF46ai3GdpUs77aBbcv7TcXMIlBsMp7J2kpNCZ0FKqf+
        vS6PXsL0dOsnY8gORsaN0X2Inu/T288=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-oWHbi9_dOZOOPCoLKPZyzg-1; Fri, 16 Dec 2022 10:06:37 -0500
X-MC-Unique: oWHbi9_dOZOOPCoLKPZyzg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A83829AB3E9;
        Fri, 16 Dec 2022 15:06:37 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-182.brq.redhat.com [10.40.192.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 139B614171BE;
        Fri, 16 Dec 2022 15:06:34 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [RFC v3 3/7] iomap/gfs2: Unlock and put folio in page_done handler
Date:   Fri, 16 Dec 2022 16:06:22 +0100
Message-Id: <20221216150626.670312-4-agruenba@redhat.com>
In-Reply-To: <20221216150626.670312-1-agruenba@redhat.com>
References: <20221216150626.670312-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
after unlocking the folio, so writeback could start writing the folio's
buffers back before they could be marked for writing to the journal.
Also, try_to_free_buffers() could free the buffers before
gfs2_iomap_page_done() was done adding the buffers to the current
current transaction.  With this change, gfs2_iomap_page_done() can add
the buffers to the current transaction while the folio is still locked.
It can then unlock the folio and complete the current transaction.

(If we just moved the entire ->page_done() handler under the folio lock,
dirtying the inode could deadlock with the locked folio on filesystems
with a block size smaller than the page size.)

The only current user of ->page_done() is gfs2, so other filesystems are
not affected.  Still, to catch out any new users, switch from a page to
a folio in ->page_done().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c         | 15 ++++++++++++---
 fs/iomap/buffered-io.c |  8 ++++----
 include/linux/iomap.h  |  7 ++++---
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 3bdb2c668a71..11115fce68cb 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -971,14 +971,23 @@ static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
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
index 8ce9abb29d46..517ad5380a62 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -580,12 +580,12 @@ static void iomap_folio_done(struct iomap_iter *iter, loff_t pos, size_t ret,
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

