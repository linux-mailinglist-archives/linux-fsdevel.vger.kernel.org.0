Return-Path: <linux-fsdevel+bounces-68221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC11C57884
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 765143556DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3A1352F8D;
	Thu, 13 Nov 2025 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEDBYHEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C21350A2D;
	Thu, 13 Nov 2025 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038958; cv=none; b=Zi9ClaasvMwTbyHWEHLtYGiEJZHrsko4BlH6cGZoavHt8XxEwZKq23Qju4ezXRXcCFhFgCLddamCZTaXn8Q35XuV4YjaVBs2UojMf1w9mVwNrTIBAwkQZ5YqY3svq93RazZl2aIZIrskPu9VDOCW9fyaxDp4OZb8XkPzHr1Ol+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038958; c=relaxed/simple;
	bh=2b3rAoY/Uqkq2cYdzGQYI68zZPND/jhfiJgWPBtUR/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h9TdHXjDTIhmKUTJZxXCfV/tZMNNVP3xXr1t3Ct9bxqifHu8x8Q4ZhYWFL8vwf5OqOIWrlkCfZiL+xwlesBHj2DHTQC6fFG9rFE3TLh60ayVnOLvjY72T1dTPNR+uErknc7OiiPV4jRpTDxisjWau3FK4y015EvPkZRJ8O3ncFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEDBYHEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B34C4CEF1;
	Thu, 13 Nov 2025 13:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038958;
	bh=2b3rAoY/Uqkq2cYdzGQYI68zZPND/jhfiJgWPBtUR/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eEDBYHEjVmyVfOFs8S59OteOA8wRLKNSg4DfWJ770QVm247gNVs9E+mGfCjdQ6l0+
	 4YVVZ6wz1uCqRlkh1g4FtmaO1TtPnnieX2nDLtMxy6hSX3ewmBGMy10DDJfbFMNQNK
	 aSGSIA1Gh9CnH/nb6zL5lL7HV1+MbqkECW98s7Ss2awU9HcVyBV5wKd1ymSo2BMoUl
	 Kx1MJRjArbEjBy5iLAYfvKNzLUVvNOnLe4J3qZl/VDeo3FZtWDDW+FvRmqxdLqBGYu
	 1zkO6B3MDLCV6HLx1YgRuJNbBJkhLkoGfyfHkB3zvVA/Yg+r8Xh4tDH4CDtGoOlPlB
	 su9X91rNJ/Gig==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:24 +0100
Subject: [PATCH RFC 04/42] ovl: port ovl_set_link_redirect() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-4-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=832; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2b3rAoY/Uqkq2cYdzGQYI68zZPND/jhfiJgWPBtUR/o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnt0jt+hP3mLQL3jvx/qi6R8JzuHFCQ+T+TMtLTj8
 uW/ePxHRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQaLjMy3EjYUbk/OruJ9W/j
 3ebF+qs2n3ywMmneb6e4MlXz2v67aQz/azW/Wv3Jsr3lz5F3sZRrH6sCz77OlV43Jux1qeVepRT
 MBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 93b81d4b6fb1..63f2b3d07f54 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -726,14 +726,8 @@ static int ovl_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 static int ovl_set_link_redirect(struct dentry *dentry)
 {
-	const struct cred *old_cred;
-	int err;
-
-	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_set_redirect(dentry, false);
-	ovl_revert_creds(old_cred);
-
-	return err;
+	with_ovl_creds(dentry->d_sb)
+		return ovl_set_redirect(dentry, false);
 }
 
 static int ovl_link(struct dentry *old, struct inode *newdir,

-- 
2.47.3


