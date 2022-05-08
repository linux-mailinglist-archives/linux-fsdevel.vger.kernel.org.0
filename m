Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8CA51F182
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiEHUh6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiEHUgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95BF11C30
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PMMIY1mb/2n+3vsiM/WTtPsT5GkWTXl63X+m32Exuao=; b=HLZQYTUKXJc55oOcFURKps5jRN
        a1z53Znr5EhbUpMg5jhdg6O/yuv3YndwdSHqs9t5j6uDm1r4x0tWBBWSM0lzIUC0DPKvUEK3rpwC4
        rGEnRxLy6d+g3Mx2uVj18UWv9UN177ZAD6CEJbjdLw93KLhyRjEPvcVMuy8h5Ol0reDleRveKtRmB
        67aS/hXyCq2FZpLR1Od5Bi3GvFXSV97iVhepDHNcxTGBFFui9kdGOghFN8BN2pe53LkXKRI0FqsuX
        1D+jLS6I4VtwCHFN/lIe0hIZN3+7AGm+ghIhgqyH3QPXVK3dO8V2voPzq1Serf9ol8quzo85ofWlr
        P0KzgyUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaE-002o26-Vg; Sun, 08 May 2022 20:32:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 17/26] ocfs2: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:38 +0100
Message-Id: <20220508203247.668791-18-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203247.668791-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use folios throughout the release_folio path.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ocfs2/aops.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 6b1679db9636..7d7b86ca078f 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -498,11 +498,11 @@ static sector_t ocfs2_bmap(struct address_space *mapping, sector_t block)
 	return status;
 }
 
-static int ocfs2_releasepage(struct page *page, gfp_t wait)
+static bool ocfs2_release_folio(struct folio *folio, gfp_t wait)
 {
-	if (!page_has_buffers(page))
-		return 0;
-	return try_to_free_buffers(page);
+	if (!folio_buffers(folio))
+		return false;
+	return try_to_free_buffers(&folio->page);
 }
 
 static void ocfs2_figure_cluster_boundaries(struct ocfs2_super *osb,
@@ -2463,7 +2463,7 @@ const struct address_space_operations ocfs2_aops = {
 	.bmap			= ocfs2_bmap,
 	.direct_IO		= ocfs2_direct_IO,
 	.invalidate_folio	= block_invalidate_folio,
-	.releasepage		= ocfs2_releasepage,
+	.release_folio		= ocfs2_release_folio,
 	.migratepage		= buffer_migrate_page,
 	.is_partially_uptodate	= block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
-- 
2.34.1

