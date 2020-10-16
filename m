Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259D229097B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410672AbgJPQOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410669AbgJPQO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:14:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B18C0613D3;
        Fri, 16 Oct 2020 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nt96PGAEpmDATNqAyB6cBLhNcHcyDa+Gu358dEu2MKs=; b=A9G7+edGKOCwVA4XmZgDqkI3yi
        tZCOX2MaYnVEEFoFAj+P3cq0caLMN33MHBoD5ZN+gJHF6OtcawWMI14nQUigNxp1oZ9wcSXzePh2w
        4JadSY1kdfjK/J3XnfRtU3EtcvrDPfwMvxSnP0Fiy/+MRARhpbPIZPk56B8WnaMC2xTCTbTPQK3Wh
        ywfQj7FfLLpamsbPs/0jZJy5lwi6KeU8PW4oMOzPMf1ddYaeRZgoRLdyCMPugH2T1xdQR8jrJ9N3r
        RLtABUXpAan3LePEbVZ4CQjPNsk8WNP0YERyrCjNxAXtQqj/sRi8K+VlJQdyQ16TF3w0BHNZ1qOcd
        1LuOeJ8A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSNA-0005f7-8A; Fri, 16 Oct 2020 16:14:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/2] fs: Make mpage_readpage synchronous
Date:   Fri, 16 Oct 2020 17:14:26 +0100
Message-Id: <20201016161426.21715-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016161426.21715-1-willy@infradead.org>
References: <20201016161426.21715-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A synchronous readpage lets us report the actual errno instead of
ineffectively setting PageError.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/mpage.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 830e6cc2a9e7..88aba79a1861 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -406,11 +406,30 @@ int mpage_readpage(struct page *page, get_block_t get_block)
 		.nr_pages = 1,
 		.get_block = get_block,
 	};
+	int err;
 
 	args.bio = do_mpage_readpage(&args);
-	if (args.bio)
-		mpage_bio_submit(REQ_OP_READ, 0, args.bio);
-	return 0;
+	/*
+	 * XXX: We can't tell the difference between "fell back to
+	 * block_read_full_page" and "this was a hole".  If we could,
+	 * we'd avoid unlocking the page in do_mpage_readpage() and
+	 * return AOP_UPDATED_PAGE here.
+	 */
+	if (!args.bio)
+		return 0;
+	bio_set_op_attrs(args.bio, REQ_OP_READ, 0);
+	guard_bio_eod(args.bio);
+	err = submit_bio_killable(args.bio, mpage_end_io);
+	if (unlikely(err))
+		goto err;
+
+	SetPageUptodate(page);
+	return AOP_UPDATED_PAGE;
+
+err:
+	if (err != -ERESTARTSYS)
+		unlock_page(page);
+	return err;
 }
 EXPORT_SYMBOL(mpage_readpage);
 
-- 
2.28.0

