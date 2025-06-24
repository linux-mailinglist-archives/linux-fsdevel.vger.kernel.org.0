Return-Path: <linux-fsdevel+bounces-52823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF83EAE72D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD01F3BC243
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A377425C829;
	Tue, 24 Jun 2025 23:07:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B7A25B1F7;
	Tue, 24 Jun 2025 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806439; cv=none; b=XjR4Mm7lCYJRiweDRDaq56sjO/pJ4JU11UzjGu07C+ghAX0HtExJpg8SYVoOhkObJaJsokZf3pr85LAyWl313c6QQCpLFcnQGZ4pwcEHhQI6LWkjjoJ2k6728TfYD20QcbPXElu5UCxw06P0rywGuFSj/QDMs39aXkRIF5MuZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806439; c=relaxed/simple;
	bh=MBOt2kqTLoDzO8acjWJ25NrnLq6XL3p6e9altq58VXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hy23zdDrlnBNfZlGMJncwywciynKJBlGyGnKFLv5WjsNgwsgjd4wSXvf7zMdkBmAh6q0Q+xUAwpWkvHZCk7pf6PAhSq78sjHRNeGEtbfc3WZ5kksy3M2TTcZrp/b+xFuveNrrAEw50Ph13A5Zv3D+QWK9QGdnN3sh5ZHwYUZ5Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUCjT-0045cU-A6;
	Tue, 24 Jun 2025 23:07:15 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/12] ovl: narrow locking in ovl_create_over_whiteout()
Date: Wed, 25 Jun 2025 08:55:02 +1000
Message-ID: <20250624230636.3233059-7-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624230636.3233059-1-neil@brown.name>
References: <20250624230636.3233059-1-neil@brown.name>
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
index e3ea7d02219f..2b879d7c386e 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -440,9 +440,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
-	struct inode *wdir = workdir->d_inode;
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
-	struct inode *udir = upperdir->d_inode;
 	struct dentry *upper;
 	struct dentry *newdentry;
 	int err;
@@ -513,22 +511,23 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 
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


