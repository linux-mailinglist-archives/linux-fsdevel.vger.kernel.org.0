Return-Path: <linux-fsdevel+bounces-33922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11749C0BC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 17:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CB72830CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 16:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2862C215F5B;
	Thu,  7 Nov 2024 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uyc5LkOp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9E212D22;
	Thu,  7 Nov 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997307; cv=none; b=GGdkox5sH/ixmLf20BipsRiXBYATuKbus+o9ZU6h+d7nTnEiVZbJDu6y3LHpt7749TJgiVR+tnKOy/Dpu6R/PcA0vNY9tml/a7Hg2a/sIxOtdUtonVwUNOhJS/8kO9WqZqJq2TLiI4+8ihIIgCY62zL+KbNpDVrEMgFPTiZI7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997307; c=relaxed/simple;
	bh=WVukMqPCZ/St6naa+qTnbTU9PWTOYMZHCqJ2q93NY7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HfSmE9cDJptm6dFS0ymbRJTaYPw2SJdyFwLVy2RDm3QAvUzx09P2ujLwyle+9MYaIzuxrCmxXC38x+VLKTs0SbW7cxyc7+BulC3lgjfSWGIU10KPUjamNWb0g9zboZ6ZszRjDguc93o2M4k+OBJN+0zc8R6ceWd45aN6CJCw0Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uyc5LkOp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730997305; x=1762533305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WVukMqPCZ/St6naa+qTnbTU9PWTOYMZHCqJ2q93NY7M=;
  b=Uyc5LkOp8uOmu7K26M+vx1nR9F4yORbA8/EvLiTeYJaBJ/UCfcalIRua
   JY6xq1OYzT1RoYZMMSCZanRVIIoVXINyE984kSbYoZYsgDUqw6AXywEQI
   K3hhRb1cFXDFuZRfP36Wzdszzz5J2pK7vj4LRiDt8gPbB4CVBu8wfJUVX
   o5Pa8rXyRhpwRA1WjG0/VECZrPrZmg544x/UPy8frlEqpUlxzwzVqzjZN
   qj33NtFB20lIUZUajyYNWX9/rBlFzbBrN0J0qQTR5PQvb107BcqHMgmGn
   Og1TKkReZlLvq+bohec9U9Ik90uqt5wPFO8OtCflfcqGEUDuGg10q7p2Z
   w==;
X-CSE-ConnectionGUID: WpJJM0IVQgGRmCH2knETSA==
X-CSE-MsgGUID: KGUdOboVT7+ubu30yYDe5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="18480120"
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="18480120"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:35:04 -0800
X-CSE-ConnectionGUID: QU95xq5dTMSGTBZYHU49LA==
X-CSE-MsgGUID: T6lFau12S/2gThGVU1+C9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="89796988"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.2.138])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:35:03 -0800
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] Add iomem helpers for use from debugfs
Date: Thu,  7 Nov 2024 17:34:44 +0100
Message-Id: <20241107163448.2123-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series attempts to promote helpers used by Xe [1] to libfs.
Earlier attempt [2] with similar helper was unnoticed.

[1] https://patchwork.freedesktop.org/series/140848/#rev1
[2] https://patchwork.freedesktop.org/series/133507/#rev1

Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org

Michal Wajdeczko (4):
  iov_iter: Provide copy_iomem_to|from_iter()
  libfs: Provide simple_read_from|write_to_iomem()
  drm/xe: Add read/write debugfs helpers for GGTT node
  drm/xe/pf: Expose access to the VF GGTT PTEs over debugfs

 drivers/gpu/drm/xe/xe_ggtt.c                | 52 ++++++++++++++
 drivers/gpu/drm/xe/xe_ggtt.h                |  7 ++
 drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c | 62 ++++++++++++++++
 fs/libfs.c                                  | 78 +++++++++++++++++++++
 include/linux/fs.h                          |  5 ++
 include/linux/uio.h                         |  4 ++
 lib/iov_iter.c                              | 42 +++++++++++
 7 files changed, 250 insertions(+)

-- 
2.43.0


