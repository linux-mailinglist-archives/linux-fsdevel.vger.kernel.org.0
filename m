Return-Path: <linux-fsdevel+bounces-19349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C666A8C3722
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 17:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A961F21683
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 15:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071914776A;
	Sun, 12 May 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOq9uKUy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2446441
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715528198; cv=none; b=QiHElglZNDma5gkHyTA9HRZ5tVP3i7XeVBlm67zjw+AJVV2ptHAedDMS9hRXZqnW3VKr1PxWvQ/1Z/8hfPVjiFMN9ToTzXLVpQ0BaY9BqEIpx4VbcxLvV/a3fvnkXK4ZyKwvw+1TaIcFtZnFn6xrhRwXEOIpzsFQaFHUito43cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715528198; c=relaxed/simple;
	bh=bgkLgGVBN1X+G4AcO3iprTd4Lp+rZcXDf1rU9vl2ShI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MwFB/NDqAeOCQbIKP8p89Cef37MktK6dJEK2jxaMPj+Jw6xs9pRBmM0swralJ9w7aYXhjJkzU67WmVioxBW+ejca862taKnmZowiLpzek3kJ0eBYkWU546h3BrfoGJ1Tur6Lam9xreqrC/LLV3VrsbsYP0ebYWls1JNjWc89GCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOq9uKUy; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715528197; x=1747064197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bgkLgGVBN1X+G4AcO3iprTd4Lp+rZcXDf1rU9vl2ShI=;
  b=WOq9uKUyZXvtjWT64wdjR40QgtLyvoRTyKH9b9FxJd4I/PHBNVtYHpkH
   skePHVCmcpB5v/1XZPwcYTl953F3UyHABpcuFY8OIHA+jnAfHG5/g8JK2
   CTIjUypTwK4kWz7SoBSPdItmgvWESyl9TtS3mfDpl7/2uINqDifESJA3B
   BXEo2eemDv+AVKDYgjtDud5aoVv91Imaqq0pkAeagShiyBSlofMm/aJ3B
   aBCruVHDPI5e7AXqwBsZwQlLjuPYhXHQQAGMCU7KGNMuhkplVfL3cuJ4i
   PIAa3o+9zTUlU9TSWakN9SRTrpzBR2R3ZPXfPbFnPgh8wuoIO9miub5Ld
   g==;
X-CSE-ConnectionGUID: OH6WmiOZTimKewpuagYDvw==
X-CSE-MsgGUID: ZUV3op1kTfuf5c7HeM/4/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11403315"
X-IronPort-AV: E=Sophos;i="6.08,156,1712646000"; 
   d="scan'208";a="11403315"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 08:36:37 -0700
X-CSE-ConnectionGUID: m3n46GydTXuj/s+gNmxweg==
X-CSE-MsgGUID: /j/BC61GQnKijWeCcPqVRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,156,1712646000"; 
   d="scan'208";a="34976587"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.25.139])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 08:36:34 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	linux-fsdevel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 4/4] drm/xe/guc: Expose raw access to GuC log over debugfs
Date: Sun, 12 May 2024 17:36:06 +0200
Message-Id: <20240512153606.1996-5-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240512153606.1996-1-michal.wajdeczko@intel.com>
References: <20240512153606.1996-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already provide the content of the GuC log in debugsfs, but it
is in a text format where each log dword is printed as hexadecimal
number, which does not scale well with large GuC log buffers.

To allow more efficient access to the GuC log, which could benefit
our CI systems, expose raw binary log data.  In addition to less
overhead in preparing text based GuC log file, the new GuC log file
in binary format is also almost 3x smaller.

Any existing script that expects the GuC log buffer in text format
can use command like below to convert from new binary format:

	hexdump -e '4/4 "0x%08x " "\n"'

but this shouldn't be the case as most decoders expect GuC log data
in binary format.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
---
Cc: linux-fsdevel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/xe/xe_guc_debugfs.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_guc_debugfs.c b/drivers/gpu/drm/xe/xe_guc_debugfs.c
index d3822cbea273..53fea952344d 100644
--- a/drivers/gpu/drm/xe/xe_guc_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_guc_debugfs.c
@@ -8,6 +8,7 @@
 #include <drm/drm_debugfs.h>
 #include <drm/drm_managed.h>
 
+#include "xe_bo.h"
 #include "xe_device.h"
 #include "xe_gt.h"
 #include "xe_guc.h"
@@ -52,6 +53,29 @@ static const struct drm_info_list debugfs_list[] = {
 	{"guc_log", guc_log, 0},
 };
 
+static ssize_t guc_log_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
+{
+	struct dentry *dent = file_dentry(file);
+	struct dentry *uc_dent = dent->d_parent;
+	struct dentry *gt_dent = uc_dent->d_parent;
+	struct xe_gt *gt = gt_dent->d_inode->i_private;
+	struct xe_guc_log *log = &gt->uc.guc.log;
+	struct xe_device *xe = gt_to_xe(gt);
+	ssize_t ret;
+
+	xe_pm_runtime_get(xe);
+	ret = xe_map_read_from(xe, buf, count, pos, &log->bo->vmap, log->bo->size);
+	xe_pm_runtime_put(xe);
+
+	return ret;
+}
+
+static const struct file_operations guc_log_ops = {
+	.owner		= THIS_MODULE,
+	.read		= guc_log_read,
+	.llseek		= default_llseek,
+};
+
 void xe_guc_debugfs_register(struct xe_guc *guc, struct dentry *parent)
 {
 	struct drm_minor *minor = guc_to_xe(guc)->drm.primary;
@@ -72,4 +96,6 @@ void xe_guc_debugfs_register(struct xe_guc *guc, struct dentry *parent)
 	drm_debugfs_create_files(local,
 				 ARRAY_SIZE(debugfs_list),
 				 parent, minor);
+
+	debugfs_create_file("guc_log_raw", 0600, parent, NULL, &guc_log_ops);
 }
-- 
2.43.0


