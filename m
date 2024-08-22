Return-Path: <linux-fsdevel+bounces-26643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8AB95AA4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73345285FA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C1A5674D;
	Thu, 22 Aug 2024 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsyfWWA8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2151B27D;
	Thu, 22 Aug 2024 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289937; cv=none; b=cdcMS/coGtSOaz1mQUB+V+6eTpt56oupAfvnOx3yWnPda38h3Hs/9VEatTv2DoQ1khaH0TvXz7GQuI344FOAJGNR6E7LGlbJN35EDRUSCUTzWmKW2n4RX2YmISWvtv8bcYk6x9iyAb2kjVceO1YU0vuQKnwl4P/PawCz8UQSEU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289937; c=relaxed/simple;
	bh=CZkEIxc+FPJaU+fDIa1vfhmaBsh7YXbodcWi0F7voVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qz0imvXHt/dzY3waWn7fBTphbyOGuhXdbtiIZ+CiseD3VHqXh4NosSt1BncRysLuALal+AQXmYB7bUN+iCh7yvG8Z/Z8cfl79nUAUI2Gf0hVsgN9Gwpx2H3CM3dgfzzUQqqeIb0AjPveTxS2mLDzqWOVvNA2fKm2CgVs8YM7tg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsyfWWA8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289936; x=1755825936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CZkEIxc+FPJaU+fDIa1vfhmaBsh7YXbodcWi0F7voVM=;
  b=FsyfWWA8Bxpz6Xc9zKMSMAayNK9t+c3cn9obsKUZqc4sVh+P3c8FA+BE
   PhSYs+yWfb6aBb0Bdj12bafL0uWGSQ/dbgRnVsujsd/ulqkRLCnBmgpwn
   o6ALKZQL+pUZ4T8D0DqMG8zbVUlRk6R+eVGL9G6BtClysSMXCgdg1wus2
   OzUKMfB98Re3469rYhNG/fO++VSoF6gvuaRgYczE8hHotwSU/OsNoiOR2
   Ufk2qg/KsWzNb+0i0nuDfRSiQe77A2blJ23CvQfRUmmaQltED9a+ujGQZ
   OwAApkd/1yKhCI7bvr8XLCzBNSXTXiOIECecIW8EUoKa1EgCzmwi+TEGU
   w==;
X-CSE-ConnectionGUID: CvimTQMATLKimauT2WpTrA==
X-CSE-MsgGUID: Tub3MiOORFGOqff8cOUifg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574733"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574733"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:32 -0700
X-CSE-ConnectionGUID: qGd1H4ZLS7iaqbvcQt7jbw==
X-CSE-MsgGUID: ZvvVH9+UTlSlgf/5Z8ERMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811028"
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
Subject: [PATCH v2 04/16] overlayfs: Document critical override_creds() operations
Date: Wed, 21 Aug 2024 18:25:11 -0700
Message-ID: <20240822012523.141846-5-vinicius.gomes@intel.com>
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

Add a comment to these operations that cannot use the _light version
of override_creds()/revert_creds(), because during the critical
section the struct cred .usage counter might be modified.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/copy_up.c | 6 +++++-
 fs/overlayfs/dir.c     | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index a5ef2005a2cc..7dec275e08cd 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -718,8 +718,12 @@ static int ovl_prep_cu_creds(struct dentry *dentry, struct ovl_cu_creds *cc)
 	if (err < 0)
 		return err;
 
-	if (cc->new)
+	if (cc->new) {
+		/* Do not use the _light version, the credentials
+		 * ->usage might be modified.
+		 */
 		cc->old = override_creds(cc->new);
+	}
 
 	return 0;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ab65e98a1def..851945904385 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -584,6 +584,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 	const struct cred *old_cred;
 	struct dentry *parent = dentry->d_parent;
 
+	/* Do not use the _light version, cred->usage might be modified */
 	old_cred = ovl_override_creds(dentry->d_sb);
 
 	/*
@@ -1159,6 +1160,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 			goto out;
 	}
 
+	/* Do not use the _light version, cred->usage might be modified */
 	old_cred = ovl_override_creds(old->d_sb);
 
 	if (!list_empty(&list)) {
@@ -1314,6 +1316,7 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
 	int err;
 
+	/* Do not use the _light version, cred->usage might be modified */
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_setup_cred_for_create(dentry, inode, mode, old_cred);
 	if (err)
-- 
2.46.0


