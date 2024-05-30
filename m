Return-Path: <linux-fsdevel+bounces-20587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A328D53CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495DEB25549
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F1217B50C;
	Thu, 30 May 2024 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d6GDWEHm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E2E176ACA
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100485; cv=none; b=k+sadiyjehrwWLKWKnnTwL2S1HqCUoOm1PbcDImbpQMyrWZ+Bk8/vNt3w6ZEOv6fmNYsNOcaEwn6KeREtVatJ8Wicg7fCLJy//09oKDH7TW1jwssc4onPxFxkacjNI55HH1KRB7Y/I11oNj2A97nAQQaolp9y3zMcGw4s1OvCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100485; c=relaxed/simple;
	bh=rI9d1HVrZWFdNh+tkuaswx/LDTv123ObI5TZxLQNISY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3JCfv/jSAP8FnV0rdZK7w2fwTV9d/Vp4dRtKgZ4ZVYc5vrFCTT/u52PGjQGidqSFGkd0QDcQR4wKgV/dzcOWlbqmKmrbIgTMA4+qmuw1Rq90e1hksyXsyTmKEEeviJkeJRorokxq1z6HrO4jXIVgpp3oFxXyCpzqzISOyNIzFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d6GDWEHm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=IiUZzllF8/N0Vx665SJISBH9NzvoaiBdnUIxv8cYqnI=; b=d6GDWEHmD12A7bsCJh+cBgfJH4
	x4T8PgQRT6PWGi/qhBN5qlUXeJeEUsJd6kFUGF3mG/L+Mcuu97dWAMGrcu8a3DbdNkxr5Fd275B4v
	K7FShkct7O2haz+lAfAhGZf9H3Vr6IMlNWU6SSo5nbKLeEsLjQXAxFn0EdyGGIWfMYL8ALVgGqwxG
	AICqauldTdt9mpoftucQCNe5JLl7oo1LC4mmEsaI7Cc8ERO6B0JKa8jXuIDaGc0sNl4hIOAY+2ZhW
	WPqHsvPCvXQ8TbCL0HVJqTQ4ZbOnQdQIGCrP9wD5cAOFevKH8ScKJzK8nbgLdCkEM04YXc3Xyqvrp
	RrfkEVow==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmH0-0000000B8Lx-426n;
	Thu, 30 May 2024 20:21:19 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/16] buffer: Remove calls to set and clear the folio error flag
Date: Thu, 30 May 2024 21:21:08 +0100
Message-ID: <20240530202110.2653630-17-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240530202110.2653630-1-willy@infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
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
index 8c19e705b9c3..dbe8f411ce52 100644
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
@@ -2405,10 +2402,8 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
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


