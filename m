Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B8EE1194
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 07:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389313AbfJWF22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 01:28:28 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:60918 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730622AbfJWF22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:28:28 -0400
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9N5SNQu003418
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:23 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9N5SI8C004972
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:23 -0400
Received: by mail-qk1-f198.google.com with SMTP id z136so2644027qkb.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2019 22:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jKyeWRSqH9KDMrwUslIqCLBGlFRwU4FLz5NzrspktIY=;
        b=mUnYNRf93eVDyRRsXYBPoj6H9Gfpt4lkM1BVpKrqyEdG7vgaazmjDRaOiEuQhiHF5r
         Rcx8Lc5J9XcvKKWWcAziRQEpj+mCjol0LlHc8k2SxmsKn/RGvLwycBoTpsQ2RbjdNlVm
         l1bMhTDUwJUdXkM9geV5Ma5xCTuYGH084UdZuqREs1pwS+aOm76kTB23Vvd/51kwUWzC
         ZIQUdmrfgSaVfDjtqURkwsYnn/Zgx9W76xpF8W2+OhZmF4tK2QO4P7phLsIxWGLPAzE2
         fQF1q4tobhtYclmUIYhllbLgokQb8b1Je4ChrT1Qfb4ucOVCt4q1wVe9dAbCzH38QKsL
         1vNw==
X-Gm-Message-State: APjAAAXdiadagsHWQKLje37pNN3PD8j4H3E+35CTazp3cqOPCZia62f2
        BPNgrCXRTzEidPhCukeYLJifrPw/NRNi0x+fVRvCnaOQ+SNV5Ii3A2B9jenm2KCeZSoUwhkaSEW
        EQdJk6fIxTOO1Qn9nHjNmN4/nPlcbmiLzqC7Y
X-Received: by 2002:ac8:ff5:: with SMTP id f50mr7549125qtk.2.1571808497878;
        Tue, 22 Oct 2019 22:28:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySnhlPkV6BMZP0zWSnQNgrYCIQctfc+Oaa9bWTmMfe7aV5gptIbNbtcIMWPtiFwZLQjeaHJw==
X-Received: by 2002:ac8:ff5:: with SMTP id f50mr7549090qtk.2.1571808496993;
        Tue, 22 Oct 2019 22:28:16 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 14sm10397445qtb.54.2019.10.22.22.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 22:28:15 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valdis.Kletnieks@vt.edu
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] staging: exfat: Clean up namespace pollution, part 1
Date:   Wed, 23 Oct 2019 01:27:44 -0400
Message-Id: <20191023052752.693689-2-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
References: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make as much as possible static.  We're over-exuberant here for the benefit
of a following patch, as the compiler will flag now-unused static code

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h      | 156 ++++++++++++++---------------
 drivers/staging/exfat/exfat_core.c | 142 +++++++++++++-------------
 2 files changed, 149 insertions(+), 149 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 3abab33e932c..0c779c8dd858 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -768,107 +768,107 @@ void buf_init(struct super_block *sb);
 void buf_shutdown(struct super_block *sb);
 int FAT_read(struct super_block *sb, u32 loc, u32 *content);
 s32 FAT_write(struct super_block *sb, u32 loc, u32 content);
-u8 *FAT_getblk(struct super_block *sb, sector_t sec);
-void FAT_modify(struct super_block *sb, sector_t sec);
+static u8 *FAT_getblk(struct super_block *sb, sector_t sec);
+static void FAT_modify(struct super_block *sb, sector_t sec);
 void FAT_release_all(struct super_block *sb);
-void FAT_sync(struct super_block *sb);
+static void FAT_sync(struct super_block *sb);
 u8 *buf_getblk(struct super_block *sb, sector_t sec);
 void buf_modify(struct super_block *sb, sector_t sec);
 void buf_lock(struct super_block *sb, sector_t sec);
 void buf_unlock(struct super_block *sb, sector_t sec);
 void buf_release(struct super_block *sb, sector_t sec);
 void buf_release_all(struct super_block *sb);
-void buf_sync(struct super_block *sb);
+static void buf_sync(struct super_block *sb);
 
 /* fs management functions */
 void fs_set_vol_flags(struct super_block *sb, u32 new_flag);
-void fs_error(struct super_block *sb);
+static void fs_error(struct super_block *sb);
 
 /* cluster management functions */
-s32 clear_cluster(struct super_block *sb, u32 clu);
-s32 fat_alloc_cluster(struct super_block *sb, s32 num_alloc,
+static s32 clear_cluster(struct super_block *sb, u32 clu);
+static s32 fat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 		      struct chain_t *p_chain);
-s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
+static s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 			struct chain_t *p_chain);
-void fat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
+static void fat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 		      s32 do_relse);
-void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
+static void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 			s32 do_relse);
-u32 find_last_cluster(struct super_block *sb, struct chain_t *p_chain);
+static u32 find_last_cluster(struct super_block *sb, struct chain_t *p_chain);
 s32 count_num_clusters(struct super_block *sb, struct chain_t *dir);
-s32 fat_count_used_clusters(struct super_block *sb);
-s32 exfat_count_used_clusters(struct super_block *sb);
+static s32 fat_count_used_clusters(struct super_block *sb);
+static s32 exfat_count_used_clusters(struct super_block *sb);
 void exfat_chain_cont_cluster(struct super_block *sb, u32 chain, s32 len);
 
 /* allocation bitmap management functions */
 s32 load_alloc_bitmap(struct super_block *sb);
 void free_alloc_bitmap(struct super_block *sb);
-s32 set_alloc_bitmap(struct super_block *sb, u32 clu);
-s32 clr_alloc_bitmap(struct super_block *sb, u32 clu);
-u32 test_alloc_bitmap(struct super_block *sb, u32 clu);
-void sync_alloc_bitmap(struct super_block *sb);
+static s32 set_alloc_bitmap(struct super_block *sb, u32 clu);
+static s32 clr_alloc_bitmap(struct super_block *sb, u32 clu);
+static u32 test_alloc_bitmap(struct super_block *sb, u32 clu);
+static void sync_alloc_bitmap(struct super_block *sb);
 
 /* upcase table management functions */
 s32 load_upcase_table(struct super_block *sb);
 void free_upcase_table(struct super_block *sb);
 
 /* dir entry management functions */
-u32 fat_get_entry_type(struct dentry_t *p_entry);
-u32 exfat_get_entry_type(struct dentry_t *p_entry);
-void fat_set_entry_type(struct dentry_t *p_entry, u32 type);
-void exfat_set_entry_type(struct dentry_t *p_entry, u32 type);
-u32 fat_get_entry_attr(struct dentry_t *p_entry);
-u32 exfat_get_entry_attr(struct dentry_t *p_entry);
-void fat_set_entry_attr(struct dentry_t *p_entry, u32 attr);
-void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr);
-u8 fat_get_entry_flag(struct dentry_t *p_entry);
-u8 exfat_get_entry_flag(struct dentry_t *p_entry);
-void fat_set_entry_flag(struct dentry_t *p_entry, u8 flag);
-void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flag);
-u32 fat_get_entry_clu0(struct dentry_t *p_entry);
-u32 exfat_get_entry_clu0(struct dentry_t *p_entry);
-void fat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu);
-void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu);
-u64 fat_get_entry_size(struct dentry_t *p_entry);
-u64 exfat_get_entry_size(struct dentry_t *p_entry);
-void fat_set_entry_size(struct dentry_t *p_entry, u64 size);
-void exfat_set_entry_size(struct dentry_t *p_entry, u64 size);
+static u32 fat_get_entry_type(struct dentry_t *p_entry);
+static u32 exfat_get_entry_type(struct dentry_t *p_entry);
+static void fat_set_entry_type(struct dentry_t *p_entry, u32 type);
+static void exfat_set_entry_type(struct dentry_t *p_entry, u32 type);
+static u32 fat_get_entry_attr(struct dentry_t *p_entry);
+static u32 exfat_get_entry_attr(struct dentry_t *p_entry);
+static void fat_set_entry_attr(struct dentry_t *p_entry, u32 attr);
+static void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr);
+static u8 fat_get_entry_flag(struct dentry_t *p_entry);
+static u8 exfat_get_entry_flag(struct dentry_t *p_entry);
+static void fat_set_entry_flag(struct dentry_t *p_entry, u8 flag);
+static void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flag);
+static u32 fat_get_entry_clu0(struct dentry_t *p_entry);
+static u32 exfat_get_entry_clu0(struct dentry_t *p_entry);
+static void fat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu);
+static void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu);
+static u64 fat_get_entry_size(struct dentry_t *p_entry);
+static u64 exfat_get_entry_size(struct dentry_t *p_entry);
+static void fat_set_entry_size(struct dentry_t *p_entry, u64 size);
+static void exfat_set_entry_size(struct dentry_t *p_entry, u64 size);
 struct timestamp_t *tm_current(struct timestamp_t *tm);
-void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
+static void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			u8 mode);
-void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
+static void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode);
-void fat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
+static void fat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			u8 mode);
-void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
+static void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode);
-s32 fat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir, s32 entry,
+static s32 fat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 		       u32 type, u32 start_clu, u64 size);
-s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 s32 entry, u32 type, u32 start_clu, u64 size);
-s32 fat_init_ext_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static s32 fat_init_ext_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			   s32 entry, s32 num_entries,
 			   struct uni_name_t *p_uniname,
 			   struct dos_name_t *p_dosname);
-s32 exfat_init_ext_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static s32 exfat_init_ext_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			     s32 entry, s32 num_entries,
 			     struct uni_name_t *p_uniname,
 		struct dos_name_t *p_dosname);
-void init_dos_entry(struct dos_dentry_t *ep, u32 type, u32 start_clu);
-void init_ext_entry(struct ext_dentry_t *ep, s32 order, u8 chksum,
+static void init_dos_entry(struct dos_dentry_t *ep, u32 type, u32 start_clu);
+static void init_ext_entry(struct ext_dentry_t *ep, s32 order, u8 chksum,
 		    u16 *uniname);
-void init_file_entry(struct file_dentry_t *ep, u32 type);
-void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu,
+static void init_file_entry(struct file_dentry_t *ep, u32 type);
+static void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu,
 		     u64 size);
-void init_name_entry(struct name_dentry_t *ep, u16 *uniname);
-void fat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static void init_name_entry(struct name_dentry_t *ep, u16 *uniname);
+static void fat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			  s32 entry, s32 order, s32 num_entries);
-void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			    s32 entry, s32 order, s32 num_entries);
 
-s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
+static s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 		  sector_t *sector, s32 *offset);
-struct dentry_t *get_entry_with_sector(struct super_block *sb, sector_t sector,
+static struct dentry_t *get_entry_with_sector(struct super_block *sb, sector_t sector,
 				       s32 offset);
 struct dentry_t *get_entry_in_dir(struct super_block *sb, struct chain_t *p_dir,
 				  s32 entry, sector_t *sector);
@@ -877,27 +877,27 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 					       u32 type,
 					       struct dentry_t **file_ep);
 void release_entry_set(struct entry_set_cache_t *es);
-s32 write_whole_entry_set(struct super_block *sb, struct entry_set_cache_t *es);
-s32 write_partial_entries_in_entry_set(struct super_block *sb,
+static s32 write_whole_entry_set(struct super_block *sb, struct entry_set_cache_t *es);
+static s32 write_partial_entries_in_entry_set(struct super_block *sb,
 				       struct entry_set_cache_t *es,
 				       struct dentry_t *ep, u32 count);
-s32 search_deleted_or_unused_entry(struct super_block *sb,
+static s32 search_deleted_or_unused_entry(struct super_block *sb,
 				   struct chain_t *p_dir, s32 num_entries);
-s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir,
+static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir,
 		     s32 num_entries);
-s32 fat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static s32 fat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 		       struct uni_name_t *p_uniname, s32 num_entries,
 		       struct dos_name_t *p_dosname, u32 type);
-s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 struct uni_name_t *p_uniname, s32 num_entries,
 			 struct dos_name_t *p_dosname, u32 type);
-s32 fat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
+static s32 fat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
 			  s32 entry, struct dentry_t *p_entry);
-s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
+static s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
 			    s32 entry, struct dentry_t *p_entry);
 s32 count_dos_name_entries(struct super_block *sb, struct chain_t *p_dir,
 			   u32 type);
-void update_dir_checksum(struct super_block *sb, struct chain_t *p_dir,
+static void update_dir_checksum(struct super_block *sb, struct chain_t *p_dir,
 			 s32 entry);
 void update_dir_checksum_with_entry_set(struct super_block *sb,
 					struct entry_set_cache_t *es);
@@ -910,33 +910,33 @@ s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 void get_uni_name_from_dos_entry(struct super_block *sb,
 				 struct dos_dentry_t *ep,
 				 struct uni_name_t *p_uniname, u8 mode);
-void fat_get_uni_name_from_ext_entry(struct super_block *sb,
+static void fat_get_uni_name_from_ext_entry(struct super_block *sb,
 				     struct chain_t *p_dir, s32 entry,
 				     u16 *uniname);
-void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
+static void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
 				       struct chain_t *p_dir, s32 entry,
 				       u16 *uniname);
-s32 extract_uni_name_from_ext_entry(struct ext_dentry_t *ep,
+static s32 extract_uni_name_from_ext_entry(struct ext_dentry_t *ep,
 				    u16 *uniname, s32 order);
-s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep,
+static s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep,
 				     u16 *uniname, s32 order);
-s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
+static s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
 			  struct dos_name_t *p_dosname);
-void fat_attach_count_to_dos_name(u8 *dosname, s32 count);
-s32 fat_calc_num_entries(struct uni_name_t *p_uniname);
-s32 exfat_calc_num_entries(struct uni_name_t *p_uniname);
-u8 calc_checksum_1byte(void *data, s32 len, u8 chksum);
+static void fat_attach_count_to_dos_name(u8 *dosname, s32 count);
+static s32 fat_calc_num_entries(struct uni_name_t *p_uniname);
+static s32 exfat_calc_num_entries(struct uni_name_t *p_uniname);
+static u8 calc_checksum_1byte(void *data, s32 len, u8 chksum);
 u16 calc_checksum_2byte(void *data, s32 len, u16 chksum, s32 type);
-u32 calc_checksum_4byte(void *data, s32 len, u32 chksum, s32 type);
+static u32 calc_checksum_4byte(void *data, s32 len, u32 chksum, s32 type);
 
 /* name resolution functions */
 s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 		 struct uni_name_t *p_uniname);
-s32 resolve_name(u8 *name, u8 **arg);
+static s32 resolve_name(u8 *name, u8 **arg);
 
 /* file operation functions */
-s32 fat16_mount(struct super_block *sb, struct pbr_sector_t *p_pbr);
-s32 fat32_mount(struct super_block *sb, struct pbr_sector_t *p_pbr);
+static s32 fat16_mount(struct super_block *sb, struct pbr_sector_t *p_pbr);
+static s32 fat32_mount(struct super_block *sb, struct pbr_sector_t *p_pbr);
 s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr);
 s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	       struct uni_name_t *p_uniname, struct file_id_t *fid);
@@ -954,9 +954,9 @@ int sector_read(struct super_block *sb, sector_t sec,
 		struct buffer_head **bh, bool read);
 int sector_write(struct super_block *sb, sector_t sec,
 		 struct buffer_head *bh, bool sync);
-int multi_sector_read(struct super_block *sb, sector_t sec,
+static int multi_sector_read(struct super_block *sb, sector_t sec,
 		      struct buffer_head **bh, s32 num_secs, bool read);
-int multi_sector_write(struct super_block *sb, sector_t sec,
+static int multi_sector_write(struct super_block *sb, sector_t sec,
 		       struct buffer_head *bh, s32 num_secs, bool sync);
 
 void bdev_open(struct super_block *sb);
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 79174e5c4145..0260e4fe3762 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -120,7 +120,7 @@ void fs_set_vol_flags(struct super_block *sb, u32 new_flag)
 	}
 }
 
-void fs_error(struct super_block *sb)
+static void fs_error(struct super_block *sb)
 {
 	struct exfat_mount_options *opts = &EXFAT_SB(sb)->options;
 
@@ -136,7 +136,7 @@ void fs_error(struct super_block *sb)
  *  Cluster Management Functions
  */
 
-s32 clear_cluster(struct super_block *sb, u32 clu)
+static s32 clear_cluster(struct super_block *sb, u32 clu)
 {
 	sector_t s, n;
 	s32 ret = FFS_SUCCESS;
@@ -167,7 +167,7 @@ s32 clear_cluster(struct super_block *sb, u32 clu)
 	return ret;
 }
 
-s32 fat_alloc_cluster(struct super_block *sb, s32 num_alloc,
+static s32 fat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 		      struct chain_t *p_chain)
 {
 	int i, num_clusters = 0;
@@ -221,7 +221,7 @@ s32 fat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 	return num_clusters;
 }
 
-s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
+static s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 			struct chain_t *p_chain)
 {
 	s32 num_clusters = 0;
@@ -300,7 +300,7 @@ s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 	return num_clusters;
 }
 
-void fat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
+static void fat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 		      s32 do_relse)
 {
 	s32 num_clusters = 0;
@@ -341,7 +341,7 @@ void fat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 		p_fs->used_clusters -= num_clusters;
 }
 
-void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
+static void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 			s32 do_relse)
 {
 	s32 num_clusters = 0;
@@ -400,7 +400,7 @@ void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 		p_fs->used_clusters -= num_clusters;
 }
 
-u32 find_last_cluster(struct super_block *sb, struct chain_t *p_chain)
+static u32 find_last_cluster(struct super_block *sb, struct chain_t *p_chain)
 {
 	u32 clu, next;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -447,7 +447,7 @@ s32 count_num_clusters(struct super_block *sb, struct chain_t *p_chain)
 	return count;
 }
 
-s32 fat_count_used_clusters(struct super_block *sb)
+static s32 fat_count_used_clusters(struct super_block *sb)
 {
 	int i, count = 0;
 	u32 clu;
@@ -463,7 +463,7 @@ s32 fat_count_used_clusters(struct super_block *sb)
 	return count;
 }
 
-s32 exfat_count_used_clusters(struct super_block *sb)
+static s32 exfat_count_used_clusters(struct super_block *sb)
 {
 	int i, map_i, map_b, count = 0;
 	u8 k;
@@ -589,7 +589,7 @@ void free_alloc_bitmap(struct super_block *sb)
 	p_fs->vol_amap = NULL;
 }
 
-s32 set_alloc_bitmap(struct super_block *sb, u32 clu)
+static s32 set_alloc_bitmap(struct super_block *sb, u32 clu)
 {
 	int i, b;
 	sector_t sector;
@@ -606,7 +606,7 @@ s32 set_alloc_bitmap(struct super_block *sb, u32 clu)
 	return sector_write(sb, sector, p_fs->vol_amap[i], 0);
 }
 
-s32 clr_alloc_bitmap(struct super_block *sb, u32 clu)
+static s32 clr_alloc_bitmap(struct super_block *sb, u32 clu)
 {
 	int i, b;
 	sector_t sector;
@@ -640,7 +640,7 @@ s32 clr_alloc_bitmap(struct super_block *sb, u32 clu)
 #endif /* CONFIG_EXFAT_DISCARD */
 }
 
-u32 test_alloc_bitmap(struct super_block *sb, u32 clu)
+static u32 test_alloc_bitmap(struct super_block *sb, u32 clu)
 {
 	int i, map_i, map_b;
 	u32 clu_base, clu_free;
@@ -680,7 +680,7 @@ u32 test_alloc_bitmap(struct super_block *sb, u32 clu)
 	return CLUSTER_32(~0);
 }
 
-void sync_alloc_bitmap(struct super_block *sb)
+static void sync_alloc_bitmap(struct super_block *sb)
 {
 	int i;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -906,7 +906,7 @@ void free_upcase_table(struct super_block *sb)
  *  Directory Entry Management Functions
  */
 
-u32 fat_get_entry_type(struct dentry_t *p_entry)
+static u32 fat_get_entry_type(struct dentry_t *p_entry)
 {
 	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
 
@@ -928,7 +928,7 @@ u32 fat_get_entry_type(struct dentry_t *p_entry)
 	return TYPE_FILE;
 }
 
-u32 exfat_get_entry_type(struct dentry_t *p_entry)
+static u32 exfat_get_entry_type(struct dentry_t *p_entry)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
 
@@ -973,7 +973,7 @@ u32 exfat_get_entry_type(struct dentry_t *p_entry)
 	return TYPE_BENIGN_SEC;
 }
 
-void fat_set_entry_type(struct dentry_t *p_entry, u32 type)
+static void fat_set_entry_type(struct dentry_t *p_entry, u32 type)
 {
 	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
 
@@ -996,7 +996,7 @@ void fat_set_entry_type(struct dentry_t *p_entry, u32 type)
 		ep->attr = ATTR_ARCHIVE | ATTR_SYMLINK;
 }
 
-void exfat_set_entry_type(struct dentry_t *p_entry, u32 type)
+static void exfat_set_entry_type(struct dentry_t *p_entry, u32 type)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
 
@@ -1026,58 +1026,58 @@ void exfat_set_entry_type(struct dentry_t *p_entry, u32 type)
 	}
 }
 
-u32 fat_get_entry_attr(struct dentry_t *p_entry)
+static u32 fat_get_entry_attr(struct dentry_t *p_entry)
 {
 	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
 
 	return (u32)ep->attr;
 }
 
-u32 exfat_get_entry_attr(struct dentry_t *p_entry)
+static u32 exfat_get_entry_attr(struct dentry_t *p_entry)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
 
 	return (u32)GET16_A(ep->attr);
 }
 
-void fat_set_entry_attr(struct dentry_t *p_entry, u32 attr)
+static void fat_set_entry_attr(struct dentry_t *p_entry, u32 attr)
 {
 	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
 
 	ep->attr = (u8)attr;
 }
 
-void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr)
+static void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
 
 	SET16_A(ep->attr, (u16)attr);
 }
 
-u8 fat_get_entry_flag(struct dentry_t *p_entry)
+static u8 fat_get_entry_flag(struct dentry_t *p_entry)
 {
 	return 0x01;
 }
 
-u8 exfat_get_entry_flag(struct dentry_t *p_entry)
+static u8 exfat_get_entry_flag(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	return ep->flags;
 }
 
-void fat_set_entry_flag(struct dentry_t *p_entry, u8 flags)
+static void fat_set_entry_flag(struct dentry_t *p_entry, u8 flags)
 {
 }
 
-void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flags)
+static void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flags)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	ep->flags = flags;
 }
 
-u32 fat_get_entry_clu0(struct dentry_t *p_entry)
+static u32 fat_get_entry_clu0(struct dentry_t *p_entry)
 {
 	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
 
@@ -1085,14 +1085,14 @@ u32 fat_get_entry_clu0(struct dentry_t *p_entry)
 		GET16_A(ep->start_clu_lo);
 }
 
-u32 exfat_get_entry_clu0(struct dentry_t *p_entry)
+static u32 exfat_get_entry_clu0(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	return GET32_A(ep->start_clu);
 }
 
-void fat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
+static void fat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
 {
 	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
 
@@ -1100,35 +1100,35 @@ void fat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
 	SET16_A(ep->start_clu_hi, CLUSTER_16(start_clu >> 16));
 }
 
-void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
+static void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	SET32_A(ep->start_clu, start_clu);
 }
 
-u64 fat_get_entry_size(struct dentry_t *p_entry)
+static u64 fat_get_entry_size(struct dentry_t *p_entry)
 {
 	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
 
 	return (u64)GET32_A(ep->size);
 }
 
-u64 exfat_get_entry_size(struct dentry_t *p_entry)
+static u64 exfat_get_entry_size(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	return GET64_A(ep->valid_size);
 }
 
-void fat_set_entry_size(struct dentry_t *p_entry, u64 size)
+static void fat_set_entry_size(struct dentry_t *p_entry, u64 size)
 {
 	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
 
 	SET32_A(ep->size, (u32)size);
 }
 
-void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
+static void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
@@ -1136,7 +1136,7 @@ void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
 	SET64_A(ep->size, size);
 }
 
-void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
+static void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			u8 mode)
 {
 	u16 t = 0x00, d = 0x21;
@@ -1161,7 +1161,7 @@ void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 	tp->year = (d >> 9);
 }
 
-void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
+static void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode)
 {
 	u16 t = 0x00, d = 0x21;
@@ -1190,7 +1190,7 @@ void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 	tp->year = (d >> 9);
 }
 
-void fat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
+static void fat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			u8 mode)
 {
 	u16 t, d;
@@ -1211,7 +1211,7 @@ void fat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 	}
 }
 
-void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
+static void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode)
 {
 	u16 t, d;
@@ -1236,7 +1236,7 @@ void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 	}
 }
 
-s32 fat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir, s32 entry,
+static s32 fat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 		       u32 type, u32 start_clu, u64 size)
 {
 	sector_t sector;
@@ -1253,7 +1253,7 @@ s32 fat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 	return FFS_SUCCESS;
 }
 
-s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 s32 entry, u32 type, u32 start_clu, u64 size)
 {
 	sector_t sector;
@@ -1380,7 +1380,7 @@ static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 	return FFS_SUCCESS;
 }
 
-void init_dos_entry(struct dos_dentry_t *ep, u32 type, u32 start_clu)
+static void init_dos_entry(struct dos_dentry_t *ep, u32 type, u32 start_clu)
 {
 	struct timestamp_t tm, *tp;
 
@@ -1396,7 +1396,7 @@ void init_dos_entry(struct dos_dentry_t *ep, u32 type, u32 start_clu)
 	ep->create_time_ms = 0;
 }
 
-void init_ext_entry(struct ext_dentry_t *ep, s32 order, u8 chksum, u16 *uniname)
+static void init_ext_entry(struct ext_dentry_t *ep, s32 order, u8 chksum, u16 *uniname)
 {
 	int i;
 	bool end = false;
@@ -1444,7 +1444,7 @@ void init_ext_entry(struct ext_dentry_t *ep, s32 order, u8 chksum, u16 *uniname)
 	}
 }
 
-void init_file_entry(struct file_dentry_t *ep, u32 type)
+static void init_file_entry(struct file_dentry_t *ep, u32 type)
 {
 	struct timestamp_t tm, *tp;
 
@@ -1459,7 +1459,7 @@ void init_file_entry(struct file_dentry_t *ep, u32 type)
 	ep->access_time_ms = 0;
 }
 
-void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu, u64 size)
+static void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu, u64 size)
 {
 	exfat_set_entry_type((struct dentry_t *)ep, TYPE_STREAM);
 	ep->flags = flags;
@@ -1468,7 +1468,7 @@ void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu, u64 size
 	SET64_A(ep->size, size);
 }
 
-void init_name_entry(struct name_dentry_t *ep, u16 *uniname)
+static void init_name_entry(struct name_dentry_t *ep, u16 *uniname)
 {
 	int i;
 
@@ -1483,7 +1483,7 @@ void init_name_entry(struct name_dentry_t *ep, u16 *uniname)
 	}
 }
 
-void fat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static void fat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 		s32 entry, s32 order, s32 num_entries)
 {
 	int i;
@@ -1501,7 +1501,7 @@ void fat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 	}
 }
 
-void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 		s32 entry, s32 order, s32 num_entries)
 {
 	int i;
@@ -1519,7 +1519,7 @@ void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 	}
 }
 
-void update_dir_checksum(struct super_block *sb, struct chain_t *p_dir,
+static void update_dir_checksum(struct super_block *sb, struct chain_t *p_dir,
 			 s32 entry)
 {
 	int i, num_entries;
@@ -1601,7 +1601,7 @@ static s32 _walk_fat_chain(struct super_block *sb, struct chain_t *p_dir,
 	return FFS_SUCCESS;
 }
 
-s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
+static s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 		  sector_t *sector, s32 *offset)
 {
 	s32 off, ret;
@@ -1633,7 +1633,7 @@ s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 	return FFS_SUCCESS;
 }
 
-struct dentry_t *get_entry_with_sector(struct super_block *sb, sector_t sector,
+static struct dentry_t *get_entry_with_sector(struct super_block *sb, sector_t sector,
 				       s32 offset)
 {
 	u8 *buf;
@@ -1910,7 +1910,7 @@ static s32 __write_partial_entries_in_entry_set(struct super_block *sb,
 }
 
 /* write back all entries in entry set */
-s32 write_whole_entry_set(struct super_block *sb, struct entry_set_cache_t *es)
+static s32 write_whole_entry_set(struct super_block *sb, struct entry_set_cache_t *es)
 {
 	return __write_partial_entries_in_entry_set(sb, es, es->sector,
 						    es->offset,
@@ -1918,7 +1918,7 @@ s32 write_whole_entry_set(struct super_block *sb, struct entry_set_cache_t *es)
 }
 
 /* write back some entries in entry set */
-s32 write_partial_entries_in_entry_set(struct super_block *sb,
+static s32 write_partial_entries_in_entry_set(struct super_block *sb,
 	struct entry_set_cache_t *es, struct dentry_t *ep, u32 count)
 {
 	s32 ret, byte_offset, off;
@@ -1957,7 +1957,7 @@ s32 write_partial_entries_in_entry_set(struct super_block *sb,
 }
 
 /* search EMPTY CONTINUOUS "num_entries" entries */
-s32 search_deleted_or_unused_entry(struct super_block *sb,
+static s32 search_deleted_or_unused_entry(struct super_block *sb,
 				   struct chain_t *p_dir, s32 num_entries)
 {
 	int i, dentry, num_empty = 0;
@@ -2051,7 +2051,7 @@ s32 search_deleted_or_unused_entry(struct super_block *sb,
 	return -1;
 }
 
-s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries)
+static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries)
 {
 	s32 ret, dentry;
 	u32 last_clu;
@@ -2142,7 +2142,7 @@ s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries
  * -1 : (root dir, ".") it is the root dir itself
  * -2 : entry with the name does not exist
  */
-s32 fat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static s32 fat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 		       struct uni_name_t *p_uniname, s32 num_entries,
 		       struct dos_name_t *p_dosname, u32 type)
 {
@@ -2240,7 +2240,7 @@ s32 fat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
  * -1 : (root dir, ".") it is the root dir itself
  * -2 : entry with the name does not exist
  */
-s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 struct uni_name_t *p_uniname, s32 num_entries,
 			 struct dos_name_t *p_dosname, u32 type)
 {
@@ -2383,7 +2383,7 @@ s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 	return -2;
 }
 
-s32 fat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
+static s32 fat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
 			  s32 entry, struct dentry_t *p_entry)
 {
 	s32 count = 0;
@@ -2413,7 +2413,7 @@ s32 fat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
 	return count;
 }
 
-s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
+static s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
 			    s32 entry, struct dentry_t *p_entry)
 {
 	int i, count = 0;
@@ -2614,7 +2614,7 @@ void get_uni_name_from_dos_entry(struct super_block *sb,
 	nls_dosname_to_uniname(sb, p_uniname, &dos_name);
 }
 
-void fat_get_uni_name_from_ext_entry(struct super_block *sb,
+static void fat_get_uni_name_from_ext_entry(struct super_block *sb,
 				     struct chain_t *p_dir, s32 entry,
 				     u16 *uniname)
 {
@@ -2641,7 +2641,7 @@ void fat_get_uni_name_from_ext_entry(struct super_block *sb,
 	}
 }
 
-void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
+static void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
 				       struct chain_t *p_dir, s32 entry,
 				       u16 *uniname)
 {
@@ -2678,7 +2678,7 @@ void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
 	release_entry_set(es);
 }
 
-s32 extract_uni_name_from_ext_entry(struct ext_dentry_t *ep, u16 *uniname,
+static s32 extract_uni_name_from_ext_entry(struct ext_dentry_t *ep, u16 *uniname,
 				    s32 order)
 {
 	int i, len = 0;
@@ -2723,7 +2723,7 @@ s32 extract_uni_name_from_ext_entry(struct ext_dentry_t *ep, u16 *uniname,
 	return len;
 }
 
-s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *uniname,
+static s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *uniname,
 				     s32 order)
 {
 	int i, len = 0;
@@ -2740,7 +2740,7 @@ s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *uniname,
 	return len;
 }
 
-s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
+static s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
 			  struct dos_name_t *p_dosname)
 {
 	int i, j, count = 0;
@@ -2835,7 +2835,7 @@ s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
 	return FFS_SUCCESS;
 }
 
-void fat_attach_count_to_dos_name(u8 *dosname, s32 count)
+static void fat_attach_count_to_dos_name(u8 *dosname, s32 count)
 {
 	int i, j, length;
 	char str_count[6];
@@ -2862,7 +2862,7 @@ void fat_attach_count_to_dos_name(u8 *dosname, s32 count)
 		dosname[7] = ' ';
 }
 
-s32 fat_calc_num_entries(struct uni_name_t *p_uniname)
+static s32 fat_calc_num_entries(struct uni_name_t *p_uniname)
 {
 	s32 len;
 
@@ -2874,7 +2874,7 @@ s32 fat_calc_num_entries(struct uni_name_t *p_uniname)
 	return (len - 1) / 13 + 2;
 }
 
-s32 exfat_calc_num_entries(struct uni_name_t *p_uniname)
+static s32 exfat_calc_num_entries(struct uni_name_t *p_uniname)
 {
 	s32 len;
 
@@ -2886,7 +2886,7 @@ s32 exfat_calc_num_entries(struct uni_name_t *p_uniname)
 	return (len - 1) / 15 + 3;
 }
 
-u8 calc_checksum_1byte(void *data, s32 len, u8 chksum)
+static u8 calc_checksum_1byte(void *data, s32 len, u8 chksum)
 {
 	int i;
 	u8 *c = (u8 *)data;
@@ -2921,7 +2921,7 @@ u16 calc_checksum_2byte(void *data, s32 len, u16 chksum, s32 type)
 	return chksum;
 }
 
-u32 calc_checksum_4byte(void *data, s32 len, u32 chksum, s32 type)
+static u32 calc_checksum_4byte(void *data, s32 len, u32 chksum, s32 type)
 {
 	int i;
 	u8 *c = (u8 *)data;
@@ -3007,7 +3007,7 @@ static struct fs_func fat_fs_func = {
 	.set_entry_time = fat_set_entry_time,
 };
 
-s32 fat16_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
+static s32 fat16_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 {
 	s32 num_reserved, num_root_sectors;
 	struct bpb16_t *p_bpb = (struct bpb16_t *)p_pbr->bpb;
@@ -3069,7 +3069,7 @@ s32 fat16_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 	return FFS_SUCCESS;
 }
 
-s32 fat32_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
+static s32 fat32_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 {
 	s32 num_reserved;
 	struct bpb32_t *p_bpb = (struct bpb32_t *)p_pbr->bpb;
@@ -3649,7 +3649,7 @@ int sector_write(struct super_block *sb, sector_t sec, struct buffer_head *bh,
 	return ret;
 }
 
-int multi_sector_read(struct super_block *sb, sector_t sec,
+static int multi_sector_read(struct super_block *sb, sector_t sec,
 		      struct buffer_head **bh, s32 num_secs, bool read)
 {
 	s32 ret = FFS_MEDIAERR;
@@ -3672,7 +3672,7 @@ int multi_sector_read(struct super_block *sb, sector_t sec,
 	return ret;
 }
 
-int multi_sector_write(struct super_block *sb, sector_t sec,
+static int multi_sector_write(struct super_block *sb, sector_t sec,
 		       struct buffer_head *bh, s32 num_secs, bool sync)
 {
 	s32 ret = FFS_MEDIAERR;
-- 
2.23.0

