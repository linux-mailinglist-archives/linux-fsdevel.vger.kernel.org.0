Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6BF65A564
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 16:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiLaPLM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Dec 2022 10:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLaPLE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:11:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90961B85D
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Dec 2022 07:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672499382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UPIwcUbZUfu3w21+Fb54YjfLv2mmYWzObZnyM39KbhE=;
        b=i5BXq1uDkJDhje5ta7A5MuosyFC+rd7ZwahNhylKNwCyil9OnyMfFqanBaogfGcj3UZUyS
        TI9yq3owXdt2+qXJwVo2NFsKRmuigUlfaScs+bRcpYaEHVjoSVpBIWPMO//LgVzaGHnSv5
        xcAvv6Xi1YBITLmHFk0a+pqyIme5T3c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-QPYCuytsN6qi_6-tn3Vs8w-1; Sat, 31 Dec 2022 10:09:38 -0500
X-MC-Unique: QPYCuytsN6qi_6-tn3Vs8w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 504DA101A521;
        Sat, 31 Dec 2022 15:09:38 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-3.brq.redhat.com [10.40.192.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DBFF492B00;
        Sat, 31 Dec 2022 15:09:36 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [PATCH v5 4/9] iomap: Add iomap_get_folio helper
Date:   Sat, 31 Dec 2022 16:09:14 +0100
Message-Id: <20221231150919.659533-5-agruenba@redhat.com>
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

Add an iomap_get_folio() helper that gets a folio reference based on
an iomap iterator and an offset into the address space.  Use it in
iomap_write_begin().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 39 ++++++++++++++++++++++++++++++---------
 include/linux/iomap.h  |  1 +
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2a9bab4f3c79..b84838d2b5d8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -457,6 +457,33 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 }
 EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 
+/**
+ * iomap_get_folio - get a folio reference for writing
+ * @iter: iteration structure
+ * @pos: start offset of write
+ *
+ * Returns a locked reference to the folio at @pos, or an error pointer if the
+ * folio could not be obtained.
+ */
+struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
+{
+	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
+	struct folio *folio;
+
+	if (iter->flags & IOMAP_NOWAIT)
+		fgp |= FGP_NOWAIT;
+
+	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
+			fgp, mapping_gfp_mask(iter->inode->i_mapping));
+	if (folio)
+		return folio;
+
+	if (iter->flags & IOMAP_NOWAIT)
+		return ERR_PTR(-EAGAIN);
+	return ERR_PTR(-ENOMEM);
+}
+EXPORT_SYMBOL_GPL(iomap_get_folio);
+
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
 	trace_iomap_release_folio(folio->mapping->host, folio_pos(folio),
@@ -603,12 +630,8 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct folio *folio;
-	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
 	int status = 0;
 
-	if (iter->flags & IOMAP_NOWAIT)
-		fgp |= FGP_NOWAIT;
-
 	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
 	if (srcmap != &iter->iomap)
 		BUG_ON(pos + len > srcmap->offset + srcmap->length);
@@ -625,12 +648,10 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 			return status;
 	}
 
-	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
-			fgp, mapping_gfp_mask(iter->inode->i_mapping));
-	if (!folio) {
-		status = (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
+	folio = iomap_get_folio(iter, pos);
+	if (IS_ERR(folio)) {
 		iomap_put_folio(iter, pos, 0, NULL);
-		return status;
+		return PTR_ERR(folio);
 	}
 
 	/*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 10ec36f373f4..e5732cc5716b 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -261,6 +261,7 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
+struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
-- 
2.38.1

