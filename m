Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D28619EC76
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Apr 2020 17:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgDEPyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Apr 2020 11:54:36 -0400
Received: from smtprelay0033.hostedemail.com ([216.40.44.33]:32944 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726696AbgDEPyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Apr 2020 11:54:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9839818224D7E;
        Sun,  5 Apr 2020 15:54:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:4:41:69:355:371:372:379:800:960:966:968:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:2196:2198:2199:2200:2393:2553:2559:2562:2828:2901:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:4250:4321:4384:4385:4395:4419:4605:5007:6119:7903:8603:10004:10848:11026:11473:11658:11914:12043:12291:12296:12297:12438:12555:12679:12683:12760:12986:13439:14096:14097:14394:14659:21080:21324:21433:21451:21627:21810:21987:21990:30034:30054:30056:30062:30069:30070:30090,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: work18_a92868a2d240
X-Filterd-Recvd-Size: 17506
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sun,  5 Apr 2020 15:54:32 +0000 (UTC)
Message-ID: <b1050f72fcade3475ff10d1e0ef1cb4d0cfde0c0.camel@perches.com>
Subject: [PATCH] exfat: Use a more common logging style
From:   Joe Perches <joe@perches.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 05 Apr 2020 08:52:35 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the direct use of KERN_<LEVEL> in functions by creating
separate exfat_<level> macros.

Miscellanea:

o Remove several unnecessary terminating newlines in formats
o Realign arguments and fit to 80 columns where appropriate

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/exfat/balloc.c   |  8 +++-----
 fs/exfat/dir.c      |  9 ++++-----
 fs/exfat/exfat_fs.h |  7 +++++++
 fs/exfat/fatent.c   | 13 +++++--------
 fs/exfat/misc.c     |  4 ++--
 fs/exfat/namei.c    | 26 ++++++++++----------------
 fs/exfat/nls.c      | 20 ++++++++------------
 fs/exfat/super.c    | 49 ++++++++++++++++++++++---------------------------
 8 files changed, 61 insertions(+), 75 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 6a04cc0..7238a3 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -58,9 +58,8 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 	need_map_size = ((EXFAT_DATA_CLUSTER_COUNT(sbi) - 1) / BITS_PER_BYTE)
 		+ 1;
 	if (need_map_size != map_size) {
-		exfat_msg(sb, KERN_ERR,
-				"bogus allocation bitmap size(need : %u, cur : %lld)",
-				need_map_size, map_size);
+		exfat_err(sb, "bogus allocation bitmap size(need : %u, cur : %lld)",
+			  need_map_size, map_size);
 		/*
 		 * Only allowed when bogus allocation
 		 * bitmap size is large
@@ -195,8 +194,7 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu)
 			(1 << sbi->sect_per_clus_bits), GFP_NOFS, 0);
 
 		if (ret_discard == -EOPNOTSUPP) {
-			exfat_msg(sb, KERN_ERR,
-				"discard not supported by device, disabling");
+			exfat_err(sb, "discard not supported by device, disabling");
 			opts->discard = 0;
 		}
 	}
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 4b91af..53ae96 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -720,9 +720,8 @@ static int exfat_dir_readahead(struct super_block *sb, sector_t sec)
 		return 0;
 
 	if (sec < sbi->data_start_sector) {
-		exfat_msg(sb, KERN_ERR,
-			"requested sector is invalid(sect:%llu, root:%llu)",
-			(unsigned long long)sec, sbi->data_start_sector);
+		exfat_err(sb, "requested sector is invalid(sect:%llu, root:%llu)",
+			  (unsigned long long)sec, sbi->data_start_sector);
 		return -EIO;
 	}
 
@@ -750,7 +749,7 @@ struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
 	sector_t sec;
 
 	if (p_dir->dir == DIR_DELETED) {
-		exfat_msg(sb, KERN_ERR, "abnormal access to deleted dentry\n");
+		exfat_err(sb, "abnormal access to deleted dentry");
 		return NULL;
 	}
 
@@ -853,7 +852,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	struct buffer_head *bh;
 
 	if (p_dir->dir == DIR_DELETED) {
-		exfat_msg(sb, KERN_ERR, "access to deleted dentry\n");
+		exfat_err(sb, "access to deleted dentry");
 		return NULL;
 	}
 
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 67d4e4..c09c8d1 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -505,6 +505,13 @@ void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
 		fmt, ## args)
 void exfat_msg(struct super_block *sb, const char *lv, const char *fmt, ...)
 		__printf(3, 4) __cold;
+#define exfat_err(sb, fmt, ...)						\
+	exfat_msg(sb, KERN_ERR, fmt, ##__VA_ARGS__)
+#define exfat_warn(sb, fmt, ...)					\
+	exfat_msg(sb, KERN_WARNING, fmt, ##__VA_ARGS__)
+#define exfat_info(sb, fmt, ...)					\
+	exfat_msg(sb, KERN_INFO, fmt, ##__VA_ARGS__)
+
 void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 tz, __le16 time, __le16 date, u8 time_ms);
 void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index a855b17..267e5e0 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -170,8 +170,7 @@ int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
 
 	/* check cluster validation */
 	if (p_chain->dir < 2 && p_chain->dir >= sbi->num_clusters) {
-		exfat_msg(sb, KERN_ERR, "invalid start cluster (%u)",
-				p_chain->dir);
+		exfat_err(sb, "invalid start cluster (%u)", p_chain->dir);
 		return -EIO;
 	}
 
@@ -305,8 +304,7 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
 	return 0;
 
 release_bhs:
-	exfat_msg(sb, KERN_ERR, "failed zeroed sect %llu\n",
-		(unsigned long long)blknr);
+	exfat_err(sb, "failed zeroed sect %llu\n", (unsigned long long)blknr);
 	for (i = 0; i < n; i++)
 		bforget(bhs[i]);
 	return err;
@@ -337,9 +335,8 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 	/* find new cluster */
 	if (hint_clu == EXFAT_EOF_CLUSTER) {
 		if (sbi->clu_srch_ptr < EXFAT_FIRST_CLUSTER) {
-			exfat_msg(sb, KERN_ERR,
-				"sbi->clu_srch_ptr is invalid (%u)\n",
-				sbi->clu_srch_ptr);
+			exfat_err(sb, "sbi->clu_srch_ptr is invalid (%u)\n",
+				  sbi->clu_srch_ptr);
 			sbi->clu_srch_ptr = EXFAT_FIRST_CLUSTER;
 		}
 
@@ -350,7 +347,7 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 
 	/* check cluster validation */
 	if (hint_clu < EXFAT_FIRST_CLUSTER && hint_clu >= sbi->num_clusters) {
-		exfat_msg(sb, KERN_ERR, "hint_cluster is invalid (%u)\n",
+		exfat_err(sb, "hint_cluster is invalid (%u)",
 			hint_clu);
 		hint_clu = EXFAT_FIRST_CLUSTER;
 		if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index 14a330..d32beb1 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -32,7 +32,7 @@ void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
 		va_start(args, fmt);
 		vaf.fmt = fmt;
 		vaf.va = &args;
-		exfat_msg(sb, KERN_ERR, "error, %pV\n", &vaf);
+		exfat_err(sb, "error, %pV", &vaf);
 		va_end(args);
 	}
 
@@ -41,7 +41,7 @@ void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
 			sb->s_id);
 	} else if (opts->errors == EXFAT_ERRORS_RO && !sb_rdonly(sb)) {
 		sb->s_flags |= SB_RDONLY;
-		exfat_msg(sb, KERN_ERR, "Filesystem has been set read-only");
+		exfat_err(sb, "Filesystem has been set read-only");
 	}
 }
 
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index a8681d..1ad2f7 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -776,8 +776,8 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 		if (d_unhashed(alias)) {
 			WARN_ON(alias->d_name.hash_len !=
 				dentry->d_name.hash_len);
-			exfat_msg(sb, KERN_INFO,
-				"rehashed a dentry(%p) in read lookup", alias);
+			exfat_info(sb, "rehashed a dentry(%p) in read lookup",
+				   alias);
 			d_drop(dentry);
 			d_rehash(alias);
 		} else if (!S_ISDIR(i_mode)) {
@@ -822,7 +822,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	exfat_chain_dup(&cdir, &ei->dir);
 	entry = ei->entry;
 	if (ei->dir.dir == DIR_DELETED) {
-		exfat_msg(sb, KERN_ERR, "abnormal access to deleted dentry");
+		exfat_err(sb, "abnormal access to deleted dentry");
 		err = -ENOENT;
 		goto unlock;
 	}
@@ -974,7 +974,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	entry = ei->entry;
 
 	if (ei->dir.dir == DIR_DELETED) {
-		exfat_msg(sb, KERN_ERR, "abnormal access to deleted dentry");
+		exfat_err(sb, "abnormal access to deleted dentry");
 		err = -ENOENT;
 		goto unlock;
 	}
@@ -986,9 +986,8 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	err = exfat_check_dir_empty(sb, &clu_to_free);
 	if (err) {
 		if (err == -EIO)
-			exfat_msg(sb, KERN_ERR,
-				"failed to exfat_check_dir_empty : err(%d)",
-				err);
+			exfat_err(sb, "failed to exfat_check_dir_empty : err(%d)",
+				  err);
 		goto unlock;
 	}
 
@@ -1009,9 +1008,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 
 	err = exfat_remove_entries(dir, &cdir, entry, 0, num_entries);
 	if (err) {
-		exfat_msg(sb, KERN_ERR,
-				"failed to exfat_remove_entries : err(%d)",
-				err);
+		exfat_err(sb, "failed to exfat_remove_entries : err(%d)", err);
 		goto unlock;
 	}
 	ei->dir.dir = DIR_DELETED;
@@ -1238,8 +1235,7 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		return -EINVAL;
 
 	if (ei->dir.dir == DIR_DELETED) {
-		exfat_msg(sb, KERN_ERR,
-				"abnormal access to deleted source dentry");
+		exfat_err(sb, "abnormal access to deleted source dentry");
 		return -ENOENT;
 	}
 
@@ -1261,8 +1257,7 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		new_ei = EXFAT_I(new_inode);
 
 		if (new_ei->dir.dir == DIR_DELETED) {
-			exfat_msg(sb, KERN_ERR,
-				"abnormal access to deleted target dentry");
+			exfat_err(sb, "abnormal access to deleted target dentry");
 			goto out;
 		}
 
@@ -1423,8 +1418,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 			if (S_ISDIR(new_inode->i_mode))
 				drop_nlink(new_inode);
 		} else {
-			exfat_msg(sb, KERN_WARNING,
-					"abnormal access to an inode dropped");
+			exfat_warn(sb, "abnormal access to an inode dropped");
 			WARN_ON(new_inode->i_nlink == 0);
 		}
 		new_inode->i_ctime = EXFAT_I(new_inode)->i_crtime =
diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 6d1c3a..217878 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -503,16 +503,14 @@ static int exfat_utf8_to_utf16(struct super_block *sb,
 	unilen = utf8s_to_utf16s(p_cstring, len, UTF16_HOST_ENDIAN,
 			(wchar_t *)uniname, MAX_NAME_LENGTH + 2);
 	if (unilen < 0) {
-		exfat_msg(sb, KERN_ERR,
-			"failed to %s (err : %d) nls len : %d",
-			__func__, unilen, len);
+		exfat_err(sb, "failed to %s (err : %d) nls len : %d",
+			  __func__, unilen, len);
 		return unilen;
 	}
 
 	if (unilen > MAX_NAME_LENGTH) {
-		exfat_msg(sb, KERN_ERR,
-			"failed to %s (estr:ENAMETOOLONG) nls len : %d, unilen : %d > %d",
-			__func__, len, unilen, MAX_NAME_LENGTH);
+		exfat_err(sb, "failed to %s (estr:ENAMETOOLONG) nls len : %d, unilen : %d > %d",
+			  __func__, len, unilen, MAX_NAME_LENGTH);
 		return -ENAMETOOLONG;
 	}
 
@@ -687,9 +685,8 @@ static int exfat_load_upcase_table(struct super_block *sb,
 
 		bh = sb_bread(sb, sector);
 		if (!bh) {
-			exfat_msg(sb, KERN_ERR,
-				"failed to read sector(0x%llx)\n",
-				(unsigned long long)sector);
+			exfat_err(sb, "failed to read sector(0x%llx)\n",
+				  (unsigned long long)sector);
 			ret = -EIO;
 			goto free_table;
 		}
@@ -722,9 +719,8 @@ static int exfat_load_upcase_table(struct super_block *sb,
 	if (index >= 0xFFFF && utbl_checksum == checksum)
 		return 0;
 
-	exfat_msg(sb, KERN_ERR,
-			"failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)\n",
-			index, checksum, utbl_checksum);
+	exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)",
+		  index, checksum, utbl_checksum);
 	ret = -EINVAL;
 free_table:
 	exfat_free_upcase_table(sbi);
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 16ed202e..cfe4ad 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -118,7 +118,7 @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
 	if (!sbi->pbr_bh) {
 		sbi->pbr_bh = sb_bread(sb, 0);
 		if (!sbi->pbr_bh) {
-			exfat_msg(sb, KERN_ERR, "failed to read boot sector");
+			exfat_err(sb, "failed to read boot sector");
 			return -ENOMEM;
 		}
 	}
@@ -365,15 +365,13 @@ static struct pbr *exfat_read_pbr_with_logical_sector(struct super_block *sb,
 
 	if (!is_power_of_2(logical_sect) ||
 	    logical_sect < 512 || logical_sect > 4096) {
-		exfat_msg(sb, KERN_ERR, "bogus logical sector size %u",
-				logical_sect);
+		exfat_err(sb, "bogus logical sector size %u", logical_sect);
 		return NULL;
 	}
 
 	if (logical_sect < sb->s_blocksize) {
-		exfat_msg(sb, KERN_ERR,
-			"logical sector size too small for device (logical sector size = %u)",
-			logical_sect);
+		exfat_err(sb, "logical sector size too small for device (logical sector size = %u)",
+			  logical_sect);
 		return NULL;
 	}
 
@@ -384,15 +382,14 @@ static struct pbr *exfat_read_pbr_with_logical_sector(struct super_block *sb,
 		*prev_bh = NULL;
 
 		if (!sb_set_blocksize(sb, logical_sect)) {
-			exfat_msg(sb, KERN_ERR,
-				"unable to set blocksize %u", logical_sect);
+			exfat_err(sb, "unable to set blocksize %u",
+				  logical_sect);
 			return NULL;
 		}
 		bh = sb_bread(sb, 0);
 		if (!bh) {
-			exfat_msg(sb, KERN_ERR,
-				"unable to read boot sector (logical sector size = %lu)",
-				sb->s_blocksize);
+			exfat_err(sb, "unable to read boot sector (logical sector size = %lu)",
+				  sb->s_blocksize);
 			return NULL;
 		}
 
@@ -417,7 +414,7 @@ static int __exfat_fill_super(struct super_block *sb)
 	/* read boot sector */
 	bh = sb_bread(sb, 0);
 	if (!bh) {
-		exfat_msg(sb, KERN_ERR, "unable to read boot sector");
+		exfat_err(sb, "unable to read boot sector");
 		return -EIO;
 	}
 
@@ -426,7 +423,7 @@ static int __exfat_fill_super(struct super_block *sb)
 
 	/* check the validity of PBR */
 	if (le16_to_cpu((p_pbr->signature)) != PBR_SIGNATURE) {
-		exfat_msg(sb, KERN_ERR, "invalid boot record signature");
+		exfat_err(sb, "invalid boot record signature");
 		ret = -EINVAL;
 		goto free_bh;
 	}
@@ -451,7 +448,7 @@ static int __exfat_fill_super(struct super_block *sb)
 
 	p_bpb = (struct pbr64 *)p_pbr;
 	if (!p_bpb->bsx.num_fats) {
-		exfat_msg(sb, KERN_ERR, "bogus number of FAT structure");
+		exfat_err(sb, "bogus number of FAT structure");
 		ret = -EINVAL;
 		goto free_bh;
 	}
@@ -481,8 +478,7 @@ static int __exfat_fill_super(struct super_block *sb)
 
 	if (le16_to_cpu(p_bpb->bsx.vol_flags) & VOL_DIRTY) {
 		sbi->vol_flag |= VOL_DIRTY;
-		exfat_msg(sb, KERN_WARNING,
-			"Volume was not properly unmounted. Some data may be corrupt. Please run fsck.");
+		exfat_warn(sb, "Volume was not properly unmounted. Some data may be corrupt. Please run fsck.");
 	}
 
 	/* exFAT file size is limited by a disk volume size */
@@ -491,19 +487,19 @@ static int __exfat_fill_super(struct super_block *sb)
 
 	ret = exfat_create_upcase_table(sb);
 	if (ret) {
-		exfat_msg(sb, KERN_ERR, "failed to load upcase table");
+		exfat_err(sb, "failed to load upcase table");
 		goto free_bh;
 	}
 
 	ret = exfat_load_bitmap(sb);
 	if (ret) {
-		exfat_msg(sb, KERN_ERR, "failed to load alloc-bitmap");
+		exfat_err(sb, "failed to load alloc-bitmap");
 		goto free_upcase_table;
 	}
 
 	ret = exfat_count_used_clusters(sb, &sbi->used_clusters);
 	if (ret) {
-		exfat_msg(sb, KERN_ERR, "failed to scan clusters");
+		exfat_err(sb, "failed to scan clusters");
 		goto free_alloc_bitmap;
 	}
 
@@ -532,8 +528,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 		struct request_queue *q = bdev_get_queue(sb->s_bdev);
 
 		if (!blk_queue_discard(q))
-			exfat_msg(sb, KERN_WARNING,
-				"mounting with \"discard\" option, but the device does not support discard");
+			exfat_warn(sb, "mounting with \"discard\" option, but the device does not support discard");
 		opts->discard = 0;
 	}
 
@@ -547,7 +542,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	err = __exfat_fill_super(sb);
 	if (err) {
-		exfat_msg(sb, KERN_ERR, "failed to recognize exfat type");
+		exfat_err(sb, "failed to recognize exfat type");
 		goto check_nls_io;
 	}
 
@@ -559,8 +554,8 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	else {
 		sbi->nls_io = load_nls(sbi->options.iocharset);
 		if (!sbi->nls_io) {
-			exfat_msg(sb, KERN_ERR, "IO charset %s not found",
-					sbi->options.iocharset);
+			exfat_err(sb, "IO charset %s not found",
+				  sbi->options.iocharset);
 			err = -EINVAL;
 			goto free_table;
 		}
@@ -573,7 +568,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	root_inode = new_inode(sb);
 	if (!root_inode) {
-		exfat_msg(sb, KERN_ERR, "failed to allocate root inode.");
+		exfat_err(sb, "failed to allocate root inode");
 		err = -ENOMEM;
 		goto free_table;
 	}
@@ -582,7 +577,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode_set_iversion(root_inode, 1);
 	err = exfat_read_root(root_inode);
 	if (err) {
-		exfat_msg(sb, KERN_ERR, "failed to initialize root inode.");
+		exfat_err(sb, "failed to initialize root inode");
 		goto put_inode;
 	}
 
@@ -591,7 +586,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_root = d_make_root(root_inode);
 	if (!sb->s_root) {
-		exfat_msg(sb, KERN_ERR, "failed to get the root dentry");
+		exfat_err(sb, "failed to get the root dentry");
 		err = -ENOMEM;
 		goto put_inode;
 	}


