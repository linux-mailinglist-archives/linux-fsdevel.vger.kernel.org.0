Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B7B4E556C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 16:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbiCWPl2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 11:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbiCWPl0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:41:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898EC29C8D;
        Wed, 23 Mar 2022 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3fBdSQ100xHcTSrCs45lHCLpgmg9lIU1s69LGZJCCrw=; b=Qcp+yp+ZH2DjkIeqC6ZDqGrtcP
        F7/NWPNevkcyYIejSZYUTqB6puAcw5bHBSaP4QUyN/cK1KbMjwr4JKHv5OrvFIEXVbyt1rR1x3MDJ
        RwH3bDWIy9yjm3eUstE4XGRjrJdGqUVKmdSvJoOJzQErAGLQOva9Ip8RFyL6qItPD2Bsp8lHeMVbl
        mzeBA+BARA4sGPFjaknpYsmE4cCVNUp+UV5yRotLlUosWK70SjimbrZMhjBJd9Qtkfh7CcQ3FoQDU
        LUQM061YdN5DUpidBL/FRN9cJovRKvMOSLrdli81rrqBggDqebC2Y61fXMFtpUDCcj4DgeUGPnVC/
        C3POyhPw==;
Received: from [2001:4bb8:19a:b822:f080:d126:bfe4:c36c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nX35W-00E9LT-P0; Wed, 23 Mar 2022 15:39:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH] fs: do not pass __GFP_HIGHMEM to bio_alloc in do_mpage_readpage
Date:   Wed, 23 Mar 2022 16:39:52 +0100
Message-Id: <20220323153952.1418560-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

The mpage bio alloc cleanup accidentally removed clearing ~GFP_KERNEL
bits from the mask passed to bio_alloc.  Fix this up in a slightly
less obsfucated way that mirrors what iomap does in its readpage code.

Fixes: 77c436de01c0 ("mpage: pass the operation to bio_alloc")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/mpage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 9ed1e58e8d70b..d465883edf719 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -148,13 +148,11 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	int op = REQ_OP_READ;
 	unsigned nblocks;
 	unsigned relative_block;
-	gfp_t gfp;
+	gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
 
 	if (args->is_readahead) {
 		op |= REQ_RAHEAD;
-		gfp = readahead_gfp_mask(page->mapping);
-	} else {
-		gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
+		gfp |= __GFP_NORETRY | __GFP_NOWARN;
 	}
 
 	if (page_has_buffers(page))
-- 
2.30.2

