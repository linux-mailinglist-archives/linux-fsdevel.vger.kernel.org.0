Return-Path: <linux-fsdevel+bounces-23032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76CF9262E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEAEB28B6A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAD017BB2D;
	Wed,  3 Jul 2024 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ie3SajtA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4654E17BB12;
	Wed,  3 Jul 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015635; cv=none; b=LfJQ9FcMA+7h8ZGGb1r2y0FJDuoOUpoYr624qFVNeQACWZ3NgR8tzWmahqx+OTJvWjBhbE148jYbt1gVYfAp/7ktG8jMgwHONj8ObBd+whEHBw3xUxZhQNT8GE3MBBZyin56tohscdfggiZvw4l1KWNpCcBTpKlKfxlwpjOY9DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015635; c=relaxed/simple;
	bh=hTpxPUXvEU8n4GM4NIa7g8llxJ/C3fr7LbX8OlU0qZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pi03X6d9/Lz3K8lYBBDirxU3V0Bv9NcRXrx4ab9Udyx7tBjvQpsqA2sN49COWr2EsA2jV+pS/QjN8GcD1V3zh3QXJmS8IsXaGlVZNBD7ZMEHUGZ6qGR7pil517gdR/72lveiaYWHC1RJsTFHQzue98sSu7QnrBItTPbTkvI6MyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ie3SajtA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720015634; x=1751551634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hTpxPUXvEU8n4GM4NIa7g8llxJ/C3fr7LbX8OlU0qZ0=;
  b=Ie3SajtAuXjGg8UeGEb3enlFyyyAmbSo64jhYzBF+2BbZZjCmQjLm/np
   QsJzIaGSZWR9JxqbSCIc8mkNSvCvwWSNwqPkPjbgpkAePj6J/si3ffZZi
   52PxUxK0OGPd4jt8o5cJMOc4id48fIbdBgX91hcK1QB+icys2qIhuYHKB
   KyQLL9VCpNFvjQj5yq3HrMYSaYZHQRXvMBf7lLstRDqfCc0aJM0DH4gxd
   0ZWpPqN/HxmH2NdWBdxFjIsntve8yp17b7yaHZX7h4quQLq+Eei9SxR99
   YA16oodt8IjOcwgVUcy/m9pY448o3RY3FYvB1FqfwbLkn8aZm8qJzZUXc
   A==;
X-CSE-ConnectionGUID: CBEAYyxxS7mSpj92P5qNDA==
X-CSE-MsgGUID: OfzPcqjdQyG0GNbZTAbrjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16900688"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="16900688"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:07:13 -0700
X-CSE-ConnectionGUID: D0WeKrJrQleqCjfg6QH6qA==
X-CSE-MsgGUID: S6D4843kTsCHHxqOJTA+OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46693450"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by orviesa006.jf.intel.com with ESMTP; 03 Jul 2024 07:07:09 -0700
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
Subject: [PATCH v3 0/3] fs/file.c: optimize the critical section of file_lock in
Date: Wed,  3 Jul 2024 10:33:08 -0400
Message-ID: <20240703143311.2184454-1-yu.ma@intel.com>
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
pts/blogbench-1.1.0 has been improved by 28% for read and 12% for write
on Intel ICX 160 cores configuration with v6.10-rc6.

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

 fs/file.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

-- 
2.43.0


