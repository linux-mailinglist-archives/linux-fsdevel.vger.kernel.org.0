Return-Path: <linux-fsdevel+bounces-39375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631D2A13288
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8B61889BF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2991D7E4A;
	Thu, 16 Jan 2025 05:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I2UB7ZqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F5D157493;
	Thu, 16 Jan 2025 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005004; cv=none; b=TD9IK8Az+oqSeOUAd03iL7fLxFHKE80MerZxzZDEJFQd0VXa5InEKXElwIcloa8RKxGhnTKp/kbLYKuBLAoP+iEHNYj4B38bC+X+msZREr/ibEeqpzbZLCyUnNnr9XzqtpkkfD1mliuAR6TNqdkZyNrUqDvXcfVt4088cCTnuMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005004; c=relaxed/simple;
	bh=gTrRgJN58R6gaF4TFozNTYArMZeziyvCJnhb0YEjdYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdXPsHb23+Fds0aqROCWTMwx6lrkDQXB3qiFrwR9Fr3jZgU5n81f9toHBsuihmmVhb/nQnTp7WTCivfI28fwIbVsw7yfJzFvGFX7RTcW2P08vcgLejWDQb2EArgumo74QlENOvjWAHKQfA6h6Nfq5O+lNGIUHBbkcQiakE+LeAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I2UB7ZqJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MjLpwuL9Gsid4xWPcBadA9w3CCN112lZ71Og0sUcro0=; b=I2UB7ZqJMYOnwr7Ub7wJrnYPA3
	BSVf9IU4MqdikLmLD2LQlcD9LTM0BTCAgKFK8Ukz4qr0RHHxqk4SQhYjidr5k0/rpHZH9ocg4tKst
	4nJemNghqRRPX45MzTT9CaLF9we3IYmZop983+5Lwa45nOY0CrMuIEeoB+f0wCMK76D4TfYGe+92k
	hHIJ6DwaVoQULfITvLH00PdnctgTuIZxNWRE/DyrRbV7/NnFoflgG319+1iun0nXCkB9VL9U3IBth
	jDJo8pesTrihPStEA/iJaeE7CC68B81IqOt9uZop16jTJhrfOENWMxWnYr2kIywhnCKkXZeyYJ+lW
	+lbtx8OA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYILg-000000022Io-0XNR;
	Thu, 16 Jan 2025 05:23:20 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH v2 19/20] orangefs_d_revalidate(): use stable parent inode and name passed by caller
Date: Thu, 16 Jan 2025 05:23:16 +0000
Message-ID: <20250116052317.485356-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116052317.485356-1-viro@zeniv.linux.org.uk>
References: <20250116052103.GF1977892@ZenIV>
 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

->d_name use is a UAF if the userland side of things can be slowed down
by attacker.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/orangefs/dcache.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/orangefs/dcache.c b/fs/orangefs/dcache.c
index c32c9a86e8d0..060c94e9759b 100644
--- a/fs/orangefs/dcache.c
+++ b/fs/orangefs/dcache.c
@@ -13,10 +13,9 @@
 #include "orangefs-kernel.h"
 
 /* Returns 1 if dentry can still be trusted, else 0. */
-static int orangefs_revalidate_lookup(struct dentry *dentry)
+static int orangefs_revalidate_lookup(struct inode *parent_inode, const struct qstr *name,
+				      struct dentry *dentry)
 {
-	struct dentry *parent_dentry = dget_parent(dentry);
-	struct inode *parent_inode = parent_dentry->d_inode;
 	struct orangefs_inode_s *parent = ORANGEFS_I(parent_inode);
 	struct inode *inode = dentry->d_inode;
 	struct orangefs_kernel_op_s *new_op;
@@ -26,14 +25,12 @@ static int orangefs_revalidate_lookup(struct dentry *dentry)
 	gossip_debug(GOSSIP_DCACHE_DEBUG, "%s: attempting lookup.\n", __func__);
 
 	new_op = op_alloc(ORANGEFS_VFS_OP_LOOKUP);
-	if (!new_op) {
-		ret = -ENOMEM;
-		goto out_put_parent;
-	}
+	if (!new_op)
+		return -ENOMEM;
 
 	new_op->upcall.req.lookup.sym_follow = ORANGEFS_LOOKUP_LINK_NO_FOLLOW;
 	new_op->upcall.req.lookup.parent_refn = parent->refn;
-	strscpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name);
+	strscpy(new_op->upcall.req.lookup.d_name, name->name);
 
 	gossip_debug(GOSSIP_DCACHE_DEBUG,
 		     "%s:%s:%d interrupt flag [%d]\n",
@@ -78,8 +75,6 @@ static int orangefs_revalidate_lookup(struct dentry *dentry)
 	ret = 1;
 out_release_op:
 	op_release(new_op);
-out_put_parent:
-	dput(parent_dentry);
 	return ret;
 out_drop:
 	gossip_debug(GOSSIP_DCACHE_DEBUG, "%s:%s:%d revalidate failed\n",
@@ -115,7 +110,7 @@ static int orangefs_d_revalidate(struct inode *dir, const struct qstr *name,
 	 * If this passes, the positive dentry still exists or the negative
 	 * dentry still does not exist.
 	 */
-	if (!orangefs_revalidate_lookup(dentry))
+	if (!orangefs_revalidate_lookup(dir, name, dentry))
 		return 0;
 
 	/* We do not need to continue with negative dentries. */
-- 
2.39.5


