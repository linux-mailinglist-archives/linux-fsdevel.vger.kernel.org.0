Return-Path: <linux-fsdevel+bounces-38791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB33A0859E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C434188C1D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3125D207DE8;
	Fri, 10 Jan 2025 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rYbLgpzj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672AB1E32CD;
	Fri, 10 Jan 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476989; cv=none; b=shjOF5wJByCTiOBugkLoMZq5Q3W/tqdS/qBlfWQudqTjQ71F+Bal5cFhdRneP039AHfdM27JPtsyAbSFtpvOp21NtfCjWdq6V1p+dME7NVaPtJf2wYxBOm+W1JgyQOSEMTKPZSqHa3sT0rGbRsp0Fj4Rte5wTv80UX4YxSc9H1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476989; c=relaxed/simple;
	bh=g7Lu5xQgxjRSidy2rPJsTtxWfzI6PXU7b2S+xxhBCjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kq+dU9FPv0mKzPS6NYcm/qbhfEh4AxQM15EWqHcfjBFpo2OFNDjB12YMw1mFSuD61FB8/FnC25PBwU2o4YQVx86niSTOhnkGboV5u/+yiyvewkZFGdz0DS0UdefTZKZIhBDwK1oE6zAbaBCi0+7Di1ohUkW+BdRNaxRcTvC8e20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rYbLgpzj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BiVfBMu4+MG8Xe+/zseR3lQpx3kkw90WuZTpkxLOa3k=; b=rYbLgpzjVR2zIesyj5xITA9/B8
	VWmsEPw5FWZaKkqJ9ze6SBMaetpb7iHysPI5wEl5/BFQsw2W13WmIdORqo0hg5RE1IQYdNFt+8pDo
	CNef+3ILi4LVwooAMmrmVNm4lZIgdjm2U7bzPsBhm0xyAryuMv2Jog/WdqmjfLYdlz5/LAuNrovwc
	fS0O1EA1HIVxyvXoavTCd9ZBDv+MyhNvXxX+DWgZ4y3VErcgN78FdScA4vPm7Bg2NLA2hdLjpjhN/
	/o4pM3WbWhTrCsrshlt28B4HSMoS7mEiEQX/6g+9832QMJYOdbAnOaTednIJ81hd6J6hcxbwgsXGD
	8A09+6NA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4zJ-0000000HRdA-2I9b;
	Fri, 10 Jan 2025 02:43:05 +0000
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
Subject: [PATCH 19/20] orangefs_d_revalidate(): use stable parent inode and name passed by caller
Date: Fri, 10 Jan 2025 02:43:02 +0000
Message-ID: <20250110024303.4157645-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

->d_name use is a UAF.

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


