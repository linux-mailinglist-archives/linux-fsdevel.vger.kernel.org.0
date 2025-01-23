Return-Path: <linux-fsdevel+bounces-39908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B891A19C70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA50188DF2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D001474A5;
	Thu, 23 Jan 2025 01:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="N2pxPUrh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEDA1E884;
	Thu, 23 Jan 2025 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596808; cv=none; b=ago+lGcN+/itZ72Pv2k8LgBkAed/P+0S+IJLVKjv5l/j/TTJAj6h6qqtcBfqtG+uLC/Jq5gb82l/f+g344PnYQkCGA0+ly8T/a/RV7xQemOiXXp43uKzbr2+4OwVp9THMa4TiB+HQr5K5+PXsEvcq0CC0pqaaA8aNGK+F+D4HmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596808; c=relaxed/simple;
	bh=ohOYnw6tlRfdgicbOWnY1f5MqOkoI0fvvDz1mVRdz/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6HDvSPq0jo4HAEygb+xC9hZhkrVWPkAfrrcIjmPMDb5LGW3IYlLDaDbjKy4iXsYvXLEahbvvr58N1ThNcoAGGqnlQiv+T8RWUEAXM310CdNp1lJXd/bS2LRzol7fCg4TjSkBMYcvNjhUauhExGK+8X5FpuYIvXT5+fnbvUmH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=N2pxPUrh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cXASIXjSdWp91MQCljYZ9undpY/fYnrkMTrfy8G1o+U=; b=N2pxPUrhKiGj6lA+ALaP5oVcxm
	0VAkGjsqOdX+CFD/k7PgGeeznYEy/2MSFbmHuqzAIsXJgWJSENnM7H7zIs2oP0rz6eQBSHQ485o40
	1Gjah+7+qVBzpaNfaG68MPqJPR6KUPIebo9RIBKw5CEGpCib9jIgPeGTxVOmcMS//RaYYJUVyH2wR
	VnSNqLRmbjWzRfP1fTmvUTFiWh7z0kT9PEpDPHEUtSbd1IULNeSE6ag5H1m/fXPGLZTa3uGrvtH4u
	6G8uLlW7bDP1ZeuCtZHKpcAaNnI+eXDjPzacnWnWZ3wQ8UIk8oPUgazQzF/rIy1SoH4ZNbcOsAt83
	WAGjVQDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamIu-00000008F2l-3sgp;
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
Subject: [PATCH v3 11/20] fscrypt_d_revalidate(): use stable parent inode passed by caller
Date: Thu, 23 Jan 2025 01:46:34 +0000
Message-ID: <20250123014643.1964371-11-viro@zeniv.linux.org.uk>
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

The only thing it's using is parent directory inode and we are already
given a stable reference to that - no need to bother with boilerplate.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/crypto/fname.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 389f5b2bf63b..010f9c0a4c2f 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -574,12 +574,10 @@ EXPORT_SYMBOL_GPL(fscrypt_fname_siphash);
  * Validate dentries in encrypted directories to make sure we aren't potentially
  * caching stale dentries after a key has been added.
  */
-int fscrypt_d_revalidate(struct inode *parent_dir, const struct qstr *name,
+int fscrypt_d_revalidate(struct inode *dir, const struct qstr *name,
 			 struct dentry *dentry, unsigned int flags)
 {
-	struct dentry *dir;
 	int err;
-	int valid;
 
 	/*
 	 * Plaintext names are always valid, since fscrypt doesn't support
@@ -592,30 +590,21 @@ int fscrypt_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	/*
 	 * No-key name; valid if the directory's key is still unavailable.
 	 *
-	 * Although fscrypt forbids rename() on no-key names, we still must use
-	 * dget_parent() here rather than use ->d_parent directly.  That's
-	 * because a corrupted fs image may contain directory hard links, which
-	 * the VFS handles by moving the directory's dentry tree in the dcache
-	 * each time ->lookup() finds the directory and it already has a dentry
-	 * elsewhere.  Thus ->d_parent can be changing, and we must safely grab
-	 * a reference to some ->d_parent to prevent it from being freed.
+	 * Note in RCU mode we have to bail if we get here -
+	 * fscrypt_get_encryption_info() may block.
 	 */
 
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	dir = dget_parent(dentry);
 	/*
 	 * Pass allow_unsupported=true, so that files with an unsupported
 	 * encryption policy can be deleted.
 	 */
-	err = fscrypt_get_encryption_info(d_inode(dir), true);
-	valid = !fscrypt_has_encryption_key(d_inode(dir));
-	dput(dir);
-
+	err = fscrypt_get_encryption_info(dir, true);
 	if (err < 0)
 		return err;
 
-	return valid;
+	return !fscrypt_has_encryption_key(dir);
 }
 EXPORT_SYMBOL_GPL(fscrypt_d_revalidate);
-- 
2.39.5


