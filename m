Return-Path: <linux-fsdevel+bounces-68228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 240B4C57869
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBF604E1D47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70B5353892;
	Thu, 13 Nov 2025 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCEh/KCF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9935389E;
	Thu, 13 Nov 2025 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038971; cv=none; b=b/HQSUOd9dJTO2fFPHFnpGGed+SsSn6G1pClCzUZY8QDmHUGba9cAxgpaJWQNL2yJUiae4A0XXFdA3QQez6Am/zfswNviY8QNonzc5IV1EUs1l5mgIJaDshqmEC9eHcxifUFRbzJxkrh8f16yn/B5hEufsJqdnaCgfRwpJ8aHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038971; c=relaxed/simple;
	bh=RFnDeF0MEob4qpugIedwhge3My+mr5DGS8UurPlba4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QtRbdquqxU6u2J24LEWF0XYdphNM28xH57IeJoY0sb8kcUvMYa9cEvNkpqS19TSn31pL+7MUPgD7sKam7G/N0obd8v3EMf1eBf2XVhuqGd/W+Nb48rcxW/n6e63Bg53GTRTDiBL8SWChCfSlWlmTaHUxl7pQCzobOYv7QJSKI6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCEh/KCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A69C16AAE;
	Thu, 13 Nov 2025 13:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038970;
	bh=RFnDeF0MEob4qpugIedwhge3My+mr5DGS8UurPlba4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FCEh/KCFqn+jEhC6MinZk3inahAPhQunVLmeSVDLJw8VXNyYbw8HN0a1+eKgWSXqv
	 96NYsVxBpYdpOwhdjOmEVl5+FWbvQv3zGYGpOIWSSAddQVL81Gc0ILJJQVA3GlTY6M
	 TefIKBP5D4NDxJ8Z/PqtpoP5c29/AmZ68KPABD5YVsPleJzB2OH2TflwxLz6U2p4yv
	 SiYhHr3pTlQqLIwlir0M6CiuQ8xsVvw//e+MuDMNWTtl873xDuJ9WoFpqvXuRPT8pE
	 XRjEEG5gpkPaMfep+a+1P4SNSJ6tknyyGVTNH5jyYxmIezlyE4NepJvxgZ3JQoG9KM
	 zYa+IWh+ZUH9Q==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:31 +0100
Subject: [PATCH RFC 11/42] ovl: port ovl_fadvise() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-11-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=989; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RFnDeF0MEob4qpugIedwhge3My+mr5DGS8UurPlba4E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnu0fRPLt8iy4h9Ki67c17wayFwt+G7Zzrtmj87Vt
 6rUG36d1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARPg5GhiYmGaem3OI1271v
 zHwss6+FY2NK7Dr1X+7OdwNb/ZYYNjMynGewfnslcJeq7d1bwVdeyX17K6f+a0KE8h61t6/19Mq
 uMQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 28263ad00dee..f562f908f48a 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -510,18 +510,13 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 {
 	struct file *realfile;
-	const struct cred *old_cred;
-	int ret;
 
 	realfile = ovl_real_file(file);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fadvise(realfile, offset, len, advice);
-	ovl_revert_creds(old_cred);
-
-	return ret;
+	with_ovl_creds(file_inode(file)->i_sb)
+		return vfs_fadvise(realfile, offset, len, advice);
 }
 
 enum ovl_copyop {

-- 
2.47.3


