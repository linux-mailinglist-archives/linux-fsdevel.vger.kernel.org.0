Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B35A1E0DC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 13:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390406AbgEYLvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 07:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390401AbgEYLvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 07:51:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79AC061A0E;
        Mon, 25 May 2020 04:51:19 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b190so8744811pfg.6;
        Mon, 25 May 2020 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JbNRen2/Tk695LLfZwS5txYYClAhgTrM7DAlNWvlVRw=;
        b=WfIjr0zAdwYGFfkOYct2uo06KaEt3yXAbzowOaYxPvJ3GOqyrv1KATzSSL/2G3eMfm
         QkO/BvqIdcMVKU+q5VAH/5py+wYM63pvo86CEI6UoPk3hyGKjv3EdEERJ6FjMCFOvd4k
         OocjIC2cuXE8WF9DV2Wobx0TqrGBdI85639ExBIr+hu6N646cNVWbk4gh6PoimTU2NZQ
         NeIpcsQY01hyFWs2XcuoGzp7s9RVsNIDMNGXFjVOgs/QtrZNv1SRFGMJNXIAJl0NLHe4
         rkHJpOGj0B07IpTmQ86OTH87dLg7/KkAt9KclRZOCj0AlUrKYdCSVfQ86ieYfvd7/ght
         EUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JbNRen2/Tk695LLfZwS5txYYClAhgTrM7DAlNWvlVRw=;
        b=YLuUG842/PSONBK9rNl0YNVJWqcshxlsMmI3EIz92ghMePj8QY8D8pDg+1pzOKyVR2
         rbGgfDefpSeaB3fSkLUwV8MKRHJUxqt3guSBBCRCvW5LboMcoxzQXE1y0pT6pxZc8Two
         8JCvvhDjMUP/Kv34qmRby0z4Wxo+fPNKLdyrXMtD8Q0f+dRtceWSr7lUQzyinsyjV92B
         Ou/mIBzwZOcYN5zvdyjQUN8//XR4kzLDWUnMmgJOAc8TUqxmUebKt4bIHViVeZFWvDeU
         m2fGqJ/rrRL/2bLms7L2+ExVLgXu8M0tcHZGh+ZZstKqPIVYa+aZ6jgsfhQT9iskoF+N
         UxPw==
X-Gm-Message-State: AOAM5314DANqmX7WzYTgxTosz/DPBj/OfKJ6qJAgX+NA6FJMTsIQpkmd
        WLX6ZLUJQAJhSqlFM2SvOz4=
X-Google-Smtp-Source: ABdhPJwD07+oD2blvOdw1Pq+mG8i2KN3GG3rejNmZKM09J2vAwJXsLipwMFq5mLzNiQerQQPvYhqiA==
X-Received: by 2002:a62:8c15:: with SMTP id m21mr16852203pfd.59.1590407478647;
        Mon, 25 May 2020 04:51:18 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:b9cb:9f91:3c10:565c])
        by smtp.gmail.com with ESMTPSA id h16sm13017537pfq.56.2020.05.25.04.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 04:51:18 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] exfat: standardize checksum calculation
Date:   Mon, 25 May 2020 20:50:51 +0900
Message-Id: <20200525115052.19243-4-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200525115052.19243-1-kohada.t2@gmail.com>
References: <20200525115052.19243-1-kohada.t2@gmail.com>
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
 fs/exfat/dir.c      | 12 ++++++------
 fs/exfat/exfat_fs.h |  5 ++---
 fs/exfat/misc.c     | 10 ++++------
 fs/exfat/nls.c      | 19 +++++++------------
 4 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index b5a237c33d50..b673362a895c 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -496,7 +496,7 @@ int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
 	int ret = 0;
 	int i, num_entries;
 	sector_t sector;
-	unsigned short chksum;
+	u16 chksum;
 	struct exfat_dentry *ep, *fep;
 	struct buffer_head *fbh, *bh;
 
@@ -505,7 +505,7 @@ int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
 		return -EIO;
 
 	num_entries = fep->dentry.file.num_ext + 1;
-	chksum = exfat_calc_chksum_2byte(fep, DENTRY_SIZE, 0, CS_DIR_ENTRY);
+	chksum = exfat_calc_chksum16(fep, DENTRY_SIZE, 0, CS_DIR_ENTRY);
 
 	for (i = 1; i < num_entries; i++) {
 		ep = exfat_get_dentry(sb, p_dir, entry + i, &bh, NULL);
@@ -513,7 +513,7 @@ int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
 			ret = -EIO;
 			goto release_fbh;
 		}
-		chksum = exfat_calc_chksum_2byte(ep, DENTRY_SIZE, chksum,
+		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
 				CS_DEFAULT);
 		brelse(bh);
 	}
@@ -600,10 +600,10 @@ int exfat_update_dir_chksum_with_entry_set(struct super_block *sb,
 	int chksum_type = CS_DIR_ENTRY, i, num_entries = es->num_entries;
 	unsigned int buf_off = (off - es->offset);
 	unsigned int remaining_byte_in_sector, copy_entries, clu;
-	unsigned short chksum = 0;
+	u16 chksum = 0;
 
 	for (i = 0; i < num_entries; i++) {
-		chksum = exfat_calc_chksum_2byte(&es->entries[i], DENTRY_SIZE,
+		chksum = exfat_calc_chksum16(&es->entries[i], DENTRY_SIZE,
 			chksum, chksum_type);
 		chksum_type = CS_DEFAULT;
 	}
@@ -1047,7 +1047,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			}
 
 			if (entry_type == TYPE_STREAM) {
-				unsigned short name_hash;
+				u16 name_hash;
 
 				if (step != DIRENT_STEP_STRM) {
 					step = DIRENT_STEP_FILE;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 15817281b3c8..993d13bbebec 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -139,7 +139,7 @@ struct exfat_dentry_namebuf {
 struct exfat_uni_name {
 	/* +3 for null and for converting */
 	unsigned short name[MAX_NAME_LENGTH + 3];
-	unsigned short name_hash;
+	u16 name_hash;
 	unsigned char name_len;
 };
 
@@ -515,8 +515,7 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
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

