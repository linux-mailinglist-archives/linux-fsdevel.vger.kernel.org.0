Return-Path: <linux-fsdevel+bounces-68301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A84EC59043
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B24DA5631BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BF635A934;
	Thu, 13 Nov 2025 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E28qKjm+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5349361DB3;
	Thu, 13 Nov 2025 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051864; cv=none; b=H2j0lkxVjcb3zghdYYG7rdq7t4w8Lwyj5DPBrVpZtlxxc4mYVrGdqbQ0wFAyGzj24gK0PsNu3JsW9mzy0JHVUZn042B/KetJ8LfDkUU2/ntVpX6tCNrBjuhsZCEN4Jqnoro+0wKZgEUzBxWThZ05TrGx3jeG8NjViX/jbvASf60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051864; c=relaxed/simple;
	bh=f3N0VYaOV3yEi7e1vqRon5+i5ePh7wf4Y4ECTOOuJ8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O43en0/A+YrrU3h5xsQgwzCNjlvu6LPg7slHEtYLs6KmP1rcKoXu1A2S3II71C1ElR9MP2KFyhi3dP1dOPIYQ0YZVNbtWxJtdpl6moKUttZZcmegRsd85ifpvttQ43w1j0AlAPcN+8JM9kn5qlXSSbVv00Rb6IJvLMSfaDcOFM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E28qKjm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E035C2BC9E;
	Thu, 13 Nov 2025 16:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051864;
	bh=f3N0VYaOV3yEi7e1vqRon5+i5ePh7wf4Y4ECTOOuJ8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E28qKjm+k+80SfQQDU+ODhttdmp5SfhhqUJIsR0Stw/9ackfo8ql5BwPnr+tNWe/J
	 veq7Hyg816cSFrv4oHqbgGik24rHuNwqBSRjrrZ6n0HysKOyuSyZ81hBmoGXM1m3O6
	 lNd8W6dFPi5SCfXYJuy6WX7diMeQG/bZMZHm5iEE3DkJlK74V98CuftsaLmwh/kc2Z
	 OGi+69ld22xjL/NJXAe0nRIvoBIh/gYnKjSl8BwnCyO8W8SvTeHjxLLZpD1AWt/9wP
	 AZFtCipwD2Sl0ThhA6oohyo1YvQN9cYUDqTqji/b/BywG3xSqlbw3m8eJ2Ern2xqW6
	 MfDGQEHVmtvDw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:13 +0100
Subject: [PATCH v2 08/42] ovl: port ovl_llseek() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-8-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=brauner@kernel.org;
 h=from:subject:message-id; bh=f3N0VYaOV3yEi7e1vqRon5+i5ePh7wf4Y4ECTOOuJ8M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbqGPY6a2WCxwWG9q4Y/A/fP5e5aSStl5nQLcpd3x
 5gJLjnaUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBHPjYwMj9fWTM/1vnFWJ797
 SdTn4y7uTeYMPhP3v9A22XXCQXLvLYb/4Xz3/l/SfnXmIOdt3nOl/5KVK2VPO1vn8uwIY5dunmX
 FDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

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
+	with_ovl_creds(inode->i_sb)
 		ret = vfs_llseek(realfile, offset, whence);
-	ovl_revert_creds(old_cred);
 
 	file->f_pos = realfile->f_pos;
 	ovl_inode_unlock(inode);

-- 
2.47.3


