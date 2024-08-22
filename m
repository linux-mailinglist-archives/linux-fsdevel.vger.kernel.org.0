Return-Path: <linux-fsdevel+bounces-26651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4595AA6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368C11F236F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241AD183CB8;
	Thu, 22 Aug 2024 01:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gD6JLkuC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2A17DFF1;
	Thu, 22 Aug 2024 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289943; cv=none; b=Itf1AHqRFoBIfHIWad2Mpu2h3SBUTeZaHEpWniSpq7jSyIEL+Jxe/W1v4S/kp+A5bInj0C4ENnIOgW3HKVu+kMDBQz7aCdQ0ezHm6tcJEtrrlYBTkVq1hFZpdmuN9pJyYNlp9+wmnkSq/nTnpIZwQhIt3WfmCbRyWLCIoCdEUkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289943; c=relaxed/simple;
	bh=Ab06tqTimEBOVZ57yicpTqqHZTz/fm/bVSgF/YElcBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sl6K8JnkydSikT3xMFL+FW+labpMYfZZTcZ4VX6EgAdHuO9L9UaokVYt64DEHlBiJV7Oo7rO/WgPr3I6ATIUYR6iiWaDA4n8wfusHheAhBNK9/3Nm8u4sUlPbiL/88eypXfMIsMNmSrZk14r/4C0gjrzMk2p5MXlN8ydxxX4s8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gD6JLkuC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289942; x=1755825942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ab06tqTimEBOVZ57yicpTqqHZTz/fm/bVSgF/YElcBo=;
  b=gD6JLkuCLVxmPUTAzvxrdyFsNAktIyRj4r7JcgVP9px97Y2lNiEJpqdw
   YCw0gmCErXXS5e22z700m7lou5t8QyT7h3OFnplfZOPyWjg4SHFveJ2vL
   mg6uSJoN03c1yGWhsVu0SoX1bVksQh4gEiFRcW/Be1E8ecboq/pmCpfpc
   hCFyMYlYNGI6dkSXfOUtDFOXWcRFqpdm0GNr29oakw9d1q1B8HS9gMGUw
   4j/sgPt7sRsK6jxKrJ/s66vcN8VsrhW/a5bdr3mTqZNuxgukR0CBnl9J5
   ZE6MCmaF43fNkHPYiNSnNbgrwLzFSbaOAIq+S4atuf13xLnWsmx1uFchp
   w==;
X-CSE-ConnectionGUID: 4cSWJ+uPRHeZM+w5Ky52xg==
X-CSE-MsgGUID: sugbZ8IDTBeii84SS6r5TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574771"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574771"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:33 -0700
X-CSE-ConnectionGUID: VCiGVqUCSTCOATsjMoRokQ==
X-CSE-MsgGUID: UmESM1nbQEq1rqf37twETw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811057"
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
Subject: [PATCH v2 12/16] overlayfs/namei: Convert to cred_guard()
Date: Wed, 21 Aug 2024 18:25:19 -0700
Message-ID: <20240822012523.141846-13-vinicius.gomes@intel.com>
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

Only ovl_maybe_lookup_lowerdata() use cred_scoped_guard(), because of
'goto', which can cause the cleanup flow to run on garbage memory.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/namei.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index e52d6ae8eeb5..723731bc3678 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -953,15 +953,12 @@ static int ovl_maybe_validate_verity(struct dentry *dentry)
 		return err;
 
 	if (!ovl_test_flag(OVL_VERIFIED_DIGEST, inode)) {
-		const struct cred *old_cred;
-
-		old_cred = ovl_override_creds_light(dentry->d_sb);
+		cred_guard(ovl_creds(dentry->d_sb));
 
 		err = ovl_validate_verity(ofs, &metapath, &datapath);
 		if (err == 0)
 			ovl_set_flag(OVL_VERIFIED_DIGEST, inode);
 
-		revert_creds_light(old_cred);
 	}
 
 	ovl_inode_unlock(inode);
@@ -975,7 +972,6 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	struct inode *inode = d_inode(dentry);
 	const char *redirect = ovl_lowerdata_redirect(inode);
 	struct ovl_path datapath = {};
-	const struct cred *old_cred;
 	int err;
 
 	if (!redirect || ovl_dentry_lowerdata(dentry))
@@ -993,9 +989,8 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	if (ovl_dentry_lowerdata(dentry))
 		goto out;
 
-	old_cred = ovl_override_creds_light(dentry->d_sb);
-	err = ovl_lookup_data_layers(dentry, redirect, &datapath);
-	revert_creds_light(old_cred);
+	cred_scoped_guard(ovl_creds(dentry->d_sb))
+		err = ovl_lookup_data_layers(dentry, redirect, &datapath);
 	if (err)
 		goto out_err;
 
@@ -1030,7 +1025,6 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			  unsigned int flags)
 {
 	struct ovl_entry *oe = NULL;
-	const struct cred *old_cred;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
 	struct ovl_entry *roe = OVL_E(dentry->d_sb->s_root);
@@ -1061,7 +1055,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > ofs->namelen)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	old_cred = ovl_override_creds_light(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	upperdir = ovl_dentry_upper(dentry->d_parent);
 	if (upperdir) {
 		d.layer = &ofs->layers[0];
@@ -1342,7 +1336,6 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 
 	ovl_dentry_init_reval(dentry, upperdentry, OVL_I_E(inode));
 
-	revert_creds_light(old_cred);
 	if (origin_path) {
 		dput(origin_path->dentry);
 		kfree(origin_path);
@@ -1366,7 +1359,6 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	kfree(upperredirect);
 out:
 	kfree(d.redirect);
-	revert_creds_light(old_cred);
 	return ERR_PTR(err);
 }
 
@@ -1374,7 +1366,6 @@ bool ovl_lower_positive(struct dentry *dentry)
 {
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
 	const struct qstr *name = &dentry->d_name;
-	const struct cred *old_cred;
 	unsigned int i;
 	bool positive = false;
 	bool done = false;
@@ -1390,7 +1381,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 	if (!ovl_dentry_upper(dentry))
 		return true;
 
-	old_cred = ovl_override_creds_light(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	/* Positive upper -> have to look up lower to see whether it exists */
 	for (i = 0; !done && !positive && i < ovl_numlower(poe); i++) {
 		struct dentry *this;
@@ -1423,7 +1414,6 @@ bool ovl_lower_positive(struct dentry *dentry)
 			dput(this);
 		}
 	}
-	revert_creds_light(old_cred);
 
 	return positive;
 }
-- 
2.46.0


