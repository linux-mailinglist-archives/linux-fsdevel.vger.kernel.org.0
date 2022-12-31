Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ADC65A56D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 16:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiLaPLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Dec 2022 10:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiLaPLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:11:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC11CE2B
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Dec 2022 07:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672499390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+kXihu6wtIVaRcBs4N4yPc1MOjQQ5BVEsp96+a6Kzg=;
        b=FV9Qynaensc+2T4DnD5QSFTUBsMhLflSPFz3yv+N72pVeDZVvojQHbUQQWAgBHLAkO3nwH
        fRU+PFKGzKes3v1ZhGNeza2x5EN5yGF1Jt0qniY5UJYDvCWmUMN3VsBW+FZh8V3DW1WygG
        ZttBDK5Xm+7NYmZKMK+OFdH8StthNdw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-T0pnY96VPEipP16fyHZWQQ-1; Sat, 31 Dec 2022 10:09:46 -0500
X-MC-Unique: T0pnY96VPEipP16fyHZWQQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01113185A78B;
        Sat, 31 Dec 2022 15:09:46 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-3.brq.redhat.com [10.40.192.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA5D1492B00;
        Sat, 31 Dec 2022 15:09:43 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [PATCH v5 7/9] iomap/xfs: Eliminate the iomap_valid handler
Date:   Sat, 31 Dec 2022 16:09:17 +0100
Message-Id: <20221231150919.659533-8-agruenba@redhat.com>
In-Reply-To: <20221231150919.659533-1-agruenba@redhat.com>
References: <20221231150919.659533-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eliminate the ->iomap_valid() handler by switching to a ->get_folio()
handler and validating the mapping there.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 25 +++++--------------------
 fs/xfs/xfs_iomap.c     | 37 ++++++++++++++++++++++++++-----------
 include/linux/iomap.h  | 22 +++++-----------------
 3 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4f363d42dbaf..df6fca11f18c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -630,7 +630,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct folio *folio;
-	int status = 0;
+	int status;
 
 	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
 	if (srcmap != &iter->iomap)
@@ -646,27 +646,12 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 		folio = page_ops->get_folio(iter, pos, len);
 	else
 		folio = iomap_get_folio(iter, pos);
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
-
-	/*
-	 * Now we have a locked folio, before we do anything with it we need to
-	 * check that the iomap we have cached is not stale. The inode extent
-	 * mapping can change due to concurrent IO in flight (e.g.
-	 * IOMAP_UNWRITTEN state can change and memory reclaim could have
-	 * reclaimed a previously partially written page at this index after IO
-	 * completion before this write reaches this file offset) and hence we
-	 * could do the wrong thing here (zero a page range incorrectly or fail
-	 * to zero) and corrupt data.
-	 */
-	if (page_ops && page_ops->iomap_valid) {
-		bool iomap_valid = page_ops->iomap_valid(iter->inode,
-							&iter->iomap);
-		if (!iomap_valid) {
+	if (IS_ERR(folio)) {
+		if (folio == ERR_PTR(-ESTALE)) {
 			iter->iomap.flags |= IOMAP_F_STALE;
-			status = 0;
-			goto out_unlock;
+			return 0;
 		}
+		return PTR_ERR(folio);
 	}
 
 	if (pos + len > folio_pos(folio) + folio_size(folio))
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 669c1bc5c3a7..d0bf99539180 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -62,29 +62,44 @@ xfs_iomap_inode_sequence(
 	return cookie | READ_ONCE(ip->i_df.if_seq);
 }
 
-/*
- * Check that the iomap passed to us is still valid for the given offset and
- * length.
- */
-static bool
-xfs_iomap_valid(
-	struct inode		*inode,
-	const struct iomap	*iomap)
+static struct folio *
+xfs_get_folio(
+	struct iomap_iter	*iter,
+	loff_t			pos,
+	unsigned		len)
 {
+	struct inode		*inode = iter->inode;
+	struct iomap		*iomap = &iter->iomap;
 	struct xfs_inode	*ip = XFS_I(inode);
+	struct folio		*folio;
 
+	folio = iomap_get_folio(iter, pos);
+	if (IS_ERR(folio))
+		return folio;
+
+	/*
+	 * Now that we have a locked folio, we need to check that the iomap we
+	 * have cached is not stale.  The inode extent mapping can change due to
+	 * concurrent IO in flight (e.g., IOMAP_UNWRITTEN state can change and
+	 * memory reclaim could have reclaimed a previously partially written
+	 * page at this index after IO completion before this write reaches
+	 * this file offset) and hence we could do the wrong thing here (zero a
+	 * page range incorrectly or fail to zero) and corrupt data.
+	 */
 	if (iomap->validity_cookie !=
 			xfs_iomap_inode_sequence(ip, iomap->flags)) {
 		trace_xfs_iomap_invalid(ip, iomap);
-		return false;
+		folio_unlock(folio);
+		folio_put(folio);
+		return ERR_PTR(-ESTALE);
 	}
 
 	XFS_ERRORTAG_DELAY(ip->i_mount, XFS_ERRTAG_WRITE_DELAY_MS);
-	return true;
+	return folio;
 }
 
 const struct iomap_page_ops xfs_iomap_page_ops = {
-	.iomap_valid		= xfs_iomap_valid,
+	.get_folio		= xfs_get_folio,
 };
 
 int
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index dd3575ada5d1..6f8e3321e475 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -134,29 +134,17 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
  * When get_folio succeeds, put_folio will always be called to do any
  * cleanup work necessary.  put_folio is responsible for unlocking and putting
  * @folio.
+ *
+ * When an iomap is created, the filesystem can store internal state (e.g., a
+ * sequence number) in iomap->validity_cookie.  When it then detects in the
+ * get_folio handler that the iomap is no longer up to date and needs to be
+ * refreshed, it can return ERR_PTR(-ESTALE) to trigger a retry.
  */
 struct iomap_page_ops {
 	struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
 			unsigned len);
 	void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
 			struct folio *folio);
-
-	/*
-	 * Check that the cached iomap still maps correctly to the filesystem's
-	 * internal extent map. FS internal extent maps can change while iomap
-	 * is iterating a cached iomap, so this hook allows iomap to detect that
-	 * the iomap needs to be refreshed during a long running write
-	 * operation.
-	 *
-	 * The filesystem can store internal state (e.g. a sequence number) in
-	 * iomap->validity_cookie when the iomap is first mapped to be able to
-	 * detect changes between mapping time and whenever .iomap_valid() is
-	 * called.
-	 *
-	 * This is called with the folio over the specified file position held
-	 * locked by the iomap code.
-	 */
-	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
 };
 
 /*
-- 
2.38.1

