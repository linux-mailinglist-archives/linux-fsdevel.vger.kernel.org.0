Return-Path: <linux-fsdevel+bounces-17349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DD68AB902
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C9E1C20F49
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2161D266;
	Sat, 20 Apr 2024 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C5wbPShr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C118041
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581465; cv=none; b=AisGN1kQS8wYp4kc+PR/xDntAbV63f6Pe0Gds5+GAVwTq8FA7bsvhBOf6VkS7mej7V+wZy6X3VKLEVZxwPnlsA7j56UrIfiuxvkVoCdRUytRl6jJzMVgWFkdflm3OhZ9LjHLXx5wBSVLgiR73nqKbAOxS4rG9IyDV0MZOUUiaKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581465; c=relaxed/simple;
	bh=jmkLAvPrdLWlWqTzNE06H6Rn/KwJNLwtwvybi/ipsCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cb550VVg+vw/qZrnlIY2tX4lslgnjKGt3uQPD/SD3SF1/X259g7+DXQqQ1TM+kZUkurzLCXVbp/WgFE1k4ga/cE9Gwh3MQ2TSAUT78OUPW64K7gnn1+n+cR9l51SeojLiqSQa4n9eCUwIu8i09u7JPzQuhJZfd/VdiN1J5MeNc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C5wbPShr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=KGeOgQ8YggiCIqvYt1WMf5unqJXOMCcuZ08I4TBl4Tk=; b=C5wbPShrtknnLOHiIrrkDv3jXe
	XQPvq0JIRQwL+Cth8/Xzix5UgurkM1bLigU3ckvdf50ylXKh2QeJ+IhoskYcoph842c4tTcBbIRJk
	qZ+t8mTJJ9zkADeKOlUaAHQ/31WH8AJ/oRbxryyl9wOpPi3dqjouVAOzRzu1ekyC47vgVfft3JHR+
	y9YiDpWU8fWDTnpvUm+3lZGlMsqxL7Tx3/28N0IMzSh5bX85AijCxzv1adAh32MAFT8MZ9Y6yZvg9
	mhMbc15TyisITysj5BKDFYLcxZDcZLM18/J+0/kgwJFSMr0fApT6m4zWqCHgCtarTgkPL1u79LEnl
	BtjUmdkA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0of-000000095gq-1xMr;
	Sat, 20 Apr 2024 02:51:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 28/30] buffer: Remove calls to set and clear the folio error flag
Date: Sat, 20 Apr 2024 03:50:23 +0100
Message-ID: <20240420025029.2166544-29-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The folio error flag is not tested anywhere, so we can stop setting
and clearing it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c |  7 +------
 fs/mpage.c  | 13 +++----------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 592741d4b88a..26face6ccb3a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -258,7 +258,6 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	} else {
 		clear_buffer_uptodate(bh);
 		buffer_io_error(bh, ", async page read");
-		folio_set_error(folio);
 	}
 
 	/*
@@ -391,7 +390,6 @@ static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 		buffer_io_error(bh, ", lost async page write");
 		mark_buffer_write_io_error(bh);
 		clear_buffer_uptodate(bh);
-		folio_set_error(folio);
 	}
 
 	first = folio_buffers(folio);
@@ -1960,7 +1958,6 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 			clear_buffer_dirty(bh);
 		}
 	} while ((bh = bh->b_this_page) != head);
-	folio_set_error(folio);
 	BUG_ON(folio_test_writeback(folio));
 	mapping_set_error(folio->mapping, err);
 	folio_start_writeback(folio);
@@ -2406,10 +2403,8 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 			if (iblock < lblock) {
 				WARN_ON(bh->b_size != blocksize);
 				err = get_block(inode, iblock, bh, 0);
-				if (err) {
-					folio_set_error(folio);
+				if (err)
 					page_error = true;
-				}
 			}
 			if (!buffer_mapped(bh)) {
 				folio_zero_range(folio, i * blocksize,
diff --git a/fs/mpage.c b/fs/mpage.c
index fa8b99a199fa..b5b5ddf9d513 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -48,13 +48,8 @@ static void mpage_read_end_io(struct bio *bio)
 	struct folio_iter fi;
 	int err = blk_status_to_errno(bio->bi_status);
 
-	bio_for_each_folio_all(fi, bio) {
-		if (err)
-			folio_set_error(fi.folio);
-		else
-			folio_mark_uptodate(fi.folio);
-		folio_unlock(fi.folio);
-	}
+	bio_for_each_folio_all(fi, bio)
+		folio_end_read(fi.folio, err == 0);
 
 	bio_put(bio);
 }
@@ -65,10 +60,8 @@ static void mpage_write_end_io(struct bio *bio)
 	int err = blk_status_to_errno(bio->bi_status);
 
 	bio_for_each_folio_all(fi, bio) {
-		if (err) {
-			folio_set_error(fi.folio);
+		if (err)
 			mapping_set_error(fi.folio->mapping, err);
-		}
 		folio_end_writeback(fi.folio);
 	}
 
-- 
2.43.0


