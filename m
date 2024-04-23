Return-Path: <linux-fsdevel+bounces-17518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDA98AE956
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 16:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6B4285927
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20B913BC12;
	Tue, 23 Apr 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAXYsct8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA913B583;
	Tue, 23 Apr 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882134; cv=none; b=JxcvrfcZQ5Wu4CXS/O8YqGOLpLKP1QxdqCa2xB1jxArTG+4ruq6ES4d2SyarxQoIAJ4eaLRoN3cEuBUf1OXiYAs3WFUcvkeMeQNx7pJEtzLtCzWbNJqYddJINxohhdCsvLvgNxP1TyvTTmPhdPxzRnHipTfBFfGp+3AbfhROBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882134; c=relaxed/simple;
	bh=l9wngut2dmKGkMnY+AgV+QGezfk1/t+xq5LIIizUEqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d6WOWoI5D4auEWXW81s0fCupou+7Q4ET9IsR1Uu1Qbsd0KEraIq+h5767FhQlbTsbF1NFSPG8TJlte9ipuH/3QphI2mMxGbHs3zcyWL5ft8VhZNO172T4v2FZD269qpslkwqTqNyutl61LCtDnmUK8wf/JzulCm12F0mN1o+GYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAXYsct8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713882133; x=1745418133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l9wngut2dmKGkMnY+AgV+QGezfk1/t+xq5LIIizUEqU=;
  b=hAXYsct81VxQMy40YTrKWxIgiMMufi3qBra0Yp2XCxEWTf5nFqn/uLLJ
   R4KsslAS6tdw0cEKwONqELuoh1h5K0B0mRv2AX5ETf1C4n7zN1ubhbvZ/
   GZw6lGTK1cJqgFZhm1g+dtNSpb9pqNi6gT0OWqwDAltHKNBNQnDtsh7fu
   YqgueY3yd1gPR2L+X2b0Z06eKHM0vcq1DmbxkWXNbUbKqH6Vvj9aQLrH3
   WrpfRJ3PtT1WMrG0x604FznU+7iNFbd4TfKR4vH3RkFszdWjgVtCd+8em
   xHG9FvvMYXVr1JUIxnSQC9ImPab+T5ShtvD+hdyBcJu4d7QWUpyuPVMf1
   Q==;
X-CSE-ConnectionGUID: OiBUwlEiTxOiDNsWdCaAsA==
X-CSE-MsgGUID: 4WmmEHSDSGyrNbXdQfh+Xw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20163856"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20163856"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:22:11 -0700
X-CSE-ConnectionGUID: CKeTtd6YR8CC2yqQntHkew==
X-CSE-MsgGUID: +iw3yEGCTx+s+/7h1ZEt6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29030065"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 23 Apr 2024 07:22:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9B9D944E; Tue, 23 Apr 2024 17:22:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 0/2] xarray: Clean up xarray.h
Date: Tue, 23 Apr 2024 17:20:23 +0300
Message-ID: <20240423142204.2408923-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Main portion of this change is to get rid of kernel.h included into
other globally available headers. This decreases a dependency hell
degree. The first patch makes it possible to avoid math.h to be included
as bitops.h is implied by bitmap.h.

Andy Shevchenko (2):
  xarray: Use BITS_PER_LONGS()
  xarray: Don't use "proxy" headers

 include/linux/xarray.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


