Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5BB74D6E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 15:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGJNFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 09:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjGJNEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:04:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377FE10C2;
        Mon, 10 Jul 2023 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CKv8MScTKmwiTmt3fYuPX1fpKU+qfHCuB387pZR9VUI=; b=JNcCJESpelSY1xMgaEcnWzv0YU
        jm8tRwpAkfKjeqM/E8Mnvb9ZcRwEefuM5EliERwE8IAsGaHgmACZ5PkH4uFegCAcrZoXTX3A5qMzB
        2nCZlbQz6SJBQMXg3UeqxFQ4KONZ4LXiMFWqjvPqnW8+J3SU/hFhpjXU80hyK/magkiIT0B7S/QhG
        58e6hBIeL7k4f1mncJhAvAiqjCRgR5MdrEa1WM+DcAVfO7BQi0OSYjTjp7qVeDPtH8zQHrFKjr/H7
        4iCkhzUeNhner8Orr6EoGEZKNWofRPyrSL7ydxndm2bNUGlkSCYYrM2N5fIryxsYkdf9my15YPKmD
        HbWd/CVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIqXX-00EcXJ-Kc; Mon, 10 Jul 2023 13:02:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 4/9] doc: Correct the description of ->release_folio
Date:   Mon, 10 Jul 2023 14:02:48 +0100
Message-Id: <20230710130253.3484695-5-willy@infradead.org>
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

The filesystem ->release_folio method is called under more circumstances
now than when the documentation was written.  The second sentence
describing the interpretation of the return value is the wrong polarity
(false indicates failure, not success).  And the third sentence is also
wrong (the kernel calls try_to_free_buffers() instead).

So replace the entire paragraph with a detailed description of what the
state of the folio may be, the meaning of the gfp parameter, why the
method is being called and what the filesystem is expected to do.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/locking.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index ed148919e11a..ca3d24becbf5 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -374,10 +374,17 @@ invalidate_lock before invalidating page cache in truncate / hole punch
 path (and thus calling into ->invalidate_folio) to block races between page
 cache invalidation and page cache filling functions (fault, read, ...).
 
-->release_folio() is called when the kernel is about to try to drop the
-buffers from the folio in preparation for freeing it.  It returns false to
-indicate that the buffers are (or may be) freeable.  If ->release_folio is
-NULL, the kernel assumes that the fs has no private interest in the buffers.
+->release_folio() is called when the MM wants to make a change to the
+folio that would invalidate the filesystem's private data.  For example,
+it may be about to be removed from the address_space or split.  The folio
+is locked and not under writeback.  It may be dirty.  The gfp parameter
+is not usually used for allocation, but rather to indicate what the
+filesystem may do to attempt to free the private data.  The filesystem may
+return false to indicate that the folio's private data cannot be freed.
+If it returns true, it should have already removed the private data from
+the folio.  If a filesystem does not provide a ->release_folio method,
+the pagecache will assume that private data is buffer_heads and call
+try_to_free_buffers().
 
 ->free_folio() is called when the kernel has dropped the folio
 from the page cache.
-- 
2.39.2

