Return-Path: <linux-fsdevel+bounces-26650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACBE95AA6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E99E1F238C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EB2183CA1;
	Thu, 22 Aug 2024 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XcqDfrUs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBAA17D340;
	Thu, 22 Aug 2024 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289943; cv=none; b=n1eiJpDbHQR0YMgKYeLAO4WiuMq73TTboOnCVrC0zIeMbEAUFUNQ+2soWedQe97qjU/z+e6EDrV6UlhivYLoErSWmAq2l15kYwg4QkyVHlvVPoQlvaj3b+Rzbq29wmImpk8Fq+XvnUFn3v3z3lhGjKLIx0EHObu0OxS8yGECs+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289943; c=relaxed/simple;
	bh=DxnumIkvaje9VmBTsox3H2YKIrYVSNnSFqODz9w2OAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIiDPGRYhVFW6UYmZRRAV4vetqpxq69z4MpzgumkdYAg+eCEOTMGnyxrBZ9hyCr3kRIRVbD0UYWOx+Dgzab8N2fWUZoZOJH1t2p6k64GElszwkhpPV/kRMVQEpPFNeRpWko4MY5EZO+nVXlAd/svNH5Civ77BrLT0kHg1mihPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XcqDfrUs; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289941; x=1755825941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DxnumIkvaje9VmBTsox3H2YKIrYVSNnSFqODz9w2OAs=;
  b=XcqDfrUsEeI6GyV1JMNhmJMamLCJro3gvBE+BhYwyUQPxGw2kCX9oyJp
   JqA2UJ9OqveHs41sPiKJGL/GI9c+2My2rOlkiAqmI3ZS2b39JdwKlFThJ
   +Anm/+ybvqctUAkZIUVawvFTfwaQr8RUk5gv0aLCVG5m85fgTeMZ2CFgf
   sfjiBD1kmxazGv3jUuagfgB1KdsZ8dAhx+WqO7Ii59n9KwKBcVyAHGtTX
   4gvFAiL1ESrwAasoO5EgFhuZBDpLjB/UIM08AoxiZvJA6USWF20ld9LZ/
   3ez99vhmFv0iu74PLjxfVphQWkDzKbKURFw8OhJREIOdyfY2epgVAcPVR
   Q==;
X-CSE-ConnectionGUID: HCPjzp3QTPGfXgJL8CJV9A==
X-CSE-MsgGUID: nWRZvazUSmyNLsouMQ/tow==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574767"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574767"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:33 -0700
X-CSE-ConnectionGUID: dpQvcYHoRNmv9ygfnKAFCA==
X-CSE-MsgGUID: HcjwI+7pRl2HkzXE8OdlgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811054"
Received: from unknown (HELO vcostago-mobl3.jf.intel.com) ([10.241.225.92])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:32 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v2 11/16] overlayfs/inode: Convert to cred_guard()
Date: Wed, 21 Aug 2024 18:25:18 -0700
Message-ID: <20240822012523.141846-12-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822012523.141846-1-vinicius.gomes@intel.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the override_creds_light()/revert_creds_light() pairs of
operations with cred_guard()/cred_scoped_guard().

In ovl_setattr(), ovl_set_or_remove_acl() and ovl_fileattr_set() use
cred_scoped_guard(), because of 'goto', which can cause the cleanup
flow to run on garbage memory.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/inode.c | 73 +++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 45 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 30460d718605..a597e748397f 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -25,7 +25,6 @@ int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	bool full_copy_up = false;
 	struct dentry *upperdentry;
-	const struct cred *old_cred;
 
 	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (err)
@@ -78,9 +77,8 @@ int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			goto out_put_write;
 
 		inode_lock(upperdentry->d_inode);
-		old_cred = ovl_override_creds_light(dentry->d_sb);
-		err = ovl_do_notify_change(ofs, upperdentry, attr);
-		revert_creds_light(old_cred);
+		cred_scoped_guard(ovl_creds(dentry->d_sb))
+			err = ovl_do_notify_change(ofs, upperdentry, attr);
 		if (!err)
 			ovl_copyattr(dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);
@@ -159,7 +157,6 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 	struct dentry *dentry = path->dentry;
 	enum ovl_path_type type;
 	struct path realpath;
-	const struct cred *old_cred;
 	struct inode *inode = d_inode(dentry);
 	bool is_dir = S_ISDIR(inode->i_mode);
 	int fsid = 0;
@@ -169,7 +166,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 	metacopy_blocks = ovl_is_metacopy_dentry(dentry);
 
 	type = ovl_path_real(dentry, &realpath);
-	old_cred = ovl_override_creds_light(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	err = ovl_do_getattr(&realpath, stat, request_mask, flags);
 	if (err)
 		goto out;
@@ -280,7 +277,6 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->nlink = dentry->d_inode->i_nlink;
 
 out:
-	revert_creds_light(old_cred);
 
 	return err;
 }
@@ -291,7 +287,6 @@ int ovl_permission(struct mnt_idmap *idmap,
 	struct inode *upperinode = ovl_inode_upper(inode);
 	struct inode *realinode;
 	struct path realpath;
-	const struct cred *old_cred;
 	int err;
 
 	/* Careful in RCU walk mode */
@@ -309,7 +304,7 @@ int ovl_permission(struct mnt_idmap *idmap,
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds_light(inode->i_sb);
+	cred_guard(ovl_creds(inode->i_sb));
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {
 		mask &= ~(MAY_WRITE | MAY_APPEND);
@@ -317,7 +312,6 @@ int ovl_permission(struct mnt_idmap *idmap,
 		mask |= MAY_READ;
 	}
 	err = inode_permission(mnt_idmap(realpath.mnt), realinode, mask);
-	revert_creds_light(old_cred);
 
 	return err;
 }
@@ -326,15 +320,13 @@ static const char *ovl_get_link(struct dentry *dentry,
 				struct inode *inode,
 				struct delayed_call *done)
 {
-	const struct cred *old_cred;
 	const char *p;
 
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
-	old_cred = ovl_override_creds_light(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	revert_creds_light(old_cred);
 	return p;
 }
 
@@ -465,11 +457,9 @@ struct posix_acl *do_ovl_get_acl(struct mnt_idmap *idmap,
 
 		acl = get_cached_acl_rcu(realinode, type);
 	} else {
-		const struct cred *old_cred;
 
-		old_cred = ovl_override_creds_light(inode->i_sb);
+		cred_guard(ovl_creds(inode->i_sb));
 		acl = ovl_get_acl_path(&realpath, posix_acl_xattr_name(type), noperm);
-		revert_creds_light(old_cred);
 	}
 
 	return acl;
@@ -481,7 +471,6 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 	int err;
 	struct path realpath;
 	const char *acl_name;
-	const struct cred *old_cred;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *upperdentry = ovl_dentry_upper(dentry);
 	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
@@ -495,10 +484,9 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 		struct posix_acl *real_acl;
 
 		ovl_path_lower(dentry, &realpath);
-		old_cred = ovl_override_creds_light(dentry->d_sb);
+		cred_guard(ovl_creds(dentry->d_sb));
 		real_acl = vfs_get_acl(mnt_idmap(realpath.mnt), realdentry,
 				       acl_name);
-		revert_creds_light(old_cred);
 		if (IS_ERR(real_acl)) {
 			err = PTR_ERR(real_acl);
 			goto out;
@@ -518,12 +506,12 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds_light(dentry->d_sb);
-	if (acl)
-		err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
-	else
-		err = ovl_do_remove_acl(ofs, realdentry, acl_name);
-	revert_creds_light(old_cred);
+	cred_scoped_guard(ovl_creds(dentry->d_sb)) {
+		if (acl)
+			err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
+		else
+			err = ovl_do_remove_acl(ofs, realdentry, acl_name);
+	}
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */
@@ -590,7 +578,6 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 {
 	int err;
 	struct inode *realinode = ovl_inode_realdata(inode);
-	const struct cred *old_cred;
 
 	if (!realinode)
 		return -EIO;
@@ -598,9 +585,8 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!realinode->i_op->fiemap)
 		return -EOPNOTSUPP;
 
-	old_cred = ovl_override_creds_light(inode->i_sb);
+	cred_guard(ovl_creds(inode->i_sb));
 	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
-	revert_creds_light(old_cred);
 
 	return err;
 }
@@ -648,7 +634,6 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(dentry);
 	struct path upperpath;
-	const struct cred *old_cred;
 	unsigned int flags;
 	int err;
 
@@ -660,19 +645,19 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		if (err)
 			goto out;
 
-		old_cred = ovl_override_creds_light(inode->i_sb);
-		/*
-		 * Store immutable/append-only flags in xattr and clear them
-		 * in upper fileattr (in case they were set by older kernel)
-		 * so children of "ovl-immutable" directories lower aliases of
-		 * "ovl-immutable" hardlinks could be copied up.
-		 * Clear xattr when flags are cleared.
-		 */
-		err = ovl_set_protattr(inode, upperpath.dentry, fa);
-		if (!err)
-			err = ovl_real_fileattr_set(&upperpath, fa);
-		revert_creds_light(old_cred);
-		ovl_drop_write(dentry);
+		cred_scoped_guard(ovl_creds(inode->i_sb)) {
+			/*
+			 * Store immutable/append-only flags in xattr and clear them
+			 * in upper fileattr (in case they were set by older kernel)
+			 * so children of "ovl-immutable" directories lower aliases of
+			 * "ovl-immutable" hardlinks could be copied up.
+			 * Clear xattr when flags are cleared.
+			 */
+			err = ovl_set_protattr(inode, upperpath.dentry, fa);
+			if (!err)
+				err = ovl_real_fileattr_set(&upperpath, fa);
+			ovl_drop_write(dentry);
+		}
 
 		/*
 		 * Merge real inode flags with inode flags read from
@@ -725,15 +710,13 @@ int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct path realpath;
-	const struct cred *old_cred;
 	int err;
 
 	ovl_path_real(dentry, &realpath);
 
-	old_cred = ovl_override_creds_light(inode->i_sb);
+	cred_guard(ovl_creds(inode->i_sb));
 	err = ovl_real_fileattr_get(&realpath, fa);
 	ovl_fileattr_prot_flags(inode, fa);
-	revert_creds_light(old_cred);
 
 	return err;
 }
-- 
2.46.0


