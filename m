Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFA918F562
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 14:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgCWNMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 09:12:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgCWNMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BKraV3KJY50yhZZu+Buo+JqIfHeH8iSauzsf1wxIpxw=; b=Vi3MXw+EUigXp7RP7DGECmv7C0
        TM9Zqb8kY1AdHb3wmX6TSekwKZz9CqkVUFkIWHG6Xs8iJgrJjoAJqtR7Irm2HrD8kbX0ZeNRHZ4+w
        86+9JNcaL5WO5ift5877cSmuzDzyuxPLvneCdCeV0I1yL9bGa7hBzLO935q8jEWeE6Fbl1gYIl8r0
        LPq7ZWiBJowe4a5KxWWv5kuugSm5eczI9oQVUGkaTddPzzEhqeZrGq0XsmMx47k6TV/NEEqDaRqLX
        ynaLoSEhmJNiNqhNSOj4HoSx78Y0zqzUaYpUiJbqHg/f/srSMw/CYHy/RRAP2bfU03GClyAIwuX5W
        zFa9GfDQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGMso-0007wd-Ad; Mon, 23 Mar 2020 13:12:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] iomap: Do not use GFP_NORETRY to allocate BIOs
Date:   Mon, 23 Mar 2020 06:12:44 -0700
Message-Id: <20200323131244.29435-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

If we use GFP_NORETRY, we have to be able to handle failures, and it's
tricky to handle failure here.  Other implementations of ->readpages
do not attempt to handle BIO allocation failures, so this is no worse.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 417115bfaf6b..2336642d7390 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -307,8 +307,6 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		if (ctx->bio)
 			submit_bio(ctx->bio);
 
-		if (ctx->is_readahead) /* same as readahead_gfp_mask */
-			gfp |= __GFP_NORETRY | __GFP_NOWARN;
 		ctx->bio = bio_alloc(gfp, min(BIO_MAX_PAGES, nr_vecs));
 		ctx->bio->bi_opf = REQ_OP_READ;
 		if (ctx->is_readahead)
-- 
2.25.1

