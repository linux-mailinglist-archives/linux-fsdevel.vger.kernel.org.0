Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03451A6920
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfICM56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 08:57:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICM56 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PSTYlyBXilK+sPxSP7tKH0yj8EToaBl6N77rNfWHXOs=; b=ABM/HR/oXT1GwIOo3yevgSwTPN
        JMYj1101WazvjPP6pl4A0J4EHieZirvKzpCWC/ClWRWcmlHarnnPn5E8nHs/oCOXWBEM0xBTmlaLZ
        So4PCcSPpUWh6qkq7pIj/YvRiNa4powTxAzmkpyQ9xFXKEPVKMVUmxcDgsAg6risJy+zICVlw0uYO
        DHT2qStAUBUAqqlR3TnBKZiDlIXWNEwaaZtLePfAmL3j96b2ng1WbnI+p6euPr+eK5D6VsffEtyDO
        CBGbvPh0lcH8uXgy/jZMqJaDiq3d74d/798PBwpHizxph9NCH/I/tm+Zd0I/XIAEnaMZSm42rwRET
        lyPENdSA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i58Nh-0002CX-LM; Tue, 03 Sep 2019 12:57:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH 5/5] iomap: move struct iomap_page out of iomap.h
Date:   Tue,  3 Sep 2019 14:57:43 +0200
Message-Id: <20190903125743.2970-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903125743.2970-1-hch@lst.de>
References: <20190903125743.2970-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all the writepage code is in the iomap code there is no
need to keep this structure public.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 17 +++++++++++++++++
 include/linux/iomap.h  | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 051b8ec326ba..4ab1ec0a282f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -23,6 +23,23 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/iomap.h>
 
+/*
+ * Structure allocated for each page when block size < PAGE_SIZE to track
+ * sub-page uptodate status and I/O completions.
+ */
+struct iomap_page {
+	atomic_t		read_count;
+	atomic_t		write_count;
+	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
+};
+
+static inline struct iomap_page *to_iomap_page(struct page *page)
+{
+	if (page_has_private(page))
+		return (struct iomap_page *)page_private(page);
+	return NULL;
+}
+
 static struct bio_set iomap_ioend_bioset;
 
 static struct iomap_page *
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e79af6b28410..5d736d3caf08 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -134,23 +134,6 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
 		unsigned flags, const struct iomap_ops *ops, void *data,
 		iomap_actor_t actor);
 
-/*
- * Structure allocate for each page when block size < PAGE_SIZE to track
- * sub-page uptodate status and I/O completions.
- */
-struct iomap_page {
-	atomic_t		read_count;
-	atomic_t		write_count;
-	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
-};
-
-static inline struct iomap_page *to_iomap_page(struct page *page)
-{
-	if (page_has_private(page))
-		return (struct iomap_page *)page_private(page);
-	return NULL;
-}
-
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
-- 
2.20.1

