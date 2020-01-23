Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E801465BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 11:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgAWK1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 05:27:00 -0500
Received: from mx05.melco.co.jp ([192.218.140.145]:40735 "EHLO
        mx05.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgAWK1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:27:00 -0500
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id 102CC3A4468;
        Thu, 23 Jan 2020 19:26:52 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 483JNW6ydKzRk1F;
        Thu, 23 Jan 2020 19:26:51 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr05.melco.co.jp (Postfix) with ESMTP id 483JNW6f02zRjtp;
        Thu, 23 Jan 2020 19:26:51 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 483JNW6qZNzRk1c;
        Thu, 23 Jan 2020 19:26:51 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf03.melco.co.jp (Postfix) with ESMTP id 483JNW62NwzRjxB;
        Thu, 23 Jan 2020 19:26:51 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 00NAQpZp018360;
        Thu, 23 Jan 2020 19:26:51 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 9580817E075;
        Thu, 23 Jan 2020 19:26:51 +0900 (JST)
Received: from tux554.tad.melco.co.jp (tux100.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id 893D617E073;
        Thu, 23 Jan 2020 19:26:51 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 00NAQpNr030556;
        Thu, 23 Jan 2020 19:26:51 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp,
        Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp
Subject: [PATCH v3] staging: exfat: remove fs_func struct.
Date:   Thu, 23 Jan 2020 19:24:45 +0900
Message-Id: <20200123102445.123033-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Tetsuhiro Kohada" <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>

Remove 'fs_func struct' and change indirect calls to direct calls.

The following issues are described in exfat's TODO.
> Create helper function for exfat_set_entry_time () and
> exfat_set_entry_type () because it's sort of ugly to be calling the same functionn directly and other code calling through  the fs_func struc ponters ...

The fs_func struct was used for switching the helper functions of fat16/fat32/exfat.
Now, it has lost the role of switching, just making the code less readable.

Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
Changes in v3:
- Add patch versions.

Changes in v2:
- Rebase to the 'linux-next' tree.
- Change signature to full name.

 drivers/staging/exfat/exfat.h       |  79 +++++-----
 drivers/staging/exfat/exfat_core.c  | 214 +++++++++++-----------------
 drivers/staging/exfat/exfat_super.c | 119 ++++++++--------
 3 files changed, 178 insertions(+), 234 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 3865c17027..4d87360fab 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -516,49 +516,6 @@ struct buf_cache_t {
 	struct buffer_head   *buf_bh;
 };
 
-struct fs_func {
-	s32	(*alloc_cluster)(struct super_block *sb, s32 num_alloc,
-				 struct chain_t *p_chain);
-	void	(*free_cluster)(struct super_block *sb, struct chain_t *p_chain,
-				s32 do_relse);
-	s32	(*count_used_clusters)(struct super_block *sb);
-
-	s32	(*init_dir_entry)(struct super_block *sb, struct chain_t *p_dir,
-				  s32 entry, u32 type, u32 start_clu, u64 size);
-	s32	(*init_ext_entry)(struct super_block *sb, struct chain_t *p_dir,
-				  s32 entry, s32 num_entries,
-				  struct uni_name_t *p_uniname,
-				  struct dos_name_t *p_dosname);
-	s32	(*find_dir_entry)(struct super_block *sb, struct chain_t *p_dir,
-				  struct uni_name_t *p_uniname, s32 num_entries,
-				  struct dos_name_t *p_dosname, u32 type);
-	void	(*delete_dir_entry)(struct super_block *sb,
-				    struct chain_t *p_dir, s32 entry,
-				    s32 offset, s32 num_entries);
-	void	(*get_uni_name_from_ext_entry)(struct super_block *sb,
-					       struct chain_t *p_dir, s32 entry,
-					       u16 *uniname);
-	s32	(*count_ext_entries)(struct super_block *sb,
-				     struct chain_t *p_dir, s32 entry,
-				     struct dentry_t *p_entry);
-	s32	(*calc_num_entries)(struct uni_name_t *p_uniname);
-
-	u32	(*get_entry_type)(struct dentry_t *p_entry);
-	void	(*set_entry_type)(struct dentry_t *p_entry, u32 type);
-	u32	(*get_entry_attr)(struct dentry_t *p_entry);
-	void	(*set_entry_attr)(struct dentry_t *p_entry, u32 attr);
-	u8	(*get_entry_flag)(struct dentry_t *p_entry);
-	void	(*set_entry_flag)(struct dentry_t *p_entry, u8 flag);
-	u32	(*get_entry_clu0)(struct dentry_t *p_entry);
-	void	(*set_entry_clu0)(struct dentry_t *p_entry, u32 clu0);
-	u64	(*get_entry_size)(struct dentry_t *p_entry);
-	void	(*set_entry_size)(struct dentry_t *p_entry, u64 size);
-	void	(*get_entry_time)(struct dentry_t *p_entry,
-				  struct timestamp_t *tp, u8 mode);
-	void	(*set_entry_time)(struct dentry_t *p_entry,
-				  struct timestamp_t *tp, u8 mode);
-};
-
 struct fs_info_t {
 	u32      drv;                    /* drive ID */
 	u32      vol_type;               /* volume FAT type */
@@ -597,7 +554,6 @@ struct fs_info_t {
 
 	u32 dev_ejected;	/* block device operation error flag */
 
-	struct fs_func *fs_func;
 	struct mutex v_mutex;
 
 	/* FAT cache */
@@ -829,5 +785,40 @@ int exfat_bdev_write(struct super_block *sb, sector_t secno,
 	       struct buffer_head *bh, u32 num_secs, bool sync);
 int exfat_bdev_sync(struct super_block *sb);
 
+/* cluster operation functions */
+s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
+			struct chain_t *p_chain);
+void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
+			s32 do_relse);
+s32 exfat_count_used_clusters(struct super_block *sb);
+
+/* dir operation functions */
+s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+			 struct uni_name_t *p_uniname, s32 num_entries,
+			 struct dos_name_t *p_dosname, u32 type);
+void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+			    s32 entry, s32 order, s32 num_entries);
+void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
+				       struct chain_t *p_dir, s32 entry,
+				       u16 *uniname);
+s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
+			    s32 entry, struct dentry_t *p_entry);
+s32 exfat_calc_num_entries(struct uni_name_t *p_uniname);
+
+/* dir entry getter/setter */
+u32 exfat_get_entry_type(struct dentry_t *p_entry);
+u32 exfat_get_entry_attr(struct dentry_t *p_entry);
+void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr);
+u8 exfat_get_entry_flag(struct dentry_t *p_entry);
+void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flags);
+u32 exfat_get_entry_clu0(struct dentry_t *p_entry);
+void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu);
+u64 exfat_get_entry_size(struct dentry_t *p_entry);
+void exfat_set_entry_size(struct dentry_t *p_entry, u64 size);
+void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
+			  u8 mode);
+void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
+			  u8 mode);
+
 extern const u8 uni_upcase[];
 #endif /* _EXFAT_H */
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 36a4102c05..07b460d013 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -249,8 +249,8 @@ static u32 test_alloc_bitmap(struct super_block *sb, u32 clu)
 	return CLUSTER_32(~0);
 }
 
-static s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
-			       struct chain_t *p_chain)
+s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
+			struct chain_t *p_chain)
 {
 	s32 num_clusters = 0;
 	u32 hint_clu, new_clu, last_clu = CLUSTER_32(~0);
@@ -328,8 +328,8 @@ static s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 	return num_clusters;
 }
 
-static void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
-			       s32 do_relse)
+void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
+			s32 do_relse)
 {
 	s32 num_clusters = 0;
 	u32 clu;
@@ -434,7 +434,7 @@ s32 count_num_clusters(struct super_block *sb, struct chain_t *p_chain)
 	return count;
 }
 
-static s32 exfat_count_used_clusters(struct super_block *sb)
+s32 exfat_count_used_clusters(struct super_block *sb)
 {
 	int i, map_i, map_b, count = 0;
 	u8 k;
@@ -499,7 +499,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 			if (!ep)
 				return -ENOENT;
 
-			type = p_fs->fs_func->get_entry_type((struct dentry_t *)ep);
+			type = exfat_get_entry_type((struct dentry_t *)ep);
 
 			if (type == TYPE_UNUSED)
 				break;
@@ -745,7 +745,7 @@ s32 load_upcase_table(struct super_block *sb)
 			if (!ep)
 				return -ENOENT;
 
-			type = p_fs->fs_func->get_entry_type((struct dentry_t *)ep);
+			type = exfat_get_entry_type((struct dentry_t *)ep);
 
 			if (type == TYPE_UNUSED)
 				break;
@@ -787,7 +787,7 @@ void free_upcase_table(struct super_block *sb)
  *  Directory Entry Management Functions
  */
 
-static u32 exfat_get_entry_type(struct dentry_t *p_entry)
+u32 exfat_get_entry_type(struct dentry_t *p_entry)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
 
@@ -862,56 +862,56 @@ static void exfat_set_entry_type(struct dentry_t *p_entry, u32 type)
 	}
 }
 
-static u32 exfat_get_entry_attr(struct dentry_t *p_entry)
+u32 exfat_get_entry_attr(struct dentry_t *p_entry)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
 
 	return (u32)GET16_A(ep->attr);
 }
 
-static void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr)
+void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
 
 	SET16_A(ep->attr, (u16)attr);
 }
 
-static u8 exfat_get_entry_flag(struct dentry_t *p_entry)
+u8 exfat_get_entry_flag(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	return ep->flags;
 }
 
-static void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flags)
+void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flags)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	ep->flags = flags;
 }
 
-static u32 exfat_get_entry_clu0(struct dentry_t *p_entry)
+u32 exfat_get_entry_clu0(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	return GET32_A(ep->start_clu);
 }
 
-static void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
+void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	SET32_A(ep->start_clu, start_clu);
 }
 
-static u64 exfat_get_entry_size(struct dentry_t *p_entry)
+u64 exfat_get_entry_size(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	return GET64_A(ep->valid_size);
 }
 
-static void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
+void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
@@ -919,8 +919,8 @@ static void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
 	SET64_A(ep->size, size);
 }
 
-static void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-				 u8 mode)
+void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
+			  u8 mode)
 {
 	u16 t = 0x00, d = 0x21;
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
@@ -948,8 +948,8 @@ static void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *t
 	tp->year = (d >> 9);
 }
 
-static void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-				 u8 mode)
+void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
+			  u8 mode)
 {
 	u16 t, d;
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
@@ -1088,20 +1088,19 @@ static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 	return 0;
 }
 
-static void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-				   s32 entry, s32 order, s32 num_entries)
+void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+			    s32 entry, s32 order, s32 num_entries)
 {
 	int i;
 	sector_t sector;
 	struct dentry_t *ep;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
 	for (i = order; i < num_entries; i++) {
 		ep = get_entry_in_dir(sb, p_dir, entry + i, &sector);
 		if (!ep)
 			return;
 
-		p_fs->fs_func->set_entry_type(ep, TYPE_DELETED);
+		exfat_set_entry_type(ep, TYPE_DELETED);
 		exfat_buf_modify(sb, sector);
 	}
 }
@@ -1366,7 +1365,7 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 		goto err_out;
 
 	ep = (struct dentry_t *)(buf + off);
-	entry_type = p_fs->fs_func->get_entry_type(ep);
+	entry_type = exfat_get_entry_type(ep);
 
 	if ((entry_type != TYPE_FILE) && (entry_type != TYPE_DIR))
 		goto err_out;
@@ -1396,7 +1395,7 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 		 * instead of copying whole sector, we will check every entry.
 		 * this will provide minimum stablity and consistency.
 		 */
-		entry_type = p_fs->fs_func->get_entry_type(ep);
+		entry_type = exfat_get_entry_type(ep);
 
 		if ((entry_type == TYPE_UNUSED) || (entry_type == TYPE_DELETED))
 			goto err_out;
@@ -1540,7 +1539,7 @@ static s32 search_deleted_or_unused_entry(struct super_block *sb,
 			if (!ep)
 				return -1;
 
-			type = p_fs->fs_func->get_entry_type(ep);
+			type = exfat_get_entry_type(ep);
 
 			if (type == TYPE_UNUSED) {
 				num_empty++;
@@ -1614,7 +1613,7 @@ static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_
 		clu.flags = p_dir->flags;
 
 		/* (1) allocate a cluster */
-		ret = p_fs->fs_func->alloc_cluster(sb, 1, &clu);
+		ret = exfat_alloc_cluster(sb, 1, &clu);
 		if (ret < 1)
 			return -EIO;
 
@@ -1650,8 +1649,8 @@ static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_
 					      fid->entry + 1, &sector);
 			if (!ep)
 				return -ENOENT;
-			p_fs->fs_func->set_entry_size(ep, size);
-			p_fs->fs_func->set_entry_flag(ep, p_dir->flags);
+			exfat_set_entry_size(ep, size);
+			exfat_set_entry_flag(ep, p_dir->flags);
 			exfat_buf_modify(sb, sector);
 
 			update_dir_checksum(sb, &fid->dir,
@@ -1690,9 +1689,9 @@ static s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *unina
  * -1 : (root dir, ".") it is the root dir itself
  * -2 : entry with the name does not exist
  */
-static s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-				struct uni_name_t *p_uniname, s32 num_entries,
-				struct dos_name_t *p_dosname, u32 type)
+s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+			 struct uni_name_t *p_uniname, s32 num_entries,
+			 struct dos_name_t *p_dosname, u32 type)
 {
 	int i = 0, dentry = 0, num_ext_entries = 0, len, step;
 	s32 order = 0;
@@ -1736,7 +1735,7 @@ static s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			if (!ep)
 				return -2;
 
-			entry_type = p_fs->fs_func->get_entry_type(ep);
+			entry_type = exfat_get_entry_type(ep);
 			step = 1;
 
 			if ((entry_type == TYPE_UNUSED) || (entry_type == TYPE_DELETED)) {
@@ -1833,21 +1832,20 @@ static s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 	return -2;
 }
 
-static s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
-				   s32 entry, struct dentry_t *p_entry)
+s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
+			    s32 entry, struct dentry_t *p_entry)
 {
 	int i, count = 0;
 	u32 type;
 	struct file_dentry_t *file_ep = (struct file_dentry_t *)p_entry;
 	struct dentry_t *ext_ep;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
 	for (i = 0, entry++; i < file_ep->num_ext; i++, entry++) {
 		ext_ep = get_entry_in_dir(sb, p_dir, entry, NULL);
 		if (!ext_ep)
 			return -1;
 
-		type = p_fs->fs_func->get_entry_type(ext_ep);
+		type = exfat_get_entry_type(ext_ep);
 		if ((type == TYPE_EXTEND) || (type == TYPE_STREAM))
 			count++;
 		else
@@ -1885,7 +1883,7 @@ s32 count_dos_name_entries(struct super_block *sb, struct chain_t *p_dir,
 			if (!ep)
 				return -ENOENT;
 
-			entry_type = p_fs->fs_func->get_entry_type(ep);
+			entry_type = exfat_get_entry_type(ep);
 
 			if (entry_type == TYPE_UNUSED)
 				return count;
@@ -1941,7 +1939,7 @@ bool is_dir_empty(struct super_block *sb, struct chain_t *p_dir)
 			if (!ep)
 				break;
 
-			type = p_fs->fs_func->get_entry_type(ep);
+			type = exfat_get_entry_type(ep);
 
 			if (type == TYPE_UNUSED)
 				return true;
@@ -1985,9 +1983,8 @@ s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 				 struct dos_name_t *p_dosname)
 {
 	s32 num_entries;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	num_entries = p_fs->fs_func->calc_num_entries(p_uniname);
+	num_entries = exfat_calc_num_entries(p_uniname);
 	if (num_entries == 0)
 		return -EINVAL;
 
@@ -1996,14 +1993,13 @@ s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 	return 0;
 }
 
-static void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
-					      struct chain_t *p_dir, s32 entry,
-					      u16 *uniname)
+void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
+				       struct chain_t *p_dir, s32 entry,
+				       u16 *uniname)
 {
 	int i;
 	struct dentry_t *ep;
 	struct entry_set_cache_t *es;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
 	es = get_entry_set_in_dir(sb, p_dir, entry, ES_ALL_ENTRIES, &ep);
 	if (!es || es->num_entries < 3) {
@@ -2021,7 +2017,7 @@ static void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
 	 * So, the index of first file-name dentry should start from 2.
 	 */
 	for (i = 2; i < es->num_entries; i++, ep++) {
-		if (p_fs->fs_func->get_entry_type(ep) == TYPE_EXTEND)
+		if (exfat_get_entry_type(ep) == TYPE_EXTEND)
 			extract_uni_name_from_name_entry((struct name_dentry_t *)
 							 ep, uniname, i);
 		else
@@ -2033,7 +2029,7 @@ static void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
 	release_entry_set(es);
 }
 
-static s32 exfat_calc_num_entries(struct uni_name_t *p_uniname)
+s32 exfat_calc_num_entries(struct uni_name_t *p_uniname)
 {
 	s32 len;
 
@@ -2101,36 +2097,6 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 	return 0;
 }
 
-/*
- *  File Operation Functions
- */
-static struct fs_func exfat_fs_func = {
-	.alloc_cluster = exfat_alloc_cluster,
-	.free_cluster = exfat_free_cluster,
-	.count_used_clusters = exfat_count_used_clusters,
-
-	.init_dir_entry = exfat_init_dir_entry,
-	.init_ext_entry = exfat_init_ext_entry,
-	.find_dir_entry = exfat_find_dir_entry,
-	.delete_dir_entry = exfat_delete_dir_entry,
-	.get_uni_name_from_ext_entry = exfat_get_uni_name_from_ext_entry,
-	.count_ext_entries = exfat_count_ext_entries,
-	.calc_num_entries = exfat_calc_num_entries,
-
-	.get_entry_type = exfat_get_entry_type,
-	.set_entry_type = exfat_set_entry_type,
-	.get_entry_attr = exfat_get_entry_attr,
-	.set_entry_attr = exfat_set_entry_attr,
-	.get_entry_flag = exfat_get_entry_flag,
-	.set_entry_flag = exfat_set_entry_flag,
-	.get_entry_clu0 = exfat_get_entry_clu0,
-	.set_entry_clu0 = exfat_set_entry_clu0,
-	.get_entry_size = exfat_get_entry_size,
-	.set_entry_size = exfat_set_entry_size,
-	.get_entry_time = exfat_get_entry_time,
-	.set_entry_time = exfat_set_entry_time,
-};
-
 s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 {
 	struct bpbex_t *p_bpb = (struct bpbex_t *)p_pbr->bpb;
@@ -2174,8 +2140,6 @@ s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 	p_fs->clu_srch_ptr = 2;
 	p_fs->used_clusters = UINT_MAX;
 
-	p_fs->fs_func = &exfat_fs_func;
-
 	return 0;
 }
 
@@ -2188,7 +2152,6 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	struct dos_name_t dos_name;
 	struct super_block *sb = inode->i_sb;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct fs_func *fs_func = p_fs->fs_func;
 
 	ret = get_num_entries_and_dos_name(sb, p_dir, p_uniname, &num_entries,
 					   &dos_name);
@@ -2205,7 +2168,7 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	clu.flags = (p_fs->vol_type == EXFAT) ? 0x03 : 0x01;
 
 	/* (1) allocate a cluster */
-	ret = fs_func->alloc_cluster(sb, 1, &clu);
+	ret = exfat_alloc_cluster(sb, 1, &clu);
 	if (ret < 0)
 		return ret;
 	else if (ret == 0)
@@ -2219,13 +2182,13 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 
 	/* (2) update the directory entry */
 	/* make sub-dir entry in parent directory */
-	ret = fs_func->init_dir_entry(sb, p_dir, dentry, TYPE_DIR, clu.dir,
-				      size);
+	ret = exfat_init_dir_entry(sb, p_dir, dentry, TYPE_DIR, clu.dir,
+				   size);
 	if (ret != 0)
 		return ret;
 
-	ret = fs_func->init_ext_entry(sb, p_dir, dentry, num_entries, p_uniname,
-				      &dos_name);
+	ret = exfat_init_ext_entry(sb, p_dir, dentry, num_entries, p_uniname,
+				   &dos_name);
 	if (ret != 0)
 		return ret;
 
@@ -2253,7 +2216,6 @@ s32 create_file(struct inode *inode, struct chain_t *p_dir,
 	struct dos_name_t dos_name;
 	struct super_block *sb = inode->i_sb;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct fs_func *fs_func = p_fs->fs_func;
 
 	ret = get_num_entries_and_dos_name(sb, p_dir, p_uniname, &num_entries,
 					   &dos_name);
@@ -2269,13 +2231,13 @@ s32 create_file(struct inode *inode, struct chain_t *p_dir,
 	/* fill the dos name directory entry information of the created file.
 	 * the first cluster is not determined yet. (0)
 	 */
-	ret = fs_func->init_dir_entry(sb, p_dir, dentry, TYPE_FILE | mode,
-				      CLUSTER_32(0), 0);
+	ret = exfat_init_dir_entry(sb, p_dir, dentry, TYPE_FILE | mode,
+				   CLUSTER_32(0), 0);
 	if (ret != 0)
 		return ret;
 
-	ret = fs_func->init_ext_entry(sb, p_dir, dentry, num_entries, p_uniname,
-				      &dos_name);
+	ret = exfat_init_ext_entry(sb, p_dir, dentry, num_entries, p_uniname,
+				   &dos_name);
 	if (ret != 0)
 		return ret;
 
@@ -2302,8 +2264,6 @@ void remove_file(struct inode *inode, struct chain_t *p_dir, s32 entry)
 	sector_t sector;
 	struct dentry_t *ep;
 	struct super_block *sb = inode->i_sb;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct fs_func *fs_func = p_fs->fs_func;
 
 	ep = get_entry_in_dir(sb, p_dir, entry, &sector);
 	if (!ep)
@@ -2312,7 +2272,7 @@ void remove_file(struct inode *inode, struct chain_t *p_dir, s32 entry)
 	exfat_buf_lock(sb, sector);
 
 	/* exfat_buf_lock() before call count_ext_entries() */
-	num_entries = fs_func->count_ext_entries(sb, p_dir, entry, ep);
+	num_entries = exfat_count_ext_entries(sb, p_dir, entry, ep);
 	if (num_entries < 0) {
 		exfat_buf_unlock(sb, sector);
 		return;
@@ -2322,7 +2282,7 @@ void remove_file(struct inode *inode, struct chain_t *p_dir, s32 entry)
 	exfat_buf_unlock(sb, sector);
 
 	/* (1) update the directory entry */
-	fs_func->delete_dir_entry(sb, p_dir, entry, 0, num_entries);
+	exfat_delete_dir_entry(sb, p_dir, entry, 0, num_entries);
 }
 
 s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
@@ -2333,8 +2293,6 @@ s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 	struct dos_name_t dos_name;
 	struct dentry_t *epold, *epnew;
 	struct super_block *sb = inode->i_sb;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct fs_func *fs_func = p_fs->fs_func;
 
 	epold = get_entry_in_dir(sb, p_dir, oldentry, &sector_old);
 	if (!epold)
@@ -2343,8 +2301,8 @@ s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 	exfat_buf_lock(sb, sector_old);
 
 	/* exfat_buf_lock() before call count_ext_entries() */
-	num_old_entries = fs_func->count_ext_entries(sb, p_dir, oldentry,
-						     epold);
+	num_old_entries = exfat_count_ext_entries(sb, p_dir, oldentry,
+						  epold);
 	if (num_old_entries < 0) {
 		exfat_buf_unlock(sb, sector_old);
 		return -ENOENT;
@@ -2372,10 +2330,10 @@ s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 		}
 
 		memcpy((void *)epnew, (void *)epold, DENTRY_SIZE);
-		if (fs_func->get_entry_type(epnew) == TYPE_FILE) {
-			fs_func->set_entry_attr(epnew,
-						fs_func->get_entry_attr(epnew) |
-						ATTR_ARCHIVE);
+		if (exfat_get_entry_type(epnew) == TYPE_FILE) {
+			exfat_set_entry_attr(epnew,
+					     exfat_get_entry_attr(epnew) |
+					     ATTR_ARCHIVE);
 			fid->attr |= ATTR_ARCHIVE;
 		}
 		exfat_buf_modify(sb, sector_new);
@@ -2396,33 +2354,33 @@ s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 		exfat_buf_modify(sb, sector_new);
 		exfat_buf_unlock(sb, sector_old);
 
-		ret = fs_func->init_ext_entry(sb, p_dir, newentry,
-					      num_new_entries, p_uniname,
-					      &dos_name);
+		ret = exfat_init_ext_entry(sb, p_dir, newentry,
+					   num_new_entries, p_uniname,
+					   &dos_name);
 		if (ret != 0)
 			return ret;
 
-		fs_func->delete_dir_entry(sb, p_dir, oldentry, 0,
-					  num_old_entries);
+		exfat_delete_dir_entry(sb, p_dir, oldentry, 0,
+				       num_old_entries);
 		fid->entry = newentry;
 	} else {
-		if (fs_func->get_entry_type(epold) == TYPE_FILE) {
-			fs_func->set_entry_attr(epold,
-						fs_func->get_entry_attr(epold) |
-						ATTR_ARCHIVE);
+		if (exfat_get_entry_type(epold) == TYPE_FILE) {
+			exfat_set_entry_attr(epold,
+					     exfat_get_entry_attr(epold) |
+					     ATTR_ARCHIVE);
 			fid->attr |= ATTR_ARCHIVE;
 		}
 		exfat_buf_modify(sb, sector_old);
 		exfat_buf_unlock(sb, sector_old);
 
-		ret = fs_func->init_ext_entry(sb, p_dir, oldentry,
-					      num_new_entries, p_uniname,
-					      &dos_name);
+		ret = exfat_init_ext_entry(sb, p_dir, oldentry,
+					   num_new_entries, p_uniname,
+					   &dos_name);
 		if (ret != 0)
 			return ret;
 
-		fs_func->delete_dir_entry(sb, p_dir, oldentry, num_new_entries,
-					  num_old_entries);
+		exfat_delete_dir_entry(sb, p_dir, oldentry, num_new_entries,
+				       num_old_entries);
 	}
 
 	return 0;
@@ -2437,23 +2395,21 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 	struct dos_name_t dos_name;
 	struct dentry_t *epmov, *epnew;
 	struct super_block *sb = inode->i_sb;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct fs_func *fs_func = p_fs->fs_func;
 
 	epmov = get_entry_in_dir(sb, p_olddir, oldentry, &sector_mov);
 	if (!epmov)
 		return -ENOENT;
 
 	/* check if the source and target directory is the same */
-	if (fs_func->get_entry_type(epmov) == TYPE_DIR &&
-	    fs_func->get_entry_clu0(epmov) == p_newdir->dir)
+	if (exfat_get_entry_type(epmov) == TYPE_DIR &&
+	    exfat_get_entry_clu0(epmov) == p_newdir->dir)
 		return -EINVAL;
 
 	exfat_buf_lock(sb, sector_mov);
 
 	/* exfat_buf_lock() before call count_ext_entries() */
-	num_old_entries = fs_func->count_ext_entries(sb, p_olddir, oldentry,
-						     epmov);
+	num_old_entries = exfat_count_ext_entries(sb, p_olddir, oldentry,
+						  epmov);
 	if (num_old_entries < 0) {
 		exfat_buf_unlock(sb, sector_mov);
 		return -ENOENT;
@@ -2480,9 +2436,9 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 	}
 
 	memcpy((void *)epnew, (void *)epmov, DENTRY_SIZE);
-	if (fs_func->get_entry_type(epnew) == TYPE_FILE) {
-		fs_func->set_entry_attr(epnew, fs_func->get_entry_attr(epnew) |
-					ATTR_ARCHIVE);
+	if (exfat_get_entry_type(epnew) == TYPE_FILE) {
+		exfat_set_entry_attr(epnew, exfat_get_entry_attr(epnew) |
+				     ATTR_ARCHIVE);
 		fid->attr |= ATTR_ARCHIVE;
 	}
 	exfat_buf_modify(sb, sector_new);
@@ -2502,12 +2458,12 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 	exfat_buf_modify(sb, sector_new);
 	exfat_buf_unlock(sb, sector_mov);
 
-	ret = fs_func->init_ext_entry(sb, p_newdir, newentry, num_new_entries,
-				      p_uniname, &dos_name);
+	ret = exfat_init_ext_entry(sb, p_newdir, newentry, num_new_entries,
+				   p_uniname, &dos_name);
 	if (ret != 0)
 		return ret;
 
-	fs_func->delete_dir_entry(sb, p_olddir, oldentry, 0, num_old_entries);
+	exfat_delete_dir_entry(sb, p_olddir, oldentry, 0, num_old_entries);
 
 	fid->dir.dir = p_newdir->dir;
 	fid->dir.size = p_newdir->size;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 128ca4403d..b81d2a87b8 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -492,7 +492,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	mutex_lock(&p_fs->v_mutex);
 
 	if (p_fs->used_clusters == UINT_MAX)
-		p_fs->used_clusters = p_fs->fs_func->count_used_clusters(sb);
+		p_fs->used_clusters = exfat_count_used_clusters(sb);
 
 	info->FatType = p_fs->vol_type;
 	info->ClusterSize = p_fs->cluster_size;
@@ -565,8 +565,8 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 		goto out;
 
 	/* search the file name for directories */
-	dentry = p_fs->fs_func->find_dir_entry(sb, &dir, &uni_name, num_entries,
-					       &dos_name, TYPE_ALL);
+	dentry = exfat_find_dir_entry(sb, &dir, &uni_name, num_entries,
+				      &dos_name, TYPE_ALL);
 	if (dentry < -1) {
 		ret = -ENOENT;
 		goto out;
@@ -595,18 +595,18 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 		}
 		ep2 = ep + 1;
 
-		fid->type = p_fs->fs_func->get_entry_type(ep);
+		fid->type = exfat_get_entry_type(ep);
 		fid->rwoffset = 0;
 		fid->hint_last_off = -1;
-		fid->attr = p_fs->fs_func->get_entry_attr(ep);
+		fid->attr = exfat_get_entry_attr(ep);
 
-		fid->size = p_fs->fs_func->get_entry_size(ep2);
+		fid->size = exfat_get_entry_size(ep2);
 		if ((fid->type == TYPE_FILE) && (fid->size == 0)) {
 			fid->flags = (p_fs->vol_type == EXFAT) ? 0x03 : 0x01;
 			fid->start_clu = CLUSTER_32(~0);
 		} else {
-			fid->flags = p_fs->fs_func->get_entry_flag(ep2);
-			fid->start_clu = p_fs->fs_func->get_entry_clu0(ep2);
+			fid->flags = exfat_get_entry_flag(ep2);
+			fid->start_clu = exfat_get_entry_clu0(ep2);
 		}
 
 		release_entry_set(es);
@@ -886,9 +886,9 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 			new_clu.flags = fid->flags;
 
 			/* (1) allocate a chain of clusters */
-			num_alloced = p_fs->fs_func->alloc_cluster(sb,
-								   num_alloc,
-								   &new_clu);
+			num_alloced = exfat_alloc_cluster(sb,
+							  num_alloc,
+							  &new_clu);
 			if (num_alloced == 0)
 				break;
 			if (num_alloced < 0) {
@@ -991,18 +991,18 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 		goto err_out;
 	ep2 = ep + 1;
 
-	p_fs->fs_func->set_entry_time(ep, tm_current(&tm), TM_MODIFY);
-	p_fs->fs_func->set_entry_attr(ep, fid->attr);
+	exfat_set_entry_time(ep, tm_current(&tm), TM_MODIFY);
+	exfat_set_entry_attr(ep, fid->attr);
 
 	if (modified) {
-		if (p_fs->fs_func->get_entry_flag(ep2) != fid->flags)
-			p_fs->fs_func->set_entry_flag(ep2, fid->flags);
+		if (exfat_get_entry_flag(ep2) != fid->flags)
+			exfat_set_entry_flag(ep2, fid->flags);
 
-		if (p_fs->fs_func->get_entry_size(ep2) != fid->size)
-			p_fs->fs_func->set_entry_size(ep2, fid->size);
+		if (exfat_get_entry_size(ep2) != fid->size)
+			exfat_set_entry_size(ep2, fid->size);
 
-		if (p_fs->fs_func->get_entry_clu0(ep2) != fid->start_clu)
-			p_fs->fs_func->set_entry_clu0(ep2, fid->start_clu);
+		if (exfat_get_entry_clu0(ep2) != fid->start_clu)
+			exfat_set_entry_clu0(ep2, fid->start_clu);
 	}
 
 	update_dir_checksum_with_entry_set(sb, es);
@@ -1108,13 +1108,13 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 		}
 	ep2 = ep + 1;
 
-	p_fs->fs_func->set_entry_time(ep, tm_current(&tm), TM_MODIFY);
-	p_fs->fs_func->set_entry_attr(ep, fid->attr);
+	exfat_set_entry_time(ep, tm_current(&tm), TM_MODIFY);
+	exfat_set_entry_attr(ep, fid->attr);
 
-	p_fs->fs_func->set_entry_size(ep2, new_size);
+	exfat_set_entry_size(ep2, new_size);
 	if (new_size == 0) {
-		p_fs->fs_func->set_entry_flag(ep2, 0x01);
-		p_fs->fs_func->set_entry_clu0(ep2, CLUSTER_32(0));
+		exfat_set_entry_flag(ep2, 0x01);
+		exfat_set_entry_clu0(ep2, CLUSTER_32(0));
 	}
 
 	update_dir_checksum_with_entry_set(sb, es);
@@ -1127,7 +1127,7 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 	}
 
 	/* (3) free the clusters */
-	p_fs->fs_func->free_cluster(sb, &clu, 0);
+	exfat_free_cluster(sb, &clu, 0);
 
 	/* hint information */
 	fid->hint_last_off = -1;
@@ -1217,7 +1217,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 		goto out2;
 	}
 
-	if (p_fs->fs_func->get_entry_attr(ep) & ATTR_READONLY) {
+	if (exfat_get_entry_attr(ep) & ATTR_READONLY) {
 		ret = -EPERM;
 		goto out2;
 	}
@@ -1237,7 +1237,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 		if (!ep)
 			goto out;
 
-		entry_type = p_fs->fs_func->get_entry_type(ep);
+		entry_type = exfat_get_entry_type(ep);
 
 		if (entry_type == TYPE_DIR) {
 			struct chain_t new_clu;
@@ -1274,12 +1274,12 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 		if (!ep)
 			goto out;
 
-		num_entries = p_fs->fs_func->count_ext_entries(sb, p_dir,
-							       new_entry, ep);
+		num_entries = exfat_count_ext_entries(sb, p_dir,
+						      new_entry, ep);
 		if (num_entries < 0)
 			goto out;
-		p_fs->fs_func->delete_dir_entry(sb, p_dir, new_entry, 0,
-						num_entries + 1);
+		exfat_delete_dir_entry(sb, p_dir, new_entry, 0,
+				       num_entries + 1);
 	}
 out:
 #ifndef CONFIG_STAGING_EXFAT_DELAYED_SYNC
@@ -1324,7 +1324,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 		goto out;
 	}
 
-	if (p_fs->fs_func->get_entry_attr(ep) & ATTR_READONLY) {
+	if (exfat_get_entry_attr(ep) & ATTR_READONLY) {
 		ret = -EPERM;
 		goto out;
 	}
@@ -1338,7 +1338,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 	clu_to_free.flags = fid->flags;
 
 	/* (2) free the clusters */
-	p_fs->fs_func->free_cluster(sb, &clu_to_free, 0);
+	exfat_free_cluster(sb, &clu_to_free, 0);
 
 	fid->size = 0;
 	fid->start_clu = CLUSTER_32(~0);
@@ -1398,7 +1398,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 		goto out;
 	}
 
-	type = p_fs->fs_func->get_entry_type(ep);
+	type = exfat_get_entry_type(ep);
 
 	if (((type == TYPE_FILE) && (attr & ATTR_SUBDIR)) ||
 	    ((type == TYPE_DIR) && (!(attr & ATTR_SUBDIR)))) {
@@ -1415,7 +1415,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 
 	/* set the file attribute */
 	fid->attr = attr;
-	p_fs->fs_func->set_entry_attr(ep, attr);
+	exfat_set_entry_attr(ep, attr);
 
 	update_dir_checksum_with_entry_set(sb, es);
 	release_entry_set(es);
@@ -1502,9 +1502,9 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	ep2 = ep + 1;
 
 	/* set FILE_INFO structure using the acquired struct dentry_t */
-	info->Attr = p_fs->fs_func->get_entry_attr(ep);
+	info->Attr = exfat_get_entry_attr(ep);
 
-	p_fs->fs_func->get_entry_time(ep, &tm, TM_CREATE);
+	exfat_get_entry_time(ep, &tm, TM_CREATE);
 	info->CreateTimestamp.Year = tm.year;
 	info->CreateTimestamp.Month = tm.mon;
 	info->CreateTimestamp.Day = tm.day;
@@ -1513,7 +1513,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->CreateTimestamp.Second = tm.sec;
 	info->CreateTimestamp.MilliSecond = 0;
 
-	p_fs->fs_func->get_entry_time(ep, &tm, TM_MODIFY);
+	exfat_get_entry_time(ep, &tm, TM_MODIFY);
 	info->ModifyTimestamp.Year = tm.year;
 	info->ModifyTimestamp.Month = tm.mon;
 	info->ModifyTimestamp.Day = tm.day;
@@ -1528,13 +1528,13 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	/* XXX this is very bad for exfat cuz name is already included in es.
 	 * API should be revised
 	 */
-	p_fs->fs_func->get_uni_name_from_ext_entry(sb, &fid->dir, fid->entry,
-						   uni_name.name);
+	exfat_get_uni_name_from_ext_entry(sb, &fid->dir, fid->entry,
+					  uni_name.name);
 	nls_uniname_to_cstring(sb, info->Name, &uni_name);
 
 	info->NumSubdirs = 2;
 
-	info->Size = p_fs->fs_func->get_entry_size(ep2);
+	info->Size = exfat_get_entry_size(ep2);
 
 	release_entry_set(es);
 
@@ -1602,7 +1602,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	}
 	ep2 = ep + 1;
 
-	p_fs->fs_func->set_entry_attr(ep, info->Attr);
+	exfat_set_entry_attr(ep, info->Attr);
 
 	/* set FILE_INFO structure using the acquired struct dentry_t */
 	tm.sec  = info->CreateTimestamp.Second;
@@ -1611,7 +1611,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.day  = info->CreateTimestamp.Day;
 	tm.mon  = info->CreateTimestamp.Month;
 	tm.year = info->CreateTimestamp.Year;
-	p_fs->fs_func->set_entry_time(ep, &tm, TM_CREATE);
+	exfat_set_entry_time(ep, &tm, TM_CREATE);
 
 	tm.sec  = info->ModifyTimestamp.Second;
 	tm.min  = info->ModifyTimestamp.Minute;
@@ -1619,9 +1619,9 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.day  = info->ModifyTimestamp.Day;
 	tm.mon  = info->ModifyTimestamp.Month;
 	tm.year = info->ModifyTimestamp.Year;
-	p_fs->fs_func->set_entry_time(ep, &tm, TM_MODIFY);
+	exfat_set_entry_time(ep, &tm, TM_MODIFY);
 
-	p_fs->fs_func->set_entry_size(ep2, info->Size);
+	exfat_set_entry_size(ep2, info->Size);
 
 	update_dir_checksum_with_entry_set(sb, es);
 	release_entry_set(es);
@@ -1704,7 +1704,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 		new_clu.flags = fid->flags;
 
 		/* (1) allocate a cluster */
-		num_alloced = p_fs->fs_func->alloc_cluster(sb, 1, &new_clu);
+		num_alloced = exfat_alloc_cluster(sb, 1, &new_clu);
 		if (num_alloced < 0) {
 			ret = -EIO;
 			goto out;
@@ -1744,13 +1744,11 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 
 		/* (3) update directory entry */
 		if (modified) {
-			if (p_fs->fs_func->get_entry_flag(ep) != fid->flags)
-				p_fs->fs_func->set_entry_flag(ep, fid->flags);
-
-			if (p_fs->fs_func->get_entry_clu0(ep) != fid->start_clu)
-				p_fs->fs_func->set_entry_clu0(ep,
-							      fid->start_clu);
+			if (exfat_get_entry_flag(ep) != fid->flags)
+				exfat_set_entry_flag(ep, fid->flags);
 
+			if (exfat_get_entry_clu0(ep) != fid->start_clu)
+				exfat_set_entry_clu0(ep, fid->start_clu);
 		}
 
 		update_dir_checksum_with_entry_set(sb, es);
@@ -1831,7 +1829,6 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 	struct dentry_t *ep;
 	struct super_block *sb = inode->i_sb;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct fs_func *fs_func = p_fs->fs_func;
 	struct file_id_t *fid = &(EXFAT_I(inode)->fid);
 
 	/* check the validity of pointer parameters */
@@ -1913,7 +1910,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 				ret = -ENOENT;
 				goto out;
 			}
-			type = fs_func->get_entry_type(ep);
+			type = exfat_get_entry_type(ep);
 
 			if (type == TYPE_UNUSED)
 				break;
@@ -1922,9 +1919,9 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 				continue;
 
 			exfat_buf_lock(sb, sector);
-			dir_entry->Attr = fs_func->get_entry_attr(ep);
+			dir_entry->Attr = exfat_get_entry_attr(ep);
 
-			fs_func->get_entry_time(ep, &tm, TM_CREATE);
+			exfat_get_entry_time(ep, &tm, TM_CREATE);
 			dir_entry->CreateTimestamp.Year = tm.year;
 			dir_entry->CreateTimestamp.Month = tm.mon;
 			dir_entry->CreateTimestamp.Day = tm.day;
@@ -1933,7 +1930,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->CreateTimestamp.Second = tm.sec;
 			dir_entry->CreateTimestamp.MilliSecond = 0;
 
-			fs_func->get_entry_time(ep, &tm, TM_MODIFY);
+			exfat_get_entry_time(ep, &tm, TM_MODIFY);
 			dir_entry->ModifyTimestamp.Year = tm.year;
 			dir_entry->ModifyTimestamp.Month = tm.mon;
 			dir_entry->ModifyTimestamp.Day = tm.day;
@@ -1946,8 +1943,8 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			       sizeof(struct date_time_t));
 
 			*uni_name.name = 0x0;
-			fs_func->get_uni_name_from_ext_entry(sb, &dir, dentry,
-							     uni_name.name);
+			exfat_get_uni_name_from_ext_entry(sb, &dir, dentry,
+							  uni_name.name);
 			nls_uniname_to_cstring(sb, dir_entry->Name, &uni_name);
 			exfat_buf_unlock(sb, sector);
 
@@ -1957,7 +1954,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 				goto out;
 			}
 
-			dir_entry->Size = fs_func->get_entry_size(ep);
+			dir_entry->Size = exfat_get_entry_size(ep);
 
 			/* hint information */
 			if (dir.dir == CLUSTER_32(0)) { /* FAT16 root_dir */
@@ -2047,7 +2044,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 	remove_file(inode, &dir, dentry);
 
 	/* (2) free the clusters */
-	p_fs->fs_func->free_cluster(sb, &clu_to_free, 1);
+	exfat_free_cluster(sb, &clu_to_free, 1);
 
 	fid->size = 0;
 	fid->start_clu = CLUSTER_32(~0);
-- 
2.25.0

