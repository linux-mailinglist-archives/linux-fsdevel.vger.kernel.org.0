Return-Path: <linux-fsdevel+bounces-17517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D87C8AE955
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 16:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 018BFB242F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 14:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBC613B5B2;
	Tue, 23 Apr 2024 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmjJS+od"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B013AD2B;
	Tue, 23 Apr 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882132; cv=none; b=Hb5ASvRKT1r/nL1nX3pdziD3JlqOX0ginYNoU7rMq7acEmYQAZlLuyiYiAjPG0SPsBT2s05VivFrcbPj59/+O7gRwhGz7Faqu7KKdOI+6Xe+IvMdLIjDgbOXte25xJ+e+JFtD83PfLXsYh1bZJLmwkFT0438YWxoHb2yitleciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882132; c=relaxed/simple;
	bh=zBsBBHL1e2snmIX58IfUqfbnuJKU+3R/sEuhgPszwh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAhI097M/SjEJwQ91IOuklZfiyikzdcoOsXU4Yw5/mQbG2SGsQxh1TQdT6SuPxCrF4X9zroiOpLaDrE5ZDw7f/sJJNQUzifgOGs2gY3/QKS+MXcxKR+LsmIcijXt28dtasajoITJoeQiub2apwVTtNNOzKW/LIMjJsnbznAuo7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmjJS+od; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713882131; x=1745418131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zBsBBHL1e2snmIX58IfUqfbnuJKU+3R/sEuhgPszwh8=;
  b=lmjJS+odVGNzwrE3GBVPj7eqvUXIPa2vglNuCuhKDGwdf9GBGC775LiR
   tfq2iwaMYUdzyu+dsX3PYWDBeLFf6pEZ+pvgOxZwZO1fBLLi8QBHk0bqW
   wIjjoS1J3QO/Vxr4MMvnss042Caoihb2fZO6Xyj+BGQtwUrovHNm3Wa2Z
   YDlRVGYzMTxasKyK21zbzZHuVk1M8q7gupsxSObwfGDjXTlRwN+Gn0OAR
   u4Gzbz9R1z3zI/CSBNJwpu/EHKBbh+qVbW1V45YS+VtorZzBZSQGuPuld
   L8ykiplCF2mZniBwKAFa1xETIFT76PbaMPr2XC0dg8TsHjEZLCbqjUFfG
   A==;
X-CSE-ConnectionGUID: M3/RmmvRRn6StgEKPXJVLg==
X-CSE-MsgGUID: I+FQAxkbSBiDHMEtqj5agA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20163851"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20163851"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:22:11 -0700
X-CSE-ConnectionGUID: tlvtzjWDQqmdq3Po0Q2zFQ==
X-CSE-MsgGUID: gSnos4jEQQOWrj26zDjTHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29030064"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 23 Apr 2024 07:22:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B55AC489; Tue, 23 Apr 2024 17:22:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 2/2] xarray: Don't use "proxy" headers
Date: Tue, 23 Apr 2024 17:20:25 +0300
Message-ID: <20240423142204.2408923-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240423142204.2408923-1-andriy.shevchenko@linux.intel.com>
References: <20240423142204.2408923-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/xarray.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index d54a1e98b0ca..d2e4d3624689 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -12,14 +12,18 @@
 #include <linux/bitmap.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
+#include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/kconfig.h>
-#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/lockdep.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/mm.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
+struct list_lru;
+
 /*
  * The bottom two bits of the entry determine how the XArray interprets
  * the contents:
-- 
2.43.0.rc1.1336.g36b5255a03ac


