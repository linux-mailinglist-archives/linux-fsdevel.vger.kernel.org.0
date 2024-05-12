Return-Path: <linux-fsdevel+bounces-19345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99B88C371A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 17:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3F91F215E3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF944C8F;
	Sun, 12 May 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ql7Wm84n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4DC81E
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715528189; cv=none; b=MZJjJjgQpyA6lyDqjvDPRCurMEy9G+RGyOZEYQMKhxXbdr65VTV75W3sJlxZTOeBPWiQVcer9n5Y4XJqvebDZG6qasSokx8aOeXr2aagMhkGvT8zDXc1TxejWlZJnUO0Dtveo0DdlHvB4+b0dsMhzGshqBmKONoZI05Wj7Xde2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715528189; c=relaxed/simple;
	bh=evDTg3GHvgeEAmXtLJweCY8WZi1mCFFe5o2IEX6ubQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o1dpFAN3Sma7JLGgcoQYUffpMGaFFLAx8rdl18AIxrTNjDLaxwpxBq5yQqPYbQuMUikzhW/oBJSlnsTLc25shOSXSrJNK0QWSUjXmiTDyWGT/cjrPTMRGrqha9uBXG0fpmOXlcI0D3UQySoV0z4ZFk98NONvlOJ+2apO5Pkz5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ql7Wm84n; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715528187; x=1747064187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=evDTg3GHvgeEAmXtLJweCY8WZi1mCFFe5o2IEX6ubQE=;
  b=Ql7Wm84n9mF6pquVDAIRxTSEUyqghmo7LTVIfdFFTeo5cPduXreiLqoe
   VQnCSc5RY+WrZdh0DO7Vg1VVN/5IrY2hTO+eblWE2RBSUeis6ODtllPZv
   c270BV1kSffsuobhbJqd75xIYS5EMI/wG6OC8HbyirqkEMLfS0VCdRFAd
   QYX1FCkwWzO0PGCkqC01k70NFpSDYONOf1pkPABaFqPau7JEdQb8GO5G7
   5iUPs+iJow7rkACAINqeOOlFgIQhAJfF3j+sBI4G5WOTczwQkpBH2EVW5
   6qCeHcuurWnxG9TTKX/9z/Cg7lMgqREuliByxqkqomnGzMI8yK9yOCZM8
   w==;
X-CSE-ConnectionGUID: 6YDQJsCgS7WWaJJSd3kaPw==
X-CSE-MsgGUID: nraQ+qNmSiGhzOlp4PLvpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11403298"
X-IronPort-AV: E=Sophos;i="6.08,156,1712646000"; 
   d="scan'208";a="11403298"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 08:36:27 -0700
X-CSE-ConnectionGUID: I5YStJUgQYekaUQSkMo9Ow==
X-CSE-MsgGUID: dV5CvDsdS2mAW9WTf295hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,156,1712646000"; 
   d="scan'208";a="34976553"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.25.139])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 08:36:25 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	linux-fsdevel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/4] Expose raw access to GuC log over debugfs
Date: Sun, 12 May 2024 17:36:02 +0200
Message-Id: <20240512153606.1996-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
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

Cc: linux-fsdevel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org

Michal Wajdeczko (4):
  libfs: add simple_read_from_iomem()
  iosys-map: add iosys_map_read_from() helper
  drm/xe: Add wrapper for iosys_map_read_from
  drm/xe/guc: Expose raw access to GuC log over debugfs

 drivers/gpu/drm/xe/xe_guc_debugfs.c | 26 +++++++++++++++
 drivers/gpu/drm/xe/xe_map.h         |  9 ++++++
 fs/libfs.c                          | 50 +++++++++++++++++++++++++++++
 include/linux/fs.h                  |  3 ++
 include/linux/iosys-map.h           | 24 ++++++++++++++
 5 files changed, 112 insertions(+)

-- 
2.43.0


