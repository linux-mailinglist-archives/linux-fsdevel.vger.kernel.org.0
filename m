Return-Path: <linux-fsdevel+bounces-68242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FEBC578F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 467F93557DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66126352925;
	Thu, 13 Nov 2025 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD3qjBrk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8735471E;
	Thu, 13 Nov 2025 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038996; cv=none; b=ZnN09cTI9l+8bJtRoXYrmSN4kX+jmywL66P4seYHn70nZWuTkM4/7olBc+CCYNVh7goeGzXu1q1eS9TYONSpmt35wX8ZD4JVioleEnxYHlz9ReboKaVLvl4/Yp6+utGZrQxzl39CUTc1kg0GGQvrw5Dn20L6pO3g0P3mX/7vGHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038996; c=relaxed/simple;
	bh=4O7Q8o9QexWTLdmil13iO13D2Tqz0hU3CFmexvZfsyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ifqm3GyI83O4ByoEG37vU8etoy5Q+8uKH3hAl6VHOYHKZFQF9RbEUYQD5t9aC5fFM4HpDJeuj+TAfdRZQjC+SWYDITLsgCwWulXJP6qmitlAl7chpNjKZj7C08ECFu4R3QcfrlLmzsgnlPyX9o33MD03TWyN27hFtHzbHPZxdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD3qjBrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4DFC19423;
	Thu, 13 Nov 2025 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038996;
	bh=4O7Q8o9QexWTLdmil13iO13D2Tqz0hU3CFmexvZfsyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JD3qjBrkZBGhDk5q7t3nN7D0cvk9dUHmXMBeqas9ivxDICfAJfmGoJhwO6uvDen/R
	 lQruJuySWw1/sMGgtkYZnjIvG0RuOePo/9Wy8OFiG4tOeiAzTnx3eGHkyRke0KAtV7
	 WXJFrThS69F2dGH9TQWd90u+ZcbE/QpwfRyl6VvuxK/G+D6XFvvQpJNSkiL37bYa4w
	 s12iXSUpmfOY3IzKm/YjfBsVY//qQpByoMkv/ignTgLfjxMMIfLqUrsB2clIePmdGC
	 WvYPCpzaH0R9dViOpRBETUCC99SoTYTfPqbtV1JbWQ+zU/LmTQHIv2lfYOc6Lkn9pj
	 V+a/u5uKLyxPQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:45 +0100
Subject: [PATCH RFC 25/42] ovl: port ovl_check_whiteout() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-25-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4O7Q8o9QexWTLdmil13iO13D2Tqz0hU3CFmexvZfsyU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnv8a/3vn2ti2SdVPIucOuPu6ieWt/7vK5KNfzkx/
 uW0ikbxSR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATeZ/KyLDrvv2VkOnzsypU
 8qb7x5+/tVNzan+pxt+WfX/nWv63KXdgZNipzqSc19n6QiPj/oem7ScUXkdcO+/4VVX73TPDmM7
 Mn0wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/readdir.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 1e9792cc557b..ba345ceb4559 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -350,26 +350,22 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 {
 	int err = 0;
 	struct dentry *dentry, *dir = path->dentry;
-	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(rdd->dentry->d_sb);
-
-	while (rdd->first_maybe_whiteout) {
-		struct ovl_cache_entry *p =
-			rdd->first_maybe_whiteout;
-		rdd->first_maybe_whiteout = p->next_maybe_whiteout;
-		dentry = lookup_one_positive_killable(mnt_idmap(path->mnt),
-						      &QSTR_LEN(p->name, p->len),
-						      dir);
-		if (!IS_ERR(dentry)) {
-			p->is_whiteout = ovl_is_whiteout(dentry);
-			dput(dentry);
-		} else if (PTR_ERR(dentry) == -EINTR) {
-			err = -EINTR;
-			break;
+	with_ovl_creds(rdd->dentry->d_sb) {
+		while (rdd->first_maybe_whiteout) {
+			struct ovl_cache_entry *p = rdd->first_maybe_whiteout;
+			rdd->first_maybe_whiteout = p->next_maybe_whiteout;
+			dentry = lookup_one_positive_killable(mnt_idmap(path->mnt),
+							      &QSTR_LEN(p->name, p->len), dir);
+			if (!IS_ERR(dentry)) {
+				p->is_whiteout = ovl_is_whiteout(dentry);
+				dput(dentry);
+			} else if (PTR_ERR(dentry) == -EINTR) {
+				err = -EINTR;
+				break;
+			}
 		}
 	}
-	ovl_revert_creds(old_cred);
 
 	return err;
 }

-- 
2.47.3


