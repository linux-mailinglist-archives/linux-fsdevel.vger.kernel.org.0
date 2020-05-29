Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11DB1E7A52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 12:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgE2KQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 06:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2KQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 06:16:34 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE5DC03E969;
        Fri, 29 May 2020 03:16:34 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y198so1130037pfb.4;
        Fri, 29 May 2020 03:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VPAQB36bLs7lZsVWcbE6FksreFmF1cJmGhsBNmLgCzs=;
        b=L4cSPmVtu5NA4+lMW+TaAr8ko/NDcfwApBntvkgpItdKZ2bJLTeoAYfAZeHBJDaD/v
         PHjudLL6uDTQcyn046n8heMp0lq3ehd8F7GTVXXsKYBeFvVJKFnZmP6MS4imXulZr7Nb
         BnRNdgOLSCA7UVTsHu9bSz097sTT3k+5GHVggjP/yAKwEdOOvNieTtwN6Mlaw2YfER9j
         GBhcTpdrVSgKfSdfHJyubw8kI/XNmzxFXEHLhmvgMVj+syEEStjaYvv8X0ScmeFqb3D3
         PUS69Y8N4dADMahB2CTKK3Lcdut5dM1SULPoQoH75lMaWqCGwTidy8HufBXv2V8ApTau
         sp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VPAQB36bLs7lZsVWcbE6FksreFmF1cJmGhsBNmLgCzs=;
        b=ZZ0H9o/4Xtz9D2B1c55cu8oVLB+xQqAW1edjM0JGqDFNRYfR2v3+yiOiy7eJdFB0Ij
         gzThRH85pMAgRQMiBCiBOgx3qbaEtkHtxz6JlIisIL18vZl5FNXsGG7+pJqKOJ15lyEc
         +ewNokQocx5wDHcfk16By7v5/6b6ZSqWk2cPs2dssiMykakPI5IO72yTT57kNtoAHLTD
         ny/c9S6w8TRdJI1e08uLdcnPWGOLlj30pPXUDI3tWeCMK5Ct/HmLO49X3rFqc7dd4v3f
         ReSpGSMvV7OImpMiuknNT2lBYUwjRLakFZq8duHcw6pqYGv5RPRIBAozzfeW48FUt1KF
         i7pg==
X-Gm-Message-State: AOAM530TEixMpyViMQYU4mmQBj/v9OEM5P+1JavW363tMdQ5vORaqtLb
        OxQgEAHDjxhl6wxF3ykBy/w=
X-Google-Smtp-Source: ABdhPJzkuThPL1+2GxOcPMLOUeO3xDoIfz7+zQGpSzICRJ6Y4s0UmS9+7njQuMuyUusnsqT2zOnNZA==
X-Received: by 2002:a63:5307:: with SMTP id h7mr7624723pgb.28.1590747394003;
        Fri, 29 May 2020 03:16:34 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:3c0d:7bea:2bcd:e53b])
        by smtp.gmail.com with ESMTPSA id u4sm10839260pjf.3.2020.05.29.03.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 03:16:33 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4 v3] exfat: standardize checksum calculation
Date:   Fri, 29 May 2020 19:14:59 +0900
Message-Id: <20200529101459.8546-4-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200529101459.8546-1-kohada.t2@gmail.com>
References: <20200529101459.8546-1-kohada.t2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To clarify that it is a 16-bit checksum, the parts related to the 16-bit
checksum are renamed and change type to u16.
Furthermore, replace checksum calculation in exfat_load_upcase_table()
with exfat_calc_checksum32().

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2:
 - rebase with patch 'optimize dir-cache' applied
Changes in v3:
 - based on '[PATCH 2/4 v3] exfat: separate the boot sector analysis'

 fs/exfat/dir.c      | 12 ++++++------
 fs/exfat/exfat_fs.h |  5 ++---
 fs/exfat/misc.c     | 10 ++++------
 fs/exfat/nls.c      | 19 +++++++------------
 4 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 2902d285bf20..de43534aa299 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -491,7 +491,7 @@ int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
 	int ret = 0;
 	int i, num_entries;
 	sector_t sector;
-	unsigned short chksum;
+	u16 chksum;
 	struct exfat_dentry *ep, *fep;
 	struct buffer_head *fbh, *bh;
 
@@ -500,7 +500,7 @@ int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
 		return -EIO;
 
 	num_entries = fep->dentry.file.num_ext + 1;
-	chksum = exfat_calc_chksum_2byte(fep, DENTRY_SIZE, 0, CS_DIR_ENTRY);
+	chksum = exfat_calc_chksum16(fep, DENTRY_SIZE, 0, CS_DIR_ENTRY);
 
 	for (i = 1; i < num_entries; i++) {
 		ep = exfat_get_dentry(sb, p_dir, entry + i, &bh, NULL);
@@ -508,7 +508,7 @@ int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
 			ret = -EIO;
 			goto release_fbh;
 		}
-		chksum = exfat_calc_chksum_2byte(ep, DENTRY_SIZE, chksum,
+		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
 				CS_DEFAULT);
 		brelse(bh);
 	}
@@ -593,8 +593,8 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
 
 	for (i = 0; i < es->num_entries; i++) {
 		ep = exfat_get_dentry_cached(es, i);
-		chksum = exfat_calc_chksum_2byte(ep, DENTRY_SIZE, chksum,
-						 chksum_type);
+		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
+					     chksum_type);
 		chksum_type = CS_DEFAULT;
 	}
 	ep = exfat_get_dentry_cached(es, 0);
@@ -1000,7 +1000,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			}
 
 			if (entry_type == TYPE_STREAM) {
-				unsigned short name_hash;
+				u16 name_hash;
 
 				if (step != DIRENT_STEP_STRM) {
 					step = DIRENT_STEP_FILE;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index eebbe5a84b2b..9188985694f0 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -137,7 +137,7 @@ struct exfat_dentry_namebuf {
 struct exfat_uni_name {
 	/* +3 for null and for converting */
 	unsigned short name[MAX_NAME_LENGTH + 3];
-	unsigned short name_hash;
+	u16 name_hash;
 	unsigned char name_len;
 };
 
@@ -512,8 +512,7 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 void exfat_truncate_atime(struct timespec64 *ts);
 void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs);
-unsigned short exfat_calc_chksum_2byte(void *data, int len,
-		unsigned short chksum, int type);
+u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
 u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);
 void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync);
 void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index b82d2dd5bd7c..17d41f3d3709 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -136,17 +136,15 @@ void exfat_truncate_atime(struct timespec64 *ts)
 	ts->tv_nsec = 0;
 }
 
-unsigned short exfat_calc_chksum_2byte(void *data, int len,
-		unsigned short chksum, int type)
+u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type)
 {
 	int i;
-	unsigned char *c = (unsigned char *)data;
+	u8 *c = (u8 *)data;
 
 	for (i = 0; i < len; i++, c++) {
-		if (((i == 2) || (i == 3)) && (type == CS_DIR_ENTRY))
+		if (unlikely(type == CS_DIR_ENTRY && (i == 2 || i == 3)))
 			continue;
-		chksum = (((chksum & 1) << 15) | ((chksum & 0xFFFE) >> 1)) +
-			(unsigned short)*c;
+		chksum = ((chksum << 15) | (chksum >> 1)) + *c;
 	}
 	return chksum;
 }
diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 1ebda90cbdd7..19321773dd07 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -527,7 +527,7 @@ static int exfat_utf8_to_utf16(struct super_block *sb,
 
 	*uniname = '\0';
 	p_uniname->name_len = unilen;
-	p_uniname->name_hash = exfat_calc_chksum_2byte(upname, unilen << 1, 0,
+	p_uniname->name_hash = exfat_calc_chksum16(upname, unilen << 1, 0,
 			CS_DEFAULT);
 
 	if (p_lossy)
@@ -623,7 +623,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 
 	*uniname = '\0';
 	p_uniname->name_len = unilen;
-	p_uniname->name_hash = exfat_calc_chksum_2byte(upname, unilen << 1, 0,
+	p_uniname->name_hash = exfat_calc_chksum16(upname, unilen << 1, 0,
 			CS_DEFAULT);
 
 	if (p_lossy)
@@ -655,7 +655,8 @@ static int exfat_load_upcase_table(struct super_block *sb,
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	unsigned int sect_size = sb->s_blocksize;
-	unsigned int i, index = 0, checksum = 0;
+	unsigned int i, index = 0;
+	u32 chksum = 0;
 	int ret;
 	unsigned char skip = false;
 	unsigned short *upcase_table;
@@ -681,13 +682,6 @@ static int exfat_load_upcase_table(struct super_block *sb,
 		for (i = 0; i < sect_size && index <= 0xFFFF; i += 2) {
 			unsigned short uni = get_unaligned_le16(bh->b_data + i);
 
-			checksum = ((checksum & 1) ? 0x80000000 : 0) +
-				(checksum >> 1) +
-				*(((unsigned char *)bh->b_data) + i);
-			checksum = ((checksum & 1) ? 0x80000000 : 0) +
-				(checksum >> 1) +
-				*(((unsigned char *)bh->b_data) + (i + 1));
-
 			if (skip) {
 				index += uni;
 				skip = false;
@@ -701,13 +695,14 @@ static int exfat_load_upcase_table(struct super_block *sb,
 			}
 		}
 		brelse(bh);
+		chksum = exfat_calc_chksum32(bh->b_data, i, chksum, CS_DEFAULT);
 	}
 
-	if (index >= 0xFFFF && utbl_checksum == checksum)
+	if (index >= 0xFFFF && utbl_checksum == chksum)
 		return 0;
 
 	exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)",
-		  index, checksum, utbl_checksum);
+		  index, chksum, utbl_checksum);
 	ret = -EINVAL;
 free_table:
 	exfat_free_upcase_table(sbi);
-- 
2.25.1

