Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA34B5364F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353681AbiE0PvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353196AbiE0Pu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1728134E35
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1XtQLdO3zOMxoYZ7MTiciQTgmwPX4hfSHC2XnCRgCrU=; b=X/ZfjynB0l9ZCO9PgWj9JR/tEI
        KX9iyayFZddcJmbIOlrS8L4dBKI18TzPRWdWSnyamzfwA8tsLyYTe3TUQrgDj9wIwmvpR6VUQhIo8
        gBr43W7SfYhmLi4pC9D1tw99Y1qO9u2r93NmNIWXN6atsvBH7x5L6A+wIfUY+4cOFLuQbk4XQr352
        grt/fRP3Dm5vxU7Ac7kbQhLQVknZWJcLLMXzeqgdEEBQKmmhGvFGuWPlrmobBFS/CtDeOdcHrv1A/
        u2Ccb56wnii1BS8E7LctrJYT7lbSrp1WvrFq9PTaoLuBcUDZaXBXU4RqpnSyYnrl2AOYULDielCgt
        KWrb5mnA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEa-002CWM-A8; Fri, 27 May 2022 15:50:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 01/24] block: Remove check of PageError
Date:   Fri, 27 May 2022 16:50:13 +0100
Message-Id: <20220527155036.524743-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220527155036.524743-1-willy@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If read_mapping_page() sees a page with PageError set, it returns a
PTR_ERR().  Checking PageError again is simply dead code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/partitions/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 8a0ec929023b..a9a51bac42df 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -716,14 +716,10 @@ void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 			(pgoff_t)(n >> (PAGE_SHIFT - 9)), NULL);
 	if (IS_ERR(page))
 		goto out;
-	if (PageError(page))
-		goto out_put_page;
 
 	p->v = page;
 	return (unsigned char *)page_address(page) +
 			((n & ((1 << (PAGE_SHIFT - 9)) - 1)) << SECTOR_SHIFT);
-out_put_page:
-	put_page(page);
 out:
 	p->v = NULL;
 	return NULL;
-- 
2.34.1

