Return-Path: <linux-fsdevel+bounces-48295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB67AACE7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 21:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8143AABAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970ED214228;
	Tue,  6 May 2025 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WcQ6zKjx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04E20E00C;
	Tue,  6 May 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561511; cv=none; b=Exaq5QdROFIpv0OVeuP37tidhFz3pnfYZI5gZ4WN6q0xgdywJPsjX8He0pctqNpRfoZGCyplJ1op//KRLEIsNoPSX1MtFOjCeQE+XFiSfuTjtqGuN3B+UL1j5zH/FlVR4bxa4bhoiJZjHfTvBwiI0zhLxylzj26xCUYPkNpyvNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561511; c=relaxed/simple;
	bh=rEPx8iJjw2X5m8OouvWivkuOZ/bXpwu2Avpiksdr/f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHi8L458q+Q4hTgzghFRnrsmOQF4AAYl0cHR0RpT3Ln5bUubFKUw3EcNBe09u5+jEyZhwYpza5cB6Zc0jqy9HvryKrdNpy8T0n5fcJUmhCU17Mc2jX+pcBKVrQAk+PcCDEDplhtNBceJqZvSba8O2EfXQOvafR/77GiBmaaIzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WcQ6zKjx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SC6a0V4vn7iz3VjzdsZsGWnMiZloNKafFnbcjEjRF3k=; b=WcQ6zKjxkH0Dhqe+WTO2kR2kzp
	nNYGTBnwiioKrrN7UfdKW4apj23XU1CrqC5zSjUM0AhuEeznQFABu4FJvyBsi9AhSEuOCmFNQnrPT
	RI8//wTtTifjRW6bE+W9w/qf/j2SETP4X5/Ay0wQTHIrKG6X5QVdO8pIY0YbY1C9jHwAxno6VS367
	AqkIsxU6tfR61P/zXIcUimrLylLOR6xiElyrKJ0lVfzGPO7BSEBEJEtZKtuZUpahExUZu/f/4VIMk
	BQp954dDe7lm400aDbJieXvYwQI9JlxpmtZY//O23aPGLxYohI8miC02WV3xn5whARjFXNQgVWOat
	hQhqzovw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOQs-0000000CT37-2VpF;
	Tue, 06 May 2025 19:58:26 +0000
Date: Tue, 6 May 2025 20:58:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Klara Modin <klarasmodin@gmail.com>
Subject: [PATCH v3] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250506195826.GU2023217@ZenIV>
References: <20250505030345.GD2023217@ZenIV>
 <20250506193405.GS2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506193405.GS2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[Aaarghh...]
it's simpler to do btrfs_reconfigure_for_mount() right after vfs_get_tree() -
no need to mess with ->s_umount.
    
[fix for braino(s) folded in - kudos to Klara Modin <klarasmodin@gmail.com>]
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7121d8c7a318..592ed044340c 100644
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
+		up_write(&dup_fc->root->d_sb->s_umount);
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

