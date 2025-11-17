Return-Path: <linux-fsdevel+bounces-68673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80843C63481
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE0D4350182
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E08A32E144;
	Mon, 17 Nov 2025 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROvxU/5l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8432D0DA;
	Mon, 17 Nov 2025 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372078; cv=none; b=lW6q7XfCY9A21ZFgNJq4AEe+2vlKYxdriYTLpzCLq6rLpZ30NLFdrQw8+YkfwFEGVjiHW73fd0U48SrSYfa9h2Ra7YfRu78rimSZisUaT0QMrPVhJxA6NDfq6c+SC786JEAxIQhTe/S1NSYv70fvhpPGfiTlFQBRw7FaT4LmyY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372078; c=relaxed/simple;
	bh=YPdns7qIIaifTfKk3Q1MjYul7fyQK40wsVqjnYaivfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCDrZ+anvLuEoCytq5+y/M7qs1LWoGKT3Po3nCsdkSmMf6IinQAsP6RgeIG9ZQ4ZgvpaarNRCiaahz3IaJuxrde+UZ6Uvw1kvPfayooifvRh43fvLFfZIzfV6HUCY5kX9aGoswLW+KqeOVS/bsp6MYFR28dEwQpr9UwHa/ubDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROvxU/5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E20BC4CEFB;
	Mon, 17 Nov 2025 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372078;
	bh=YPdns7qIIaifTfKk3Q1MjYul7fyQK40wsVqjnYaivfQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ROvxU/5lXDPGv0HXdkF7DHqTF1+qzSbWbxLJdMTud4ei5Q4y+l0XR4C1vqp2jdFpU
	 a6LrWDv8JZ28Vie2UB41qOHv6iB306Lt3P5ESoRxCxiTiHSvsw5Y4nLDFnOe8vfsyD
	 LOKoLSe4424hPoXUJ80EQi3x4SyPmjWePJmzABM9eGpA+X8xPccitYc0U+VFQI4eQ0
	 vF4meFKsWi+/a96RNXHuUtn2XphRmiFi/NJ5uV/jfYb9HC8JAOjuJ0QGHz4dqe6h8g
	 wB+dgqrFgYQCH0lHnWN6wwcyaNvt9Kr3MWiOQ+TH8Zd9aceMWh8Q6M0sFLgWfJ7PfK
	 QSfrtMztzu5Qg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:01 +0100
Subject: [PATCH v4 30/42] ovl: port ovl_xattr_set() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-30-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YPdns7qIIaifTfKk3Q1MjYul7fyQK40wsVqjnYaivfQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf5mFS/D+Pj9//qXW7yXbVZqc4nPOtAS1bb25nRLm
 +i1lkLBHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNhW8bwz7TDZW9rlvLb0857
 L3xx3ZV8+v+/eZ0H9Xkvab4y36nKXsjIsIFnjubEmR5evMFPE9/s837RN6vmWAv7M6Ynv9eFK8k
 ncgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/xattrs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 88055deca936..787df86acb26 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -41,13 +41,11 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 	struct dentry *upperdentry = ovl_i_dentry_upper(inode);
 	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
 	struct path realpath;
-	const struct cred *old_cred;
 
 	if (!value && !upperdentry) {
 		ovl_path_lower(dentry, &realpath);
-		old_cred = ovl_override_creds(dentry->d_sb);
+		with_ovl_creds(dentry->d_sb)
 			err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
-		ovl_revert_creds(old_cred);
 		if (err < 0)
 			goto out;
 	}
@@ -64,15 +62,14 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb) {
 		if (value) {
-		err = ovl_do_setxattr(ofs, realdentry, name, value, size,
-				      flags);
+			err = ovl_do_setxattr(ofs, realdentry, name, value, size, flags);
 		} else {
 			WARN_ON(flags != XATTR_REPLACE);
 			err = ovl_do_removexattr(ofs, realdentry, name);
 		}
-	ovl_revert_creds(old_cred);
+	}
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */

-- 
2.47.3


