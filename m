Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5910F6EB3D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 23:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjDUVoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 17:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjDUVoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:44:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CF126B2;
        Fri, 21 Apr 2023 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZUAOcNqD6LayzeKVCuQ/BLskBnjlrIyvlaP+338TFj0=; b=4faVVxfybgSKlFUw4CjuG22i97
        71PGGt9QIrJ/HwbknwCDE//N0MK6Lp3ra+wQrXZsk0eWG60sRW0X5RUf4Kenfek+eG2paFJP/MaZa
        0pWwiy4StWWh+SSoxTEvENx27Ue1WY0nZEQ5jvksW4DR5M1zwWo9akRwduyxRxOL7u3B+Vg/sEuOs
        8Ct23zxr9jtxEu1k9C79r6F1cOvTy0vfzN2gpw8diBX/Hb0y0aSu/dsvGfqVJ/FI8leP+YAgddYgn
        hK5IlPwLjcORNIqVDFOLTCGjGCfsFF6VGnKA9PA/rSAOR6sQOrz+AG5XTaTPZkVnxF4ht9+1OwIlY
        CcAZD47g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppyY1-00Btos-2R;
        Fri, 21 Apr 2023 21:44:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, djwong@kernel.org
Cc:     p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        mcgrof@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC 6/8] shmem: consider block size in shmem_default_max_inodes()
Date:   Fri, 21 Apr 2023 14:43:58 -0700
Message-Id: <20230421214400.2836131-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230421214400.2836131-1-mcgrof@kernel.org>
References: <20230421214400.2836131-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Today we allow for a max number of inodes in consideration for
the smallest possible inodes with just one block of size PAGE_SIZE.
The max number of inodes depend on the size of the block size then,
and if we want to support higher block sizes we end up with less
number of inodes.

Account for this in the computation for the max number of inodes.

If the blocksize is greater than the PAGE_SIZE, we simply divide the
number of pages usable, multiply by the page size and divide by the
blocksize.

This produces no functional changes right now as we don't support
larger block sizes yet.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b83596467706..5a64efd1f3c2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -143,11 +143,14 @@ static unsigned long shmem_default_max_blocks(u64 blocksize)
 	return totalram_pages() >> (__ffs(blocksize) - PAGE_SHIFT + 1);
 }
 
-static unsigned long shmem_default_max_inodes(void)
+static unsigned long shmem_default_max_inodes(u64 blocksize)
 {
 	unsigned long nr_pages = totalram_pages();
+	unsigned long pages_for_inodes = min(nr_pages - totalhigh_pages(), nr_pages / 2);
 
-	return min(nr_pages - totalhigh_pages(), nr_pages / 2);
+	if (blocksize == shmem_default_bsize())
+		return pages_for_inodes;
+	return pages_for_inodes >> (__ffs(blocksize) - PAGE_SHIFT);
 }
 #else
 static u64 shmem_sb_blocksize(struct shmem_sb_info *sbinfo)
@@ -4028,7 +4031,7 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 	if (sbinfo->max_blocks != shmem_default_max_blocks(shmem_default_bsize()))
 		seq_printf(seq, ",size=%luk",
 			sbinfo->max_blocks << (PAGE_SHIFT - 10));
-	if (sbinfo->max_inodes != shmem_default_max_inodes())
+	if (sbinfo->max_inodes != shmem_default_max_inodes(shmem_default_bsize()))
 		seq_printf(seq, ",nr_inodes=%lu", sbinfo->max_inodes);
 	if (sbinfo->mode != (0777 | S_ISVTX))
 		seq_printf(seq, ",mode=%03ho", sbinfo->mode);
@@ -4109,7 +4112,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (!(ctx->seen & SHMEM_SEEN_BLOCKS))
 			ctx->blocks = shmem_default_max_blocks(shmem_default_bsize());
 		if (!(ctx->seen & SHMEM_SEEN_INODES))
-			ctx->inodes = shmem_default_max_inodes();
+			ctx->inodes = shmem_default_max_inodes(shmem_default_bsize());
 		if (!(ctx->seen & SHMEM_SEEN_INUMS))
 			ctx->full_inums = IS_ENABLED(CONFIG_TMPFS_INODE64);
 		sbinfo->noswap = ctx->noswap;
-- 
2.39.2

