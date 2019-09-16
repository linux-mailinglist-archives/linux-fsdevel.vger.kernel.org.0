Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B816AB39F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 14:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbfIPMFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 08:05:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731844AbfIPMFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5VCkM+PMCEEEa6IiEPmOKLvxwc8qVg+TJJuCSKtZbHo=; b=JhjJD8bIziR+3lXjmrsK94GjZ
        s5cOkSKKvXWvJTTSVZETkCTcDT6n/Cb0StiAtLbEkdQRRZiFmEstgc/LfwHbf19hGfzhv3pXsAFrx
        oITZ1N4hxzA/zJ7IoZ1H46zje5Qkp+YDYjafAkelGB0gNXeOgsEJR1WUf2I58UJjpK/r9KHpfS++s
        h3OARinXtMIYtXKDI7cJ4Wel8aWI1uYgX1EhPAYkgvbFXQGJvKNLtPThaJ+49TjmsWUNxOXMOwVXM
        +biYLdRO3wPqKj8hyTQjsLRBBdL2Ke/6NuOwNVaaGarP/2yEHfELVlIuzlYetu2LTDlglGGkRIUHD
        e9xshec8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9pl7-0004gt-7Z; Mon, 16 Sep 2019 12:05:33 +0000
Date:   Mon, 16 Sep 2019 05:05:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 4/6] ext4: reorder map.m_flags checks in
 ext4_iomap_begin()
Message-ID: <20190916120533.GB4005@infradead.org>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <8aa099e66ece73578f32cbbc411b6f3e52d53e52.1568282664.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa099e66ece73578f32cbbc411b6f3e52d53e52.1568282664.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 12, 2019 at 09:04:30PM +1000, Matthew Bobrowski wrote:
> @@ -3581,10 +3581,21 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
>  		iomap->addr = IOMAP_NULL_ADDR;
>  	} else {
> -		if (map.m_flags & EXT4_MAP_MAPPED) {
> -			iomap->type = IOMAP_MAPPED;
> -		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> +		/*
> +		 * Flags passed to ext4_map_blocks() for direct IO
> +		 * writes can result in m_flags having both
> +		 * EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits set. In
> +		 * order for allocated unwritten extents to be
> +		 * converted to written extents in the end_io handler
> +		 * correctly, we need to ensure that the iomap->type
> +		 * is also set appropriately in that case. Thus, we
> +		 * need to check whether EXT4_MAP_UNWRITTEN is set
> +		 * first.
> +		 */
> +		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
>  			iomap->type = IOMAP_UNWRITTEN;
> +		} else if (map.m_flags & EXT4_MAP_MAPPED) {
> +			iomap->type = IOMAP_MAPPED;

I think much of this would benefit a lot from just being split up.
I hacked up a patch last week that split the ext4 direct I/O code
a bit, but this is completely untested and needs further splitup,
but maybe you can take it as an inspiration for your series?
E.g. at least one helper for filling out the iomap from the ext4
map data, and one for the seek unwritten extent reporting.  The
split of the overall iomap ops seemed useful to me, but might not
be as important with the other cleanups:

---
From 7ac1a837e279e415882feae473e335b4a3d89c10 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Sun, 8 Sep 2019 10:44:28 +0200
Subject: ext4: refactor the iomap code

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/ext4.h  |   1 +
 fs/ext4/file.c  |   7 +-
 fs/ext4/inode.c | 279 ++++++++++++++++++++++++++----------------------
 3 files changed, 159 insertions(+), 128 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bf660aa7a9e0..c8e34fe3daba 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3333,6 +3333,7 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
 }
 
 extern const struct iomap_ops ext4_iomap_ops;
+extern const struct iomap_ops ext4_report_iomap_ops;
 
 #endif	/* __KERNEL__ */
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 70b0438dbc94..cd2d41bc842b 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -328,7 +328,8 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 	} else {
 		down_read(&EXT4_I(inode)->i_mmap_sem);
 	}
-	result = dax_iomap_fault(vmf, pe_size, &pfn, &error, &ext4_iomap_ops);
+	result = dax_iomap_fault(vmf, pe_size, &pfn, &error,
+			&ext4_iomap_ops);
 	if (write) {
 		ext4_journal_stop(handle);
 
@@ -492,12 +493,12 @@ loff_t ext4_llseek(struct file *file, loff_t offset, int whence)
 						maxbytes, i_size_read(inode));
 	case SEEK_HOLE:
 		inode_lock_shared(inode);
-		offset = iomap_seek_hole(inode, offset, &ext4_iomap_ops);
+		offset = iomap_seek_hole(inode, offset, &ext4_report_iomap_ops);
 		inode_unlock_shared(inode);
 		break;
 	case SEEK_DATA:
 		inode_lock_shared(inode);
-		offset = iomap_seek_data(inode, offset, &ext4_iomap_ops);
+		offset = iomap_seek_data(inode, offset, &ext4_report_iomap_ops);
 		inode_unlock_shared(inode);
 		break;
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 420fe3deed39..1c1b07f0cdbf 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3452,152 +3452,116 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	return inode->i_state & I_DIRTY_DATASYNC;
 }
 
-static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
-			    unsigned flags, struct iomap *iomap)
+static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
+		unsigned long first_block, struct ext4_map_blocks *map)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	unsigned int blkbits = inode->i_blkbits;
-	unsigned long first_block, last_block;
-	struct ext4_map_blocks map;
-	bool delalloc = false;
-	int ret;
-
-	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
-		return -EINVAL;
-	first_block = offset >> blkbits;
-	last_block = min_t(loff_t, (offset + length - 1) >> blkbits,
-			   EXT4_MAX_LOGICAL_BLOCK);
-
-	if (flags & IOMAP_REPORT) {
-		if (ext4_has_inline_data(inode)) {
-			ret = ext4_inline_data_iomap(inode, iomap);
-			if (ret != -EAGAIN) {
-				if (ret == 0 && offset >= iomap->length)
-					ret = -ENOENT;
-				return ret;
-			}
-		}
-	} else {
-		if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
-			return -ERANGE;
-	}
-
-	map.m_lblk = first_block;
-	map.m_len = last_block - first_block + 1;
-
-	if (flags & IOMAP_REPORT) {
-		ret = ext4_map_blocks(NULL, inode, &map, 0);
-		if (ret < 0)
-			return ret;
-
-		if (ret == 0) {
-			ext4_lblk_t end = map.m_lblk + map.m_len - 1;
-			struct extent_status es;
-
-			ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
-						  map.m_lblk, end, &es);
-
-			if (!es.es_len || es.es_lblk > end) {
-				/* entire range is a hole */
-			} else if (es.es_lblk > map.m_lblk) {
-				/* range starts with a hole */
-				map.m_len = es.es_lblk - map.m_lblk;
-			} else {
-				ext4_lblk_t offs = 0;
-
-				if (es.es_lblk < map.m_lblk)
-					offs = map.m_lblk - es.es_lblk;
-				map.m_lblk = es.es_lblk + offs;
-				map.m_len = es.es_len - offs;
-				delalloc = true;
-			}
-		}
-	} else if (flags & IOMAP_WRITE) {
-		int dio_credits;
-		handle_t *handle;
-		int retries = 0;
-
-		/* Trim mapping request to maximum we can map at once for DIO */
-		if (map.m_len > DIO_MAX_BLOCKS)
-			map.m_len = DIO_MAX_BLOCKS;
-		dio_credits = ext4_chunk_trans_blocks(inode, map.m_len);
-retry:
-		/*
-		 * Either we allocate blocks and then we don't get unwritten
-		 * extent so we have reserved enough credits, or the blocks
-		 * are already allocated and unwritten and in that case
-		 * extent conversion fits in the credits as well.
-		 */
-		handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS,
-					    dio_credits);
-		if (IS_ERR(handle))
-			return PTR_ERR(handle);
-
-		ret = ext4_map_blocks(handle, inode, &map,
-				      EXT4_GET_BLOCKS_CREATE_ZERO);
-		if (ret < 0) {
-			ext4_journal_stop(handle);
-			if (ret == -ENOSPC &&
-			    ext4_should_retry_alloc(inode->i_sb, &retries))
-				goto retry;
-			return ret;
-		}
-
-		/*
-		 * If we added blocks beyond i_size, we need to make sure they
-		 * will get truncated if we crash before updating i_size in
-		 * ext4_iomap_end(). For faults we don't need to do that (and
-		 * even cannot because for orphan list operations inode_lock is
-		 * required) - if we happen to instantiate block beyond i_size,
-		 * it is because we race with truncate which has already added
-		 * the inode to the orphan list.
-		 */
-		if (!(flags & IOMAP_FAULT) && first_block + map.m_len >
-		    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
-			int err;
-
-			err = ext4_orphan_add(handle, inode);
-			if (err < 0) {
-				ext4_journal_stop(handle);
-				return err;
-			}
-		}
-		ext4_journal_stop(handle);
-	} else {
-		ret = ext4_map_blocks(NULL, inode, &map, 0);
-		if (ret < 0)
-			return ret;
-	}
 
 	iomap->flags = 0;
 	if (ext4_inode_datasync_dirty(inode))
 		iomap->flags |= IOMAP_F_DIRTY;
 	iomap->bdev = inode->i_sb->s_bdev;
-	iomap->dax_dev = sbi->s_daxdev;
+	iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
 	iomap->offset = (u64)first_block << blkbits;
-	iomap->length = (u64)map.m_len << blkbits;
-
-	if (ret == 0) {
-		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
+	iomap->length = (u64)map->m_len << blkbits;
+	if (type) {
+		iomap->type = type;
 		iomap->addr = IOMAP_NULL_ADDR;
 	} else {
-		if (map.m_flags & EXT4_MAP_MAPPED) {
+		if (map->m_flags & EXT4_MAP_MAPPED) {
 			iomap->type = IOMAP_MAPPED;
-		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
+		} else if (map->m_flags & EXT4_MAP_UNWRITTEN) {
 			iomap->type = IOMAP_UNWRITTEN;
 		} else {
 			WARN_ON_ONCE(1);
 			return -EIO;
 		}
-		iomap->addr = (u64)map.m_pblk << blkbits;
+		iomap->addr = (u64)map->m_pblk << blkbits;
 	}
-
-	if (map.m_flags & EXT4_MAP_NEW)
+	if (map->m_flags & EXT4_MAP_NEW)
 		iomap->flags |= IOMAP_F_NEW;
-
 	return 0;
 }
 
+#ifdef CONFIG_FS_DAX
+static int ext4_iomap_alloc(struct inode *inode, unsigned flags,
+		unsigned long first_block, struct ext4_map_blocks *map)
+{
+	unsigned int blkbits = inode->i_blkbits;
+	int dio_credits, ret, retries = 0;
+	handle_t *handle;
+
+	/* Trim mapping request to maximum we can map at once for DIO */
+	if (map->m_len > DIO_MAX_BLOCKS)
+		map->m_len = DIO_MAX_BLOCKS;
+	dio_credits = ext4_chunk_trans_blocks(inode, map->m_len);
+retry:
+	/*
+	 * Either we allocate blocks and then we don't get unwritten extent so
+	 * we have reserved enough credits, or the blocks are already allocated
+	 * and unwritten and in that case extent conversion fits in the credits
+	 as well.
+	 */
+	handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS, dio_credits);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	ret = ext4_map_blocks(handle, inode, map, EXT4_GET_BLOCKS_CREATE_ZERO);
+	if (ret < 0)
+		goto journal_stop;
+
+	/*
+	 * If we added blocks beyond i_size, we need to make sure they will get
+	 * truncated if we crash before updating i_size in ext4_iomap_end().
+	 * For faults we don't need to do that (and even cannot because for
+	 * orphan list operations inode_lock is required) - if we happen to
+	 * instantiate block beyond i_size, it is because we race with truncate
+	 * which has already added the inode to the orphan list.
+	 */
+	if (!(flags & IOMAP_FAULT) && first_block + map->m_len >
+	    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
+		int err;
+
+		err = ext4_orphan_add(handle, inode);
+		if (err < 0)
+			ret = err;
+	}
+journal_stop:
+	ext4_journal_stop(handle);
+	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+		goto retry;
+	return ret;
+}
+
+static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+		unsigned flags, struct iomap *iomap)
+{
+	unsigned int blkbits = inode->i_blkbits;
+	unsigned long first_block, last_block;
+	struct ext4_map_blocks map;
+	int ret;
+
+	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
+		return -EINVAL;
+	first_block = offset >> blkbits;
+	last_block = min_t(loff_t, (offset + length - 1) >> blkbits,
+			   EXT4_MAX_LOGICAL_BLOCK);
+
+	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
+		return -ERANGE;
+
+	map.m_lblk = first_block;
+	map.m_len = last_block - first_block + 1;
+	if (flags & IOMAP_WRITE)
+		ret = ext4_iomap_alloc(inode, flags, first_block, &map);
+	else
+		ret = ext4_map_blocks(NULL, inode, &map, 0);
+
+	if (ret < 0)
+		return ret;
+	return ext4_set_iomap(inode, iomap, ret ? 0 : IOMAP_HOLE, first_block,
+			      &map);
+}
+
 static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 			  ssize_t written, unsigned flags, struct iomap *iomap)
 {
@@ -3654,6 +3618,71 @@ const struct iomap_ops ext4_iomap_ops = {
 	.iomap_begin		= ext4_iomap_begin,
 	.iomap_end		= ext4_iomap_end,
 };
+#endif /* CONFIG_FS_DAX */
+
+static u16 ext4_iomap_check_delalloc(struct inode *inode,
+		struct ext4_map_blocks *map)
+{
+	ext4_lblk_t end = map->m_lblk + map->m_len - 1;
+	struct extent_status es;
+
+	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, map->m_lblk, end,
+			&es);
+
+	/* entire range is a hole */
+	if (!es.es_len || es.es_lblk > end)
+		return IOMAP_HOLE;
+	if (es.es_lblk <= map->m_lblk) {
+		ext4_lblk_t offs = 0;
+
+		if (es.es_lblk < map->m_lblk)
+			offs = map->m_lblk - es.es_lblk;
+		map->m_lblk = es.es_lblk + offs;
+		map->m_len = es.es_len - offs;
+		return IOMAP_DELALLOC;
+	}
+	/* range starts with a hole */
+	map->m_len = es.es_lblk - map->m_lblk;
+	return IOMAP_HOLE;
+}
+
+static int ext4_report_iomap_begin(struct inode *inode, loff_t offset,
+		loff_t length, unsigned flags, struct iomap *iomap)
+{
+	unsigned int blkbits = inode->i_blkbits;
+	unsigned long first_block, last_block;
+	struct ext4_map_blocks map;
+	u16 type = 0;
+	int ret;
+
+	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
+		return -EINVAL;
+	first_block = offset >> blkbits;
+	last_block = min_t(loff_t, (offset + length - 1) >> blkbits,
+			   EXT4_MAX_LOGICAL_BLOCK);
+
+	if (ext4_has_inline_data(inode)) {
+		ret = ext4_inline_data_iomap(inode, iomap);
+		if (ret != -EAGAIN) {
+			if (ret == 0 && offset >= iomap->length)
+				ret = -ENOENT;
+			return ret;
+		}
+	}
+
+	map.m_lblk = first_block;
+	map.m_len = last_block - first_block + 1;
+	ret = ext4_map_blocks(NULL, inode, &map, 0);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		type = ext4_iomap_check_delalloc(inode, &map);
+	return ext4_set_iomap(inode, iomap, type, first_block, &map);
+}
+
+const struct iomap_ops ext4_report_iomap_ops = {
+	.iomap_begin		= ext4_report_iomap_begin,
+};
 
 static int ext4_end_io_dio(struct kiocb *iocb, loff_t offset,
 			    ssize_t size, void *private)
-- 
2.20.1

