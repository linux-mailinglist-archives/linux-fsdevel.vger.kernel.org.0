Return-Path: <linux-fsdevel+bounces-32395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A689A49EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A841C2135F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6792C1917D4;
	Fri, 18 Oct 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Y7w7/yS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2A152E12
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293561; cv=none; b=B8Zur4AZfORvZGYfRi+uT/q3anz2Pyt2qrb4sUOT40C50YLgpXvVixFfM0RdBSA4lh8xL3FNHA9QLKXvjc4pWNcz1AxnnfHZ+hZrzwPnPbAOV9xWpugJ9q10TNdByBKPk6VSubLZJowpZI3SjSSuW3cAL08ULtogwkHa08PBkzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293561; c=relaxed/simple;
	bh=gwqFjOJExb5iTfLmZTA9qRgfJlhcnGzl3QKZQcFgveM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6F3O8CIIkdfA9dQKBO3S5M87pBzD8Y9pGlGTdSAUzrd6pxaJoYtd5BhFDVxu5B3jTrYIw2kD4isCWZ3KWghDtRncGeWvRUVBH9cm6CXO/F4ClxWThjtmlaFeni5dWcA7t5QCSoPy3N2gWiRK2u2MzeskebaBHtlms4vdOquJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Y7w7/yS9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ueXIH9q/kM9DCxKgc3jrPn5DjzZoc30guIDVUWRVb/E=; b=Y7w7/yS93thjPzWxllHUHGj9lK
	1Qh8SFPnEFUKfnlacTFx/Mp7nXHhry13m5Ozq5SAcpykh05+AbJp97xNWrWUJjdmEN0CqIOsCWhTd
	AEQMksWLUbCpRIjwHAF59VUB8eiOEFxaO+19CgU1gUdp/daHSKvoQ5qiFQJP35r6up8zHoqCe4PuJ
	83c8IMo6HIHW5nnWvc+luf+jEnGhWqWbirrXrcQeebbLM5xxxw2ADwn2ohZMP7V2C62hmsfG250wv
	BNJj3Me/Li4j0ru8Vq4qvwxZeimzrJ6r9lPSuw/kkbbnAUoZNGkxLDtFRiD5EszR0FSPk6HOQqUpN
	67HEcY1w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFY-00000005E6F-3n04;
	Fri, 18 Oct 2024 23:19:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 01/17] ufs: fix handling of delete_entry and set_link failures
Date: Sat, 19 Oct 2024 00:19:00 +0100
Message-ID: <20241018231916.1245836-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018231428.GC1172273@ZenIV>
References: <20241018231428.GC1172273@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

similar to minixfs series - make ufs_set_link() report failures,
lift folio_release_kmap() into the callers of ufs_set_link()
and ufs_delete_entry(), make ufs_rename() handle failures in both.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/dir.c   | 29 ++++++++++++++---------------
 fs/ufs/namei.c | 39 +++++++++++++++++----------------------
 fs/ufs/ufs.h   |  4 ++--
 3 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index d6e6a2198971..88d0062cfdb9 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -81,10 +81,9 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 }
 
 
-/* Releases the page */
-void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
-		  struct folio *folio, struct inode *inode,
-		  bool update_times)
+int ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
+		 struct folio *folio, struct inode *inode,
+		 bool update_times)
 {
 	loff_t pos = folio_pos(folio) + offset_in_folio(folio, de);
 	unsigned len = fs16_to_cpu(dir->i_sb, de->d_reclen);
@@ -92,17 +91,19 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 
 	folio_lock(folio);
 	err = ufs_prepare_chunk(folio, pos, len);
-	BUG_ON(err);
+	if (unlikely(err)) {
+		folio_unlock(folio);
+		return err;
+	}
 
 	de->d_ino = cpu_to_fs32(dir->i_sb, inode->i_ino);
 	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
 
 	ufs_commit_chunk(folio, pos, len);
-	folio_release_kmap(folio, de);
 	if (update_times)
 		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
-	ufs_handle_dirsync(dir);
+	return ufs_handle_dirsync(dir);
 }
 
 static bool ufs_check_folio(struct folio *folio, char *kaddr)
@@ -505,8 +506,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 		if (de->d_reclen == 0) {
 			ufs_error(inode->i_sb, __func__,
 				  "zero-length directory entry");
-			err = -EIO;
-			goto out;
+			return -EIO;
 		}
 		pde = de;
 		de = ufs_next_entry(sb, de);
@@ -516,18 +516,17 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 	pos = folio_pos(folio) + from;
 	folio_lock(folio);
 	err = ufs_prepare_chunk(folio, pos, to - from);
-	BUG_ON(err);
+	if (unlikely(err)) {
+		folio_unlock(folio);
+		return err;
+	}
 	if (pde)
 		pde->d_reclen = cpu_to_fs16(sb, to - from);
 	dir->d_ino = 0;
 	ufs_commit_chunk(folio, pos, to - from);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
-	err = ufs_handle_dirsync(inode);
-out:
-	folio_release_kmap(folio, kaddr);
-	UFSD("EXIT\n");
-	return err;
+	return ufs_handle_dirsync(inode);
 }
 
 int ufs_make_empty(struct inode * inode, struct inode *dir)
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index c8390976ab6a..38a024c8cccd 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -210,20 +210,18 @@ static int ufs_unlink(struct inode *dir, struct dentry *dentry)
 	struct inode * inode = d_inode(dentry);
 	struct ufs_dir_entry *de;
 	struct folio *folio;
-	int err = -ENOENT;
+	int err;
 
 	de = ufs_find_entry(dir, &dentry->d_name, &folio);
 	if (!de)
-		goto out;
+		return -ENOENT;
 
 	err = ufs_delete_entry(dir, de, folio);
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
+	folio_release_kmap(folio, de);
 	return err;
 }
 
@@ -253,14 +251,14 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct ufs_dir_entry * dir_de = NULL;
 	struct folio *old_folio;
 	struct ufs_dir_entry *old_de;
-	int err = -ENOENT;
+	int err;
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
 	old_de = ufs_find_entry(old_dir, &old_dentry->d_name, &old_folio);
 	if (!old_de)
-		goto out;
+		return -ENOENT;
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
@@ -281,7 +279,10 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		new_de = ufs_find_entry(new_dir, &new_dentry->d_name, &new_folio);
 		if (!new_de)
 			goto out_dir;
-		ufs_set_link(new_dir, new_de, new_folio, old_inode, 1);
+		err = ufs_set_link(new_dir, new_de, new_folio, old_inode, 1);
+		folio_release_kmap(new_folio, new_de);
+		if (err)
+			goto out_dir;
 		inode_set_ctime_current(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
@@ -299,26 +300,20 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
  	 * rename.
 	 */
 	inode_set_ctime_current(old_inode);
-
-	ufs_delete_entry(old_dir, old_de, old_folio);
 	mark_inode_dirty(old_inode);
 
-	if (dir_de) {
+	err = ufs_delete_entry(old_dir, old_de, old_folio);
+	if (!err && dir_de) {
 		if (old_dir != new_dir)
-			ufs_set_link(old_inode, dir_de, dir_folio, new_dir, 0);
-		else
-			folio_release_kmap(dir_folio, dir_de);
+			err = ufs_set_link(old_inode, dir_de, dir_folio,
+					   new_dir, 0);
 		inode_dec_link_count(old_dir);
 	}
-	return 0;
-
-
 out_dir:
 	if (dir_de)
 		folio_release_kmap(dir_folio, dir_de);
 out_old:
 	folio_release_kmap(old_folio, old_de);
-out:
 	return err;
 }
 
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index a2c762cb65a0..c7638e62ffe8 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -108,8 +108,8 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *, const struct qstr *,
 int ufs_delete_entry(struct inode *, struct ufs_dir_entry *, struct folio *);
 int ufs_empty_dir(struct inode *);
 struct ufs_dir_entry *ufs_dotdot(struct inode *, struct folio **);
-void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
-		struct folio *folio, struct inode *inode, bool update_times);
+int ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
+		 struct folio *folio, struct inode *inode, bool update_times);
 
 /* file.c */
 extern const struct inode_operations ufs_file_inode_operations;
-- 
2.39.5


