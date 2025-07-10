Return-Path: <linux-fsdevel+bounces-54569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B772B00F88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01F61CA3778
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93E52D3731;
	Thu, 10 Jul 2025 23:21:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F82BE65E;
	Thu, 10 Jul 2025 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189692; cv=none; b=GfgZvmus6cUWK5ZFH++fhjnw1cmpOSeObyeIJiTpRDAhsZy3v3jGisvgHWEq9C1p6lfTqea2eaT99LOIvRrClfl0HZ+p+Q7SUOnwyXWj+CMXe9Nng4M6flZh2ynqPoipP05UcRwqui9gZCW48V03asts90oX2Grl1vEyH8SE+jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189692; c=relaxed/simple;
	bh=xv6oPJvMI0ZCv4fMmQgp3nYQhxoi0Mu5Fllb8dVB0js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SA2oCslbp1eyCbBhpjRfcO4qqpLrRUPbVGdEwIXfntt/PwWmRrJgMdxYhvyJa/MNUcJu/83Pr/ciqwjDCtvN9Z+n3obsXElexPek4xK1psLGPtpNysL7tt/1kygNicIwlsMHF5VwPzqYGOiF1zvGn4Nm9GQYGeZ6jzKSVIQJNmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zs-001XGC-FX;
	Thu, 10 Jul 2025 23:21:22 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/20] ovl: narrow locking in ovl_create_over_whiteout()
Date: Fri, 11 Jul 2025 09:03:37 +1000
Message-ID: <20250710232109.3014537-8-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710232109.3014537-1-neil@brown.name>
References: <20250710232109.3014537-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlock the parents immediately after the rename, and use
ovl_cleanup_unlocked() for cleanup, which takes a separate lock.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index b3d858654f23..687d5e12289c 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -432,9 +432,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
-	struct inode *wdir = workdir->d_inode;
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
-	struct inode *udir = upperdir->d_inode;
 	struct dentry *upper;
 	struct dentry *newdentry;
 	int err;
@@ -505,22 +503,23 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 
 		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper,
 				    RENAME_EXCHANGE);
+		unlock_rename(workdir, upperdir);
 		if (err)
-			goto out_cleanup_locked;
+			goto out_cleanup;
 
-		ovl_cleanup(ofs, wdir, upper);
+		ovl_cleanup_unlocked(ofs, workdir, upper);
 	} else {
 		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper, 0);
+		unlock_rename(workdir, upperdir);
 		if (err)
-			goto out_cleanup_locked;
+			goto out_cleanup;
 	}
 	ovl_dir_modified(dentry->d_parent, false);
 	err = ovl_instantiate(dentry, inode, newdentry, hardlink, NULL);
 	if (err) {
-		ovl_cleanup(ofs, udir, newdentry);
+		ovl_cleanup_unlocked(ofs, upperdir, newdentry);
 		dput(newdentry);
 	}
-	unlock_rename(workdir, upperdir);
 out_dput:
 	dput(upper);
 out:
-- 
2.49.0


