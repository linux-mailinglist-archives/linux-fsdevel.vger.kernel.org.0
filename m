Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C58B6618C7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 20:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjAHTnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 14:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjAHTnH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:43:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7786DF24
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 11:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673206866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHGmm+6pyhfRGaoS1tmIeM5ClqKPuUJWD5zTFMeTau0=;
        b=MHYo8a0QMIad+hT8+/DFaOg28ZED93/VwR/Blj/9eK6CI5H0A7+cVNC+T7vUeV8TnI42tH
        irqYGDrNhZ45ILlF5IDwAkKVNNl9CtnIPPKNo3RJ95vpZ+zZklP9z3/t/jkEaBMK4H6uPc
        VG3BIjeX0zNQ3tDbX7MeT3DEWDioNzE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-KEJkthAlMJaUugpo3cwnOQ-1; Sun, 08 Jan 2023 14:41:01 -0500
X-MC-Unique: KEJkthAlMJaUugpo3cwnOQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CF073806077;
        Sun,  8 Jan 2023 19:41:01 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-3.brq.redhat.com [10.40.192.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC023492B06;
        Sun,  8 Jan 2023 19:40:58 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [RFC v6 08/10] iomap/xfs: Eliminate the iomap_valid handler
Date:   Sun,  8 Jan 2023 20:40:32 +0100
Message-Id: <20230108194034.1444764-9-agruenba@redhat.com>
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

Eliminate the ->iomap_valid() handler by switching to a ->get_folio()
handler and validating the mapping there.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 26 +++++---------------------
 fs/xfs/xfs_iomap.c     | 37 ++++++++++++++++++++++++++-----------
 include/linux/iomap.h  | 23 ++++++-----------------
 3 files changed, 37 insertions(+), 49 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 006ddf933948..72dfbc3cb086 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -638,10 +638,9 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
 static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 		size_t len, struct folio **foliop)
 {
-	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct folio *folio;
-	int status = 0;
+	int status;
 
 	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
 	if (srcmap != &iter->iomap)
@@ -654,27 +653,12 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
 	folio = __iomap_get_folio(iter, pos, len);
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
index da226032aedc..0ae2cddbedd6 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -134,29 +134,18 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
  * When get_folio succeeds, put_folio will always be called to do any
  * cleanup work necessary.  put_folio is responsible for unlocking and putting
  * @folio.
+ *
+ * When an iomap is created, the filesystem can store internal state (e.g., a
+ * sequence number) in iomap->validity_cookie.  The get_folio handler can use
+ * this validity cookie to detect when the iomap needs to be refreshed because
+ * it is no longer up to date.  In that case, the function should return
+ * ERR_PTR(-ESTALE) to retry the operation with a fresh mapping.
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

