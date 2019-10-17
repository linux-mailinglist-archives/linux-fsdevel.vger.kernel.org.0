Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFCB7DB52A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 19:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395064AbfJQR5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 13:57:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395052AbfJQR5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3LCOvHhI1d2tI4XsgInbF6NgLTLi4GG5UiaMnE6QtZI=; b=IlnWhkZTRq141ZKHGylpzx4uEw
        41ikMuzBreVnZmX4G9M/2PR8rVG1dGVCUlNbv9D94o047Pex+ZRuKVj0+SdkP4iuK9x2BiNuCV1Iz
        KQWgXbBq/L7WrlOISqYG1jfChOSa6+HevJ6a/jtC7bbcBxa90qYBuJsPjWo44J4OKZrl6g24VHx3K
        164ph0/MLXogU7vueFglU6XURZBdrqA9SfYqVvA6tdbbGU7z6FjQtbOY2UK9g9ILRN1c534RaOp/8
        JZ27i4otJc0Q21XyaqUAc6J6pHw/s/875jzfkG0VrV/mpoD7u6XKxTdDsjssApXWBUOIzr4NVulG6
        c67evKuA==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLA1F-0001Nk-3c; Thu, 17 Oct 2019 17:57:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH 12/14] iomap: move struct iomap_page out of iomap.h
Date:   Thu, 17 Oct 2019 19:56:22 +0200
Message-Id: <20191017175624.30305-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017175624.30305-1-hch@lst.de>
References: <20191017175624.30305-1-hch@lst.de>
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
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 17 +++++++++++++++++
 include/linux/iomap.h  | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7b83a7ba2edb..f8ff96124a86 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -21,6 +21,23 @@
 
 #include "../internal.h"
 
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
index 71fd12ee5616..8611f8bf2878 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -136,23 +136,6 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
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

