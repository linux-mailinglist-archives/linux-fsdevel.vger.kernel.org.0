Return-Path: <linux-fsdevel+bounces-26647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC4B95AA5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD931F238BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFD717DFFC;
	Thu, 22 Aug 2024 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFxfpoHU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604B1139D09;
	Thu, 22 Aug 2024 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289941; cv=none; b=CirikqS9Re136ecO/mK03y1Fn7CmuTCPATYzX2OQYoc6mNN7W6eNp1TdTg+O/Pt1Uib9kQt1Tpfu+3+ySiTWnQlDX4snaqyDlRIuBEy10Qh00Sa4KK2UFn90HwFQkeFOTM6C5MOy6OSkrRGlEyaKxb21syap863Sx+r5MiOSNGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289941; c=relaxed/simple;
	bh=5rXnXbk1c4Kt4w3W/VDqUVSLfqQ4dhp6JFN14hVfuIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSvdN25ulK2GbDVru9JSxaIJCFz37iGtBjqzjGkPjQ2k8eB7ED4LyX6m4WMQ3Mbo304neE5kf8VXK5cvEfv6vUyF2Y28dMaMRbdbHdcC35m3yqhqOZh0cFFflViDnLEKa9xD2TSHHRdL2hKidjKZt1rvjDWT8CGoKRu+T6VIvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFxfpoHU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289939; x=1755825939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5rXnXbk1c4Kt4w3W/VDqUVSLfqQ4dhp6JFN14hVfuIg=;
  b=LFxfpoHUj6urcaTS9J6vNDRfahbGQfD+kX/lteD3S0jUoFTZx46u8+7M
   Xoy/7e2deUDmh17NGznSs3XnzG20l91N5YRhF9l6DqrScwWl2FBrpb8Yc
   3YVarXKD5QXhIigfbP+wN0vh6e/dGn8t8uMx3uxgAi+Ce2tXc02xHlrR4
   TSPjA1Cewzr7Cr5XeJtaCV5hadjUEZt022jZLF++PxoXdQpQj5CE4gYfa
   LD013gz5Ger9TN1lWhscai5yS26Zi0R1yEKA+MdXTCkJuPAbDLOvMP2e0
   uOc23kidzPLbKGhtIQmVOP8MlhCF+0lJogEMNo4EvRYHC2fXYRsE5hL4c
   Q==;
X-CSE-ConnectionGUID: Y+LR17zcQhSEJCKZE8mWTw==
X-CSE-MsgGUID: 1Ix7XCpOR1SOqvsav6WlGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574753"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574753"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:33 -0700
X-CSE-ConnectionGUID: PdiG4iYHQf2bvqRNmQBbug==
X-CSE-MsgGUID: b08gBb1vTfOlEEwfPb/kgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811045"
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
Subject: [PATCH v2 08/16] overlayfs/copy_up: Convert to cred_guard()
Date: Wed, 21 Aug 2024 18:25:15 -0700
Message-ID: <20240822012523.141846-9-vinicius.gomes@intel.com>
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
operations to cred_guard().

Only ovl_copy_up_flags() was converted to use cred_guard().

ovl_copy_up_workdir() and ovl_copy_up_tmpfile() use their own
credentials helpers that may change the usage of creds in question. So
these are not modified.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/copy_up.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 7b1679ce996e..cab87d390b54 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1184,7 +1184,6 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 {
 	int err = 0;
-	const struct cred *old_cred;
 	bool disconnected = (dentry->d_flags & DCACHE_DISCONNECTED);
 
 	/*
@@ -1204,7 +1203,7 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds_light(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	while (!err) {
 		struct dentry *next;
 		struct dentry *parent = NULL;
@@ -1229,7 +1228,6 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 		dput(parent);
 		dput(next);
 	}
-	revert_creds_light(old_cred);
 
 	return err;
 }
-- 
2.46.0


