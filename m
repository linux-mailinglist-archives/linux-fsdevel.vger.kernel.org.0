Return-Path: <linux-fsdevel+bounces-48017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E37AA8B3F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 05:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8130F3A6FFD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 03:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC8F19CD01;
	Mon,  5 May 2025 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Uoh85/wN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329BA130A7D;
	Mon,  5 May 2025 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746414230; cv=none; b=RXKAUJUHpC7Btdqv8nN6oeDDiRuq5gjsg2/1c9vgvalIHOzR7GyllG22O5HqJHr/ErCtJeTsD7t8EfmcS0XHtPJk5V0byjn8tIIW7w6rV8aMcfKBavfU8EfAG9Ha8qU5EJD1B704q/16koEIa//zzx4xYPDGO+9oXm2pbHEcUeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746414230; c=relaxed/simple;
	bh=lrKF2jdld1kATsiwUl0xDPfRpz5qxj+02SVe9yfWyrM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nH0MuVc+w63A83pRhC74pHRvaVSgf32myKgL/LCmvkyMXUGN8gNuCtowoXtgBO9cmVibu9+eCMq9gz74IY/I8I78TUJdTRYdfB4Ghdvg3QIKpF6cUQwqg5T3fMMAwj1kngrmiAwNgpjR2Z5o6KYBI49yA2VilelKPR12h4+kT4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Uoh85/wN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YqfIve3mOMD666HaSsd18Gvt8Vrj20e45FaBuwKQfSM=; b=Uoh85/wNJJZhg14yWpxaExYci2
	gxJ20PMGjOTx8gMT1kdJaDKK8hLSXYXE3ldgEWrsBBtw/xGQLX53ggSIMGtQNNLPpQLst+bGfgAa9
	cPb5mOSxsq+hbYOPof2VXblG4VfBjhn7n/amTbEP7wb9m3Y080c9ovaZdBDLEFAzFZ9XIK1EtuTOq
	HjHn2228KfmpwsYOyiX7lBWLyvFFCFED1MxuGwoTTrDYD6miDcy9fnSfVUUvuIF7BkTTfAH170iPD
	dnoHZ+VF7m05PUEgJ19blI0A3lC+p1uzljQRYdN112nVhR7UK4ZLS373XBRAU795pMv18DHA1NW2Q
	0K2nCSnQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBm7N-00000001P5E-1ZOm;
	Mon, 05 May 2025 03:03:45 +0000
Date: Mon, 5 May 2025 04:03:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250505030345.GD2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

it's simpler to do btrfs_reconfigure_for_mount() right after vfs_get_tree() -
no need to mess with ->s_umount.

Objections?
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7121d8c7a318..a3634e7f2304 100644
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
+		mnt = vfs_create_mount(fc);
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

