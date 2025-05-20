Return-Path: <linux-fsdevel+bounces-49479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 558C0ABCE88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 07:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD84B1883952
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 05:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22D25CC69;
	Tue, 20 May 2025 05:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xTX4ys/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBEE25B671
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718179; cv=none; b=Q2IRPsp6vgYzfjt6Vgcf98+bD1SVHOeOqTq2/1O86JpF0FB4+DNA+rCMeoVnC+3arNuCUOp5cRQXjDpwuuS7d7kPcuQG8a7OTedpYW3kSziEMcEzUBvmr+gA/38K0vusEENp3LpaH75Jesku6hoBgjJH0CDm9uR8ibULuJpN90U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718179; c=relaxed/simple;
	bh=ckfgp5cSo5K5k1rAontem8yZ2aUqnKaCPUb6Zy3JpNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5pNYNuXqjuyIZb+RyJDvn+ajwK538xy8iJ+QiFKkCnW3vBfenJ09Q2y3qQY4Y5LEgESSxyyCDBlOYbRr/xQmXIQTqcD5kIcNCSbGpoFSWp613Fl74s/59H97cmo3iO6Dd5i76DCyk3P7gL7xGS9osbRNRVgtJ2zZBxc7/bnDc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xTX4ys/h; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747718175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tyGTr5uf1FpOqkJ6li2TLa5npwmkkdAbemi7PJM5Xs=;
	b=xTX4ys/hOr8D50A+DkeqPIH+ve4DprVZXSh3TJdQm91HkvlXJS568/3duBtbZ7R7XSZYR+
	6c+CjezmJwp4td1Lcs2MrcjEqEnMUn5WXWZNJafdfVI4CQdUHsEXLEvbboGja9DFFtSyfS
	cBvluvPA+HM3Tsiwku7Nzq0WwVUEikg=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 5/6] bcachefs: Hook up d_casefold_enable()
Date: Tue, 20 May 2025 01:15:57 -0400
Message-ID: <20250520051600.1903319-6-kent.overstreet@linux.dev>
In-Reply-To: <20250520051600.1903319-1-kent.overstreet@linux.dev>
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hook up BCH_INODE_has_case_insensitive -> S_NO_CASEFOLD, and call the
new dcache methods for exclusion with overlayfs when the flag is
changing.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/fs.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 0b5d52895e05..a02f787a6d05 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -68,6 +68,11 @@ static inline void bch2_inode_flags_to_vfs(struct bch_fs *c, struct bch_inode_in
 		inode->v.i_flags |= S_CASEFOLD;
 	else
 		inode->v.i_flags &= ~S_CASEFOLD;
+
+	if (inode->ei_inode.bi_flags & BCH_INODE_has_case_insensitive)
+		inode->v.i_flags &= ~S_NO_CASEFOLD;
+	else
+		inode->v.i_flags |= S_NO_CASEFOLD;
 }
 
 void bch2_inode_update_after_write(struct btree_trans *trans,
@@ -916,6 +921,8 @@ static int bch2_rename2(struct mnt_idmap *idmap,
 	struct bch_inode_info *dst_inode = to_bch_ei(dst_dentry->d_inode);
 	struct bch_inode_unpacked dst_dir_u, src_dir_u;
 	struct bch_inode_unpacked src_inode_u, dst_inode_u, *whiteout_inode_u;
+	struct d_casefold_enable casefold_enable_src = {};
+	struct d_casefold_enable casefold_enable_dst = {};
 	struct btree_trans *trans;
 	enum bch_rename_mode mode = flags & RENAME_EXCHANGE
 		? BCH_RENAME_EXCHANGE
@@ -940,6 +947,21 @@ static int bch2_rename2(struct mnt_idmap *idmap,
 			 src_inode,
 			 dst_inode);
 
+	if (src_dir != dst_dir) {
+		if (bch2_inode_casefold(c, &src_inode->ei_inode)) {
+			ret = d_casefold_enable(dst_dentry, &casefold_enable_dst);
+			if (ret)
+				goto err;
+		}
+
+		if (mode == BCH_RENAME_EXCHANGE &&
+		    bch2_inode_casefold(c, &dst_inode->ei_inode)) {
+			ret = d_casefold_enable(src_dentry, &casefold_enable_src);
+			if (ret)
+				goto err;
+		}
+	}
+
 	trans = bch2_trans_get(c);
 
 	ret   = bch2_subvol_is_ro_trans(trans, src_dir->ei_inum.subvol) ?:
@@ -1044,6 +1066,9 @@ static int bch2_rename2(struct mnt_idmap *idmap,
 			   src_inode,
 			   dst_inode);
 
+	d_casefold_enable_commit(&casefold_enable_dst, ret);
+	d_casefold_enable_commit(&casefold_enable_src, ret);
+
 	return bch2_err_class(ret);
 }
 
@@ -1710,6 +1735,7 @@ static int bch2_fileattr_set(struct mnt_idmap *idmap,
 	struct bch_inode_info *inode = to_bch_ei(d_inode(dentry));
 	struct bch_fs *c = inode->v.i_sb->s_fs_info;
 	struct flags_set s = {};
+	struct d_casefold_enable casefold_enable = {};
 	int ret;
 
 	if (fa->fsx_valid) {
@@ -1742,9 +1768,17 @@ static int bch2_fileattr_set(struct mnt_idmap *idmap,
 		s.casefold = (fa->flags & FS_CASEFOLD_FL) != 0;
 		fa->flags &= ~FS_CASEFOLD_FL;
 
+		if (s.casefold) {
+			ret = d_casefold_enable(dentry, &casefold_enable);
+			if (ret)
+				goto err;
+		}
+
 		s.flags |= map_flags_rev(bch_flags_to_uflags, fa->flags);
-		if (fa->flags)
-			return -EOPNOTSUPP;
+		if (fa->flags) {
+			ret = -EOPNOTSUPP;
+			goto err;
+		}
 	}
 
 	mutex_lock(&inode->ei_update_lock);
@@ -1755,6 +1789,9 @@ static int bch2_fileattr_set(struct mnt_idmap *idmap,
 		bch2_write_inode(c, inode, fssetxattr_inode_update_fn, &s,
 			       ATTR_CTIME);
 	mutex_unlock(&inode->ei_update_lock);
+err:
+	d_casefold_enable_commit(&casefold_enable, ret);
+
 	return ret;
 }
 
-- 
2.49.0


