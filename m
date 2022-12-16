Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E9064F2C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 21:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiLPUy3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 15:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiLPUx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:53:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D77E6A762;
        Fri, 16 Dec 2022 12:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=55nhYCS2WM3aurKUD+8s2RoJARzCY1JdmvCeXT5Y8QY=; b=nlitUDEFlHX2XXYYOLhJDj9iyH
        Qz6l3ieE+x1UsWd4+fXvEvnwyMSQ/TczBGGcPXIF4BLQwWtogcFKhqLcqzIdJJuLp6R6tTRphcj0D
        CYjd6IBNAak7qlOIc/HG5yVUxvY/aXothrN9EZ4UUP4Iy2cBDCO2CCtUSkutL8ye6R/eNUiNfGzdg
        Xyd7ChvLBFPKjY9hLtj3qlkm0sirP8hrhE2cHX3944bvKof+nRZluMfAE9/E3YNqGB2acveA0mDTc
        AqbWTc5qnOyQCx2Y2MO36U1nMOB7HC5f5heO4Ixi9Q26JqTp0qOamKN/1/vSyyPb4KaDubg1rErus
        ZFijNRvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6HiH-00Frfj-Vu; Fri, 16 Dec 2022 20:53:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     reiserfs-devel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 3/8] reiserfs: Convert direct2indirect() to call folio_zero_range()
Date:   Fri, 16 Dec 2022 20:53:42 +0000
Message-Id: <20221216205348.3781217-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221216205348.3781217-1-willy@infradead.org>
References: <20221216205348.3781217-1-willy@infradead.org>
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

Remove this open-coded call to kmap()/memset()/kunmap() with the
higher-level abstraction folio_zero_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/tail_conversion.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
index a61bca73c45f..ca36bb88b8b0 100644
--- a/fs/reiserfs/tail_conversion.c
+++ b/fs/reiserfs/tail_conversion.c
@@ -151,11 +151,11 @@ int direct2indirect(struct reiserfs_transaction_handle *th, struct inode *inode,
 	 * out the unused part of the block (it was not up to date before)
 	 */
 	if (up_to_date_bh) {
-		unsigned pgoff =
-		    (tail_offset + total_tail - 1) & (PAGE_SIZE - 1);
-		char *kaddr = kmap_atomic(up_to_date_bh->b_page);
-		memset(kaddr + pgoff, 0, blk_size - total_tail);
-		kunmap_atomic(kaddr);
+		size_t start = offset_in_folio(up_to_date_bh->b_folio,
+					(tail_offset + total_tail - 1));
+
+		folio_zero_range(up_to_date_bh->b_folio, start,
+				blk_size - total_tail);
 	}
 
 	REISERFS_I(inode)->i_first_direct_byte = U32_MAX;
-- 
2.35.1

