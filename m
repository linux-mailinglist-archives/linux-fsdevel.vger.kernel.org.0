Return-Path: <linux-fsdevel+bounces-17782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D401F8B22BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E24DAB29447
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9A414A4C7;
	Thu, 25 Apr 2024 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHrYvRz1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA5C14A091;
	Thu, 25 Apr 2024 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051761; cv=none; b=hi4AofZTMNv6qNtmtCcxj4rS33bF+XqIY7BPjWxybSn/UQ1gOLNrUwyUj5ueghZLPga1qf9aXE5h+mT0fzxDdzXVaEu7FMHF6884ev54r5+SujT2OGL0sxatCxiPIrx+5wUO64NQncYwI6Zf/BfGD80bW7kT3B8cH0afgtRjbhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051761; c=relaxed/simple;
	bh=/wh0tkUN7g3ReoAIEMJ7oFqF6cMIggwYSbzM52BSptM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8bXejgjeOMFIrNyTh4xWD5IBQjyBCc75zx8puddCgXelYku7248FRlajLcPfFGzdtWw3xFu29w6auqDRiY1pQiijPRwShZ6AEMPGWGXjMeHTP3fK4l9RQyEkCpfNxyYEouvUJwX/hTH/3po+XOnt+bMfik6901pTmikUE8fwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHrYvRz1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed32341906so991560b3a.1;
        Thu, 25 Apr 2024 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714051758; x=1714656558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FocX2ENNC23gjap0Wl/CF9LC9c00Rg9MqvN6XwRvlvo=;
        b=kHrYvRz131blyEOyd/EtE6Zd1CRc53/QKCxya3k4+nh1avt3TUaN4P7ll3wN1oZjNS
         nqQl0gKgSpzHj8gOadK6gbczvz2Tjzw9Ywp5qTg9xnDiOllAc+Qs+aUPeVXp+YfJSzJG
         85i5NlQ2fQV1OzahQFS3JrEd82PsKmYXqOBjtDy918dG8Uc2TPnvpq68YPeBP2z75Wqb
         NSkhsb69w98a0abv8LQJyqp9Sq3klETa2pFNw3OFEMIUIpsldCFzyYG//K6tye1B0WII
         Re/bViO6rKHz5M4yBttnGBzISmld14IOgKnc54KjMUH2i4TAbYpV9/7yUkBNBE+VF1QG
         DB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714051758; x=1714656558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FocX2ENNC23gjap0Wl/CF9LC9c00Rg9MqvN6XwRvlvo=;
        b=neyaRwO6AoqYH0TgMXYk+i+v7d3m+BLTivAOQFeR3Eh6/9hWLHZ0CRwwB2My2cLM9A
         qOV3nLYQ5q/R0WC/sR6gGAIR/6NPKMKTOLNUX0zLKlGHxcuA+6OzR5uJhdXu9aEn8rtu
         Nz/uqH8k/Fm2r6Tp+eydlGd8k+VhcTqv/AKjVwSKInHQ2L5mzDq0z/yAtYXVJ7eOqEm8
         J3ytjmYNHtlHtdXQ3nOBOrZVi/foRkIGbKt+BBlbqYdZRf5uAdtEqbuCJ/0zusn60Y9i
         DDutylmbsgFJZNnqWRJKozzKFFSmnYCDpteKJ9Gagn0Wbwu9sgnleDQuZYEKWppdswcd
         yhbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4dWx29WPZ4pWeZCP2X/4hbWOA9xIIIJOc48vFq8CVE19uxFBoqghrMzN/QRLVzOum/DYKJ+Bt7NF6nui+YrBj2zyHXCv7TB+J
X-Gm-Message-State: AOJu0YwTaSQe5iSiawKyfWTSWJGLJe5rMK7nDRRKEMr4cKCHgoJ7bhjL
	GJthvzIQVBVSA6V41LrLxqCYmRhQYfIIhRuV9aSSh5Q/VhK3VFQ8Yr/5RdO9
X-Google-Smtp-Source: AGHT+IE3cSoUeWuPz0fi6kdz/sLK+SIFJCC1Rq+mP272g2W765HZiA8q20f0NRSVppPwuZcx4isCiQ==
X-Received: by 2002:a05:6a00:8c4:b0:6ed:41f3:431d with SMTP id s4-20020a056a0008c400b006ed41f3431dmr6712776pfu.0.1714051758398;
        Thu, 25 Apr 2024 06:29:18 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id s15-20020a62e70f000000b006f260fb17e5sm9764518pfh.141.2024.04.25.06.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:29:17 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [RFCv3 4/7] ext2: Implement seq counter for validating cached iomap
Date: Thu, 25 Apr 2024 18:58:48 +0530
Message-ID: <009d08646b77e0d774b4ce248675b86564bca9ee.1714046808.git.ritesh.list@gmail.com>
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

There is a possibility of following race with iomap during
writebck -

write_cache_pages()
  cache extent covering 0..1MB range
  write page at offset 0k
					truncate(file, 4k)
					  drops all relevant pages
					  frees fs blocks
					pwrite(file, 4k, 4k)
					  creates dirty page in the page cache
  writes page at offset 4k to a stale block

This race can happen because iomap_writepages() keeps a cached extent mapping
within struct iomap. While write_cache_pages() is going over each folio,
(can cache a large extent range), if a truncate happens in parallel on the
next folio followed by a buffered write to the same offset within the file,
this can change logical to physical offset of the cached iomap mapping.
That means, the cached iomap has now become stale.

This patch implements the seq counter approach for revalidation of stale
iomap mappings. i_blkseq will get incremented for every block
allocation/free. Here is what we do -

For ext2 buffered-writes, the block allocation happens at the
->write_iter time itself. So at writeback time,
1. We first cache the i_blkseq.
2. Call ext2_get_blocks(, create = 0) to get the no. of blocks
   already allocated.
3. Call ext2_get_blocks() the second time with length to be same as
   the no. of blocks we know were already allocated.
4. Till now it means, the cached i_blkseq remains valid as no block
   allocation has happened yet.
This means the next call to ->map_blocks(), we can verify whether the
i_blkseq has raced with truncate or not. If not, then i_blkseq will
remain valid.

In case of a hole (could happen with mmaped writes), we only allocate
1 block at a time anyways. So even if the i_blkseq value changes right
after, we anyway need to allocate the next block in subsequent
->map_blocks() call.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/balloc.c |  1 +
 fs/ext2/ext2.h   |  6 +++++
 fs/ext2/inode.c  | 57 ++++++++++++++++++++++++++++++++++++++++++++----
 fs/ext2/super.c  |  2 +-
 4 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 1bfd6ab11038..047a8f41a6f5 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -495,6 +495,7 @@ void ext2_free_blocks(struct inode * inode, ext2_fsblk_t block,
 	}
 
 	ext2_debug ("freeing block(s) %lu-%lu\n", block, block + count - 1);
+	ext2_inc_i_blkseq(EXT2_I(inode));
 
 do_more:
 	overflow = 0;
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index f38bdd46e4f7..67b1acb08eb2 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -663,6 +663,7 @@ struct ext2_inode_info {
 	struct rw_semaphore xattr_sem;
 #endif
 	rwlock_t i_meta_lock;
+	unsigned int i_blkseq;
 
 	/*
 	 * truncate_mutex is for serialising ext2_truncate() against
@@ -698,6 +699,11 @@ static inline struct ext2_inode_info *EXT2_I(struct inode *inode)
 	return container_of(inode, struct ext2_inode_info, vfs_inode);
 }
 
+static inline void ext2_inc_i_blkseq(struct ext2_inode_info *ei)
+{
+	WRITE_ONCE(ei->i_blkseq, READ_ONCE(ei->i_blkseq) + 1);
+}
+
 /* balloc.c */
 extern int ext2_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 2b62786130b5..946a614ddfc0 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -406,6 +406,8 @@ static int ext2_alloc_blocks(struct inode *inode,
 	ext2_fsblk_t current_block = 0;
 	int ret = 0;
 
+	ext2_inc_i_blkseq(EXT2_I(inode));
+
 	/*
 	 * Here we try to allocate the requested multiple blocks at once,
 	 * on a best-effort basis.
@@ -966,15 +968,62 @@ ext2_writepages(struct address_space *mapping, struct writeback_control *wbc)
 	return mpage_writepages(mapping, wbc, ext2_get_block);
 }
 
+static bool ext2_imap_valid(struct iomap_writepage_ctx *wpc, struct inode *inode,
+			    loff_t offset)
+{
+	if (offset < wpc->iomap.offset ||
+	    offset >= wpc->iomap.offset + wpc->iomap.length)
+		return false;
+
+	if (wpc->iomap.validity_cookie != READ_ONCE(EXT2_I(inode)->i_blkseq))
+		return false;
+
+	return true;
+}
+
 static int ext2_write_map_blocks(struct iomap_writepage_ctx *wpc,
 				 struct inode *inode, loff_t offset,
 				 unsigned len)
 {
-	if (offset >= wpc->iomap.offset &&
-	    offset < wpc->iomap.offset + wpc->iomap.length)
+	loff_t maxblocks = (loff_t)INT_MAX;
+	u8 blkbits = inode->i_blkbits;
+	u32 bno;
+	bool new, boundary;
+	int ret;
+
+	if (ext2_imap_valid(wpc, inode, offset))
 		return 0;
 
-	return ext2_iomap_begin(inode, offset, inode->i_sb->s_blocksize,
+	/*
+	 * For ext2 buffered-writes, the block allocation happens at the
+	 * ->write_iter time itself. So at writeback time -
+	 * 1. We first cache the i_blkseq.
+	 * 2. Call ext2_get_blocks(, create = 0) to get the no. of blocks
+	 *    already allocated.
+	 * 3. Call ext2_get_blocks() the second time with length to be same as
+	 *    the no. of blocks we know were already allocated.
+	 * 4. Till now it means, the cached i_blkseq remains valid as no block
+	 *    allocation has happened yet.
+	 * This means the next call to ->map_blocks(), we can verify whether the
+	 * i_blkseq has raced with truncate or not. If not, then i_blkseq will
+	 * remain valid.
+	 *
+	 * In case of a hole (could happen with mmaped writes), we only allocate
+	 * 1 block at a time anyways. So even if the i_blkseq value changes, we
+	 * anyway need to allocate the next block in subsequent ->map_blocks()
+	 * call.
+	 */
+	wpc->iomap.validity_cookie = READ_ONCE(EXT2_I(inode)->i_blkseq);
+
+	ret = ext2_get_blocks(inode, offset >> blkbits, maxblocks << blkbits,
+			      &bno, &new, &boundary, 0);
+	if (ret < 0)
+		return ret;
+	/*
+	 * ret can be 0 in case of a hole which is possible for mmaped writes.
+	 */
+	ret = ret ? ret : 1;
+	return ext2_iomap_begin(inode, offset, (loff_t)ret << blkbits,
 				IOMAP_WRITE, &wpc->iomap, NULL);
 }
 
@@ -1000,7 +1049,7 @@ ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc
 
 const struct address_space_operations ext2_file_aops = {
 	.dirty_folio		= iomap_dirty_folio,
-	.release_folio 		= iomap_release_folio,
+	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.read_folio		= ext2_file_read_folio,
 	.readahead		= ext2_file_readahead,
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 37f7ce56adce..32f5386284d6 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -188,7 +188,7 @@ static struct inode *ext2_alloc_inode(struct super_block *sb)
 #ifdef CONFIG_QUOTA
 	memset(&ei->i_dquot, 0, sizeof(ei->i_dquot));
 #endif
-
+	WRITE_ONCE(ei->i_blkseq, 0);
 	return &ei->vfs_inode;
 }
 
-- 
2.44.0


