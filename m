Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEC864ED86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiLPPIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiLPPHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:07:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59392BC3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671203206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZgSNEk7ohWBknf3nvFSN56CDLafXV5s1mvKpkk+zzc=;
        b=YjhR7dWK/o62qSpJ4x2IPh/cHXop8lb4wxyjfVnO6fQeSxOLyM8+IiPGNdIyeYh7HPe4bh
        Dbur9dWqzEP5fiyTtwqGdBNLmZJoMDdeGmGuSZMaw75Ub4Cp6M3Es0ZGr1CC8nwsmqnavn
        bfeOV1s1Z0kzG2Gh/suhhDlqw7T7Yp0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-FlOPzOmuOOS6mhfGXN7I-w-1; Fri, 16 Dec 2022 10:06:40 -0500
X-MC-Unique: FlOPzOmuOOS6mhfGXN7I-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B27710119EB;
        Fri, 16 Dec 2022 15:06:40 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-182.brq.redhat.com [10.40.192.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE64C14171BE;
        Fri, 16 Dec 2022 15:06:37 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [RFC v3 4/7] iomap: Add iomap_folio_prepare helper
Date:   Fri, 16 Dec 2022 16:06:23 +0100
Message-Id: <20221216150626.670312-5-agruenba@redhat.com>
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

Add an iomap_folio_prepare() helper that gets a folio reference based on
an iomap iterator and an offset into the address space.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 27 +++++++++++++++++++++------
 include/linux/iomap.h  |  1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 517ad5380a62..f0f167ca1b2e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -457,6 +457,26 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 }
 EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 
+/**
+ * iomap_folio_prepare - get a folio reference for writing
+ * @iter: iteration structure
+ * @pos: start offset of write
+ *
+ * Returns a locked reference to the folio at @pos, or NULL if the folio could
+ * not be obtained.
+ */
+struct folio *iomap_folio_prepare(struct iomap_iter *iter, loff_t pos)
+{
+	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
+
+	if (iter->flags & IOMAP_NOWAIT)
+		fgp |= FGP_NOWAIT;
+
+	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
+			fgp, mapping_gfp_mask(iter->inode->i_mapping));
+}
+EXPORT_SYMBOL(iomap_folio_prepare);
+
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
 	trace_iomap_release_folio(folio->mapping->host, folio_pos(folio),
@@ -603,12 +623,8 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
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
@@ -625,8 +641,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 			return status;
 	}
 
-	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
-			fgp, mapping_gfp_mask(iter->inode->i_mapping));
+	folio = iomap_folio_prepare(iter, pos);
 	if (!folio) {
 		status = (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
 		iomap_folio_done(iter, pos, 0, NULL);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 743e2a909162..0bf16ef22d81 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -261,6 +261,7 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
+struct folio *iomap_folio_prepare(struct iomap_iter *iter, loff_t pos);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
-- 
2.38.1

