Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF226F9BA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 22:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKLVNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 16:13:30 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37514 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726932AbfKLVN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:29 -0500
Received: from mr5.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xACLDPoG029570
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:25 -0500
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xACLDKJl025824
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:25 -0500
Received: by mail-qv1-f70.google.com with SMTP id g33so9535557qvd.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3Z+S4urbr2iKrpZkoGbtfNBBqmKO7ik8ZoIsYV7NUHk=;
        b=r/fL0Y6pRpn+2dW3Jg2r5DcqAFfYazUqe7OEjDmtMUF3H+MzMHN7LXD2EKgex+0wq+
         1ntZQdUDN6D84WpLAeotMUYoWo6GZrp0eESw8jxafz/fagO118yZf6/yrUA5BnlztHuX
         MbU/KpzK2UmNQr3g61XzGWPB+uXaoIPnnEDsYWq5VIgDzo5UZQ3f6g9bMbIFQGWYFuEX
         xym9kVARpMSiOG4oYy/OiX2jFKPL0oGsYj6VDr2hCMGXbNNI89WzUeLdNTNn7DsxFwBu
         Kk3gh6IiYLcc5HgNZzIk6U1q7I6VGakJjqKloZC09vF7o/7aUQqKKyajlDhKMo+ih2ts
         IJOA==
X-Gm-Message-State: APjAAAWgRc1otO4MEf6soqzgPyQI0H5fCgfZ/E0ldHZ/6c1frK71xzd8
        u3vWQDkdaH2hrELMdfRG0FVle53Z+2/39am98QwX2+YuC4euPoILGGekAxb3BGBwWs09eDFS2Fg
        CUj7Z8xID2N7HqhRUr8J/KJu577KiPAluIFt0
X-Received: by 2002:a05:620a:139a:: with SMTP id k26mr2432249qki.34.1573593199762;
        Tue, 12 Nov 2019 13:13:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzlai8bma2t14+ToESMSYT22AlEQss0TkoRC69qo0zAGolH1KQs6H+QKkKm+bTiVTxZtrQyg==
X-Received: by 2002:a05:620a:139a:: with SMTP id k26mr2432186qki.34.1573593198942;
        Tue, 12 Nov 2019 13:13:18 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 130sm9674214qkd.33.2019.11.12.13.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:13:16 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] staging: exfat: Remove FAT/VFAT mount support, part 2
Date:   Tue, 12 Nov 2019 16:12:28 -0500
Message-Id: <20191112211238.156490-3-Valdis.Kletnieks@vt.edu>
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

Remove no longer referenced FAT/VFAT routines.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h      |  44 --
 drivers/staging/exfat/exfat_core.c | 619 -----------------------------
 2 files changed, 663 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 68f79e13af2b..9ea865f607af 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -766,17 +766,12 @@ void fs_error(struct super_block *sb);
 
 /* cluster management functions */
 s32 clear_cluster(struct super_block *sb, u32 clu);
-s32 fat_alloc_cluster(struct super_block *sb, s32 num_alloc,
-		      struct chain_t *p_chain);
 s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 			struct chain_t *p_chain);
-void fat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
-		      s32 do_relse);
 void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 			s32 do_relse);
 u32 find_last_cluster(struct super_block *sb, struct chain_t *p_chain);
 s32 count_num_clusters(struct super_block *sb, struct chain_t *dir);
-s32 fat_count_used_clusters(struct super_block *sb);
 s32 exfat_count_used_clusters(struct super_block *sb);
 void exfat_chain_cont_cluster(struct super_block *sb, u32 chain, s32 len);
 
@@ -793,63 +788,36 @@ s32 load_upcase_table(struct super_block *sb);
 void free_upcase_table(struct super_block *sb);
 
 /* dir entry management functions */
-u32 fat_get_entry_type(struct dentry_t *p_entry);
 u32 exfat_get_entry_type(struct dentry_t *p_entry);
-void fat_set_entry_type(struct dentry_t *p_entry, u32 type);
 void exfat_set_entry_type(struct dentry_t *p_entry, u32 type);
-u32 fat_get_entry_attr(struct dentry_t *p_entry);
 u32 exfat_get_entry_attr(struct dentry_t *p_entry);
-void fat_set_entry_attr(struct dentry_t *p_entry, u32 attr);
 void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr);
-u8 fat_get_entry_flag(struct dentry_t *p_entry);
 u8 exfat_get_entry_flag(struct dentry_t *p_entry);
-void fat_set_entry_flag(struct dentry_t *p_entry, u8 flag);
 void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flag);
-u32 fat_get_entry_clu0(struct dentry_t *p_entry);
 u32 exfat_get_entry_clu0(struct dentry_t *p_entry);
-void fat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu);
 void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu);
-u64 fat_get_entry_size(struct dentry_t *p_entry);
 u64 exfat_get_entry_size(struct dentry_t *p_entry);
-void fat_set_entry_size(struct dentry_t *p_entry, u64 size);
 void exfat_set_entry_size(struct dentry_t *p_entry, u64 size);
 struct timestamp_t *tm_current(struct timestamp_t *tm);
-void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-			u8 mode);
 void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode);
-void fat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-			u8 mode);
 void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode);
-s32 fat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir, s32 entry,
-		       u32 type, u32 start_clu, u64 size);
 s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 s32 entry, u32 type, u32 start_clu, u64 size);
-s32 fat_init_ext_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-			   s32 entry, s32 num_entries,
-			   struct uni_name_t *p_uniname,
-			   struct dos_name_t *p_dosname);
 s32 exfat_init_ext_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			     s32 entry, s32 num_entries,
 			     struct uni_name_t *p_uniname,
 		struct dos_name_t *p_dosname);
-void init_dos_entry(struct dos_dentry_t *ep, u32 type, u32 start_clu);
-void init_ext_entry(struct ext_dentry_t *ep, s32 order, u8 chksum,
-		    u16 *uniname);
 void init_file_entry(struct file_dentry_t *ep, u32 type);
 void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu,
 		     u64 size);
 void init_name_entry(struct name_dentry_t *ep, u16 *uniname);
-void fat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-			  s32 entry, s32 order, s32 num_entries);
 void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			    s32 entry, s32 order, s32 num_entries);
 
 s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 		  sector_t *sector, s32 *offset);
-struct dentry_t *get_entry_with_sector(struct super_block *sb, sector_t sector,
-				       s32 offset);
 struct dentry_t *get_entry_in_dir(struct super_block *sb, struct chain_t *p_dir,
 				  s32 entry, sector_t *sector);
 struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
@@ -865,14 +833,9 @@ s32 search_deleted_or_unused_entry(struct super_block *sb,
 				   struct chain_t *p_dir, s32 num_entries);
 s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir,
 		     s32 num_entries);
-s32 fat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-		       struct uni_name_t *p_uniname, s32 num_entries,
-		       struct dos_name_t *p_dosname, u32 type);
 s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 struct uni_name_t *p_uniname, s32 num_entries,
 			 struct dos_name_t *p_dosname, u32 type);
-s32 fat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
-			  s32 entry, struct dentry_t *p_entry);
 s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
 			    s32 entry, struct dentry_t *p_entry);
 s32 count_dos_name_entries(struct super_block *sb, struct chain_t *p_dir,
@@ -890,14 +853,9 @@ s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 void get_uni_name_from_dos_entry(struct super_block *sb,
 				 struct dos_dentry_t *ep,
 				 struct uni_name_t *p_uniname, u8 mode);
-void fat_get_uni_name_from_ext_entry(struct super_block *sb,
-				     struct chain_t *p_dir, s32 entry,
-				     u16 *uniname);
 void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
 				       struct chain_t *p_dir, s32 entry,
 				       u16 *uniname);
-s32 extract_uni_name_from_ext_entry(struct ext_dentry_t *ep,
-				    u16 *uniname, s32 order);
 s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep,
 				     u16 *uniname, s32 order);
 s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
@@ -905,9 +863,7 @@ s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
 void fat_attach_count_to_dos_name(u8 *dosname, s32 count);
 s32 fat_calc_num_entries(struct uni_name_t *p_uniname);
 s32 exfat_calc_num_entries(struct uni_name_t *p_uniname);
-u8 calc_checksum_1byte(void *data, s32 len, u8 chksum);
 u16 calc_checksum_2byte(void *data, s32 len, u16 chksum, s32 type);
-u32 calc_checksum_4byte(void *data, s32 len, u32 chksum, s32 type);
 
 /* name resolution functions */
 s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 89bed7460162..ed9e4521ec04 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -167,60 +167,6 @@ s32 clear_cluster(struct super_block *sb, u32 clu)
 	return ret;
 }
 
-s32 fat_alloc_cluster(struct super_block *sb, s32 num_alloc,
-		      struct chain_t *p_chain)
-{
-	int i, num_clusters = 0;
-	u32 new_clu, last_clu = CLUSTER_32(~0), read_clu;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	new_clu = p_chain->dir;
-	if (new_clu == CLUSTER_32(~0))
-		new_clu = p_fs->clu_srch_ptr;
-	else if (new_clu >= p_fs->num_clusters)
-		new_clu = 2;
-
-	__set_sb_dirty(sb);
-
-	p_chain->dir = CLUSTER_32(~0);
-
-	for (i = 2; i < p_fs->num_clusters; i++) {
-		if (FAT_read(sb, new_clu, &read_clu) != 0)
-			return -1;
-
-		if (read_clu == CLUSTER_32(0)) {
-			if (FAT_write(sb, new_clu, CLUSTER_32(~0)) < 0)
-				return -1;
-			num_clusters++;
-
-			if (p_chain->dir == CLUSTER_32(~0)) {
-				p_chain->dir = new_clu;
-			} else {
-				if (FAT_write(sb, last_clu, new_clu) < 0)
-					return -1;
-			}
-
-			last_clu = new_clu;
-
-			if ((--num_alloc) == 0) {
-				p_fs->clu_srch_ptr = new_clu;
-				if (p_fs->used_clusters != UINT_MAX)
-					p_fs->used_clusters += num_clusters;
-
-				return num_clusters;
-			}
-		}
-		if ((++new_clu) >= p_fs->num_clusters)
-			new_clu = 2;
-	}
-
-	p_fs->clu_srch_ptr = new_clu;
-	if (p_fs->used_clusters != UINT_MAX)
-		p_fs->used_clusters += num_clusters;
-
-	return num_clusters;
-}
-
 s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 			struct chain_t *p_chain)
 {
@@ -300,47 +246,6 @@ s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 	return num_clusters;
 }
 
-void fat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
-		      s32 do_relse)
-{
-	s32 num_clusters = 0;
-	u32 clu, prev;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	int i;
-	sector_t sector;
-
-	if ((p_chain->dir == CLUSTER_32(0)) || (p_chain->dir == CLUSTER_32(~0)))
-		return;
-	__set_sb_dirty(sb);
-	clu = p_chain->dir;
-
-	if (p_chain->size <= 0)
-		return;
-
-	do {
-		if (p_fs->dev_ejected)
-			break;
-
-		if (do_relse) {
-			sector = START_SECTOR(clu);
-			for (i = 0; i < p_fs->sectors_per_clu; i++)
-				buf_release(sb, sector + i);
-		}
-
-		prev = clu;
-		if (FAT_read(sb, clu, &clu) == -1)
-			break;
-
-		if (FAT_write(sb, prev, CLUSTER_32(0)) < 0)
-			break;
-		num_clusters++;
-
-	} while (clu != CLUSTER_32(~0));
-
-	if (p_fs->used_clusters != UINT_MAX)
-		p_fs->used_clusters -= num_clusters;
-}
-
 void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 			s32 do_relse)
 {
@@ -447,22 +352,6 @@ s32 count_num_clusters(struct super_block *sb, struct chain_t *p_chain)
 	return count;
 }
 
-s32 fat_count_used_clusters(struct super_block *sb)
-{
-	int i, count = 0;
-	u32 clu;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	for (i = 2; i < p_fs->num_clusters; i++) {
-		if (FAT_read(sb, i, &clu) != 0)
-			break;
-		if (clu != CLUSTER_32(0))
-			count++;
-	}
-
-	return count;
-}
-
 s32 exfat_count_used_clusters(struct super_block *sb)
 {
 	int i, map_i, map_b, count = 0;
@@ -907,28 +796,6 @@ void free_upcase_table(struct super_block *sb)
  *  Directory Entry Management Functions
  */
 
-u32 fat_get_entry_type(struct dentry_t *p_entry)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	if (*ep->name == 0x0)
-		return TYPE_UNUSED;
-
-	else if (*ep->name == 0xE5)
-		return TYPE_DELETED;
-
-	else if (ep->attr == ATTR_EXTEND)
-		return TYPE_EXTEND;
-
-	else if ((ep->attr & (ATTR_SUBDIR | ATTR_VOLUME)) == ATTR_VOLUME)
-		return TYPE_VOLUME;
-
-	else if ((ep->attr & (ATTR_SUBDIR | ATTR_VOLUME)) == ATTR_SUBDIR)
-		return TYPE_DIR;
-
-	return TYPE_FILE;
-}
-
 u32 exfat_get_entry_type(struct dentry_t *p_entry)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
@@ -974,29 +841,6 @@ u32 exfat_get_entry_type(struct dentry_t *p_entry)
 	return TYPE_BENIGN_SEC;
 }
 
-void fat_set_entry_type(struct dentry_t *p_entry, u32 type)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	if (type == TYPE_UNUSED)
-		*ep->name = 0x0;
-
-	else if (type == TYPE_DELETED)
-		*ep->name = 0xE5;
-
-	else if (type == TYPE_EXTEND)
-		ep->attr = ATTR_EXTEND;
-
-	else if (type == TYPE_DIR)
-		ep->attr = ATTR_SUBDIR;
-
-	else if (type == TYPE_FILE)
-		ep->attr = ATTR_ARCHIVE;
-
-	else if (type == TYPE_SYMLINK)
-		ep->attr = ATTR_ARCHIVE | ATTR_SYMLINK;
-}
-
 void exfat_set_entry_type(struct dentry_t *p_entry, u32 type)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
@@ -1027,13 +871,6 @@ void exfat_set_entry_type(struct dentry_t *p_entry, u32 type)
 	}
 }
 
-u32 fat_get_entry_attr(struct dentry_t *p_entry)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	return (u32)ep->attr;
-}
-
 u32 exfat_get_entry_attr(struct dentry_t *p_entry)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
@@ -1041,13 +878,6 @@ u32 exfat_get_entry_attr(struct dentry_t *p_entry)
 	return (u32)GET16_A(ep->attr);
 }
 
-void fat_set_entry_attr(struct dentry_t *p_entry, u32 attr)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	ep->attr = (u8)attr;
-}
-
 void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
@@ -1055,11 +885,6 @@ void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr)
 	SET16_A(ep->attr, (u16)attr);
 }
 
-u8 fat_get_entry_flag(struct dentry_t *p_entry)
-{
-	return 0x01;
-}
-
 u8 exfat_get_entry_flag(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
@@ -1067,10 +892,6 @@ u8 exfat_get_entry_flag(struct dentry_t *p_entry)
 	return ep->flags;
 }
 
-void fat_set_entry_flag(struct dentry_t *p_entry, u8 flags)
-{
-}
-
 void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flags)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
@@ -1078,14 +899,6 @@ void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flags)
 	ep->flags = flags;
 }
 
-u32 fat_get_entry_clu0(struct dentry_t *p_entry)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	return ((u32)GET16_A(ep->start_clu_hi) << 16) |
-		GET16_A(ep->start_clu_lo);
-}
-
 u32 exfat_get_entry_clu0(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
@@ -1093,14 +906,6 @@ u32 exfat_get_entry_clu0(struct dentry_t *p_entry)
 	return GET32_A(ep->start_clu);
 }
 
-void fat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	SET16_A(ep->start_clu_lo, CLUSTER_16(start_clu));
-	SET16_A(ep->start_clu_hi, CLUSTER_16(start_clu >> 16));
-}
-
 void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
@@ -1108,13 +913,6 @@ void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
 	SET32_A(ep->start_clu, start_clu);
 }
 
-u64 fat_get_entry_size(struct dentry_t *p_entry)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	return (u64)GET32_A(ep->size);
-}
-
 u64 exfat_get_entry_size(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
@@ -1122,13 +920,6 @@ u64 exfat_get_entry_size(struct dentry_t *p_entry)
 	return GET64_A(ep->valid_size);
 }
 
-void fat_set_entry_size(struct dentry_t *p_entry, u64 size)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	SET32_A(ep->size, (u32)size);
-}
-
 void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
@@ -1137,31 +928,6 @@ void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
 	SET64_A(ep->size, size);
 }
 
-void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-			u8 mode)
-{
-	u16 t = 0x00, d = 0x21;
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	switch (mode) {
-	case TM_CREATE:
-		t = GET16_A(ep->create_time);
-		d = GET16_A(ep->create_date);
-		break;
-	case TM_MODIFY:
-		t = GET16_A(ep->modify_time);
-		d = GET16_A(ep->modify_date);
-		break;
-	}
-
-	tp->sec  = (t & 0x001F) << 1;
-	tp->min  = (t >> 5) & 0x003F;
-	tp->hour = (t >> 11);
-	tp->day  = (d & 0x001F);
-	tp->mon  = (d >> 5) & 0x000F;
-	tp->year = (d >> 9);
-}
-
 void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode)
 {
@@ -1191,27 +957,6 @@ void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 	tp->year = (d >> 9);
 }
 
-void fat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-			u8 mode)
-{
-	u16 t, d;
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	t = (tp->hour << 11) | (tp->min << 5) | (tp->sec >> 1);
-	d = (tp->year <<  9) | (tp->mon << 5) |  tp->day;
-
-	switch (mode) {
-	case TM_CREATE:
-		SET16_A(ep->create_time, t);
-		SET16_A(ep->create_date, d);
-		break;
-	case TM_MODIFY:
-		SET16_A(ep->modify_time, t);
-		SET16_A(ep->modify_date, d);
-		break;
-	}
-}
-
 void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode)
 {
@@ -1237,23 +982,6 @@ void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 	}
 }
 
-s32 fat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir, s32 entry,
-		       u32 type, u32 start_clu, u64 size)
-{
-	sector_t sector;
-	struct dos_dentry_t *dos_ep;
-
-	dos_ep = (struct dos_dentry_t *)get_entry_in_dir(sb, p_dir, entry,
-							 &sector);
-	if (!dos_ep)
-		return -EIO;
-
-	init_dos_entry(dos_ep, type, start_clu);
-	buf_modify(sb, sector);
-
-	return 0;
-}
-
 s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 s32 entry, u32 type, u32 start_clu, u64 size)
 {
@@ -1330,70 +1058,6 @@ static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 	return 0;
 }
 
-void init_dos_entry(struct dos_dentry_t *ep, u32 type, u32 start_clu)
-{
-	struct timestamp_t tm, *tp;
-
-	fat_set_entry_type((struct dentry_t *)ep, type);
-	SET16_A(ep->start_clu_lo, CLUSTER_16(start_clu));
-	SET16_A(ep->start_clu_hi, CLUSTER_16(start_clu >> 16));
-	SET32_A(ep->size, 0);
-
-	tp = tm_current(&tm);
-	fat_set_entry_time((struct dentry_t *)ep, tp, TM_CREATE);
-	fat_set_entry_time((struct dentry_t *)ep, tp, TM_MODIFY);
-	SET16_A(ep->access_date, 0);
-	ep->create_time_ms = 0;
-}
-
-void init_ext_entry(struct ext_dentry_t *ep, s32 order, u8 chksum, u16 *uniname)
-{
-	int i;
-	bool end = false;
-
-	fat_set_entry_type((struct dentry_t *)ep, TYPE_EXTEND);
-	ep->order = (u8)order;
-	ep->sysid = 0;
-	ep->checksum = chksum;
-	SET16_A(ep->start_clu, 0);
-
-	for (i = 0; i < 10; i += 2) {
-		if (!end) {
-			SET16(ep->unicode_0_4 + i, *uniname);
-			if (*uniname == 0x0)
-				end = true;
-			else
-				uniname++;
-		} else {
-			SET16(ep->unicode_0_4 + i, 0xFFFF);
-		}
-	}
-
-	for (i = 0; i < 12; i += 2) {
-		if (!end) {
-			SET16_A(ep->unicode_5_10 + i, *uniname);
-			if (*uniname == 0x0)
-				end = true;
-			else
-				uniname++;
-		} else {
-			SET16_A(ep->unicode_5_10 + i, 0xFFFF);
-		}
-	}
-
-	for (i = 0; i < 4; i += 2) {
-		if (!end) {
-			SET16_A(ep->unicode_11_12 + i, *uniname);
-			if (*uniname == 0x0)
-				end = true;
-			else
-				uniname++;
-		} else {
-			SET16_A(ep->unicode_11_12 + i, 0xFFFF);
-		}
-	}
-}
-
 void init_file_entry(struct file_dentry_t *ep, u32 type)
 {
 	struct timestamp_t tm, *tp;
@@ -1433,24 +1097,6 @@ void init_name_entry(struct name_dentry_t *ep, u16 *uniname)
 	}
 }
 
-void fat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-		s32 entry, s32 order, s32 num_entries)
-{
-	int i;
-	sector_t sector;
-	struct dentry_t *ep;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	for (i = num_entries - 1; i >= order; i--) {
-		ep = get_entry_in_dir(sb, p_dir, entry - i, &sector);
-		if (!ep)
-			return;
-
-		p_fs->fs_func->set_entry_type(ep, TYPE_DELETED);
-		buf_modify(sb, sector);
-	}
-}
-
 void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			    s32 entry, s32 order, s32 num_entries)
 {
@@ -1583,19 +1229,6 @@ s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 	return 0;
 }
 
-struct dentry_t *get_entry_with_sector(struct super_block *sb, sector_t sector,
-				       s32 offset)
-{
-	u8 *buf;
-
-	buf = buf_getblk(sb, sector);
-
-	if (!buf)
-		return NULL;
-
-	return (struct dentry_t *)(buf + offset);
-}
-
 struct dentry_t *get_entry_in_dir(struct super_block *sb, struct chain_t *p_dir,
 				  s32 entry, sector_t *sector)
 {
@@ -1866,46 +1499,6 @@ s32 write_whole_entry_set(struct super_block *sb, struct entry_set_cache_t *es)
 						    es->num_entries);
 }
 
-/* write back some entries in entry set */
-s32 write_partial_entries_in_entry_set(struct super_block *sb,
-				       struct entry_set_cache_t *es,
-				       struct dentry_t *ep, u32 count)
-{
-	s32 ret, byte_offset, off;
-	u32 clu = 0;
-	sector_t sec;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
-	struct chain_t dir;
-
-	/* vaidity check */
-	if (ep + count  > ((struct dentry_t *)&es->__buf) + es->num_entries)
-		return -EINVAL;
-
-	dir.dir = GET_CLUSTER_FROM_SECTOR(es->sector);
-	dir.flags = es->alloc_flag;
-	dir.size = 0xffffffff;		/* XXX */
-
-	byte_offset = (es->sector - START_SECTOR(dir.dir)) <<
-			p_bd->sector_size_bits;
-	byte_offset += ((void **)ep - &es->__buf) + es->offset;
-
-	ret = _walk_fat_chain(sb, &dir, byte_offset, &clu);
-	if (ret != 0)
-		return ret;
-
-	/* byte offset in cluster */
-	byte_offset &= p_fs->cluster_size - 1;
-
-	/* byte offset in sector    */
-	off = byte_offset & p_bd->sector_size_mask;
-
-	/* sector offset in cluster */
-	sec = byte_offset >> p_bd->sector_size_bits;
-	sec += START_SECTOR(clu);
-	return __write_partial_entries_in_entry_set(sb, es, sec, off, count);
-}
-
 /* search EMPTY CONTINUOUS "num_entries" entries */
 s32 search_deleted_or_unused_entry(struct super_block *sb,
 				   struct chain_t *p_dir, s32 num_entries)
@@ -2087,104 +1680,6 @@ s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries
 	return dentry;
 }
 
-/* return values of fat_find_dir_entry()
- * >= 0 : return dir entiry position with the name in dir
- * -1 : (root dir, ".") it is the root dir itself
- * -2 : entry with the name does not exist
- */
-s32 fat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-		       struct uni_name_t *p_uniname, s32 num_entries,
-		       struct dos_name_t *p_dosname, u32 type)
-{
-	int i, dentry = 0, len;
-	s32 order = 0;
-	bool is_feasible_entry = true, has_ext_entry = false;
-	s32 dentries_per_clu;
-	u32 entry_type;
-	u16 entry_uniname[14], *uniname = NULL, unichar;
-	struct chain_t clu;
-	struct dentry_t *ep;
-	struct dos_dentry_t *dos_ep;
-	struct ext_dentry_t *ext_ep;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	if (p_dir->dir == p_fs->root_dir) {
-		if ((!nls_uniname_cmp(sb, p_uniname->name,
-				      (u16 *)UNI_CUR_DIR_NAME)) ||
-			(!nls_uniname_cmp(sb, p_uniname->name,
-					  (u16 *)UNI_PAR_DIR_NAME)))
-			return -1; // special case, root directory itself
-	}
-
-	if (p_dir->dir == CLUSTER_32(0)) /* FAT16 root_dir */
-		dentries_per_clu = p_fs->dentries_in_root;
-	else
-		dentries_per_clu = p_fs->dentries_per_clu;
-
-	clu.dir = p_dir->dir;
-	clu.flags = p_dir->flags;
-
-	while (clu.dir != CLUSTER_32(~0)) {
-		if (p_fs->dev_ejected)
-			break;
-
-		for (i = 0; i < dentries_per_clu; i++, dentry++) {
-			ep = get_entry_in_dir(sb, &clu, i, NULL);
-			if (!ep)
-				return -2;
-
-			entry_type = p_fs->fs_func->get_entry_type(ep);
-
-			if ((entry_type == TYPE_FILE) || (entry_type == TYPE_DIR)) {
-				if ((type == TYPE_ALL) || (type == entry_type)) {
-					if (is_feasible_entry && has_ext_entry)
-						return dentry;
-
-					dos_ep = (struct dos_dentry_t *)ep;
-					if (!nls_dosname_cmp(sb, p_dosname->name, dos_ep->name))
-						return dentry;
-				}
-				is_feasible_entry = true;
-				has_ext_entry = false;
-			} else if (entry_type == TYPE_EXTEND) {
-				if (is_feasible_entry) {
-					ext_ep = (struct ext_dentry_t *)ep;
-					if (ext_ep->order > 0x40) {
-						order = (s32)(ext_ep->order - 0x40);
-						uniname = p_uniname->name + 13 * (order - 1);
-					} else {
-						order = (s32)ext_ep->order;
-						uniname -= 13;
-					}
-
-					len = extract_uni_name_from_ext_entry(ext_ep, entry_uniname, order);
-
-					unichar = *(uniname + len);
-					*(uniname + len) = 0x0;
-
-					if (nls_uniname_cmp(sb, uniname, entry_uniname))
-						is_feasible_entry = false;
-
-					*(uniname + len) = unichar;
-				}
-				has_ext_entry = true;
-			} else if (entry_type == TYPE_UNUSED) {
-				return -2;
-			}
-			is_feasible_entry = true;
-			has_ext_entry = false;
-		}
-
-		if (p_dir->dir == CLUSTER_32(0))
-			break; /* FAT16 root_dir */
-
-		if (FAT_read(sb, clu.dir, &clu.dir) != 0)
-			return -2;
-	}
-
-	return -2;
-}
-
 /* return values of exfat_find_dir_entry()
  * >= 0 : return dir entiry position with the name in dir
  * -1 : (root dir, ".") it is the root dir itself
@@ -2333,36 +1828,6 @@ s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 	return -2;
 }
 
-s32 fat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
-			  s32 entry, struct dentry_t *p_entry)
-{
-	s32 count = 0;
-	u8 chksum;
-	struct dos_dentry_t *dos_ep = (struct dos_dentry_t *)p_entry;
-	struct ext_dentry_t *ext_ep;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	chksum = calc_checksum_1byte((void *)dos_ep->name, DOS_NAME_LENGTH, 0);
-
-	for (entry--; entry >= 0; entry--) {
-		ext_ep = (struct ext_dentry_t *)get_entry_in_dir(sb, p_dir,
-								 entry, NULL);
-		if (!ext_ep)
-			return -1;
-
-		if ((p_fs->fs_func->get_entry_type((struct dentry_t *)ext_ep) ==
-		     TYPE_EXTEND) && (ext_ep->checksum == chksum)) {
-			count++;
-			if (ext_ep->order > 0x40)
-				return count;
-		} else {
-			return count;
-		}
-	}
-
-	return count;
-}
-
 s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
 			    s32 entry, struct dentry_t *p_entry)
 {
@@ -2564,33 +2029,6 @@ void get_uni_name_from_dos_entry(struct super_block *sb,
 	nls_dosname_to_uniname(sb, p_uniname, &dos_name);
 }
 
-void fat_get_uni_name_from_ext_entry(struct super_block *sb,
-				     struct chain_t *p_dir, s32 entry,
-				     u16 *uniname)
-{
-	int i;
-	struct ext_dentry_t *ep;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	for (entry--, i = 1; entry >= 0; entry--, i++) {
-		ep = (struct ext_dentry_t *)get_entry_in_dir(sb, p_dir, entry,
-							     NULL);
-		if (!ep)
-			return;
-
-		if (p_fs->fs_func->get_entry_type((struct dentry_t *)ep) ==
-		    TYPE_EXTEND) {
-			extract_uni_name_from_ext_entry(ep, uniname, i);
-			if (ep->order > 0x40)
-				return;
-		} else {
-			return;
-		}
-
-		uniname += 13;
-	}
-}
-
 void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
 				       struct chain_t *p_dir, s32 entry,
 				       u16 *uniname)
@@ -2628,51 +2066,6 @@ void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
 	release_entry_set(es);
 }
 
-s32 extract_uni_name_from_ext_entry(struct ext_dentry_t *ep, u16 *uniname,
-				    s32 order)
-{
-	int i, len = 0;
-
-	for (i = 0; i < 10; i += 2) {
-		*uniname = GET16(ep->unicode_0_4 + i);
-		if (*uniname == 0x0)
-			return len;
-		uniname++;
-		len++;
-	}
-
-	if (order < 20) {
-		for (i = 0; i < 12; i += 2) {
-			*uniname = GET16_A(ep->unicode_5_10 + i);
-			if (*uniname == 0x0)
-				return len;
-			uniname++;
-			len++;
-		}
-	} else {
-		for (i = 0; i < 8; i += 2) {
-			*uniname = GET16_A(ep->unicode_5_10 + i);
-			if (*uniname == 0x0)
-				return len;
-			uniname++;
-			len++;
-		}
-		*uniname = 0x0; /* uniname[MAX_NAME_LENGTH-1] */
-		return len;
-	}
-
-	for (i = 0; i < 4; i += 2) {
-		*uniname = GET16_A(ep->unicode_11_12 + i);
-		if (*uniname == 0x0)
-			return len;
-		uniname++;
-		len++;
-	}
-
-	*uniname = 0x0;
-	return len;
-}
-
 s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *uniname,
 				     s32 order)
 {
@@ -2812,18 +2205,6 @@ void fat_attach_count_to_dos_name(u8 *dosname, s32 count)
 		dosname[7] = ' ';
 }
 
-s32 fat_calc_num_entries(struct uni_name_t *p_uniname)
-{
-	s32 len;
-
-	len = p_uniname->name_len;
-	if (len == 0)
-		return 0;
-
-	/* 1 dos name entry + extended entries */
-	return (len - 1) / 13 + 2;
-}
-
 s32 exfat_calc_num_entries(struct uni_name_t *p_uniname)
 {
 	s32 len;
-- 
2.24.0

