Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79A61FA507
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 02:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgFPAY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 20:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgFPAY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 20:24:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE313C061A0E;
        Mon, 15 Jun 2020 17:24:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d8so7568417plo.12;
        Mon, 15 Jun 2020 17:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SQQn2jlA4WN6yItqYwtJlJhnirXU5nk3dC97lktwFFs=;
        b=E7vSd3CZltYffnJ7e8tAxU0uw5ZDpC3HRtz0oW/qdGBd10OaymT+3z69oQd+S3+sbV
         MKvgk1WlOI3vxOv6bL51lraUpt1u+opItPIa76J6jW90yuVgJpMbW0Yqpl+Q8QFA1Aeg
         Q8DJIKMtr/iNv2tqHxSPVRAPMyIKr2utOHA0L8MsiFaeKAlfRavDCQwae3GiBoEAEpTv
         659uwvCy+f1w0tro+fYuoWMOmvtMLmR4Q8xg/LPOrZPv9ZB5t8T/btLKLEf8UD2EmNOw
         lDJipkjqJrQCrVIkk/q51g9zoCHztEbHJMlaIO8gEIuGeKPiwhXxFNcAM5/Su/rIwCVw
         XsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SQQn2jlA4WN6yItqYwtJlJhnirXU5nk3dC97lktwFFs=;
        b=OUd5Kdxhl0E3wh6B1w2xy6lh6RUHjZHv86z0h6KWWNvPpkX8jKdt72Ul/k5m8ixDK6
         7PclPevEFgdyINtBdkclqxT8Dn0vOF49+ECcXPuVvUmspn608Ah3ESMTyAxIhckQgVHX
         q7ji5abkLvY58YUpjro6/Jdru1D9goicYCEnPh0GutcmfVchLdji+AiPhw5FCiYRX/gD
         ZHhjPB8DzTdCFLHNYh1kzGvx4PMYMmcBW5o9JvSJeZd1O9JlkEDVFqsIiOFq4Cnc5M2i
         nzYhPKTOkDH/0sejeoiKwkC4/mQdX9qqieec/yEdGP6k58NUXXr3I/54cWhg6/wOZkdF
         qwMw==
X-Gm-Message-State: AOAM5337b2jbyRh16MoRT57vgO7UL1jAv4W0idVlfWQOCLBRnC/GFHxZ
        QqArB+AsUxFdSGaxuaniYGQ=
X-Google-Smtp-Source: ABdhPJw+7z3R7gPDdo94HqqLnkvUzcTSeGhVAeQYtwKJjQiB+OFVDEa+d1QJF1Jaz7sKQ/DGs/OYfw==
X-Received: by 2002:a17:90a:c905:: with SMTP id v5mr219611pjt.39.1592267096165;
        Mon, 15 Jun 2020 17:24:56 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:b8ad:8a8d:fa4d:221e])
        by smtp.gmail.com with ESMTPSA id n4sm536619pjt.48.2020.06.15.17.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 17:24:55 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] exfat: remove EXFAT_SB_DIRTY flag
Date:   Tue, 16 Jun 2020 09:24:49 +0900
Message-Id: <20200616002450.2522-1-kohada.t2@gmail.com>
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

Suggested-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2:
 - exfat_sync_fs() avoids synchronous processing when wait=0

 fs/exfat/balloc.c   |  4 ++--
 fs/exfat/dir.c      | 16 ++++++++--------
 fs/exfat/exfat_fs.h |  5 +----
 fs/exfat/fatent.c   |  7 ++-----
 fs/exfat/misc.c     |  3 +--
 fs/exfat/namei.c    | 12 ++++++------
 fs/exfat/super.c    | 14 ++++++--------
 7 files changed, 26 insertions(+), 35 deletions(-)

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
index e650e65536f8..49804d369b51 100644
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
@@ -60,13 +57,14 @@ static int exfat_sync_fs(struct super_block *sb, int wait)
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	int err = 0;
 
+	if (!wait)
+		return;
+
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

