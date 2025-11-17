Return-Path: <linux-fsdevel+bounces-68657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8BCC63424
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE1E44F2B8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD7F32AAA2;
	Mon, 17 Nov 2025 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEJ8ZFHc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9883D329394;
	Mon, 17 Nov 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372050; cv=none; b=mpmbe4ZOe42WVEghNIwTVO+zREZM0vzaTHtmaYIdivuCGa1BhuISebbaSCrb5Ai934UTV4JOvfvQi5a1OmNTPr3ay+OaicxKHVF82kob1ptSOqsmWqpXLtFIIovw/xtt0uqLjT/ay2LPdrg9cKiWKy7Ei++DLOykDVPp3SR6jsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372050; c=relaxed/simple;
	bh=F0sqdcVxRKZpq2qXQxzycOKbw5B11rHZkfCZfiEvcGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tsolzc7zz7cK7zSnFj/gSIrizbENUy9kGpgSqUo0RDhmho8mgOZKdyc4h2R82IaroORjam52Z2G2wQ5w/8G3gT0IM3vaZGdVveL4ZWHOeovK27Es7ESo5co/Vx6lw8SCXCpBUgadTOE0BZgSqlcVM18lxjKrjF28csZ2f6Oc2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEJ8ZFHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28CAC4CEF5;
	Mon, 17 Nov 2025 09:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372048;
	bh=F0sqdcVxRKZpq2qXQxzycOKbw5B11rHZkfCZfiEvcGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hEJ8ZFHcgmpnEkPhIQVnLLq+jcluKKmGhKTi78IkC7oT6j5KyAlLfsz+aATJ9jQXe
	 R5PPCM/S9vcVPHSy1YPrr7AGMCXEnuAsuIicwWvm00wm1MqJ7yAJfMGQxKDQFFa9gb
	 Pc+C8tIG50GMPIpef/oGZAMV9MAKsaUHpSGcZsuEmiWdJneQ1a0EhXok5Ke9Zo1r0p
	 TRaarnTVjw/sVCTV+7Wr6a7asNsHtz2XTImtbS0EjX2biUXGM2L/MyiNBDZ8S51lCB
	 99mfPIkAXmAWJvhQGk995De6u4+SIRfw4P0NWbUu2Gv7Bc4l4uaRzLBYMOdQYrW6n1
	 IYYTKmeWK3VAQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:44 +0100
Subject: [PATCH v4 13/42] ovl: port ovl_setattr() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-13-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=brauner@kernel.org;
 h=from:subject:message-id; bh=F0sqdcVxRKZpq2qXQxzycOKbw5B11rHZkfCZfiEvcGM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf5a7bZ1Sf6dG0qTgppnNnu6KSsKdvybeHpnr8myT
 m3t/UJ/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCtYXhn/nlZjFtGaOzSfJb
 8hZX2tiXzfDbXLygtdvUp9g9nlcgkpGhR/7JMXX2t6UnvugV7FmuxHBmNg8Pq9edS4IPnn7/wDi
 DHwA=
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


