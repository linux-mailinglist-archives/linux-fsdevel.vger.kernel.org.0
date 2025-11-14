Return-Path: <linux-fsdevel+bounces-68461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDB4C5C8D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AB444F8577
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8221A30FC11;
	Fri, 14 Nov 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj5W4P76"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC54530F934;
	Fri, 14 Nov 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115336; cv=none; b=M+3KnqAHE3MzlAvXvIlZhCPA3oxTqZORW33Owb4UiCJXvv8ocf/mnOXo6xsJRAgm4YO1+m4QEPjyXZzj9MXK+jV4iumVjYK6oyZOG2VanC+3jo/tTpR2h6dsbuUVh99m/jqme99pO7M/zveUILt6+QFh8yegNfG+ZsHoWsP4WE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115336; c=relaxed/simple;
	bh=61+Uu00ezvHNVc6nBngVZzZ/MKvnyS7XUlvm2HORWjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llJXpV26jNAiqJ+Bv8oXGt59h+HFNUyYuS/ge2hX4+bJmbV5wa5hOt+oE2emqngwAJud31dnOrXatAXD6GNsFnXT1LfH456le+M4Y8CVnw6lbKu4eKjh7movFqNDxGy0sRIVE62F/fQM8yoAItdZxCYca4jnn/MTpP0/MNg0LAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj5W4P76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A6DC113D0;
	Fri, 14 Nov 2025 10:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763115335;
	bh=61+Uu00ezvHNVc6nBngVZzZ/MKvnyS7XUlvm2HORWjA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yj5W4P76aQIhVMqedsnRnyOHAY7GgXlxIsAvLShk8PH7ZAr4EDpPMlnWvJMkwXv4a
	 Xn+XwEKDxjJ5D8iHyujKD9IcncJEki9kHHH5DAZSlwFvtrW3p+Ti3gD5Qvlu++ZyT4
	 tFIrAEXSs9+OGABl1Vby+fFusSvkm9NbdM7VNN3YJKLGw8A1Q1PlwMWaqTuE8tCfNV
	 F+AR3cq9kmJmGvFQXqTd6MQ2qNrf5tWZWlBl7KWMtcnsn3PG2Bg+MXoa0SRNe1/h1I
	 f9isOCZS/MY2QZnD+nxLGXG7YKtiEqbFm+oEGOdY9lDntrVOl0JrSxoQyxztLEtTkD
	 7gg4+6Qg2g0OA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 14 Nov 2025 11:15:17 +0100
Subject: [PATCH 2/6] ovl: port ovl_create_tmpfile() to new
 prepare_creds_ovl cleanup guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-work-ovl-cred-guard-prepare-v1-2-4fc1208afa3d@kernel.org>
References: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559; i=brauner@kernel.org;
 h=from:subject:message-id; bh=61+Uu00ezvHNVc6nBngVZzZ/MKvnyS7XUlvm2HORWjA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKMzry7hLK+Wa6z1Xz3wefDNnHF5b9UX6vN+HK5kviX
 CdXCDMWdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEOI3hf2opd6f5IYVb5XZa
 LJbmd+fvbNOQ8Ly8TcG3sONOhs5GXob/7jwvP3yYm/z39NMeYeP//j/Crgq8n+wnHOaiw2Ky5Jc
 7FwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This clearly indicates the double-credential override and makes the code
a lot easier to grasp with one glance.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 87f6c5ea6ce0..a276eafb5e78 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1372,7 +1372,6 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 			      struct inode *inode, umode_t mode)
 {
-	const struct cred *new_cred __free(put_cred) = NULL;
 	struct path realparentpath;
 	struct file *realfile;
 	struct ovl_file *of;
@@ -1381,10 +1380,10 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
 	int err;
 
-	scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
-		new_cred = ovl_setup_cred_for_create(dentry, inode, mode, old_cred);
-		if (IS_ERR(new_cred))
-			return PTR_ERR(new_cred);
+	with_ovl_creds(dentry->d_sb) {
+		scoped_class(prepare_creds_ovl, cred, dentry, inode, mode) {
+			if (IS_ERR(cred))
+				return PTR_ERR(cred);
 
 			ovl_path_upper(dentry->d_parent, &realparentpath);
 			realfile = backing_tmpfile_open(&file->f_path, flags,
@@ -1412,6 +1411,7 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 				ovl_file_free(of);
 			}
 		}
+	}
 	return err;
 }
 

-- 
2.47.3


