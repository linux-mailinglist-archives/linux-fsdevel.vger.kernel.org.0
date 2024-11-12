Return-Path: <linux-fsdevel+bounces-34538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F219C621B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A041F2321F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38607219C94;
	Tue, 12 Nov 2024 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxkmQPOx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D6C212D05;
	Tue, 12 Nov 2024 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441929; cv=none; b=pWEfUEWLxdUXi/EC/yZccSBenX8BV4pprHmQBaTDhwNpE6rMXGEXDaYee5+O3BS80sjKwFX3vEV8AwGaIzTh48zZ07ZzmdyrzwzBB3SZ4hLbsQ55RFFtMopeJMSOeyiskmp9SxlbA1gD4JNy6PERFvSoAQG+8RaeGKMFJkjO3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441929; c=relaxed/simple;
	bh=aKiEV+jPfRQz3/UPWDaLFzJD8dFBjc5HUjXksgGPKLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UlMYCw8U8ggKXjv4Cv4RIJHMPjrNFBY6y7P5kpa75ynZRHC0mE7wt3mXx1wqwizHh6e6POd1qr4eQHzaQcTWfZM/SnxU0zIKP7Ym2t5BK27M3i1yJvemI+j05W54QvrfJuBPkK0F20CF9EyqZKWpxLZFX6W544Rw16pE0CH8QJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxkmQPOx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731441929; x=1762977929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aKiEV+jPfRQz3/UPWDaLFzJD8dFBjc5HUjXksgGPKLs=;
  b=lxkmQPOxRpdZ3QR3B1mpFPfXizkHtfH7IcfrnYYAW+sn/EGiV1ZNj7WW
   N2vJytGJSsBAGmKjnvQwbd9Q6emjNZjMj/l/PH5P3F3LEhr7HDSs16ifR
   ebIZIeT0VigvF/+he5+DGF+Ow71zXyRpu5WUzW+HPNEfqyr0EL9/6Hkgj
   E4klsmSqgfsy5WyHl72QJ1REUnm4m3QdR0X0nRZx65+nw3cweFl4ehowK
   G20vMOA039MJDJV3LcA46/Y/wxHoUQI48/B9W0I2cJLHrzfSlTaQaOaay
   FUgl3TZGQEFPzSGZOYgg6UAPe4f+e60l+SVkiHjcMKyVjnkjNfj6XhXTa
   Q==;
X-CSE-ConnectionGUID: 6wnYenn1QGK2XyhvOPs7WA==
X-CSE-MsgGUID: wP59/F7/Rly6KMoFUWFy9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31394336"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="31394336"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 12:05:28 -0800
X-CSE-ConnectionGUID: bKkRxV3gTQGTixoxY33i7w==
X-CSE-MsgGUID: SwfoqNkJTe+phUgbyVRLkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="92710347"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.245.85.128])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 12:05:26 -0800
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/4] Add iomem helpers for use from debugfs
Date: Tue, 12 Nov 2024 21:04:50 +0100
Message-Id: <20241112200454.2211-1-michal.wajdeczko@intel.com>
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

v1: https://patchwork.freedesktop.org/series/141060/#rev1
v2: use iterate_and_advance to treat user_iter separately (Matthew)

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
 include/linux/uio.h                         |  3 +
 lib/iov_iter.c                              | 66 +++++++++++++++++
 7 files changed, 273 insertions(+)

-- 
2.43.0


