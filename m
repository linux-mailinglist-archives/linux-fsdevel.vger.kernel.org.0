Return-Path: <linux-fsdevel+bounces-68688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A131C63379
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 33FF728BA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D3932ED2D;
	Mon, 17 Nov 2025 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2z0QoHl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40225329E75;
	Mon, 17 Nov 2025 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372107; cv=none; b=HPHxjugp1mPa1VbLtIQgaXlOKMNbNRatDmjnjXmGnddJalPsq47J9hu1uYnoX4EqPk/aehmLeNFIZ7wrf2MC38hsb2OgsWL3vuPSGjXB14fROgQs5SAZ7a4QNuMqvO3AC4DgVjPLJ4fHi6m+LyqcrOCwsnE7GXT5Fb+LQUHM9LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372107; c=relaxed/simple;
	bh=J6w/6vWKTt4/yHJ7tivoydrShyLaMnV5hWdOwD5i++w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HNSdpgVJ0Mk12HkiNYEGByhttqU7alHn2d9SvskPd5zCzwZqWoZmJDjaDdlJe4Ec/cRrW/IObu9dIdjO1paLSqHbVAG68U3/1hL64TdndDHHDni4stErEGFoJTYzaejUFVSM1HRODpuOlIDnx8OzANir5s0PbAQRJb4L3RfLGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2z0QoHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAED4C4CEF1;
	Mon, 17 Nov 2025 09:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372107;
	bh=J6w/6vWKTt4/yHJ7tivoydrShyLaMnV5hWdOwD5i++w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q2z0QoHldc6ddd2XDyn641GWkMcspJPr6F04E38ggE09Wx+1iA1+//neJB5NpyfIG
	 6z4f8EJjuOF6TkoU91QJM+D49oqbQMmvEURQ6l6oyu9gZiKreZdlHby/5ip8/8OkH5
	 g+wRuuUWazYFm0IxT0wqwfKHNH09kLwnliX6CfiX9C9MQMWJ5G8AFHWdIHwPXONSrF
	 HYWw3zh5v/BGmVIY17p1YO9axA7JZseAUDFfjtueKNWPWjbdFgxb/3nyEBh+7WQ//v
	 06yFyuKT0ghlYhnVfb0uz4v568Oi+b2yXhV1AOl9jsa0Sbr80QoWB3f+2ak2qOziAn
	 xs3c8WbnRBN4A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:39 +0100
Subject: [PATCH v2 2/6] ovl: port ovl_create_tmpfile() to new
 ovl_override_creator_creds cleanup guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-prepare-v2-2-bd1c97a36d7b@kernel.org>
References: <20251117-work-ovl-cred-guard-prepare-v2-0-bd1c97a36d7b@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-prepare-v2-0-bd1c97a36d7b@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=brauner@kernel.org;
 h=from:subject:message-id; bh=J6w/6vWKTt4/yHJ7tivoydrShyLaMnV5hWdOwD5i++w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvXHdfOr76uVy19xj++965C3hE2+p7zh59Raz3tOON
 XHvw9x+d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkRykjw40l4U4qx+Q3tD2o
 /GnecJld7cfne+4PZHLKZ22UZdnHtpGRod90rfS5og6nizfMJtUWeqrutj8aecbCL4dR1Nqr4zw
 vEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This clearly indicates the double-credential override and makes the code
a lot easier to grasp with one glance.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 3eb0bb0b8f3b..dad818de4386 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1387,7 +1387,6 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 			      struct inode *inode, umode_t mode)
 {
-	const struct cred *new_cred __free(put_cred) = NULL;
 	struct path realparentpath;
 	struct file *realfile;
 	struct ovl_file *of;
@@ -1396,10 +1395,10 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
 	int err;
 
-	scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
-		new_cred = ovl_setup_cred_for_create(dentry, inode, mode, old_cred);
-		if (IS_ERR(new_cred))
-			return PTR_ERR(new_cred);
+	with_ovl_creds(dentry->d_sb) {
+		scoped_class(ovl_override_creator_creds, cred, dentry, inode, mode) {
+			if (IS_ERR(cred))
+				return PTR_ERR(cred);
 
 			ovl_path_upper(dentry->d_parent, &realparentpath);
 			realfile = backing_tmpfile_open(&file->f_path, flags, &realparentpath,
@@ -1425,6 +1424,7 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 				ovl_file_free(of);
 			}
 		}
+	}
 	return err;
 }
 

-- 
2.47.3


