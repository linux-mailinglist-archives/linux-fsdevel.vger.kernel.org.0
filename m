Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D342788C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 14:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgIYM5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 08:57:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:51808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbgIYM5e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:57:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69C6DAF40
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2020 12:57:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2C1ED1E12E9; Fri, 25 Sep 2020 14:57:32 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] udf: Remove pointless union in udf_inode_info
Date:   Fri, 25 Sep 2020 14:57:29 +0200
Message-Id: <20200925125730.8496-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200925125730.8496-1-jack@suse.cz>
References: <20200925125730.8496-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We use only a single member out of the i_ext union in udf_inode_info.
Just remove the pointless union.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/directory.c |  2 +-
 fs/udf/file.c      |  7 +++----
 fs/udf/ialloc.c    | 14 +++++++-------
 fs/udf/inode.c     | 36 +++++++++++++++++-------------------
 fs/udf/misc.c      |  6 +++---
 fs/udf/namei.c     |  7 +++----
 fs/udf/partition.c |  2 +-
 fs/udf/super.c     |  4 ++--
 fs/udf/symlink.c   |  2 +-
 fs/udf/udf_i.h     |  6 +-----
 10 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index d9523013096f..73720320f0ab 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -34,7 +34,7 @@ struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
 	fibh->soffset = fibh->eoffset;
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-		fi = udf_get_fileident(iinfo->i_ext.i_data -
+		fi = udf_get_fileident(iinfo->i_data -
 				       (iinfo->i_efe ?
 					sizeof(struct extendedFileEntry) :
 					sizeof(struct fileEntry)),
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 628941a6b79a..ad8eefad27d7 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -50,7 +50,7 @@ static void __udf_adinicb_readpage(struct page *page)
 	 * So just sample it once and use the same value everywhere.
 	 */
 	kaddr = kmap_atomic(page);
-	memcpy(kaddr, iinfo->i_ext.i_data + iinfo->i_lenEAttr, isize);
+	memcpy(kaddr, iinfo->i_data + iinfo->i_lenEAttr, isize);
 	memset(kaddr + isize, 0, PAGE_SIZE - isize);
 	flush_dcache_page(page);
 	SetPageUptodate(page);
@@ -76,8 +76,7 @@ static int udf_adinicb_writepage(struct page *page,
 	BUG_ON(!PageLocked(page));
 
 	kaddr = kmap_atomic(page);
-	memcpy(iinfo->i_ext.i_data + iinfo->i_lenEAttr, kaddr,
-		i_size_read(inode));
+	memcpy(iinfo->i_data + iinfo->i_lenEAttr, kaddr, i_size_read(inode));
 	SetPageUptodate(page);
 	kunmap_atomic(kaddr);
 	mark_inode_dirty(inode);
@@ -215,7 +214,7 @@ long udf_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return put_user(UDF_I(inode)->i_lenEAttr, (int __user *)arg);
 	case UDF_GETEABLOCK:
 		return copy_to_user((char __user *)arg,
-				    UDF_I(inode)->i_ext.i_data,
+				    UDF_I(inode)->i_data,
 				    UDF_I(inode)->i_lenEAttr) ? -EFAULT : 0;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index 0adb40718a5d..84ed23edebfd 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -67,16 +67,16 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
 		iinfo->i_efe = 1;
 		if (UDF_VERS_USE_EXTENDED_FE > sbi->s_udfrev)
 			sbi->s_udfrev = UDF_VERS_USE_EXTENDED_FE;
-		iinfo->i_ext.i_data = kzalloc(inode->i_sb->s_blocksize -
-					    sizeof(struct extendedFileEntry),
-					    GFP_KERNEL);
+		iinfo->i_data = kzalloc(inode->i_sb->s_blocksize -
+					sizeof(struct extendedFileEntry),
+					GFP_KERNEL);
 	} else {
 		iinfo->i_efe = 0;
-		iinfo->i_ext.i_data = kzalloc(inode->i_sb->s_blocksize -
-					    sizeof(struct fileEntry),
-					    GFP_KERNEL);
+		iinfo->i_data = kzalloc(inode->i_sb->s_blocksize -
+					sizeof(struct fileEntry),
+					GFP_KERNEL);
 	}
-	if (!iinfo->i_ext.i_data) {
+	if (!iinfo->i_data) {
 		iput(inode);
 		return ERR_PTR(-ENOMEM);
 	}
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 566118417e56..bb89c3e43212 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -157,8 +157,8 @@ void udf_evict_inode(struct inode *inode)
 	truncate_inode_pages_final(&inode->i_data);
 	invalidate_inode_buffers(inode);
 	clear_inode(inode);
-	kfree(iinfo->i_ext.i_data);
-	iinfo->i_ext.i_data = NULL;
+	kfree(iinfo->i_data);
+	iinfo->i_data = NULL;
 	udf_clear_extent_cache(inode);
 	if (want_delete) {
 		udf_free_inode(inode);
@@ -288,14 +288,14 @@ int udf_expand_file_adinicb(struct inode *inode)
 		kaddr = kmap_atomic(page);
 		memset(kaddr + iinfo->i_lenAlloc, 0x00,
 		       PAGE_SIZE - iinfo->i_lenAlloc);
-		memcpy(kaddr, iinfo->i_ext.i_data + iinfo->i_lenEAttr,
+		memcpy(kaddr, iinfo->i_data + iinfo->i_lenEAttr,
 			iinfo->i_lenAlloc);
 		flush_dcache_page(page);
 		SetPageUptodate(page);
 		kunmap_atomic(kaddr);
 	}
 	down_write(&iinfo->i_data_sem);
-	memset(iinfo->i_ext.i_data + iinfo->i_lenEAttr, 0x00,
+	memset(iinfo->i_data + iinfo->i_lenEAttr, 0x00,
 	       iinfo->i_lenAlloc);
 	iinfo->i_lenAlloc = 0;
 	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
@@ -311,8 +311,7 @@ int udf_expand_file_adinicb(struct inode *inode)
 		lock_page(page);
 		down_write(&iinfo->i_data_sem);
 		kaddr = kmap_atomic(page);
-		memcpy(iinfo->i_ext.i_data + iinfo->i_lenEAttr, kaddr,
-		       inode->i_size);
+		memcpy(iinfo->i_data + iinfo->i_lenEAttr, kaddr, inode->i_size);
 		kunmap_atomic(kaddr);
 		unlock_page(page);
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
@@ -399,8 +398,7 @@ struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	}
 	mark_buffer_dirty_inode(dbh, inode);
 
-	memset(iinfo->i_ext.i_data + iinfo->i_lenEAttr, 0,
-		iinfo->i_lenAlloc);
+	memset(iinfo->i_data + iinfo->i_lenEAttr, 0, iinfo->i_lenAlloc);
 	iinfo->i_lenAlloc = 0;
 	eloc.logicalBlockNum = *block;
 	eloc.partitionReferenceNum =
@@ -1263,7 +1261,7 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 		if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
 			down_write(&iinfo->i_data_sem);
 			udf_clear_extent_cache(inode);
-			memset(iinfo->i_ext.i_data + iinfo->i_lenEAttr + newsize,
+			memset(iinfo->i_data + iinfo->i_lenEAttr + newsize,
 			       0x00, bsize - newsize -
 			       udf_file_entry_alloc_offset(inode));
 			iinfo->i_lenAlloc = newsize;
@@ -1414,7 +1412,7 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 					sizeof(struct extendedFileEntry));
 		if (ret)
 			goto out;
-		memcpy(iinfo->i_ext.i_data,
+		memcpy(iinfo->i_data,
 		       bh->b_data + sizeof(struct extendedFileEntry),
 		       bs - sizeof(struct extendedFileEntry));
 	} else if (fe->descTag.tagIdent == cpu_to_le16(TAG_IDENT_FE)) {
@@ -1423,7 +1421,7 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		ret = udf_alloc_i_data(inode, bs - sizeof(struct fileEntry));
 		if (ret)
 			goto out;
-		memcpy(iinfo->i_ext.i_data,
+		memcpy(iinfo->i_data,
 		       bh->b_data + sizeof(struct fileEntry),
 		       bs - sizeof(struct fileEntry));
 	} else if (fe->descTag.tagIdent == cpu_to_le16(TAG_IDENT_USE)) {
@@ -1436,7 +1434,7 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 					sizeof(struct unallocSpaceEntry));
 		if (ret)
 			goto out;
-		memcpy(iinfo->i_ext.i_data,
+		memcpy(iinfo->i_data,
 		       bh->b_data + sizeof(struct unallocSpaceEntry),
 		       bs - sizeof(struct unallocSpaceEntry));
 		return 0;
@@ -1617,8 +1615,8 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 static int udf_alloc_i_data(struct inode *inode, size_t size)
 {
 	struct udf_inode_info *iinfo = UDF_I(inode);
-	iinfo->i_ext.i_data = kmalloc(size, GFP_KERNEL);
-	if (!iinfo->i_ext.i_data)
+	iinfo->i_data = kmalloc(size, GFP_KERNEL);
+	if (!iinfo->i_data)
 		return -ENOMEM;
 	return 0;
 }
@@ -1709,7 +1707,7 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 
 		use->lengthAllocDescs = cpu_to_le32(iinfo->i_lenAlloc);
 		memcpy(bh->b_data + sizeof(struct unallocSpaceEntry),
-		       iinfo->i_ext.i_data, inode->i_sb->s_blocksize -
+		       iinfo->i_data, inode->i_sb->s_blocksize -
 					sizeof(struct unallocSpaceEntry));
 		use->descTag.tagIdent = cpu_to_le16(TAG_IDENT_USE);
 		crclen = sizeof(struct unallocSpaceEntry);
@@ -1775,7 +1773,7 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 
 	if (iinfo->i_efe == 0) {
 		memcpy(bh->b_data + sizeof(struct fileEntry),
-		       iinfo->i_ext.i_data,
+		       iinfo->i_data,
 		       inode->i_sb->s_blocksize - sizeof(struct fileEntry));
 		fe->logicalBlocksRecorded = cpu_to_le64(lb_recorded);
 
@@ -1794,7 +1792,7 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 		crclen = sizeof(struct fileEntry);
 	} else {
 		memcpy(bh->b_data + sizeof(struct extendedFileEntry),
-		       iinfo->i_ext.i_data,
+		       iinfo->i_data,
 		       inode->i_sb->s_blocksize -
 					sizeof(struct extendedFileEntry));
 		efe->objectSize =
@@ -2090,7 +2088,7 @@ void udf_write_aext(struct inode *inode, struct extent_position *epos,
 	struct udf_inode_info *iinfo = UDF_I(inode);
 
 	if (!epos->bh)
-		ptr = iinfo->i_ext.i_data + epos->offset -
+		ptr = iinfo->i_data + epos->offset -
 			udf_file_entry_alloc_offset(inode) +
 			iinfo->i_lenEAttr;
 	else
@@ -2182,7 +2180,7 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 	if (!epos->bh) {
 		if (!epos->offset)
 			epos->offset = udf_file_entry_alloc_offset(inode);
-		ptr = iinfo->i_ext.i_data + epos->offset -
+		ptr = iinfo->i_data + epos->offset -
 			udf_file_entry_alloc_offset(inode) +
 			iinfo->i_lenEAttr;
 		alen = udf_file_entry_alloc_offset(inode) +
diff --git a/fs/udf/misc.c b/fs/udf/misc.c
index 401e64cde1be..eab94527340d 100644
--- a/fs/udf/misc.c
+++ b/fs/udf/misc.c
@@ -52,9 +52,9 @@ struct genericFormat *udf_add_extendedattr(struct inode *inode, uint32_t size,
 	uint16_t crclen;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 
-	ea = iinfo->i_ext.i_data;
+	ea = iinfo->i_data;
 	if (iinfo->i_lenEAttr) {
-		ad = iinfo->i_ext.i_data + iinfo->i_lenEAttr;
+		ad = iinfo->i_data + iinfo->i_lenEAttr;
 	} else {
 		ad = ea;
 		size += sizeof(struct extendedAttrHeaderDesc);
@@ -153,7 +153,7 @@ struct genericFormat *udf_get_extendedattr(struct inode *inode, uint32_t type,
 	uint32_t offset;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 
-	ea = iinfo->i_ext.i_data;
+	ea = iinfo->i_data;
 
 	if (iinfo->i_lenEAttr) {
 		struct extendedAttrHeaderDesc *eahd;
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 77b6d89b9bcd..e169d8fe35b5 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -460,8 +460,7 @@ static struct fileIdentDesc *udf_add_entry(struct inode *dir,
 		if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
 			block = dinfo->i_location.logicalBlockNum;
 			fi = (struct fileIdentDesc *)
-					(dinfo->i_ext.i_data +
-					 fibh->soffset -
+					(dinfo->i_data + fibh->soffset -
 					 udf_ext0_offset(dir) +
 					 dinfo->i_lenEAttr);
 		} else {
@@ -940,7 +939,7 @@ static int udf_symlink(struct inode *dir, struct dentry *dentry,
 		mark_buffer_dirty_inode(epos.bh, inode);
 		ea = epos.bh->b_data + udf_ext0_offset(inode);
 	} else
-		ea = iinfo->i_ext.i_data + iinfo->i_lenEAttr;
+		ea = iinfo->i_data + iinfo->i_lenEAttr;
 
 	eoffset = sb->s_blocksize - udf_ext0_offset(inode);
 	pc = (struct pathComponent *)ea;
@@ -1120,7 +1119,7 @@ static int udf_rename(struct inode *old_dir, struct dentry *old_dentry,
 		retval = -EIO;
 		if (old_iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
 			dir_fi = udf_get_fileident(
-					old_iinfo->i_ext.i_data -
+					old_iinfo->i_data -
 					  (old_iinfo->i_efe ?
 					   sizeof(struct extendedFileEntry) :
 					   sizeof(struct fileEntry)),
diff --git a/fs/udf/partition.c b/fs/udf/partition.c
index 090baff83990..4cbf40575965 100644
--- a/fs/udf/partition.c
+++ b/fs/udf/partition.c
@@ -65,7 +65,7 @@ uint32_t udf_get_pblock_virt15(struct super_block *sb, uint32_t block,
 	}
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-		loc = le32_to_cpu(((__le32 *)(iinfo->i_ext.i_data +
+		loc = le32_to_cpu(((__le32 *)(iinfo->i_data +
 			vdata->s_start_offset))[block]);
 		goto translate;
 	}
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 1c42f544096d..7df371e59eb7 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -168,7 +168,7 @@ static void init_once(void *foo)
 {
 	struct udf_inode_info *ei = (struct udf_inode_info *)foo;
 
-	ei->i_ext.i_data = NULL;
+	ei->i_data = NULL;
 	inode_init_once(&ei->vfs_inode);
 }
 
@@ -1210,7 +1210,7 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
 			vat20 = (struct virtualAllocationTable20 *)bh->b_data;
 		} else {
 			vat20 = (struct virtualAllocationTable20 *)
-							vati->i_ext.i_data;
+							vati->i_data;
 		}
 
 		map->s_type_specific.s_virtual.s_start_offset =
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index 25ff91c7e94a..c973db239604 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -122,7 +122,7 @@ static int udf_symlink_filler(struct file *file, struct page *page)
 
 	down_read(&iinfo->i_data_sem);
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-		symlink = iinfo->i_ext.i_data + iinfo->i_lenEAttr;
+		symlink = iinfo->i_data + iinfo->i_lenEAttr;
 	} else {
 		bh = sb_bread(inode->i_sb, pos);
 
diff --git a/fs/udf/udf_i.h b/fs/udf/udf_i.h
index 4245d1f63258..06ff7006b822 100644
--- a/fs/udf/udf_i.h
+++ b/fs/udf/udf_i.h
@@ -45,11 +45,7 @@ struct udf_inode_info {
 	unsigned		i_strat4096 : 1;
 	unsigned		i_streamdir : 1;
 	unsigned		reserved : 25;
-	union {
-		struct short_ad	*i_sad;
-		struct long_ad		*i_lad;
-		__u8		*i_data;
-	} i_ext;
+	__u8			*i_data;
 	struct kernel_lb_addr	i_locStreamdir;
 	__u64			i_lenStreams;
 	struct rw_semaphore	i_data_sem;
-- 
2.16.4

