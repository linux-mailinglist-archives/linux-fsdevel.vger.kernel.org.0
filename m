Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC1FF9BA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 22:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfKLVNf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 16:13:35 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:44420 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727443AbfKLVNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:35 -0500
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xACLDVQe012700
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:31 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xACLDQhX025936
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:31 -0500
Received: by mail-qk1-f199.google.com with SMTP id p68so45024qkf.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ByMcF+jIW65N0t44Z+5sKGDrsib/q8emNcBuAWUj2XM=;
        b=ibxkA6VsLssEKo7/HKWnprUwp8tHFIwF47+S0M3Y7XN0UbwSXllx8O5Ga5q5zK8/++
         ZUhVOd8vSQ/M0j50t+8NSCRw9ZKd4vvpSBgBm1QIQjRiZfrGMbdAw/dNVTFlXk7fDg/n
         fdCFgWI/1LdoqnQxePLUmG8icAghkrS9TjwD5Whh05knNUQwb12X9ddAvLhaObrzkXO6
         wXkcvB+OR3igqyxafAVUKrsYe21EhghDWz5zdmU5fkvAxd87uqMNkPgQGpbGIZjmD2SL
         zTPzqXKgPrAixoJVXNQ6uX97VxGIAHm9nEcbkVJNvJGzpCrylK9oUvfJDeMzjmRFXwy7
         EE/Q==
X-Gm-Message-State: APjAAAXdaGwelpl8gcrgdcaTgDnCdLDk9MZXGrRFpHoCFXpVN1UQn/YS
        NUEgRNFKbXv+KFAkH7Cb5ec5Q0mz9ocvSHVdcrcZkAlA/KTInt2uvyHnsxCBalv+8MynVVO3LZB
        UptNONGL+58R0ONp7uEn1zLUF3GGKfM5d+F3R
X-Received: by 2002:aed:30c3:: with SMTP id 61mr33681078qtf.243.1573593206112;
        Tue, 12 Nov 2019 13:13:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2xUZFQdTzCarwdRguQuie5Wck7pdR4O0YRMTEbf7Q5L1rI6IgZdtEeJwRkbIf74aZHcIUFw==
X-Received: by 2002:aed:30c3:: with SMTP id 61mr33680988qtf.243.1573593205184;
        Tue, 12 Nov 2019 13:13:25 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 130sm9674214qkd.33.2019.11.12.13.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:13:23 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] staging: exfat: Remove FAT/VFAT mount support, part 3
Date:   Tue, 12 Nov 2019 16:12:29 -0500
Message-Id: <20191112211238.156490-4-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
References: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In this patch, we straighten out most of the cases where the
code was testing 'p_fs->vol_type == EXFAT' and '!= EXFAT'

There's still some ?: ops and a few places where the code
is doing checks for '.' and '..' that require looking at,
but those are future patches

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat_cache.c | 207 ++-----------------
 drivers/staging/exfat/exfat_core.c  | 205 ++++++-------------
 drivers/staging/exfat/exfat_super.c | 297 +++++++---------------------
 3 files changed, 148 insertions(+), 561 deletions(-)

diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
index 28a67f8139ea..1d344c5f3e15 100644
--- a/drivers/staging/exfat/exfat_cache.c
+++ b/drivers/staging/exfat/exfat_cache.c
@@ -202,107 +202,22 @@ static int __FAT_read(struct super_block *sb, u32 loc, u32 *content)
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
-	if (p_fs->vol_type == FAT12) {
-		sec = p_fs->FAT1_start_sector +
-			((loc + (loc >> 1)) >> p_bd->sector_size_bits);
-		off = (loc + (loc >> 1)) & p_bd->sector_size_mask;
-
-		if (off == (p_bd->sector_size - 1)) {
-			fat_sector = FAT_getblk(sb, sec);
-			if (!fat_sector)
-				return -1;
-
-			_content = (u32)fat_sector[off];
-
-			fat_sector = FAT_getblk(sb, ++sec);
-			if (!fat_sector)
-				return -1;
-
-			_content |= (u32)fat_sector[0] << 8;
-		} else {
-			fat_sector = FAT_getblk(sb, sec);
-			if (!fat_sector)
-				return -1;
-
-			fat_entry = &fat_sector[off];
-			_content = GET16(fat_entry);
-		}
-
-		if (loc & 1)
-			_content >>= 4;
-
-		_content &= 0x00000FFF;
-
-		if (_content >= CLUSTER_16(0x0FF8)) {
-			*content = CLUSTER_32(~0);
-			return 0;
-		}
-		*content = CLUSTER_32(_content);
-		return 0;
-	} else if (p_fs->vol_type == FAT16) {
-		sec = p_fs->FAT1_start_sector +
-			(loc >> (p_bd->sector_size_bits - 1));
-		off = (loc << 1) & p_bd->sector_size_mask;
-
-		fat_sector = FAT_getblk(sb, sec);
-		if (!fat_sector)
-			return -1;
-
-		fat_entry = &fat_sector[off];
-
-		_content = GET16_A(fat_entry);
-
-		_content &= 0x0000FFFF;
-
-		if (_content >= CLUSTER_16(0xFFF8)) {
-			*content = CLUSTER_32(~0);
-			return 0;
-		}
-		*content = CLUSTER_32(_content);
-		return 0;
-	} else if (p_fs->vol_type == FAT32) {
-		sec = p_fs->FAT1_start_sector +
-			(loc >> (p_bd->sector_size_bits - 2));
-		off = (loc << 2) & p_bd->sector_size_mask;
-
-		fat_sector = FAT_getblk(sb, sec);
-		if (!fat_sector)
-			return -1;
+	sec = p_fs->FAT1_start_sector +
+		(loc >> (p_bd->sector_size_bits - 2));
+	off = (loc << 2) & p_bd->sector_size_mask;
 
-		fat_entry = &fat_sector[off];
+	fat_sector = FAT_getblk(sb, sec);
+	if (!fat_sector)
+		return -1;
 
-		_content = GET32_A(fat_entry);
+	fat_entry = &fat_sector[off];
+	_content = GET32_A(fat_entry);
 
-		_content &= 0x0FFFFFFF;
-
-		if (_content >= CLUSTER_32(0x0FFFFFF8)) {
-			*content = CLUSTER_32(~0);
-			return 0;
-		}
-		*content = CLUSTER_32(_content);
-		return 0;
-	} else if (p_fs->vol_type == EXFAT) {
-		sec = p_fs->FAT1_start_sector +
-			(loc >> (p_bd->sector_size_bits - 2));
-		off = (loc << 2) & p_bd->sector_size_mask;
-
-		fat_sector = FAT_getblk(sb, sec);
-		if (!fat_sector)
-			return -1;
-
-		fat_entry = &fat_sector[off];
-		_content = GET32_A(fat_entry);
-
-		if (_content >= CLUSTER_32(0xFFFFFFF8)) {
-			*content = CLUSTER_32(~0);
-			return 0;
-		}
-		*content = CLUSTER_32(_content);
+	if (_content >= CLUSTER_32(0xFFFFFFF8)) {
+		*content = CLUSTER_32(~0);
 		return 0;
 	}
-
-	/* Unknown volume type, throw in the towel and go home */
-	*content = CLUSTER_32(~0);
+	*content = CLUSTER_32(_content);
 	return 0;
 }
 
@@ -330,101 +245,17 @@ static s32 __FAT_write(struct super_block *sb, u32 loc, u32 content)
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
-	if (p_fs->vol_type == FAT12) {
-		content &= 0x00000FFF;
+	sec = p_fs->FAT1_start_sector + (loc >>
+					 (p_bd->sector_size_bits - 2));
+	off = (loc << 2) & p_bd->sector_size_mask;
 
-		sec = p_fs->FAT1_start_sector +
-			((loc + (loc >> 1)) >> p_bd->sector_size_bits);
-		off = (loc + (loc >> 1)) & p_bd->sector_size_mask;
+	fat_sector = FAT_getblk(sb, sec);
+	if (!fat_sector)
+		return -1;
 
-		fat_sector = FAT_getblk(sb, sec);
-		if (!fat_sector)
-			return -1;
+	fat_entry = &fat_sector[off];
 
-		if (loc & 1) { /* odd */
-			content <<= 4;
-
-			if (off == (p_bd->sector_size - 1)) {
-				fat_sector[off] = (u8)(content |
-						       (fat_sector[off] &
-							0x0F));
-				FAT_modify(sb, sec);
-
-				fat_sector = FAT_getblk(sb, ++sec);
-				if (!fat_sector)
-					return -1;
-
-				fat_sector[0] = (u8)(content >> 8);
-			} else {
-				fat_entry = &fat_sector[off];
-				content |= GET16(fat_entry) & 0x000F;
-
-				SET16(fat_entry, content);
-			}
-		} else { /* even */
-			fat_sector[off] = (u8)(content);
-
-			if (off == (p_bd->sector_size - 1)) {
-				fat_sector[off] = (u8)(content);
-				FAT_modify(sb, sec);
-
-				fat_sector = FAT_getblk(sb, ++sec);
-				if (!fat_sector)
-					return -1;
-				fat_sector[0] = (u8)((fat_sector[0] & 0xF0) |
-						     (content >> 8));
-			} else {
-				fat_entry = &fat_sector[off];
-				content |= GET16(fat_entry) & 0xF000;
-
-				SET16(fat_entry, content);
-			}
-		}
-	}
-
-	else if (p_fs->vol_type == FAT16) {
-		content &= 0x0000FFFF;
-
-		sec = p_fs->FAT1_start_sector + (loc >>
-						 (p_bd->sector_size_bits - 1));
-		off = (loc << 1) & p_bd->sector_size_mask;
-
-		fat_sector = FAT_getblk(sb, sec);
-		if (!fat_sector)
-			return -1;
-
-		fat_entry = &fat_sector[off];
-
-		SET16_A(fat_entry, content);
-	} else if (p_fs->vol_type == FAT32) {
-		content &= 0x0FFFFFFF;
-
-		sec = p_fs->FAT1_start_sector + (loc >>
-						 (p_bd->sector_size_bits - 2));
-		off = (loc << 2) & p_bd->sector_size_mask;
-
-		fat_sector = FAT_getblk(sb, sec);
-		if (!fat_sector)
-			return -1;
-
-		fat_entry = &fat_sector[off];
-
-		content |= GET32_A(fat_entry) & 0xF0000000;
-
-		SET32_A(fat_entry, content);
-	} else { /* p_fs->vol_type == EXFAT */
-		sec = p_fs->FAT1_start_sector + (loc >>
-						 (p_bd->sector_size_bits - 2));
-		off = (loc << 2) & p_bd->sector_size_mask;
-
-		fat_sector = FAT_getblk(sb, sec);
-		if (!fat_sector)
-			return -1;
-
-		fat_entry = &fat_sector[off];
-
-		SET32_A(fat_entry, content);
-	}
+	SET32_A(fat_entry, content);
 
 	FAT_modify(sb, sec);
 	return 0;
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index ed9e4521ec04..77b826dfdeda 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -20,15 +20,6 @@ static void __set_sb_dirty(struct super_block *sb)
 
 static u8 name_buf[MAX_PATH_LENGTH * MAX_CHARSET_SIZE];
 
-static char *reserved_names[] = {
-	"AUX     ", "CON     ", "NUL     ", "PRN     ",
-	"COM1    ", "COM2    ", "COM3    ", "COM4    ",
-	"COM5    ", "COM6    ", "COM7    ", "COM8    ", "COM9    ",
-	"LPT1    ", "LPT2    ", "LPT3    ", "LPT4    ",
-	"LPT5    ", "LPT6    ", "LPT7    ", "LPT8    ", "LPT9    ",
-	NULL
-};
-
 static u8 free_bit[] = {
 	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, /*   0 ~  19 */
 	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3, /*  20 ~  39 */
@@ -99,25 +90,23 @@ void fs_set_vol_flags(struct super_block *sb, u32 new_flag)
 
 	p_fs->vol_flag = new_flag;
 
-	if (p_fs->vol_type == EXFAT) {
-		if (!p_fs->pbr_bh) {
-			if (sector_read(sb, p_fs->PBR_sector,
-					&p_fs->pbr_bh, 1) != 0)
-				return;
-		}
+	if (!p_fs->pbr_bh) {
+		if (sector_read(sb, p_fs->PBR_sector,
+				&p_fs->pbr_bh, 1) != 0)
+			return;
+	}
 
-		p_pbr = (struct pbr_sector_t *)p_fs->pbr_bh->b_data;
-		p_bpb = (struct bpbex_t *)p_pbr->bpb;
-		SET16(p_bpb->vol_flags, (u16)new_flag);
+	p_pbr = (struct pbr_sector_t *)p_fs->pbr_bh->b_data;
+	p_bpb = (struct bpbex_t *)p_pbr->bpb;
+	SET16(p_bpb->vol_flags, (u16)new_flag);
 
-		/* XXX duyoung
-		 * what can we do here? (cuz fs_set_vol_flags() is void)
-		 */
-		if ((new_flag == VOL_DIRTY) && (!buffer_dirty(p_fs->pbr_bh)))
-			sector_write(sb, p_fs->PBR_sector, p_fs->pbr_bh, 1);
-		else
-			sector_write(sb, p_fs->PBR_sector, p_fs->pbr_bh, 0);
-	}
+	/* XXX duyoung
+	 * what can we do here? (cuz fs_set_vol_flags() is void)
+	 */
+	if ((new_flag == VOL_DIRTY) && (!buffer_dirty(p_fs->pbr_bh)))
+		sector_write(sb, p_fs->PBR_sector, p_fs->pbr_bh, 1);
+	else
+		sector_write(sb, p_fs->PBR_sector, p_fs->pbr_bh, 0);
 }
 
 void fs_error(struct super_block *sb)
@@ -1613,10 +1602,8 @@ s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries
 		if (p_fs->dev_ejected)
 			break;
 
-		if (p_fs->vol_type == EXFAT) {
-			if (p_dir->dir != p_fs->root_dir)
-				size = i_size_read(inode);
-		}
+		if (p_dir->dir != p_fs->root_dir)
+			size = i_size_read(inode);
 
 		last_clu = find_last_cluster(sb, p_dir);
 		clu.dir = last_clu + 1;
@@ -1653,21 +1640,19 @@ s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries
 		p_dir->size++;
 
 		/* (3) update the directory entry */
-		if (p_fs->vol_type == EXFAT) {
-			if (p_dir->dir != p_fs->root_dir) {
-				size += p_fs->cluster_size;
-
-				ep = get_entry_in_dir(sb, &fid->dir,
-						      fid->entry + 1, &sector);
-				if (!ep)
-					return -ENOENT;
-				p_fs->fs_func->set_entry_size(ep, size);
-				p_fs->fs_func->set_entry_flag(ep, p_dir->flags);
-				buf_modify(sb, sector);
-
-				update_dir_checksum(sb, &fid->dir,
-						    fid->entry);
-			}
+		if (p_dir->dir != p_fs->root_dir) {
+			size += p_fs->cluster_size;
+
+			ep = get_entry_in_dir(sb, &fid->dir,
+					      fid->entry + 1, &sector);
+			if (!ep)
+				return -ENOENT;
+			p_fs->fs_func->set_entry_size(ep, size);
+			p_fs->fs_func->set_entry_flag(ep, p_dir->flags);
+			buf_modify(sb, sector);
+
+			update_dir_checksum(sb, &fid->dir,
+					    fid->entry);
 		}
 
 		i_size_write(inode, i_size_read(inode) + p_fs->cluster_size);
@@ -1979,36 +1964,13 @@ s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 				 struct uni_name_t *p_uniname, s32 *entries,
 				 struct dos_name_t *p_dosname)
 {
-	s32 ret, num_entries;
-	bool lossy = false;
-	char **r;
+	s32 num_entries;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
 	num_entries = p_fs->fs_func->calc_num_entries(p_uniname);
 	if (num_entries == 0)
 		return -EINVAL;
 
-	if (p_fs->vol_type != EXFAT) {
-		nls_uniname_to_dosname(sb, p_dosname, p_uniname, &lossy);
-
-		if (lossy) {
-			ret = fat_generate_dos_name(sb, p_dir, p_dosname);
-			if (ret)
-				return ret;
-		} else {
-			for (r = reserved_names; *r; r++) {
-				if (!strncmp((void *)p_dosname->name, *r, 8))
-					return -EINVAL;
-			}
-
-			if (p_dosname->name_case != 0xFF)
-				num_entries = 1;
-		}
-
-		if (num_entries > 1)
-			p_dosname->name_case = 0x0;
-	}
-
 	*entries = num_entries;
 
 	return 0;
@@ -2392,7 +2354,7 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	s32 ret, dentry, num_entries;
 	u64 size;
 	struct chain_t clu;
-	struct dos_name_t dos_name, dot_name;
+	struct dos_name_t dos_name;
 	struct super_block *sb = inode->i_sb;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct fs_func *fs_func = p_fs->fs_func;
@@ -2422,45 +2384,7 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	if (ret != 0)
 		return ret;
 
-	if (p_fs->vol_type == EXFAT) {
-		size = p_fs->cluster_size;
-	} else {
-		size = 0;
-
-		/* initialize the . and .. entry
-		 * Information for . points to itself
-		 * Information for .. points to parent dir
-		 */
-
-		dot_name.name_case = 0x0;
-		memcpy(dot_name.name, DOS_CUR_DIR_NAME, DOS_NAME_LENGTH);
-
-		ret = fs_func->init_dir_entry(sb, &clu, 0, TYPE_DIR, clu.dir,
-					      0);
-		if (ret != 0)
-			return ret;
-
-		ret = fs_func->init_ext_entry(sb, &clu, 0, 1, NULL, &dot_name);
-		if (ret != 0)
-			return ret;
-
-		memcpy(dot_name.name, DOS_PAR_DIR_NAME, DOS_NAME_LENGTH);
-
-		if (p_dir->dir == p_fs->root_dir)
-			ret = fs_func->init_dir_entry(sb, &clu, 1, TYPE_DIR,
-						      CLUSTER_32(0), 0);
-		else
-			ret = fs_func->init_dir_entry(sb, &clu, 1, TYPE_DIR,
-						      p_dir->dir, 0);
-
-		if (ret != 0)
-			return ret;
-
-		ret = p_fs->fs_func->init_ext_entry(sb, &clu, 1, 1, NULL,
-						    &dot_name);
-		if (ret != 0)
-			return ret;
-	}
+	size = p_fs->cluster_size;
 
 	/* (2) update the directory entry */
 	/* make sub-dir entry in parent directory */
@@ -2626,23 +2550,21 @@ s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 		buf_modify(sb, sector_new);
 		buf_unlock(sb, sector_old);
 
-		if (p_fs->vol_type == EXFAT) {
-			epold = get_entry_in_dir(sb, p_dir, oldentry + 1,
-						 &sector_old);
-			buf_lock(sb, sector_old);
-			epnew = get_entry_in_dir(sb, p_dir, newentry + 1,
-						 &sector_new);
-
-			if (!epold || !epnew) {
-				buf_unlock(sb, sector_old);
-				return -ENOENT;
-			}
+		epold = get_entry_in_dir(sb, p_dir, oldentry + 1,
+					 &sector_old);
+		buf_lock(sb, sector_old);
+		epnew = get_entry_in_dir(sb, p_dir, newentry + 1,
+					 &sector_new);
 
-			memcpy((void *)epnew, (void *)epold, DENTRY_SIZE);
-			buf_modify(sb, sector_new);
+		if (!epold || !epnew) {
 			buf_unlock(sb, sector_old);
+			return -ENOENT;
 		}
 
+		memcpy((void *)epnew, (void *)epold, DENTRY_SIZE);
+		buf_modify(sb, sector_new);
+		buf_unlock(sb, sector_old);
+
 		ret = fs_func->init_ext_entry(sb, p_dir, newentry,
 					      num_new_entries, p_uniname,
 					      &dos_name);
@@ -2681,7 +2603,6 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 {
 	s32 ret, newentry, num_new_entries, num_old_entries;
 	sector_t sector_mov, sector_new;
-	struct chain_t clu;
 	struct dos_name_t dos_name;
 	struct dentry_t *epmov, *epnew;
 	struct super_block *sb = inode->i_sb;
@@ -2736,36 +2657,20 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 	buf_modify(sb, sector_new);
 	buf_unlock(sb, sector_mov);
 
-	if (p_fs->vol_type == EXFAT) {
-		epmov = get_entry_in_dir(sb, p_olddir, oldentry + 1,
-					 &sector_mov);
-		buf_lock(sb, sector_mov);
-		epnew = get_entry_in_dir(sb, p_newdir, newentry + 1,
-					 &sector_new);
-		if (!epmov || !epnew) {
-			buf_unlock(sb, sector_mov);
-			return -ENOENT;
-		}
-
-		memcpy((void *)epnew, (void *)epmov, DENTRY_SIZE);
-		buf_modify(sb, sector_new);
+	epmov = get_entry_in_dir(sb, p_olddir, oldentry + 1,
+				 &sector_mov);
+	buf_lock(sb, sector_mov);
+	epnew = get_entry_in_dir(sb, p_newdir, newentry + 1,
+				 &sector_new);
+	if (!epmov || !epnew) {
 		buf_unlock(sb, sector_mov);
-	} else if (fs_func->get_entry_type(epnew) == TYPE_DIR) {
-		/* change ".." pointer to new parent dir */
-		clu.dir = fs_func->get_entry_clu0(epnew);
-		clu.flags = 0x01;
-
-		epnew = get_entry_in_dir(sb, &clu, 1, &sector_new);
-		if (!epnew)
-			return -ENOENT;
-
-		if (p_newdir->dir == p_fs->root_dir)
-			fs_func->set_entry_clu0(epnew, CLUSTER_32(0));
-		else
-			fs_func->set_entry_clu0(epnew, p_newdir->dir);
-		buf_modify(sb, sector_new);
+		return -ENOENT;
 	}
 
+	memcpy((void *)epnew, (void *)epmov, DENTRY_SIZE);
+	buf_modify(sb, sector_new);
+	buf_unlock(sb, sector_mov);
+
 	ret = fs_func->init_ext_entry(sb, p_newdir, newentry, num_new_entries,
 				      p_uniname, &dos_name);
 	if (ret != 0)
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 10e0a75765d9..cf094458b5d2 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -411,25 +411,21 @@ static int ffsMountVol(struct super_block *sb)
 		goto out;
 	}
 
-	if (p_fs->vol_type == EXFAT) {
-		ret = load_alloc_bitmap(sb);
-		if (ret) {
-			bdev_close(sb);
-			goto out;
-		}
-		ret = load_upcase_table(sb);
-		if (ret) {
-			free_alloc_bitmap(sb);
-			bdev_close(sb);
-			goto out;
-		}
+	ret = load_alloc_bitmap(sb);
+	if (ret) {
+		bdev_close(sb);
+		goto out;
+	}
+	ret = load_upcase_table(sb);
+	if (ret) {
+		free_alloc_bitmap(sb);
+		bdev_close(sb);
+		goto out;
 	}
 
 	if (p_fs->dev_ejected) {
-		if (p_fs->vol_type == EXFAT) {
-			free_upcase_table(sb);
-			free_alloc_bitmap(sb);
-		}
+		free_upcase_table(sb);
+		free_alloc_bitmap(sb);
 		bdev_close(sb);
 		ret = -EIO;
 		goto out;
@@ -458,10 +454,8 @@ static int ffsUmountVol(struct super_block *sb)
 	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 
-	if (p_fs->vol_type == EXFAT) {
-		free_upcase_table(sb);
-		free_alloc_bitmap(sb);
-	}
+	free_upcase_table(sb);
+	free_alloc_bitmap(sb);
 
 	FAT_release_all(sb);
 	buf_release_all(sb);
@@ -593,22 +587,13 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 		fid->size = 0;
 		fid->start_clu = p_fs->root_dir;
 	} else {
-		if (p_fs->vol_type == EXFAT) {
-			es = get_entry_set_in_dir(sb, &dir, dentry,
-						  ES_2_ENTRIES, &ep);
-			if (!es) {
-				ret =  -ENOENT;
-				goto out;
-			}
-			ep2 = ep + 1;
-		} else {
-			ep = get_entry_in_dir(sb, &dir, dentry, NULL);
-			if (!ep) {
-				ret =  -ENOENT;
-				goto out;
-			}
-			ep2 = ep;
+		es = get_entry_set_in_dir(sb, &dir, dentry,
+					  ES_2_ENTRIES, &ep);
+		if (!es) {
+			ret =  -ENOENT;
+			goto out;
 		}
+		ep2 = ep + 1;
 
 		fid->type = p_fs->fs_func->get_entry_type(ep);
 		fid->rwoffset = 0;
@@ -624,8 +609,7 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 			fid->start_clu = p_fs->fs_func->get_entry_clu0(ep2);
 		}
 
-		if (p_fs->vol_type == EXFAT)
-			release_entry_set(es);
+		release_entry_set(es);
 	}
 
 	if (p_fs->dev_ejected)
@@ -812,7 +796,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 	s32 num_clusters, num_alloc, num_alloced = (s32)~0;
 	int ret = 0;
 	u32 clu, last_clu;
-	sector_t LogSector, sector = 0;
+	sector_t LogSector;
 	u64 oneblkwrite, write_bytes;
 	struct chain_t new_clu;
 	struct timestamp_t tm;
@@ -1001,25 +985,15 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 	brelse(tmp_bh);
 
 	/* (3) update the direcoty entry */
-	if (p_fs->vol_type == EXFAT) {
-		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
-					  ES_ALL_ENTRIES, &ep);
-		if (!es)
-			goto err_out;
-		ep2 = ep + 1;
-	} else {
-		ep = get_entry_in_dir(sb, &fid->dir, fid->entry, &sector);
-		if (!ep)
-			goto err_out;
-		ep2 = ep;
-	}
+	es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
+				  ES_ALL_ENTRIES, &ep);
+	if (!es)
+		goto err_out;
+	ep2 = ep + 1;
 
 	p_fs->fs_func->set_entry_time(ep, tm_current(&tm), TM_MODIFY);
 	p_fs->fs_func->set_entry_attr(ep, fid->attr);
 
-	if (p_fs->vol_type != EXFAT)
-		buf_modify(sb, sector);
-
 	if (modified) {
 		if (p_fs->fs_func->get_entry_flag(ep2) != fid->flags)
 			p_fs->fs_func->set_entry_flag(ep2, fid->flags);
@@ -1029,15 +1003,10 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 
 		if (p_fs->fs_func->get_entry_clu0(ep2) != fid->start_clu)
 			p_fs->fs_func->set_entry_clu0(ep2, fid->start_clu);
-
-		if (p_fs->vol_type != EXFAT)
-			buf_modify(sb, sector);
 	}
 
-	if (p_fs->vol_type == EXFAT) {
-		update_dir_checksum_with_entry_set(sb, es);
-		release_entry_set(es);
-	}
+	update_dir_checksum_with_entry_set(sb, es);
+	release_entry_set(es);
 
 #ifndef CONFIG_EXFAT_DELAYED_SYNC
 	fs_sync(sb, true);
@@ -1067,7 +1036,6 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 	s32 num_clusters;
 	u32 last_clu = CLUSTER_32(0);
 	int ret = 0;
-	sector_t sector = 0;
 	struct chain_t clu;
 	struct timestamp_t tm;
 	struct dentry_t *ep, *ep2;
@@ -1132,22 +1100,13 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 	}
 
 	/* (1) update the directory entry */
-	if (p_fs->vol_type == EXFAT) {
-		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
-					  ES_ALL_ENTRIES, &ep);
-		if (!es) {
-			ret = -ENOENT;
-			goto out;
-			}
-		ep2 = ep + 1;
-	} else {
-		ep = get_entry_in_dir(sb, &fid->dir, fid->entry, &sector);
-		if (!ep) {
-			ret = -ENOENT;
-			goto out;
+	es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
+				  ES_ALL_ENTRIES, &ep);
+	if (!es) {
+		ret = -ENOENT;
+		goto out;
 		}
-		ep2 = ep;
-	}
+	ep2 = ep + 1;
 
 	p_fs->fs_func->set_entry_time(ep, tm_current(&tm), TM_MODIFY);
 	p_fs->fs_func->set_entry_attr(ep, fid->attr);
@@ -1158,12 +1117,8 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 		p_fs->fs_func->set_entry_clu0(ep2, CLUSTER_32(0));
 	}
 
-	if (p_fs->vol_type != EXFAT) {
-		buf_modify(sb, sector);
-	} else {
-		update_dir_checksum_with_entry_set(sb, es);
-		release_entry_set(es);
-	}
+	update_dir_checksum_with_entry_set(sb, es);
+	release_entry_set(es);
 
 	/* (2) cut off from the FAT chain */
 	if (last_clu != CLUSTER_32(0)) {
@@ -1436,19 +1391,11 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 	mutex_lock(&p_fs->v_mutex);
 
 	/* get the directory entry of given file */
-	if (p_fs->vol_type == EXFAT) {
-		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
-					  ES_ALL_ENTRIES, &ep);
-		if (!es) {
-			ret = -ENOENT;
-			goto out;
-		}
-	} else {
-		ep = get_entry_in_dir(sb, &fid->dir, fid->entry, &sector);
-		if (!ep) {
-			ret = -ENOENT;
-			goto out;
-		}
+	es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
+				  ES_ALL_ENTRIES, &ep);
+	if (!es) {
+		ret = -ENOENT;
+		goto out;
 	}
 
 	type = p_fs->fs_func->get_entry_type(ep);
@@ -1460,8 +1407,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 		else
 			ret = -EINVAL;
 
-		if (p_fs->vol_type == EXFAT)
-			release_entry_set(es);
+		release_entry_set(es);
 		goto out;
 	}
 
@@ -1471,12 +1417,8 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 	fid->attr = attr;
 	p_fs->fs_func->set_entry_attr(ep, attr);
 
-	if (p_fs->vol_type != EXFAT) {
-		buf_modify(sb, sector);
-	} else {
-		update_dir_checksum_with_entry_set(sb, es);
-		release_entry_set(es);
-	}
+	update_dir_checksum_with_entry_set(sb, es);
+	release_entry_set(es);
 
 #ifndef CONFIG_EXFAT_DELAYED_SYNC
 	fs_sync(sb, true);
@@ -1495,7 +1437,6 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 
 static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 {
-	sector_t sector = 0;
 	s32 count;
 	int ret = 0;
 	struct chain_t dir;
@@ -1552,23 +1493,13 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	}
 
 	/* get the directory entry of given file or directory */
-	if (p_fs->vol_type == EXFAT) {
-		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
-					  ES_2_ENTRIES, &ep);
-		if (!es) {
-			ret = -ENOENT;
-			goto out;
-		}
-		ep2 = ep + 1;
-	} else {
-		ep = get_entry_in_dir(sb, &fid->dir, fid->entry, &sector);
-		if (!ep) {
-			ret = -ENOENT;
-			goto out;
-		}
-		ep2 = ep;
-		buf_lock(sb, sector);
+	es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
+				  ES_2_ENTRIES, &ep);
+	if (!es) {
+		ret = -ENOENT;
+		goto out;
 	}
+	ep2 = ep + 1;
 
 	/* set FILE_INFO structure using the acquired struct dentry_t */
 	info->Attr = p_fs->fs_func->get_entry_attr(ep);
@@ -1599,25 +1530,13 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	 */
 	p_fs->fs_func->get_uni_name_from_ext_entry(sb, &fid->dir, fid->entry,
 						   uni_name.name);
-	if (*uni_name.name == 0x0 && p_fs->vol_type != EXFAT)
-		get_uni_name_from_dos_entry(sb, (struct dos_dentry_t *)ep,
-					    &uni_name, 0x1);
 	nls_uniname_to_cstring(sb, info->Name, &uni_name);
 
-	if (p_fs->vol_type == EXFAT) {
-		info->NumSubdirs = 2;
-	} else {
-		buf_unlock(sb, sector);
-		get_uni_name_from_dos_entry(sb, (struct dos_dentry_t *)ep,
-					    &uni_name, 0x0);
-		nls_uniname_to_cstring(sb, info->ShortName, &uni_name);
-		info->NumSubdirs = 0;
-	}
+	info->NumSubdirs = 2;
 
 	info->Size = p_fs->fs_func->get_entry_size(ep2);
 
-	if (p_fs->vol_type == EXFAT)
-		release_entry_set(es);
+	release_entry_set(es);
 
 	if (is_dir) {
 		dir.dir = fid->start_clu;
@@ -1648,7 +1567,6 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 {
-	sector_t sector = 0;
 	int ret = 0;
 	struct timestamp_t tm;
 	struct dentry_t *ep, *ep2;
@@ -1676,23 +1594,13 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	fs_set_vol_flags(sb, VOL_DIRTY);
 
 	/* get the directory entry of given file or directory */
-	if (p_fs->vol_type == EXFAT) {
-		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
-					  ES_ALL_ENTRIES, &ep);
-		if (!es) {
-			ret = -ENOENT;
-			goto out;
-		}
-		ep2 = ep + 1;
-	} else {
-		/* for other than exfat */
-		ep = get_entry_in_dir(sb, &fid->dir, fid->entry, &sector);
-		if (!ep) {
-			ret = -ENOENT;
-			goto out;
-		}
-		ep2 = ep;
+	es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
+				  ES_ALL_ENTRIES, &ep);
+	if (!es) {
+		ret = -ENOENT;
+		goto out;
 	}
+	ep2 = ep + 1;
 
 	p_fs->fs_func->set_entry_attr(ep, info->Attr);
 
@@ -1715,12 +1623,8 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 
 	p_fs->fs_func->set_entry_size(ep2, info->Size);
 
-	if (p_fs->vol_type != EXFAT) {
-		buf_modify(sb, sector);
-	} else {
-		update_dir_checksum_with_entry_set(sb, es);
-		release_entry_set(es);
-	}
+	update_dir_checksum_with_entry_set(sb, es);
+	release_entry_set(es);
 
 	if (p_fs->dev_ejected)
 		ret = -EIO;
@@ -1740,7 +1644,6 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 	bool modified = false;
 	u32 last_clu;
 	int ret = 0;
-	sector_t sector = 0;
 	struct chain_t new_clu;
 	struct dentry_t *ep;
 	struct entry_set_cache_t *es = NULL;
@@ -1830,28 +1733,17 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 		num_clusters += num_alloced;
 		*clu = new_clu.dir;
 
-		if (p_fs->vol_type == EXFAT) {
-			es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
-						  ES_ALL_ENTRIES, &ep);
-			if (!es) {
-				ret = -ENOENT;
-				goto out;
-			}
-			/* get stream entry */
-			ep++;
+		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
+					  ES_ALL_ENTRIES, &ep);
+		if (!es) {
+			ret = -ENOENT;
+			goto out;
 		}
+		/* get stream entry */
+		ep++;
 
 		/* (3) update directory entry */
 		if (modified) {
-			if (p_fs->vol_type != EXFAT) {
-				ep = get_entry_in_dir(sb, &fid->dir,
-						      fid->entry, &sector);
-				if (!ep) {
-					ret = -ENOENT;
-					goto out;
-				}
-			}
-
 			if (p_fs->fs_func->get_entry_flag(ep) != fid->flags)
 				p_fs->fs_func->set_entry_flag(ep, fid->flags);
 
@@ -1859,14 +1751,10 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 				p_fs->fs_func->set_entry_clu0(ep,
 							      fid->start_clu);
 
-			if (p_fs->vol_type != EXFAT)
-				buf_modify(sb, sector);
 		}
 
-		if (p_fs->vol_type == EXFAT) {
-			update_dir_checksum_with_entry_set(sb, es);
-			release_entry_set(es);
-		}
+		update_dir_checksum_with_entry_set(sb, es);
+		release_entry_set(es);
 
 		/* add number of new blocks to inode */
 		inode->i_blocks += num_alloced << (p_fs->cluster_size_bits - 9);
@@ -2060,25 +1948,13 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			*uni_name.name = 0x0;
 			fs_func->get_uni_name_from_ext_entry(sb, &dir, dentry,
 							     uni_name.name);
-			if (*uni_name.name == 0x0 && p_fs->vol_type != EXFAT)
-				get_uni_name_from_dos_entry(sb,
-						(struct dos_dentry_t *)ep,
-						&uni_name, 0x1);
 			nls_uniname_to_cstring(sb, dir_entry->Name, &uni_name);
 			buf_unlock(sb, sector);
 
-			if (p_fs->vol_type == EXFAT) {
-				ep = get_entry_in_dir(sb, &clu, i + 1, NULL);
-				if (!ep) {
-					ret = -ENOENT;
-					goto out;
-				}
-			} else {
-				get_uni_name_from_dos_entry(sb,
-						(struct dos_dentry_t *)ep,
-						&uni_name, 0x0);
-				nls_uniname_to_cstring(sb, dir_entry->ShortName,
-						       &uni_name);
+			ep = get_entry_in_dir(sb, &clu, i + 1, NULL);
+			if (!ep) {
+				ret = -ENOENT;
+				goto out;
 			}
 
 			dir_entry->Size = fs_func->get_entry_size(ep);
@@ -3056,7 +2932,6 @@ static int exfat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct fs_info_t *p_fs = &sbi->fs_info;
-	struct bd_info_t *p_bd = &sbi->bd_info;
 	const unsigned long blocksize = sb->s_blocksize;
 	const unsigned char blocksize_bits = sb->s_blocksize_bits;
 	sector_t last_block;
@@ -3066,18 +2941,6 @@ static int exfat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
 	*phys = 0;
 	*mapped_blocks = 0;
 
-	if ((p_fs->vol_type == FAT12) || (p_fs->vol_type == FAT16)) {
-		if (inode->i_ino == EXFAT_ROOT_INO) {
-			if (sector <
-			    (p_fs->dentries_in_root >>
-			     (p_bd->sector_size_bits - DENTRY_SIZE_BITS))) {
-				*phys = sector + p_fs->root_start_sector;
-				*mapped_blocks = 1;
-			}
-			return 0;
-		}
-	}
-
 	last_block = (i_size_read(inode) + (blocksize - 1)) >> blocksize_bits;
 	if (sector >= last_block) {
 		if (*create == 0)
@@ -3823,7 +3686,6 @@ static int exfat_fill_super(struct super_block *sb, void *data, int silent)
 	struct exfat_sb_info *sbi;
 	int debug, ret;
 	long error;
-	char buf[50];
 
 	/*
 	 * GFP_KERNEL is ok here, because while we do hold the
@@ -3870,17 +3732,6 @@ static int exfat_fill_super(struct super_block *sb, void *data, int silent)
 	 * if (FAT_FIRST_ENT(sb, media) != first)
 	 */
 
-	/* codepage is not meaningful in exfat */
-	if (sbi->fs_info.vol_type != EXFAT) {
-		error = -EINVAL;
-		sprintf(buf, "cp%d", sbi->options.codepage);
-		sbi->nls_disk = load_nls(buf);
-		if (!sbi->nls_disk) {
-			pr_err("[EXFAT] Codepage %s not found\n", buf);
-			goto out_fail2;
-		}
-	}
-
 	sbi->nls_io = load_nls(sbi->options.iocharset);
 
 	error = -ENOMEM;
-- 
2.24.0

