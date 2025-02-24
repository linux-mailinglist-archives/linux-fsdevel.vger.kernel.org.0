Return-Path: <linux-fsdevel+bounces-42523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6D6A42EE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8315C3A75F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4ED1FC10C;
	Mon, 24 Feb 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Gd8vKzW8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D31DB365
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432057; cv=none; b=u3m+n5hHMS3mQQ3g+np/83Ahi8Od9RzxcvfoGuPOv+OixoOFuF+100R3TN/B6h99fOHTgUkbQOGht8z80lAxzGEYjSbcm53Z03bNtIXRhktDSUtPQlCdLYkBGCmxImIjvwLSEzE0HlxwTLqibQgqrXFUPeZdVpFtknlr5g5ObmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432057; c=relaxed/simple;
	bh=hSOG7xe+/GVqAfdCPIjEuY0FzmW4woWIO62hXEvnXjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oi4nMphBS11v3n8BGXTIUjphzjwN765Eo3L8QUZ3fIyEB6nGn/AQ8go0iRYAtBnRQKCkEFAQLkObTQDOTZ6vCJ1AYf4IFD+OyTOxCi2qCQjzXgtCZzm2IHuBlotAnezbcRjSrjdYFiiPtUehG+xMoiIXFXBZ5C/UogNs5alXo0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Gd8vKzW8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kQxbqwabztLHj1KjTc0ureYK+atGoV7lXfY1w60QLO4=; b=Gd8vKzW80GoEfHiovQCaC7ea24
	WCVTOW01dBif2tYqrOtF0ebMZjMVa74qXk5N3/H/suxm9tFXgNh055PNDwL4XEJh/9E++GYrYEyD5
	JdBjjkOcSLOXTASkV69gOeyYqSdD5L8hr8baqU+YeVmpLhTUKXUxbMOTPsqJD9Gw6YJ9j3rUVlY3o
	fHkcBtdbgCww5wg1hLo8DKiREFSsMsW+cAXtPlXKLdJOb+wiPsuSu+q0G39lqGp1yGG3VWMGG02NB
	RzJdJVlGy5jBvvXf03FU65F9yuX25vJU+igvKN8YflEId+b0KGsmkI2EwoH9HHUu10vfVLNBaJD0J
	Fuy/gK6w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsj-00000007Mz2-1dtd;
	Mon, 24 Feb 2025 21:20:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 16/21] ramfs, hugetlbfs, mqueue: set DCACHE_DONTCACHE
Date: Mon, 24 Feb 2025 21:20:46 +0000
Message-ID: <20250224212051.1756517-16-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

makes simple_lookup() slightly cheaper there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hugetlbfs/inode.c | 1 +
 fs/ramfs/inode.c     | 1 +
 ipc/mqueue.c         | 1 +
 3 files changed, 3 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 0fc179a59830..205dd7562be1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1431,6 +1431,7 @@ hugetlbfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize_bits = huge_page_shift(ctx->hstate);
 	sb->s_magic = HUGETLBFS_MAGIC;
 	sb->s_op = &hugetlbfs_ops;
+	sb->s_d_flags = DCACHE_DONTCACHE;
 	sb->s_time_gran = 1;
 
 	/*
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 8006faaaf0ec..c4ee67870c4b 100644
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
index 35b4f8659904..dbd5c74eecb2 100644
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


