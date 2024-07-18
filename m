Return-Path: <linux-fsdevel+bounces-23969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 209F79370A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 00:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6C11C2219C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29652146598;
	Thu, 18 Jul 2024 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sKmcnDHR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C015B1FB;
	Thu, 18 Jul 2024 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721341815; cv=none; b=EzeNp8KjdeE3LljD9gIagFn8RdRYltybf3lGQaOqZMfd7RePHqu3NuxI23GylMFCGs7djvsUJBRCWl0LoKb6iWw2XueyGDB6OVrXM4ypZQ727gV4GDNMFaxHEDYRYrQFnVL7Egv5QRF6XbbwiFf4GwpZGOHtME7196+aJA2KV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721341815; c=relaxed/simple;
	bh=xXbDKc8Yh3b5P3gYo8YX3u8p27q+YFrAwJyJ6zB8Yto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Be+lZNhOg4qlCnbb7OgSvxXrd5+SBM0veMy6rdjpUmmfZ6tgxJSMthdTnBZWaiBJJC3dhzFRzt4rokcK4VopJjpnrcV8uSGaiCHDvH81O8fL5oysAgcMuBv0M4GOIDMlH/ciVQUtIQx7y0aS9fidNNKgGLKADT43GEQyhYuv4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sKmcnDHR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+NJMSMAX7aG95L+HfUpIkXRtG072jixgCRh36PazJ9w=; b=sKmcnDHR8XhJaq7PUUNFKz/4Qu
	T5a6y17edFBP/6+dmacpYCDAUJoAJmfRQJzrP5eYpxV64HYdHzxzyKJUvDnx8jCqXvHUHEMA4kNZt
	7AVcn6OP+5A8t8dgkmgrD7nWCqElv5LBY59jaSaREycT/9WS4jP7UffDAns7mmqBgWjlr8fBtRNRB
	xY5DsFs6jfqA8DR60jMuK+W5PNj1cOJ4CTQNFzT9U9KvYGMNxr7Uh/JBENXzWfN7GI4Eqjh05cxdl
	avmkBr6+3p/QuboroCe25y6fzbmwxvYgTCYMeS9xBBBJcsgDiQ/H3rRXaWNNVaHUjqURPbFyaPzkx
	rTs15nkg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUZdW-00000002O0O-47Z3;
	Thu, 18 Jul 2024 22:30:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 2/4] ext4: Pipeline buffer reads in mext_page_mkuptodate()
Date: Thu, 18 Jul 2024 23:30:00 +0100
Message-ID: <20240718223005.568869-2-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718223005.568869-1-willy@infradead.org>
References: <20240718223005.568869-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of synchronously reading one buffer at a time, submit reads
as we walk the buffers in the first loop, then wait for them in the
second loop.  This should be significantly more efficient, particularly
on HDDs, but I have not measured.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/move_extent.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 204f53b23622..6d651ad788ac 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -174,7 +174,9 @@ mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
 	sector_t block;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
 	unsigned int blocksize, block_start, block_end;
-	int i, err,  nr = 0, partial = 0;
+	int i, nr = 0;
+	bool partial = false;
+
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(folio_test_writeback(folio));
 
@@ -192,13 +194,13 @@ mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
 			if (!buffer_uptodate(bh))
-				partial = 1;
+				partial = true;
 			continue;
 		}
 		if (buffer_uptodate(bh))
 			continue;
 		if (!buffer_mapped(bh)) {
-			err = ext4_get_block(inode, block, bh, 0);
+			int err = ext4_get_block(inode, block, bh, 0);
 			if (err)
 				return err;
 			if (!buffer_mapped(bh)) {
@@ -207,6 +209,12 @@ mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
 				continue;
 			}
 		}
+		lock_buffer(bh);
+		if (buffer_uptodate(bh)) {
+			unlock_buffer(bh);
+			continue;
+		}
+		ext4_read_bh_nowait(bh, 0, NULL);
 		BUG_ON(nr >= MAX_BUF_PER_PAGE);
 		arr[nr++] = bh;
 	}
@@ -216,11 +224,10 @@ mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
 
 	for (i = 0; i < nr; i++) {
 		bh = arr[i];
-		if (!bh_uptodate_or_lock(bh)) {
-			err = ext4_read_bh(bh, 0, NULL);
-			if (err)
-				return err;
-		}
+		wait_on_buffer(bh);
+		if (buffer_uptodate(bh))
+			continue;
+		return -EIO;
 	}
 out:
 	if (!partial)
-- 
2.43.0


