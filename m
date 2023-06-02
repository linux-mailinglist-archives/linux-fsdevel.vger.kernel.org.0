Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75811720BE9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 00:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbjFBWZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 18:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbjFBWZE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:25:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5261BC;
        Fri,  2 Jun 2023 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vLEeKteqsDUAnkFvPBrhq1GjkuxkCUs9Dhv1jNbwvTQ=; b=BkW7WbhVl3DxOgxkZirtFJT4qI
        RRNfRDJoLxb2wb/7/XpKqq8mXL+kG98X9FDqZ0ads4jQL+xScjCUSApEQnUrGqAWWIcjAL/n6jJ7O
        rjExndgNv31Zxnnb6ib9ZdVBCXCMd4JamiS/Fdr+nUIUMDUAHlYdgk6asmmadt60S09C/6wuHuijl
        0uxidhXAHQCIzaUHVxnUwHwRdwO36vfui04uPmdDbkdrQeG41XunrZUz5ctuewZqMg4dr98JpCgWz
        hss7UPcIGqAPg77NXh6bc2JiEPVTcNafmw0xO7aFP63zD/DAMcM4nUHzz54dYOJMf20tnu68fV7eX
        TLzViVyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q5DCQ-009aPM-So; Fri, 02 Jun 2023 22:24:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 3/7] iomap: Remove unnecessary test from iomap_release_folio()
Date:   Fri,  2 Jun 2023 23:24:40 +0100
Message-Id: <20230602222445.2284892-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230602222445.2284892-1-willy@infradead.org>
References: <20230602222445.2284892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The check for the folio being under writeback is unnecessary; the caller
has checked this and the folio is locked, so the folio cannot be under
writeback at this point.

The comment is somewhat misleading in that it talks about one specific
situation in which we can see a dirty folio.  There are others, so change
the comment to explain why we can't release the iomap_page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 08ee293c4117..2054b85c9d9b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -483,12 +483,10 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
 			folio_size(folio));
 
 	/*
-	 * mm accommodates an old ext3 case where clean folios might
-	 * not have had the dirty bit cleared.  Thus, it can send actual
-	 * dirty folios to ->release_folio() via shrink_active_list();
-	 * skip those here.
+	 * If the folio is dirty, we refuse to release our metadata because
+	 * it may be partially dirty (FIXME, add a test for that).
 	 */
-	if (folio_test_dirty(folio) || folio_test_writeback(folio))
+	if (folio_test_dirty(folio))
 		return false;
 	iomap_page_release(folio);
 	return true;
-- 
2.39.2

