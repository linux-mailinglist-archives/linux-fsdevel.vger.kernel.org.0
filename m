Return-Path: <linux-fsdevel+bounces-39917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD7DA19C81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DD21635CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243017085C;
	Thu, 23 Jan 2025 01:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hkEgvNE6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7276135965;
	Thu, 23 Jan 2025 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596809; cv=none; b=CVd/+77RjLHasgB75EWSzP9ALTYnVwQtvKu+f60DTzazPNrz8uYdgzleKsxB3A5jHD2Zv7gN9cmAw7CzCRP4rlF+gkVsf/wfL6a9NIle0kVGg9lDMTz5Y9vAJNeD9bLf6XEg5egiBTtmZaM0yjTkThOD9iObL4b2Mo5bh7M4Yfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596809; c=relaxed/simple;
	bh=hergQ0UtAkYbyivylSWUfYg/yaL+rMJ0njc/JZrW/sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEMLJVkho1s+ArbLsSYfgANJvsAjxa2Tbdb5drGdfmKBGt08l+uooUB5S+mgJbB0ywVGHmCNsZ7GPdbb2Km2slVO0NjcPbAGTEwKoE/YRCWNBClbBt9XsF54TDjU3hlijzSTfgzdMlUmjE0st2nmzE+ngLrf/M5LoHirZjRFR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hkEgvNE6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hqOmDaE4VdnWGGxnsANM+Oqb7CSop4zrRhX19MfRv+A=; b=hkEgvNE6XsQ9AaTlLP840OoBkl
	bgUF7396QyIQy+BqphB/CcG8PhhnJZMDZ7owYBAyk9Visi7Y0vff7cz7YeEfrRkXq+W3NRifUBPnQ
	N7e9yRrhtvG2hpq9Twmex01jxnsrLzjkF2js2HZvIu0eILGHwzn4ThffO6WV84x//LMaz6uvXLvDV
	hf6ypECe02wdkisWQZt3tMoMHxFK4I9K6YUqL1Z0pNk+hUelwFc/zJpZBM0BqGnbEN7DS4jsUMIGx
	enTihowYP+Qw9IwX6rR/GWFBzQLLz1WPCys81wT5HJqEzTYw0jCjnxlzCw4kGpxUzXDxRf++jkh7m
	QJ1mA35A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamIv-00000008F3z-32pZ;
	Thu, 23 Jan 2025 01:46:45 +0000
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
Subject: [PATCH v3 19/20] orangefs_d_revalidate(): use stable parent inode and name passed by caller
Date: Thu, 23 Jan 2025 01:46:42 +0000
Message-ID: <20250123014643.1964371-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
References: <20250123014511.GA1962481@ZenIV>
 <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
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
 fs/orangefs/dcache.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/orangefs/dcache.c b/fs/orangefs/dcache.c
index c32c9a86e8d0..a19d1ad705db 100644
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
@@ -26,14 +25,14 @@ static int orangefs_revalidate_lookup(struct dentry *dentry)
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
+	/* op_alloc() leaves ->upcall zeroed */
+	memcpy(new_op->upcall.req.lookup.d_name, name->name,
+			min(name->len, ORANGEFS_NAME_MAX - 1));
 
 	gossip_debug(GOSSIP_DCACHE_DEBUG,
 		     "%s:%s:%d interrupt flag [%d]\n",
@@ -78,8 +77,6 @@ static int orangefs_revalidate_lookup(struct dentry *dentry)
 	ret = 1;
 out_release_op:
 	op_release(new_op);
-out_put_parent:
-	dput(parent_dentry);
 	return ret;
 out_drop:
 	gossip_debug(GOSSIP_DCACHE_DEBUG, "%s:%s:%d revalidate failed\n",
@@ -115,7 +112,7 @@ static int orangefs_d_revalidate(struct inode *dir, const struct qstr *name,
 	 * If this passes, the positive dentry still exists or the negative
 	 * dentry still does not exist.
 	 */
-	if (!orangefs_revalidate_lookup(dentry))
+	if (!orangefs_revalidate_lookup(dir, name, dentry))
 		return 0;
 
 	/* We do not need to continue with negative dentries. */
-- 
2.39.5


