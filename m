Return-Path: <linux-fsdevel+bounces-60979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5485B53ECE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 00:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C31AA045D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 22:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10B12F5468;
	Thu, 11 Sep 2025 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oUTYmyiC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAFFC120;
	Thu, 11 Sep 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757630793; cv=none; b=V0HCtmJHkgoiFlXSAccSxr2NtYgxE6zgpC3sIh9+eJHz6MWHLUmQVwYOLomEqQZ0diqWeH6BvL6zYPTQgJrHk8kZiipPrqak7WuNfBBWq3DV0Z9mR0XP7wbrETgrKo8/YCfxBWXuWZsKXdK4a1CRjgegM5ltCvesFT1hHCVYXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757630793; c=relaxed/simple;
	bh=AwFzlKjQ3EIJ49KkRn9T+xsYSQQ8/09OKEKzWkiINfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRdbJXs7YKR2jrNH/xc00urDXJSAkpKUM1gHkvsVjsjAfhM66+SOIbtvXtzRi4E/qWvxZPXMc5z1nLYPUFi6dLqCGWXqKKLAJ6R0FrEmV59amJ3T8P16ncywlaTIGNCLytg4z27W+rlF91V1lVshCXU+bigjgekhHpjEiLayo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oUTYmyiC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/s8CFKMYO+LS878V51yLT1b+Zsxbl/+6lRaD/jUIXY0=; b=oUTYmyiCZ59K5d3uQfD18y9gpg
	5TzWIZFhJIIpfibA/syGRAs4V8o4rol3lQttYK9KTm/4z9sC93uHropZc50Kdsq1tmn6X+xKuIRNM
	hXsQ6maVwTffPKEzMKA4zYid15YWv4QiBgcvlxkjSJZI7rkvGbKQnCYjSpBvlePvQd3LqdA6KJQqI
	N+ehL5qnjKqDooWUlfokLy2Q0u5Cy+GrJj6wEUN2axTNXkWqjMgSJ09vbLVuOrp0aqjV/Sz64YPGf
	lW5DSC5+b7hC724AGtWqwMqpYAnUNPI7xIx3/d7oDIzGpAU6eMlm/iyM/xHI55pU1qGjlyb1IO5F+
	oA6DHIVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwq3g-00000006g2t-3j6H;
	Thu, 11 Sep 2025 22:46:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org,
	jlayton@kernel.org,
	neil@brown.name
Subject: [PATCH 3/5] _nfsd_symlink(): switch to simple_start_creating()
Date: Thu, 11 Sep 2025 23:46:26 +0100
Message-ID: <20250911224628.1591565-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911224628.1591565-1-viro@zeniv.linux.org.uk>
References: <20250911224429.GX39973@ZenIV>
 <20250911224628.1591565-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfsctl.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 6d60bc48f96e..1b5e417784f6 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1155,23 +1155,6 @@ static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_client *nc
 }
 
 #if IS_ENABLED(CONFIG_SUNRPC_GSS)
-static int __nfsd_symlink(struct inode *dir, struct dentry *dentry,
-			  umode_t mode, const char *content)
-{
-	struct inode *inode;
-
-	inode = nfsd_get_inode(dir->i_sb, mode);
-	if (!inode)
-		return -ENOMEM;
-
-	inode->i_link = (char *)content;
-	inode->i_size = strlen(content);
-
-	d_add(dentry, inode);
-	fsnotify_create(dir, dentry);
-	return 0;
-}
-
 /*
  * @content is assumed to be a NUL-terminated string that lives
  * longer than the symlink itself.
@@ -1180,17 +1163,24 @@ static void _nfsd_symlink(struct dentry *parent, const char *name,
 			  const char *content)
 {
 	struct inode *dir = parent->d_inode;
+	struct inode *inode;
 	struct dentry *dentry;
-	int ret;
 
-	inode_lock(dir);
-	dentry = d_alloc_name(parent, name);
-	if (!dentry)
-		goto out;
-	ret = __nfsd_symlink(d_inode(parent), dentry, S_IFLNK | 0777, content);
-	if (ret)
-		dput(dentry);
-out:
+	inode = nfsd_get_inode(dir->i_sb, S_IFLNK | 0777);
+	if (!inode)
+		return;
+
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry)) {
+		iput(inode);
+		return;
+	}
+
+	inode->i_link = (char *)content;
+	inode->i_size = strlen(content);
+
+	d_instantiate(dentry, inode);
+	fsnotify_create(dir, dentry);
 	inode_unlock(dir);
 }
 #else
-- 
2.47.2


