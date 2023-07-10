Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5F774D6DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 15:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjGJNEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjGJNEL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:04:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A70118;
        Mon, 10 Jul 2023 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=B5bV0iovg+lW23zRXzSduES5qszRr1vQXDi2cK3VfU8=; b=sOqOUKRAZbw5CqoZEVLL2ovbl0
        IZdPKYm00UliXiQl54gOjcM/BsR+T6KQ57611Tgk27m3IGxhYXB0g7BFHO1+oMOVw/ep+O5hhXAjZ
        xE2JnKz78UP9M1VQtL3Y3M3OFQW8DPyBT96WCsGLJOiedFnUJw8VtVq2UVI5h/XdtDgicgb8SIw9v
        7XEaDgURS9UZ12igBF+4dwxxrtJlPVO0bB5+odyK92MjAAgGVlBieI+GyCuf299QQgW9hY02739K/
        tpNMjBALKdstcurywrw/LfmrNSpKINYZ4Vj3XIgA5sTknOGqzRZg4z0f9ARNklRjfrAInwfJ1G7gD
        mym54xEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIqXX-00EcXG-HW; Mon, 10 Jul 2023 13:02:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 3/9] iomap: Remove large folio handling in iomap_invalidate_folio()
Date:   Mon, 10 Jul 2023 14:02:47 +0100
Message-Id: <20230710130253.3484695-4-willy@infradead.org>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index adb92cdb24b0..1cb905140528 100644
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

