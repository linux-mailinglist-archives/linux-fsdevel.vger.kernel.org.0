Return-Path: <linux-fsdevel+bounces-68462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F868C5C8B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A410C356A79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403973101D0;
	Fri, 14 Nov 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc85mQzX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6DB30F950;
	Fri, 14 Nov 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115337; cv=none; b=W5QyGVe/HMYFvFor5mzRbbTuKJJCesxEx8bU7YKcH6JaZ/3Gv6wkS6tPO76yIVGpZ3RoxuAyy+l3HfDBms/d6EsUmMFe6DWb4L6oi8Yf9KJrz6nRvIZ+ht/zOoMZTF6LCLWh5coQbP6AjXMRFYzkQVeXrXy36272GcedsFBhM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115337; c=relaxed/simple;
	bh=FwZ66NeLVkWlYSbfDfs4sy6Bfvj6W5lb3AYZh92Smfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=db6SUepAre+sDfcW5Zpmjbc3/c1MmAFlVzkYlEXjO5zahD/4+ltSw/wEYi9Dxz4oFzAEBKU1ot0bhGfDp8pxlKefYJ0YMz857apawgSM2rwdy2mXOOecVsG17tBYpMxNBaj+Vc0QLG7tggRvAvh8LgTfDZgWJimDjGaPoMNExDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc85mQzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE86C4CEF1;
	Fri, 14 Nov 2025 10:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763115337;
	bh=FwZ66NeLVkWlYSbfDfs4sy6Bfvj6W5lb3AYZh92Smfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vc85mQzXeCSGN1tfzdufm1Vtlm6ZiyPNLU8L0HaFSC3ov8q4JLX20WOg6LLfUjvDu
	 vbMFnY3ZIUV+47ntFRN1beormWptGB6X35sIUesXS4S2NmxTeupgKPABXFGlYNr71y
	 NMI/ovW8Ia+wRFgB+OZYBJj8U57ILDZbXu6raC2oaEUQkDroiaZwb8IzDahudG43hL
	 e1a8/46FVG6CEbvz/BZlRn5fbwdGDx1zuEQfLQWAgjUZXAKQy7deUYboHlG753cdA5
	 X5nkf4DecXuFVtm6HZxrRl4eazDOiR/haRiSThTOO94OMiRb29V+r3KVvukM4BTAtn
	 fbsCXrB421qig==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 14 Nov 2025 11:15:18 +0100
Subject: [PATCH 3/6] ovl: reflow ovl_create_or_link()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-work-ovl-cred-guard-prepare-v1-3-4fc1208afa3d@kernel.org>
References: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; i=brauner@kernel.org;
 h=from:subject:message-id; bh=FwZ66NeLVkWlYSbfDfs4sy6Bfvj6W5lb3AYZh92Smfk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKMzq1bXkcpcuwQTHa3+Xn5/UedXHr+0ROlQYU8+4qO
 nPD87ZTRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQO/WZkOG5wU+TwxmWPHHxW
 H2dbxP+0zm3Z9QNtN4/+eHLvH98el7OMDLMahHNeqwjl7Vr/6DNPrmH/7Rrrys6l7xd2bS8WPr8
 inhkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Reflow the creation routine in preparation of porting it to a guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index a276eafb5e78..ff30a91e07f8 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -644,14 +644,23 @@ static const struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
 	return override_cred;
 }
 
+static int do_ovl_create_or_link(struct dentry *dentry, struct inode *inode,
+				 struct ovl_cattr *attr)
+{
+	if (!ovl_dentry_is_whiteout(dentry))
+		return ovl_create_upper(dentry, inode, attr);
+
+	return ovl_create_over_whiteout(dentry, inode, attr);
+}
+
 static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			      struct ovl_cattr *attr, bool origin)
 {
 	int err;
-	const struct cred *new_cred __free(put_cred) = NULL;
 	struct dentry *parent = dentry->d_parent;
 
 	scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
+		const struct cred *new_cred __free(put_cred) = NULL;
 		/*
 		 * When linking a file with copy up origin into a new parent, mark the
 		 * new parent dir "impure".
@@ -662,7 +671,6 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 				return err;
 		}
 
-		if (!attr->hardlink) {
 		/*
 		 * In the creation cases(create, mkdir, mknod, symlink),
 		 * ovl should transfer current's fs{u,g}id to underlying
@@ -676,16 +684,15 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		 * create a new inode, so just use the ovl mounter's
 		 * fs{u,g}id.
 		 */
+
+		if (attr->hardlink)
+			return do_ovl_create_or_link(dentry, inode, attr);
+
 		new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode, old_cred);
 		if (IS_ERR(new_cred))
 			return PTR_ERR(new_cred);
-		}
-
-		if (!ovl_dentry_is_whiteout(dentry))
-			return ovl_create_upper(dentry, inode, attr);
-
-		return ovl_create_over_whiteout(dentry, inode, attr);
 
+		return do_ovl_create_or_link(dentry, inode, attr);
 	}
 	return err;
 }

-- 
2.47.3


