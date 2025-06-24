Return-Path: <linux-fsdevel+bounces-52820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E14AE72D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908D81733A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F225C702;
	Tue, 24 Jun 2025 23:07:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77282561A8;
	Tue, 24 Jun 2025 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806438; cv=none; b=N1iI4eQRqrR99ew8u3MHOKKNGEpQ3u39BPMih+JXiox18kN7vjogoyya5i0QXo5RKnGeV/o5gAPjJLT7m3qITnMOZ/VR4BjUA36yYYgjifROprtt7aMe0+ln32k83wfl98cNRijv/qRRxjJUJaAOz+VUaeDSEYbF8xUSl3imCiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806438; c=relaxed/simple;
	bh=xZxm7kEzCXcZ/3AhHwpQgwTHbv8MrcEYnqlfskCEswc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggwPF0vdb1d2QzCvezDtOJESpCmtpObLVcNg5ptatZ3p5jPvIiiY2HFTsw25xouHSTei7YDroZdGOotewaEgxU2wxR1/EWzclxY+KBLHH2v0qrWF20Clh+0PnH6xAOowMTR65lwYpQwr0YF3B1tVVkSTu3YUGOWoGgebmN1pLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUCjS-0045cE-AD;
	Tue, 24 Jun 2025 23:07:14 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/12] ovl: narrow locking in ovl_create_upper()
Date: Wed, 25 Jun 2025 08:55:00 +1000
Message-ID: <20250624230636.3233059-5-neil@brown.name>
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

Drop the directory lock immediately after the ovl_create_real() call and
take a separate lock later for cleanup in ovl_cleanup_unlocked() - if
needed.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index a51a3dc02bf5..2d67704d641e 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -326,9 +326,10 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 				    ovl_lookup_upper(ofs, dentry->d_name.name,
 						     upperdir, dentry->d_name.len),
 				    attr);
+	inode_unlock(udir);
 	err = PTR_ERR(newdentry);
 	if (IS_ERR(newdentry))
-		goto out_unlock;
+		goto out;
 
 	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
 	    !ovl_allow_offline_changes(ofs)) {
@@ -340,14 +341,13 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink, NULL);
 	if (err)
 		goto out_cleanup;
-out_unlock:
-	inode_unlock(udir);
+out:
 	return err;
 
 out_cleanup:
-	ovl_cleanup(ofs, udir, newdentry);
+	ovl_cleanup_unlocked(ofs, upperdir, newdentry);
 	dput(newdentry);
-	goto out_unlock;
+	goto out;
 }
 
 static struct dentry *ovl_clear_empty(struct dentry *dentry,
-- 
2.49.0


