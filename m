Return-Path: <linux-fsdevel+bounces-6557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6E381980D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3031C25225
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB33511732;
	Wed, 20 Dec 2023 05:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="v9NthIBF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B110A1E
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 05:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mOyXfYVwPc89DuE5B4EvXVBfXvHboDeUrEQljJ/mEGo=; b=v9NthIBFyGrGXW70gxY6lTs1tk
	GqqITvooROzcvpr92Fd1g4KaSQHTUtvmonKpXawNiyigIP/QM/CnTXmRpNPOkfkSbzHu4JXtgGNKh
	HSnb30RL6Pr/8ztLgAuTsLb7vOO25mCRFnIJfdFDAny2PHWfb15LUt7T4bP/gRAHjn44iKY3RmTfw
	0ibaEkqgPmSGVFRU/QD1xQZG2ITCU0EmD5PCA+2LpjsHm9mgN8JFKNhHYR78jYiMRknt6q2wqmYVM
	HE6WuiURCTo0csj2khIuKjaogm8bON2aezdu8w6KvdFz05jxEH0EkvOtM8wN+tY0f9MtYdS/5xjpu
	pn51dhXA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFp30-00HIwD-2P;
	Wed, 20 Dec 2023 05:23:10 +0000
Date: Wed, 20 Dec 2023 05:23:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: nilfs2: d_obtain_alias(ERR_PTR(...)) will do the right thing...
Message-ID: <20231220052310.GI1674809@ZenIV>
References: <20231220051348.GY1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220051348.GY1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nilfs2/namei.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 2a4e7f4a8102..8e8c7c981a7a 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -439,7 +439,6 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 static struct dentry *nilfs_get_parent(struct dentry *child)
 {
 	unsigned long ino;
-	struct inode *inode;
 	struct nilfs_root *root;
 
 	ino = nilfs_inode_by_name(d_inode(child), &dotdot_name);
@@ -448,11 +447,7 @@ static struct dentry *nilfs_get_parent(struct dentry *child)
 
 	root = NILFS_I(d_inode(child))->i_root;
 
-	inode = nilfs_iget(child->d_sb, root, ino);
-	if (IS_ERR(inode))
-		return ERR_CAST(inode);
-
-	return d_obtain_alias(inode);
+	return d_obtain_alias(nilfs_iget(child->d_sb, root, ino));
 }
 
 static struct dentry *nilfs_get_dentry(struct super_block *sb, u64 cno,
-- 
2.39.2


