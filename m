Return-Path: <linux-fsdevel+bounces-68369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 594BEC5A233
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CBCA8346245
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F4C326942;
	Thu, 13 Nov 2025 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCMjKi5d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABD2C3245;
	Thu, 13 Nov 2025 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069554; cv=none; b=CC3u8Has8BDTiMEiBhco6GRc2Rq6Xby6u314taH/KKxkgVryUc8zXvxTmlFt3HjPov/nuvS6vLBSb8+G9TK2+onsV02tfTOk1nRgyO+jFqBloAbK3yoJEl0f0PrzlTnywG9gCThajVkH0iKdH44fg7n9ZeMgT6cHIb/n9eHnVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069554; c=relaxed/simple;
	bh=F0sqdcVxRKZpq2qXQxzycOKbw5B11rHZkfCZfiEvcGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cQH2NFJAG1GM47hggWulwG9aGkWSKxxqSS4Y6pksAcK8Re+k8rQBrl53owjmiOkZg8md5GBSUgx75uR8xU4+HL9lpYwHkxBs2YRfu3izTB8dpVkiLeS7r//S5GwMujVgz0GNnIDsuNJBAAvd/5Jtx6+P85s68Lj3VtwKSWsmWNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCMjKi5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D03BC19423;
	Thu, 13 Nov 2025 21:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069553;
	bh=F0sqdcVxRKZpq2qXQxzycOKbw5B11rHZkfCZfiEvcGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KCMjKi5dCaiOpDJ+0yeThCTklfG3oLf8gfckshHP3A/7cF2HuP7sf9ffOZfiBadCi
	 GnOlVSwPWNqmygBwuUxLjsyt96d7HXpowu2l/9VXcFhz/N0X+eddBa5BvmBQKGzCd+
	 2xEEbbIjAaiBGtcwppwjYY3fwb+vQP1rNxYz1zcJrPjWohB6IniH5AsBqDvQnJDRnd
	 kN2TiERmdHxjBVVqjCo1EzN6Vm4+9QRZY5HVR8cbcf32NkJH5C2dQz2o4OQscZai8O
	 qSGeT0nNcw3NjXSLgDoIFzoUwD1iQU0WwiBhzShaAsC97J4rc6Lw+rDyIkHSxoAhRL
	 pxFhABktL/msw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:56 +0100
Subject: [PATCH v3 13/42] ovl: port ovl_setattr() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-13-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=brauner@kernel.org;
 h=from:subject:message-id; bh=F0sqdcVxRKZpq2qXQxzycOKbw5B11rHZkfCZfiEvcGM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YUd5HZdbX9ok/dV4X2R618d4nyww8Wu9ZTj0sP9G
 42TWWdzdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEZxsjw1z2A6+/efxd9Trv
 5dPH68Sf6oS6P/jDv0TySHNC3zvXBWaMDLPYzn/rahHi7VNNmHouyO+21eY1E5RrNDlvrgr6+Nv
 BnwUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index e11f310ce092..7b28318b7f31 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -25,7 +25,6 @@ int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	bool full_copy_up = false;
 	struct dentry *upperdentry;
-	const struct cred *old_cred;
 
 	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (err)
@@ -78,9 +77,8 @@ int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			goto out_put_write;
 
 		inode_lock(upperdentry->d_inode);
-		old_cred = ovl_override_creds(dentry->d_sb);
+		with_ovl_creds(dentry->d_sb)
 			err = ovl_do_notify_change(ofs, upperdentry, attr);
-		ovl_revert_creds(old_cred);
 		if (!err)
 			ovl_copyattr(dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);

-- 
2.47.3


