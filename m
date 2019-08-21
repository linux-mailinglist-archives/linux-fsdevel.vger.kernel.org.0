Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2A1796E63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 02:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfHUAaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 20:30:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHUAay (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2gejrSoB2FzOwPwvIl0YMQL5/0v4jqvQgFkwdGSMLdY=; b=EYq9cp4l8H1rBuegeGWSpo3tV/
        b64BCrcV/5dPyOeSAJWKmjxUbIYGlM3/VUrUmNv2AcS7HW4NI30jeKHpIrvz2DbdH48AjTsO9Bch0
        X96PDpCP9O2c97OGZF0tkz3vZsdb7+/vgXSgyCY32JWsOIPikpz9ysGDYhERuourwZJrswEzY4/4s
        0znWy3av/2InYDoHUCu2BfvZR981QSw37FWWDVBJUAZxKPrq+llrq109lbA46BK21cobBmTh4YgeZ
        zRTqHwTik5u0XVUI6hDwDdb65uILwGg2fu1SokY/tbStjIUQVYNZkAmhkJJuO53T5SU6sm0QRPpKw
        kDN3fYlQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0EWQ-0003Hi-EJ; Wed, 21 Aug 2019 00:30:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 5/5] xfs: Pass a page to xfs_finish_page_writeback
Date:   Tue, 20 Aug 2019 17:30:39 -0700
Message-Id: <20190821003039.12555-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821003039.12555-1-willy@infradead.org>
References: <20190821003039.12555-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The only part of the bvec we were accessing was the bv_page, so just
pass that instead of the whole bvec.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/xfs/xfs_aops.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 1a26e9ca626b..edcb4797fcc2 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -58,21 +58,21 @@ xfs_find_daxdev_for_inode(
 static void
 xfs_finish_page_writeback(
 	struct inode		*inode,
-	struct bio_vec	*bvec,
+	struct page		*page,
 	int			error)
 {
-	struct iomap_page	*iop = to_iomap_page(bvec->bv_page);
+	struct iomap_page	*iop = to_iomap_page(page);
 
 	if (error) {
-		SetPageError(bvec->bv_page);
+		SetPageError(page);
 		mapping_set_error(inode->i_mapping, -EIO);
 	}
 
-	ASSERT(iop || i_blocks_per_page(inode, bvec->bv_page) <= 1);
+	ASSERT(iop || i_blocks_per_page(inode, page) <= 1);
 	ASSERT(!iop || atomic_read(&iop->write_count) > 0);
 
 	if (!iop || atomic_dec_and_test(&iop->write_count))
-		end_page_writeback(bvec->bv_page);
+		end_page_writeback(page);
 }
 
 /*
@@ -106,7 +106,7 @@ xfs_destroy_ioend(
 
 		/* walk each page on bio, ending page IO on them */
 		bio_for_each_segment_all(bvec, bio, iter_all)
-			xfs_finish_page_writeback(inode, bvec, error);
+			xfs_finish_page_writeback(inode, bvec->bv_page, error);
 		bio_put(bio);
 	}
 
-- 
2.23.0.rc1

