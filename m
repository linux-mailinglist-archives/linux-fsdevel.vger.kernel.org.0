Return-Path: <linux-fsdevel+bounces-42527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628A1A42EED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6C11656B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4542C1FC7E0;
	Mon, 24 Feb 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ucH1lMrL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B541DB548
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432057; cv=none; b=W2kJAb43QJ58Jt6GY/QtCoDmAhJrOZrWrScK25kCD1u3X4x84X8gl1JN/uPiDoh6fBTAZgHIkHEIFqJ/8N8r573dmVMCeF371hEO6RDIO8pWUjbEW/6+7mfxjgrhMhAFlMO/JPYzSQQoS+1tcPvbvPTvuYel0xxRLyHCvifCrZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432057; c=relaxed/simple;
	bh=pzVhNNSycZLwcra/LRDgOW/BFaSPn9URgkcC7mmcpuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mc+kHBEJkSw6FBRo/4G+YUdTqUpXrS+C7wrAd3gsA/EwMoogf07AkF+ZmwU+WiHxt+xZeJ6gTTiDCUnmhF+oTJKITUTevA5RZz4AwOiug1cUC4vrOxk7ASPz9Q7Tj7ufbzPgf4y8IPPqEpUoaKZFGXsLCTjDXR07UZTdIz2LRcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ucH1lMrL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8nWOoUPAozKOT6sknONZd+MJUdMcGxAsstbpKKQicvg=; b=ucH1lMrLd+frGgA9wYWgbMuCbM
	KaTZjnB7ee/6W93ylNBPt8KjCHlyji81ZVtJCm2Ei7RJk1e9t2dt1cPNuUpp5HNi84pTgC0ELYr5P
	+s2I7YRzS6maqhGDjPYsw5YvYtT0ecgUAnFaNWIdmXqImx5S6CG4QBX/rLzRoaBFEFSwcHFMS4qig
	LpBe6E46hyukPRGLKQC8EwN6muiZhaMTC0/65WwZjBWMJoIrTKgao4laL0mrD9iALSzZc4n1oxcYp
	uYCoxwR6f/TNnOMFMkLFbumF76nV/0sm3h1pAt7/h4ztvCZRD6+FuSv3+TlAhBiUpKdtPaSEAwwAN
	hYbn6NDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsi-00000007MyB-3mJp;
	Mon, 24 Feb 2025 21:20:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 13/21] devpts, sunrpc: don't bother with ->d_delete or ->d_op, for that matter
Date: Mon, 24 Feb 2025 21:20:43 +0000
Message-ID: <20250224212051.1756517-13-viro@zeniv.linux.org.uk>
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

Just put DCACHE_DONTCACHE into ->s_d_flags.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/devpts/inode.c     | 2 +-
 net/sunrpc/rpc_pipe.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index f092973236ef..39344af02d1f 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -433,7 +433,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	s->s_blocksize_bits = 10;
 	s->s_magic = DEVPTS_SUPER_MAGIC;
 	s->s_op = &devpts_sops;
-	set_default_d_op(s, &simple_dentry_operations);
+	s->s_d_flags = DCACHE_DONTCACHE;
 	s->s_time_gran = 1;
 
 	error = -ENOMEM;
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index e093e4cf20fa..acb28a502580 100644
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


