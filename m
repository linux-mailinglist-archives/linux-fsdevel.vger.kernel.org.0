Return-Path: <linux-fsdevel+bounces-54558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B03B00F73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA601CA3391
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3A52C15B5;
	Thu, 10 Jul 2025 23:21:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3229E113;
	Thu, 10 Jul 2025 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189690; cv=none; b=BGb7jEpPGWufk5Nnoi8UPJ+uVghPjNPOtZ0/D/++ro385oEORDrmq2B05+o38xWwarldkS1PaRido/DneqD8klWVt1PmAy0hzVob7lIx4y16jFs4V6L4G9VFTsdGdeORtxTHQEfKF13lxPaDKjgB8tZz2r6QG6R1Ls9uX21iYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189690; c=relaxed/simple;
	bh=7bvyDLLXFTlnp7oGHpOX5dgaJIb2Cx5LEyolDfr0x2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nemz22e/fUakLVRNhp/NI2lUpM/Hfd8iSJK9x0JUqxQAJBM5XgeQT5cxqUoB410Kmmj7vB+OKk79Ybn+mbPTWjHpbHjw6SIQeiOGPSSxnjmqkb6VkQ8R5cU4i00ifPaZwFlaeBNJau5vREqxm5HixuPfAkJiALV9zuEniF0lwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zr-001XG4-Jb;
	Thu, 10 Jul 2025 23:21:21 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/20] ovl: narrow locking in ovl_create_upper()
Date: Fri, 11 Jul 2025 09:03:35 +1000
Message-ID: <20250710232109.3014537-6-neil@brown.name>
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

Drop the directory lock immediately after the ovl_create_real() call and
take a separate lock later for cleanup in ovl_cleanup_unlocked() - if
needed.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 144e1753d0c9..fa438e13e8b1 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -326,9 +326,9 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 				    ovl_lookup_upper(ofs, dentry->d_name.name,
 						     upperdir, dentry->d_name.len),
 				    attr);
-	err = PTR_ERR(newdentry);
+	inode_unlock(udir);
 	if (IS_ERR(newdentry))
-		goto out_unlock;
+		return PTR_ERR(newdentry);
 
 	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
 	    !ovl_allow_offline_changes(ofs)) {
@@ -340,14 +340,12 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink, NULL);
 	if (err)
 		goto out_cleanup;
-out_unlock:
-	inode_unlock(udir);
-	return err;
+	return 0;
 
 out_cleanup:
-	ovl_cleanup(ofs, udir, newdentry);
+	ovl_cleanup_unlocked(ofs, upperdir, newdentry);
 	dput(newdentry);
-	goto out_unlock;
+	return err;
 }
 
 static struct dentry *ovl_clear_empty(struct dentry *dentry,
-- 
2.49.0


