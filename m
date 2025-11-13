Return-Path: <linux-fsdevel+bounces-68364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D27C5A22A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA64335475A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BA5326923;
	Thu, 13 Nov 2025 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpXkn8aR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB163254A3;
	Thu, 13 Nov 2025 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069544; cv=none; b=gj+d17Vp8wIVkzzpOF9C8W6vt1ZF6o81ksomIo9zOWWw7xaCXNO4MjmOoGiQ3PImgUAqaibFI8/SuMxho2hK8QrBCyBhkOm+BemUOaWp9r/rFwsu77/d2aEbnmwWAcemKDZf6A/+I/cPCfliy0l2zhd2/pS06LXPdiFs8+LI0EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069544; c=relaxed/simple;
	bh=KFGHaLeqXLLXrh32v5PfFDZYIcKwEziBKk3OT7fXu5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oN6qXDjqOOePHVSDcdeQq3g91hJkyr36GSz4pV7Mky0dlHFag5ZcFagLBaamT99S50L0YzgIHgFJxok4lFNnzD36GRuQmmXfKXpM0YHbJiw9TeSrb6I0tFTdG/EinLJ9S9OrOkPwy4cqAlHGwIktOGQdtblR035Xz1vTCq900lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpXkn8aR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFCDC4CEF8;
	Thu, 13 Nov 2025 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069544;
	bh=KFGHaLeqXLLXrh32v5PfFDZYIcKwEziBKk3OT7fXu5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NpXkn8aRMO5IsPo0kjocIu0tvo4LPFRuEDYb6hbYwcEm3NLZNRngQBPa7MSeMH5hJ
	 suuZnJRagDtePL2umo87V0wnAUgyEKeHACp0U/7zZ6flDTVOBI0ImqTQ1SQ/2X8HjS
	 jGvVIw9NZT16O1tirBT+24fwHJbxnmZPuxB9cvG6Gh3t9HiJXn25Hq0utLRTE21eYE
	 eES9eJzdHALJOSBc+xu7vlQJpaCyMKvuQxdApuzzEW+LTRGvaFutQrJgCRxdBWhARX
	 QFwwxIUah5KZzMSqXMNKQGT6myWfdZIKVLg+8JQniKYbHVxtdR3Yn6s4hSJc6/74cY
	 6qw+/TRwdcLVg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:51 +0100
Subject: [PATCH v3 08/42] ovl: port ovl_llseek() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-8-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KFGHaLeqXLLXrh32v5PfFDZYIcKwEziBKk3OT7fXu5s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YX9f+EY+U/02vIjL1tXqdhmcNdm5qydteC7TcLn4
 2fjqq4JdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykahIjw/8+lQv9NWU/tb66
 JuzacCBdKuniyYM3P4qtTpvn0a4quZPhr+CzihWfdToyhRwiGn65NV0Ru6Ppt2C6cJnP1rvb7Ng
 EWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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


