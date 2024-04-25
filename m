Return-Path: <linux-fsdevel+bounces-17780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA58B22B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02FCFB29110
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB15149E04;
	Thu, 25 Apr 2024 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOs99D62"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E8149C6D;
	Thu, 25 Apr 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051754; cv=none; b=WCJNO3pewQSGfdmFO/lWuF3vWvzMBpe7NiwIRCgrbv38gIpzm2iSYd7dkQ9U+PkjwouRwT4/zZrfD3btLAyczmljXCIGns2oZZ+5+FEl9Cei5KAnRYnPSjKWj3YarwpcJsqGudN5fkrWaBSPQLFPSSJxSkKv8Thgex622m7PVH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051754; c=relaxed/simple;
	bh=I40xLpUAHIctlLAtpBSyFlGrk8n2E8bYdUoDPm5XAog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSSiX7P5IWVHq/7Yy6FsXdxOU4AxCt1gVaLhSVFl5nwKHXbETN2qkrydGd9ibe9ABaC7bLgwzO/GY7u9L6ie1Xq69ZLUt2nvJnQDFPQAVJwE3OW2r2u4tU55UHzMRS8dhs11Y4AsvpzNo6ffXBiDBx19xbXtI9oFySUKs7p03D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOs99D62; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed32341906so991406b3a.1;
        Thu, 25 Apr 2024 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714051751; x=1714656551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQsc0k300b3kctLYqSVw3Z17BFFR+ZMwOgu7lBfzzbs=;
        b=gOs99D62RtouVZdnHJfUzeSgqiZdonMD0CwRPDlaPzrTehmPI7WweuSj2MxKy9TM+m
         Bgs3Bxvzt/1+RqL1gYgTHv/44FA7BBYJNOpVrgcTn54MuHspzRl3EnLvbNJ5lFItfrXA
         afqHGUBoFHvHKZvyzZohOn2AFhtslKeT6Wfuh1u0PwAM29fXx6cu/XjODItruFGka9aK
         J2FtQRFOfGDCRHXPTJRMkFK0A8/SbnXWTWg//Qbk/WUAFnwGV6RiUwRPuouR7Y160CfL
         M60G3Xn/vRkgTtw7rvwkuuGIUIlayO0BCOIiEcUWKVYAe1qkvJlKWUvuzRtQ8ZqoJc+p
         TaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714051751; x=1714656551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQsc0k300b3kctLYqSVw3Z17BFFR+ZMwOgu7lBfzzbs=;
        b=FqASZNALZOZxLXwbRyVP96gc8XMWPySQELcYsE/Y3GmGgmYgq3MkBywqv26QcEcFV+
         34qVT8k6801AgJ1wp/jyTs/Ci4JDXZ+8J/PIyQspr2GNbOU2J2C+NgXMJOXYzpUdiE/U
         4QfqoPuXJQcTcG8fUUzdkKu/w0TEnbmFfe2fzlj+CXuIjL7qOMRs6ee70SXmGCwvA1e9
         rRvve2ey3RR/Oieka45Z9cBa0sydFMcXU/LeVUF8mq9KDY2iagrz68XHoFB3vFcOctMy
         /zvsJTqAqwDQq8P5JzxRQWMxtWsc2GMSWe3G1mDGwekbx8XfkkUIohwqWmOteHq+zWtw
         V/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTZYNBs3RHMb2dvGNWQnIAMcnZMBq3c7dVjVR1nnhcnYm15+ISBidX8tzbGfkner51jAMx6ARyGvGu21OyKxiq1GtP9TBauzq0
X-Gm-Message-State: AOJu0YwLl4fE/wEMuwyi1Sv/F0oAuDVx+kZVVC3Iym3yP7FDte9BFqwl
	lbA42BUewYlHt2vwa0FaWxaJhAb+m05px+M0FrNWY4VxuoVlBRyGlyMlBkjn
X-Google-Smtp-Source: AGHT+IFxQWdbYGmmaQOyPDzj671xQy106G3swzYQOnPFN4SzBpQxFJem3ERZHsIDaQCps8RobdfOww==
X-Received: by 2002:a05:6a00:1399:b0:6ea:914e:a108 with SMTP id t25-20020a056a00139900b006ea914ea108mr6884818pfg.12.1714051751384;
        Thu, 25 Apr 2024 06:29:11 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id s15-20020a62e70f000000b006f260fb17e5sm9764518pfh.141.2024.04.25.06.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:29:10 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [RFCv3 2/7] ext2: Convert ext2 regular file buffered I/O to use iomap
Date: Thu, 25 Apr 2024 18:58:46 +0530
Message-ID: <54d3fdabeb82e494fab83204cd49e75b58ef298e.1714046808.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714046808.git.ritesh.list@gmail.com>
References: <cover.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch converts ext2 regular file's buffered-io path to use iomap.
- buffered-io path using iomap_file_buffered_write
- DIO fallback to buffered-io now uses iomap_file_buffered_write
- writeback path now uses a new aops - ext2_file_aops
- truncate now uses iomap_truncate_page
- mmap path of ext2 continues to use generic_file_vm_ops

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/file.c  | 20 ++++++++++++--
 fs/ext2/inode.c | 69 ++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 4ddc36f4dbd4..ee5cd4a2f24f 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -252,7 +252,7 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 		iocb->ki_flags &= ~IOCB_DIRECT;
 		pos = iocb->ki_pos;
-		status = generic_perform_write(iocb, from);
+		status = iomap_file_buffered_write(iocb, from, &ext2_iomap_ops);
 		if (unlikely(status < 0)) {
 			ret = status;
 			goto out_unlock;
@@ -278,6 +278,22 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return ret;
 }
 
+static ssize_t ext2_buffered_write_iter(struct kiocb *iocb,
+					struct iov_iter *from)
+{
+	ssize_t ret = 0;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	inode_lock(inode);
+	ret = generic_write_checks(iocb, from);
+	if (ret > 0)
+		ret = iomap_file_buffered_write(iocb, from, &ext2_iomap_ops);
+	inode_unlock(inode);
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+	return ret;
+}
+
 static ssize_t ext2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 #ifdef CONFIG_FS_DAX
@@ -299,7 +315,7 @@ static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_DIRECT)
 		return ext2_dio_write_iter(iocb, from);
 
-	return generic_file_write_iter(iocb, from);
+	return ext2_buffered_write_iter(iocb, from);
 }
 
 const struct file_operations ext2_file_operations = {
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index c4de3a94c4b2..f90d280025d9 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -877,10 +877,14 @@ ext2_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 	if ((flags & IOMAP_DIRECT) && (flags & IOMAP_WRITE) && written == 0)
 		return -ENOTBLK;
 
-	if (iomap->type == IOMAP_MAPPED &&
-	    written < length &&
-	    (flags & IOMAP_WRITE))
+	if (iomap->type == IOMAP_MAPPED && written < length &&
+	   (flags & IOMAP_WRITE)) {
 		ext2_write_failed(inode->i_mapping, offset + length);
+		return 0;
+	}
+
+	if (iomap->flags & IOMAP_F_SIZE_CHANGED)
+		mark_inode_dirty(inode);
 	return 0;
 }
 
@@ -912,6 +916,16 @@ static void ext2_readahead(struct readahead_control *rac)
 	mpage_readahead(rac, ext2_get_block);
 }
 
+static int ext2_file_read_folio(struct file *file, struct folio *folio)
+{
+	return iomap_read_folio(folio, &ext2_iomap_ops);
+}
+
+static void ext2_file_readahead(struct readahead_control *rac)
+{
+	iomap_readahead(rac, &ext2_iomap_ops);
+}
+
 static int
 ext2_write_begin(struct file *file, struct address_space *mapping,
 		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
@@ -941,12 +955,41 @@ static sector_t ext2_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping,block,ext2_get_block);
 }
 
+static sector_t ext2_file_bmap(struct address_space *mapping, sector_t block)
+{
+	return iomap_bmap(mapping, block, &ext2_iomap_ops);
+}
+
 static int
 ext2_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	return mpage_writepages(mapping, wbc, ext2_get_block);
 }
 
+static int ext2_write_map_blocks(struct iomap_writepage_ctx *wpc,
+				 struct inode *inode, loff_t offset,
+				 unsigned len)
+{
+	if (offset >= wpc->iomap.offset &&
+	    offset < wpc->iomap.offset + wpc->iomap.length)
+		return 0;
+
+	return ext2_iomap_begin(inode, offset, inode->i_sb->s_blocksize,
+				IOMAP_WRITE, &wpc->iomap, NULL);
+}
+
+static const struct iomap_writeback_ops ext2_writeback_ops = {
+	.map_blocks		= ext2_write_map_blocks,
+};
+
+static int ext2_file_writepages(struct address_space *mapping,
+				struct writeback_control *wbc)
+{
+	struct iomap_writepage_ctx wpc = { };
+
+	return iomap_writepages(mapping, wbc, &wpc, &ext2_writeback_ops);
+}
+
 static int
 ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
@@ -955,6 +998,20 @@ ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc
 	return dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
 }
 
+const struct address_space_operations ext2_file_aops = {
+	.dirty_folio		= iomap_dirty_folio,
+	.release_folio 		= iomap_release_folio,
+	.invalidate_folio	= iomap_invalidate_folio,
+	.read_folio		= ext2_file_read_folio,
+	.readahead		= ext2_file_readahead,
+	.bmap			= ext2_file_bmap,
+	.direct_IO		= noop_direct_IO,
+	.writepages		= ext2_file_writepages,
+	.migrate_folio		= filemap_migrate_folio,
+	.is_partially_uptodate	= iomap_is_partially_uptodate,
+	.error_remove_folio	= generic_error_remove_folio,
+};
+
 const struct address_space_operations ext2_aops = {
 	.dirty_folio		= block_dirty_folio,
 	.invalidate_folio	= block_invalidate_folio,
@@ -1279,8 +1336,8 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 		error = dax_truncate_page(inode, newsize, NULL,
 					  &ext2_iomap_ops);
 	else
-		error = block_truncate_page(inode->i_mapping,
-				newsize, ext2_get_block);
+		error = iomap_truncate_page(inode, newsize, NULL,
+					    &ext2_iomap_ops);
 	if (error)
 		return error;
 
@@ -1370,7 +1427,7 @@ void ext2_set_file_ops(struct inode *inode)
 	if (IS_DAX(inode))
 		inode->i_mapping->a_ops = &ext2_dax_aops;
 	else
-		inode->i_mapping->a_ops = &ext2_aops;
+		inode->i_mapping->a_ops = &ext2_file_aops;
 }
 
 struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
-- 
2.44.0


