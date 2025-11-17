Return-Path: <linux-fsdevel+bounces-68659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF86C6331C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2963A7228
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709E132AAB0;
	Mon, 17 Nov 2025 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXLN3qbx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E58329C42;
	Mon, 17 Nov 2025 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372053; cv=none; b=Nt6sCRGsN65nTF7gB3GKkqZqdN/jbGsE+31+O259TN74+dykkbLCHRT8Rj/r+Yj7NBZ9lTJvAMjf7cjSHSN8iuufHAdpIzMONyL+YcA7YQt7rseB3LtjLQ2ZTcWhqHOq3GwZdroLiFlmBEuMN5AdH4T9GYR7cZ4UKIkzLDlq2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372053; c=relaxed/simple;
	bh=5iO55r6K1T90vIhDiacs7KryoGerPeGY2kAmXKHg1MA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lhlASRcRGYGQkuw6+JPeI86nlHl3KKv6JrDky+DLriCrKh0yAsLccAaSQydE5t15y5vVv8DagOmoglTCjpcmvNtkkKTxDD5w0BpLCCWsheYwl0J/SzjrKMUDqeuqJ+YFrQXi1uFmOmgWSRecrydSE9IVgq2oc8v6LpVezlxoF5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXLN3qbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585DEC4CEF1;
	Mon, 17 Nov 2025 09:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372053;
	bh=5iO55r6K1T90vIhDiacs7KryoGerPeGY2kAmXKHg1MA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XXLN3qbxKWfqzR7LKe0oqRfksNJANzUwm3GqiSFQFzoq/vqvVYPSoPO9TluhEwnyO
	 nss8MVwRcJ+ZRhEAEtXzkOl+zNlJsvMI1wyTiOp61RbRDKAcxZA+jkOhZdPiUMwTxJ
	 8r9fiLbvVNBq30ux2nnWsMMWNsR1lUj6jivCNYL0iL0E5do+Ny9mnIhJ5l8SEqSdsl
	 vtTVrNiIkZLe7ectIlclpI8SSDPRR8/lyzz3ppZVFSzaNv291rVbrul+GxYmS8WeEU
	 qS2QfI5xXdE7g1+hkOSr+No2VsNw9ET33M07aVBbnlUnXaYMwvTyZmR3zS84j6AQkZ
	 iq+ho5Ad0F8PA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:47 +0100
Subject: [PATCH v4 16/42] ovl: port ovl_get_link() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-16-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5iO55r6K1T90vIhDiacs7KryoGerPeGY2kAmXKHg1MA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf761OlboP3u2PdTl52MuPK4aO0dxdLJ91mO8v8MU
 7L4MalUr6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiv70YGR6XW33z/PM0lOum
 Vdzs64Jt22c03XUonqWncq5IKn+56mJGhg1OeZZsNpLJO3pvPW7vs7/DfY9T/aDz4i3uWve5v+T
 94gYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index dca96db19f81..3a35f9b125f4 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -327,16 +327,11 @@ static const char *ovl_get_link(struct dentry *dentry,
 				struct inode *inode,
 				struct delayed_call *done)
 {
-	const struct cred *old_cred;
-	const char *p;
-
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	ovl_revert_creds(old_cred);
-	return p;
+	with_ovl_creds(dentry->d_sb)
+		return vfs_get_link(ovl_dentry_real(dentry), done);
 }
 
 #ifdef CONFIG_FS_POSIX_ACL

-- 
2.47.3


