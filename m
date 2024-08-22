Return-Path: <linux-fsdevel+bounces-26653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D643695AA76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91B11C2181F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C65185928;
	Thu, 22 Aug 2024 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dt+2ACs0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC611802A8;
	Thu, 22 Aug 2024 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289945; cv=none; b=U9JoNr38Y9TrUzAD1LZCe2JK+fzQsE8WRVTuKGP3g+pAyWuNxVPyq7LR8/59M5S5g/BdUN/gieSEVRkKni7VZqCkG7TAV9rjjR7X8NGjB2RgiRridIj7RqroqA1C3Iurhr4o5UYPwtscJ7qARnUyAOB/+RmClJKrKxwt9I55Hrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289945; c=relaxed/simple;
	bh=+8wcLF29EUtosA8Xrm+wTC4UhwuwLsycHTXnhxSk+Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVdwMkXnl3j/Ql0E4AOPojh5/xMAxErkVGZ18g+g6E079VYiMduLkCTSr39ssu3WIyBR1DewW547E/dywX6sVk2le7ijFg7jBWmYHXGhkrtblIZIeowumO3+TqaBHn38rA2HMpS2pKv/yLJbYmo2/3/BtRgvLil0MXHoqxIiPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dt+2ACs0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289943; x=1755825943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+8wcLF29EUtosA8Xrm+wTC4UhwuwLsycHTXnhxSk+Yo=;
  b=Dt+2ACs0Pp+eT8BLwO7i1dkJtcLzEAyzdiiM2rM6iAkvHOAlGUk2gVZl
   t89ntBW/c8Bq9uX0IYX2ZQt1WTILTXdUG1UAjButH8QBb8yVetOGOpGyr
   VdCfNrNWRPxhfC+wA6azqrljbhOQb9FCfEdaGOieTPl3tcNhTzXxjtA47
   8MtXQj1QS4juPGaHpBw4AdlmG3yY16Fr1Q+wx+Cylm2c8ZsnChubGw5x8
   FjY5cnRFG4/tjHDqXEuXjaRTze/5qzjDyRVYnUZgEFiZsT9huCeeYyaKt
   EJ2Da7bIYp61p3d/tj94soS7n4FJPc+CHAKNE8bAJwxwcDPix/FqemKIO
   g==;
X-CSE-ConnectionGUID: /ptGFod/R3uOALnTRWEOuQ==
X-CSE-MsgGUID: CcgjDDOJQ8ShZ0578ddG6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574778"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574778"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:33 -0700
X-CSE-ConnectionGUID: 4I8bHqtLTEurDToKHnpYCQ==
X-CSE-MsgGUID: wZ3sLpasR+yah/MW453/kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811064"
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
Subject: [PATCH v2 14/16] overlayfs/xattrs: Convert to cred_guard()
Date: Wed, 21 Aug 2024 18:25:21 -0700
Message-ID: <20240822012523.141846-15-vinicius.gomes@intel.com>
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

In ovl_xattr_set() use cred_scoped_guard(), because of 'goto', which
can cause the cleanup flow to run on garbage memory.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/xattrs.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 0d315d0dd89e..c7eb3d06a9b8 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -41,15 +41,14 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 	struct dentry *upperdentry = ovl_i_dentry_upper(inode);
 	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
 	struct path realpath;
-	const struct cred *old_cred;
 
 	if (!value && !upperdentry) {
 		ovl_path_lower(dentry, &realpath);
-		old_cred = ovl_override_creds_light(dentry->d_sb);
-		err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
-		revert_creds_light(old_cred);
+		cred_scoped_guard(ovl_creds(dentry->d_sb))
+			err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
 		if (err < 0)
 			goto out;
+
 	}
 
 	if (!upperdentry) {
@@ -64,15 +63,15 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds_light(dentry->d_sb);
-	if (value) {
-		err = ovl_do_setxattr(ofs, realdentry, name, value, size,
-				      flags);
-	} else {
-		WARN_ON(flags != XATTR_REPLACE);
-		err = ovl_do_removexattr(ofs, realdentry, name);
+	cred_scoped_guard(ovl_creds(dentry->d_sb)) {
+		if (value) {
+			err = ovl_do_setxattr(ofs, realdentry, name, value, size,
+					      flags);
+		} else {
+			WARN_ON(flags != XATTR_REPLACE);
+			err = ovl_do_removexattr(ofs, realdentry, name);
+		}
 	}
-	revert_creds_light(old_cred);
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */
@@ -85,13 +84,11 @@ static int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char
 			 void *value, size_t size)
 {
 	ssize_t res;
-	const struct cred *old_cred;
 	struct path realpath;
 
 	ovl_i_path_real(inode, &realpath);
-	old_cred = ovl_override_creds_light(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	res = vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
-	revert_creds_light(old_cred);
 	return res;
 }
 
@@ -116,12 +113,10 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 	ssize_t res;
 	size_t len;
 	char *s;
-	const struct cred *old_cred;
 	size_t prefix_len, name_len;
 
-	old_cred = ovl_override_creds_light(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	res = vfs_listxattr(realdentry, list, size);
-	revert_creds_light(old_cred);
 	if (res <= 0 || size == 0)
 		return res;
 
-- 
2.46.0


