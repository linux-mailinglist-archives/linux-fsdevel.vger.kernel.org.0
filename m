Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1429C536502
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353708AbiE0PvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353680AbiE0PvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:51:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09A613B8C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XjQP/FhIMNNRCHBvtTQpbw+sDJqqK43i6MI8xDK6ue4=; b=s/SNQOmeia3GYJViS3bMI/vt9F
        p1fx2sT3rnf6oVTVudcF+/ZPI83MYVnblbDR7d5iALZpV5fYuEmP75M9lQZCp+7F+MjBu+MKTU8Kr
        KMp5kmB8yCJiyKsSUrW1OVq5qWgE+eHSsRIDmvTMtBwqL3ZCP1yJmUNZu7eies+fgLLh1r4jmxJh4
        MDGzcYx1T8GVus8gV7jHg+wzVvFtDNmJgoy78NGA1sj+U4HlTpuKiUKBNH0tumD+fCW3s5Eim5ipe
        O6abP0bvbUG1oZ8EddBj7G0qjrRc3gqNvyGVt9swuAckGmfALxap68pRqBLMAoXy9hPGONDpxdzLX
        ijeunrQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEa-002CWa-RE; Fri, 27 May 2022 15:50:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 08/24] ext2: Remove check for PageError
Date:   Fri, 27 May 2022 16:50:20 +0100
Message-Id: <20220527155036.524743-9-willy@infradead.org>
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
page with PageError set, so this test is not needed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext2/dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 2c2f179b6977..3410e4132405 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -204,8 +204,7 @@ static struct page * ext2_get_page(struct inode *dir, unsigned long n,
 	if (!IS_ERR(page)) {
 		*page_addr = kmap_local_page(page);
 		if (unlikely(!PageChecked(page))) {
-			if (PageError(page) || !ext2_check_page(page, quiet,
-								*page_addr))
+			if (!ext2_check_page(page, quiet, *page_addr))
 				goto fail;
 		}
 	}
-- 
2.34.1

