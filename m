Return-Path: <linux-fsdevel+bounces-48290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2664AACE1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 21:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C431C237FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2C91A42C4;
	Tue,  6 May 2025 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="L3DKkaJZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649FC4B1E5C;
	Tue,  6 May 2025 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560049; cv=none; b=qpcMbN0C4gggT62xtaG0v5u+bUqt0ArJoTHsluyLCMoN5bJiB72E1xX4jnTEdauwEWVKwnpkw40z1tottMPcwKSoDdfcpgma6X6vjnPkvGkwLSKG8V8swzjG8vnstuBJH/JlRP3xGrlOkxRdjJMy7Qd7O6LYVBhgqSzVimSumk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560049; c=relaxed/simple;
	bh=M/ZGWLCsT/TDTgDTDiNylFd+K4ZNKYMDrHPhnqhTAWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckuRrL/2kOLVBSVHNDTG8qVG92osW1kE4GrkmgQnjic7rXccayueChVQLuYFxEJUXTmuIZWi83hpz4B0ALZbib65Fe5ePL1EwAH7cBOY6SrvCYzhtUfH9cYH5gijZLI1huW0CQksJv/1rLcPEcZhwqu0THqx0wQ/oF1FPIeME88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=L3DKkaJZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=scdhlzWH163saw8mFZb/EITu8VJKW1SO/XCiq0AF5nw=; b=L3DKkaJZhjI81k4vBg3ldyM6iG
	fvbIeqUlU8/rIWBxjhzYxtTqD4X7rSU/fgU7i8eVef7p325HB+FTR8nL1nFjKqqL2Ta7LGScewtBK
	wY2lNTojeDBtqToZXjNF+l9ALqZhM/7LT9r5zDa7hS+n25UAS9iSs2e76BbbDFYNjzqbOz+0KkLdB
	rqSUwYadZt9szvmfIz7siC6wIbXOw0tSMb2FyiXh8wzDSAj2aDdIzL6KEMQzp1W4+GDBAtYqVksb3
	e82GAucx3V7cUBu2/ho8f/7oXBP9lo+V3pD7Damqs5kfrahPtTVTkeXeNbfBpahJoa0+l2eo81eei
	W4NSId2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCO3J-0000000CLlI-1wRx;
	Tue, 06 May 2025 19:34:05 +0000
Date: Tue, 6 May 2025 20:34:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Klara Modin <klarasmodin@gmail.com>
Subject: [PATCH v2] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250506193405.GS2023217@ZenIV>
References: <20250505030345.GD2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505030345.GD2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

it's simpler to do btrfs_reconfigure_for_mount() right after vfs_get_tree() -
no need to mess with ->s_umount.
    
[fix for braino(s) folded in - kudos to Klara Modin <klarasmodin@gmail.com>]
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7121d8c7a318..75934b25ff47 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1984,17 +1984,13 @@ static int btrfs_get_tree_super(struct fs_context *fc)
  * btrfs or not, setting the whole super block RO.  To make per-subvolume mounting
  * work with different options work we need to keep backward compatibility.
  */
-static int btrfs_reconfigure_for_mount(struct fs_context *fc, struct vfsmount *mnt)
+static int btrfs_reconfigure_for_mount(struct fs_context *fc)
 {
 	int ret = 0;
 
-	if (fc->sb_flags & SB_RDONLY)
-		return ret;
-
-	down_write(&mnt->mnt_sb->s_umount);
-	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
+	if (!(fc->sb_flags & SB_RDONLY) && (fc->root->d_sb->s_flags & SB_RDONLY))
 		ret = btrfs_reconfigure(fc);
-	up_write(&mnt->mnt_sb->s_umount);
+
 	return ret;
 }
 
@@ -2047,17 +2043,18 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 	security_free_mnt_opts(&fc->security);
 	fc->security = NULL;
 
-	mnt = fc_mount(dup_fc);
-	if (IS_ERR(mnt)) {
-		put_fs_context(dup_fc);
-		return PTR_ERR(mnt);
+	ret = vfs_get_tree(dup_fc);
+	if (!ret) {
+		ret = btrfs_reconfigure_for_mount(dup_fc);
+		up_write(&fc->root->d_sb->s_umount);
 	}
-	ret = btrfs_reconfigure_for_mount(dup_fc, mnt);
+	if (!ret)
+		mnt = vfs_create_mount(dup_fc);
+	else
+		mnt = ERR_PTR(ret);
 	put_fs_context(dup_fc);
-	if (ret) {
-		mntput(mnt);
-		return ret;
-	}
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
 
 	/*
 	 * This free's ->subvol_name, because if it isn't set we have to

