Return-Path: <linux-fsdevel+bounces-39905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD85A19C62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109A9188A6FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73413A87C;
	Thu, 23 Jan 2025 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="u3VMKwc3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E211E49B;
	Thu, 23 Jan 2025 01:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596807; cv=none; b=Egr/wcti8fLujdXYa9QTkZ8MYxX8Wl7II4P4/ikmT68TsyFRfRQvvx3iy0N6272lS+1jJ0/Dg37SBxU6r44Fq/nS+JifzdJgbf1rwdqgxITwVG1Le6R+tWUvkjGAb6NyHq3WDcqbZQEsNgbUseM8ebafk60BNNMAyAXWBz2zMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596807; c=relaxed/simple;
	bh=ot+udBmI1CQbJSTCFXkOBawjzR15kHZr0R3x4BDl+I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puPx2iXo3HQDZVb8yVULa7TqBVhLEftq+hQWQ/a/PmtU+mz9otukfDnMOcI+VOE0E6S3bad0d6n0b3VMiYzCRWTL7STkzl2K/UpsHUNEhc6tdOEnlvcGLByS2S839UxkF3piAMPJFrG5d5lkYzIE6melY+GBnNgKOT/TxRd/cnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=u3VMKwc3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=INmE/Qa1ftxLIP6wHPjlnqSznmk2B616DmlRYgglfUs=; b=u3VMKwc3Xmrh/uri3cad9SJj4o
	zNvPU0QKxRNL6NdvTh1rOtgcjP9+H39U8y0kFc9sSvn/AY1E4SDEf1ogqk34gW9I+8kGVekuEj+sO
	T4cF91Oz5NpBUPyXRJtsInffntzgXltGPLQAOV+2IlUkTWNCJFhNAnUHs2uKsgtLA944W9tq8oa2m
	NHnfaUuYBa9Q+PDfViMiAf62N1jglaVWNMJyLja8tQ/Pbgtm6Fyc/uTE2pmdPMprFwJCbTji60SzO
	aGa2FostNnRSdEpuzK4RWu0skjHx9heaZtckLEq+TWJUCoLcER6/0g1rGOh33mhQeFPjLYrPqfE0V
	+bgHAK0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamIu-00000008F2P-2RgL;
	Thu, 23 Jan 2025 01:46:44 +0000
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
Subject: [PATCH v3 09/20] ceph_d_revalidate(): use stable parent inode passed by caller
Date: Thu, 23 Jan 2025 01:46:32 +0000
Message-ID: <20250123014643.1964371-9-viro@zeniv.linux.org.uk>
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

No need to mess with the boilerplate for obtaining what we already
have.  Note that ceph is one of the "will want a path from filesystem
root if we want to talk to server" cases, so the name of the last
component is of little use - it is passed to fscrypt_d_revalidate()
and it's used to deal with (also crypt-related) case in request
marshalling, when encrypted name turns out to be too long.  The former
is not a problem, but the latter is racy; that part will be handled
in the next commit.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/dir.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index c4c71c24221b..dc5f55bebad7 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1940,30 +1940,19 @@ static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry,
 /*
  * Check if cached dentry can be trusted.
  */
-static int ceph_d_revalidate(struct inode *parent_dir, const struct qstr *name,
+static int ceph_d_revalidate(struct inode *dir, const struct qstr *name,
 			     struct dentry *dentry, unsigned int flags)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(dentry->d_sb)->mdsc;
 	struct ceph_client *cl = mdsc->fsc->client;
 	int valid = 0;
-	struct dentry *parent;
-	struct inode *dir, *inode;
+	struct inode *inode;
 
-	valid = fscrypt_d_revalidate(parent_dir, name, dentry, flags);
+	valid = fscrypt_d_revalidate(dir, name, dentry, flags);
 	if (valid <= 0)
 		return valid;
 
-	if (flags & LOOKUP_RCU) {
-		parent = READ_ONCE(dentry->d_parent);
-		dir = d_inode_rcu(parent);
-		if (!dir)
-			return -ECHILD;
-		inode = d_inode_rcu(dentry);
-	} else {
-		parent = dget_parent(dentry);
-		dir = d_inode(parent);
-		inode = d_inode(dentry);
-	}
+	inode = d_inode_rcu(dentry);
 
 	doutc(cl, "%p '%pd' inode %p offset 0x%llx nokey %d\n",
 	      dentry, dentry, inode, ceph_dentry(dentry)->offset,
@@ -2039,9 +2028,6 @@ static int ceph_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	doutc(cl, "%p '%pd' %s\n", dentry, dentry, valid ? "valid" : "invalid");
 	if (!valid)
 		ceph_dir_clear_complete(dir);
-
-	if (!(flags & LOOKUP_RCU))
-		dput(parent);
 	return valid;
 }
 
-- 
2.39.5


