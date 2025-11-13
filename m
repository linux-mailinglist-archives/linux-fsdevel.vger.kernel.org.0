Return-Path: <linux-fsdevel+bounces-68367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F9C5A239
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20243B5D70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A3B326935;
	Thu, 13 Nov 2025 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eC1QHKl5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A8A320CAC;
	Thu, 13 Nov 2025 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069550; cv=none; b=DlXZPIKRG71iZSna8+DN8OqQ3bcNFDOLobZYv3aWvtPP3Ahj99GyIMNxmwbInyN6I1tCnq6/385A7tc9GnzuiTbE/vgXMdN2dA2kC+esWvhrbXbEtn5cRknC4PcMEVRBkZDTkQsrCCQB5T6ENSpfBxrxDWaYttA1vV421bSYGpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069550; c=relaxed/simple;
	bh=8ekCz0i+nQCss2JlZWQ8Ri5tJPGzRNJjeyfMjnRa8gY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UEnUzvh7O3IpSgEfiv9gvax0wQMO6gkDTDMMP1yCJgOQQh4C8Uunm8RKA/CTtt7UnZCrrtotTIQw0Gm1AJi2eHm+cbd2l/Ys/dGT+rqdCkCimci3DJ2n1vFFEFQ3desmZsrctWjeCCWbk04PtVStM2XpOcJ6xjR67sU87zRCqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eC1QHKl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A776BC4CEF7;
	Thu, 13 Nov 2025 21:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069550;
	bh=8ekCz0i+nQCss2JlZWQ8Ri5tJPGzRNJjeyfMjnRa8gY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eC1QHKl5mPZvlRcbn+N5IYvcEqJae8KNWAn3v9X/ARxJg1Khhpnbx8aTH4p04gGQD
	 f415jc/LxWcB5WnXGtqA7/MECv/0Rqun9saAuXxlhffGjueL75+ReXdQ8YDBHPng9I
	 vwbs+qHbC/cHfylG37s+z1Cp1PfRVfzLfCBC/WO3zlO+srglaEgb6f6Mlx8l0k+OvJ
	 ewRyMgAG8217E0Yv0G2Xa+yyo+I6wLn66++nCuJJ8oEfO1h/mABjFxWyJGlj8Cqcni
	 rxIavqzh9pJl7qIFrx6kISKmAyMGIVFebYJCLXNP6LFlbnuZbiPXgR2ahXH9n3TMkT
	 Ak3SVx4EH4nCg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:54 +0100
Subject: [PATCH v3 11/42] ovl: port ovl_fadvise() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-11-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8ekCz0i+nQCss2JlZWQ8Ri5tJPGzRNJjeyfMjnRa8gY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YV1rN/3YGXe8fNTeUp+BYfV7wqePZ2lTluKLe33g
 oMVK4SPdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkUwUjw9nLUzmi1u4ysHSf
 WLdJ5dhCVp+P8s/N+RV77366M/mz9i2G/xnfpuoY3HX3kLp9nFV8XbvjbOOe2XOqZl21nlyiYLu
 LjxMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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


