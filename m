Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D409364ED8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiLPPI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiLPPHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:07:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29D464D0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671203212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hx1hr3zVnpxfjUoh5oVvuyRaT+eEP0rAMA6HZN8X1gk=;
        b=Sbjq458Bho/9IccRb8LtqFiDVQkF5xzIAnXfyGxGNlomyZ8v6ppYG0SSXjZn9JFdgbyomT
        6vVksRwXaBHNu0guv7l3AH44Hq0ibDKiWjjw0Y5X0lah/0AYBE46Vn7AGjUOAca5ffCa3M
        F386as0ZcHUjiA/Jd2+h2zepPZPvI6o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-u8Rdga8HO_uSQuxF1_tiZw-1; Fri, 16 Dec 2022 10:06:46 -0500
X-MC-Unique: u8Rdga8HO_uSQuxF1_tiZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 370033C10ED8;
        Fri, 16 Dec 2022 15:06:45 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-182.brq.redhat.com [10.40.192.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 181A314171BE;
        Fri, 16 Dec 2022 15:06:42 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [RFC v3 6/7] iomap/xfs: Eliminate the iomap_valid handler
Date:   Fri, 16 Dec 2022 16:06:25 +0100
Message-Id: <20221216150626.670312-7-agruenba@redhat.com>
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

Eliminate the ->iomap_valid() handler by switching to a ->page_prepare()
handler and validating the mapping there.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 24 ++++--------------------
 fs/xfs/xfs_iomap.c     | 38 +++++++++++++++++++++++++++-----------
 include/linux/iomap.h  | 17 -----------------
 3 files changed, 31 insertions(+), 48 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6b7c1a10b8ec..b73ff317da21 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -623,7 +623,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct folio *folio;
-	int status = 0;
+	int status;
 
 	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
 	if (srcmap != &iter->iomap)
@@ -642,27 +642,11 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	if (IS_ERR_OR_NULL(folio)) {
 		if (!folio)
 			return (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
-		return PTR_ERR(folio);
-	}
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
index 669c1bc5c3a7..2248ce7be2e3 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -62,29 +62,45 @@ xfs_iomap_inode_sequence(
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
+xfs_page_prepare(
+	struct iomap_iter	*iter,
+	loff_t			pos,
+	unsigned		len)
 {
+	struct inode		*inode = iter->inode;
+	struct iomap		*iomap = &iter->iomap;
 	struct xfs_inode	*ip = XFS_I(inode);
+	struct folio *folio;
 
+	folio = iomap_folio_prepare(iter, pos);
+	if (!folio)
+		return NULL;
+
+	/*
+	 * Now we have a locked folio, before we do anything with it we need to
+	 * check that the iomap we have cached is not stale. The inode extent
+	 * mapping can change due to concurrent IO in flight (e.g.
+	 * IOMAP_UNWRITTEN state can change and memory reclaim could have
+	 * reclaimed a previously partially written page at this index after IO
+	 * completion before this write reaches this file offset) and hence we
+	 * could do the wrong thing here (zero a page range incorrectly or fail
+	 * to zero) and corrupt data.
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
+	.page_prepare		= xfs_page_prepare,
 };
 
 int
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index c74ab8c53b47..1c8b9a04b0bb 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -140,23 +140,6 @@ struct iomap_page_ops {
 			unsigned len);
 	void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
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

