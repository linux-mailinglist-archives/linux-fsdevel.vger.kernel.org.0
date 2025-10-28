Return-Path: <linux-fsdevel+bounces-65816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2CBC12425
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 01:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED49F1A21383
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 00:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E64929CB3A;
	Tue, 28 Oct 2025 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="f4JAKTKO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A1E1F4CBB;
	Tue, 28 Oct 2025 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612384; cv=none; b=Xy5H7vKp1S1X0QFKjwRWCgAoRbcR3h70sm5+MfDsu0Ch+VOiCpP/oxb7yV8pqQ4qfNZVtVww2p6BWbGuzth9DclgujTb1D9H/1b2a7AZuXiRFsBHePGt5aQpBLkUj2WHYHCsljUIeMvmwP8XcVVS1qv2LZ4Eqr/WBaZx5ybNq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612384; c=relaxed/simple;
	bh=3/7wTnp+BUluB0yOKxyyf9McG0O9FqLVmSTXxagaJjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgAPxzwTyAHTJMK96an3lEMhTvcR1nyY/MqfBmbGNDoIFWQ0WF8o4WwsU738Ld1G0lTzKRCIisPyWyk3W1p+t3PJA/2KCMoNXORiDtYzb5YcD/ZgW+g6bpr0sq35N+vPt07IZdZaTTZj7j4SPf69iAS1haEKVyWII4l5W9UUYd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=f4JAKTKO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wxn4MG/UuDcxk84tNsHI6sa3Q9kQYypoP2eBG9UjNw0=; b=f4JAKTKOyUvAjdLI7hZUAhoUfo
	Umj1X11GLfW5MbBiC38ur+8xzYipcDH16+43VSUxKfs/lHaISaeSkVzRaNpFTfyFUYCY+KdHM7KhI
	vD1SFb1t0huHy5LzNuaYBee+aQ8MI356K8GTabzz8vwPsHYG8ARquVPAV0jwve8cZLy6+IaB33B/a
	vx+dI7d90jzzbg/JvrMvk8K3ehJlOqP7J33X9UucwIFiY8i8I80AxuBEIDHDi4WAk1toaAkb+9/68
	MB4VBC0i7KQg5RZoG7H1S/o1eUUEBvKV8dC1zGT/SYE4rP1NzvzsSmrHwljXjO/LoS0yILwrLxu0O
	+p944aPg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqr-00000001eYS-0CJN;
	Tue, 28 Oct 2025 00:46:17 +0000
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
Subject: [PATCH v2 23/50] convert spufs
Date: Tue, 28 Oct 2025 00:45:42 +0000
Message-ID: <20251028004614.393374-24-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 7ec60290abe6..f21f7a76ef0b 100644
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
 	inc_nlink(d_inode(dentry));
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


