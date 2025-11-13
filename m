Return-Path: <linux-fsdevel+bounces-68363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 710D7C5A296
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA9F84F0A9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43E73254A2;
	Thu, 13 Nov 2025 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKr/L6+V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6C325726;
	Thu, 13 Nov 2025 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069543; cv=none; b=EfT+ffkNSKd5JMSrSjCNMBM2+zcZZ/9hR8UM/cKhd3Q9ijTSTxyTg68nIGEsGrBYDhq+kY02Z58neNiMUuEH1W+Il0kxEypHXAngllrwU1X1zo/bfimQDdCbTjUsCLXjSCa2sNDi9JbPU3ttwh869/38abSZzPXkwmSKW+Oow4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069543; c=relaxed/simple;
	bh=D3NzlfmrifsUTN0buNefyT8fRFt9vtpnzxT1KyeP750=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjmoS9FaWyDrgEUavu/3OX5eg4eIlxzf1icak5mpzX87o5V/PSPSfvPhe/o2V85pBt1fVhyv+Gn460I9VgcJVUZshk1AWcX4ASHRwy/mK1cGVjzyW/xl7LYsGvmvHwh5PRldedPowFYFnrgB7FZ4sNTGLV7Q6UEMXWEBzk5qju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKr/L6+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B695C4CEF5;
	Thu, 13 Nov 2025 21:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069542;
	bh=D3NzlfmrifsUTN0buNefyT8fRFt9vtpnzxT1KyeP750=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sKr/L6+Vi0ImVXX+xDo9znEjLXznLKAfGOg1JWgRXODHhCnlQm3na5KAIFJRb6iA7
	 g7oqsnIZUi2uNgHBC00W68PbMVxdUCRx1/6jR4I3F2EGZd0O4u1fSpRHYTViFhuqp8
	 1g3qvdqRUdTUwrjk1uOJcoYPRrvB5e0k9VD0yhYuG08Rx/rd/ZQGtURRobsTrKWejH
	 GjhzQXspkyoHvVhFMbSBfKz84BJPBkEnHuH07n1D/AatANW6pSAFSYWWQOen59OiY9
	 NP2Ixb33EU4daD9UUJBrJO1gXsDK3pFUAw9yE319p+T05qXUjmYoIjAUYnGmmPDUAg
	 3M4D80gJ23QFg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:50 +0100
Subject: [PATCH v3 07/42] ovl: port ovl_open_realfile() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-7-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=brauner@kernel.org;
 h=from:subject:message-id; bh=D3NzlfmrifsUTN0buNefyT8fRFt9vtpnzxT1KyeP750=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YV95Qw+uucxj4BQKJ9sxbQk/gtzPnXV277y9ig9w
 JD50VGmo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKHnzD8LzVa2DthwbR9NrNs
 vnuY3GBZdnLnT7XTdft9jiwPklywrZrhv9+ed8V71/1/Z5muGSx5RzVs5vvFi27zLXQRn3GsMuH
 wK2YA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7ab2c9daffd0..1f606b62997b 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -31,7 +31,6 @@ static struct file *ovl_open_realfile(const struct file *file,
 	struct inode *inode = file_inode(file);
 	struct mnt_idmap *real_idmap;
 	struct file *realfile;
-	const struct cred *old_cred;
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
 	int acc_mode = ACC_MODE(flags);
 	int err;
@@ -39,9 +38,10 @@ static struct file *ovl_open_realfile(const struct file *file,
 	if (flags & O_APPEND)
 		acc_mode |= MAY_APPEND;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	with_ovl_creds(inode->i_sb) {
 		real_idmap = mnt_idmap(realpath->mnt);
-	err = inode_permission(real_idmap, realinode, MAY_OPEN | acc_mode);
+		err = inode_permission(real_idmap, realinode,
+				       MAY_OPEN | acc_mode);
 		if (err) {
 			realfile = ERR_PTR(err);
 		} else {
@@ -49,9 +49,10 @@ static struct file *ovl_open_realfile(const struct file *file,
 				flags &= ~O_NOATIME;
 
 			realfile = backing_file_open(file_user_path(file),
-					     flags, realpath, current_cred());
+						     flags, realpath,
+						     current_cred());
+		}
 	}
-	ovl_revert_creds(old_cred);
 
 	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
 		 file, file, ovl_whatisit(inode, realinode), file->f_flags,

-- 
2.47.3


