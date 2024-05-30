Return-Path: <linux-fsdevel+bounces-20585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037928D53C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96789B25586
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCAE176AD7;
	Thu, 30 May 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FwYVs1m/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF626158DD3
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100483; cv=none; b=rUW0Ns7+UucF4KK9nv1BS/Dda3qplA4Il0LWH6oTkgqLGc8DTr62kLeCCtHPc0MDzuimUXP/+OwRxcc/wuq3kkoSvvfNLn4jGr0Rxir41ES+t2ZN3TNfyBmM1n4LaRAoA/cctRbwsHuwpX3dHpAG1djJjc/7vbRnJ8F/z8FQxPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100483; c=relaxed/simple;
	bh=koMDs2Vu8z5aibwmSojSI8g4wOfb3cYLT2vweHqNtHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFHzrf1bkQZ9vu2SfNc/aTSZjw/1L6PKzGqe6GcrAblAgSQIfrni+Fkbdyg0TAknV5lsbra/g7VpXxuJRjpSMFuZV6+nZpRBkBFjTLQ0z+WEWDta2QGVWnNtqji4CH0g4ccf1FbVl48Oot4Wry5V9PLp/aBt2frJkJv2TWhpu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FwYVs1m/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=UFQQOkEiNJUxviR/YN/zSOcTjWprC5zQJykTTnepqQQ=; b=FwYVs1m/SkZLlsGMkm0TjK8u9R
	kSWmqe/Jf19viUcKgWZS5zOjbDLzWGvEdmsIUzftGsGnpFLvZqRIINH51K+58oTF/+jbYA1wfRayL
	LkeX5L5SV8REoN6k9Unvqj4cBiq+Ob25ZPytl/yxG9+4Bb+EoWzKV+16LikUAACEJt/FA8HmPm7hh
	b7jjebXiw6Xvmk9SUfMPOBlyVDkCsUU6b2sDlxygfL65hEaV4tpwQz0zhh1pjwnrFG+1FBZyUyU8w
	1pRscA9Qsberqpm88xNZMR4VDP/cgdEZBdHgogUKT5IPxuasJFE2G1kGXjLE3+rlahA1Der5qBI7G
	+ngN0eOA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmGz-0000000B8Kw-17Xn;
	Thu, 30 May 2024 20:21:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/16] cramfs: Convert cramfs_read_folio to use a folio
Date: Thu, 30 May 2024 21:20:55 +0100
Message-ID: <20240530202110.2653630-4-willy@infradead.org>
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

Remove the conversion back into a page and use the folio APIs throughout.
Remove the setting of PG_error instead of converting it; it is unused
by core code or by the rest of cramfs, so it serves no purpose here.
Use folio_end_read() to save an atomic operation and unify the two
exit paths.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cramfs/inode.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index d818ed1bb07e..b84d1747a020 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -811,19 +811,19 @@ static struct dentry *cramfs_lookup(struct inode *dir, struct dentry *dentry, un
 
 static int cramfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	u32 maxblock;
 	int bytes_filled;
 	void *pgdata;
+	bool success = false;
 
 	maxblock = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	bytes_filled = 0;
-	pgdata = kmap_local_page(page);
+	pgdata = kmap_local_folio(folio, 0);
 
-	if (page->index < maxblock) {
+	if (folio->index < maxblock) {
 		struct super_block *sb = inode->i_sb;
-		u32 blkptr_offset = OFFSET(inode) + page->index * 4;
+		u32 blkptr_offset = OFFSET(inode) + folio->index * 4;
 		u32 block_ptr, block_start, block_len;
 		bool uncompressed, direct;
 
@@ -844,7 +844,7 @@ static int cramfs_read_folio(struct file *file, struct folio *folio)
 			if (uncompressed) {
 				block_len = PAGE_SIZE;
 				/* if last block: cap to file length */
-				if (page->index == maxblock - 1)
+				if (folio->index == maxblock - 1)
 					block_len =
 						offset_in_page(inode->i_size);
 			} else {
@@ -861,7 +861,7 @@ static int cramfs_read_folio(struct file *file, struct folio *folio)
 			 * from the previous block's pointer.
 			 */
 			block_start = OFFSET(inode) + maxblock * 4;
-			if (page->index)
+			if (folio->index)
 				block_start = *(u32 *)
 					cramfs_read(sb, blkptr_offset - 4, 4);
 			/* Beware... previous ptr might be a direct ptr */
@@ -906,17 +906,12 @@ static int cramfs_read_folio(struct file *file, struct folio *folio)
 	}
 
 	memset(pgdata + bytes_filled, 0, PAGE_SIZE - bytes_filled);
-	flush_dcache_page(page);
-	kunmap_local(pgdata);
-	SetPageUptodate(page);
-	unlock_page(page);
-	return 0;
+	flush_dcache_folio(folio);
 
+	success = true;
 err:
 	kunmap_local(pgdata);
-	ClearPageUptodate(page);
-	SetPageError(page);
-	unlock_page(page);
+	folio_end_read(folio, success);
 	return 0;
 }
 
-- 
2.43.0


