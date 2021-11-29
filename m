Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BB046138C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 12:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377281AbhK2LNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 06:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbhK2LK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:10:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD70EC0613B1;
        Mon, 29 Nov 2021 02:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JeGTBYwcFtstkkTYN7zPtjhm0Z/PelxPkiqUh7H0zqQ=; b=dzcSOz0IrhcFRwdVJibR8SZhSV
        451ezHdSdw4eTCkZD7OCDn5+Ej1io5AYoie4ocwZzVFkxLxsXx3yMXMFTlhYoE6wv1wKPA1p7oZU2
        ciW9nJBm6S1j6OybZ7eaOR/eSwsQuCctU+umtLyQODfiveM+Tl56eoZxAvFx9NtIinkPrUVx6E6F5
        NcfAD8UMm7WYtD49ZeJlN+qEzVonh3KonFFfvqqVWRq0uH0xByCFa+Oa0J5SrFMgWow8imMGkIfRh
        spSOawn6irEVlYvrSf9n3jTge/OW5bJWB7YN44zKKR7BpizLRCSIqU4oc4PWs8i+g/Pk6Tuh9Hrn5
        npvDywKw==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrdnz-0073XX-Rx; Mon, 29 Nov 2021 10:22:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 26/29] fsdax: shift partition offset handling into the file systems
Date:   Mon, 29 Nov 2021 11:22:00 +0100
Message-Id: <20211129102203.2243509-27-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the last user of ->bdev in dax.c by requiring the file system to
pass in an address that already includes the DAX offset.  As part of the
only set ->bdev or ->daxdev when actually required in the ->iomap_begin
methods.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com> [erofs]
---
 fs/dax.c            |  6 +-----
 fs/erofs/data.c     | 11 +++++++++--
 fs/erofs/internal.h |  1 +
 fs/ext2/inode.c     |  8 ++++++--
 fs/ext4/inode.c     | 16 +++++++++++-----
 fs/xfs/xfs_iomap.c  | 10 ++++++++--
 6 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 148e8b0967f35..e0eecd8e3a8f8 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -711,11 +711,7 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 
 static pgoff_t dax_iomap_pgoff(const struct iomap *iomap, loff_t pos)
 {
-	phys_addr_t paddr = iomap->addr + (pos & PAGE_MASK) - iomap->offset;
-
-	if (iomap->bdev)
-		paddr += (get_start_sect(iomap->bdev) << SECTOR_SHIFT);
-	return PHYS_PFN(paddr);
+	return PHYS_PFN(iomap->addr + (pos & PAGE_MASK) - iomap->offset);
 }
 
 static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter)
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0e35ef3f9f3d7..9b1bb177ce303 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -159,6 +159,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	/* primary device by default */
 	map->m_bdev = sb->s_bdev;
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
+	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
 
 	if (map->m_deviceid) {
 		down_read(&devs->rwsem);
@@ -169,6 +170,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 		}
 		map->m_bdev = dif->bdev;
 		map->m_daxdev = dif->dax_dev;
+		map->m_dax_part_off = dif->dax_part_off;
 		up_read(&devs->rwsem);
 	} else if (devs->extra_devices) {
 		down_read(&devs->rwsem);
@@ -185,6 +187,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 				map->m_pa -= startoff;
 				map->m_bdev = dif->bdev;
 				map->m_daxdev = dif->dax_dev;
+				map->m_dax_part_off = dif->dax_part_off;
 				break;
 			}
 		}
@@ -215,9 +218,13 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (ret)
 		return ret;
 
-	iomap->bdev = mdev.m_bdev;
-	iomap->dax_dev = mdev.m_daxdev;
 	iomap->offset = map.m_la;
+	if (flags & IOMAP_DAX) {
+		iomap->dax_dev = mdev.m_daxdev;
+		iomap->offset += mdev.m_dax_part_off;
+	} else {
+		iomap->bdev = mdev.m_bdev;
+	}
 	iomap->length = map.m_llen;
 	iomap->flags = 0;
 	iomap->private = NULL;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index c1e65346e9f15..5c2a83876220c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -438,6 +438,7 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
 struct erofs_map_dev {
 	struct block_device *m_bdev;
 	struct dax_device *m_daxdev;
+	u64 m_dax_part_off;
 
 	erofs_off_t m_pa;
 	unsigned int m_deviceid;
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 01d69618277de..602578b72d8c5 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -817,9 +817,11 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return ret;
 
 	iomap->flags = 0;
-	iomap->bdev = inode->i_sb->s_bdev;
 	iomap->offset = (u64)first_block << blkbits;
-	iomap->dax_dev = sbi->s_daxdev;
+	if (flags & IOMAP_DAX)
+		iomap->dax_dev = sbi->s_daxdev;
+	else
+		iomap->bdev = inode->i_sb->s_bdev;
 
 	if (ret == 0) {
 		iomap->type = IOMAP_HOLE;
@@ -828,6 +830,8 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	} else {
 		iomap->type = IOMAP_MAPPED;
 		iomap->addr = (u64)bno << blkbits;
+		if (flags & IOMAP_DAX)
+			iomap->addr += sbi->s_dax_part_off;
 		iomap->length = (u64)ret << blkbits;
 		iomap->flags |= IOMAP_F_MERGED;
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 89c4a174bd393..ccafcbc146d3e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3272,7 +3272,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 
 static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 			   struct ext4_map_blocks *map, loff_t offset,
-			   loff_t length)
+			   loff_t length, unsigned int flags)
 {
 	u8 blkbits = inode->i_blkbits;
 
@@ -3289,8 +3289,10 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	if (map->m_flags & EXT4_MAP_NEW)
 		iomap->flags |= IOMAP_F_NEW;
 
-	iomap->bdev = inode->i_sb->s_bdev;
-	iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
+	if (flags & IOMAP_DAX)
+		iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
+	else
+		iomap->bdev = inode->i_sb->s_bdev;
 	iomap->offset = (u64) map->m_lblk << blkbits;
 	iomap->length = (u64) map->m_len << blkbits;
 
@@ -3310,9 +3312,13 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	if (map->m_flags & EXT4_MAP_UNWRITTEN) {
 		iomap->type = IOMAP_UNWRITTEN;
 		iomap->addr = (u64) map->m_pblk << blkbits;
+		if (flags & IOMAP_DAX)
+			iomap->addr += EXT4_SB(inode->i_sb)->s_dax_part_off;
 	} else if (map->m_flags & EXT4_MAP_MAPPED) {
 		iomap->type = IOMAP_MAPPED;
 		iomap->addr = (u64) map->m_pblk << blkbits;
+		if (flags & IOMAP_DAX)
+			iomap->addr += EXT4_SB(inode->i_sb)->s_dax_part_off;
 	} else {
 		iomap->type = IOMAP_HOLE;
 		iomap->addr = IOMAP_NULL_ADDR;
@@ -3421,7 +3427,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (ret < 0)
 		return ret;
 out:
-	ext4_set_iomap(inode, iomap, &map, offset, length);
+	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
 
 	return 0;
 }
@@ -3541,7 +3547,7 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 		delalloc = ext4_iomap_is_delalloc(inode, &map);
 
 set_iomap:
-	ext4_set_iomap(inode, iomap, &map, offset, length);
+	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
 	if (delalloc && iomap->type == IOMAP_HOLE)
 		iomap->type = IOMAP_DELALLOC;
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 0ed3e7674353b..e552ce541ec2d 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -71,15 +71,21 @@ xfs_bmbt_to_iomap(
 		iomap->type = IOMAP_DELALLOC;
 	} else {
 		iomap->addr = BBTOB(xfs_fsb_to_db(ip, imap->br_startblock));
+		if (mapping_flags & IOMAP_DAX)
+			iomap->addr += target->bt_dax_part_off;
+
 		if (imap->br_state == XFS_EXT_UNWRITTEN)
 			iomap->type = IOMAP_UNWRITTEN;
 		else
 			iomap->type = IOMAP_MAPPED;
+
 	}
 	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
 	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
-	iomap->bdev = target->bt_bdev;
-	iomap->dax_dev = target->bt_daxdev;
+	if (mapping_flags & IOMAP_DAX)
+		iomap->dax_dev = target->bt_daxdev;
+	else
+		iomap->bdev = target->bt_bdev;
 	iomap->flags = iomap_flags;
 
 	if (xfs_ipincount(ip) &&
-- 
2.30.2

