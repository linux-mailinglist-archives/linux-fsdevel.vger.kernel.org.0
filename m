Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7B3BD5E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 02:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411276AbfIYAwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 20:52:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411271AbfIYAwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NExg9D+3Wa1fP9cAWyjnC7ZkvWAvXtW4PTf8NgFY27g=; b=suSAuWrP7cezUqpexhdh3X0z5y
        6NfZdi50ztEisvpucYDUd8qslBQOK3CD6GRgm+x6K58lGz0PeZGxnmTHEX8GjdeiMReZOwB2tUvRD
        Ew63ydItKTG+uFzaJHLbLjIMuwD9cRlJ2fySGe4+u4RjeUxIxuIxu+LI3ShyZHjB+GomS6ZVduzGK
        xJ69gFGUxCtMNnt08HEHqOvKbSH+2Moaf/jZfQ0e5ELf6Uxce85lsSaTXOrXsXyL/zyOnAAOt4juK
        8vWodAioL6Ilx6s4i1jwAgrpZNaiqjOyGbD4+EeQcPerWqpglu+A04YHWqDz0duVCXYxNzdQK6PJ+
        VhX6mFDw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCvXV-00076b-Fc; Wed, 25 Sep 2019 00:52:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 06/15] xfs: Pass a page to xfs_finish_page_writeback
Date:   Tue, 24 Sep 2019 17:52:05 -0700
Message-Id: <20190925005214.27240-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925005214.27240-1-willy@infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
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
2.23.0

