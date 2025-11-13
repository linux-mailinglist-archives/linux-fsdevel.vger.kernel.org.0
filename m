Return-Path: <linux-fsdevel+bounces-68327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8783C58F41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DC6427D79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876C536829E;
	Thu, 13 Nov 2025 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KO05rSSO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53082ED151;
	Thu, 13 Nov 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051912; cv=none; b=PlcOW2Y/WBZ+Dt9ypiKgfm0+9/KQ1KRazNH2NzEmKuWapGn47W/Sf7tdOXApyDrsAmvIQuM0wWTvHq18p8kp8zkX1ONf1qlZMktopUv3PseeSDzTwBIRU/rV7nOtXKZugppche6swAvpiRxiL9Ubu8HrfRvw/8mHWRrUg2x+P2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051912; c=relaxed/simple;
	bh=f/C4QOLoVkCowUDKqBvtZ6mccdpO1XNqr60YO7BVxTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxxgeGg/Wse8qd3IndWo+fs/FbDqtoOhaNnEetjy9bQx3eXLmmIHJCNyekmPI4hSYIAxD4fHuKuhkiLEQ1afbRu7hYnhq+yn6Kl5SIIpq3nS1e72YkyqVb9Bgw31du4IqPZqmTj+3YlHYW5fQOIOZ9dp9Znn5/KsSkPRv6WMIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KO05rSSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4114BC116D0;
	Thu, 13 Nov 2025 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051912;
	bh=f/C4QOLoVkCowUDKqBvtZ6mccdpO1XNqr60YO7BVxTI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KO05rSSOAZzGeSZ1N2/AYKsX7Rl3q9/itP4HoioRopPFM4T0s3bARGdcQAR26VnpB
	 2euQZEeZSHSSrYL5aj6BZJCqdM6Ftw1xuCTlOaHjw9x58Kf4vg42yTvmFMSYEsnM1b
	 YsLUznIoLjVg3jskYZthDjhCYQTzDnX1QMiwOfW0Nf8UuExMkYkmROfDngxgLSx+W0
	 tBv4qDXOITCYueLrxqO/88re+T1tqycXJYuWzf3IsDr/4682lYxoHsafe3pU0sr8bd
	 dMpPOIpMNIepRBpOfEaA/4VNwvAxpRu7Pq1o5OEMnGBJv+9SgdxBx1GEpSi9VUWknA
	 cv7RsSIumGHGQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:39 +0100
Subject: [PATCH v2 34/42] ovl: port ovl_rename() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-34-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=998; i=brauner@kernel.org;
 h=from:subject:message-id; bh=f/C4QOLoVkCowUDKqBvtZ6mccdpO1XNqr60YO7BVxTI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbpXpGcbpLv1lnubnUrYYuOadozz0Yb3Vz7Z5kx8G
 vd947SpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZ68Tw3/P4p/59VySYDv64
 e/vzYd+C3HaX9kmGbWGb29iOxvXdiWFk2Mb33pz3zqMCwYkrm1V8DkdaL7S4eOT5LbU7le+jWY6
 psgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index cd2b397d23a0..9d5cea06ca00 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1247,7 +1247,6 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	bool overwrite = !(flags & RENAME_EXCHANGE);
 	bool is_dir = d_is_dir(old);
 	bool new_is_dir = d_is_dir(new);
-	const struct cred *old_cred = NULL;
 	struct ovl_renamedata ovlrd = {
 		.old_parent		= old->d_parent,
 		.old_dentry		= old,
@@ -1318,11 +1317,9 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 			goto out;
 	}
 
-	old_cred = ovl_override_creds(old->d_sb);
-
+	with_ovl_creds(old->d_sb)
 		err = do_ovl_rename(&ovlrd, &list);
 
-	ovl_revert_creds(old_cred);
 	if (update_nlink)
 		ovl_nlink_end(new);
 	else

-- 
2.47.3


