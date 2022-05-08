Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DE151F165
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiEHUgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiEHUff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE40710C6
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dsJD4hWlcYDmhUrlvN64XAtOIu0W3eZefceiArYxrO4=; b=F6IUWUrU//XYMD0g86UhVmMTZU
        8HxhhpTi+GZtKPm3hkupsGyF0h3pwT5EdwWAEtqTExszitdENJULQLhUyDT8s8QL0dUYNhJRx2xF+
        xZ0LqRZN3l+3yk9uZzwMniMpgvC7ql/X6tR6ca8zXlhoYCLQ5P16jqbI8Fbfl8fron9281koVisEl
        A4jHm2A5FTEI5BEM5VnGG14dl8330MbKOPk1eNK8Fj51xTYUGYMQZEr+h+kEz0mo2ZeAiFgvCOIkl
        FKIIWSxUbBbUOKTizXouxJRrxx6o/+n/MpPWZpo8/m1jmagYNShIA9EKXgh5OfN6qow1NDl+hbOKU
        Uod7Jhzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ5-002noi-ED; Sun, 08 May 2022 20:31:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 20/37] freevxfs: Convert vxfs_immed to read_folio
Date:   Sun,  8 May 2022 21:31:14 +0100
Message-Id: <20220508203131.667959-21-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
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

