Return-Path: <linux-fsdevel+bounces-67832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C6AC4BEB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C72F4F6F2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A952F357707;
	Tue, 11 Nov 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XROLldmC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8714346E40;
	Tue, 11 Nov 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844135; cv=none; b=QlO35v3UGLmyq41BohEKazOTjHOHHL6raQQCu/kRilE/87+BXwktKhmaaKbCVSvGt7e/v3fpdMa7YFOECvyYHBqmhn8YcF69i4NQ6Eer1PggpVvQPuWG4R4b6YoeLbqzdQWbIxP+K2GLCwRlPPPvZZ1/nl5chAatAdZdTdpvWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844135; c=relaxed/simple;
	bh=35MbVjxtToOQyUh5FTs7bBeOlum4Q1e4+S1+OrjjcRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okT5ewGBMx3nzU2wmrKF/2bcFNZmbII2DG97b8UHbui8oo/Trcc7tPZYkWRrFMA7/wTJJsh4OjD/slCNeEJaOlCYZDuwL/q67lrAP2+W+ELgOypv9Hn39fEi+TtHLzI6N4tpEB7galBeCcCh0Q0+1lJwBQoTHgzEE4UpaOWQSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XROLldmC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=o92Omq0psZ3ukvz3ytEXVDnarOtbezsCR+bO9JM0kAQ=; b=XROLldmCt6vbuYYnp0vPCUnJ5r
	4MIOfqGi3QUqBs/hPJsIwMOEeht/upSkaIWOnW2RidmjawMf5e6wCTzF33KPnTafLW1GSw2Si61YT
	heqXkOg8l0moj1QBWrtiM9s79RsazBTl7Awrry1FBsjrAvW/GRHjFGLCNSWHPimn+tVy8fVHPGQnb
	psoxEEp/YzziTl9UE5ntlhzLe7Ehqk4xBfnw9YvLvC+S2Wkt0YpkfZDjXgujxxk0wFO5OG772DyGu
	Y2k7crP+0mFlSAG6DRFWOmavK9Ut4mE2/AvyVdyQICVc3J3mhlf+B3B3qxi5YYSbQHia+dtZiqOul
	VPcxn56A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHl-0000000BwzL-1HAm;
	Tue, 11 Nov 2025 06:55:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: [PATCH v3 23/50] convert spufs
Date: Tue, 11 Nov 2025 06:54:52 +0000
Message-ID: <20251111065520.2847791-24-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

have spufs_new_file() use d_make_persistent() instead of d_add() and
do an uncondition dput() in the caller; the rest is completely
straightforward.

[a braino in spufs_mkgang() fixed]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 7ec60290abe6..fc8ccf4dc159 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -127,7 +127,7 @@ spufs_new_file(struct super_block *sb, struct dentry *dentry,
 	inode->i_fop = fops;
 	inode->i_size = size;
 	inode->i_private = SPUFS_I(inode)->i_ctx = get_spu_context(ctx);
-	d_add(dentry, inode);
+	d_make_persistent(dentry, inode);
 out:
 	return ret;
 }
@@ -163,10 +163,9 @@ static int spufs_fill_dir(struct dentry *dir,
 			return -ENOMEM;
 		ret = spufs_new_file(dir->d_sb, dentry, files->ops,
 					files->mode & mode, files->size, ctx);
-		if (ret) {
-			dput(dentry);
+		dput(dentry);
+		if (ret)
 			return ret;
-		}
 		files++;
 	}
 	return 0;
@@ -241,11 +240,10 @@ spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
 
 	inode_lock(inode);
 
-	dget(dentry);
 	inc_nlink(dir);
 	inc_nlink(inode);
 
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 
 	if (flags & SPU_CREATE_NOSCHED)
 		ret = spufs_fill_dir(dentry, spufs_dir_nosched_contents,
@@ -479,10 +477,9 @@ spufs_mkgang(struct inode *dir, struct dentry *dentry, umode_t mode)
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 
-	d_instantiate(dentry, inode);
-	dget(dentry);
 	inc_nlink(dir);
-	inc_nlink(d_inode(dentry));
+	inc_nlink(inode);
+	d_make_persistent(dentry, inode);
 	return ret;
 
 out_iput:
@@ -780,7 +777,7 @@ static struct file_system_type spufs_type = {
 	.name = "spufs",
 	.init_fs_context = spufs_init_fs_context,
 	.parameters	= spufs_fs_parameters,
-	.kill_sb = kill_litter_super,
+	.kill_sb = kill_anon_super,
 };
 MODULE_ALIAS_FS("spufs");
 
-- 
2.47.3


