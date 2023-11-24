Return-Path: <linux-fsdevel+bounces-3626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B86D7F6C17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1644A281142
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D48AD4B;
	Fri, 24 Nov 2023 06:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="b2Bq2tgz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F861BC2;
	Thu, 23 Nov 2023 22:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Uudj7kC5X7EPH72uDZs9RHVMmZaQqoTHgWgAXC5FG5U=; b=b2Bq2tgz7MuCyU4P1LAKbg2hCp
	6DrIF63BbJgJgvys1j48vNBZS/EECYwMEQRaTI2+ulUbRST3tSMj7eFKSoHz6F0O69IBhC5ckLiUr
	4mmZkqfvDdhZViGl+U42xm0FYh8lNAiVTS+MXHThfw8Y0j/4X1b3HhZEqRzZ4Ubadk7WnOzyhNBfS
	jH5F+kqKY5GbJgDqB5X0LrCFrZETFeCo+TpPV4ojLl4tVJ+liv4SxkcX6cHMMpHl02j+X6rAnwk4D
	bY7W6AHKow4xwDKUfQA9etqqWa5SS/3mRfOGAEN9U8Ms5FK/RfRytYASHv26IvqaRuCnJPVcPcuFh
	buPdTsoA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PKw-002Q1R-2o;
	Fri, 24 Nov 2023 06:06:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/20] simple_fill_super(): don't bother with d_genocide() on failure
Date: Fri, 24 Nov 2023 06:06:38 +0000
Message-Id: <20231124060644.576611-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Failing ->fill_super() will be followed by ->kill_sb(), which should
include kill_litter_super() if the call of simple_fill_super() had
been asked to create anything besides the root dentry.  So there's
no need to empty the partially populated tree - it will be trimmed
by inevitable kill_litter_super().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/libfs.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index e9440d55073c..6fa8ad36049f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -912,7 +912,6 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
 		      const struct tree_descr *files)
 {
 	struct inode *inode;
-	struct dentry *root;
 	struct dentry *dentry;
 	int i;
 
@@ -935,8 +934,8 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	set_nlink(inode, 2);
-	root = d_make_root(inode);
-	if (!root)
+	s->s_root = d_make_root(inode);
+	if (!s->s_root)
 		return -ENOMEM;
 	for (i = 0; !files->name || files->name[0]; i++, files++) {
 		if (!files->name)
@@ -948,13 +947,13 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
 				"with an index of 1!\n", __func__,
 				s->s_type->name);
 
-		dentry = d_alloc_name(root, files->name);
+		dentry = d_alloc_name(s->s_root, files->name);
 		if (!dentry)
-			goto out;
+			return -ENOMEM;
 		inode = new_inode(s);
 		if (!inode) {
 			dput(dentry);
-			goto out;
+			return -ENOMEM;
 		}
 		inode->i_mode = S_IFREG | files->mode;
 		simple_inode_init_ts(inode);
@@ -962,13 +961,7 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
 		inode->i_ino = i;
 		d_add(dentry, inode);
 	}
-	s->s_root = root;
 	return 0;
-out:
-	d_genocide(root);
-	shrink_dcache_parent(root);
-	dput(root);
-	return -ENOMEM;
 }
 EXPORT_SYMBOL(simple_fill_super);
 
-- 
2.39.2


