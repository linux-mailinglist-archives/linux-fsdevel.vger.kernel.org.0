Return-Path: <linux-fsdevel+bounces-23827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11CF933E52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 16:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D731C21081
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F45181319;
	Wed, 17 Jul 2024 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jq9sOuM+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BCC11CA1;
	Wed, 17 Jul 2024 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226261; cv=none; b=T6bGVYd2FDwils5N/vsT2z9FPUW3NAj3ghuJtYx9JkZvmDFr8xB9yPiRRnId1bJmsayRRMMGkGVSqoLNn60VWOPWMUEMZ5e/gdNwG7FcA9dAjlNAw1eNx7QHuOJM3AbPLL8wAlXCQAkdWLhyC1x4lGG9y9nZbWyridP1Nzw1uGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226261; c=relaxed/simple;
	bh=6cYRLXHWXL4ibRkIOcn9Cw2QGInwfKBSviOsULVF0rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qp4cAs+O5qQuR/Hpuogq2RcfUGkR6+3jHawqRl/3GlaKQ4ytvEhD+XCWB7s3liYI8JPjz85hFuUfGBZCllKBgbZL/4YSavEqKR/MQuBWl2S/NK87aZHgAmOc1/4+XlN4ocbR8PIbhn8OiczLZ+w2+fpAtu0n0DN4rDI+kXbRkew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jq9sOuM+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721226260; x=1752762260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6cYRLXHWXL4ibRkIOcn9Cw2QGInwfKBSviOsULVF0rI=;
  b=Jq9sOuM+vDgI77k34hXBug3ilMeYCsMteikx8b5WdWLoQunsoLLKvjvt
   cU6QfNsNQbsdXOs9inTX5Wbu/xHryOOvIP/LRAHCAYpb8VNBTnqqNsryA
   OkMV+UKUyLd+zq4Dd1QHsCnHn3dU0wsOfDWqh4s6waMlLA/CbuxymXM8X
   8WO6u5L2twPcUuO5Nw2MiflM76lBNyZfNt1y0de3s83u1prcQOHsYUAWP
   thpevUT+1zNeqWTCDWVjg5Bh5KSeZGNeTWI7kibzknrebVz5OgBomEmlc
   fwqwtFKGWCYdqwiGvRVrzg7X7ZHmOnunT8UIX81f3AQcjjgXP7uREBU0S
   g==;
X-CSE-ConnectionGUID: rw4RKfyhS2acdp73CKc0/Q==
X-CSE-MsgGUID: 2wHvQBksSjqgYTgJZUy9aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29313599"
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="29313599"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 07:24:19 -0700
X-CSE-ConnectionGUID: zBV00UreRQ63z0WN8pu2Qg==
X-CSE-MsgGUID: sNg6y5VSQKGlf6vQ/YOyPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="54596614"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jul 2024 07:24:16 -0700
From: Yu Ma <yu.ma@intel.com>
To: brauner@kernel.org,
	jack@suse.cz,
	mjguzik@gmail.com,
	edumazet@google.com
Cc: yu.ma@intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pan.deng@intel.com,
	tianyou.li@intel.com,
	tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v5 0/3] fs/file.c: optimize the critical section of file_lock in
Date: Wed, 17 Jul 2024 10:50:15 -0400
Message-ID: <20240717145018.3972922-1-yu.ma@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614163416.728752-1-yu.ma@intel.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pts/blogbench-1.1.0 is a benchmark designed to replicate the
load of a real-world busy file server by multiple threads of
random reads, writes, and rewrites. When running default configuration
with multiple parallel threads, hot spin lock contention is observed
from alloc_fd(), file_closed_fd() and put_unused_fd() around file_lock.

These 3 patches are created to reduce the critical section of file_lock
in alloc_fd() and close_fd(). As a result, on top of patch 1,
pts/blogbench-1.1.0 has been improved by 22% for read and 8% for write
on Intel ICX 160 cores configuration with v6.10-rc7.

v4 -> v5:
Revised patch 3 for some code style issues.

v3 -> v4:
1. Rebased the patch set to v6.10-rc7 and updated performance results.
2. Updated patch 1 to revise the order of fd checking.
3. As proposed by Mateusz Guzik <mjguzik gmail.com>, and agreed by Jan Kara
<jack@suse.cz> and Tim Chen <tim.c.chen@linux.intel.com>, updated patch 3 with
a more generic and scalable fast path for the word contains next_fd.

v2 -> v3:
1. Rebased the patch set to latest v6.10-rc6 and updated the performance results
2. Reordered the patches as suggested by Mateusz Guzik <mjguzik gmail.com>
3. Updated the fast path from alloc_fd() to find_next_fd() as suggested by
Mateusz Guzik <mjguzik gmail.com> and Jan Kara <jack@suse.cz>, it is efficient
and more concise than v2.

v1 -> v2:
1. Rebased the patch set to latest v6.10-rc4 and updated the performance results
2. Fixed the bug identified by Mateusz Guzik in patch 1 with adding rlimit check
for fast path
3. Updated patch 3 to remove sanity_check directly per the alignment with
maintainer

Yu Ma (3):
  fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()
  fs/file.c: conditionally clear full_fds
  fs/file.c: add fast path in find_next_fd()

 fs/file.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

-- 
2.43.0


