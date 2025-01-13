Return-Path: <linux-fsdevel+bounces-39016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D7CA0B33C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 10:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B5818847E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3BC23ED6A;
	Mon, 13 Jan 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qs2KpbwK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077E2451EB;
	Mon, 13 Jan 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760918; cv=none; b=SnC5xYsRTRlcZY8HEeFz9UkRWRtmfARS159Q3OAhBcMWk1mQVBFfDaZVf73dzcCi/Ll5a8P9pm90768jWzUm+vsl+HmteY9WlbuUPQU9XfdVtPgc/OvkLsK4gfqxVCYJEhexBivvJxvl4xlPgAr7kuDBOfksnjOQb+XdXx3HJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760918; c=relaxed/simple;
	bh=nqaz5kf8Gpr2/PYun8USq2ScAPkS+nRLzWA5DTmPKfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VakWkV3fffIuMkIYLo04lKnFBy82iE972zZHPbtbRDHyQg6iafoPyRF+n82hhynpnvb9eGh+mIa35WLD+v7tKZLi+s6qejaEBrB638k6DXs8Cm6WAPN5CS8gxi0t2K5by98iNkm2nV4Jp0YH2JlH2c0sYHEkj38jAeZwbG2M8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qs2KpbwK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736760916; x=1768296916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nqaz5kf8Gpr2/PYun8USq2ScAPkS+nRLzWA5DTmPKfY=;
  b=Qs2KpbwKTawGG7wR4EZ6arUi88dMU7vpBRyNjZcM/ebO54IJW2mnTDV0
   5UhXS/lwJ84NoEjQbUyqW1zAmq9/5ONIHofLJ32mgMuAyB4aE0/43EVpG
   +SptjzUeju9GTI3uliT4ItFuiBvH8MOFCVMbquZT/SI7sVIHJZyzwscXW
   2WWdSbypg5hnyFDhhb1mTsrWbiRV2vv3tgoOww09yde5diIsOR4xtr7Bq
   ayYdc5i0sFnrqAQsaeHLdWmPAuZzcpmc/2tUHlOqLoYP4QLK+i+46ckQ6
   pdahEOQbAa12uOngGsYv9hWOZb6WOas1FBBz6OEW+PwjQgIc5f/TNqx6m
   g==;
X-CSE-ConnectionGUID: MFZWRxAsTSO+3xm6vDl3mQ==
X-CSE-MsgGUID: H209TU3iTy6NXWXTuIg50w==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40949003"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40949003"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:35:13 -0800
X-CSE-ConnectionGUID: YHvab8AHTZap7Fid/vX1Ng==
X-CSE-MsgGUID: dIYjIwIASBqXwJo6gSbPrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104303071"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 13 Jan 2025 01:35:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E68D8331; Mon, 13 Jan 2025 11:35:03 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Airlie <airlied@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Hao Ge <gehao@kylinos.cn>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Nhat Pham <nphamcs@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosryahmed@google.com>,
	Yu Zhao <yuzhao@google.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/8] mm: Remove PG_reclaim
Date: Mon, 13 Jan 2025 11:34:45 +0200
Message-ID: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use PG_dropbehind instead of PG_reclaim and remove PG_reclaim.

After removing PG_relcaim, PG_readahead is exclusive user of the page
flag bit.

Kirill A. Shutemov (8):
  drm/i915/gem: Convert __shmem_writeback() to folios
  drm/i915/gem: Use PG_dropbehind instead of PG_reclaim
  mm/zswap: Use PG_dropbehind instead of PG_reclaim
  mm/swap: Use PG_dropbehind instead of PG_reclaim
  mm/vmscan: Use PG_dropbehind instead of PG_reclaim
  mm/vmscan: Use PG_dropbehind instead of PG_reclaim in
    shrink_folio_list()
  mm/mglru: Check PG_dropcache instead of PG_reclaim in
    lru_gen_folio_seq()
  mm: Remove PG_reclaim

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 18 ++++-----
 fs/fuse/dev.c                             |  2 +-
 fs/proc/page.c                            |  2 +-
 include/linux/mm_inline.h                 |  4 +-
 include/linux/page-flags.h                | 15 +++-----
 include/trace/events/mmflags.h            |  2 +-
 include/uapi/linux/kernel-page-flags.h    |  2 +-
 mm/filemap.c                              | 12 ------
 mm/migrate.c                              | 10 +----
 mm/page-writeback.c                       | 16 +-------
 mm/page_io.c                              | 15 +++-----
 mm/swap.c                                 | 24 +-----------
 mm/vmscan.c                               | 46 ++++++-----------------
 mm/zswap.c                                |  4 +-
 tools/mm/page-types.c                     |  8 +---
 15 files changed, 41 insertions(+), 139 deletions(-)

-- 
2.45.2


