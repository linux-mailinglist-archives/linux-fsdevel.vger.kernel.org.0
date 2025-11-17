Return-Path: <linux-fsdevel+bounces-68648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12491C63406
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87FAB355E5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401AB328B63;
	Mon, 17 Nov 2025 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6xcy3h2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350CB32862D;
	Mon, 17 Nov 2025 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372034; cv=none; b=cREmOc+ivsXaJDoOqvqFqssh+TE7/1aBeNdRr+L0z8VP1I0HGx87mbRlaY/w6Fw8NnMV9l192DLnUfBN8hSCk0IjApShCmw4LSff34hmCNlidStZXla0qxMSTEFrh1y4vpzzBrGFLQw2xCHapkoB6tEnmLlCsw2r1oyxRrjIV0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372034; c=relaxed/simple;
	bh=B2+Y0YF3/vmrw7dYZj5bbU+H2FgZF44A5BgQtn2E3aM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PnjDFw67G1uAsVIar0ubbmV2IqEUN0o6SnRR/O6Sp45GWDMn1XXvQyQl2U6mJ1SD1QCK3y9+RjiNGkvCvtByWSvIMxV/yGAskn3Gkjqs6ssgwcyl64lkMlmoId1RWe9/mRa/0rLlx3g4zJ/Gt9TvobwOsvPDY5ZMGZ+dR6lBcKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6xcy3h2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE20C4CEF1;
	Mon, 17 Nov 2025 09:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372033;
	bh=B2+Y0YF3/vmrw7dYZj5bbU+H2FgZF44A5BgQtn2E3aM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u6xcy3h2wBXsYd+5xl2c/uzvYUHtPV51e1YcGPrbNPAedOju88nu1PeI09qWkgyuJ
	 v82ONZsa3K0UdLh/MxmyKaYR8wtbUfGXPuRP79dWcGJ0H49I6Z07hv9gxpMO4pADdP
	 t5zpmNSYAXWNMLFDUcGSbzsAuJr/tjOaeTCqu7sOWq4ldJaKNRzFuloK70lEuRG1t9
	 /3cCQ8UVY3I+0LNmWyKszEB2mEz1F84M643EbRKds0F+GilNfO59wKdCgcDAMcvddP
	 yqwOhrRw4PN0TiskBn7Ex22/WGRhlc2UEwqbdmC1yDIoL9vFxYUcix0+Fenv9Fa4rF
	 pNY4N/EIpBylg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:36 +0100
Subject: [PATCH v4 05/42] ovl: port ovl_do_remove() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-5-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=brauner@kernel.org;
 h=from:subject:message-id; bh=B2+Y0YF3/vmrw7dYZj5bbU+H2FgZF44A5BgQtn2E3aM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf7y99bCM8kHjOY8k7j15Pky/9knuaw79KYdXCl5W
 dd8hdght45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJhH1lZDi0crEzp2pS+jFX
 iZXOCZv+pr19LL9z3zEm72P1JimpvCIM/1Qjd8SGzorWvOZ2bU1Kh/I6gwexfTrRc9I9d5lGhs7
 NZQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 63f2b3d07f54..1a801fa40dd1 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -903,7 +903,6 @@ static void ovl_drop_nlink(struct dentry *dentry)
 static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 {
 	int err;
-	const struct cred *old_cred;
 	bool lower_positive = ovl_lower_positive(dentry);
 	LIST_HEAD(list);
 
@@ -922,12 +921,12 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb) {
 		if (!lower_positive)
 			err = ovl_remove_upper(dentry, is_dir, &list);
 		else
 			err = ovl_remove_and_whiteout(dentry, &list);
-	ovl_revert_creds(old_cred);
+	}
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);

-- 
2.47.3


