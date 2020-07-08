Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC121847E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 11:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgGHJ6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 05:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgGHJ6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:58:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47771C08C5DC;
        Wed,  8 Jul 2020 02:58:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e18so21425072pgn.7;
        Wed, 08 Jul 2020 02:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfd3otyp56vRqiURxmDOZ6Fo0opPnI/s7gjtxv0KznQ=;
        b=gL2NcQtPyLmGdzNGGNQjTRVRuD8YTehJuNaOsRyQZtacdqttXhiIP5wBwJ7N11ezVs
         QtIYgsbhXHAliR9T7rDYN8pV+9J5phU56BO6bnC+6h9K6uqG85qvV2Qk6ozQGKVhLG23
         6unVCTkqfJsITJPcTxxhHiVre1zM49yuVGHKAiH0Zgw49DJBoEz9nw1QMB5kcBn8xiLj
         pYrV+IAbFiJWWN9Mc9rrcg35W0wp+Umuko1hQpFrUyV91ktzvkQlCJBxlXOAvZbSlPzF
         LjQXsBjSBvWehbljAS3zv/hzfALFJrCYh+90yl+ZghepmlaqODL+8TkuFYGQfRV3BHWG
         Rjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfd3otyp56vRqiURxmDOZ6Fo0opPnI/s7gjtxv0KznQ=;
        b=j0xY/z138i3DNkjCehHeSZSq5Q1hYm+wo2cGstrHKEZbwTDKpTgCjyydM4y1MObobs
         dfagJGiBYkc65xTeV/bezPG1ZZ+k7T0Z6Nads9+rL6YG7q5Lj8qTTKfnZUlUnJyfUrvS
         HvTzg+Qw4GYB1e2Db1Oxy8O8PHuZjiik7n1iE///GK9GAE/UxRoN5LBp5c/FgtORZa7g
         cJqFt/pzmCgDnt7on1Fql/sO+Rn0X9IK2GzjdSxrmn4Bcnk26fJ5c6rJyor6sD1dLvtX
         nAuDPOmn1n8wMqD20ZvCE3qoHukRsPJazpAiCzn2WdLqzegY8zvOU69PIaTtMduyK1R3
         T2xg==
X-Gm-Message-State: AOAM531MgEgKt70sOh5Tww3GEh+sBw94or9Rj1zX70O6rklLIkyuHUfC
        HG8qnBRIxTVN84hpgpiBKiE=
X-Google-Smtp-Source: ABdhPJxOYlfGjzaVLuvnhyaKrtfL7UXTvUZMzz+Dec8UeVdd/TGCzwBrNgUt8dKQgLU3tCdUNAy8VA==
X-Received: by 2002:a62:1b4a:: with SMTP id b71mr44869526pfb.9.1594202290717;
        Wed, 08 Jul 2020 02:58:10 -0700 (PDT)
Received: from dc803.localdomain (flh2-125-196-131-224.osk.mesh.ad.jp. [125.196.131.224])
        by smtp.gmail.com with ESMTPSA id q24sm3567971pgg.3.2020.07.08.02.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 02:58:10 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] exfat: retain 'VolumeFlags' properly
Date:   Wed,  8 Jul 2020 18:57:45 +0900
Message-Id: <20200708095746.4179-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Retain ActiveFat, MediaFailure and ClearToZero fields.
And, never clear VolumeDirty, if it is dirty at mount.

In '3.1.13.3 Media Failure Field' of exfat specification says ...
 If, upon mounting a volume, the value of this field is 1, implementations
 which scan the entire volume for media failures and record all failures as
 "bad" clusters in the FAT (or otherwise resolve media failures) may clear
 the value of this field to 0.
Therefore, should not clear MediaFailure without scanning volume.

In '8.1 Recommended Write Ordering' of exfat specification says ...
 Clear the value of the VolumeDirty field to 0, if its value prior to the
 first step was 0
Therefore, should not clear VolumeDirty when mounted.

Also, rename ERR_MEDIUM to MED_FAILURE.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/exfat_fs.h  |  5 +++--
 fs/exfat/exfat_raw.h |  2 +-
 fs/exfat/super.c     | 22 ++++++++++++++--------
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index cb51d6e83199..3f8dc4ca8109 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -224,7 +224,8 @@ struct exfat_sb_info {
 	unsigned int num_FAT_sectors; /* num of FAT sectors */
 	unsigned int root_dir; /* root dir cluster */
 	unsigned int dentries_per_clu; /* num of dentries per cluster */
-	unsigned int vol_flag; /* volume dirty flag */
+	unsigned int vol_flags; /* volume flags */
+	unsigned int vol_flags_noclear; /* volume flags to retain */
 	struct buffer_head *boot_bh; /* buffer_head of BOOT sector */
 
 	unsigned int map_clu; /* allocation bitmap start cluster */
@@ -380,7 +381,7 @@ static inline int exfat_sector_to_cluster(struct exfat_sb_info *sbi,
 }
 
 /* super.c */
-int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag);
+int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flags);
 
 /* fatent.c */
 #define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu)
diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index 350ce59cc324..d86a8a6b0601 100644
--- a/fs/exfat/exfat_raw.h
+++ b/fs/exfat/exfat_raw.h
@@ -16,7 +16,7 @@
 
 #define VOL_CLEAN		0x0000
 #define VOL_DIRTY		0x0002
-#define ERR_MEDIUM		0x0004
+#define MED_FAILURE		0x0004
 
 #define EXFAT_EOF_CLUSTER	0xFFFFFFFFu
 #define EXFAT_BAD_CLUSTER	0xFFFFFFF7u
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index b5bf6dedbe11..c26b0f5a0875 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -96,17 +96,22 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
+int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flags)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct boot_sector *p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
 	bool sync;
 
+	if (new_flags == VOL_CLEAN)
+		new_flags = (sbi->vol_flags & ~VOL_DIRTY) | sbi->vol_flags_noclear;
+	else
+		new_flags |= sbi->vol_flags;
+
 	/* flags are not changed */
-	if (sbi->vol_flag == new_flag)
+	if (sbi->vol_flags == new_flags)
 		return 0;
 
-	sbi->vol_flag = new_flag;
+	sbi->vol_flags = new_flags;
 
 	/* skip updating volume dirty flag,
 	 * if this volume has been mounted with read-only
@@ -114,9 +119,9 @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
 	if (sb_rdonly(sb))
 		return 0;
 
-	p_boot->vol_flags = cpu_to_le16(new_flag);
+	p_boot->vol_flags = cpu_to_le16(new_flags);
 
-	if (new_flag == VOL_DIRTY && !buffer_dirty(sbi->boot_bh))
+	if ((new_flags & VOL_DIRTY) && !buffer_dirty(sbi->boot_bh))
 		sync = true;
 	else
 		sync = false;
@@ -457,7 +462,8 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	sbi->dentries_per_clu = 1 <<
 		(sbi->cluster_size_bits - DENTRY_SIZE_BITS);
 
-	sbi->vol_flag = le16_to_cpu(p_boot->vol_flags);
+	sbi->vol_flags = le16_to_cpu(p_boot->vol_flags);
+	sbi->vol_flags_noclear = sbi->vol_flags & (VOL_DIRTY | MED_FAILURE);
 	sbi->clu_srch_ptr = EXFAT_FIRST_CLUSTER;
 	sbi->used_clusters = EXFAT_CLUSTERS_UNTRACKED;
 
@@ -472,9 +478,9 @@ static int exfat_read_boot_sector(struct super_block *sb)
 		exfat_err(sb, "bogus data start sector");
 		return -EINVAL;
 	}
-	if (sbi->vol_flag & VOL_DIRTY)
+	if (sbi->vol_flags & VOL_DIRTY)
 		exfat_warn(sb, "Volume was not properly unmounted. Some data may be corrupt. Please run fsck.");
-	if (sbi->vol_flag & ERR_MEDIUM)
+	if (sbi->vol_flags & MED_FAILURE)
 		exfat_warn(sb, "Medium has reported failures. Some data may be lost.");
 
 	/* exFAT file size is limited by a disk volume size */
-- 
2.25.1

