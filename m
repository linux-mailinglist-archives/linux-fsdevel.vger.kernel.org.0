Return-Path: <linux-fsdevel+bounces-26655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0601595AA7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F10FB231B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C8618593B;
	Thu, 22 Aug 2024 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbRrryIB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E31836ED;
	Thu, 22 Aug 2024 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289945; cv=none; b=FBF57s+RXhFHQf/JNUuwOILt4EnKj8KJAsi776UzGXek6YwNWmBYHqv6pe53QuT9CbDScMKpmDRtJJvpzwBkfesyl1QvjGF/BnA2YkLupFK30xcjLbRNl5MBmi6dXhEhRnjAbUitK1RpVDKkK3e3Zp8qg3FtwPgKMPlXOp4C7qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289945; c=relaxed/simple;
	bh=1sA07qhmx3hNY35eUvH1W+ptgOoM99mdc8JI5jE8SM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDla3xMsTVeUcMvBTCcxcYU/rhle1/DnMO4yY4oTeUfCDKR10Rx8dpkSTKueK2GBs24BqIVCVaaArvbKJRTDyWayN5UIzfRG+yM/hSB5gXUY0O/7qpDkaB2a33YojV62LJtxifJMde2HWMt7DnJanUK9qPlPbYnXAYrouTpLdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AbRrryIB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289944; x=1755825944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1sA07qhmx3hNY35eUvH1W+ptgOoM99mdc8JI5jE8SM0=;
  b=AbRrryIBCMAHWkF1Zn29xjuEey687BGlYX9o8jw981MkEqc1kmCijtCO
   I6FBUFCvapeS/6yWvTT9+kpgdKsz1V1wKhFp4NbL3586veplqOZSf/ByC
   eepEBBbsJXWWyLnWtivUXM9pCdQDhYzHbS/l44TBRkuBSJeGPJ68orn0z
   WPJpiHkk3HhWn+dtEDiAOmqNAtrIy5b/4EvMmQLHmzyVVGcIfe3oMZQAu
   W9ZrqpCcDmJkSu2UuWlc1MWOMA9gxVpz6569teUAPuoU1G/lCiJ3RmsOj
   /gD/btPpyEhBSxwUhAD+LI2OfukdyWiDzpnSdbV/NgoG91ZmALV5aU/iT
   g==;
X-CSE-ConnectionGUID: wxCznk8sSj2dt2tXuYhT4w==
X-CSE-MsgGUID: iZ5tTzB8Rn+/tbGNdPjHGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574785"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574785"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:33 -0700
X-CSE-ConnectionGUID: rM5jJrkeQwqpHZoJ8t7Zew==
X-CSE-MsgGUID: 9f49qoRWQ66z1YYNza7nbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811070"
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
Subject: [PATCH v2 16/16] overlayfs: Remove ovl_override_creds_light()
Date: Wed, 21 Aug 2024 18:25:23 -0700
Message-ID: <20240822012523.141846-17-vinicius.gomes@intel.com>
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

Remove the declaration of this unsafe helper.

As the GUARD() helper guarantees that the cleanup will run, it is less
error prone. Future usages should either use the GUARD helpers or the
non "light" versions.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/overlayfs.h | 1 -
 fs/overlayfs/util.c      | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 557d8c4e3a01..0bfe35da4b7b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -429,7 +429,6 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
-const struct cred *ovl_override_creds_light(struct super_block *sb);
 
 static inline const struct cred *ovl_creds(struct super_block *sb)
 {
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 77b8d01829a4..fafd8b709f64 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -68,13 +68,6 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 	return override_creds(ofs->creator_cred);
 }
 
-const struct cred *ovl_override_creds_light(struct super_block *sb)
-{
-	struct ovl_fs *ofs = OVL_FS(sb);
-
-	return override_creds_light(ofs->creator_cred);
-}
-
 /*
  * Check if underlying fs supports file handles and try to determine encoding
  * type, in order to deduce maximum inode number used by fs.
-- 
2.46.0


