Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEAF730FC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244132AbjFOGuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 02:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244491AbjFOGtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:49:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F2B3591;
        Wed, 14 Jun 2023 23:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9oEpfo7m9i9PNsVkWJYbrLv9mQHmCpeKhrScjOt6KZw=; b=xkSCTO6OWqGqmfw8kNEEZUtw7Y
        akByH5+jvKu/RXRw6vZXgeDEStVpf2X0BBQXKc5yVLKyyXC1VsVxN2+LKfocZiohO5MHziPCBKJxg
        9dyryI2WZbyuTaAIZivK+z3odQaFaFTXjb+4RzGs3KDoPGdRL/zIyian0LUlSezMS0mzOS2dU2+e8
        tT0vIocQUcHvzVi53fF7iltsRpupt+6kseprcYtNF+3AFFcrjmOA/vq6z/XvWO8JBsKK9iXoYocWp
        GXPMLHkJqMzZ40qfVIt/4pAMgCHbQvEcHCTw2rC+jYWc6Fb8bWbanjadtpWq9lBcmrtk3W6M7kaf9
        L7ruT9IQ==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9gmm-00Du9P-13;
        Thu, 15 Jun 2023 06:48:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/11] md-bitmap: initialize variables at declaration time in md_bitmap_file_unmap
Date:   Thu, 15 Jun 2023 08:48:31 +0200
Message-Id: <20230615064840.629492-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615064840.629492-1-hch@lst.de>
References: <20230615064840.629492-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just a small tidyup to prepare for bigger changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-bitmap.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index d8469720fac23f..0b2d8933cbc75e 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -842,14 +842,10 @@ static int md_bitmap_storage_alloc(struct bitmap_storage *store,
 
 static void md_bitmap_file_unmap(struct bitmap_storage *store)
 {
-	struct page **map, *sb_page;
-	int pages;
-	struct file *file;
-
-	file = store->file;
-	map = store->filemap;
-	pages = store->file_pages;
-	sb_page = store->sb_page;
+	struct file *file = store->file;
+	struct page *sb_page = store->sb_page;
+	struct page **map = store->filemap;
+	int pages = store->file_pages;
 
 	while (pages--)
 		if (map[pages] != sb_page) /* 0 is sb_page, release it below */
-- 
2.39.2

