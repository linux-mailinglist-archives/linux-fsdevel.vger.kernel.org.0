Return-Path: <linux-fsdevel+bounces-68227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B31EC578AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B185351CD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115F1353899;
	Thu, 13 Nov 2025 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4SkzpR2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF5F35388D;
	Thu, 13 Nov 2025 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038969; cv=none; b=iuD7ENSDNSQcytTL9IBE28dx0RPPhNKeCJmMAJtjw0Yyt8rhHaRw7TSMunDK3l14Z2Z7wczo4GRDRzQqny9LBaxaQKLWZJJZQivFHq+ZVY3mArsmbdGmdoXqugMjRqrwlmj7NICRwp+98Hy+3W9HwKwiBPjn6eXteoSbEB0wsYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038969; c=relaxed/simple;
	bh=B0PySrZ4MO1su4viGVotOlVAoZ9jNaaSXWbQUf/NIsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K4EX+ZKJqaL3Vp4qyqnfDXhXsPjRbAR5/47ewr/UYEByfQGosdRevr9kcvn7haLxHaDGilHQyJypQ5wmG4wXKd/w2uccwO/ed9+mdfYO6VUkY5+BcS5ilbmFA9WZ8AbZG30PWOdBBKRlK6XlTtwjAzh6DarRPCnUO4AAEQ7fF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4SkzpR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD12C19423;
	Thu, 13 Nov 2025 13:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038969;
	bh=B0PySrZ4MO1su4viGVotOlVAoZ9jNaaSXWbQUf/NIsw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E4SkzpR2HWjNmPXUGe+UWRQhB4tKrIHwySUzsAmvYtRE7Ogixl7hAtNDp763TntSN
	 bG1jIzzi+piD470yvafEWLvc5UxHbFVTsp+75Kgnl+K460DfHT13Y6kPvSP9Jbe3c4
	 +XeKfoCNpJEQrATZwzFjtOYcNKpJWVxQNzJN8oAHKGG1GWp+ShBjwGAcksQAYIAb/C
	 c5haPICCUgvG//IxreP8rZJtHxBBqugaIPndTlKcDk6X5Yskcc3Pv+TOtcTx/S/czQ
	 lNlRZhApzj1gESs8GZ/hQsx/f1IYtD2M/iLc5PhOFQ95yz9lFn2hbcBiUXA87uTviG
	 hcAfhtjCkxGog==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:30 +0100
Subject: [PATCH RFC 10/42] ovl: port ovl_fallocate() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-10-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019; i=brauner@kernel.org;
 h=from:subject:message-id; bh=B0PySrZ4MO1su4viGVotOlVAoZ9jNaaSXWbQUf/NIsw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXntkuU1WtmDzv8vbnk34Un55/hs9rWMPv219fe4Wj
 0XhdDlz1Y5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ1JkzMqx3FWy6+r/Z40lp
 5pIa22LveunaP9MaY3d/q3+05Vnd3T8Mf2UaZ7+xnOT8fUp02Y2U2grV3ccXr/pgcXVpSJxuXFh
 OFA8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 6c5aa74f63ec..28263ad00dee 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -481,7 +481,6 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 {
 	struct inode *inode = file_inode(file);
 	struct file *realfile;
-	const struct cred *old_cred;
 	int ret;
 
 	inode_lock(inode);
@@ -496,9 +495,8 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	if (IS_ERR(realfile))
 		goto out_unlock;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fallocate(realfile, mode, offset, len);
-	ovl_revert_creds(old_cred);
+	with_ovl_creds(inode->i_sb)
+		ret = vfs_fallocate(realfile, mode, offset, len);
 
 	/* Update size */
 	ovl_file_modified(file);

-- 
2.47.3


