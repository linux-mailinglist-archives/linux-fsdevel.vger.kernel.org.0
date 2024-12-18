Return-Path: <linux-fsdevel+bounces-37691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B0B9F5CD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 03:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCCA37A24F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 02:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360ED13C3C2;
	Wed, 18 Dec 2024 02:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3qaC05k7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429AA4642D;
	Wed, 18 Dec 2024 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734488792; cv=none; b=AQ27NSaXKayOeU/JzgSYFj7IqeVbMgLKEWXXgGHLksnt98clY6OvDH0HUakkkEnuMFRZDaFLovY5hiwHtwBGsCIicn4O7xXwdA0khTB7vU2U2sP6McjIdE+FGlKH1rmgJtqdw5FyaVJSYzf1gt+xxKQmvqhwjWUVM2o7g5GKjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734488792; c=relaxed/simple;
	bh=22eXPXm/5BoUDqAxOXUyQl9RxqIqzFk5NXYU3k/1j4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wlp+9l10bTQlp4hitMDxXd90qQdkDQCT4BFSB2Av1CrUcf5/sEgYgmQ+hXxcF3LCj2m2imLNVGiOdu7jhpoHTIzYtaCA5zfLaNilU2kBARt61PgUcweDoEH8O3rJEM0WeWBSDd2G9wtGbdnl+eEKgulJyT+TuxsQBe6TnRJ1Ab8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3qaC05k7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KAcXP1LLN9RIr4LUuyxBmqGvK7FM1npzcMSwryY+7ME=; b=3qaC05k7YgxBzQwXc9ZAOl7DAT
	k61pID00MJyziEMK2a/rV9rNOMTAiDPENc2QdtSsXU1PRi68fxGTFDy8dAn848eYwuVU4g6SzLUFN
	vwenXhO4VWLRUjJOHA3Z7Qyf6Yy6knyLtBAB/LupK9s0sdcSjpz8D53qvxjRTzgIcHp/10eV1u5jO
	lrh0jIW2l6IJq0zzB1AqB3idKyQzCI2cWnmBL4YFePKdAnGbpv/fMBW6odvahgNV7DTzfDcS2NF8b
	dghX2PPebP4c53s6nR+FcNy2avvEOLCpIjKRipbwyxpSMp2nQsdx43cWKgWU/lxo2IP9GVtm1W1/m
	BHnGwU/A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjlc-0000000FOFU-168x;
	Wed, 18 Dec 2024 02:26:28 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@suse.de,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org,
	kbusch@kernel.org
Cc: john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH 2/5] fs/buffer: simplify block_read_full_folio() with bh_offset()
Date: Tue, 17 Dec 2024 18:26:23 -0800
Message-ID: <20241218022626.3668119-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218022626.3668119-1-mcgrof@kernel.org>
References: <20241218022626.3668119-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Remove the temporary variable i on the iteration of all buffer heads
on a folio and just use bh_offset(bh) to simplify the loop.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 7c6aac0742a6..8baf87db110d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2410,7 +2410,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	sector_t iblock, lblock;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
 	size_t blocksize;
-	int nr, i;
+	int nr;
 	int fully_mapped = 1;
 	bool page_error = false;
 	loff_t limit = i_size_read(inode);
@@ -2428,7 +2428,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	lblock = div_u64(limit + blocksize - 1, blocksize);
 	bh = head;
 	nr = 0;
-	i = 0;
 
 	/* Stage one - collect buffer heads we need issue a read for */
 	do {
@@ -2446,7 +2445,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 					page_error = true;
 			}
 			if (!buffer_mapped(bh)) {
-				folio_zero_range(folio, i * blocksize,
+				folio_zero_range(folio, bh_offset(bh),
 						blocksize);
 				if (!err)
 					set_buffer_uptodate(bh);
@@ -2460,7 +2459,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 				continue;
 		}
 		arr[nr++] = bh;
-	} while (i++, iblock++, (bh = bh->b_this_page) != head);
+	} while (iblock++, (bh = bh->b_this_page) != head);
 
 	bh_read_batch_async(folio, nr, arr, fully_mapped, nr == 0, page_error);
 
-- 
2.43.0


