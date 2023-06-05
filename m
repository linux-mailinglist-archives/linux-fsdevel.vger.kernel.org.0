Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89677223F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 12:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjFEKzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 06:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjFEKzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:55:25 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7612911C;
        Mon,  5 Jun 2023 03:55:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b01d912924so43170645ad.1;
        Mon, 05 Jun 2023 03:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685962518; x=1688554518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxrzfIp1bwlxrggScZU2c1c7t8HyvxqKo5xx2x+BHzs=;
        b=a9yswcidqIQodT44r0/9muHlwWLyf8GVMw1Dm4Q0PvIpYODGAzzSarevkO9IEYWmUk
         uOAsSxRCWyb+9qLVgHAtJckaSupYP0QiRtgbgBIn+8VV/+w1RxbzBhCz9eOMMYYONkkR
         SyxBN99mt4/fUy4SlBfnWQyFlTz7wqPU3TiC/+RHlNisksAOtfOt6triJVHp8mnDJlSx
         7Pin25efvEKHfu8sHjtrBEKhHnWar/dvH01ILzJ+4sP2EGvNTLQ/FZiJbc1CKRINcLvz
         KJQfCJYm3ZbL0ag/7tWjfByk/+s0exTR/4HlSVIPQEARYrtJNepTJEmukYRvbpT6G97c
         RV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685962518; x=1688554518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxrzfIp1bwlxrggScZU2c1c7t8HyvxqKo5xx2x+BHzs=;
        b=eAj3PaJy2fP0jZkk4JQVEHWP0yQs5Wm3M5witSBieeI0GucmPvP77vRfdQs6eERD3X
         prNaq19IY36i5TCTIE2LQ8aP5kG7UB8MxemysdDgUWKLpErvIK4gyZ6ho1poac+t+0DK
         gohue0Jtraz8aN031cqeAQHvVeE7jQ8X7YudPT8K0ScLKE/xRiUntAAfQ4e979c+Qgq8
         zDAdI4BTdSQS6Owmh/D38WSmhn734244MQO9YXYovb16cP2YyVfmeGdUQra5a9HM7ssh
         YQNokKR+ImGAqECH8xRJh1MxyvFSrLU293YwuxqSdgisy19faw4D8jgWy+DIlbKR8xXS
         xXag==
X-Gm-Message-State: AC+VfDz3rAjI8yQRXQEwvaGfWOvkLrIY5OguHKZx9oQ8uW8YdzxO/LTf
        i1dIVaY7M8p95k4IamRDPeA1QKCL33A=
X-Google-Smtp-Source: ACHHUZ64dDKctH++/r2IBTDMoQhIUBSSuVb3O63nNI3T9gvaB5JEgO22OBuph0UeU1YCffStYCDI0g==
X-Received: by 2002:a17:902:d506:b0:1b1:9233:bbf5 with SMTP id b6-20020a170902d50600b001b19233bbf5mr9197475plg.57.1685962518438;
        Mon, 05 Jun 2023 03:55:18 -0700 (PDT)
Received: from dw-tp.c4p-in.ibmmobiledemo.com ([129.41.58.19])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001b0f727bc44sm6266883plh.16.2023.06.05.03.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:55:18 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv7 1/6] iomap: Rename iomap_page_create/release() to iomap_iop_alloc/free()
Date:   Mon,  5 Jun 2023 16:25:01 +0530
Message-Id: <d06abc56a48e3ac7d8c0619fee57506f36fcca5b.1685962158.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685962158.git.ritesh.list@gmail.com>
References: <cover.1685962158.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch renames the iomap_page_create/release() functions to
iomap_iop_alloc/free() calls. Later patches adds more functions for
handling iop structure with iomap_iop_** naming conventions.
Hence iomap_iop_alloc/free() makes more sense to be consistent with all
APIs.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 063133ec77f4..4567bdd4fff9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -43,8 +43,8 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 
 static struct bio_set iomap_ioend_bioset;
 
-static struct iomap_page *
-iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
+static struct iomap_page *iomap_iop_alloc(struct inode *inode,
+				struct folio *folio, unsigned int flags)
 {
 	struct iomap_page *iop = to_iomap_page(folio);
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
@@ -69,7 +69,7 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
 	return iop;
 }
 
-static void iomap_page_release(struct folio *folio)
+static void iomap_iop_free(struct folio *folio)
 {
 	struct iomap_page *iop = folio_detach_private(folio);
 	struct inode *inode = folio->mapping->host;
@@ -231,7 +231,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (offset > 0)
-		iop = iomap_page_create(iter->inode, folio, iter->flags);
+		iop = iomap_iop_alloc(iter->inode, folio, iter->flags);
 	else
 		iop = to_iomap_page(folio);
 
@@ -269,7 +269,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		return iomap_read_inline_data(iter, folio);
 
 	/* zero post-eof blocks as the page may be mapped */
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
+	iop = iomap_iop_alloc(iter->inode, folio, iter->flags);
 	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
@@ -490,7 +490,7 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
 	 */
 	if (folio_test_dirty(folio) || folio_test_writeback(folio))
 		return false;
-	iomap_page_release(folio);
+	iomap_iop_free(folio);
 	return true;
 }
 EXPORT_SYMBOL_GPL(iomap_release_folio);
@@ -507,12 +507,12 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 	if (offset == 0 && len == folio_size(folio)) {
 		WARN_ON_ONCE(folio_test_writeback(folio));
 		folio_cancel_dirty(folio);
-		iomap_page_release(folio);
+		iomap_iop_free(folio);
 	} else if (folio_test_large(folio)) {
 		/* Must release the iop so the page can be split */
 		WARN_ON_ONCE(!folio_test_uptodate(folio) &&
 			     folio_test_dirty(folio));
-		iomap_page_release(folio);
+		iomap_iop_free(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
@@ -559,7 +559,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		return 0;
 	folio_clear_error(folio);
 
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
+	iop = iomap_iop_alloc(iter->inode, folio, iter->flags);
+
 	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
 		return -EAGAIN;
 
@@ -1612,7 +1613,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct folio *folio, u64 end_pos)
 {
-	struct iomap_page *iop = iomap_page_create(inode, folio, 0);
+	struct iomap_page *iop = iomap_iop_alloc(inode, folio, 0);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
-- 
2.40.1

