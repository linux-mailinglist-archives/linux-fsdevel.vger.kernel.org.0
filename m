Return-Path: <linux-fsdevel+bounces-54564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953CAB00F7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF225615C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043CF29B8E2;
	Thu, 10 Jul 2025 23:21:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9796B2BE7D9;
	Thu, 10 Jul 2025 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189691; cv=none; b=oXlOoP795JPXKt3GO5QVt1bRA/ip2ncCdHOb+PO16VVe/pbg8uRthH8q41G6szYR/HhKsiXwIqA1TJBd44qSjkaWcamaZGjHjvYkSqrRLG59nPRgOAOI+yhl6GQ7kGWfNXzqhozz6Uvni2N20HOIGAJR0U/u69J73AhOb3cUyTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189691; c=relaxed/simple;
	bh=oZ01mGfos05Hy1BNyqVAWqo5K0Vf6jrum0zPxdXRrFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqCtmSA+dBxEtTkwL6GKqjCqlNkdv37NIcOifOfwr/uqW90mX0jGrt8YyC2+npZF4CfTdFwK2bK1HYr8SmUtPnxRzwvYPi9LsgSHxiBwZlMbIAwVc4FJTKFM4GvU+Ra4fkkige51eotwa6/HcVbwUUY9w250LQyWSQ2JIT470mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zs-001XG8-1B;
	Thu, 10 Jul 2025 23:21:21 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/20] ovl: narrow locking in ovl_clear_empty()
Date: Fri, 11 Jul 2025 09:03:36 +1000
Message-ID: <20250710232109.3014537-7-neil@brown.name>
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

Drop the locks immediately after rename, and use a separate lock for
cleanup.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Note that ovl_cleanup_whiteouts() operates on "upper", a child of
"upperdir" and does not require upperdir or workdir to be locked.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index fa438e13e8b1..b3d858654f23 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -353,7 +353,6 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
-	struct inode *wdir = workdir->d_inode;
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
 	struct path upperpath;
 	struct dentry *upper;
@@ -400,10 +399,10 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	err = ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, RENAME_EXCHANGE);
 	if (err)
 		goto out_cleanup;
+	unlock_rename(workdir, upperdir);
 
 	ovl_cleanup_whiteouts(ofs, upper, list);
-	ovl_cleanup(ofs, wdir, upper);
-	unlock_rename(workdir, upperdir);
+	ovl_cleanup_unlocked(ofs, workdir, upper);
 
 	/* dentry's upper doesn't match now, get rid of it */
 	d_drop(dentry);
-- 
2.49.0


