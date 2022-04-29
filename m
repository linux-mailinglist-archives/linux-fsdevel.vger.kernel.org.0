Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93EC5151FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379528AbiD2Ra0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379594AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81771A6230
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dsJD4hWlcYDmhUrlvN64XAtOIu0W3eZefceiArYxrO4=; b=SG49es2Ho6iIMmKSApoMWWHlff
        UgboG/I1Sf2Cftx5VHfIMfs336CnaoShLivGF3GnbQ5APZtmUpzpPLO0y78n6m6zUXqHB1nFldzEq
        ADAK70l62W7U8O1s59iXBKruYKm2zWvgfVZ7ZkIkLakSKwLhAQI44PLAxX8ViNM/hAZZeyDW0NpW+
        jlSpgfl3I2cwBjxNxQjHs8vyxR3grTvzNSFCYt2Ixha1m0UfO4MFnjUWfOQGCh5BrZgaqfaGjQGMP
        8NP01ppSqNMAHfjQSZiH10NkfTiGngemPpAV1ruQc1DL1J+UrnACi32f1O3lnkw+zr5C0pghdqgst
        IPzFTIDg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNc-00Cdc7-JS; Fri, 29 Apr 2022 17:26:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 52/69] freevxfs: Convert vxfs_immed to read_folio
Date:   Fri, 29 Apr 2022 18:25:39 +0100
Message-Id: <20220429172556.3011843-53-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a "weak" conversion which converts straight back to using pages.
A full conversion should be performed at some point, hopefully by
someone familiar with the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/freevxfs/vxfs_immed.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/freevxfs/vxfs_immed.c b/fs/freevxfs/vxfs_immed.c
index bfc780c682fb..a37431e443d3 100644
--- a/fs/freevxfs/vxfs_immed.c
+++ b/fs/freevxfs/vxfs_immed.c
@@ -38,33 +38,34 @@
 #include "vxfs_inode.h"
 
 
-static int	vxfs_immed_readpage(struct file *, struct page *);
+static int	vxfs_immed_read_folio(struct file *, struct folio *);
 
 /*
  * Address space operations for immed files and directories.
  */
 const struct address_space_operations vxfs_immed_aops = {
-	.readpage =		vxfs_immed_readpage,
+	.read_folio =		vxfs_immed_read_folio,
 };
 
 /**
- * vxfs_immed_readpage - read part of an immed inode into pagecache
+ * vxfs_immed_read_folio - read part of an immed inode into pagecache
  * @file:	file context (unused)
- * @page:	page frame to fill in.
+ * @folio:	folio to fill in.
  *
  * Description:
- *   vxfs_immed_readpage reads a part of the immed area of the
+ *   vxfs_immed_read_folio reads a part of the immed area of the
  *   file that hosts @pp into the pagecache.
  *
  * Returns:
  *   Zero on success, else a negative error code.
  *
  * Locking status:
- *   @page is locked and will be unlocked.
+ *   @folio is locked and will be unlocked.
  */
 static int
-vxfs_immed_readpage(struct file *fp, struct page *pp)
+vxfs_immed_read_folio(struct file *fp, struct folio *folio)
 {
+	struct page *pp = &folio->page;
 	struct vxfs_inode_info	*vip = VXFS_INO(pp->mapping->host);
 	u_int64_t	offset = (u_int64_t)pp->index << PAGE_SHIFT;
 	caddr_t		kaddr;
-- 
2.34.1

