Return-Path: <linux-fsdevel+bounces-5113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B62808350
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4231F22406
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5F328CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IhXKePS7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0506D5B;
	Wed,  6 Dec 2023 23:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vbU0cp4U8G5+R2oYHimlhM4sTS1r6QMLrwyCKAbKiO8=; b=IhXKePS7ISnw5zMmzekQxqFqH2
	eUqwjxBqC9/76MSF9WDD0JOv4oqyrME1z+CcS8wni4dXbjGllGKkRjPvH3FTUaEBz3ewPrQlPEIv0
	aAR+9nY5QnGAN+ZZ8ziveU090vKiDqQZ2NObi6HWkoKUuBbfrBfnt3hB0MloNk5GYOI+0QJxFbbXR
	756NxsYBczFYI70BPjoYo4jkx8naiUyJN8/oTn2ztQH2D7REpr8CDOf+HxCeh/W6RsKWoPodIwO83
	BE0+Yf7TpBFoKBT3nHliSG96B9fTxs0IMQ/9QZZyM/qPpyzGyjtJNvUcONiucm5v/19rKCuORXNy6
	edzcVvGQ==;
Received: from [2001:4bb8:191:e7ca:4bf6:cea4:9bbf:8b02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rB8n8-00C4yx-0g;
	Thu, 07 Dec 2023 07:27:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 04/14] iomap: move the PF_MEMALLOC check to iomap_writepages
Date: Thu,  7 Dec 2023 08:27:00 +0100
Message-Id: <20231207072710.176093-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207072710.176093-1-hch@lst.de>
References: <20231207072710.176093-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The iomap writepage implementation has been removed in commit
478af190cb6c ("iomap: remove iomap_writepage") and this code is now only
called through ->writepages which never happens from memory reclaim.

Nove the check from iomap_do_writepage to iomap_writepages so that is
only called once per ->writepage invocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dc5039cdacd928..ef99418f5a7a73 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1912,20 +1912,6 @@ static int iomap_do_writepage(struct folio *folio,
 
 	trace_iomap_writepage(inode, folio_pos(folio), folio_size(folio));
 
-	/*
-	 * Refuse to write the folio out if we're called from reclaim context.
-	 *
-	 * This avoids stack overflows when called from deeply used stacks in
-	 * random callers for direct reclaim or memcg reclaim.  We explicitly
-	 * allow reclaim from kswapd as the stack usage there is relatively low.
-	 *
-	 * This should never happen except in the case of a VM regression so
-	 * warn about it.
-	 */
-	if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
-			PF_MEMALLOC))
-		goto redirty;
-
 	/*
 	 * Is this folio beyond the end of the file?
 	 *
@@ -1991,8 +1977,6 @@ static int iomap_do_writepage(struct folio *folio,
 
 	return iomap_writepage_map(wpc, wbc, inode, folio, end_pos);
 
-redirty:
-	folio_redirty_for_writepage(wbc, folio);
 unlock:
 	folio_unlock(folio);
 	return 0;
@@ -2005,6 +1989,14 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 {
 	int			ret;
 
+	/*
+	 * Writeback from reclaim context should never happen except in the case
+	 * of a VM regression so warn about it and refuse to write the data.
+	 */
+	if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC | PF_KSWAPD)) ==
+			PF_MEMALLOC))
+		return -EIO;
+
 	wpc->ops = ops;
 	ret = write_cache_pages(mapping, wbc, iomap_do_writepage, wpc);
 	if (!wpc->ioend)
-- 
2.39.2


