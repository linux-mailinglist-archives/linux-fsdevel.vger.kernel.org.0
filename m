Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173864048C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 12:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhIIK7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 06:59:23 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:37600 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234628AbhIIK7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:59:20 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 9D0731D78;
        Thu,  9 Sep 2021 13:58:09 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1631185089;
        bh=Gvw8TGpTmwC4QvKKtiXTUz8bcFGI+HJPLVvq+sRhbLo=;
        h=Date:To:CC:From:Subject;
        b=Kv8AjDJQ20D1udCY+cKQalI8HJulDnPo001+nok8X0nHdT3FDVUH1QryuzlSl8Ms6
         MW9k5hhWz4tNNVAfG2UOayoAdi8tMF+cZOR/etpbARBx3QN0PImB107RlyLJ13kLYl
         TRZUnU5snnXEz/KM2+5U3K0ZzsuIbEAB+8U4uY7A=
Received: from [192.168.211.46] (192.168.211.46) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 9 Sep 2021 13:58:09 +0300
Message-ID: <8a99d42f-1097-9c0d-d1b2-5b971a8a4d1f@paragon-software.com>
Date:   Thu, 9 Sep 2021 13:58:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 3/3] fs/ntfs3: Add sync flag to ntfs_sb_write_run and
 al_update
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.46]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows to wait only when it's requested.
It speeds up creation of hardlinks.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c   | 2 +-
 fs/ntfs3/attrlist.c | 6 +++---
 fs/ntfs3/frecord.c  | 2 +-
 fs/ntfs3/fslog.c    | 9 +++++----
 fs/ntfs3/fsntfs.c   | 8 ++++----
 fs/ntfs3/inode.c    | 2 +-
 fs/ntfs3/ntfs_fs.h  | 4 ++--
 fs/ntfs3/xattr.c    | 2 +-
 8 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 34c4cbf7e29b..64a28fe7c124 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -291,7 +291,7 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 		if (!rsize) {
 			/* Empty resident -> Non empty nonresident. */
 		} else if (!is_data) {
-			err = ntfs_sb_write_run(sbi, run, 0, data, rsize);
+			err = ntfs_sb_write_run(sbi, run, 0, data, rsize, 0);
 			if (err)
 				goto out2;
 		} else if (!page) {
diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index fa32399eb517..e41443cb3d63 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -336,7 +336,7 @@ int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE type, const __le16 *name,
 
 	if (attr && attr->non_res) {
 		err = ntfs_sb_write_run(ni->mi.sbi, &al->run, 0, al->le,
-					al->size);
+					al->size, 0);
 		if (err)
 			return err;
 		al->dirty = false;
@@ -423,7 +423,7 @@ bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
 	return true;
 }
 
-int al_update(struct ntfs_inode *ni)
+int al_update(struct ntfs_inode *ni, int sync)
 {
 	int err;
 	struct ATTRIB *attr;
@@ -445,7 +445,7 @@ int al_update(struct ntfs_inode *ni)
 		memcpy(resident_data(attr), al->le, al->size);
 	} else {
 		err = ntfs_sb_write_run(ni->mi.sbi, &al->run, 0, al->le,
-					al->size);
+					al->size, sync);
 		if (err)
 			goto out;
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 5dd7b7a7c5e0..8478be3ab0e4 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3209,7 +3209,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 					goto out;
 			}
 
-			err = al_update(ni);
+			err = al_update(ni, sync);
 			if (err)
 				goto out;
 		}
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index b5853aed0e25..5c82b6218d94 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2219,7 +2219,7 @@ static int last_log_lsn(struct ntfs_log *log)
 
 			err = ntfs_sb_write_run(log->ni->mi.sbi,
 						&log->ni->file.run, off, page,
-						log->page_size);
+						log->page_size, 0);
 
 			if (err)
 				goto out;
@@ -3710,7 +3710,8 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 
 	if (a_dirty) {
 		attr = oa->attr;
-		err = ntfs_sb_write_run(sbi, oa->run1, vbo, buffer_le, bytes);
+		err = ntfs_sb_write_run(sbi, oa->run1, vbo, buffer_le, bytes,
+					0);
 		if (err)
 			goto out;
 	}
@@ -5152,10 +5153,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 
 	ntfs_fix_pre_write(&rh->rhdr, log->page_size);
 
-	err = ntfs_sb_write_run(sbi, &ni->file.run, 0, rh, log->page_size);
+	err = ntfs_sb_write_run(sbi, &ni->file.run, 0, rh, log->page_size, 0);
 	if (!err)
 		err = ntfs_sb_write_run(sbi, &log->ni->file.run, log->page_size,
-					rh, log->page_size);
+					rh, log->page_size, 0);
 
 	kfree(rh);
 	if (err)
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 91e3743e1442..c89a0f5c5ad4 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1080,7 +1080,7 @@ int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
 }
 
 int ntfs_sb_write_run(struct ntfs_sb_info *sbi, const struct runs_tree *run,
-		      u64 vbo, const void *buf, size_t bytes)
+		      u64 vbo, const void *buf, size_t bytes, int sync)
 {
 	struct super_block *sb = sbi->sb;
 	u8 cluster_bits = sbi->cluster_bits;
@@ -1100,7 +1100,7 @@ int ntfs_sb_write_run(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 
 	for (;;) {
 		u32 op = len < bytes ? len : bytes;
-		int err = ntfs_sb_write(sb, lbo, op, buf, 0);
+		int err = ntfs_sb_write(sb, lbo, op, buf, sync);
 
 		if (err)
 			return err;
@@ -2175,7 +2175,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
 
 	/* Write main SDS bucket. */
 	err = ntfs_sb_write_run(sbi, &ni->file.run, sbi->security.next_off,
-				d_security, aligned_sec_size);
+				d_security, aligned_sec_size, 0);
 
 	if (err)
 		goto out;
@@ -2193,7 +2193,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
 
 	/* Write copy SDS bucket. */
 	err = ntfs_sb_write_run(sbi, &ni->file.run, mirr_off, d_security,
-				aligned_sec_size);
+				aligned_sec_size, 0);
 	if (err)
 		goto out;
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 187ef6adc9e1..aa519ed4453c 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1593,7 +1593,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 
 	/* Write non resident data. */
 	if (nsize) {
-		err = ntfs_sb_write_run(sbi, &ni->file.run, 0, rp, nsize);
+		err = ntfs_sb_write_run(sbi, &ni->file.run, 0, rp, nsize, 0);
 		if (err)
 			goto out7;
 	}
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 97e682ebcfb9..a29578fa935b 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -436,7 +436,7 @@ bool al_remove_le(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le);
 bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
 		  const __le16 *name, size_t name_len,
 		  const struct MFT_REF *ref);
-int al_update(struct ntfs_inode *ni);
+int al_update(struct ntfs_inode *ni, int sync);
 static inline size_t al_aligned(size_t size)
 {
 	return (size + 1023) & ~(size_t)1023;
@@ -577,7 +577,7 @@ int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void *buffer);
 int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
 		  const void *buffer, int wait);
 int ntfs_sb_write_run(struct ntfs_sb_info *sbi, const struct runs_tree *run,
-		      u64 vbo, const void *buf, size_t bytes);
+		      u64 vbo, const void *buf, size_t bytes, int sync);
 struct buffer_head *ntfs_bread_run(struct ntfs_sb_info *sbi,
 				   const struct runs_tree *run, u64 vbo);
 int ntfs_read_run_nb(struct ntfs_sb_info *sbi, const struct runs_tree *run,
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 83de1fd3b9c3..210a23979e71 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -444,7 +444,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 		/* Delete xattr, ATTR_EA */
 		ni_remove_attr_le(ni, attr, mi, le);
 	} else if (attr->non_res) {
-		err = ntfs_sb_write_run(sbi, &ea_run, 0, ea_all, size);
+		err = ntfs_sb_write_run(sbi, &ea_run, 0, ea_all, size, 0);
 		if (err)
 			goto out;
 	} else {
-- 
2.28.0
