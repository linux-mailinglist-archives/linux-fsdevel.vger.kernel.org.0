Return-Path: <linux-fsdevel+bounces-39373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F39A13286
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B3A7A39A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573CF1D5165;
	Thu, 16 Jan 2025 05:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RkwD0Hiw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90C9155335;
	Thu, 16 Jan 2025 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005004; cv=none; b=iCM9LRJSOYfiyV8vVzwY3hXymSjkr0Kfbd0YNntYdTxRQw4o8EtFLer261rjBn69pbLRk0y5YfT+MF1FVdVSgXlN1cpJTpCvpkpGr69XArWCug3avP78jpxDmn7gm7lSiHrpZ3buDeoZcbia2YvCqClx8fzKfxTmfHUhoylbgow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005004; c=relaxed/simple;
	bh=xll445NA9CDt1doNqJg5AW6QYeiL0uC7l/8N2NBaxd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AK1uMLMKPIFvRcmsr2Wmjd/IEJlNs3J9kWxEuWhqOe4aSGHW+RCm+MxVNOvwvSwT7WaMMTT3pyHsl4OLwoPDOUdV4+jZaEfN4d1sPaxah9x+M62HX99czjaCUXOW6+A72/Zw0eYm3qK3todKWg7JiKQvc58LAqS3TNpMhEIDFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RkwD0Hiw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XkQHyBfy7cWsOFwEw1uqtx8wpSFb7k25tuptSzuWiIg=; b=RkwD0Hiw47jqgq1vxgerh6EEMO
	MJRHUuV3IbAc7j1ycIRU0aE1K8XbiocesKhdPZzk10aMcuNoGe1cP9Ila+Ep5lfpRNCJUDKsgxLa7
	cgHAYKar/9bFBrBl1qZZmt7M0No0CnVmrED10Acxlir3GsJSU7vjpgO1w9eachv1iLsZEXdYIZ/v7
	CM3TOcppJ+wnBjxMT9qfSxi+6yUKDJGjsK0YRX5jUuVh6f2b8F+Aw/U7ftnAuaqT+nmkC+fAhS68J
	fZLVLNmjLVJilLZ1VmZZD09nLrvjBmIqPCtozvDUnl6ugI984PtzD2uhCIwtxRPeDMDGRZlmsmxcF
	yQT89Rfw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYILf-000000022HN-0YNg;
	Thu, 16 Jan 2025 05:23:19 +0000
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
Subject: [PATCH v2 11/20] fscrypt_d_revalidate(): use stable parent inode passed by caller
Date: Thu, 16 Jan 2025 05:23:08 +0000
Message-ID: <20250116052317.485356-11-viro@zeniv.linux.org.uk>
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

The only thing it's using is parent directory inode and we are already
given a stable reference to that - no need to bother with boilerplate.

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


