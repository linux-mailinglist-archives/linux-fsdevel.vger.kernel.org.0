Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B42E1EE000
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 10:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgFDIpb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 04:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgFDIpb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:45:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CBDC05BD1E;
        Thu,  4 Jun 2020 01:45:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s88so900481pjb.5;
        Thu, 04 Jun 2020 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=th3lrI0sLiSoK9l/XiRMXKL/UveXR8EGX2Fm9rxXtcA=;
        b=BoZPVpuSH6UxlYttHjg65eQAttQep6nSy+nolQNS3E5GE3cozzs8vMvAKKfB7m7jrk
         6XtKxx2mJ4OMEHyo81bG9A2AKWXfF2gGWxTTjPbQE631kpJQGuoD+9qb5KgYJqXw5mJL
         WH6ieEajm5azYKHYk3RWQ/Qr7P716C/0svgZuoCtukcES/3AXnO5B4Gvw5cnXV3uz5ej
         Yb8bvl0GsTma5uWF8sVViUIJoBNQhAkbpgP4IBFZie9CSEuOXh8nj9ZDVRDHcLWWv8K+
         kbIMI4uuurKMHXZsWi5uMgNaG/TWBgUuU9zbroy7qSbhWruVOpeALVzb/ZxuBx+1G/m5
         2KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=th3lrI0sLiSoK9l/XiRMXKL/UveXR8EGX2Fm9rxXtcA=;
        b=mduKEz3kvcnVw41uXwaf8e6gM1JTTB+bpdRIKvocDVehswSqgkwq0XNdPYGd53CNTd
         q74PgKiJvqfEYuds+iye+/K17qwfP1q+Y39ruWaFRgS5IEnJuvO2eVrq3UXfN/rVRhbP
         6P1DSetzFi9/VQD1x/jQslmvA3TOB4Vu9HLKua5ZbaJoTfVogo9yRzKakbflGNd6rRt2
         2zxqSrwvD5hCz5DdPB4GIco1SJWkb4rdLT+nPfvYLGSZeRIcNnVq9yzKx+dlrI5H7OV9
         cXcOltAwJU7351/Z5IbVG/UnNwBsN6SmCyNq9BC7kOhpnpKDFcU2dCvtD2aHBmOcj1S6
         Sgug==
X-Gm-Message-State: AOAM533ZPwOaqbAcU/vKl0Fik+8I+FwBfbFPjS5TVXnWAMKQzG3pgtgQ
        dNan8yap4m2L9SGKC9ppZZ8=
X-Google-Smtp-Source: ABdhPJzG/jDtXaLQssiN0HLHLtqbOtMn6gWPGCP8YC1Jt13l4lNL+lpAwSckM6Wd6Y/sZL5U9ofeQQ==
X-Received: by 2002:a17:902:ff03:: with SMTP id f3mr3810564plj.287.1591260330456;
        Thu, 04 Jun 2020 01:45:30 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:39b2:3392:bee8:f3be])
        by smtp.gmail.com with ESMTPSA id y6sm4770565pjw.15.2020.06.04.01.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:45:29 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] exfat: set EXFAT_SB_DIRTY and VOL_DIRTY at the same timing
Date:   Thu,  4 Jun 2020 17:44:44 +0900
Message-Id: <20200604084445.19205-3-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200604084445.19205-1-kohada.t2@gmail.com>
References: <20200604084445.19205-1-kohada.t2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Set EXFAT_SB_DIRTY flag in exfat_put_super().

In some cases, can't clear VOL_DIRTY with 'sync'.
ex:

VOL_DIRTY is set when rmdir starts, but when non-empty-dir is detected,
return error without setting EXFAT_SB_DIRTY.
If performe 'sync' in this state, VOL_DIRTY will not be cleared.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/balloc.c   |  4 ++--
 fs/exfat/dir.c      | 18 ++++++++----------
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/fatent.c   |  6 +-----
 fs/exfat/misc.c     |  3 +--
 fs/exfat/namei.c    | 12 ++++++------
 fs/exfat/super.c    |  3 +++
 7 files changed, 22 insertions(+), 26 deletions(-)

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
index 3eb8386fb5f2..96c9a817d928 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -468,7 +468,7 @@ int exfat_init_dir_entry(struct inode *inode, struct exfat_chain *p_dir,
 			&ep->dentry.file.access_date,
 			NULL);
 
-	exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
+	exfat_update_bh(bh, IS_DIRSYNC(inode));
 	brelse(bh);
 
 	ep = exfat_get_dentry(sb, p_dir, entry + 1, &bh, &sector);
@@ -478,7 +478,7 @@ int exfat_init_dir_entry(struct inode *inode, struct exfat_chain *p_dir,
 	exfat_init_stream_entry(ep,
 		(type == TYPE_FILE) ? ALLOC_FAT_CHAIN : ALLOC_NO_FAT_CHAIN,
 		start_clu, size);
-	exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
+	exfat_update_bh(bh, IS_DIRSYNC(inode));
 	brelse(bh);
 
 	return 0;
@@ -514,7 +514,7 @@ int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
 	}
 
 	fep->dentry.file.checksum = cpu_to_le16(chksum);
-	exfat_update_bh(sb, fbh, IS_DIRSYNC(inode));
+	exfat_update_bh(fbh, IS_DIRSYNC(inode));
 release_fbh:
 	brelse(fbh);
 	return ret;
@@ -536,7 +536,7 @@ int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
 		return -EIO;
 
 	ep->dentry.file.num_ext = (unsigned char)(num_entries - 1);
-	exfat_update_bh(sb, bh, sync);
+	exfat_update_bh(bh, sync);
 	brelse(bh);
 
 	ep = exfat_get_dentry(sb, p_dir, entry + 1, &bh, &sector);
@@ -545,7 +545,7 @@ int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
 
 	ep->dentry.stream.name_len = p_uniname->name_len;
 	ep->dentry.stream.name_hash = cpu_to_le16(p_uniname->name_hash);
-	exfat_update_bh(sb, bh, sync);
+	exfat_update_bh(bh, sync);
 	brelse(bh);
 
 	for (i = EXFAT_FIRST_CLUSTER; i < num_entries; i++) {
@@ -554,7 +554,7 @@ int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
 			return -EIO;
 
 		exfat_init_name_entry(ep, uniname);
-		exfat_update_bh(sb, bh, sync);
+		exfat_update_bh(bh, sync);
 		brelse(bh);
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
@@ -578,7 +578,7 @@ int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
 			return -EIO;
 
 		exfat_set_entry_type(ep, TYPE_DELETED);
-		exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
+		exfat_update_bh(bh, IS_DIRSYNC(inode));
 		brelse(bh);
 	}
 
@@ -606,10 +606,8 @@ int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
 {
 	int i, err = 0;
 
-	if (es->modified) {
-		set_bit(EXFAT_SB_DIRTY, &EXFAT_SB(es->sb)->s_state);
+	if (es->modified)
 		err = exfat_update_bhs(es->bh, es->num_bh, sync);
-	}
 
 	for (i = 0; i < es->num_bh; i++)
 		err ? bforget(es->bh[i]):brelse(es->bh[i]);
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f4fa0e833486..0e094d186612 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -514,7 +514,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs);
 u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
 u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);
-void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync);
+void exfat_update_bh(struct buffer_head *bh, int sync);
 int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync);
 void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
 		unsigned int size, unsigned char flags);
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 5d11bc2f1b68..f8171183b4c1 100644
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
@@ -261,7 +260,6 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
 			memset(bhs[n]->b_data, 0, sb->s_blocksize);
 		}
 
-		set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
 		err = exfat_update_bhs(bhs, n, IS_DIRSYNC(dir));
 		if (err)
 			goto release_bhs;
@@ -326,8 +324,6 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 		}
 	}
 
-	set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
-
 	p_chain->dir = EXFAT_EOF_CLUSTER;
 
 	while ((new_clu = exfat_find_free_bitmap(sb, hint_clu)) !=
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index dc34968e99d3..564718747fb2 100644
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
index 5b0f35329d63..e36c9fc4a5d6 100644
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
 
@@ -1083,7 +1083,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 			return -EIO;
 
 		memcpy(epnew, epold, DENTRY_SIZE);
-		exfat_update_bh(sb, new_bh, sync);
+		exfat_update_bh(new_bh, sync);
 		brelse(old_bh);
 		brelse(new_bh);
 
@@ -1100,7 +1100,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 			epold->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
 			ei->attr |= ATTR_ARCHIVE;
 		}
-		exfat_update_bh(sb, old_bh, sync);
+		exfat_update_bh(old_bh, sync);
 		brelse(old_bh);
 		ret = exfat_init_ext_entry(inode, p_dir, oldentry,
 			num_new_entries, p_uniname);
@@ -1155,7 +1155,7 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 		epnew->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
 		ei->attr |= ATTR_ARCHIVE;
 	}
-	exfat_update_bh(sb, new_bh, IS_DIRSYNC(inode));
+	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
 	brelse(mov_bh);
 	brelse(new_bh);
 
@@ -1167,7 +1167,7 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 		return -EIO;
 
 	memcpy(epnew, epmov, DENTRY_SIZE);
-	exfat_update_bh(sb, new_bh, IS_DIRSYNC(inode));
+	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
 	brelse(mov_bh);
 	brelse(new_bh);
 
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index e650e65536f8..199a1e78f9e5 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -104,6 +104,9 @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
 	struct boot_sector *p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
 	bool sync;
 
+	if (new_flag == VOL_DIRTY)
+		set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
+
 	/* flags are not changed */
 	if (sbi->vol_flag == new_flag)
 		return 0;
-- 
2.25.1

