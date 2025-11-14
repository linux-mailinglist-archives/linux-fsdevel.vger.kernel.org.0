Return-Path: <linux-fsdevel+bounces-68553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B675C5F882
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 23:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0C864E2660
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 22:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12438301473;
	Fri, 14 Nov 2025 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evzmHh5O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC992FFF9C;
	Fri, 14 Nov 2025 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763160339; cv=none; b=aY0mvFz/MGTUhq5fE7arw43Luc+zlmDQWJsGWrUTG3P9eod8p7GeaBnNjkfcmZDHacv32m0dSD5ksHSHFMOl/MNlWmfAEQvQWlExREvMAccVsZZTAevGsT2ocQYvKFRSkzs3XrC2ouRVMNNEzrDDOgP3sBh1owal71M+prPNt2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763160339; c=relaxed/simple;
	bh=fdRwnB7LIevOLDZngRzWQhpRkGoW8zq3EudhEZZzEKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhWmY9QjgoPKNDvr/FKkQkjTh2W0iaAZND+osEB26h7Jz/xwARtvZFVWb5c0HvI3bI6Z69Wug24KfkOWYqR9nizU4xDZLRKdiMQdm1gs+2Z0xhJxOklExVO13Sc12HXC1HoaYPoamnb8IfHT9/W6lZ6lnQt+JVnvFZ1L2U2IdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evzmHh5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D9DC4CEF1;
	Fri, 14 Nov 2025 22:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763160339;
	bh=fdRwnB7LIevOLDZngRzWQhpRkGoW8zq3EudhEZZzEKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=evzmHh5OGDPlrzJlnjN3y2fjDGWW+RwdqoquhAMtOwnvrGpjzncU7pSrgahnSELVo
	 duCLyyZpVGGKNlKQqjKfNjqhMYBddgAgnImr6Oaqq/qAg2mI5on7KvK8Jx9XXx/geD
	 LQb6WE6oBfth5cx9TtRfBzX8YgEhU9MF+MWVlx6Jk8OLRC2c3Tnm+3WrkLwSQNlUTa
	 kcpq7FVTaJWN68VX0BfNyV+TnMm8h0QAtEBo34aYDsnHBK21MXUUMy8laTYAzfrydP
	 Jv2fhqP0msaCD6mNRiKpp+WpDjigAPKS2nRmchbEAYcMpX7gt/cfZtmhrrZcoaDo/K
	 ECHv8HULAuogg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 14 Nov 2025 23:45:26 +0100
Subject: [PATCH 5/5] ovl: remove struct ovl_cu_creds and associated
 functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-work-ovl-cred-guard-copyup-v1-5-ea3fb15cf427@kernel.org>
References: <20251114-work-ovl-cred-guard-copyup-v1-0-ea3fb15cf427@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-copyup-v1-0-ea3fb15cf427@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fdRwnB7LIevOLDZngRzWQhpRkGoW8zq3EudhEZZzEKw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKb+Q44LzrKuP+Y3u4lyvPaQ/byLVsxd/J95LbFzt8Y
 OcVknm7s6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiX1gZ/pdZiTonq2fWihpV
 m1eVfhLjSPzwwKczh+tXnJmv8Mtd/xn+V/o+/CPYz/uGaX1U8UbrzouRrhXM29VUCiQvt+/b/Xk
 yBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that we have this all ported to a cred guard remove the struct and
the associated helpers.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/copy_up.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 2176903d4538..537295b17af8 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -727,34 +727,6 @@ static int ovl_copy_up_metadata(struct ovl_copy_up_ctx *c, struct dentry *temp)
 	return err;
 }
 
-struct ovl_cu_creds {
-	const struct cred *old;
-	struct cred *new;
-};
-
-static int __maybe_unused ovl_prep_cu_creds(struct dentry *dentry, struct ovl_cu_creds *cc)
-{
-	int err;
-
-	cc->old = cc->new = NULL;
-	err = security_inode_copy_up(dentry, &cc->new);
-	if (err < 0)
-		return err;
-
-	if (cc->new)
-		cc->old = override_creds(cc->new);
-
-	return 0;
-}
-
-static void __maybe_unused ovl_revert_cu_creds(struct ovl_cu_creds *cc)
-{
-	if (cc->new) {
-		revert_creds(cc->old);
-		put_cred(cc->new);
-	}
-}
-
 static const struct cred *ovl_prepare_copy_up_creds(struct dentry *dentry)
 {
 	struct cred *copy_up_cred = NULL;

-- 
2.47.3


