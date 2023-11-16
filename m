Return-Path: <linux-fsdevel+bounces-2940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC6A7EDB0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 06:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B6D9B20B61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 05:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396FAC8D5;
	Thu, 16 Nov 2023 05:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DtR5Rfdy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4272181
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 21:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pL9x/qlF0URqv9qHjS2gr076oNYkpmLKhf5sgiepgPU=; b=DtR5RfdyX6xEOywNgMrPIuIF4f
	9HbxkZ7VLf/4UaK6aFV8N+sWRSTTN9v2KMw0eKiS++WoKhXfRtu15u1xqyW4BSZqaZhHC7EHSzW6x
	qEYzM2d4KqGCC2y4mIHKfQ6ZX82Vn3EMuujBrNS9dxaJj0xFQ7lt51pO0i5+Z1HDVrP3OYd+VmxaO
	BMbAguasIN61dGNil+95aGsxwwiy/J3ixCfLRQVv+F6pNrkhaHYoq5efR+EcbXIM3uqxHgQ9TcJbT
	uWo2iEPKo99N1hAE09PJv89Mg+9kSIF5rV9k8hZsi3v3Nc3C3RlVWBdeLWLRlBxpPzi2TNn1kwSav
	GcpoYL3g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r3UdP-00GOck-1W;
	Thu, 16 Nov 2023 05:09:47 +0000
Date: Thu, 16 Nov 2023 05:09:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 2/2] bch2_ioctl_subvolume_destroy(): fix locking
Message-ID: <20231116050947.GA3907833@ZenIV>
References: <20231116050832.GX1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116050832.GX1957730@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

(#for-bcachefs, on top of #work.namei)
From bbe6a7c899e7f265c5a6d01a178336a405e98ed6 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 14 Nov 2023 18:52:42 -0500
Subject: [PATCH 2/2] bch2_ioctl_subvolume_destroy(): fix locking

make it use user_path_locked_at() to get the normal directory protection
for modifications, as well as stable ->d_parent and ->d_name in victim

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/bcachefs/fs-ioctl.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
index 5a39bcb597a3..c5ab5a2dc9be 100644
--- a/fs/bcachefs/fs-ioctl.c
+++ b/fs/bcachefs/fs-ioctl.c
@@ -453,33 +453,36 @@ static long bch2_ioctl_subvolume_create(struct bch_fs *c, struct file *filp,
 static long bch2_ioctl_subvolume_destroy(struct bch_fs *c, struct file *filp,
 				struct bch_ioctl_subvolume arg)
 {
+	const char __user *name = (void __user *)(unsigned long)arg.dst_ptr;
 	struct path path;
 	struct inode *dir;
+	struct dentry *victim;
 	int ret = 0;
 
 	if (arg.flags)
 		return -EINVAL;
 
-	ret = user_path_at(arg.dirfd,
-			(const char __user *)(unsigned long)arg.dst_ptr,
-			LOOKUP_FOLLOW, &path);
-	if (ret)
-		return ret;
+	victim = user_path_locked_at(arg.dirfd, name, &path);
+	if (IS_ERR(victim))
+		return PTR_ERR(victim);
 
-	if (path.dentry->d_sb->s_fs_info != c) {
+	if (victim->d_sb->s_fs_info != c) {
 		ret = -EXDEV;
 		goto err;
 	}
-
-	dir = path.dentry->d_parent->d_inode;
-
-	ret = __bch2_unlink(dir, path.dentry, true);
-	if (ret)
+	if (!d_is_positive(victim)) {
+		ret = -ENOENT;
 		goto err;
-
-	fsnotify_rmdir(dir, path.dentry);
-	d_delete(path.dentry);
+	}
+	dir = d_inode(path.dentry);
+	ret = __bch2_unlink(dir, victim, true);
+	if (!ret) {
+		fsnotify_rmdir(dir, victim);
+		d_delete(victim);
+	}
+	inode_unlock(dir);
 err:
+	dput(victim);
 	path_put(&path);
 	return ret;
 }
-- 
2.39.2


