Return-Path: <linux-fsdevel+bounces-33856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FDF9BFB13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C18F28307D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF4C38385;
	Thu,  7 Nov 2024 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDik/j1G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736514F70;
	Thu,  7 Nov 2024 00:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941068; cv=none; b=ohenuRwp/dQjSmf+A5FzGUGW+jdigIHky2fUbmbERpDM42arL0Ard+/Ugk2xgG7+JZ9OXWQwxxLDaV/w8eEWHCHb1n2lr4fYe55NY6tN0KvJKsF4SFr8jKb1ZwX3XuKG+unPlIMyKsT0phHFIOjrfFHZP5cTEjt14/q5O4ZBfXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941068; c=relaxed/simple;
	bh=lvczs+KGO/SNLRad/bgNhITn0FjIxg1/VkTgbqju/bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6L8nT6BJpVu6ffp19c3PDnl8f/RSL1DWvHrwg8wC1/x61fCwFyht+ogKvWo+0insTuHTtkFMoYDLua5GYt1zuPFdP2Kb48GXpDWLqlEykSAQrHsBhpIhZkbgDigsNgDTXAz1CwXWbeuwF5JXpcE4kvPLZg+JRF4To75kLi1D8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDik/j1G; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730941067; x=1762477067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lvczs+KGO/SNLRad/bgNhITn0FjIxg1/VkTgbqju/bE=;
  b=WDik/j1GmQ2wwfIFCn0oSDu7l/4Xh4+kRuzuisHTlNJIyIio9RoUkD2k
   g+yOvSUqh2NeUCB+OyOUbCaxey8RMxVYP8xygHBIdjnxe+4UcGHMjmhey
   g2kgxZpEUZNXEwGUCxRfnCllP5etIeQdwPJ1sQcAxrVOENS6hU+2Bqgt2
   iVXhJEUxdjo5x4MC+qnxGqcq2980Lb78z+eXDZSUha+CdmphEL6NinzSZ
   3/e7uU2jTzlYn8X587YXTfY9Nq7iQhzJ+X08JJV/qYaM3LsQpgg/Dr9ra
   nD+54nt3FEG84p5jTLgsl5mjegEFYFDy0XyEpL9hrHfKMTEHu+GQCXEzh
   A==;
X-CSE-ConnectionGUID: by8ZH7PURNWxjzj3sQZovQ==
X-CSE-MsgGUID: OnfS1c9jRgeuYWmG9sPRMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41320198"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41320198"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 16:57:43 -0800
X-CSE-ConnectionGUID: FRrcaGJJRKq/UQ8rYpTXzA==
X-CSE-MsgGUID: 5/a1YUR9RROdsKTCNAWlHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="85193449"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO vcostago-mobl3.lan) ([10.124.222.105])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 16:57:43 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v4 4/4] ovl: Optimize override/revert creds
Date: Wed,  6 Nov 2024 16:57:20 -0800
Message-ID: <20241107005720.901335-5-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107005720.901335-1-vinicius.gomes@intel.com>
References: <20241107005720.901335-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use override_creds_light() in ovl_override_creds() and
revert_creds_light() in ovl_revert_creds_light().

The _light() functions do not change the 'usage' of the credentials in
question, as they refer to the credentials associated with the
mounter, which have a longer lifetime.

In ovl_setup_cred_for_create(), do not need to modify the mounter
credentials (returned by override_creds()) 'usage' counter. Add a
warning to verify that we are indeed working with the mounter
credentials (stored in the superblock). Failure in this assumption
means that creds may leak.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/dir.c  | 7 ++++++-
 fs/overlayfs/util.c | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 09db5eb19242..136a2c7fb9e5 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -571,7 +571,12 @@ static int ovl_setup_cred_for_create(struct dentry *dentry, struct inode *inode,
 		put_cred(override_cred);
 		return err;
 	}
-	put_cred(override_creds(override_cred));
+
+	/*
+	 * We must be called with creator creds already, otherwise we risk
+	 * leaking creds.
+	 */
+	WARN_ON_ONCE(override_creds(override_cred) != ovl_creds(dentry->d_sb));
 	put_cred(override_cred);
 
 	return 0;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 9408046f4f41..3bb107471fb4 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -65,12 +65,12 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 {
 	struct ovl_fs *ofs = OVL_FS(sb);
 
-	return override_creds(ofs->creator_cred);
+	return override_creds_light(ofs->creator_cred);
 }
 
 void ovl_revert_creds(const struct cred *old_cred)
 {
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 }
 
 /*
-- 
2.47.0


