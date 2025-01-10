Return-Path: <linux-fsdevel+bounces-38780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9630CA0857D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A873A8C01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8709B1F9428;
	Fri, 10 Jan 2025 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IU9AbFhr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87381E25F4;
	Fri, 10 Jan 2025 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476987; cv=none; b=ltmoyQ7v/uJwy0wWbogVtyIm9GWSVCrxuZYqRwljMwpjmJn6D7dt0aNIAWBsACqc2SV5O4Jq3itr0A7xkiyMHQeZg1FExQdKjnX4j7ZR2/moKgs3I9yFQLA07pv+ugINtCD4foHIDX/08nyG66u8F41dE1t6ptuwW3QR/XSM2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476987; c=relaxed/simple;
	bh=JSqOCszBVP4a0JdOKu2btg3KSSnRI0V0SgEWY2fLTWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyRm2XLTidvSlRtSih3KIfkycX38X6LvxwhWL6fQ/HvzTzCEyS0c+1+IdtHPuLMBZU8wdxkkOeA4ZYsMfqzeWXnRMsAKxzGbODd4cwag8rseIZkxNugPNUQ4PBnoiy3aysiwSkRT3sRHyOf1fSOf0hR2dRQP+mqP5UjNkSJWzFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IU9AbFhr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5Rx+u+PO8tzqpgasiduw2br6cp30m2o9rFSyk8L9j4E=; b=IU9AbFhrN5SlKx9TgwuHEVYTYK
	Ys4b+o8e2pO9kIWCEidj4Hg/2/rZwZoY2/MObpfdDmBsvcFRJEf8c9N2DDMoWpH7mqXR1B8pBvQw2
	/9xvIhy73ntR/2o22hRjKtA6KZ9+TV/Vi62hLWKdsdwaxwa1bWiKhKS8DMJ2pwtykjVnCF4/ZpmDy
	+OyhyvUwFobcBEIPfC2QiSjJOoUCH9z5Hhu+39n/bzBNdoX4/tQjBoW3tbHOgOjRSn6SLU3CaR2Va
	XIlNyGPRbR59s++uFkr7/2xwtzN4KakxzNdimms26UQeBZEZPDYVkrnitW34iws8sbsLZdzeT9M5b
	ypCviFZA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4zI-0000000HRbe-1YiW;
	Fri, 10 Jan 2025 02:43:04 +0000
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
Subject: [PATCH 09/20] ceph_d_revalidate(): use stable parent inode passed by caller
Date: Fri, 10 Jan 2025 02:42:52 +0000
Message-ID: <20250110024303.4157645-9-viro@zeniv.linux.org.uk>
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

No need to mess with the boilerplate for obtaining what we already
have.  Note that ceph is one of the "will want a path from filesystem
root if we want to talk to server" cases, so the name of the last
component is of little use - it is passed to fscrypt_d_revalidate()
and it's used to deal with (also crypt-related) case in request
marshalling, when encrypted name turns out to be too long.  The former
is not a problem, but the latter is racy; that part will be handled
in the next commit.

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


