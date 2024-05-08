Return-Path: <linux-fsdevel+bounces-19018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064768BF67C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE8A1F23BD8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79CC2030B;
	Wed,  8 May 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uc96R+QE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27FD208D1
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150696; cv=none; b=I5x0+AuGNFnDOaswUleolb2NKr2rPUmQQhM4Ax1F2fb831sMY1/fBIfjrV8R3a+h7147ildy1wPBZly0KCXOQ33Y5ej3ic6HNkUkKPLyTrMg/YAcLpTpSgeC7ixhtN9Xs01VgBDsmSRifWZbF3WtIoq1AqCTtbTss5Hh7eKQX+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150696; c=relaxed/simple;
	bh=nFVoe+lCpd4XHNXq7S3+TzB2tIQcjVNaOjFl2C6P/h8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=as9mCiMgqR0/SL6aUhJIngKFH+VA0gLIYQU/twuq/Q9+OyNcptTf5so5EF+t+FDfUIxAwB7SwEiWxX7dCcjdnqluTAu960FHR/DNrmsHYcncZq7oYqTvrusMY4NvT7JHp2+ETQ0Z/aOKs/74QwJHjE74V8FHfYIU1iiBf9AaDVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uc96R+QE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Xn25Bxka5XU8tiYI7RaTxyu9Y4+iuIijCwHM0bilPGM=; b=uc96R+QEHrATlTQR+R5BplMsIx
	Mop7BQ+4dXTCDpHWyHdVLrxvmC+lCMJmLI7x+sOI8GtWoPqOFowVL/WpwuT0OFAg//t4mx4nRhIBA
	2u6tGq5QE5Jl6d5R6cGAcuF1WKREqFuVqSsWtjsxh67G87VNyG6rEBSN/WmCOK8gA43UIxOXVpXTG
	OBXpcqu0is908WRcUCfaNIf6PfwmRGdF4ShIJ2SPq9LBJbhJP7+pqLdhRKj5P5ATWJf4Xj5OvgvLX
	+2E5ZB4qNkzf8NkhhQnglAvLblbgFtWWda2yhQNpUyOYtRkSjYVxGEeCJQJ0XCgQijdIcC355653f
	3EvY1BmQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b2r-00FvzZ-0V;
	Wed, 08 May 2024 06:44:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 2 05/10] fs/buffer.c: massage the remaining users of ->bd_inode to ->bd_mapping
Date: Wed,  8 May 2024 07:44:47 +0100
Message-Id: <20240508064452.3797817-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
References: <20240508063522.GO2118490@ZenIV>
 <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

both for ->i_blkbits and both want the address_space in question anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/buffer.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 78a4e95ba2f2..ac29e0f221bc 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -189,8 +189,8 @@ EXPORT_SYMBOL(end_buffer_write_sync);
 static struct buffer_head *
 __find_get_block_slow(struct block_device *bdev, sector_t block)
 {
-	struct inode *bd_inode = bdev->bd_inode;
-	struct address_space *bd_mapping = bd_inode->i_mapping;
+	struct address_space *bd_mapping = bdev->bd_mapping;
+	const int blkbits = bd_mapping->host->i_blkbits;
 	struct buffer_head *ret = NULL;
 	pgoff_t index;
 	struct buffer_head *bh;
@@ -199,7 +199,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	int all_mapped = 1;
 	static DEFINE_RATELIMIT_STATE(last_warned, HZ, 1);
 
-	index = ((loff_t)block << bd_inode->i_blkbits) / PAGE_SIZE;
+	index = ((loff_t)block << blkbits) / PAGE_SIZE;
 	folio = __filemap_get_folio(bd_mapping, index, FGP_ACCESSED, 0);
 	if (IS_ERR(folio))
 		goto out;
@@ -233,7 +233,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 		       (unsigned long long)block,
 		       (unsigned long long)bh->b_blocknr,
 		       bh->b_state, bh->b_size, bdev,
-		       1 << bd_inode->i_blkbits);
+		       1 << blkbits);
 	}
 out_unlock:
 	spin_unlock(&bd_mapping->i_private_lock);
@@ -1696,16 +1696,16 @@ EXPORT_SYMBOL(create_empty_buffers);
  */
 void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 {
-	struct inode *bd_inode = bdev->bd_inode;
-	struct address_space *bd_mapping = bd_inode->i_mapping;
+	struct address_space *bd_mapping = bdev->bd_mapping;
+	const int blkbits = bd_mapping->host->i_blkbits;
 	struct folio_batch fbatch;
-	pgoff_t index = ((loff_t)block << bd_inode->i_blkbits) / PAGE_SIZE;
+	pgoff_t index = ((loff_t)block << blkbits) / PAGE_SIZE;
 	pgoff_t end;
 	int i, count;
 	struct buffer_head *bh;
 	struct buffer_head *head;
 
-	end = ((loff_t)(block + len - 1) << bd_inode->i_blkbits) / PAGE_SIZE;
+	end = ((loff_t)(block + len - 1) << blkbits) / PAGE_SIZE;
 	folio_batch_init(&fbatch);
 	while (filemap_get_folios(bd_mapping, &index, end, &fbatch)) {
 		count = folio_batch_count(&fbatch);
-- 
2.39.2


