Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16A795C543
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 23:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfGAVz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 17:55:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAVz3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HCoBRtk6j/eJ7O5EawSmP/iZjeG31+uCVxDvJ1dafp4=; b=KvUvdz3of6j6msfddXssK+56xR
        j07AtR0zn58bFNvQpUuXz6GUllEC5PREN4B6cjBXUxM7diU3MA+PJn+xZ/hFGw40PnBVVoINeXh/J
        8WdU0XWuzzHxJawlvMY53WMmVQ3//UK6cSMs3i0gmPzjn5SQ6az3hq6/3SzbFO3e7oAtKZfORBbhI
        UMtyc+Ep4YI7FcgOQHVp3dxo3muzgiufIIOudO0pUgK3EdAqHg8fDHdwT4VDmiIy9x6ae1rF9MHUi
        UfyYnom+Ox4y8qJeDOi8YwoRlF82yQcAsmWvwMbHGSvG2DliwqwLNqqMteztYm9C5XMQ4YfNca7Ll
        of1nXzFw==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi4Gj-0001ln-K5; Mon, 01 Jul 2019 21:55:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: [PATCH 05/15] iomap: move struct iomap_page to iomap.c
Date:   Mon,  1 Jul 2019 23:54:29 +0200
Message-Id: <20190701215439.19162-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701215439.19162-1-hch@lst.de>
References: <20190701215439.19162-1-hch@lst.de>
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
---
 fs/iomap.c            | 17 +++++++++++++++++
 include/linux/iomap.h | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index ea5b8e7c8903..63952a7b1c05 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -100,6 +100,23 @@ iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
 
+/*
+ * Structure allocate for each page when block size < PAGE_SIZE to track
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
 static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f9fb716e60ab..a5f0565210a0 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -117,23 +117,6 @@ struct iomap_ops {
 			ssize_t written, unsigned flags, struct iomap *iomap);
 };
 
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

