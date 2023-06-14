Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB0772FD4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 13:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbjFNLrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 07:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFNLrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:47:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E576810F7;
        Wed, 14 Jun 2023 04:46:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9D4951FDED;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686743217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HqgE0FoAJNGu3N9ldwgXXKWng+6fcILJBM9HxWu5/NM=;
        b=XIORnNdJrvGEKeB2679tyIGGbsGA6aRreLcugpVv3sg62nALqkZYkJYvIm6YUHEukI2EIj
        f/TA8v5NejynDwmXXWOp7RdmPFjRzr4pzi7ZkIcLnwLt5FDXeRSalpRiNwGkf/fx6R27Xo
        CQkoT/X4KqzxC1nf0aiLAg6AXVYEMzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686743217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HqgE0FoAJNGu3N9ldwgXXKWng+6fcILJBM9HxWu5/NM=;
        b=E5RJpF3gL1iygNwm8tgdEVR9oSKr1G01Fvtut4qtEtAg95627X2HroAfPDGDIW7yqUeyVz
        CTZwvWSz93eCtnAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 8BF2F2C145;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 808DC51C4E0F; Wed, 14 Jun 2023 13:46:57 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/7] brd: abstract page_size conventions
Date:   Wed, 14 Jun 2023 13:46:33 +0200
Message-Id: <20230614114637.89759-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230614114637.89759-1-hare@suse.de>
References: <20230614114637.89759-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for changing the block sizes abstract away references
to PAGE_SIZE and friends.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/brd.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 24769d010fee..71d3d8af8b0d 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -45,6 +45,23 @@ struct brd_device {
 	u64			brd_nr_folios;
 };
 
+#define BRD_SECTOR_SHIFT(b) (PAGE_SHIFT - SECTOR_SHIFT)
+
+static pgoff_t brd_sector_index(struct brd_device *brd, sector_t sector)
+{
+	pgoff_t idx;
+
+	idx = sector >> BRD_SECTOR_SHIFT(brd);
+	return idx;
+}
+
+static int brd_sector_offset(struct brd_device *brd, sector_t sector)
+{
+	unsigned int rd_sector_mask = (1 << BRD_SECTOR_SHIFT(brd)) - 1;
+
+	return ((unsigned int)sector & rd_sector_mask) << SECTOR_SHIFT;
+}
+
 /*
  * Look up and return a brd's folio for a given sector.
  */
@@ -53,7 +70,7 @@ static struct folio *brd_lookup_folio(struct brd_device *brd, sector_t sector)
 	pgoff_t idx;
 	struct folio *folio;
 
-	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to folio index */
+	idx = brd_sector_index(brd, sector); /* sector to folio index */
 	folio = xa_load(&brd->brd_folios, idx);
 
 	BUG_ON(folio && folio->index != idx);
@@ -68,19 +85,20 @@ static int brd_insert_folio(struct brd_device *brd, sector_t sector, gfp_t gfp)
 {
 	pgoff_t idx;
 	struct folio *folio, *cur;
+	unsigned int rd_sector_order = get_order(PAGE_SIZE);
 	int ret = 0;
 
 	folio = brd_lookup_folio(brd, sector);
 	if (folio)
 		return 0;
 
-	folio = folio_alloc(gfp | __GFP_ZERO | __GFP_HIGHMEM, 0);
+	folio = folio_alloc(gfp | __GFP_ZERO | __GFP_HIGHMEM, rd_sector_order);
 	if (!folio)
 		return -ENOMEM;
 
 	xa_lock(&brd->brd_folios);
 
-	idx = sector >> PAGE_SECTORS_SHIFT;
+	idx = brd_sector_index(brd, sector);
 	folio->index = idx;
 
 	cur = __xa_cmpxchg(&brd->brd_folios, idx, NULL, folio, gfp);
@@ -122,11 +140,12 @@ static void brd_free_folios(struct brd_device *brd)
 static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
 			     gfp_t gfp)
 {
-	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
+	unsigned int rd_sector_size = PAGE_SIZE;
+	unsigned int offset = brd_sector_offset(brd, sector);
 	size_t copy;
 	int ret;
 
-	copy = min_t(size_t, n, PAGE_SIZE - offset);
+	copy = min_t(size_t, n, rd_sector_size - offset);
 	ret = brd_insert_folio(brd, sector, gfp);
 	if (ret)
 		return ret;
@@ -145,10 +164,11 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 {
 	struct folio *folio;
 	void *dst;
-	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
+	unsigned int rd_sector_size = PAGE_SIZE;
+	unsigned int offset = brd_sector_offset(brd, sector);
 	size_t copy;
 
-	copy = min_t(size_t, n, PAGE_SIZE - offset);
+	copy = min_t(size_t, n, rd_sector_size - offset);
 	folio = brd_lookup_folio(brd, sector);
 	BUG_ON(!folio);
 
@@ -177,10 +197,11 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 {
 	struct folio *folio;
 	void *src;
-	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
+	unsigned int rd_sector_size = PAGE_SIZE;
+	unsigned int offset = brd_sector_offset(brd, sector);
 	size_t copy;
 
-	copy = min_t(size_t, n, PAGE_SIZE - offset);
+	copy = min_t(size_t, n, rd_sector_size - offset);
 	folio = brd_lookup_folio(brd, sector);
 	if (folio) {
 		src = kmap_local_folio(folio, offset);
-- 
2.35.3

