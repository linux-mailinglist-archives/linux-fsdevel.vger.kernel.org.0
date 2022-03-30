Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D54EC710
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347221AbiC3OvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347213AbiC3OvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:51:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CE715FE9
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=v79nSpWWp4DQFLI9Ra6AFFtDk369jRNQ8gjo++s/zGs=; b=mE3JarJQULsU17/CwRwQwxnY1t
        243u7XlXdvMjG777Oe9evN2VOyU0Vo47bhQXl5WZz2vHDozTWBY+eA8Vdk+Hj0ylTcjnPYiR7fIbw
        dDwyqkwVg+MmzA2QFwsistdbs0qh7PmLMjX4ZWMkNVLGhVcaJUZrOR6dp347/1PAqWFaXA24QFIMp
        Qt5HAN/JJ891i9rjMTh7zOSwUj5VEN7y1tPyFMVX11W+LEz+5LLXGjiSUpFozFcCPDHZOfBbqnDWL
        xlNI9vITr+mX9+6BARhf26RvEtTZ1Ehw7XgrvTgYVIfViEM682ollaMapUT06LNxc3hVIKkCvFZLX
        KiGM5xTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZdc-001KD2-0E; Wed, 30 Mar 2022 14:49:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 03/12] iomap: Simplify is_partially_uptodate a little
Date:   Wed, 30 Mar 2022 15:49:21 +0100
Message-Id: <20220330144930.315951-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220330144930.315951-1-willy@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
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

Remove the unnecessary variable 'len' and fix a comment to refer to
the folio instead of the page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 49dccd9050f1..8ce8720093b9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -435,18 +435,17 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 {
 	struct iomap_page *iop = to_iomap_page(folio);
 	struct inode *inode = folio->mapping->host;
-	size_t len;
 	unsigned first, last, i;
 
 	if (!iop)
 		return false;
 
-	/* Limit range to this folio */
-	len = min(folio_size(folio) - from, count);
+	/* Caller's range may extend past the end of this folio */
+	count = min(folio_size(folio) - from, count);
 
-	/* First and last blocks in range within page */
+	/* First and last blocks in range within folio */
 	first = from >> inode->i_blkbits;
-	last = (from + len - 1) >> inode->i_blkbits;
+	last = (from + count - 1) >> inode->i_blkbits;
 
 	for (i = first; i <= last; i++)
 		if (!test_bit(i, iop->uptodate))
-- 
2.34.1

