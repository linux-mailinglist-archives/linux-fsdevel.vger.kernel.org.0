Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2000274D6E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 15:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjGJNFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 09:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjGJNEc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:04:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786D91B1;
        Mon, 10 Jul 2023 06:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VUQDsCY2lUnUk2xg7tsQfzEWDS9nF90sU8cxFuMW9kg=; b=OiiqmXc1G50qSVQo01wvgYWZNc
        v4TBRfH5DGL6q1w9K/cd26zviqpTdNGRsxSK1IC9o4B9xz8K/07kVeQu203Fo1A0V/vJTq3E2ihwA
        h01LCJfOTeRo0rTMT7Cg5jA7ipAnlyJPHQ6mmuu5cAcgQkIHIbTFGyRtCoVjDEWFBMnfTak4l0MVx
        28Q78/yhtBdhwuekU+yxej+72U3ceXl2Sk+vCZ+B3LAy5mVbb709dTN0KxhxQBIctC3BK8X2D+QpH
        TG39kQ2LfQzHEFxznIVyw6Lnmwq/GJPcrvE5uV98PzZyAXuyxZa6MEz7Srj8uNWVsg0ZwX8KxnlAF
        dHMWMJgw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIqXX-00EcXL-NM; Mon, 10 Jul 2023 13:02:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 5/9] iomap: Remove unnecessary test from iomap_release_folio()
Date:   Mon, 10 Jul 2023 14:02:49 +0100
Message-Id: <20230710130253.3484695-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230710130253.3484695-1-willy@infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1cb905140528..7aa3009f907f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -483,12 +483,11 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
 			folio_size(folio));
 
 	/*
-	 * mm accommodates an old ext3 case where clean folios might
-	 * not have had the dirty bit cleared.  Thus, it can send actual
-	 * dirty folios to ->release_folio() via shrink_active_list();
-	 * skip those here.
+	 * If the folio is dirty, we refuse to release our metadata because
+	 * it may be partially dirty.  Once we track per-block dirty state,
+	 * we can release the metadata if every block is dirty.
 	 */
-	if (folio_test_dirty(folio) || folio_test_writeback(folio))
+	if (folio_test_dirty(folio))
 		return false;
 	iomap_page_release(folio);
 	return true;
-- 
2.39.2

