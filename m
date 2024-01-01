Return-Path: <linux-fsdevel+bounces-7055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91597821369
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 10:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CD32824F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 09:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579CF1870;
	Mon,  1 Jan 2024 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YjUYuimm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A3917C9
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jan 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=FkmsJLu1w69IiF8eTiTiHXT+0vGvjgOW05eg/Bz+S/k=; b=YjUYuimmQKgSTwM0r9/HrrtsEb
	HG7zE727QFJu2DRMHyCog5Td4y7+H/16NFSW1HWTS9Syy0MZtc6Bzx/xUkL1RQWemSFTA7cRutrgl
	+qOeEuDxafuEtzlX8P79HssdkWAoUDdVe0rx0tcMD9FxJ4nc0IyGBR4VUx40c/5VVkqL307BI1JDD
	pUyuchcu2Zgd8xYFROwLUpZa8W2iyLwOF8URPCpof+ZGVk3AM1ShPpfDcZ+jnE+LCDL4L4tl0p2LV
	P+Mfmrw2cMNOvNzifuQB+cXhvKxZAhQKyCcqAMMfS065B06zh1pIqYTeim4966rCvx1yutaVzncSm
	qLCKlz/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rKElF-008SlY-VZ; Mon, 01 Jan 2024 09:39:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH] buffer: Fix unintended successful return
Date: Mon,  1 Jan 2024 09:38:48 +0000
Message-Id: <20240101093848.2017115-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If try_to_free_buffers() succeeded and then folio_alloc_buffers()
failed, grow_dev_folio() would return success.  This would be incorrect;
memory allocation failure is supposed to result in a failure.  It's a
harmless bug; the caller will simply go around the loop one more time
and grow_dev_folio() will correctly return a failure that time.  But it
was an unintended change and looks like a more serious bug than it is.

While I'm in here, improve the commentary about why we return success
even though we failed.

Reported-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d5ce6b29c893..d3bcf601d3e5 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1028,8 +1028,8 @@ static sector_t folio_init_buffers(struct folio *folio,
  *
  * This is used purely for blockdev mappings.
  *
- * Returns false if we have a 'permanent' failure.  Returns true if
- * we succeeded, or the caller should retry.
+ * Returns false if we have a failure which cannot be cured by retrying
+ * without sleeping.  Returns true if we succeeded, or the caller should retry.
  */
 static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 		pgoff_t index, unsigned size, gfp_t gfp)
@@ -1051,10 +1051,17 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 			goto unlock;
 		}
 
-		/* Caller should retry if this call fails */
-		end_block = ~0ULL;
-		if (!try_to_free_buffers(folio))
+		/*
+		 * Retrying may succeed; for example the folio may finish
+		 * writeback, or buffers may be cleaned.  This should not
+		 * happen very often; maybe we have old buffers attached to
+		 * this blockdev's page cache and we're trying to change
+		 * the block size?
+		 */
+		if (!try_to_free_buffers(folio)) {
+			end_block = ~0ULL;
 			goto unlock;
+		}
 	}
 
 	bh = folio_alloc_buffers(folio, size, gfp | __GFP_ACCOUNT);
-- 
2.43.0


