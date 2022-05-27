Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6061C536503
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353710AbiE0PvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353676AbiE0PvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:51:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B133513568B
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4wMMq3g5aM81AzKOoyA+PVFh218cMXjUSmWn3svbOQM=; b=r2pTcvZX9BEVvMkSidk0tFblVG
        f+AA4nFpaarqlyspVcUMydPbuLIMUCtWHuk9UVuTDME0BJ44GxqwxQPXIQWsTkfY80k8bSVOLs/Qy
        F3n2Qd1hCSrAvDM/QvBiL2her0e+X7l/I4ybmzzOxPGH6ZIRxaQOwcpKvdjoQ1keD+LpKdLX1cZk4
        RL4U5mOk4sdzWyjgR/vURpJRk8dHhZMJcyYRsl4xyGFH/pMCVtELyP6I0Tv5UotlR4MZ9JHSmrvjp
        5JTcKDL6jnInPZtChUb94vqvw9hC5rykH4Fj03aDq1olr6AetuiQkL8a8eaHpRi2xGUF4uByu1N8l
        UhWyWCyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEa-002CWW-Mv; Fri, 27 May 2022 15:50:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 06/24] hfsplus: Remove check for PageError
Date:   Fri, 27 May 2022 16:50:18 +0100
Message-Id: <20220527155036.524743-7-willy@infradead.org>
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

If read_mapping_page() encounters an error, it returns an errno, not a
page with PageError set, so this is dead code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hfsplus/bnode.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 177fae4e6581..a5ab00e54220 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -447,10 +447,6 @@ static struct hfs_bnode *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
 		page = read_mapping_page(mapping, block, NULL);
 		if (IS_ERR(page))
 			goto fail;
-		if (PageError(page)) {
-			put_page(page);
-			goto fail;
-		}
 		node->page[i] = page;
 	}
 
-- 
2.34.1

