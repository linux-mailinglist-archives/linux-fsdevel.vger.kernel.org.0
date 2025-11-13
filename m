Return-Path: <linux-fsdevel+bounces-68225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBDDC578A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76646356156
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33FD352FBA;
	Thu, 13 Nov 2025 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhxnaxKp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4084352956;
	Thu, 13 Nov 2025 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038968; cv=none; b=otcIHZDPPet2sEMpU3CuKQKpIAyEN+MJ4A0jR3boC62ZqLYQbRrctUUMK7Fu6svYiooZWwL2a3DIpO3Vaw1ZYzi0OCWq0cZjNCUtPIL4SQTb5KqgFiZ7FWZ/SgK0OdlBLQXgcVdipIpdH11zAUAi1wHr8swy6tClbaa5a57gKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038968; c=relaxed/simple;
	bh=nfQ19OB4qlzHo4jThkjG0yyqbqLzMCPsdaote+0uKQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEyshX3IWdFues6xXU9ow0O/Sa6Mw2N4ZPLu3pW6DLG+IhP9m1FQ31KIdvlnbUwI+cVDkK/8xwW7ZVdMx2koymTbND2jBjaW3pzv3ksptAKHBOwdX/9zOpXqU99ITKI25xedNVZDNjtTotRM3FwP2/9BbO+iHR0SnZbX9RgV6Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhxnaxKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35143C116D0;
	Thu, 13 Nov 2025 13:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038965;
	bh=nfQ19OB4qlzHo4jThkjG0yyqbqLzMCPsdaote+0uKQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BhxnaxKpFB+qCsJ24/PjeEPNwzImGFcWnVSCWxM8CujM4omxOi9EeiVCEQxnT7gDP
	 dMVG230tC6hedhPg4QzePbdMuKfy/Mxn3Cd1rqDkE0bGXYhIAYmRosMidkBY41VDfS
	 bkA1L10ozgiF6tL7FXpazFOQoDB0uvJSK8hEhW08WDoodXrQ1G//AlbQlMHYGU3aFE
	 TmbRqE7F4rRPtaUd9r+TWznxlfhFrJiKp3a+UxsbRRGVTUc+dKukwcax9OkbrwX5tp
	 H06I8jc+Vj5Xtud1BmdAOB2kY6Hjv5RLYuuPRVJQfzgJtGWCYWt2b9xcTRFJsd9XL+
	 BlecCGnHzxyog==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:28 +0100
Subject: [PATCH RFC 08/42] ovl: port ovl_llseek() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-8-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nfQ19OB4qlzHo4jThkjG0yyqbqLzMCPsdaote+0uKQw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnuUGJjz8WH3uoNL2Z5IG5sUhUc9W3R3leSVb+bc/
 oVTrfZc7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIzWtGhunPXkYcqr/c75sb
 /vnCxl+9mQr3Gtbdf/hmbk4vX5ju3lCGf6pJ0pEcOUJ/sqQsuwU/Ki3YenYhgyvr7bfh2Wslt7Z
 N4AYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 1f606b62997b..e713f27d70aa 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -245,7 +245,6 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file_inode(file);
 	struct file *realfile;
-	const struct cred *old_cred;
 	loff_t ret;
 
 	/*
@@ -274,9 +273,8 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	ovl_inode_lock(inode);
 	realfile->f_pos = file->f_pos;
 
-	old_cred = ovl_override_creds(inode->i_sb);
-	ret = vfs_llseek(realfile, offset, whence);
-	ovl_revert_creds(old_cred);
+	with_ovl_creds(inode->i_sb)
+		ret = vfs_llseek(realfile, offset, whence);
 
 	file->f_pos = realfile->f_pos;
 	ovl_inode_unlock(inode);

-- 
2.47.3


