Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93D034ECE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 17:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhC3Pwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 11:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231752AbhC3Pw0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:52:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A654619C0;
        Tue, 30 Mar 2021 15:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617119545;
        bh=ZMEkBm8vB1lsE3KyqReVRJtHNT43kqFsrOF2nrVUUQs=;
        h=Date:From:To:Cc:Subject:From;
        b=LI1IcAsQZpe3oe5fzDC/q551qNbP6cUOTJ20sE7pGru3HKjWk6gE7EmNPETkliZ6Y
         51jaVG2eYPCL7WcDBJFJsED+48tdMIotUj2Ilgs5E/13EpVw5+XHSdniqMXWLrfbv2
         6TpvmVkdrsj4HHCC6tRJcJwCCC78jZLtpWlM2JhXNXymqloZGIewwpe4vCsjQLmvB/
         cZoVejpPh1TtYqt6kDiq4slJZh76pAH0qtJq2t7CSZz3O9mScRGso55t0Z1PZ7RvRY
         +dKWrjO43qgrldS3V7jl3uxjHfNZ0Ei3wpZHpxBKK5Oqgss4EizHR2JkzAur25EvUx
         FmfgctxOYfuFg==
Date:   Tue, 30 Mar 2021 09:52:26 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] hfsplus: Fix out-of-bounds warnings in
 __hfsplus_setxattr
Message-ID: <20210330145226.GA207011@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the following out-of-bounds warnings by enclosing
structure members file and finder into new struct info:

fs/hfsplus/xattr.c:300:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct DInfo' at offset 48 [-Warray-bounds]
fs/hfsplus/xattr.c:313:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct FInfo' at offset 48 [-Warray-bounds]

Refactor the code by making it more "structured."

Also, this helps with the ongoing efforts to enable -Warray-bounds and
makes the code clearer and avoid confusing the compiler.

Link: https://github.com/KSPP/linux/issues/109
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/hfsplus/catalog.c     | 16 ++++++++--------
 fs/hfsplus/dir.c         |  4 ++--
 fs/hfsplus/hfsplus_raw.h | 12 ++++++++----
 fs/hfsplus/xattr.c       | 18 ++++++++----------
 4 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 35472cba750e..9cdc6550b468 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -124,7 +124,7 @@ static int hfsplus_cat_build_record(hfsplus_cat_entry *entry,
 		hfsplus_cat_set_perms(inode, &folder->permissions);
 		if (inode == sbi->hidden_dir)
 			/* invisible and namelocked */
-			folder->user_info.frFlags = cpu_to_be16(0x5000);
+			folder->info.user.frFlags = cpu_to_be16(0x5000);
 		return sizeof(*folder);
 	} else {
 		struct hfsplus_cat_file *file;
@@ -142,14 +142,14 @@ static int hfsplus_cat_build_record(hfsplus_cat_entry *entry,
 		if (cnid == inode->i_ino) {
 			hfsplus_cat_set_perms(inode, &file->permissions);
 			if (S_ISLNK(inode->i_mode)) {
-				file->user_info.fdType =
+				file->info.user.fdType =
 					cpu_to_be32(HFSP_SYMLINK_TYPE);
-				file->user_info.fdCreator =
+				file->info.user.fdCreator =
 					cpu_to_be32(HFSP_SYMLINK_CREATOR);
 			} else {
-				file->user_info.fdType =
+				file->info.user.fdType =
 					cpu_to_be32(sbi->type);
-				file->user_info.fdCreator =
+				file->info.user.fdCreator =
 					cpu_to_be32(sbi->creator);
 			}
 			if (HFSPLUS_FLG_IMMUTABLE &
@@ -158,11 +158,11 @@ static int hfsplus_cat_build_record(hfsplus_cat_entry *entry,
 				file->flags |=
 					cpu_to_be16(HFSPLUS_FILE_LOCKED);
 		} else {
-			file->user_info.fdType =
+			file->info.user.fdType =
 				cpu_to_be32(HFSP_HARDLINK_TYPE);
-			file->user_info.fdCreator =
+			file->info.user.fdCreator =
 				cpu_to_be32(HFSP_HFSPLUS_CREATOR);
-			file->user_info.fdFlags =
+			file->info.user.fdFlags =
 				cpu_to_be16(0x100);
 			file->create_date =
 				HFSPLUS_I(sbi->hidden_dir)->create_date;
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 03e6c046faf4..0ae8f797d7f3 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -73,9 +73,9 @@ static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
 			goto fail;
 		}
 		cnid = be32_to_cpu(entry.file.id);
-		if (entry.file.user_info.fdType ==
+		if (entry.file.info.user.fdType ==
 				cpu_to_be32(HFSP_HARDLINK_TYPE) &&
-				entry.file.user_info.fdCreator ==
+				entry.file.info.user.fdCreator ==
 				cpu_to_be32(HFSP_HFSPLUS_CREATOR) &&
 				HFSPLUS_SB(sb)->hidden_dir &&
 				(entry.file.create_date ==
diff --git a/fs/hfsplus/hfsplus_raw.h b/fs/hfsplus/hfsplus_raw.h
index 456e87aec7fd..005a043bc7ee 100644
--- a/fs/hfsplus/hfsplus_raw.h
+++ b/fs/hfsplus/hfsplus_raw.h
@@ -260,8 +260,10 @@ struct hfsplus_cat_folder {
 	__be32 access_date;
 	__be32 backup_date;
 	struct hfsplus_perm permissions;
-	struct DInfo user_info;
-	struct DXInfo finder_info;
+	struct {
+		struct DInfo user;
+		struct DXInfo finder;
+	} info;
 	__be32 text_encoding;
 	__be32 subfolders;	/* Subfolder count in HFSX. Reserved in HFS+. */
 } __packed;
@@ -294,8 +296,10 @@ struct hfsplus_cat_file {
 	__be32 access_date;
 	__be32 backup_date;
 	struct hfsplus_perm permissions;
-	struct FInfo user_info;
-	struct FXInfo finder_info;
+	struct {
+		struct FInfo user;
+		struct FXInfo finder;
+	} info;
 	__be32 text_encoding;
 	u32 reserved2;
 
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 4d169c5a2673..e18a472ac937 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -262,10 +262,8 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 	struct hfs_find_data cat_fd;
 	hfsplus_cat_entry entry;
 	u16 cat_entry_flags, cat_entry_type;
-	u16 folder_finderinfo_len = sizeof(struct DInfo) +
-					sizeof(struct DXInfo);
-	u16 file_finderinfo_len = sizeof(struct FInfo) +
-					sizeof(struct FXInfo);
+	u16 folder_finderinfo_len = sizeof(entry.folder.info);
+	u16 file_finderinfo_len = sizeof(entry.file.info);
 
 	if ((!S_ISREG(inode->i_mode) &&
 			!S_ISDIR(inode->i_mode)) ||
@@ -297,7 +295,7 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 					sizeof(hfsplus_cat_entry));
 		if (be16_to_cpu(entry.type) == HFSPLUS_FOLDER) {
 			if (size == folder_finderinfo_len) {
-				memcpy(&entry.folder.user_info, value,
+				memcpy(&entry.folder.info, value,
 						folder_finderinfo_len);
 				hfs_bnode_write(cat_fd.bnode, &entry,
 					cat_fd.entryoffset,
@@ -310,7 +308,7 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 			}
 		} else if (be16_to_cpu(entry.type) == HFSPLUS_FILE) {
 			if (size == file_finderinfo_len) {
-				memcpy(&entry.file.user_info, value,
+				memcpy(&entry.file.info, value,
 						file_finderinfo_len);
 				hfs_bnode_write(cat_fd.bnode, &entry,
 					cat_fd.entryoffset,
@@ -463,14 +461,14 @@ static ssize_t hfsplus_getxattr_finder_info(struct inode *inode,
 		if (entry_type == HFSPLUS_FOLDER) {
 			hfs_bnode_read(fd.bnode, folder_finder_info,
 				fd.entryoffset +
-				offsetof(struct hfsplus_cat_folder, user_info),
+				offsetof(struct hfsplus_cat_folder, info.user),
 				folder_rec_len);
 			memcpy(value, folder_finder_info, folder_rec_len);
 			res = folder_rec_len;
 		} else if (entry_type == HFSPLUS_FILE) {
 			hfs_bnode_read(fd.bnode, file_finder_info,
 				fd.entryoffset +
-				offsetof(struct hfsplus_cat_file, user_info),
+				offsetof(struct hfsplus_cat_file, info.user),
 				file_rec_len);
 			memcpy(value, file_finder_info, file_rec_len);
 			res = file_rec_len;
@@ -631,14 +629,14 @@ static ssize_t hfsplus_listxattr_finder_info(struct dentry *dentry,
 		len = sizeof(struct DInfo) + sizeof(struct DXInfo);
 		hfs_bnode_read(fd.bnode, folder_finder_info,
 				fd.entryoffset +
-				offsetof(struct hfsplus_cat_folder, user_info),
+				offsetof(struct hfsplus_cat_folder, info.user),
 				len);
 		found_bit = find_first_bit((void *)folder_finder_info, len*8);
 	} else if (entry_type == HFSPLUS_FILE) {
 		len = sizeof(struct FInfo) + sizeof(struct FXInfo);
 		hfs_bnode_read(fd.bnode, file_finder_info,
 				fd.entryoffset +
-				offsetof(struct hfsplus_cat_file, user_info),
+				offsetof(struct hfsplus_cat_file, info.user),
 				len);
 		found_bit = find_first_bit((void *)file_finder_info, len*8);
 	} else {
-- 
2.27.0

