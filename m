Return-Path: <linux-fsdevel+bounces-3462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D141A7F50BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 20:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC20281589
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 19:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC9958114;
	Wed, 22 Nov 2023 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VPI2OBDP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB0118E;
	Wed, 22 Nov 2023 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=T08sUyzdKaybfEkZCNae4ocOGsjYgJj1qnspFJtuRWw=; b=VPI2OBDPeBOUVnGE8jDPzdPwIB
	LdSM8NnPxd857Ws5I/vrvU6Eg5/bADwz0IMxB2X9tSjNjYDE+i6ZsCxz2Py4n4oznqunCDngsEAFq
	foFIfg83tyMxLfEqHcMcgzNLh1yNo+5OiGshcIEUp574A8fLJKxpZ3K4y11D5PKLdfQx9ivIQmGxg
	xwcdf1NNJ+pMb6U7IrpOLXf1mDO4HxF7OycX466XlxKoZbAOvS6GiDonodlA32g6T6cXseWxQl4cE
	LFJYbxG0CxrmiXGBiYgaupA727WG9wv+oJf0YU3qE5K9PPtYhdg6YAPnWHh06MODNTSx3NeCwiUlR
	Z0q+NFCg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5t1p-001l1k-05;
	Wed, 22 Nov 2023 19:36:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mo Zou <lostzoumo@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] ext2: Avoid reading renamed directory if parent does not change
Date: Wed, 22 Nov 2023 19:36:47 +0000
Message-Id: <20231122193652.419091-4-viro@zeniv.linux.org.uk>
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


