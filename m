Return-Path: <linux-fsdevel+bounces-3825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0607F8E89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 21:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46CC7B21341
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 20:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808B230F8B;
	Sat, 25 Nov 2023 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fvIi7k46"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657F3127;
	Sat, 25 Nov 2023 12:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=T08sUyzdKaybfEkZCNae4ocOGsjYgJj1qnspFJtuRWw=; b=fvIi7k46RHfJK7RTy5TGozS6Ua
	XAdcnLEO4sw2DJk9NFpGgleDZrmOVdFvPyviE+d6EH/kn7S6fvGNbfgLJ/E+AjrJwYynr6vqADksd
	J9xfEMbHbnp2gEWGmlnDhmI7keINg1U/P8lyVAX/PwYPXtFS9lUafIk8HHpfMyeUk8BxfIl1q24xM
	2Gg00raJtCN1PVCh4NqJm7w9Xk5hA/bmPxJuopyulFZU4a7JcbcQKMt/v0/LEfK8R/BKH3lPTUI4X
	4cKgtDVX69Lq1layYaICqnkS6tTZnUkgqq8DLSxwyESGcx5C/q+gWu/axyLhZdRTAzzR1i3B4dngF
	7HDkW05A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6z0F-003A4f-35;
	Sat, 25 Nov 2023 20:11:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mo Zou <lostzoumo@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] ext2: Avoid reading renamed directory if parent does not change
Date: Sat, 25 Nov 2023 20:11:42 +0000
Message-Id: <20231125201147.753695-4-viro@zeniv.linux.org.uk>
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
change. Change ext2 rename code to avoid reading renamed directory if
its parent does not change. Although it is currently harmless it is a
bad practice to read directory contents without inode->i_rwsem.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ext2/namei.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 65f702b1da5b..8346ab9534c1 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -325,6 +325,7 @@ static int ext2_rename (struct mnt_idmap * idmap,
 	struct ext2_dir_entry_2 * dir_de = NULL;
 	struct folio * old_folio;
 	struct ext2_dir_entry_2 * old_de;
+	bool old_is_dir = S_ISDIR(old_inode->i_mode);
 	int err;
 
 	if (flags & ~RENAME_NOREPLACE)
@@ -342,7 +343,7 @@ static int ext2_rename (struct mnt_idmap * idmap,
 	if (IS_ERR(old_de))
 		return PTR_ERR(old_de);
 
-	if (S_ISDIR(old_inode->i_mode)) {
+	if (old_is_dir && old_dir != new_dir) {
 		err = -EIO;
 		dir_de = ext2_dotdot(old_inode, &dir_folio);
 		if (!dir_de)
@@ -354,7 +355,7 @@ static int ext2_rename (struct mnt_idmap * idmap,
 		struct ext2_dir_entry_2 *new_de;
 
 		err = -ENOTEMPTY;
-		if (dir_de && !ext2_empty_dir (new_inode))
+		if (old_is_dir && !ext2_empty_dir(new_inode))
 			goto out_dir;
 
 		new_de = ext2_find_entry(new_dir, &new_dentry->d_name,
@@ -368,14 +369,14 @@ static int ext2_rename (struct mnt_idmap * idmap,
 		if (err)
 			goto out_dir;
 		inode_set_ctime_current(new_inode);
-		if (dir_de)
+		if (old_is_dir)
 			drop_nlink(new_inode);
 		inode_dec_link_count(new_inode);
 	} else {
 		err = ext2_add_link(new_dentry, old_inode);
 		if (err)
 			goto out_dir;
-		if (dir_de)
+		if (old_is_dir)
 			inode_inc_link_count(new_dir);
 	}
 
@@ -387,7 +388,7 @@ static int ext2_rename (struct mnt_idmap * idmap,
 	mark_inode_dirty(old_inode);
 
 	err = ext2_delete_entry(old_de, old_folio);
-	if (!err && dir_de) {
+	if (!err && old_is_dir) {
 		if (old_dir != new_dir)
 			err = ext2_set_link(old_inode, dir_de, dir_folio,
 					    new_dir, false);
-- 
2.39.2


