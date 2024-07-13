Return-Path: <linux-fsdevel+bounces-23627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D52893032C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 04:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86161F236C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 02:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E6F14012;
	Sat, 13 Jul 2024 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOzmMuZl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F00D1FB4;
	Sat, 13 Jul 2024 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720836800; cv=none; b=rv6CxP+3bkcSBymvgXrpEAwAJxUEQ9l0aNdmAa0sk2nm6+8dIdfHFz0fPpsJibmbcGYt8INno9SbH+QdWG6K1r/oMur4r2AYu9ZoUcV71nXkEbqqLYKuNRcirXPnj5D7RnLL05K/RX+Cd7nbFwIEiyUTmF41rE4At911Gz57RdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720836800; c=relaxed/simple;
	bh=i0I8QWNsM4G1mHZmeVaLIHQgGk4PNpA7jkE//Yfz0A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvnSJJofjGlxvaM1eU7gVGjSvdYM7As3ZEM6epzp/pnprExhCUM4z4EDClNb4kd67mh6X35mInanKqEIhU4jtBbNGZVmkwcDsGj8MjfzpO2BdrOfXgtXZfz/bDBirCBGL5nXWuVMTHzrsNLH5Fk9PsghYNSrS19MDOjG86yJ0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOzmMuZl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720836798; x=1752372798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i0I8QWNsM4G1mHZmeVaLIHQgGk4PNpA7jkE//Yfz0A4=;
  b=bOzmMuZl/DeeaNnFb4MmyosvXxMJ9Sf0u63Zrx7tZiG+88YPRwOEZAwF
   hNBUIATrynHrE1LD24PozkiJDdonxzhJPUvCYV84wq6ts5MD7ueMoyfr8
   rVCtCTC45ppYIaDvVNNZUl7XTRsSC4EY65p6WchtMmUe3AeurC3xu7NbC
   DjB7LJppC27EgymOiJER71YwYFHUqfsPP5fcd7ahSJe2cJndzWqxRQ+LX
   jZ1Lz2BF/Zf7ADpOkfuZKn4tuYY05dlBygTEjCEnhQo6IAYKNyFy9i2dj
   nChvq3YqzPeOpSXFxSVMdY8LX96ZgnG9kfLQEeS6yV3ECzI3a8JAMeS+W
   g==;
X-CSE-ConnectionGUID: i7eVGVInRkGSYrrEtimdFg==
X-CSE-MsgGUID: nnLUEjDNRRmmpXGuWpO5jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="12531265"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="12531265"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 19:13:18 -0700
X-CSE-ConnectionGUID: 7l8LxtmoRCaWA/sgg2j34Q==
X-CSE-MsgGUID: /2wzwrsOQxOsNcXz2rE3mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="53449876"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa005.fm.intel.com with ESMTP; 12 Jul 2024 19:13:15 -0700
From: Yu Ma <yu.ma@intel.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mjguzik@gmail.com,
	edumazet@google.com
Cc: yu.ma@intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pan.deng@intel.com,
	tianyou.li@intel.com,
	tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: [PATCH v4 0/3] fs/file.c: optimize the critical section of file_lock in
Date: Fri, 12 Jul 2024 22:39:14 -0400
Message-ID: <20240713023917.3967269-1-yu.ma@intel.com>
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

 fs/file.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

-- 
2.43.0


