Return-Path: <linux-fsdevel+bounces-68685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F69C634C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE529358D9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A7E32E74F;
	Mon, 17 Nov 2025 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZVUKeku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E28328262;
	Mon, 17 Nov 2025 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372100; cv=none; b=ZFwsR4xeCmUwOxVADnmma6A9qg567rKFLH+MmODOznN3QA37uu7oG02rreVVcL2gs2QJmNxEzkmEfEWBQ8LaAkCNoQFGOPjbSSzylC58Ich3QpCbf5BIyb96/5YVPno6AuvUz4FHkvgJqP2d8lxxeekv38bpTLaeCxtKePbj2AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372100; c=relaxed/simple;
	bh=ULK38kqJjMiA+l8RFycLI4QMy+N0BxTIEV+IiefQ7LY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XKtflG/JwyvNZE+G4Jirxt2K267m0Bv4BItobg9WYDzB1oat76XkEPHg8IOp5Q7xJXdHLHCzfa8Kuoq7dpi1DG1tEZH2VWa/Mlao7wyr2giUbXEFPHGgvhbxIJ/28vifrpPKCN73nEEyZVMGNqspXqzNlQMTFb2Szc7f/hlZIzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZVUKeku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D12C4CEF5;
	Mon, 17 Nov 2025 09:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372100;
	bh=ULK38kqJjMiA+l8RFycLI4QMy+N0BxTIEV+IiefQ7LY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VZVUKekuNEv/lclfnZwPfdW0Pai8+hjI6E/vdWvJTe4oG/3XfuOrIJMVCkq6xL8ap
	 D3bKajy0vrSV0zGUyi8yZyYci+SDW63/+3O0Vnl/fymbzFJPYTZTCe8qRc0YZjEEsb
	 PothNkL6RXKEYlEEfGNxT1eJfbO+XXzWFCFolhV/NED2pNNb7v4azaCSOLaLAa8b0I
	 r2N7nOQ1dqBGKs97c/8Lc4hBtQmNZJ6gVr1tyXr56YEqYLlTJe2cSTICjzAKYY36in
	 VamrLbYEzUvwi7atvt187nSFDJxSED4ET8sLuWYMqPSMgzcvB48CJElV5hU7au+7lG
	 FwetoXV1V8IaQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:13 +0100
Subject: [PATCH v4 42/42] ovl: remove ovl_revert_creds()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-42-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ULK38kqJjMiA+l8RFycLI4QMy+N0BxTIEV+IiefQ7LY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf5e1uyz+syy7Wf4d993c2jc45ys3yM09+jVayaS5
 3ptZ9326ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIug7D/3BOH52LPzKZ63yt
 9v9Xzwxt/5xus8B61bGzZmlta8UXCDIydH42ZF8mMOu70SLGkPaZshunbzv5ZvpdztUmp2ub/+p
 94wYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The wrapper isn't needed anymore. Overlayfs completely relies on its
cleanup guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/overlayfs.h | 1 -
 fs/overlayfs/util.c      | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index eeace590ba57..41a3c0e9595b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -437,7 +437,6 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
-void ovl_revert_creds(const struct cred *old_cred);
 
 EXTEND_CLASS(override_creds, _ovl, ovl_override_creds(sb), struct super_block *sb)
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index e2f2e0d17f0b..dc521f53d7a3 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -69,11 +69,6 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 	return override_creds(ofs->creator_cred);
 }
 
-void ovl_revert_creds(const struct cred *old_cred)
-{
-	revert_creds(old_cred);
-}
-
 /*
  * Check if underlying fs supports file handles and try to determine encoding
  * type, in order to deduce maximum inode number used by fs.

-- 
2.47.3


