Return-Path: <linux-fsdevel+bounces-51256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4EAAD4D9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B69117C4F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D959248166;
	Wed, 11 Jun 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CcFmctSt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A823A9AE
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628484; cv=none; b=pzluVT1zscJXnoe6MJJ2MZ1haLSimcEmivfZq5BCW27q7b7LBid31MC57ZCzINy+1FBkPqkuVe90C2w0rhWZCSotbhoad76TVpoS2qFyeRGnm24STXIoodGpYu6HXT8FUuxpq7Fj3F1H/41v0XH4roronZA2bn7gykekZP2yCXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628484; c=relaxed/simple;
	bh=NE6KtK7Y41l34gILJHUJmblJKMcZJ8Zi0d0I3/jFB+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btsEfPvCgUizjLXaGbJfeU49QgjOExnuReAZX4fCBeWl1vp45rudR+7CAJQ8asQ12tah5GLpNO3mBYrYcxUiKRS5U4B4Qog4GXqSFYVI38j/ybWzQw9g2vCjoOqBuJ7fTo3/38kfMHUD5sA3XScYZU99W29sA9ppljnOiYhcF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CcFmctSt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SHHs6S0xBH4lPtIr2fNbvJWNztXLX80K/+8kp0iOyVc=; b=CcFmctStmwiOWGYLrKtf+8KNOn
	3jUT958foq1qTWKHt0LX/okagLg9gPZUwFFqsI/gBaxEsPfiEsKVqlYA5nXQPQg4ZgDoxnDiaGjEA
	RlzQALCHr79HorjjlonH8vFxwpWiCxWK7tdqofQQOznAuT7nZdu07f/gI9dKfIN1KS+4pDyiLGKU3
	kdG7MOmwNd8/XzWc5KoiFeDbLHD3JSRUtK2RgMu7G/gn/iSnbyDheM3dSUZeLG6E22Wa2F8DYjRq/
	Gcz44Axtj091krgEMBT+1G7EtyioY4M9NXetLi6R+ZiHRT91akx1sx3vawyBpUsa2pMXyshuaAI2T
	JaF26nhg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIC-0000000HTyU-0pc9;
	Wed, 11 Jun 2025 07:54:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 16/21] ramfs, hugetlbfs, mqueue: set DCACHE_DONTCACHE
Date: Wed, 11 Jun 2025 08:54:32 +0100
Message-ID: <20250611075437.4166635-16-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

makes simple_lookup() slightly cheaper there - no need for
simple_lookup() to set the flag and we want it on everything
on those anyway.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hugetlbfs/inode.c | 1 +
 fs/ramfs/inode.c     | 1 +
 ipc/mqueue.c         | 1 +
 3 files changed, 3 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e4de5425838d..6e0ade365a33 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1433,6 +1433,7 @@ hugetlbfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize_bits = huge_page_shift(ctx->hstate);
 	sb->s_magic = HUGETLBFS_MAGIC;
 	sb->s_op = &hugetlbfs_ops;
+	sb->s_d_flags = DCACHE_DONTCACHE;
 	sb->s_time_gran = 1;
 
 	/*
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 775fa905fda0..f8874c3b8c1e 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -269,6 +269,7 @@ static int ramfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize_bits	= PAGE_SHIFT;
 	sb->s_magic		= RAMFS_MAGIC;
 	sb->s_op		= &ramfs_ops;
+	sb->s_d_flags		= DCACHE_DONTCACHE;
 	sb->s_time_gran		= 1;
 
 	inode = ramfs_get_inode(sb, NULL, S_IFDIR | fsi->mount_opts.mode, 0);
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 82ed2d3c9846..482af449e00d 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -411,6 +411,7 @@ static int mqueue_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = MQUEUE_MAGIC;
 	sb->s_op = &mqueue_super_ops;
+	sb->s_d_flags = DCACHE_DONTCACHE;
 
 	inode = mqueue_get_inode(sb, ns, S_IFDIR | S_ISVTX | S_IRWXUGO, NULL);
 	if (IS_ERR(inode))
-- 
2.39.5


