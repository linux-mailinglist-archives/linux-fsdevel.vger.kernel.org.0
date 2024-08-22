Return-Path: <linux-fsdevel+bounces-26654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3261A95AA77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA753281E75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3556718592F;
	Thu, 22 Aug 2024 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qpjk4eo1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E285183061;
	Thu, 22 Aug 2024 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289945; cv=none; b=AFIQm8onkg678rQK60IpjzsNfhsSHGSYsRcyG32G4v0K9b9LrcP7U03G5/XaT7rcm1hT/yaRHCy73R7fs967E4lAX4TuseeT+2QW6HLL3v3UQMshfHu/YEMkqWyiREzQNhdbYP5be5RW8AHx6diXTxTLv9UgQgovRu3IvQAiZ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289945; c=relaxed/simple;
	bh=jqDSnKF4M3GugtJniE15+Oim9lTUFyfIyrgNv8X+mMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIEuRn2bp6OEHvBrQYYvYPNq4XJBWGLOzUwqJJhKr5oJ8jHtzDqYYDeaE8nvSF6s6vgDMfurJCPSSOcgOflWN/KISEDuuViqg0OXCk5G8QLPKBoonvbYEuEzZk/oGMvv4VTdyj4oxhhsUhJ+xNTLn7umc8iTyC/YC9sY8KDclWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qpjk4eo1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289944; x=1755825944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jqDSnKF4M3GugtJniE15+Oim9lTUFyfIyrgNv8X+mMQ=;
  b=Qpjk4eo1Tz0zlVhg2GN2jtyvXCUot8omHdmECoGqdlNSYdyYWKS/e5lv
   9Q16mzHvA1PcOeeTStyLozo6it/Kfyvoog4KP8SzSFr5k9s19zjbCMURh
   bmKjmbvhKjFpH1Tuek/Yfn9XxSQee9fKf3kPrG5Tp17UWoEFNQgYp/oBE
   rB5JJDHjD87E4jYxofp4M7NUgBrw/YCgY1zBLl4dGgx0s0JlTf2j+J0xe
   +etuSlKH/bMcS599ObyC5lpg/YbLY2E8gZqDFcj92Ecz5ePk6+Kkafhei
   ZTOyle1Vbm3wSkpefFUGTmijyCPwH3KEPPG4WbBI+mYzOdkb7009AHhou
   A==;
X-CSE-ConnectionGUID: l940r3kRRruc2tpU13w3Pg==
X-CSE-MsgGUID: tpcw42MhRQWGA18ooywHGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574781"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574781"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:33 -0700
X-CSE-ConnectionGUID: Qw1SseeDRVibf2T1q0h3Hw==
X-CSE-MsgGUID: g9aB30pVQxWOM6qE4TP+qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811067"
Received: from unknown (HELO vcostago-mobl3.jf.intel.com) ([10.241.225.92])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:33 -0700
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
Subject: [PATCH v2 15/16] overlayfs/util: Convert to cred_guard()
Date: Wed, 21 Aug 2024 18:25:22 -0700
Message-ID: <20240822012523.141846-16-vinicius.gomes@intel.com>
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

In ovl_nlink_start() use cred_scoped_guard(), because of
'goto', which can cause the cleanup flow to run on garbage memory.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/util.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 80caeb81c727..77b8d01829a4 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1140,7 +1140,6 @@ static void ovl_cleanup_index(struct dentry *dentry)
 int ovl_nlink_start(struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-	const struct cred *old_cred;
 	int err;
 
 	if (WARN_ON(!inode))
@@ -1177,15 +1176,15 @@ int ovl_nlink_start(struct dentry *dentry)
 	if (d_is_dir(dentry) || !ovl_test_flag(OVL_INDEX, inode))
 		return 0;
 
-	old_cred = ovl_override_creds_light(dentry->d_sb);
-	/*
-	 * The overlay inode nlink should be incremented/decremented IFF the
-	 * upper operation succeeds, along with nlink change of upper inode.
-	 * Therefore, before link/unlink/rename, we store the union nlink
-	 * value relative to the upper inode nlink in an upper inode xattr.
-	 */
-	err = ovl_set_nlink_upper(dentry);
-	revert_creds_light(old_cred);
+	cred_scoped_guard(ovl_creds(dentry->d_sb)) {
+		/*
+		 * The overlay inode nlink should be incremented/decremented IFF the
+		 * upper operation succeeds, along with nlink change of upper inode.
+		 * Therefore, before link/unlink/rename, we store the union nlink
+		 * value relative to the upper inode nlink in an upper inode xattr.
+		 */
+		err = ovl_set_nlink_upper(dentry);
+	}
 	if (err)
 		goto out_drop_write;
 
@@ -1206,11 +1205,8 @@ void ovl_nlink_end(struct dentry *dentry)
 	ovl_drop_write(dentry);
 
 	if (ovl_test_flag(OVL_INDEX, inode) && inode->i_nlink == 0) {
-		const struct cred *old_cred;
-
-		old_cred = ovl_override_creds_light(dentry->d_sb);
+		cred_guard(ovl_creds(dentry->d_sb));
 		ovl_cleanup_index(dentry);
-		revert_creds_light(old_cred);
 	}
 
 	ovl_inode_unlock(inode);
-- 
2.46.0


