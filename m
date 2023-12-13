Return-Path: <linux-fsdevel+bounces-5796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597E28108A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8F71C20E14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF268D301;
	Wed, 13 Dec 2023 03:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NmEGHwTF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4D4BD
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 19:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VjPK/De1gE8RmPpJweMC8W9BLYkPksaDrCLgp/sOxQA=; b=NmEGHwTFaUvziagbRrHCWdBKZw
	SHKHduCo4sIk7mHZY4D1qw6yYFck3A2IKx7kJhHyUgmBSkt29ZpweYifR4Z9U5cSF3I3dTTkJ8yIu
	UxrEzELwX6WzwX07z+j6Zetu6zfNvP6vKIRxSEiTwbpo8K/5A2ZKPoHNBV5F907TgDOFCs07Z2aaf
	3qDcAuzhmuFsE6BvtX1ywBkSNNzLKHLDjkDnvoPVnfoTDYjmP7Dd+emVqY24CtgEvhkPdFMybG1nX
	PJUrkmKR27403+m77nzopXgcpzi9Jb285xPkmRH1ZLFmWRqXhyYXLcQKNMvKyjjK28gz/Kl5aeSRG
	DtOAUPjg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDFlU-00Bbxx-1z;
	Wed, 13 Dec 2023 03:18:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 05/12] ufs: fix handling of delete_entry and set_link failures
Date: Wed, 13 Dec 2023 03:18:20 +0000
Message-Id: <20231213031827.2767531-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213031827.2767531-1-viro@zeniv.linux.org.uk>
References: <20231213031639.GJ1674809@ZenIV>
 <20231213031827.2767531-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

similar to minixfs series - make ufs_set_link() report failures,
lift dir_put_page() into the callers of ufs_set_link() and
ufs_delete_entry(), make ufs_rename() handle failures in both.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/dir.c   | 27 ++++++++++++---------------
 fs/ufs/namei.c | 40 +++++++++++++++++-----------------------
 fs/ufs/ufs.h   |  2 +-
 3 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index fcf13e3ca869..5edacece384b 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -81,8 +81,7 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 }
 
 
-/* Releases the page */
-void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
+int ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 		  struct page *page, struct inode *inode,
 		  bool update_times)
 {
@@ -92,17 +91,19 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 
 	lock_page(page);
 	err = ufs_prepare_chunk(page, pos, len);
-	BUG_ON(err);
+	if (unlikely(err)) {
+		unlock_page(page);
+		return err;
+	}
 
 	de->d_ino = cpu_to_fs32(dir->i_sb, inode->i_ino);
 	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
 
 	ufs_commit_chunk(page, pos, len);
-	unmap_and_put_page(page, de);
 	if (update_times)
 		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
-	ufs_handle_dirsync(dir);
+	return ufs_handle_dirsync(dir);
 }
 
 
@@ -522,8 +523,6 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 	struct ufs_dir_entry *de = (struct ufs_dir_entry *) (kaddr + from);
 	int err;
 
-	UFSD("ENTER\n");
-
 	UFSD("ino %u, reclen %u, namlen %u, name %s\n",
 	      fs32_to_cpu(sb, de->d_ino),
 	      fs16_to_cpu(sb, de->d_reclen),
@@ -533,8 +532,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 		if (de->d_reclen == 0) {
 			ufs_error(inode->i_sb, __func__,
 				  "zero-length directory entry");
-			err = -EIO;
-			goto out;
+			return -EIO;
 		}
 		pde = de;
 		de = ufs_next_entry(sb, de);
@@ -545,18 +543,17 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 	pos = page_offset(page) + from;
 	lock_page(page);
 	err = ufs_prepare_chunk(page, pos, to - from);
-	BUG_ON(err);
+	if (unlikely(err)) {
+		unlock_page(page);
+		return err;
+	}
 	if (pde)
 		pde->d_reclen = cpu_to_fs16(sb, to - from);
 	dir->d_ino = 0;
 	ufs_commit_chunk(page, pos, to - from);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
-	err = ufs_handle_dirsync(inode);
-out:
-	unmap_and_put_page(page, kaddr);
-	UFSD("EXIT\n");
-	return err;
+	return ufs_handle_dirsync(inode);
 }
 
 int ufs_make_empty(struct inode * inode, struct inode *dir)
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 25fa97340f73..b8082fb53a08 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -210,20 +210,18 @@ static int ufs_unlink(struct inode *dir, struct dentry *dentry)
 	struct inode * inode = d_inode(dentry);
 	struct ufs_dir_entry *de;
 	struct page *page;
-	int err = -ENOENT;
+	int err;
 
 	de = ufs_find_entry(dir, &dentry->d_name, &page);
 	if (!de)
-		goto out;
+		return -ENOENT;
 
 	err = ufs_delete_entry(dir, de, page);
-	if (err)
-		goto out;
-
-	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
-	inode_dec_link_count(inode);
-	err = 0;
-out:
+	if (!err) {
+		inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
+		inode_dec_link_count(inode);
+	}
+	unmap_and_put_page(page, de);
 	return err;
 }
 
@@ -253,14 +251,14 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct ufs_dir_entry *dir_de = NULL;
 	struct page *old_page;
 	struct ufs_dir_entry *old_de;
-	int err = -ENOENT;
+	int err;
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
 	old_de = ufs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_de)
-		goto out;
+		return -ENOENT;
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
@@ -281,7 +279,10 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		new_de = ufs_find_entry(new_dir, &new_dentry->d_name, &new_page);
 		if (!new_de)
 			goto out_dir;
-		ufs_set_link(new_dir, new_de, new_page, old_inode, 1);
+		err = ufs_set_link(new_dir, new_de, new_page, old_inode, 1);
+		unmap_and_put_page(new_page, new_de);
+		if (err)
+			goto out_dir;
 		inode_set_ctime_current(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
@@ -299,27 +300,20 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
  	 * rename.
 	 */
 	inode_set_ctime_current(old_inode);
-
-	ufs_delete_entry(old_dir, old_de, old_page);
 	mark_inode_dirty(old_inode);
 
-	if (dir_de) {
+	err = ufs_delete_entry(old_dir, old_de, old_page);
+	if (!err && dir_de) {
 		if (old_dir != new_dir)
-			ufs_set_link(old_inode, dir_de, dir_page, new_dir, 0);
-		else {
-			unmap_and_put_page(dir_page, dir_de);
-		}
+			err = ufs_set_link(old_inode, dir_de, dir_page,
+					   new_dir, 0);
 		inode_dec_link_count(old_dir);
 	}
-	return 0;
-
-
 out_dir:
 	if (dir_de)
 		unmap_and_put_page(dir_page, dir_de);
 out_old:
 	unmap_and_put_page(old_page, old_de);
-out:
 	return err;
 }
 
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index 6b499180643b..b521ab01471a 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -106,7 +106,7 @@ extern struct ufs_dir_entry *ufs_find_entry(struct inode *, const struct qstr *,
 extern int ufs_delete_entry(struct inode *, struct ufs_dir_entry *, struct page *);
 extern int ufs_empty_dir (struct inode *);
 extern struct ufs_dir_entry *ufs_dotdot(struct inode *, struct page **);
-extern void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
+extern int ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 			 struct page *page, struct inode *inode, bool update_times);
 
 /* file.c */
-- 
2.39.2


