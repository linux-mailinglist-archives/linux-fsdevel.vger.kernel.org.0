Return-Path: <linux-fsdevel+bounces-3826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956BE7F8E88
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 21:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60E41C20BDC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 20:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D892230F9B;
	Sat, 25 Nov 2023 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mUtvtpLB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72460133;
	Sat, 25 Nov 2023 12:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YsjVgw8ngtuO/NgOh1rsmIhgLaPmuciBhn09an+KSXg=; b=mUtvtpLB5ut74CWBVRvXjm+GX4
	4KUxA40HdkBvxubpdJcyMUFFc1lnhXvL/FDfSXzsjS7xiNhlBFMRQ4N3ZaI2lYtd5c6IYLvfgkDwY
	AmCYER9alg9t5PqTf+3BpBE2/08fWikTs31Finyh4zrfgy14k849DUUfHitjsodNcJ6NK4ra13LXT
	ZxCRYu7WultWtPr5JYuRmJIGROOCxTHRbqYn5jquf7XxHOtztE1Ph7Ew3wQDKpd4fYMmvvKeOTTID
	WpeqVITSKJYAHzHkKVkixaMk1KBgDYnMlxFQZ2E2T57We1Yrm61+HQMDZd7xqg0m8kjI1ZYKKdHmo
	Svm8syEA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6z0G-003A4j-0K;
	Sat, 25 Nov 2023 20:11:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mo Zou <lostzoumo@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] ext4: don't access the source subdirectory content on same-directory rename
Date: Sat, 25 Nov 2023 20:11:43 +0000
Message-Id: <20231125201147.753695-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231125201147.753695-1-viro@zeniv.linux.org.uk>
References: <20231125201015.GA38156@ZenIV>
 <20231125201147.753695-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

We can't really afford locking the source on same-directory rename;
currently vfs_rename() tries to do that, but it will have to be changed.
The logics in ext4 is lazy and goes looking for ".." in source even in
same-directory case.  It's not hard to get rid of that, leaving that
behaviour only for cross-directory case; that VFS can get locks safely
(and will keep doing that after the coming changes).

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ext4/namei.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d252935f9c8a..467ba47a691c 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3591,10 +3591,14 @@ struct ext4_renament {
 	int dir_inlined;
 };
 
-static int ext4_rename_dir_prepare(handle_t *handle, struct ext4_renament *ent)
+static int ext4_rename_dir_prepare(handle_t *handle, struct ext4_renament *ent, bool is_cross)
 {
 	int retval;
 
+	ent->is_dir = true;
+	if (!is_cross)
+		return 0;
+
 	ent->dir_bh = ext4_get_first_dir_block(handle, ent->inode,
 					      &retval, &ent->parent_de,
 					      &ent->dir_inlined);
@@ -3612,6 +3616,9 @@ static int ext4_rename_dir_finish(handle_t *handle, struct ext4_renament *ent,
 {
 	int retval;
 
+	if (!ent->dir_bh)
+		return 0;
+
 	ent->parent_de->inode = cpu_to_le32(dir_ino);
 	BUFFER_TRACE(ent->dir_bh, "call ext4_handle_dirty_metadata");
 	if (!ent->dir_inlined) {
@@ -3900,7 +3907,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			if (new.dir != old.dir && EXT4_DIR_LINK_MAX(new.dir))
 				goto end_rename;
 		}
-		retval = ext4_rename_dir_prepare(handle, &old);
+		retval = ext4_rename_dir_prepare(handle, &old, new.dir != old.dir);
 		if (retval)
 			goto end_rename;
 	}
@@ -3964,7 +3971,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 	inode_set_mtime_to_ts(old.dir, inode_set_ctime_current(old.dir));
 	ext4_update_dx_flag(old.dir);
-	if (old.dir_bh) {
+	if (old.is_dir) {
 		retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);
 		if (retval)
 			goto end_rename;
@@ -3987,7 +3994,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (unlikely(retval))
 		goto end_rename;
 
-	if (S_ISDIR(old.inode->i_mode)) {
+	if (old.is_dir) {
 		/*
 		 * We disable fast commits here that's because the
 		 * replay code is not yet capable of changing dot dot
@@ -4114,14 +4121,12 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		ext4_handle_sync(handle);
 
 	if (S_ISDIR(old.inode->i_mode)) {
-		old.is_dir = true;
-		retval = ext4_rename_dir_prepare(handle, &old);
+		retval = ext4_rename_dir_prepare(handle, &old, new.dir != old.dir);
 		if (retval)
 			goto end_rename;
 	}
 	if (S_ISDIR(new.inode->i_mode)) {
-		new.is_dir = true;
-		retval = ext4_rename_dir_prepare(handle, &new);
+		retval = ext4_rename_dir_prepare(handle, &new, new.dir != old.dir);
 		if (retval)
 			goto end_rename;
 	}
-- 
2.39.2


