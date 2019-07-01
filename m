Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 194A55C553
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 23:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfGAV4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 17:56:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44796 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAV4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1cM8rtVZcUoMG4FfS5hdRNZT/XeV1Ea4OU7AC3QMrYU=; b=f9wVcCEpxvf4GeNSmzSE4k8bb5
        Zt1mxrYK5Dym7kFxR3L+LPg8z33ZMkEMLGAE8sTcWS1w7F8gM3kT/+hE8r15zfmroeOA50T3k4A/5
        6P0UoMyJEn5wMc+VMkqtgCUqoUF2F8+5f6FYZ3SmnmeczZr1eETt6a4IDVryFc/FiIcZwuWi6pc0Z
        CYwpe4RY+WoHFEASJuEaLLd4CVMgP/uuZ16qYbOQIE2kcCNf1Sx9vuEGBsf0mk/nHhrHBNS4q+YhX
        nUhF7l6Wz2nJoUSQhIcbDu15YMpOPs9K9e1ieMPEcKHey9sMyHVfgQwoPNMYX2jd+sTEQmw1h2k3h
        utlogaNQ==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi4HL-0001rw-DX; Mon, 01 Jul 2019 21:56:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: [PATCH 10/15] gfs2: merge gfs2_writepage_common into gfs2_writepage
Date:   Mon,  1 Jul 2019 23:54:34 +0200
Message-Id: <20190701215439.19162-11-hch@lst.de>
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

No need to keep these two functions separate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/aops.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 3b3043332e5a..d78b5778fca7 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -82,15 +82,11 @@ static int gfs2_get_block_noalloc(struct inode *inode, sector_t lblock,
 }
 
 /**
- * gfs2_writepage_common - Common bits of writepage
- * @page: The page to be written
+ * gfs2_writepage - Write page for writeback mappings
+ * @page: The page
  * @wbc: The writeback control
- *
- * Returns: 1 if writepage is ok, otherwise an error code or zero if no error.
  */
-
-static int gfs2_writepage_common(struct page *page,
-				 struct writeback_control *wbc)
+static int gfs2_writepage(struct page *page, struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
@@ -109,7 +105,9 @@ static int gfs2_writepage_common(struct page *page,
 		page->mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
 		goto out;
 	}
-	return 1;
+
+	return nobh_writepage(page, gfs2_get_block_noalloc, wbc);
+
 redirty:
 	redirty_page_for_writepage(wbc, page);
 out:
@@ -117,24 +115,6 @@ static int gfs2_writepage_common(struct page *page,
 	return 0;
 }
 
-/**
- * gfs2_writepage - Write page for writeback mappings
- * @page: The page
- * @wbc: The writeback control
- *
- */
-
-static int gfs2_writepage(struct page *page, struct writeback_control *wbc)
-{
-	int ret;
-
-	ret = gfs2_writepage_common(page, wbc);
-	if (ret <= 0)
-		return ret;
-
-	return nobh_writepage(page, gfs2_get_block_noalloc, wbc);
-}
-
 /* This is the same as calling block_write_full_page, but it also
  * writes pages outside of i_size
  */
-- 
2.20.1

