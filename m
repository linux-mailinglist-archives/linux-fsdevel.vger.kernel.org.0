Return-Path: <linux-fsdevel+bounces-68660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E8AC63403
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 227674EEA3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871A9329C42;
	Mon, 17 Nov 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvQUKaM7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04E132939C;
	Mon, 17 Nov 2025 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372056; cv=none; b=J4RUdUq39UedSLdVxvHZn1RypV7ddqJXM5LTasasxMA2mflTAeBY4sGynB7MLCAoWDgZb3QmLoQ9EKDpyKQBYkHdOVcZX6583e4shRyCD75fwo0FB7kQdoNoUthFkvhAckok50acnilMRfolTTVZP6faC/tcH/9jKF2LYuMNPGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372056; c=relaxed/simple;
	bh=xR3sFH2D4S1Ty1W0iWziq6tLvi0ZWQFJXnHpfejcsVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRXSVEv7Ym7bc6tUvfVqKzW6mWiDTiuasKnRuTUTRoAA4GXA4/UdrUnc6z9B1b2ra3dR8fBXsywdNvXxq5kaGmvzmidRuUAqS1apGBAqtfW2QUsub8N2J6KHrcMB++G8+IlX9KNPbmS8vOoFpXK6UDOUS5k7Qjb5vQqvAztewQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvQUKaM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B7EC116B1;
	Mon, 17 Nov 2025 09:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372055;
	bh=xR3sFH2D4S1Ty1W0iWziq6tLvi0ZWQFJXnHpfejcsVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NvQUKaM7Y642D/Xj9tJ65y1l30iP15xpu+v5851lporHc5qmA8kBTeRLyEt6QU3BL
	 MWZgBGkIP38WNMkT3vJ101PxAEgN08fnSqE/L6jH1D2ofhekWMYTbbiUkVTsUdXuWL
	 KdETjXClows3qvK8/RjYNNnex09FrcjHVYl3yUlAUteDkBAjFu5u7JqFbNRuqpVyoa
	 LsKanHPhi9e9Mk8xwCTe4/E6sKmuyqeD5JaRb2X4oQnNPT897h74QhMlysgF2wFh5a
	 1TIcbBu8vyNDtDrcr4iLnaaVeBJyQ0grgyaZfQaqV/Sc9HhN4/lzYgorNS7ROV1ySH
	 mFXhF9mNRkqaQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:48 +0100
Subject: [PATCH v4 17/42] ovl: port do_ovl_get_acl() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-17-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=787; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xR3sFH2D4S1Ty1W0iWziq6tLvi0ZWQFJXnHpfejcsVA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf7Kke/0g7+qwfvEIZkXv+zT/OfZRa9lrZq9oSjpX
 HPYrPqTHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNp3M7wv2DLq30xvWePmwZy
 +HZu/nkp1DDo2J/kgG1nxNknXZxk+JDhv8sd9xbXhexl5m7zMj9c2K1gOHNi2a9Y7y8hy2/FdJ1
 dzQQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 3a35f9b125f4..1e74b3d9b7f3 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -461,11 +461,8 @@ struct posix_acl *do_ovl_get_acl(struct mnt_idmap *idmap,
 
 		acl = get_cached_acl_rcu(realinode, type);
 	} else {
-		const struct cred *old_cred;
-
-		old_cred = ovl_override_creds(inode->i_sb);
+		with_ovl_creds(inode->i_sb)
 			acl = ovl_get_acl_path(&realpath, posix_acl_xattr_name(type), noperm);
-		ovl_revert_creds(old_cred);
 	}
 
 	return acl;

-- 
2.47.3


