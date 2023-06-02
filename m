Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937A4720BED
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 00:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjFBWZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 18:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbjFBWZL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:25:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB551BF;
        Fri,  2 Jun 2023 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8dCohK3HnaaNjnWeZwFJCo19Yo0iOXyeyDVPkMnax+A=; b=Hb1LAS9iQgiBqesTXfeqEFRDSk
        xWzKPR4WggMLYWCSYPE+xCwAbP7BodH4rS2Ns+/PGXbmypoPs2kwL9/w4rnR/OoERHDKJzOUa4NUh
        HCUcKcSsLGZRf4w1+YXsWs54PxE0XEX2LSiTe9KLlK6ySpY8qvFvA2oztqFYS4CIfVRxuiPcdHISc
        8QTyKOveMj1/4KXbND4pMvBNzcbipK3Uylq0VFMM9Zni7MrjNSBXA8a0MtgAEKFUfZkMkYhEJU1GL
        MR83PKGOElW/GnfsxoYZbBQ+JhYb7YIwPVwtGytEylJvP3caPcIBYC5csdJ1R708gQTXZTgjjuhC7
        ajVgySeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q5DCQ-009aPI-NE; Fri, 02 Jun 2023 22:24:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 1/7] iomap: Remove large folio handling in iomap_invalidate_folio()
Date:   Fri,  2 Jun 2023 23:24:38 +0100
Message-Id: <20230602222445.2284892-2-willy@infradead.org>
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

We do not need to release the iomap_page in iomap_invalidate_folio()
to allow the folio to be split.  The splitting code will call
->release_folio() if there is still per-fs private data attached to
the folio.  At that point, we will check if the folio is still dirty
and decline to release the iomap_page.  It is possible to trigger the
warning in perfectly legitimate circumstances (eg if a disk read fails,
we do a partial write to the folio, then we truncate the folio), which
will cause those writes to be lost.

Fixes: 60d8231089f0 ("iomap: Support large folios in invalidatepage")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 063133ec77f4..08ee293c4117 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -508,11 +508,6 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 		WARN_ON_ONCE(folio_test_writeback(folio));
 		folio_cancel_dirty(folio);
 		iomap_page_release(folio);
-	} else if (folio_test_large(folio)) {
-		/* Must release the iop so the page can be split */
-		WARN_ON_ONCE(!folio_test_uptodate(folio) &&
-			     folio_test_dirty(folio));
-		iomap_page_release(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
-- 
2.39.2

