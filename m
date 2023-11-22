Return-Path: <linux-fsdevel+bounces-3467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD767F50C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 20:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B94BB20F20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3824F5D4BA;
	Wed, 22 Nov 2023 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="j/zHIGdb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE2B1B2;
	Wed, 22 Nov 2023 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1kXdQTzP9QbMwip9HhQkODeDCTy6uPz4pJDbGLrfwH4=; b=j/zHIGdbj57GVSf3DgjFtbdzKE
	YXPaab07VjQSO1hmibpG7Yx3cWdhR6Gt7FJ3w44L7KwZ+vQ16Xm2JYzQ47NgaIioMCP6/HINChePB
	f9BnMFXX3+IZzeLoCwZmE+JGw6KJqao1AGBWgNv7jG1nZWOI355W9J63abY9m5dxqknDvV1hLqZf6
	S//r8xOmWheYW872BRLirbQJW8c8LFS7D2t+uNB2TradI9dAqRwrQoxFgxiblODgGndnFa92Jvt3v
	zExswAs4CxD3Z7cXEkzeINfSkXTYumauvHRuO8aJtGzPAuZp7m7PV8jpHXBNK6+bSAf0lNVZTgzEH
	P/mGlS3w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5t1p-001l1o-0z;
	Wed, 22 Nov 2023 19:36:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mo Zou <lostzoumo@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] f2fs: Avoid reading renamed directory if parent does not change
Date: Wed, 22 Nov 2023 19:36:49 +0000
Message-Id: <20231122193652.419091-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231122193652.419091-1-viro@zeniv.linux.org.uk>
References: <20231122193028.GE38156@ZenIV>
 <20231122193652.419091-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: Jan Kara <jack@suse.cz>

The VFS will not be locking moved directory if its parent does not
change.  Change f2fs rename code to avoid reading renamed directory if
its parent does not change.  Having it uninlined while we are reading
it would cause trouble and we won't be able to rely upon ->i_rwsem
on the directory being renamed in cases that do not alter its parent.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/f2fs/namei.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index d0053b0284d8..fdc97df6bb85 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -963,6 +963,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct f2fs_dir_entry *old_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry;
 	struct f2fs_dir_entry *new_entry;
+	bool old_is_dir = S_ISDIR(old_inode->i_mode);
 	int err;
 
 	if (unlikely(f2fs_cp_error(sbi)))
@@ -1017,7 +1018,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		goto out;
 	}
 
-	if (S_ISDIR(old_inode->i_mode)) {
+	if (old_is_dir && old_dir != new_dir) {
 		old_dir_entry = f2fs_parent_dir(old_inode, &old_dir_page);
 		if (!old_dir_entry) {
 			if (IS_ERR(old_dir_page))
@@ -1029,7 +1030,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (new_inode) {
 
 		err = -ENOTEMPTY;
-		if (old_dir_entry && !f2fs_empty_dir(new_inode))
+		if (old_is_dir && !f2fs_empty_dir(new_inode))
 			goto out_dir;
 
 		err = -ENOENT;
@@ -1054,7 +1055,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 		inode_set_ctime_current(new_inode);
 		f2fs_down_write(&F2FS_I(new_inode)->i_sem);
-		if (old_dir_entry)
+		if (old_is_dir)
 			f2fs_i_links_write(new_inode, false);
 		f2fs_i_links_write(new_inode, false);
 		f2fs_up_write(&F2FS_I(new_inode)->i_sem);
@@ -1074,12 +1075,12 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto out_dir;
 		}
 
-		if (old_dir_entry)
+		if (old_is_dir)
 			f2fs_i_links_write(new_dir, true);
 	}
 
 	f2fs_down_write(&F2FS_I(old_inode)->i_sem);
-	if (!old_dir_entry || whiteout)
+	if (!old_is_dir || whiteout)
 		file_lost_pino(old_inode);
 	else
 		/* adjust dir's i_pino to pass fsck check */
@@ -1105,8 +1106,8 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		iput(whiteout);
 	}
 
-	if (old_dir_entry) {
-		if (old_dir != new_dir && !whiteout)
+	if (old_is_dir) {
+		if (old_dir_entry && !whiteout)
 			f2fs_set_link(old_inode, old_dir_entry,
 						old_dir_page, new_dir);
 		else
-- 
2.39.2


