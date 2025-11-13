Return-Path: <linux-fsdevel+bounces-68392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8C1C5A3BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 659BD4F5539
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C627328B4D;
	Thu, 13 Nov 2025 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwSqM4tN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5834325713;
	Thu, 13 Nov 2025 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069595; cv=none; b=eOz0eoMU8E3t7YXxMMazpffFPRp2reTdRJlWYCSlBmfE95VJ8baZYSZTh2+T+nyfTuENgwq649BYZ3hgIjDZQOodzg8a14GM8OXeZ0fY2JcNTyUJy5fDqKyCJ9Wjf+UoPzw5kDFmOYSsG3Sz1niEDHjZUzxLmM1okFpQC4Zjg5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069595; c=relaxed/simple;
	bh=lyu6vcks5WeowdDtzkpH236RP/LHscuF4A7OeNmFdj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orSSy16XDQNQ5jABgyT84C3aoUoA3mbaiUESAov9NOPpSUAsEckt671gdb3T/Eg8c/aBH3Z7DkNSQLfGG8tAOrMeR+vIZmkeVXwBRCHatrHdFg8Lx3T8dnlTLsrQNjogcNF587+ScE8Fi7qIOKBG5NV2Yzupj4vsCrdv3c1RjUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwSqM4tN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEDFC4CEF5;
	Thu, 13 Nov 2025 21:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069595;
	bh=lyu6vcks5WeowdDtzkpH236RP/LHscuF4A7OeNmFdj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hwSqM4tNZnRIz4nz7gtWz3wvYyi42VQ5N19bIq/qR3Ax42IeNyCS6Njx3HH5pH1ad
	 kcFyub/868mH6Uim+cUCgNK3gZQAiudpGMTE5Wu8wV/CYkVzmcwI5HddTWnnFu7CEP
	 hv7fRFoXUaqTwUSRPo757sFNrUY1bnuHZrLyWMGXqucu2X0/nCdbrirhqqSKsG7olK
	 TfOxuxW+ZebofNd8ikWJXE2G+XBfE9Bx6DCQMrxHVO7hD0a/Mun824wxEhrOFkvr+Q
	 HAp1oeM59ccAxrZP2AHjBdW8qFGGZ1loGxpXgbN7eIolGJ69RhW5B0ysm7HeJxwpo1
	 AqtRVZMBtjs6g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:19 +0100
Subject: [PATCH v3 36/42] ovl: port ovl_copyfile() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-36-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lyu6vcks5WeowdDtzkpH236RP/LHscuF4A7OeNmFdj4=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGkWTlijIKiPHxlK4MRHrCT/fMyg+5B3NxfhvHpwDUbh0p0N7
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmkWTlgACgkQkcYbwGV43KIh0wEA3q5d
 CNCELAQ6AVis2tNkQDsXNAxsGUyp9eVU7oVX5IQBALk4UoLZeeZtSmTQlwhUIf7Wvcfyl79d4as
 sDUOKzY4I
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index e375c7306051..42a77876a36d 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -531,7 +531,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 {
 	struct inode *inode_out = file_inode(file_out);
 	struct file *realfile_in, *realfile_out;
-	const struct cred *old_cred;
 	loff_t ret;
 
 	inode_lock(inode_out);
@@ -553,25 +552,27 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	if (IS_ERR(realfile_in))
 		goto out_unlock;
 
-	old_cred = ovl_override_creds(file_inode(file_out)->i_sb);
+	with_ovl_creds(file_inode(file_out)->i_sb) {
 		switch (op) {
 			case OVL_COPY:
 				ret = vfs_copy_file_range(realfile_in, pos_in,
-					  realfile_out, pos_out, len, flags);
+							  realfile_out, pos_out,
+							  len, flags);
 				break;
 
 			case OVL_CLONE:
 				ret = vfs_clone_file_range(realfile_in, pos_in,
-					   realfile_out, pos_out, len, flags);
+							   realfile_out,
+							   pos_out, len, flags);
 				break;
 
 			case OVL_DEDUPE:
 				ret = vfs_dedupe_file_range_one(realfile_in, pos_in,
-						realfile_out, pos_out, len,
-						flags);
+								realfile_out, pos_out,
+								len, flags);
 				break;
 		}
-	ovl_revert_creds(old_cred);
+	}
 
 	/* Update size */
 	ovl_file_modified(file_out);

-- 
2.47.3


