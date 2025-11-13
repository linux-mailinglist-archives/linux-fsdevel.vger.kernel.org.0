Return-Path: <linux-fsdevel+bounces-68245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A45C5788D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87CAC4E22D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAAC354AF2;
	Thu, 13 Nov 2025 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNp+Z52Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B85350A1B;
	Thu, 13 Nov 2025 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039002; cv=none; b=RB5HxN8icVj3meu2XXBFWz55AzSj/ODrb3CBdZLHvd6Z8q7GaX0gVB3H4XFYSz3YxeCO79Lf1ZfZ4BtEhHwQXN55q5o0+gDe28MaY9XPBlyqe5GoEVKtvwq7DSa3oD/uiekPV9YsHZhm5Jpp2yl1LmKlvBKu+omudx09dsYAwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039002; c=relaxed/simple;
	bh=QQT5/sSOaPhk/MXUNLQ3s+V0G34puIfWoq8P5lfjomk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Anq/Ct4EWHj5s7qLIIanVVneqob0ZFST/GSyPDlD5Ku5XGdkSM3iw+T3kKkOJN11bV1woViMQ1+FysHOpvnGP/KcYNYcqt2x+r5+fn/tKmTiKUkT05BfGCt/v90rXTZnrR8kqSI88TVHoZIGChskF63cIvCVEj3sWr42yR1UcEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNp+Z52Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD9EC2BCAF;
	Thu, 13 Nov 2025 13:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039001;
	bh=QQT5/sSOaPhk/MXUNLQ3s+V0G34puIfWoq8P5lfjomk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XNp+Z52YwRdMcGHyG19pDedhqG0Hsb6ov8gg3v+0xbLA49LKZEQjgqq0wKwJ9Lkxd
	 b6OV+SPczkfBcIHi7jL9vMzsN4iZlvs9KQx3lxkG/8YbrVKxkAF/xas/nRmJpnvZtX
	 bOW/Q07T4DH4xzDJp1WNYfZ0cwWBSRcIIdVaPU9yOSnmAgpztB19UHr4E4i4x/bTrd
	 eu0qZx7MJGQCuElmr+5NIjbRJo7QQusVR91UTb7y3zOEm6Zaa9XE8G3fgxuEXxzQnz
	 wE3qA11MK6Y7XhbcNlmA0jeamKJ4iegDmVmRlK6mj/9V7zWkJow6dqWLgyEiWQRzit
	 w6bXzyMzvBLLg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:48 +0100
Subject: [PATCH RFC 28/42] ovl: port ovl_check_empty_dir() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-28-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QQT5/sSOaPhk/MXUNLQ3s+V0G34puIfWoq8P5lfjomk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnvisVBHsfrEtAQtr9uzdkbmpC3iuuDPLSXsHmIpd
 6Bn68JFHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5t5iR4UJM0ZPi8mi2nMPP
 /rMH7BYuubl+mjlncP79zttZ95Y/fMPIsGdJQrMmm+fvE4X7mhaqT4tyeDZ7wpoF1lHHl8y8yL5
 cjRsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/readdir.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 502fcc0f0399..77c4825a06f9 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1058,11 +1058,9 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	int err;
 	struct ovl_cache_entry *p, *n;
 	struct rb_root root = RB_ROOT;
-	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_dir_read_merged(dentry, list, &root);
-	ovl_revert_creds(old_cred);
+	with_ovl_creds(dentry->d_sb)
+		err = ovl_dir_read_merged(dentry, list, &root);
 	if (err)
 		return err;
 

-- 
2.47.3


