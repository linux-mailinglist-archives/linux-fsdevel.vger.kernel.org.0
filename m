Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A3772FD4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 13:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244269AbjFNLrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 07:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjFNLrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:47:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F299C1BC3;
        Wed, 14 Jun 2023 04:46:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF2BB2251A;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686743217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CbocsrMjXp7dBwU80SxwtZMmeZa5Prxn6bB4blsRqFc=;
        b=VBwllP/vdy0rvoghMWasHmjJKlmJP4eYOLD9/8tJO+rxARI9BJ/dzhII0uV02vTRUSoHzh
        CCE1rQnLEMFY06ZBORzgWF31ETC1Ab7UC5J9W2tiQZyJL03WjeVSiNP4xJByqGPUTEuUxk
        FFxdxW6iTjXbu0+3Lcq1e7fIrQ/dPN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686743217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CbocsrMjXp7dBwU80SxwtZMmeZa5Prxn6bB4blsRqFc=;
        b=1TLaH2Wd/FXHoOKBlRtPpC5KmV11QkwhBaKWiyVPkOgs/JRFzcrWBvZKIaQTKD0YoXVxH7
        vMoIa7WQxmxHeWAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 9E91A2C14E;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 97D9451C4E15; Wed, 14 Jun 2023 13:46:57 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6/7] mm/filemap: allocate folios with mapping blocksize
Date:   Wed, 14 Jun 2023 13:46:36 +0200
Message-Id: <20230614114637.89759-7-hare@suse.de>
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

The mapping has an underlying blocksize (by virtue of
mapping->host->i_blkbits), so if the mapping blocksize
is larger than the pagesize we should allocate folios
in the correct order.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/pagemap.h | 7 +++++++
 mm/filemap.c            | 7 ++++---
 mm/readahead.c          | 6 +++---
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 716953ee1ebd..9ea1a9724d64 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -494,6 +494,13 @@ static inline gfp_t readahead_gfp_mask(struct address_space *x)
 	return mapping_gfp_mask(x) | __GFP_NORETRY | __GFP_NOWARN;
 }
 
+static inline int mapping_get_order(struct address_space *x)
+{
+	if (x->host->i_blkbits > PAGE_SHIFT)
+		return x->host->i_blkbits - PAGE_SHIFT;
+	return 0;
+}
+
 typedef int filler_t(struct file *, struct folio *);
 
 pgoff_t page_cache_next_miss(struct address_space *mapping,
diff --git a/mm/filemap.c b/mm/filemap.c
index 4be20e82e4c3..6f08d04995d9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1936,7 +1936,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp |= GFP_NOWAIT | __GFP_NOWARN;
 		}
 
-		folio = filemap_alloc_folio(gfp, 0);
+		folio = filemap_alloc_folio(gfp, mapping_get_order(mapping));
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 
@@ -2495,7 +2495,8 @@ static int filemap_create_folio(struct file *file,
 	struct folio *folio;
 	int error;
 
-	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
+				    mapping_get_order(mapping));
 	if (!folio)
 		return -ENOMEM;
 
@@ -3646,7 +3647,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
-		folio = filemap_alloc_folio(gfp, 0);
+		folio = filemap_alloc_folio(gfp, mapping_get_order(mapping));
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 		err = filemap_add_folio(mapping, folio, index, gfp);
diff --git a/mm/readahead.c b/mm/readahead.c
index 47afbca1d122..031935b78af7 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -245,7 +245,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask, mapping_get_order(mapping));
 		if (!folio)
 			break;
 		if (filemap_add_folio(mapping, folio, index + i,
@@ -806,7 +806,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask, mapping_get_order(mapping));
 		if (!folio)
 			return;
 		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
@@ -833,7 +833,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask, mapping_get_order(mapping));
 		if (!folio)
 			return;
 		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
-- 
2.35.3

