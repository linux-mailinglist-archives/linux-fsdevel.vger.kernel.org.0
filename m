Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9572C6E24AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 15:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDNNtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 09:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjDNNtj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:49:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0A7B77E;
        Fri, 14 Apr 2023 06:49:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 262D9219D7;
        Fri, 14 Apr 2023 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681480150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tVTQPul/JXATpe+rLUOKdbwaHI2COkJc82nsUk9iRu0=;
        b=yrrU8Rd8A6t3YfPMmwobhbRVKgeH14EUpv9J7/J74OlCc/kJNuZgarcU3PNAUH61RBAUxM
        3b5vspT9hfcvBkrii/eKZvjDWZLTwodFjnI6S9SYS4eCK40AZiYFy7zwbqAkJIJb0ZMVLy
        Ru/9vvTOVF1QGjm5/TFinKWlsMglZI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681480150;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tVTQPul/JXATpe+rLUOKdbwaHI2COkJc82nsUk9iRu0=;
        b=3Cm3KiqT004Qj8aTzVi0lrNxTyArJdXb6TAd7XXHhwgQ6kHnpe7eQRbw8AREzmsFzx4G1F
        qBLrXxO/oJelEBBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D12BB2C143;
        Fri, 14 Apr 2023 13:49:09 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id C146951C23D9; Fri, 14 Apr 2023 15:49:09 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] mm/filemap: allocate folios according to the blocksize
Date:   Fri, 14 Apr 2023 15:49:08 +0200
Message-Id: <20230414134908.103932-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the blocksize is larger than the pagesize allocate folios
with the correct order.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 mm/filemap.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 05fd86752489..468f25714ced 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1927,7 +1927,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		folio_wait_stable(folio);
 no_page:
 	if (!folio && (fgp_flags & FGP_CREAT)) {
-		int err;
+		int err, order = 0;
 		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
 			gfp |= __GFP_WRITE;
 		if (fgp_flags & FGP_NOFS)
@@ -1937,7 +1937,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp |= GFP_NOWAIT | __GFP_NOWARN;
 		}
 
-		folio = filemap_alloc_folio(gfp, 0);
+		if (mapping->host->i_blkbits > PAGE_SHIFT)
+			order = mapping->host->i_blkbits - PAGE_SHIFT;
+		folio = filemap_alloc_folio(gfp, order);
 		if (!folio)
 			return NULL;
 
@@ -2492,9 +2494,11 @@ static int filemap_create_folio(struct file *file,
 		struct folio_batch *fbatch)
 {
 	struct folio *folio;
-	int error;
+	int error, order = 0;
 
-	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
+	if (mapping->host->i_blkbits > PAGE_SHIFT)
+		order = mapping->host->i_blkbits - PAGE_SHIFT;
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), order);
 	if (!folio)
 		return -ENOMEM;
 
@@ -3607,14 +3611,16 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 		pgoff_t index, filler_t filler, struct file *file, gfp_t gfp)
 {
 	struct folio *folio;
-	int err;
+	int err, order = 0;
 
+	if (mapping->host->i_blkbits > PAGE_SHIFT)
+		order = mapping->host->i_blkbits - PAGE_SHIFT;
 	if (!filler)
 		filler = mapping->a_ops->read_folio;
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (!folio) {
-		folio = filemap_alloc_folio(gfp, 0);
+		folio = filemap_alloc_folio(gfp, order);
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 		err = filemap_add_folio(mapping, folio, index, gfp);
-- 
2.35.3

