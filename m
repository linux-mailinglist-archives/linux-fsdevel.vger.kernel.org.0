Return-Path: <linux-fsdevel+bounces-42514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4202FA42EE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DA1165818
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47DE1DDA33;
	Mon, 24 Feb 2025 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WaFiY0xs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2D21D9A79
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432056; cv=none; b=f0KuXQ+6i1WhOw+HidpeUrdqht2/TUuLq/4GffQUFohLQFhFloVzFhfoxiKfDkjn7BOMQ2VwTMId6nwQi15VMViS9i+aNr8V7lDhbAKQCchr1Sezc0+5AlS32Z9FF1/xSK2mD3Sfh2NnddJRV8Ik+k+9GZDtZw0M72eEJ8DfUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432056; c=relaxed/simple;
	bh=ZV7yAoiQLs1+UjVXs8H9EhGvXY10O+mRXKqQqhSlnkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkUt619jovrpLWm8U84BNQHOj2g74akKPWNVijgLxqTo0PJiN4NP2bun/Z/pt7YIe+oVNFbf+WjalidQ+bXUmtZCGaFQMTxpZ0p/Py8PEcw+YKlDPdAhS+eZDoPnQJpt1S4dGkeRtfXyX9Z9OTM3JNZcodwiIY0ZWEOy/AuD6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WaFiY0xs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cD0QyUmsDMX3U0Nt5e+64XvmDN00y3Jrngvt56dwu8Y=; b=WaFiY0xsXC6584uNQ3Usb7O01c
	OEUnE20K7wT5XMOwYThNJjl9jH8wuqbnwthypd0hzx2cjXm1+WC3L7MROtkrYvVUmu1pXiT+bJ9k7
	ppi8Ab+nDJHs2FszYaQKnoEWpaV4nT5DPC+Lr0aVolP8LY9Pnj4h0purFaC2pzjEWVcl88UBhUJsg
	pkVElusC2lNGH5gKfSaIWet2m2tyjtdyC6weOXHPcHAIywzepzzM1mI2hcrx1NDMB8RNBdsgWjd+t
	TO9+qaV+/ETI1Oqd3C+wuN8e4px6bnjiiuXyWF77i1wGPSGbcTNqVWyA9JeeBcOZAhS1fS+VEvdfZ
	dAuNHW7A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsi-00000007Mx9-0YPa;
	Mon, 24 Feb 2025 21:20:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 04/21] fuse: no need for special dentry_operations for root dentry
Date: Mon, 24 Feb 2025 21:20:34 +0000
Message-ID: <20250224212051.1756517-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

->d_revalidate() is never called for root anyway...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fuse/dir.c    | 7 -------
 fs/fuse/fuse_i.h | 1 -
 fs/fuse/inode.c  | 4 +---
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 198862b086ff..24979d5413fa 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -336,13 +336,6 @@ const struct dentry_operations fuse_dentry_operations = {
 	.d_automount	= fuse_dentry_automount,
 };
 
-const struct dentry_operations fuse_root_dentry_operations = {
-#if BITS_PER_LONG < 64
-	.d_init		= fuse_dentry_init,
-	.d_release	= fuse_dentry_release,
-#endif
-};
-
 int fuse_valid_type(int m)
 {
 	return S_ISREG(m) || S_ISDIR(m) || S_ISLNK(m) || S_ISCHR(m) ||
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fee96fe7887b..71a2b3900854 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1069,7 +1069,6 @@ static inline void fuse_sync_bucket_dec(struct fuse_sync_bucket *bucket)
 extern const struct file_operations fuse_dev_operations;
 
 extern const struct dentry_operations fuse_dentry_operations;
-extern const struct dentry_operations fuse_root_dentry_operations;
 
 /**
  * Get a filled in inode
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9db2cb8c150..57a1ee016b73 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1800,12 +1800,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
-	sb->s_d_op = &fuse_root_dentry_operations;
+	sb->s_d_op = &fuse_dentry_operations;
 	root_dentry = d_make_root(root);
 	if (!root_dentry)
 		goto err_dev_free;
-	/* Root dentry doesn't have .d_revalidate */
-	sb->s_d_op = &fuse_dentry_operations;
 
 	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
-- 
2.39.5


