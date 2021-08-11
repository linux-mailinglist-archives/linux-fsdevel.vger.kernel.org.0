Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9590A3E8843
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 04:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhHKCxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 22:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhHKCxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:53:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB91FC061765;
        Tue, 10 Aug 2021 19:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vIquiZe2U3IFUT2wRjBdKcO4it0HQuYNXi2MHpqaGVs=; b=mEIgOjkHTN79Kfb6wIm+SvCXJB
        HLQpL5TBThF3tpv5Ir21NCqvMxu4DjCXV9byzsTqeGAps8nQVJakt7pXIbmX3pcHxbXehLgEfnXj8
        oLf0ILa6gD3C6U2yLPM7oXhxt+7pdkBzV+ixCUpt9JVNkTr4Hc3j2D3Bm9PWqmmjd88mKOwW1Ikf0
        MdCnTVWHIvtXwq6Bd1yUgJC3DAbEVtkzSCq63wbujlUljfFrGJRflWQlftbwqPuGlSmF5+XX5DqLo
        H8X63PrlyLXIfBWiGgmtCrfkYqZc37GW0X2MzvGXQ0ZP0dljaPYJ/jsL1fPdfkODh2FeN7G4s1vh1
        +xRHR8kw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDeKl-00CsNZ-FD; Wed, 11 Aug 2021 02:51:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 6/8] iomap: Allow a NULL writeback_control argument to iomap_alloc_ioend()
Date:   Wed, 11 Aug 2021 03:46:45 +0100
Message-Id: <20210811024647.3067739-7-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811024647.3067739-1-willy@infradead.org>
References: <20210811024647.3067739-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we're doing writethrough, we don't have a writeback_control to
pass in.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a74da66e64a7..2b89c43aedd7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1213,9 +1213,13 @@ static struct iomap_ioend *iomap_alloc_ioend(struct inode *inode,
 	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &iomap_ioend_bioset);
 	bio_set_dev(bio, iomap->bdev);
 	bio->bi_iter.bi_sector = sector;
-	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
+	bio->bi_opf = REQ_OP_WRITE;
 	bio->bi_write_hint = inode->i_write_hint;
-	wbc_init_bio(wbc, bio);
+
+	if (wbc) {
+		bio->bi_opf |= wbc_to_write_flags(wbc);
+		wbc_init_bio(wbc, bio);
+	}
 
 	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
 	INIT_LIST_HEAD(&ioend->io_list);
-- 
2.30.2

