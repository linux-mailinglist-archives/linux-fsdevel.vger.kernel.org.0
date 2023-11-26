Return-Path: <linux-fsdevel+bounces-3842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 772C57F92A3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 13:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBAF1F20EFE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4608CD285;
	Sun, 26 Nov 2023 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a9a14tQ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D61AEA;
	Sun, 26 Nov 2023 04:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=H82zLqgdzfDpBHLXwBaMr5xkqQBqQ3VwCLTS3bTb4pY=; b=a9a14tQ9Bn66Bjt7AbTBiihW2G
	+UsWfrRjcvgJOQ24FLJ6HINKS0zpT3BzjHHPJPR+qfiwXSXtUbDbuY2pywPzEJTHeQZMnoocQCtMp
	zWNS3dqAz/fBLZ+nYGHD2R75AdYeyApAKyu1+MbeWw+IOODvyhnkXYr7bLEJGFFQXcLPxEHWYEXsP
	lmp1I9ZmUeebQYX1+Z0LFdbNe+C51+BOrYgqAi3KDsuHFhhGZEYI7vPqRDHTGHgDT4HiK6UBKqmyv
	iNdqvQ7KwwxXixfO/GdsOdrZyirDxBst6i6LqMojkVFlEPD7NQIh7S4NBpjCyEkZVT+EbWpOivfdA
	dKLk8ZKg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r7EXo-00BCCM-11;
	Sun, 26 Nov 2023 12:47:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/13] iomap: clear the per-folio dirty bits on all writeback failures
Date: Sun, 26 Nov 2023 13:47:08 +0100
Message-Id: <20231126124720.1249310-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231126124720.1249310-1-hch@lst.de>
References: <20231126124720.1249310-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

write_cache_pages always clear the page dirty bit before calling into the
file systems, and leaves folios with a writeback failure without the
dirty bit after return.  We also clear the per-block writeback bits for
writeback failures unless no I/O has submitted, which will leave the
folio in an inconsistent state where it doesn't have the folio dirty,
but one or more per-block dirty bits.  This seems to be due the place
where the iomap_clear_range_dirty call was inserted into the existing
not very clearly structured code when adding per-block dirty bit support
and not actually intentional.  Switch to always clearing the dirty on
writeback failure.

Fixes: 4ce02c679722 ("iomap: Add per-block dirty state tracking to improve performance")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f72df2babe561a..98d52feb220f0a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1849,10 +1849,6 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		 */
 		if (wpc->ops->discard_folio)
 			wpc->ops->discard_folio(folio, pos);
-		if (!count) {
-			folio_unlock(folio);
-			goto done;
-		}
 	}
 
 	/*
@@ -1861,6 +1857,12 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * all the dirty bits in the folio here.
 	 */
 	iomap_clear_range_dirty(folio, 0, folio_size(folio));
+
+	if (error && !count) {
+		folio_unlock(folio);
+		goto done;
+	}
+
 	folio_start_writeback(folio);
 	folio_unlock(folio);
 
-- 
2.39.2


