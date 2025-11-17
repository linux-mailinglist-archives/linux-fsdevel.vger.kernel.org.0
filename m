Return-Path: <linux-fsdevel+bounces-68650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CF2C6340C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D17F358715
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EC232721B;
	Mon, 17 Nov 2025 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzPvqO/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D306C328B4C;
	Mon, 17 Nov 2025 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372037; cv=none; b=sVOWVl3vFCi9eoXrYcAkzg47FHe2H3WhY35WI2B7oGQJDwQIudMMxduvRzVWhVrOidEzRloE4N4CEzibcWZD4bMZqbcxNHgoJVkWSzYR3UviWKtB/YFfliMmdaeNwG6r9Lwz2rupHHrtcgVx6PFfHPrgE+ZwfpW/l1fpVmAURrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372037; c=relaxed/simple;
	bh=D3NzlfmrifsUTN0buNefyT8fRFt9vtpnzxT1KyeP750=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qvuhfjxxmX8bjiIF8n1oVg4gG9t9OHQb78/u3axu1LSOqAfJw3ZBpJFcMVqlHppA1hs7WX0DdP5c60nDqv/CwkQwZ825ODLS+dH5V4C/QYRVKNP5mgSzEyVij6p5I4mlVVbiafr72RdFCSULoi5Ss69dp7+Ed+VNQm0z2HzAkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzPvqO/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF4CC4CEF5;
	Mon, 17 Nov 2025 09:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372037;
	bh=D3NzlfmrifsUTN0buNefyT8fRFt9vtpnzxT1KyeP750=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QzPvqO/PBRGQD+IKev1q8P4BV72PxndNamrt91olm3MmX5pHfw1s9crLI14fvgwMw
	 s/inbcW4guxnDIFIPHoua/iDSioDofsIa1b1eO0h8hfcWTREszQne6IDzFRkKcd3rx
	 yJ2xOiPqfJd5zMuO1SYk/j+hqKv6B4jWqtJqcAHaPSMwolRLugIyiopLaZtWV8USgU
	 TFzp7kff3dora0l5sry0uvyPa6hkGSDnGrrb0csmXJ1VZqUH2rc/mMjs2rJcFIJayI
	 udURQZtuXVfvfu6tnxIWHhA1QgO4VzQH2nUgyDtYLsYQEJvLMWay6CjARnB/si64zX
	 Y400THjqVBsuw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:38 +0100
Subject: [PATCH v4 07/42] ovl: port ovl_open_realfile() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-7-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=brauner@kernel.org;
 h=from:subject:message-id; bh=D3NzlfmrifsUTN0buNefyT8fRFt9vtpnzxT1KyeP750=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf6icWXdwrQJMiJ/1rYIPWCZVXp7vgf3vn1/33OJa
 N/8kj+RsaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi76QZ/lku2Cy4tnhTwz6W
 K+dZhLecqbLaY6e3uu/GXDHRr4KimZcZGeZNTl4ZduVQPb/3r+vdxbpMV61CNdnZ15jMucv0nPn
 5Tw4A
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


