Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FF064E367
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 22:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiLOVoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 16:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiLOVoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3131C5C773
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dolFcnZSbP8XIvTbLJTtj44AzsL03OwQAE61xgsj16w=; b=SJxFU+GAh61E2VPOFiSQhHDaV0
        cBK7PGSWzdIqCsaZz1F29jFEApQdstVyxk8AZMKEJchesJSQ6xLQbn8vbX7ctaKpQ2qaKwBrcixkx
        WrLIOJUYqJMHkG5fsoV6J0Yh6o7P2tVlsXR2SimIimlEtzstEl3ZELDMtRgAZj0Stnet4avBIdIJh
        i0BDSHTeW0nejKMWBXOAFX0JK2r64zqo8JtCIlDZj0dfzJeV918wVKYEok1fHuUbeSztn7xK0uF8c
        XauOLQu4jiW1k9kPA1PmKNqtKwapJe+xgwx4GM1dIo2JGEZjkJP3gBetRWeQtIf7iU7mZ+d9i8wAm
        EoJHOw6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5w1P-00EmMM-TC; Thu, 15 Dec 2022 21:44:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/12] mpage: Use b_folio in do_mpage_readpage()
Date:   Thu, 15 Dec 2022 21:44:02 +0000
Message-Id: <20221215214402.3522366-13-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221215214402.3522366-1-willy@infradead.org>
References: <20221215214402.3522366-1-willy@infradead.org>
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

Remove this conversion of a folio back to a page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/mpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 0f8ae954a579..db59cbf6affc 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -198,7 +198,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	/*
 	 * Then do more get_blocks calls until we are done with this folio.
 	 */
-	map_bh->b_page = &folio->page;
+	map_bh->b_folio = folio;
 	while (page_block < blocks_per_page) {
 		map_bh->b_state = 0;
 		map_bh->b_size = 0;
-- 
2.35.1

