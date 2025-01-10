Return-Path: <linux-fsdevel+bounces-38793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AC9A085A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A25188CE10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE22F2080E0;
	Fri, 10 Jan 2025 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="m+wOOJ29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8266F19DF6A;
	Fri, 10 Jan 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476990; cv=none; b=a9mTYRGB45LChCOUGavNR3GRFVlMGshWP/13xlq8tM1umvER/j8q7kNdjJ9YIVxgqTw4uZYY/AZr+gyL1KY/L78K3qoy8FSKrU1//oOJslNYcXBqWNLyjJJvGug5yCWzPQC1GyAnOe6uiLp7JCbFvbLpCpl9bcVSXxQMwjgauQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476990; c=relaxed/simple;
	bh=xll445NA9CDt1doNqJg5AW6QYeiL0uC7l/8N2NBaxd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEgHWFGdzvbWf+DepVA8/Jg22cq460py0Is8A0dlJeWpR+5JfeLtFsTGE+1L0oVGQWAipUFpfHQc+WRYfujdRXdJnPRVu6/5pzSPAs0bth28Rbo0FjYOqubo5kIxqLouFDYzd4/RSVzzRAymH9avaJCTJhrWMcZb/DRZ5ZvCG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=m+wOOJ29; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XkQHyBfy7cWsOFwEw1uqtx8wpSFb7k25tuptSzuWiIg=; b=m+wOOJ29MYRlXsDvQaPsL3QgZl
	f655ub9wvMHIVR8jqGxLLeQgTPwDQ0M0hLV4v6UAIGFPWAIuUoePMPMMlO9/fmllHB/RgVAZmigLd
	CJQkIk7X5ofhGOpmpaIBa8tixVKk0YfLyFBfUfhIVPjZm7UkqqJWfVYsj1MI7H65gNFQZj9P0cRfn
	VaPbPE5qzWsYrM8Kc8qYLPdjCU8QF8EGFShZXxjhC3+GHTO9oS3x8Ej0vKG1ny55wzmyyKGeOw0Zh
	DlC1m6VSxVG7w8aUq++C/DHm5wuME1Zwd3F1Whewb3iCKYjuaVieMW6WojBczLm/LlUsoM6Z1vKdQ
	a+Lfwyjw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4zI-0000000HRc2-2p3v;
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
Subject: [PATCH 11/20] fscrypt_d_revalidate(): use stable parent inode passed by caller
Date: Fri, 10 Jan 2025 02:42:54 +0000
Message-ID: <20250110024303.4157645-11-viro@zeniv.linux.org.uk>
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


