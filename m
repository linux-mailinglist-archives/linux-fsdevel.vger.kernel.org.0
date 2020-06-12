Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08591F71B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 03:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgFLB3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 21:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFLB27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 21:28:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDD9C03E96F;
        Thu, 11 Jun 2020 18:28:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id m2so3156023pjv.2;
        Thu, 11 Jun 2020 18:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UuX98k44zJs9+jjw1elCUIEgCmzn+LhEnNmqpfI0RWg=;
        b=pdr0D1BaG+EvfOqtlDS+5TmSulHCsAQ6Xf8EYAFqF+tPRAq6eh4ntakzPibIpClLmy
         oMcLbHFHTgHL4j+84QMnS6nwpuX8LeL6FrzygtZDwhdD1C28pZyUhvYQ8uIxwqvEk1xL
         0MPXF8MwjBQBZExDs1NIIAynMNq14JupcB+LD8o55UwrX7wcW0//wkBqQcOJn2vJDWmI
         UM+svPZ6ApVbgATZwldBYv6yIbBbhzZ8ivU3UTCLaiP87xrqnlqV5eNOamqif6mItdEt
         KxiBSqNzP9Fka6wTQC4C1Jojclq0EZFnfSQ9fZjmIyl/zaKG/fCi7NALLarxq4ZtPaKs
         zmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UuX98k44zJs9+jjw1elCUIEgCmzn+LhEnNmqpfI0RWg=;
        b=KXFsTyxRKAMRBzCD2+oQDGJbWlu0y2NVmsRpfcm3NU/HFYgu1mMyNhN1ZbLjFnLmyR
         4ws+cLY2DJpgmscqZGTcO6gIyEVAtA7VpiLS0gJnO7e4jpKMGOqULXHK/qTmJYLVl8w+
         +RpWAb7vIiglhgwHYIZG/rlniIqXHPiFPKQ1QFilEZUvaRzF0SYCWXluiRGXiXezKkJj
         /WZ/A7uQBgkRmHZLRcw1/bQ4BG0HgY9R//00TQ13ROdiKslWUVKKOCuM7LMggaJ8uqOr
         Wj4OFUs7iiCtFl91JeWuqeQ5B4IOTq+S7g4/OdXZvnrgknJvL1V71/14qh2YWW5bJDOb
         42TA==
X-Gm-Message-State: AOAM530mRod2+LGRFxOReD7QqRvXJkntEDvsVvr8wxNp9vhoNFDnVylX
        VpKM9mDh+pApkrbTEC0GyIM=
X-Google-Smtp-Source: ABdhPJzspMQRP4u3MxYjs/LV1MtFeOM/n5bxRnYYJ68saMP7SJQBVHUNV6K6q9JdQq5WsCLVduqhwA==
X-Received: by 2002:a17:90a:de95:: with SMTP id n21mr10740317pjv.100.1591925339017;
        Thu, 11 Jun 2020 18:28:59 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:40d4:9829:ac15:641f])
        by smtp.gmail.com with ESMTPSA id h5sm4522096pfb.120.2020.06.11.18.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 18:28:58 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] exfat: remove EXFAT_SB_DIRTY flag
Date:   Fri, 12 Jun 2020 10:28:33 +0900
Message-Id: <20200612012834.13503-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

remove EXFAT_SB_DIRTY flag and related codes.

This flag is set/reset in exfat_put_super()/exfat_sync_fs()
to avoid sync_blockdev().
However ...
- exfat_put_super():
Before calling this, the VFS has already called sync_filesystem(),
so sync is never performed here.
- exfat_sync_fs():
After calling this, the VFS calls sync_blockdev(), so, it is meaningless
to check EXFAT_SB_DIRTY or to bypass sync_blockdev() here.
Not only that, but in some cases can't clear VOL_DIRTY.
ex:
VOL_DIRTY is set when rmdir starts, but when non-empty-dir is detected,
return error without setting EXFAT_SB_DIRTY.
If performe 'sync' in this state, VOL_DIRTY will not be cleared.

Remove the EXFAT_SB_DIRTY check to ensure synchronization.
And, remove the code related to the flag.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/balloc.c   |  4 ++--
 fs/exfat/dir.c      | 16 ++++++++--------
 fs/exfat/exfat_fs.h |  5 +----
 fs/exfat/fatent.c   |  7 ++-----
 fs/exfat/misc.c     |  3 +--
 fs/exfat/namei.c    | 12 ++++++------
 fs/exfat/super.c    | 11 +++--------
 7 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 4055eb00ea9b..a987919686c0 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -158,7 +158,7 @@ int exfat_set_bitmap(struct inode *inode, unsigned int clu)
 	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
 
 	set_bit_le(b, sbi->vol_amap[i]->b_data);
-	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
+	exfat_update_bh(sbi->vol_amap[i], IS_DIRSYNC(inode));
 	return 0;
 }
 
@@ -180,7 +180,7 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu)
 	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
 
 	clear_bit_le(b, sbi->vol_amap[i]->b_data);
-	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
+	exfat_update_bh(sbi->vol_amap[i], IS_DIRSYNC(inode));
 
 	if (opts->discard) {
 		int ret_discard;
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 8e775bd5d523..02acbb6ddf02 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -470,7 +470,7 @@ int exfat_init_dir_entry(struct inode *inode, struct exfat_chain *p_dir,
 			&ep->dentry.file.access_date,
 			NULL);
 
-	exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
+	exfat_update_bh(bh, IS_DIRSYNC(inode));
 	brelse(bh);
 
 	ep = exfat_get_dentry(sb, p_dir, entry + 1, &bh, &sector);
@@ -480,7 +480,7 @@ int exfat_init_dir_entry(struct inode *inode, struct exfat_chain *p_dir,
 	exfat_init_stream_entry(ep,
 		(type == TYPE_FILE) ? ALLOC_FAT_CHAIN : ALLOC_NO_FAT_CHAIN,
 		start_clu, size);
-	exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
+	exfat_update_bh(bh, IS_DIRSYNC(inode));
 	brelse(bh);
 
 	return 0;
@@ -516,7 +516,7 @@ int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
 	}
 
 	fep->dentry.file.checksum = cpu_to_le16(chksum);
-	exfat_update_bh(sb, fbh, IS_DIRSYNC(inode));
+	exfat_update_bh(fbh, IS_DIRSYNC(inode));
 release_fbh:
 	brelse(fbh);
 	return ret;
@@ -538,7 +538,7 @@ int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
 		return -EIO;
 
 	ep->dentry.file.num_ext = (unsigned char)(num_entries - 1);
-	exfat_update_bh(sb, bh, sync);
+	exfat_update_bh(bh, sync);
 	brelse(bh);
 
 	ep = exfat_get_dentry(sb, p_dir, entry + 1, &bh, &sector);
@@ -547,7 +547,7 @@ int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
 
 	ep->dentry.stream.name_len = p_uniname->name_len;
 	ep->dentry.stream.name_hash = cpu_to_le16(p_uniname->name_hash);
-	exfat_update_bh(sb, bh, sync);
+	exfat_update_bh(bh, sync);
 	brelse(bh);
 
 	for (i = EXFAT_FIRST_CLUSTER; i < num_entries; i++) {
@@ -556,7 +556,7 @@ int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
 			return -EIO;
 
 		exfat_init_name_entry(ep, uniname);
-		exfat_update_bh(sb, bh, sync);
+		exfat_update_bh(bh, sync);
 		brelse(bh);
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
@@ -580,7 +580,7 @@ int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
 			return -EIO;
 
 		exfat_set_entry_type(ep, TYPE_DELETED);
-		exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
+		exfat_update_bh(bh, IS_DIRSYNC(inode));
 		brelse(bh);
 	}
 
@@ -610,7 +610,7 @@ void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
 
 	for (i = 0; i < es->num_bh; i++) {
 		if (es->modified)
-			exfat_update_bh(es->sb, es->bh[i], sync);
+			exfat_update_bh(es->bh[i], sync);
 		brelse(es->bh[i]);
 	}
 	kfree(es);
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 595f3117f492..84664024e51e 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -13,8 +13,6 @@
 #define EXFAT_SUPER_MAGIC       0x2011BAB0UL
 #define EXFAT_ROOT_INO		1
 
-#define EXFAT_SB_DIRTY		0
-
 #define EXFAT_CLUSTERS_UNTRACKED (~0u)
 
 /*
@@ -238,7 +236,6 @@ struct exfat_sb_info {
 	unsigned int clu_srch_ptr; /* cluster search pointer */
 	unsigned int used_clusters; /* number of used clusters */
 
-	unsigned long s_state;
 	struct mutex s_lock; /* superblock lock */
 	struct exfat_mount_options options;
 	struct nls_table *nls_io; /* Charset used for input and display */
@@ -514,7 +511,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs);
 u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
 u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);
-void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync);
+void exfat_update_bh(struct buffer_head *bh, int sync);
 void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
 		unsigned int size, unsigned char flags);
 void exfat_chain_dup(struct exfat_chain *dup, struct exfat_chain *ec);
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 4e5c5c9c0f2d..82ee8246c080 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -75,7 +75,7 @@ int exfat_ent_set(struct super_block *sb, unsigned int loc,
 
 	fat_entry = (__le32 *)&(bh->b_data[off]);
 	*fat_entry = cpu_to_le32(content);
-	exfat_update_bh(sb, bh, sb->s_flags & SB_SYNCHRONOUS);
+	exfat_update_bh(bh, sb->s_flags & SB_SYNCHRONOUS);
 	exfat_mirror_bh(sb, sec, bh);
 	brelse(bh);
 	return 0;
@@ -174,7 +174,6 @@ int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
 		return -EIO;
 	}
 
-	set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
 	clu = p_chain->dir;
 
 	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
@@ -274,7 +273,7 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
 			goto release_bhs;
 		}
 		memset(bhs[n]->b_data, 0, sb->s_blocksize);
-		exfat_update_bh(sb, bhs[n], 0);
+		exfat_update_bh(bhs[n], 0);
 
 		n++;
 		blknr++;
@@ -358,8 +357,6 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 		}
 	}
 
-	set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
-
 	p_chain->dir = EXFAT_EOF_CLUSTER;
 
 	while ((new_clu = exfat_find_free_bitmap(sb, hint_clu)) !=
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index 17d41f3d3709..8a3dde59052b 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -163,9 +163,8 @@ u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type)
 	return chksum;
 }
 
-void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync)
+void exfat_update_bh(struct buffer_head *bh, int sync)
 {
-	set_bit(EXFAT_SB_DIRTY, &EXFAT_SB(sb)->s_state);
 	set_buffer_uptodate(bh);
 	mark_buffer_dirty(bh);
 
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index edd8023865a0..5eef2217fcf2 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -387,7 +387,7 @@ static int exfat_find_empty_entry(struct inode *inode,
 			ep->dentry.stream.valid_size = cpu_to_le64(size);
 			ep->dentry.stream.size = ep->dentry.stream.valid_size;
 			ep->dentry.stream.flags = p_dir->flags;
-			exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
+			exfat_update_bh(bh, IS_DIRSYNC(inode));
 			brelse(bh);
 			if (exfat_update_dir_chksum(inode, &(ei->dir),
 			    ei->entry))
@@ -1071,7 +1071,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 			epnew->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
 			ei->attr |= ATTR_ARCHIVE;
 		}
-		exfat_update_bh(sb, new_bh, sync);
+		exfat_update_bh(new_bh, sync);
 		brelse(old_bh);
 		brelse(new_bh);
 
@@ -1087,7 +1087,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 		}
 
 		memcpy(epnew, epold, DENTRY_SIZE);
-		exfat_update_bh(sb, new_bh, sync);
+		exfat_update_bh(new_bh, sync);
 		brelse(old_bh);
 		brelse(new_bh);
 
@@ -1104,7 +1104,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 			epold->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
 			ei->attr |= ATTR_ARCHIVE;
 		}
-		exfat_update_bh(sb, old_bh, sync);
+		exfat_update_bh(old_bh, sync);
 		brelse(old_bh);
 		ret = exfat_init_ext_entry(inode, p_dir, oldentry,
 			num_new_entries, p_uniname);
@@ -1159,7 +1159,7 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 		epnew->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
 		ei->attr |= ATTR_ARCHIVE;
 	}
-	exfat_update_bh(sb, new_bh, IS_DIRSYNC(inode));
+	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
 	brelse(mov_bh);
 	brelse(new_bh);
 
@@ -1175,7 +1175,7 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 	}
 
 	memcpy(epnew, epmov, DENTRY_SIZE);
-	exfat_update_bh(sb, new_bh, IS_DIRSYNC(inode));
+	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
 	brelse(mov_bh);
 	brelse(new_bh);
 
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index e650e65536f8..b2611050b671 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -45,9 +45,6 @@ static void exfat_put_super(struct super_block *sb)
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
 	mutex_lock(&sbi->s_lock);
-	if (test_and_clear_bit(EXFAT_SB_DIRTY, &sbi->s_state))
-		sync_blockdev(sb->s_bdev);
-	exfat_set_vol_flags(sb, VOL_CLEAN);
 	exfat_free_bitmap(sbi);
 	brelse(sbi->boot_bh);
 	mutex_unlock(&sbi->s_lock);
@@ -62,11 +59,9 @@ static int exfat_sync_fs(struct super_block *sb, int wait)
 
 	/* If there are some dirty buffers in the bdev inode */
 	mutex_lock(&sbi->s_lock);
-	if (test_and_clear_bit(EXFAT_SB_DIRTY, &sbi->s_state)) {
-		sync_blockdev(sb->s_bdev);
-		if (exfat_set_vol_flags(sb, VOL_CLEAN))
-			err = -EIO;
-	}
+	sync_blockdev(sb->s_bdev);
+	if (exfat_set_vol_flags(sb, VOL_CLEAN))
+		err = -EIO;
 	mutex_unlock(&sbi->s_lock);
 	return err;
 }
-- 
2.25.1

