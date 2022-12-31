Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D77765A560
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 16:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbiLaPLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Dec 2022 10:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLaPLE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:11:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57708CE06
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Dec 2022 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672499387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BNcpLuaoMj/aSn3yA96m/tYCTKBmskvk8TA/HV70IVE=;
        b=Nw6KcwBHzR9EfW4C2G13s7Fedz9CAN7VnrU08nK5Y/+CoJq/Ai76wi5GP3WXulPlUwkWEY
        dEPmgI0EJXE/7xkAUq83m+ReSVy9mrVpkbLz8b9vmV2/rK6x66srgY1jURAcpHqh2b5qzr
        YJ/LkiqzfollGqpgH4s/h2yGjm1Hjts=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-oLIIdSz0PGGbZyTDUGAgbQ-1; Sat, 31 Dec 2022 10:09:43 -0500
X-MC-Unique: oLIIdSz0PGGbZyTDUGAgbQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69FDF811E6E;
        Sat, 31 Dec 2022 15:09:43 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-3.brq.redhat.com [10.40.192.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 251E7492B00;
        Sat, 31 Dec 2022 15:09:40 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [PATCH v5 6/9] iomap: Rename page_prepare handler to get_folio
Date:   Sat, 31 Dec 2022 16:09:16 +0100
Message-Id: <20221231150919.659533-7-agruenba@redhat.com>
In-Reply-To: <20221231150919.659533-1-agruenba@redhat.com>
References: <20221231150919.659533-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ->page_prepare() handler in struct iomap_page_ops is now somewhat
misnamed, so rename it to ->get_folio().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c         | 6 +++---
 fs/iomap/buffered-io.c | 4 ++--
 include/linux/iomap.h  | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 41349e09558b..d3adb715ac8c 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -957,7 +957,7 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 }
 
 static struct folio *
-gfs2_iomap_page_prepare(struct iomap_iter *iter, loff_t pos, unsigned len)
+gfs2_iomap_get_folio(struct iomap_iter *iter, loff_t pos, unsigned len)
 {
 	struct inode *inode = iter->inode;
 	unsigned int blockmask = i_blocksize(inode) - 1;
@@ -998,7 +998,7 @@ static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
 }
 
 static const struct iomap_page_ops gfs2_iomap_page_ops = {
-	.page_prepare = gfs2_iomap_page_prepare,
+	.get_folio = gfs2_iomap_get_folio,
 	.put_folio = gfs2_iomap_put_folio,
 };
 
@@ -1291,7 +1291,7 @@ int gfs2_alloc_extent(struct inode *inode, u64 lblock, u64 *dblock,
 /*
  * NOTE: Never call gfs2_block_zero_range with an open transaction because it
  * uses iomap write to perform its actions, which begin their own transactions
- * (iomap_begin, page_prepare, etc.)
+ * (iomap_begin, get_folio, etc.)
  */
 static int gfs2_block_zero_range(struct inode *inode, loff_t from,
 				 unsigned int length)
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7decd8cdc755..4f363d42dbaf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -642,8 +642,8 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	if (!mapping_large_folio_support(iter->inode->i_mapping))
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
-	if (page_ops && page_ops->page_prepare)
-		folio = page_ops->page_prepare(iter, pos, len);
+	if (page_ops && page_ops->get_folio)
+		folio = page_ops->get_folio(iter, pos, len);
 	else
 		folio = iomap_get_folio(iter, pos);
 	if (IS_ERR(folio))
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 87b5d0f8e578..dd3575ada5d1 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -126,17 +126,17 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
 }
 
 /*
- * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
+ * When a filesystem sets page_ops in an iomap mapping it returns, get_folio
  * and put_folio will be called for each page written to.  This only applies to
  * buffered writes as unbuffered writes will not typically have pages
  * associated with them.
  *
- * When page_prepare succeeds, put_folio will always be called to do any
+ * When get_folio succeeds, put_folio will always be called to do any
  * cleanup work necessary.  put_folio is responsible for unlocking and putting
  * @folio.
  */
 struct iomap_page_ops {
-	struct folio *(*page_prepare)(struct iomap_iter *iter, loff_t pos,
+	struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
 			unsigned len);
 	void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
 			struct folio *folio);
-- 
2.38.1

