Return-Path: <linux-fsdevel+bounces-26212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB71956039
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 01:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703C81F21EC3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 23:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A3715575D;
	Sun, 18 Aug 2024 23:58:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-06.prod.sxb1.secureserver.net (sxb1plsmtpa01-06.prod.sxb1.secureserver.net [188.121.53.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C281A291
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Aug 2024 23:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724025537; cv=none; b=KR7nhaJwE7AEfSwi0PyudqYwS1+lRDBitz7FCFQ+RHPBXKcGSp1mfkeUrHrmcAtu3l7OO8FroLhNJtgM87mEPzc3ohDQ4h1WNOHaaV3jbKMZjhGyKcboPQk9ZnSYHdxsCC5WIn9ry8MUUASSxM1p/gmCwIPr8VxMnqYADrPWcRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724025537; c=relaxed/simple;
	bh=G73OEgJWv98tJ1N7a3jIpsciRVOfJTKmyNgrnC4lwWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWKkxLfdpCaJbTcfYQjmSKY3LH+4jMqTXiNVZcB+xUPjJ2NvOsZOzapk5LtSzdqHq5gw7qpYf+ugdXXmQzwAWvzzF4g+49XxkAEWnFYHLNkhLdujbyHB5mtzHmSCdWSanMvuJKxnlnkqq3a/wNn7H8+Uu4ACUnkSCgHPYxsSYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id fpn7sTYC0QGHUfpnKsxSIV; Sun, 18 Aug 2024 16:58:47 -0700
X-CMAE-Analysis: v=2.4 cv=LJ6tQ4W9 c=1 sm=1 tr=0 ts=66c28ab7
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=anrbtZqQEueed_iD4xoA:9 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: willy@infradead.org,
	lizetao1@huawei.com,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 1/4] Squashfs: Update page_actor to not use page->index
Date: Mon, 19 Aug 2024 00:58:44 +0100
Message-Id: <20240818235847.170468-2-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240818235847.170468-1-phillip@squashfs.org.uk>
References: <20240818235847.170468-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFSx/F/6C0Y7TeC/JaJpJkGg+I37+UT52v5GqI7/FTbq0zwkBaiVIG/Mo4HU28wok1h3/vD2rspnh6hAyd8rkSz9PAU1tpLlGA5MzG7WuOQCh4/yv/hD
 E3ljf9rAmfPBwjjm5HRgF5B1E7BhTJfnz4msf8TTjr6mrHs9ZvlzfbsldzFVMi9CRGFHkZgXgeNrD6PNHupxtD096C5h+OiYekKKDPueQIFlu96rHWzJD2Zy
 b8u6/26klW5FGcBzTyP553KjBXMYDTC6w2El51ntvM+BzC+Yj0MILn9I70bcrL6jOUtgpuaWgxs0e+UQ8LZMucPC+cL1cNpX1rJ2+q1DiPg0SWH4eIoW1mm5
 oNz0pfbZhrCx0SaEDeUPMlbN67C8aHouB4mT3rKtJZ6Jv0eO9rQ=

This commit removes an unnecessary use of page->index,
and moves the other use over to folio->index.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/file.c        |  2 +-
 fs/squashfs/file_direct.c |  3 ++-
 fs/squashfs/page_actor.c  | 11 ++++++++---
 fs/squashfs/page_actor.h  |  3 ++-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index a8c1e7f9a609..2b6b63f4ccd1 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -589,7 +589,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
 			goto skip_pages;
 
 		actor = squashfs_page_actor_init_special(msblk, pages, nr_pages,
-							 expected);
+							expected, start);
 		if (!actor)
 			goto skip_pages;
 
diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index 2a689ce71de9..0586e6ba94bf 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -67,7 +67,8 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	 * Create a "page actor" which will kmap and kunmap the
 	 * page cache pages appropriately within the decompressor
 	 */
-	actor = squashfs_page_actor_init_special(msblk, page, pages, expected);
+	actor = squashfs_page_actor_init_special(msblk, page, pages, expected,
+						start_index << PAGE_SHIFT);
 	if (actor == NULL)
 		goto out;
 
diff --git a/fs/squashfs/page_actor.c b/fs/squashfs/page_actor.c
index 81af6c4ca115..2b3e807d4dea 100644
--- a/fs/squashfs/page_actor.c
+++ b/fs/squashfs/page_actor.c
@@ -60,6 +60,11 @@ struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
 }
 
 /* Implementation of page_actor for decompressing directly into page cache. */
+static loff_t page_next_index(struct squashfs_page_actor *actor)
+{
+	return page_folio(actor->page[actor->next_page])->index;
+}
+
 static void *handle_next_page(struct squashfs_page_actor *actor)
 {
 	int max_pages = (actor->length + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -68,7 +73,7 @@ static void *handle_next_page(struct squashfs_page_actor *actor)
 		return NULL;
 
 	if ((actor->next_page == actor->pages) ||
-			(actor->next_index != actor->page[actor->next_page]->index)) {
+			(actor->next_index != page_next_index(actor))) {
 		actor->next_index++;
 		actor->returned_pages++;
 		actor->last_page = NULL;
@@ -103,7 +108,7 @@ static void direct_finish_page(struct squashfs_page_actor *actor)
 }
 
 struct squashfs_page_actor *squashfs_page_actor_init_special(struct squashfs_sb_info *msblk,
-	struct page **page, int pages, int length)
+	struct page **page, int pages, int length, loff_t start_index)
 {
 	struct squashfs_page_actor *actor = kmalloc(sizeof(*actor), GFP_KERNEL);
 
@@ -125,7 +130,7 @@ struct squashfs_page_actor *squashfs_page_actor_init_special(struct squashfs_sb_
 	actor->pages = pages;
 	actor->next_page = 0;
 	actor->returned_pages = 0;
-	actor->next_index = page[0]->index & ~((1 << (msblk->block_log - PAGE_SHIFT)) - 1);
+	actor->next_index = start_index >> PAGE_SHIFT;
 	actor->pageaddr = NULL;
 	actor->last_page = NULL;
 	actor->alloc_buffer = msblk->decompressor->alloc_buffer;
diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
index 97d4983559b1..c6d837f0e9ca 100644
--- a/fs/squashfs/page_actor.h
+++ b/fs/squashfs/page_actor.h
@@ -29,7 +29,8 @@ extern struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
 				int pages, int length);
 extern struct squashfs_page_actor *squashfs_page_actor_init_special(
 				struct squashfs_sb_info *msblk,
-				struct page **page, int pages, int length);
+				struct page **page, int pages, int length,
+				loff_t start_index);
 static inline struct page *squashfs_page_actor_free(struct squashfs_page_actor *actor)
 {
 	struct page *last_page = actor->last_page;
-- 
2.39.2


