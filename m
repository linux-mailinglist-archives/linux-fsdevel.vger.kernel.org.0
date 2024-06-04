Return-Path: <linux-fsdevel+bounces-20898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54398FAA6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9D3FB21EFE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757A4137936;
	Tue,  4 Jun 2024 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hanyang-ac-kr.20230601.gappssmtp.com header.i=@hanyang-ac-kr.20230601.gappssmtp.com header.b="kG/DR6Hd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D219137746
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717481214; cv=none; b=l4gLeKfeGvycAb5yN8NXr69DJVU/VDTo91bHmrbO9fvqKfl4cCKuyNnYG7jU/Pp3IiecmH7GNj3MuAkLKsb/G7KdI/1GSt17/dQCt+LOYKyXKKoVWnQLvMD2tX+rF+/WRNjKQjEWuofa6ZPkGSD4UUTVDnoYdWQxNFUUHmju8kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717481214; c=relaxed/simple;
	bh=5Pbiq5BncGCQHGZ/BUr3pdbaC/m3gcY06Lx/koA3JjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iBpKzMtIoCxwBn3MQbnh4Lt0BAm8P+Nv/c/yz66dXehPrhbRI5Hm8f0sr/ANrLtAdFfrj2tVWmgLVlL/ylGLpZEg7NaJWROEtJ0sMx27INfGoCg+SwlbTUNRMpbHyo2MVYFL/lbMyHhtWhbmxT1kMJpq6xSqDa2V3kxR2Fqwi6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hanyang.ac.kr; spf=pass smtp.mailfrom=hanyang.ac.kr; dkim=pass (2048-bit key) header.d=hanyang-ac-kr.20230601.gappssmtp.com header.i=@hanyang-ac-kr.20230601.gappssmtp.com header.b=kG/DR6Hd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hanyang.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hanyang.ac.kr
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c2039db0c6so1719913a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 23:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hanyang-ac-kr.20230601.gappssmtp.com; s=20230601; t=1717481212; x=1718086012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BIcez9BuCzz7Va1QtdhEX0AIotFujX2cdnmTbIsAvbI=;
        b=kG/DR6HdWAvNC4oVQgsvsObr+BLbg2s7dpie+9MG76Ls1DnfwSvlJ4KAdMOC5NCYzc
         LNylMKPaYRYWF3dVtSkT8qDCKzI4KaZO5/Bgt9Vhb7fgwdL62EuCs3n1C8MD5WNyXx70
         AIe/oe6/tx9uap56taqb0/DzpygOnisU0wywCFNC6Y8UrR3Poa9mHwoYV6a4ygFWPeOS
         pMhJulJAYCqokOZqHIsX5O1zFQFYoBapQu4zULVFa1dfMZtDFXAn5IAVrhCsj+/mhi1e
         PUHvdJAVCmBHFXeRfpaXCCW+48LxQa4o/HnKFDP5K5jW5fR1W9IFnUWCUDFrm+6YqMg1
         K+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717481212; x=1718086012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIcez9BuCzz7Va1QtdhEX0AIotFujX2cdnmTbIsAvbI=;
        b=axNBNVjsRo3xAFH2/1Lj6lUfYvaaI6a68l9SYR7n7DyGw3kYmObakiq/rOahDNNDfM
         D86fDpKIPneqf+keQE0jMkvs9xDQoblnf+dxBON7MpcRGEp8meKyofc6aXNLWywC6R+h
         vJFRrChpaLkHM2NUhUdeWr2dPRmmJsqLi15O22/cqYTdRIEIQqssIvRRbPsX7yhbUjbZ
         JSXiLUDY/yIHorzk4p0bPeS9M5fxs++8e++Dsu/zVRX2UaXVbquHqwOrSWxe+7mAZSRZ
         n7GAjtyLCMNVzlbDNjfHFJc86c+7MsZe8jwhOXSv+gjejo7KMy59l9kq/G4E35xP8+pq
         92MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNNn87yPsJYwPCIDCJ8F+LK8inSBWdR/+iKAWRch1cNcAl+bKE+m0tIzZ1L+ojc0nMaJlAMOds/88plKdisdSP7oq49+tqgCvnXAkQzA==
X-Gm-Message-State: AOJu0Yzo4U+9HLAtemNOLHWqA9UcbyGaFX+iAcxQNk+wuQ9HTvbbrd/A
	hqLFLNapePigx9eZbyVCmiu3SFvPxi3qx+QsWfZuIfX10KDoFhs8SOw29lfHpQ==
X-Google-Smtp-Source: AGHT+IG732bkL+U5j7iP2YD1YrzBGWxGYDy8KbMJ/+AJ/EUQi7cXFXfP++wbU+4WlXOksfzzCjYYPw==
X-Received: by 2002:a17:90a:e398:b0:2c2:53f:132e with SMTP id 98e67ed59e1d1-2c25309e67dmr2698340a91.13.1717481211488;
        Mon, 03 Jun 2024 23:06:51 -0700 (PDT)
Received: from localhost.localdomain ([58.75.155.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c27e3a5asm7290347a91.30.2024.06.03.23.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 23:06:51 -0700 (PDT)
From: Hyeonwoo Cha <chw1119@hanyang.ac.kr>
To: david.sterba@suse.com
Cc: aivazian.tigran@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	hirofumi@mail.parknet.co.jp,
	sfr@canb.auug.org.au,
	chw1119@hanyang.ac.kr,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	reiserfs-devel@vger.kernel.org
Subject: [PATCH v2] Fix issue in mark_buffer_dirty_inode
Date: Tue,  4 Jun 2024 15:06:36 +0900
Message-Id: <20240604060636.87652-1-chw1119@hanyang.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thank you for the feedback. I have revised the patch based on your suggestions. Below is the updated patch description.

This patch addresses the FIXME in the mark_buffer_dirty_inode function. It modifies the function to align with the current data-plane operations. Additionally, it corrects the unnecessary buffer allocation. To ensure compatibility with various filesystems using mark_buffer_dirty_inode, the code in other filesystems has also been updated.

Detailed analysis:
- This patch fixes issues in the mark_buffer_dirty_inode function.
- The function has been modified to conform to the current data-plane operations.
- Unnecessary buffer allocations have been corrected to improve memory usage efficiency.
- To enhance compatibility, the code in other filesystems using mark_buffer_dirty_inode has been revised accordingly.

Signed-off-by: Hyeonwoo Cha <chw1119@hanyang.ac.kr>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>

From 891bd0c94033279c459f7f33ab8d5f398c4b913e Mon Sep 17 00:00:00 2001
From: Hyeonwoo Cha <chw1119@hanyang.ac.kr>
Date: Tue, 4 Jun 2024 14:17:45 +0900
Subject: [PATCH] fix-fs-mark_buffer_dirty_fsync

---
 fs/affs/amigaffs.c          | 17 +++++++++++------
 fs/affs/file.c              | 26 ++++++++++++++------------
 fs/affs/inode.c             | 16 ++++++++++------
 fs/affs/namei.c             |  9 +++++----
 fs/bfs/dir.c                |  7 ++++---
 fs/buffer.c                 | 36 ++++++++++++++++++------------------
 fs/ext2/inode.c             |  8 ++++----
 fs/ext4/ext4_jbd2.c         |  2 +-
 fs/fat/dir.c                | 14 +++++++-------
 fs/fat/fatent.c             | 10 +++++-----
 fs/fat/namei_msdos.c        |  4 ++--
 fs/fat/namei_vfat.c         |  2 +-
 fs/minix/itree_common.c     |  8 ++++----
 fs/sysv/itree.c             |  2 +-
 fs/udf/directory.c          |  4 ++--
 fs/udf/inode.c              | 12 ++++++------
 fs/udf/namei.c              |  2 +-
 fs/udf/truncate.c           |  2 +-
 include/linux/buffer_head.h |  2 +-
 19 files changed, 98 insertions(+), 85 deletions(-)

diff --git a/fs/affs/amigaffs.c b/fs/affs/amigaffs.c
index fd669daa4..b11e7fcb2 100644
--- a/fs/affs/amigaffs.c
+++ b/fs/affs/amigaffs.c
@@ -27,6 +27,7 @@ affs_insert_hash(struct inode *dir, struct buffer_head *bh)
 {
 	struct super_block *sb = dir->i_sb;
 	struct buffer_head *dir_bh;
+	struct address_space *mapping = dir->i_mapping;
 	u32 ino, hash_ino;
 	int offset;
 
@@ -57,7 +58,7 @@ affs_insert_hash(struct inode *dir, struct buffer_head *bh)
 		AFFS_TAIL(sb, dir_bh)->hash_chain = cpu_to_be32(ino);
 
 	affs_adjust_checksum(dir_bh, ino);
-	mark_buffer_dirty_inode(dir_bh, dir);
+	mark_buffer_dirty_fsync(dir_bh, mapping);
 	affs_brelse(dir_bh);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
@@ -74,6 +75,7 @@ affs_insert_hash(struct inode *dir, struct buffer_head *bh)
 int
 affs_remove_hash(struct inode *dir, struct buffer_head *rem_bh)
 {
+	struct address_space *mapping = dir->i_mapping;
 	struct super_block *sb;
 	struct buffer_head *bh;
 	u32 rem_ino, hash_ino;
@@ -100,7 +102,7 @@ affs_remove_hash(struct inode *dir, struct buffer_head *rem_bh)
 			else
 				AFFS_TAIL(sb, bh)->hash_chain = ino;
 			affs_adjust_checksum(bh, be32_to_cpu(ino) - hash_ino);
-			mark_buffer_dirty_inode(bh, dir);
+			mark_buffer_dirty_fsync(bh, mapping);
 			AFFS_TAIL(sb, rem_bh)->parent = 0;
 			retval = 0;
 			break;
@@ -142,6 +144,7 @@ static int
 affs_remove_link(struct dentry *dentry)
 {
 	struct inode *dir, *inode = d_inode(dentry);
+	struct address_space *mapping = inode->i_mapping;
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh, *link_bh = NULL;
 	u32 link_ino, ino;
@@ -180,7 +183,7 @@ affs_remove_link(struct dentry *dentry)
 			affs_unlock_dir(dir);
 			goto done;
 		}
-		mark_buffer_dirty_inode(link_bh, inode);
+		mark_buffer_dirty_fsync(link_bh, mapping);
 
 		memcpy(AFFS_TAIL(sb, bh)->name, AFFS_TAIL(sb, link_bh)->name, 32);
 		retval = affs_insert_hash(dir, bh);
@@ -188,7 +191,7 @@ affs_remove_link(struct dentry *dentry)
 			affs_unlock_dir(dir);
 			goto done;
 		}
-		mark_buffer_dirty_inode(bh, inode);
+		mark_buffer_dirty_fsync(bh, mapping);
 
 		affs_unlock_dir(dir);
 		iput(dir);
@@ -203,7 +206,7 @@ affs_remove_link(struct dentry *dentry)
 			__be32 ino2 = AFFS_TAIL(sb, link_bh)->link_chain;
 			AFFS_TAIL(sb, bh)->link_chain = ino2;
 			affs_adjust_checksum(bh, be32_to_cpu(ino2) - link_ino);
-			mark_buffer_dirty_inode(bh, inode);
+			mark_buffer_dirty_fsync(bh, mapping);
 			retval = 0;
 			/* Fix the link count, if bh is a normal header block without links */
 			switch (be32_to_cpu(AFFS_TAIL(sb, bh)->stype)) {
@@ -276,6 +279,8 @@ affs_remove_header(struct dentry *dentry)
 
 	retval = -ENOENT;
 	inode = d_inode(dentry);
+	struct address_space *mapping = inode->i_mapping;
+
 	if (!inode)
 		goto done;
 
@@ -306,7 +311,7 @@ affs_remove_header(struct dentry *dentry)
 	retval = affs_remove_hash(dir, bh);
 	if (retval)
 		goto done_unlock;
-	mark_buffer_dirty_inode(bh, inode);
+	mark_buffer_dirty_fsync(bh, mapping);
 
 	affs_unlock_dir(dir);
 
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 04c018e19..1d769bf43 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -119,6 +119,7 @@ affs_grow_extcache(struct inode *inode, u32 lc_idx)
 static struct buffer_head *
 affs_alloc_extblock(struct inode *inode, struct buffer_head *bh, u32 ext)
 {
+	struct address_space *mapping = inode->i_mapping;
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *new_bh;
 	u32 blocknr, tmp;
@@ -139,14 +140,14 @@ affs_alloc_extblock(struct inode *inode, struct buffer_head *bh, u32 ext)
 	AFFS_TAIL(sb, new_bh)->parent = cpu_to_be32(inode->i_ino);
 	affs_fix_checksum(sb, new_bh);
 
-	mark_buffer_dirty_inode(new_bh, inode);
+	mark_buffer_dirty_fsync(new_bh, mapping);
 
 	tmp = be32_to_cpu(AFFS_TAIL(sb, bh)->extension);
 	if (tmp)
 		affs_warning(sb, "alloc_ext", "previous extension set (%x)", tmp);
 	AFFS_TAIL(sb, bh)->extension = cpu_to_be32(blocknr);
 	affs_adjust_checksum(bh, blocknr - tmp);
-	mark_buffer_dirty_inode(bh, inode);
+	mark_buffer_dirty_fsync(bh, mapping);
 
 	AFFS_I(inode)->i_extcnt++;
 	mark_inode_dirty(inode);
@@ -558,6 +559,7 @@ static int affs_do_read_folio_ofs(struct folio *folio, size_t to, int create)
 static int
 affs_extent_file_ofs(struct inode *inode, u32 newsize)
 {
+	struct address_space *mapping = inode->i_mapping;
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh, *prev_bh;
 	u32 bidx, boff;
@@ -579,7 +581,7 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 		memset(AFFS_DATA(bh) + boff, 0, tmp);
 		be32_add_cpu(&AFFS_DATA_HEAD(bh)->size, tmp);
 		affs_fix_checksum(sb, bh);
-		mark_buffer_dirty_inode(bh, inode);
+		mark_buffer_dirty_fsync(bh, mapping);
 		size += tmp;
 		bidx++;
 	} else if (bidx) {
@@ -601,7 +603,7 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(tmp);
 		affs_fix_checksum(sb, bh);
 		bh->b_state &= ~(1UL << BH_New);
-		mark_buffer_dirty_inode(bh, inode);
+		mark_buffer_dirty_fsync(bh, mapping);
 		if (prev_bh) {
 			u32 tmp_next = be32_to_cpu(AFFS_DATA_HEAD(prev_bh)->next);
 
@@ -611,7 +613,7 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 					     bidx, tmp_next);
 			AFFS_DATA_HEAD(prev_bh)->next = cpu_to_be32(bh->b_blocknr);
 			affs_adjust_checksum(prev_bh, bh->b_blocknr - tmp_next);
-			mark_buffer_dirty_inode(prev_bh, inode);
+			mark_buffer_dirty_fsync(prev_bh, mapping);
 			affs_brelse(prev_bh);
 		}
 		size += bsize;
@@ -728,7 +730,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		memcpy(AFFS_DATA(bh) + boff, data + from, tmp);
 		be32_add_cpu(&AFFS_DATA_HEAD(bh)->size, tmp);
 		affs_fix_checksum(sb, bh);
-		mark_buffer_dirty_inode(bh, inode);
+		mark_buffer_dirty_fsync(bh, mapping);
 		written += tmp;
 		from += tmp;
 		bidx++;
@@ -761,12 +763,12 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 						     bidx, tmp_next);
 				AFFS_DATA_HEAD(prev_bh)->next = cpu_to_be32(bh->b_blocknr);
 				affs_adjust_checksum(prev_bh, bh->b_blocknr - tmp_next);
-				mark_buffer_dirty_inode(prev_bh, inode);
+				mark_buffer_dirty_fsync(prev_bh, mapping);
 			}
 		}
 		affs_brelse(prev_bh);
 		affs_fix_checksum(sb, bh);
-		mark_buffer_dirty_inode(bh, inode);
+		mark_buffer_dirty_fsync(bh, mapping);
 		written += bsize;
 		from += bsize;
 		bidx++;
@@ -795,13 +797,13 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 						     bidx, tmp_next);
 				AFFS_DATA_HEAD(prev_bh)->next = cpu_to_be32(bh->b_blocknr);
 				affs_adjust_checksum(prev_bh, bh->b_blocknr - tmp_next);
-				mark_buffer_dirty_inode(prev_bh, inode);
+				mark_buffer_dirty_fsync(prev_bh, mapping);
 			}
 		} else if (be32_to_cpu(AFFS_DATA_HEAD(bh)->size) < tmp)
 			AFFS_DATA_HEAD(bh)->size = cpu_to_be32(tmp);
 		affs_brelse(prev_bh);
 		affs_fix_checksum(sb, bh);
-		mark_buffer_dirty_inode(bh, inode);
+		mark_buffer_dirty_fsync(bh, mapping);
 		written += tmp;
 		from += tmp;
 		bidx++;
@@ -863,6 +865,7 @@ affs_free_prealloc(struct inode *inode)
 void
 affs_truncate(struct inode *inode)
 {
+	struct address_space *mapping = inode->i_mapping;
 	struct super_block *sb = inode->i_sb;
 	u32 ext, ext_key;
 	u32 last_blk, blkcnt, blk;
@@ -881,7 +884,6 @@ affs_truncate(struct inode *inode)
 	}
 
 	if (inode->i_size > AFFS_I(inode)->mmu_private) {
-		struct address_space *mapping = inode->i_mapping;
 		struct page *page;
 		void *fsdata = NULL;
 		loff_t isize = inode->i_size;
@@ -938,7 +940,7 @@ affs_truncate(struct inode *inode)
 	}
 	AFFS_TAIL(sb, ext_bh)->extension = 0;
 	affs_fix_checksum(sb, ext_bh);
-	mark_buffer_dirty_inode(ext_bh, inode);
+	mark_buffer_dirty_fsync(ext_bh, mapping);
 	affs_brelse(ext_bh);
 
 	if (inode->i_size) {
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 0210df8d3..a4e610944 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -165,6 +165,8 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
 int
 affs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
+	
+	struct address_space *mapping = inode->i_mapping;
 	struct super_block	*sb = inode->i_sb;
 	struct buffer_head	*bh;
 	struct affs_tail	*tail;
@@ -206,7 +208,7 @@ affs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		}
 	}
 	affs_fix_checksum(sb, bh);
-	mark_buffer_dirty_inode(bh, inode);
+	mark_buffer_dirty_fsync(bh, mapping);
 	affs_brelse(bh);
 	affs_free_prealloc(inode);
 	return 0;
@@ -289,7 +291,8 @@ affs_evict_inode(struct inode *inode)
 
 struct inode *
 affs_new_inode(struct inode *dir)
-{
+{	
+	struct address_space *mapping = dir->i_mapping;
 	struct super_block	*sb = dir->i_sb;
 	struct inode		*inode;
 	u32			 block;
@@ -304,7 +307,7 @@ affs_new_inode(struct inode *dir)
 	bh = affs_getzeroblk(sb, block);
 	if (!bh)
 		goto err_bh;
-	mark_buffer_dirty_inode(bh, inode);
+	mark_buffer_dirty_fsync(bh, mapping);
 	affs_brelse(bh);
 
 	inode->i_uid     = current_fsuid();
@@ -347,6 +350,7 @@ affs_new_inode(struct inode *dir)
 int
 affs_add_entry(struct inode *dir, struct inode *inode, struct dentry *dentry, s32 type)
 {
+	struct address_space *mapping = inode->i_mapping;
 	struct super_block *sb = dir->i_sb;
 	struct buffer_head *inode_bh = NULL;
 	struct buffer_head *bh;
@@ -392,17 +396,17 @@ affs_add_entry(struct inode *dir, struct inode *inode, struct dentry *dentry, s3
 		AFFS_TAIL(sb, bh)->link_chain = chain;
 		AFFS_TAIL(sb, inode_bh)->link_chain = cpu_to_be32(block);
 		affs_adjust_checksum(inode_bh, block - be32_to_cpu(chain));
-		mark_buffer_dirty_inode(inode_bh, inode);
+		mark_buffer_dirty_fsync(inode_bh, mapping);
 		set_nlink(inode, 2);
 		ihold(inode);
 	}
 	affs_fix_checksum(sb, bh);
-	mark_buffer_dirty_inode(bh, inode);
+	mark_buffer_dirty_fsync(bh, mapping);
 	dentry->d_fsdata = (void *)(long)bh->b_blocknr;
 
 	affs_lock_dir(dir);
 	retval = affs_insert_hash(dir, bh);
-	mark_buffer_dirty_inode(bh, inode);
+	mark_buffer_dirty_fsync(bh, mapping);
 	affs_unlock_dir(dir);
 	affs_unlock_link(inode);
 
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index 8c154490a..a434ce621 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -373,7 +373,8 @@ affs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	}
 	*p = 0;
 	inode->i_size = i + 1;
-	mark_buffer_dirty_inode(bh, inode);
+	struct address_space *mapping = inode->i_mapping
+	mark_buffer_dirty_fsync(bh, mapping);
 	affs_brelse(bh);
 	mark_inode_dirty(inode);
 
@@ -443,7 +444,7 @@ affs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	/* TODO: move it back to old_dir, if error? */
 
 done:
-	mark_buffer_dirty_inode(bh, retval ? old_dir : new_dir);
+	mark_buffer_dirty_fsync(bh, retval ? old_dir->i_mapping : new_dir->i_mapping);
 	affs_brelse(bh);
 	return retval;
 }
@@ -496,8 +497,8 @@ affs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	retval = affs_insert_hash(old_dir, bh_new);
 	affs_unlock_dir(old_dir);
 done:
-	mark_buffer_dirty_inode(bh_old, new_dir);
-	mark_buffer_dirty_inode(bh_new, old_dir);
+	mark_buffer_dirty_fsync(bh_old, new_dir->i_mapping);
+	mark_buffer_dirty_fsync(bh_new, old_dir->i_mapping);
 	affs_brelse(bh_old);
 	affs_brelse(bh_new);
 	return retval;
diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index c375e22c4..b344a1b4a 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -169,6 +169,7 @@ static int bfs_link(struct dentry *old, struct inode *dir,
 static int bfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int error = -ENOENT;
+	struct address_space *mapping = dir->i_mapping;
 	struct inode *inode = d_inode(dentry);
 	struct buffer_head *bh;
 	struct bfs_dirent *de;
@@ -186,7 +187,7 @@ static int bfs_unlink(struct inode *dir, struct dentry *dentry)
 		set_nlink(inode, 1);
 	}
 	de->ino = 0;
-	mark_buffer_dirty_inode(bh, dir);
+	mark_buffer_dirty_fsync(bh, mapping);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
@@ -246,7 +247,7 @@ static int bfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		inode_set_ctime_current(new_inode);
 		inode_dec_link_count(new_inode);
 	}
-	mark_buffer_dirty_inode(old_bh, old_dir);
+	mark_buffer_dirty_fsync(old_bh, old_dir->i_mapping);
 	error = 0;
 
 end_rename:
@@ -296,7 +297,7 @@ static int bfs_add_entry(struct inode *dir, const struct qstr *child, int ino)
 				for (i = 0; i < BFS_NAMELEN; i++)
 					de->name[i] =
 						(i < namelen) ? name[i] : 0;
-				mark_buffer_dirty_inode(bh, dir);
+				mark_buffer_dirty_fsync(bh, dir->i_mapping);
 				brelse(bh);
 				return 0;
 			}
diff --git a/fs/buffer.c b/fs/buffer.c
index 8c19e705b..508851619 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -118,7 +118,7 @@ void buffer_check_dirty_writeback(struct folio *folio,
  * from becoming locked again - you have to lock it yourself
  * if you want to preserve its state.
  */
-void __wait_on_buffer(struct buffer_head * bh)
+void __wait_on_buffer(struct buffer_head *bh)
 {
 	wait_on_bit_io(&bh->b_state, BH_Lock, TASK_UNINTERRUPTIBLE);
 }
@@ -473,7 +473,7 @@ EXPORT_SYMBOL(mark_buffer_async_write);
  * try_to_free_buffers() will be operating against the *blockdev* mapping
  * at the time, not against the S_ISREG file which depends on those buffers.
  * So the locking for i_private_list is via the i_private_lock in the address_space
- * which backs the buffers.  Which is different from the address_space 
+ * which backs the buffers.  Which is different from the address_space
  * against which the buffers are listed.  So for a particular address_space,
  * mapping->i_private_lock does *not* protect mapping->i_private_list!  In fact,
  * mapping->i_private_list will always be protected by the backing blockdev's
@@ -666,26 +666,27 @@ void write_boundary_block(struct block_device *bdev,
 	}
 }
 
-void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
+void mark_buffer_dirty_fsync(struct buffer_head *bh, struct address_space *mapping)
 {
-	struct address_space *mapping = inode->i_mapping;
 	struct address_space *buffer_mapping = bh->b_folio->mapping;
 
 	mark_buffer_dirty(bh);
+
+	if (bh->b_assoc_map)
+        return;
+
 	if (!mapping->i_private_data) {
-		mapping->i_private_data = buffer_mapping;
-	} else {
-		BUG_ON(mapping->i_private_data != buffer_mapping);
-	}
-	if (!bh->b_assoc_map) {
-		spin_lock(&buffer_mapping->i_private_lock);
-		list_move_tail(&bh->b_assoc_buffers,
-				&mapping->i_private_list);
-		bh->b_assoc_map = mapping;
-		spin_unlock(&buffer_mapping->i_private_lock);
-	}
+    	mapping->i_private_data = buffer_mapping;
+    } else {
+        BUG_ON(mapping->i_private_data != buffer_mapping);
+    }
+
+    spin_lock(&buffer_mapping->i_private_lock);
+    list_move_tail(&bh->b_assoc_buffers, &mapping->i_private_list);
+    bh->b_assoc_map = mapping;
+    spin_unlock(&buffer_mapping->i_private_lock);
 }
-EXPORT_SYMBOL(mark_buffer_dirty_inode);
+EXPORT_SYMBOL(mark_buffer_dirty_fsync);
 
 /**
  * block_dirty_folio - Mark a folio as dirty.
@@ -843,7 +844,6 @@ static int fsync_buffers_list(spinlock_t *lock, struct list_head *list)
 		brelse(bh);
 		spin_lock(lock);
 	}
-	
 	spin_unlock(lock);
 	err2 = osync_buffers_list(lock, list);
 	if (err)
@@ -2155,7 +2155,7 @@ int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 		    !buffer_unwritten(bh) &&
 		     (block_start < from || block_end > to)) {
 			bh_read_nowait(bh, 0);
-			*wait_bh++=bh;
+			*wait_bh++ = bh;
 		}
 	}
 	/*
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 0caa1650c..5410d3f47 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -526,7 +526,7 @@ static int ext2_alloc_branch(struct inode *inode,
 		}
 		set_buffer_uptodate(bh);
 		unlock_buffer(bh);
-		mark_buffer_dirty_inode(bh, inode);
+		mark_buffer_dirty_fsync(bh, inode->i_mapping);
 		/* We used to sync bh here if IS_SYNC(inode).
 		 * But we now rely upon generic_write_sync()
 		 * and b_inode_buffers.  But not for directories.
@@ -597,7 +597,7 @@ static void ext2_splice_branch(struct inode *inode,
 
 	/* had we spliced it onto indirect block? */
 	if (where->bh)
-		mark_buffer_dirty_inode(where->bh, inode);
+		mark_buffer_dirty_fsync(where->bh, inode->i_mapping);
 
 	inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
@@ -1199,7 +1199,7 @@ static void __ext2_truncate_blocks(struct inode *inode, loff_t offset)
 		if (partial == chain)
 			mark_inode_dirty(inode);
 		else
-			mark_buffer_dirty_inode(partial->bh, inode);
+			mark_buffer_dirty_fsync(partial->bh, inode->i_mapping);
 		ext2_free_branches(inode, &nr, &nr+1, (chain+n-1) - partial);
 	}
 	/* Clear the ends of indirect blocks on the shared branch */
@@ -1208,7 +1208,7 @@ static void __ext2_truncate_blocks(struct inode *inode, loff_t offset)
 				   partial->p + 1,
 				   (__le32*)partial->bh->b_data+addr_per_block,
 				   (chain+n-1) - partial);
-		mark_buffer_dirty_inode(partial->bh, inode);
+		mark_buffer_dirty_fsync(partial->bh, inode->i_mapping);
 		brelse (partial->bh);
 		partial--;
 	}
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index da4a82456..93fe0ec45 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -379,7 +379,7 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 		}
 	} else {
 		if (inode)
-			mark_buffer_dirty_inode(bh, inode);
+			mark_buffer_dirty_fsync(bh, inode->i_mapping);
 		else
 			mark_buffer_dirty(bh);
 		if (inode && inode_needs_sync(inode)) {
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index acbec5bdd..85f84c633 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1024,7 +1024,7 @@ static int __fat_remove_entries(struct inode *dir, loff_t pos, int nr_slots)
 			de++;
 			nr_slots--;
 		}
-		mark_buffer_dirty_inode(bh, dir);
+		mark_buffer_dirty_fsync(bh, dir->i_mapping);
 		if (IS_DIRSYNC(dir))
 			err = sync_dirty_buffer(bh);
 		brelse(bh);
@@ -1059,7 +1059,7 @@ int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
 		de--;
 		nr_slots--;
 	}
-	mark_buffer_dirty_inode(bh, dir);
+	mark_buffer_dirty_fsync(bh, dir->i_mapping);
 	if (IS_DIRSYNC(dir))
 		err = sync_dirty_buffer(bh);
 	brelse(bh);
@@ -1111,7 +1111,7 @@ static int fat_zeroed_cluster(struct inode *dir, sector_t blknr, int nr_used,
 		memset(bhs[n]->b_data, 0, sb->s_blocksize);
 		set_buffer_uptodate(bhs[n]);
 		unlock_buffer(bhs[n]);
-		mark_buffer_dirty_inode(bhs[n], dir);
+		mark_buffer_dirty_fsync(bhs[n], dir->i_mapping);
 
 		n++;
 		blknr++;
@@ -1192,7 +1192,7 @@ int fat_alloc_new_dir(struct inode *dir, struct timespec64 *ts)
 	memset(de + 2, 0, sb->s_blocksize - 2 * sizeof(*de));
 	set_buffer_uptodate(bhs[0]);
 	unlock_buffer(bhs[0]);
-	mark_buffer_dirty_inode(bhs[0], dir);
+	mark_buffer_dirty_fsync(bhs[0], dir->i_mapping);
 
 	err = fat_zeroed_cluster(dir, blknr, 1, bhs, MAX_BUF_PER_PAGE);
 	if (err)
@@ -1254,7 +1254,7 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
 			memcpy(bhs[n]->b_data, slots, copy);
 			set_buffer_uptodate(bhs[n]);
 			unlock_buffer(bhs[n]);
-			mark_buffer_dirty_inode(bhs[n], dir);
+			mark_buffer_dirty_fsync(bhs[n], dir->i_mapping);
 			slots += copy;
 			size -= copy;
 			if (!size)
@@ -1356,7 +1356,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 		for (i = 0; i < long_bhs; i++) {
 			int copy = min_t(int, sb->s_blocksize - offset, size);
 			memcpy(bhs[i]->b_data + offset, slots, copy);
-			mark_buffer_dirty_inode(bhs[i], dir);
+			mark_buffer_dirty_fsync(bhs[i], dir->i_mapping);
 			offset = 0;
 			slots += copy;
 			size -= copy;
@@ -1367,7 +1367,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 			/* Fill the short name slot. */
 			int copy = min_t(int, sb->s_blocksize - offset, size);
 			memcpy(bhs[i]->b_data + offset, slots, copy);
-			mark_buffer_dirty_inode(bhs[i], dir);
+			mark_buffer_dirty_fsync(bhs[i], dir->i_mapping);
 			if (IS_DIRSYNC(dir))
 				err = sync_dirty_buffer(bhs[i]);
 		}
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index 1db348f8f..4aa928e09 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -170,9 +170,9 @@ static void fat12_ent_put(struct fat_entry *fatent, int new)
 	}
 	spin_unlock(&fat12_entry_lock);
 
-	mark_buffer_dirty_inode(fatent->bhs[0], fatent->fat_inode);
+	mark_buffer_dirty_fsync(fatent->bhs[0], fatent->fat_inode->i_mapping);
 	if (fatent->nr_bhs == 2)
-		mark_buffer_dirty_inode(fatent->bhs[1], fatent->fat_inode);
+		mark_buffer_dirty_fsync(fatent->bhs[1], fatent->fat_inode->i_mapping);
 }
 
 static void fat16_ent_put(struct fat_entry *fatent, int new)
@@ -181,7 +181,7 @@ static void fat16_ent_put(struct fat_entry *fatent, int new)
 		new = EOF_FAT16;
 
 	*fatent->u.ent16_p = cpu_to_le16(new);
-	mark_buffer_dirty_inode(fatent->bhs[0], fatent->fat_inode);
+	mark_buffer_dirty_fsync(fatent->bhs[0], fatent->fat_inode->i_mapping);
 }
 
 static void fat32_ent_put(struct fat_entry *fatent, int new)
@@ -189,7 +189,7 @@ static void fat32_ent_put(struct fat_entry *fatent, int new)
 	WARN_ON(new & 0xf0000000);
 	new |= le32_to_cpu(*fatent->u.ent32_p) & ~0x0fffffff;
 	*fatent->u.ent32_p = cpu_to_le32(new);
-	mark_buffer_dirty_inode(fatent->bhs[0], fatent->fat_inode);
+	mark_buffer_dirty_fsync(fatent->bhs[0], fatent->fat_inode->i_mapping);
 }
 
 static int fat12_ent_next(struct fat_entry *fatent)
@@ -395,7 +395,7 @@ static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
 			memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
 			set_buffer_uptodate(c_bh);
 			unlock_buffer(c_bh);
-			mark_buffer_dirty_inode(c_bh, sbi->fat_inode);
+			mark_buffer_dirty_fsync(c_bh, sbi->fat_inode->i_mapping);
 			if (sb->s_flags & SB_SYNCHRONOUS)
 				err = sync_dirty_buffer(c_bh);
 			brelse(c_bh);
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 2116c4868..2fa341ba6 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -524,7 +524,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 
 	if (update_dotdot) {
 		fat_set_start(dotdot_de, MSDOS_I(new_dir)->i_logstart);
-		mark_buffer_dirty_inode(dotdot_bh, old_inode);
+		mark_buffer_dirty_fsync(dotdot_bh, old_inode->i_mapping);
 		if (IS_DIRSYNC(new_dir)) {
 			err = sync_dirty_buffer(dotdot_bh);
 			if (err)
@@ -564,7 +564,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 
 	if (update_dotdot) {
 		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
-		mark_buffer_dirty_inode(dotdot_bh, old_inode);
+		mark_buffer_dirty_fsync(dotdot_bh, old_inode->i_mapping);
 		corrupt |= sync_dirty_buffer(dotdot_bh);
 	}
 error_inode:
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index c4d00999a..c4ed9fd7d 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -912,7 +912,7 @@ static int vfat_update_dotdot_de(struct inode *dir, struct inode *inode,
 				 struct msdos_dir_entry *dotdot_de)
 {
 	fat_set_start(dotdot_de, MSDOS_I(dir)->i_logstart);
-	mark_buffer_dirty_inode(dotdot_bh, inode);
+	mark_buffer_dirty_fsync(dotdot_bh, inode->i_mapping);
 	if (IS_DIRSYNC(dir))
 		return sync_dirty_buffer(dotdot_bh);
 	return 0;
diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
index dad131e30..4354da0ce 100644
--- a/fs/minix/itree_common.c
+++ b/fs/minix/itree_common.c
@@ -98,7 +98,7 @@ static int alloc_branch(struct inode *inode,
 		*branch[n].p = branch[n].key;
 		set_buffer_uptodate(bh);
 		unlock_buffer(bh);
-		mark_buffer_dirty_inode(bh, inode);
+		mark_buffer_dirty_fsync(bh, inode->i_mapping);
 		parent = nr;
 	}
 	if (n == num)
@@ -135,7 +135,7 @@ static inline int splice_branch(struct inode *inode,
 
 	/* had we spliced it onto indirect block? */
 	if (where->bh)
-		mark_buffer_dirty_inode(where->bh, inode);
+		mark_buffer_dirty_fsync(where->bh, inode->i_mapping);
 
 	mark_inode_dirty(inode);
 	return 0;
@@ -328,14 +328,14 @@ static inline void truncate (struct inode * inode)
 		if (partial == chain)
 			mark_inode_dirty(inode);
 		else
-			mark_buffer_dirty_inode(partial->bh, inode);
+			mark_buffer_dirty_fsync(partial->bh, inode->i_mapping);
 		free_branches(inode, &nr, &nr+1, (chain+n-1) - partial);
 	}
 	/* Clear the ends of indirect blocks on the shared branch */
 	while (partial > chain) {
 		free_branches(inode, partial->p + 1, block_end(partial->bh),
 				(chain+n-1) - partial);
-		mark_buffer_dirty_inode(partial->bh, inode);
+		mark_buffer_dirty_fsync(partial->bh, inode->i_mapping);
 		brelse (partial->bh);
 		partial--;
 	}
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index 19bcb51a2..c50a77a4d 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -16,7 +16,7 @@ enum {DIRECT = 10, DEPTH = 4};	/* Have triple indirect */
 
 static inline void dirty_indirect(struct buffer_head *bh, struct inode *inode)
 {
-	mark_buffer_dirty_inode(bh, inode);
+	mark_buffer_dirty_fsync(bh, inode->i_mapping);
 	if (IS_SYNC(inode))
 		sync_dirty_buffer(bh);
 }
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 93153665e..4ecb058c0 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -423,9 +423,9 @@ void udf_fiiter_write_fi(struct udf_fileident_iter *iter, uint8_t *impuse)
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
 		mark_inode_dirty(iter->dir);
 	} else {
-		mark_buffer_dirty_inode(iter->bh[0], iter->dir);
+		mark_buffer_dirty_fsync(iter->bh[0], iter->dir->i_mapping);
 		if (iter->bh[1])
-			mark_buffer_dirty_inode(iter->bh[1], iter->dir);
+			mark_buffer_dirty_fsync(iter->bh[1], iter->dir->i_mapping);
 	}
 	inode_inc_iversion(iter->dir);
 }
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 2fb21c5ff..3f2d8b150 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1226,7 +1226,7 @@ struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
 		memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
 		set_buffer_uptodate(bh);
 		unlock_buffer(bh);
-		mark_buffer_dirty_inode(bh, inode);
+		mark_buffer_dirty_fsync(bh, inode->i_mapping);
 		return bh;
 	}
 
@@ -1978,7 +1978,7 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 	memset(bh->b_data, 0x00, sb->s_blocksize);
 	set_buffer_uptodate(bh);
 	unlock_buffer(bh);
-	mark_buffer_dirty_inode(bh, inode);
+	mark_buffer_dirty_fsync(bh, inode->i_mapping);
 
 	aed = (struct allocExtDesc *)(bh->b_data);
 	if (!UDF_QUERY_FLAG(sb, UDF_FLAG_STRICT)) {
@@ -2068,7 +2068,7 @@ int __udf_add_aext(struct inode *inode, struct extent_position *epos,
 		else
 			udf_update_tag(epos->bh->b_data,
 					sizeof(struct allocExtDesc));
-		mark_buffer_dirty_inode(epos->bh, inode);
+		mark_buffer_dirty_fsync(epos->bh, inode->i_mapping);
 	}
 
 	return 0;
@@ -2152,7 +2152,7 @@ void udf_write_aext(struct inode *inode, struct extent_position *epos,
 				       le32_to_cpu(aed->lengthAllocDescs) +
 				       sizeof(struct allocExtDesc));
 		}
-		mark_buffer_dirty_inode(epos->bh, inode);
+		mark_buffer_dirty_fsync(epos->bh, inode->i_mapping);
 	} else {
 		mark_inode_dirty(inode);
 	}
@@ -2331,7 +2331,7 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
 			else
 				udf_update_tag(oepos.bh->b_data,
 						sizeof(struct allocExtDesc));
-			mark_buffer_dirty_inode(oepos.bh, inode);
+			mark_buffer_dirty_fsync(oepos.bh, inode->i_mapping);
 		}
 	} else {
 		udf_write_aext(inode, &oepos, &eloc, elen, 1);
@@ -2348,7 +2348,7 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
 			else
 				udf_update_tag(oepos.bh->b_data,
 						sizeof(struct allocExtDesc));
-			mark_buffer_dirty_inode(oepos.bh, inode);
+			mark_buffer_dirty_fsync(oepos.bh, inode->i_mapping);
 		}
 	}
 
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 1308109fd..b6dfa195a 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -634,7 +634,7 @@ static int udf_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		memset(epos.bh->b_data, 0x00, bsize);
 		set_buffer_uptodate(epos.bh);
 		unlock_buffer(epos.bh);
-		mark_buffer_dirty_inode(epos.bh, inode);
+		mark_buffer_dirty_fsync(epos.bh, inode->i_mapping);
 		ea = epos.bh->b_data + udf_ext0_offset(inode);
 	} else
 		ea = iinfo->i_data + iinfo->i_lenEAttr;
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index a686c10fd..c73fabb8f 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -169,7 +169,7 @@ static void udf_update_alloc_ext_desc(struct inode *inode,
 		len += lenalloc;
 
 	udf_update_tag(epos->bh->b_data, len);
-	mark_buffer_dirty_inode(epos->bh, inode);
+	mark_buffer_dirty_fsync(epos->bh, inode->i_mapping);
 }
 
 /*
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 14acf1bbe..d8f650883 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -207,7 +207,7 @@ void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
 
 /* Things to do with buffers at mapping->private_list */
-void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode);
+void mark_buffer_dirty_fsync(struct buffer_head *bh, struct address_space *inode);
 int generic_buffers_fsync_noflush(struct file *file, loff_t start, loff_t end,
 				  bool datasync);
 int generic_buffers_fsync(struct file *file, loff_t start, loff_t end,
-- 
2.34.1


