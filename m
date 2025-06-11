Return-Path: <linux-fsdevel+bounces-51252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A63AD4D96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E534917BB6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EDF246335;
	Wed, 11 Jun 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="amqkUVIe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401023C39A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628483; cv=none; b=ZKMNO5A7TSGBAkbcJQgbYs5uxkIfYQmG6YoCmA/PMuNfyboVEEhtqJ0d6KiNHnhvaxtiGG+0IlPNkO8jE8XHy6CnSk4k4wwr42zJIQcxNWapCOQovjpfanxCDzemFrEQ+AMZu4AWaRKx1rRhVBGBaa1QAWzXGKN3q36/bbHbXUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628483; c=relaxed/simple;
	bh=+jT2jqy7g6OoDyDNcHq9OuDUankgP5nFI24B9/wJR0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSTAvQ9WIg+rAShTC4PI/GIib1Hg9NByh6PfCBPhFLeemA8qbpxZgqJTwUrqJ9mz/bwcPHtCjTSBBXdczVV4WV1Zqg6DGdlJ9Dyf18iXZUhdnkaTN4Y3S9GIJ2jfPAMOHjAmVm9DeMlJJFf4JpURep5nGO6tOQ1KkwgEwxsRhas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=amqkUVIe; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=q/scHe5hFL76FKFrVdCjycNKKyR5kLuRk7AbcPhDAb0=; b=amqkUVIe78Hhfp7FjB7dmaFu7m
	hpe5lJophYykDNN6EVyApWM8Dm4DMpxKKouviANVJYzlH3yN7zTt6a8sZfuWuZ3AZEkFoZUWnLMTH
	1MkwKHBABDfVd/waS1GssPr+TieQTaC4PWvVnNxD2RLXHWyyajPvRf3tdTMlioGxN/Z39W3c8y+7W
	mUW/+XI6uAN6NHqT5QHGUprPzPO0HPd2t1c5yJ3HtkqUnOroopjiMarp17ovfCc4zah1RQfmLIK30
	J1yZflZkFrmXn3OH8Kkuhjpv2RmrINKvyHqxCH3/EfQdOnAO3+T9647bIZ9SPojrNkQoKhdG3v0wZ
	FvZtlllg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIB-0000000HTxx-3lQT;
	Wed, 11 Jun 2025 07:54:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 14/21] devpts, sunrpc, hostfs: don't bother with ->d_op
Date: Wed, 11 Jun 2025 08:54:30 +0100
Message-ID: <20250611075437.4166635-14-viro@zeniv.linux.org.uk>
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

Default ->d_op being simple_dentry_operations is equivalent to leaving
it NULL and putting DCACHE_DONTCACHE into ->s_d_flags.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/devpts/inode.c       | 2 +-
 fs/hostfs/hostfs_kern.c | 2 +-
 net/sunrpc/rpc_pipe.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index fd17992ee298..fdf22264a8e9 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -381,7 +381,7 @@ static int devpts_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_blocksize_bits = 10;
 	s->s_magic = DEVPTS_SUPER_MAGIC;
 	s->s_op = &devpts_sops;
-	set_default_d_op(s, &simple_dentry_operations);
+	s->s_d_flags = DCACHE_DONTCACHE;
 	s->s_time_gran = 1;
 	fsi->sb = s;
 
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 1c0f5038e19c..1f512f8ea757 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -933,7 +933,7 @@ static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize_bits = 10;
 	sb->s_magic = HOSTFS_SUPER_MAGIC;
 	sb->s_op = &hostfs_sbops;
-	set_default_d_op(sb, &simple_dentry_operations);
+	sb->s_d_flags = DCACHE_DONTCACHE;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	err = super_setup_bdi(sb);
 	if (err)
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index f4e880383f67..b85537191f8f 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1363,7 +1363,7 @@ rpc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = RPCAUTH_GSSMAGIC;
 	sb->s_op = &s_ops;
-	set_default_d_op(sb, &simple_dentry_operations);
+	sb->s_d_flags = DCACHE_DONTCACHE;
 	sb->s_time_gran = 1;
 
 	inode = rpc_get_inode(sb, S_IFDIR | 0555);
-- 
2.39.5


