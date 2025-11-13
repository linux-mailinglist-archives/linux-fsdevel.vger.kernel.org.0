Return-Path: <linux-fsdevel+bounces-68316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D82C58E62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8684203C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497DB36657B;
	Thu, 13 Nov 2025 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv3CAM+T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288135B157;
	Thu, 13 Nov 2025 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051892; cv=none; b=dSwCa7N0GZPtrUyD0Cxte39zprif3zfp14bOxZckbs8rbwfNAzdxKHlyTH6twIXdCZOC2qaAf4zYZ7yAhqF9PNkBzsSvvSL4Q73a2TmBdieKyXPFDzMigqgjfWK7IGsbhygS/ZPWK0ZpG8hRhhgSV8jIrrFC0Zed4XNjZTbAOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051892; c=relaxed/simple;
	bh=5ykAELZzm5DlWk/awe0ZIMVdBUEEMWwtOnY6Y5jyi0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwIoTBaZjoLULFbpJ6Nn6Yt6E63LhQm/MvPf8hU2wOU4OjwA2ficgsyHVr/9A73IO5yTPuVxZ9EpcyKBAxg+bar2q17bEmmnUOAKH7XiXZeOasRf9C/7YS7uC3S52nWtDdRmVYSuvFnTauXKFujQ/Rp/YRrQHFoGqdQGKtsmF7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv3CAM+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D9AC4CEFB;
	Thu, 13 Nov 2025 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051892;
	bh=5ykAELZzm5DlWk/awe0ZIMVdBUEEMWwtOnY6Y5jyi0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lv3CAM+T6ny1ClaPXBFwVfYNnueLlvX/TqYdpqQMtP17jO+te+6DWPrrFuga5O3hS
	 egpErHocE5gaSX94qXEkVnH0YIlBhcF055xXO+g+5XOTfa2JND2EvQwaHXWlJ2bkRx
	 ToI3/kkYrdwjeBtNXfWydrtSVAwFTGGjtiSnGqSv78LLHVXJpod6jZ2EeMAYwKStu5
	 qIAQWxm9gRfBhOq0EQa5s1kclZScDkfkr/zqd11yLh8XNndUsgxck+AqQGkWdc9fxS
	 Lm9slbOzmS6txbuJbd/lN4fRX+uslTZKD56KfFNZ8p1xMtOy/SSB4tJif8niq1nvPJ
	 XGwU0BfTj5adw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:28 +0100
Subject: [PATCH v2 23/42] ovl: port ovl_maybe_lookup_lowerdata() to cred
 guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-23-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5ykAELZzm5DlWk/awe0ZIMVdBUEEMWwtOnY6Y5jyi0c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbpNcLh4Wv7KWyefSc/Pus5rvMHP4C2Z8nty2n/R6
 o0xv2p3d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExksgkjw095S921tdIztBZa
 7GZcYpFy74pgu/nxwhUsXsvmvT93bjfDP5OmE+nJKzsn7Ax8c+rShblOfHVzmSdomgRHbzopUbX
 Rlg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/namei.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index dbacf02423cb..49874525cf52 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -996,7 +996,6 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	struct inode *inode = d_inode(dentry);
 	const char *redirect = ovl_lowerdata_redirect(inode);
 	struct ovl_path datapath = {};
-	const struct cred *old_cred;
 	int err;
 
 	if (!redirect || ovl_dentry_lowerdata(dentry))
@@ -1014,9 +1013,8 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	if (ovl_dentry_lowerdata(dentry))
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb)
 		err = ovl_lookup_data_layers(dentry, redirect, &datapath);
-	ovl_revert_creds(old_cred);
 	if (err)
 		goto out_err;
 

-- 
2.47.3


