Return-Path: <linux-fsdevel+bounces-51653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38285AD9A52
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 08:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7581B162B5B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 06:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1234C1E47B4;
	Sat, 14 Jun 2025 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ecZzO+zS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D271DDC1A
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749880954; cv=none; b=aviqcm0G7RKOznjP1rVkmp6wgJTMoeXnpm1xY+k95s1l92AJE6lEP3aO+azUg+Ocaf8tGJkUdSaPSf66zSv7DSx6tf5/HnsmEZs0BRx0/T57q85JKVowUfRnGopGaRGsA4PsDOnhEcsH30gwuihyCEaytg7IMtMv2hBGI+Pb2MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749880954; c=relaxed/simple;
	bh=Ymg2/whCQRAkj3yGTtGtKaQj5T77/CxdWapHn9OrXYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3jDp2wivAHfNvprxph9yFDXAsdx+ViPoacq1ZgKGutK6I9YdHp83BhKUUVW8BUUlHqaSglOY4ViJJVYNO+pE8eBC9XT2b6jCwqElENgRMXiyyPGZMrunAL0yKABACutFIzT4P7061mq0MeRz0h/IbUugLZuDyr6GQ2GNocj3mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ecZzO+zS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5uXU/uhdE2jo+QjPPv0nZ1Nhjleks3Fvhai4NzNphnA=; b=ecZzO+zSknxQfzoI6mwFd2zqwj
	BrSfulcRRLDfNvzI9mK1laETkPcm960U3+8lyVKZnOT7xV4Oghw/J7yWzWNYjgee1q5+Znkt/v5lh
	SvtxFpiA6TewOmxBqkZvIqBT6Kg1lgCMjTq/MJ12l451CgKLRWATg4u7OQI7wxvqY01sbYyWG7I1n
	/mE/fkixfSZpSYZYHDbGvDAN5ZpVhFboEJGzTF2Xx0RORhCA5gCjKTR/g6Xr7V4fep7cl0wxvB4Q0
	oA/NbA8t0RU+zwMDUnorYFKuwasNoZm7JrI/tWqJPx7mYGtgIK1NNo3kng2t1kGLpkE8wHUlmTs1m
	/l4leuzA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQJyJ-000000022q9-1Jb9;
	Sat, 14 Jun 2025 06:02:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: neil@brown.name,
	torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH 4/8] binfmt_misc: switch to locked_recursive_removal()
Date: Sat, 14 Jun 2025 07:02:26 +0100
Message-ID: <20250614060230.487463-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614060230.487463-1-viro@zeniv.linux.org.uk>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... fixing a mount leak, strictly speaking.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_misc.c | 40 +---------------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 432fbf4fc334..760437a91648 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -674,44 +674,6 @@ static void bm_evict_inode(struct inode *inode)
 	}
 }
 
-/**
- * unlink_binfmt_dentry - remove the dentry for the binary type handler
- * @dentry: dentry associated with the binary type handler
- *
- * Do the actual filesystem work to remove a dentry for a registered binary
- * type handler. Since binfmt_misc only allows simple files to be created
- * directly under the root dentry of the filesystem we ensure that we are
- * indeed passed a dentry directly beneath the root dentry, that the inode
- * associated with the root dentry is locked, and that it is a regular file we
- * are asked to remove.
- */
-static void unlink_binfmt_dentry(struct dentry *dentry)
-{
-	struct dentry *parent = dentry->d_parent;
-	struct inode *inode, *parent_inode;
-
-	/* All entries are immediate descendants of the root dentry. */
-	if (WARN_ON_ONCE(dentry->d_sb->s_root != parent))
-		return;
-
-	/* We only expect to be called on regular files. */
-	inode = d_inode(dentry);
-	if (WARN_ON_ONCE(!S_ISREG(inode->i_mode)))
-		return;
-
-	/* The parent inode must be locked. */
-	parent_inode = d_inode(parent);
-	if (WARN_ON_ONCE(!inode_is_locked(parent_inode)))
-		return;
-
-	if (simple_positive(dentry)) {
-		dget(dentry);
-		simple_unlink(parent_inode, dentry);
-		d_delete(dentry);
-		dput(dentry);
-	}
-}
-
 /**
  * remove_binfmt_handler - remove a binary type handler
  * @misc: handle to binfmt_misc instance
@@ -729,7 +691,7 @@ static void remove_binfmt_handler(struct binfmt_misc *misc, Node *e)
 	write_lock(&misc->entries_lock);
 	list_del_init(&e->list);
 	write_unlock(&misc->entries_lock);
-	unlink_binfmt_dentry(e->dentry);
+	locked_recursive_removal(e->dentry, NULL);
 }
 
 /* /<entry> */
-- 
2.39.5


