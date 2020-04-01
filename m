Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6455119A3BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 05:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbgDADEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 23:04:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbgDADEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 23:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=72eXXTNwJe0o0F8S3JsJfQ80eVmaeJpwWzz6gP96RxQ=; b=U7PMe36Tq75pm7G3VLF68SjTq4
        BF0q8dj1ync9742NjyttNAbppo8rbOfEIsyRDIK5T1CmItrsNOmnrZMuB/ELPJLpo5lbFiGSA7iTQ
        V8K65yeKDeQ1uSFSK6SfsDNd4i+wdhIN/SCv+dPPB2Ti1ypX+4sYiQeQRbY/BKuoFvlFaV0BoEaU0
        H/rCgkDgDUQYYskWDH3VFy4e1ti4OXshRzCRzWDq98zd7oNcQiRjRR1uCX0TR8FfHx+32iRCj9ywa
        XSnz7g/N4ASVqhXC5/MDUtUw2QqHIIum02MS2066Hgz0/mM+9yTnw3M5vG8iJ0nk/oy84CltSeU7e
        IBxekXXg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJTfz-0004UK-He; Wed, 01 Apr 2020 03:04:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] iomap: Handle memory allocation failure in readahead
Date:   Tue, 31 Mar 2020 20:04:21 -0700
Message-Id: <20200401030421.17195-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

bio_alloc() can fail when we use GFP_NORETRY.  If it does, allocate
a bio large enough for a single page like mpage_readpages() does.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 417115bfaf6b..c258801f18d4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -302,6 +302,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 	if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {
 		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
+		gfp_t orig_gfp = gfp;
 		int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 		if (ctx->bio)
@@ -310,6 +311,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		if (ctx->is_readahead) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
 		ctx->bio = bio_alloc(gfp, min(BIO_MAX_PAGES, nr_vecs));
+		if (!ctx->bio)
+			ctx->bio = bio_alloc(orig_gfp, 1);
 		ctx->bio->bi_opf = REQ_OP_READ;
 		if (ctx->is_readahead)
 			ctx->bio->bi_opf |= REQ_RAHEAD;
-- 
2.25.1

