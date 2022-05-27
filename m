Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA7A536506
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353716AbiE0Pvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353707AbiE0PvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:51:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61C11030
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=J6ZYsEntBqEXv9QBv404Bgc48t6nDUnBZmpt61SYzKU=; b=LiGJJ8kQ87fQsAY1OFDvu/IXG9
        /p1ELYx7K+911E5NCn4ItDp8JJrDnoTO9ECbIH2Duh1Z9YUkJ6yZIEuA5dbNjxgX6Qdzx/rda66rW
        AGs08STh0x9LpH3Mg1EndQxzbmsG/AJPeoZ9mWumUXE7L4nBjEDbfcNH2cdVWQjPJTi5x5J08SRM5
        DAaRYZx5IlbfV7I4j/wQn08l/SodtBqgIC6orOO9/l2C1BXJDz1YfEFq5GwdIgWit2Yb6uJivEBx6
        h5nH07gRWAl5RfUExkLlfBEGGLErgDOhLc2rm5rOW2ytAvUgEFQrIH1/n+YHXSnfuHdhn9piTbMny
        qmzN0+RA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEa-002CWU-Kx; Fri, 27 May 2022 15:50:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 05/24] hfs: Remove check for PageError
Date:   Fri, 27 May 2022 16:50:17 +0100
Message-Id: <20220527155036.524743-6-willy@infradead.org>
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
 fs/hfs/bnode.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index c0a73a6ffb28..c83fd0e8404d 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -296,10 +296,6 @@ static struct hfs_bnode *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
 		page = read_mapping_page(mapping, block++, NULL);
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

