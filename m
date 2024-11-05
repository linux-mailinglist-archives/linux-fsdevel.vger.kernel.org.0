Return-Path: <linux-fsdevel+bounces-33696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2CA9BD5F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 20:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C121F24E2C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 19:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BF5212D1C;
	Tue,  5 Nov 2024 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7vqI0RG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F91212630;
	Tue,  5 Nov 2024 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730835341; cv=none; b=XvlmIfV6xPAhXDOKKQof9jbWLxhl1F6MM6R37+O0rU5FC31wE71Eh00i4/oSBWU5dTSTvIt0o6+JLuo4RJ1ObKqDv/c78WW8tiiFOsgqkTEW+63u7LW1rvqB/EKuroF/l8mTe8X/L0vTCiCp6HE93P76vCuHm6/zhuDjPPIuscU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730835341; c=relaxed/simple;
	bh=V8K3YQoPkVxlzdYMsmRmO8gq3bm6FCUInrmT5xIGlcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4IZjnHyY4kWEOC+Q0fXAgQRusFCeOnf0V9u2MO48sgCaSB4R4i1sBI52fjqfHEtqL3iscT61cWN/8FWpA6pYz4p9GT95nJiG2NgbUHLjfV+urw+HCzZGEyBtlJMHTjGpY1UyPSTJPlM3XxRcWf6OaNqwFauQWw3vMUVTgnCisE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7vqI0RG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730835340; x=1762371340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V8K3YQoPkVxlzdYMsmRmO8gq3bm6FCUInrmT5xIGlcw=;
  b=D7vqI0RG6wF5u7WY7Zq9ie2NzaRbDItU8TrPAlc8uU1ZoxLt3CG8SHKE
   9qyXHcNM8WypG17s3PUbYy7YJdOltoTZYGE1YZsrOQLKCxP/UDCvcAERo
   dedHcAGJAFjIPNR10XO8Q7gc1t3+EQ40w9pSKvLa+avHfcXtyYO9iqkyn
   Bx4yVpU5sxgPv9VxxduVks415rWNFVHwfhcutsbn2v0yNVgmt1IIvv4wM
   +F2kMSuuJIy92h14KGA6HVO+gFNZSs88SyKnPdpUdacBjQhIywS9UEkFz
   UhrGamPI2Kb0c8hNeQbavwougRJjOqYwUZCO3+BmW00osYJh9dLPWkhda
   A==;
X-CSE-ConnectionGUID: ASxixUeUTy2Up27ZecmD4A==
X-CSE-MsgGUID: vd/RoH+iTvSYXQwxt9c7VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34297826"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34297826"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 11:35:37 -0800
X-CSE-ConnectionGUID: zrgE/8Y9TqaIZ7nCaG8pMQ==
X-CSE-MsgGUID: dKWaUdXGQ0KVqEZdZBSxMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="114939409"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO vcostago-mobl3.intel.com) ([10.124.221.238])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 11:35:36 -0800
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
Subject: [PATCH overlayfs-next v3 4/4] fs/overlayfs: Drop creds usage decrement for ovl_setup_for_create()
Date: Tue,  5 Nov 2024 11:35:14 -0800
Message-ID: <20241105193514.828616-5-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105193514.828616-1-vinicius.gomes@intel.com>
References: <20241105193514.828616-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the previous commit, we do not need to modify the mounter
credentials (returned by override_creds()) 'usage' counter when
preparing for "create" operations, as 'usage' will be kept constant.

Add a warning to verify that we are indeed working with the mounter
credentials (stored in the superblock). Failure in this assumption
means that creds may leak.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 74769d47c8ae..de012db6c169 100644
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
-- 
2.47.0


