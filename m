Return-Path: <linux-fsdevel+bounces-68692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 131B7C6352C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3EC1E381D54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB5832F74F;
	Mon, 17 Nov 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYnqaEZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438F326927;
	Mon, 17 Nov 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372114; cv=none; b=k8B4XcRbBrVEyCmHUfrlPr3hRBAI/aiwhxH4o6CAiLgsZcpTzNubyoBssOLBgePYsD9ezs8eR9AONv8odYQbMibkVuCgcErfkrR6H0WnkxyN/fQp3vHxqcPi3XXta6Xjtv8XmU9JAE6ydkNJwHYUBb+Rsk6xtr9cMKLBEJjoy/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372114; c=relaxed/simple;
	bh=nDgtba9XD/c2BaWxAWSI2BL5Bzd0CfPMoPSV/qrS8g0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BDPihoKpecyxoakaWXZzFit8CfzBBxEW5236Ny9TsE7edBDYVPejyPF/fWqDuWAMDbgx8ecAYZrpTGFUSSQTx1pln4FmX77L2L7LMQ71KlTEDE/uE7sZh9AE2llILcE9f1g2tsYODYK+ppSJcqorCu92zkKvTIp5Sod2opZp8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYnqaEZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF3BC4CEF1;
	Mon, 17 Nov 2025 09:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372114;
	bh=nDgtba9XD/c2BaWxAWSI2BL5Bzd0CfPMoPSV/qrS8g0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PYnqaEZWYoanu5g57wHoR/JaWT081+DQxR3hm6le4D+St02L1CkBh8wwxFkZaEylt
	 KN10HCI9VSpH5JNg7jO3V+GAeok39ZqddJXdAN67Rx6F5O/OdDutk28hbNZP033brV
	 tGi/UcW3xlVsJmHCCXa8NfYhmw8tRLZwqarxcqqWmeQVV+acng2cECYez0Q3+SDkzR
	 C+sKpy+ah8X+zxp6oOFyn4fFgtjOfxl9UxRuvoPL9vqCMFQNDEnysfY+Isu24h+OOF
	 ncEJJ6KWmuxuIVZWuSFwLL148UWyDoYfoNsWoQXKoqt4JwYzNxroGqKEcYWqZZ57FZ
	 Gy8FjfyvoMECA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:43 +0100
Subject: [PATCH v2 6/6] ovl: drop ovl_setup_cred_for_create()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-prepare-v2-6-bd1c97a36d7b@kernel.org>
References: <20251117-work-ovl-cred-guard-prepare-v2-0-bd1c97a36d7b@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-prepare-v2-0-bd1c97a36d7b@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1653; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nDgtba9XD/c2BaWxAWSI2BL5Bzd0CfPMoPSV/qrS8g0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvXE117kQvNrk+O/TSefvzssTuM89ecm93ZqbnkYpv
 5oW37xkXkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEbvIwMuyoyObSFnEoL7xg
 tSW0dFmF0NQoibAbb17GTJFdI7dy5QFGho5/DmwSLxel10wz0uWe8KfzQM5FhqeSx7Tz88oi5t3
 lZAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It is now unused and can be removed.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index cb474b649ed2..e428a2de59fc 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -611,39 +611,6 @@ DEFINE_CLASS(ovl_override_creator_creds,
 	     ovl_override_creator_creds(dentry, inode, mode),
 	     struct dentry *dentry, struct inode *inode, umode_t mode)
 
-static const __maybe_unused struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
-						    struct inode *inode,
-						    umode_t mode,
-						    const struct cred *old_cred)
-{
-	int err;
-	struct cred *override_cred;
-
-	override_cred = prepare_creds();
-	if (!override_cred)
-		return ERR_PTR(-ENOMEM);
-
-	override_cred->fsuid = inode->i_uid;
-	override_cred->fsgid = inode->i_gid;
-	err = security_dentry_create_files_as(dentry, mode, &dentry->d_name,
-					      old_cred, override_cred);
-	if (err) {
-		put_cred(override_cred);
-		return ERR_PTR(err);
-	}
-
-	/*
-	 * Caller is going to match this with revert_creds() and drop
-	 * referenec on the returned creds.
-	 * We must be called with creator creds already, otherwise we risk
-	 * leaking creds.
-	 */
-	old_cred = override_creds(override_cred);
-	WARN_ON_ONCE(old_cred != ovl_creds(dentry->d_sb));
-
-	return override_cred;
-}
-
 static int do_ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 				 struct ovl_cattr *attr)
 {

-- 
2.47.3


