Return-Path: <linux-fsdevel+bounces-3824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C747F8E85
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 21:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1276281560
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 20:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385F630D1C;
	Sat, 25 Nov 2023 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XcMyRMly"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CF413A;
	Sat, 25 Nov 2023 12:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1kXdQTzP9QbMwip9HhQkODeDCTy6uPz4pJDbGLrfwH4=; b=XcMyRMlyK2J+etyO+6P/aIB6ik
	pLcqvGbY9qBE5zywvQUnOf0X3uLFW0H/OpUKVdiK04VPwNrsLqjvhPHBz9mOKokwiHL9YFDTv+FT2
	xtdJNbOEYAiUQlO2MBcaUBIk5/NjtuNmJTJZJC7ASCA5Mh0608tTMX5KwYtwL62OAKo35eWjOkmWH
	D9vMKMvDO4yEXVLkvxxOMgzDA0Ofw5bVdAbdVMv+hfTKPEzIO0B572Fm+Xfe5WQ3qpZpThf6yTB0W
	xZ/ltCn0C1GTsqp7raqEB7lXB+1gCCvH1FIHNnzRvrqzcyTzX2pBtst2B70lIa6sSLgR+94M8A7HX
	O/s6m2Pw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6z0G-003A4n-0j;
	Sat, 25 Nov 2023 20:11:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mo Zou <lostzoumo@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] f2fs: Avoid reading renamed directory if parent does not change
Date: Sat, 25 Nov 2023 20:11:44 +0000
Message-Id: <20231125201147.753695-6-viro@zeniv.linux.org.uk>
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


