Return-Path: <linux-fsdevel+bounces-40377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B827DA22B31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 11:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB67188485B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 10:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA25C1BEF8F;
	Thu, 30 Jan 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqKJfFIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E61BD000;
	Thu, 30 Jan 2025 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231334; cv=none; b=QAmCgBnhWZgT33sC75fbwHBCDCLUD5vzOPbwSkgW7Ze+/cVIG8T+EsDMhgeEQEJ0j/s4QGBypWMpl0b6VEWf71bTdCyxsZdXXc2RC5sUJ2hwPOzvhNYsH4W73+9MA2dGE2c6DOzFium3iaqgIxh9HFOhRxV8urBlzbESHkZrQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231334; c=relaxed/simple;
	bh=+dyUpBxVjxCxLu9VSrPpXrjdtVNMDemhFMBW2Yfb6UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7+qjvlP4FuveJMPmwznPZMxVp2R7ilXWSOQkRYkYlL4/EIm5Ebq3o1l2vp3peWl6Dymb3QiaN0+qmngfKR1OHl9DUSaoksssFn+LTaifySRJg+01vNmbkTu1yraXVxtx/hB0CzlPW1oJ0CywOqM096dEKwTcm1k+VDBSFzgb1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqKJfFIc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738231333; x=1769767333;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+dyUpBxVjxCxLu9VSrPpXrjdtVNMDemhFMBW2Yfb6UQ=;
  b=bqKJfFIcj1hwQEa+sFVtLh5RmwnVKI18x3+C80BAOhq3T9/zP7a2Gq5O
   TNM95k+48XDhQLGwDgqmw3AqrB7re/NhimtPR26L7gJ0HbH0t3K4SmYBF
   8PygIJAaKFMh6I3BF9lzL+GvlbIsFUG2BAGFvk++KBJw1e9k1H2Usvhiq
   q4L7Cr+WCGpUwOlqzlDM5ogJLfZ8LW0TvgDAhixwA2xeX2JrHerUNV/dv
   S1RBegw1yqfkKqOJPZ2afPg3D1t1dbkp+bMmYRj6hXBqfUCqZiTi05NtY
   hW3Ph+V9bAv+KMG1xgpVlfXpuoakfq5bHhhxmHY1NiZWPUYLX4AjT7vMB
   w==;
X-CSE-ConnectionGUID: IwrCgt8uTOmwO0Tj55DBlA==
X-CSE-MsgGUID: uDs6k4B9Q36oHJ58tmpOEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38648251"
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="38648251"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 02:02:11 -0800
X-CSE-ConnectionGUID: nEIQsW3gTXeR6VDwGD3hYA==
X-CSE-MsgGUID: 7L+VJ1VeTHWT7VMDRV9KSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140161517"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 30 Jan 2025 02:01:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 84483E1; Thu, 30 Jan 2025 12:01:01 +0200 (EET)
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
Subject: [PATCHv3 00/11] Get rid of PG_reclaim and rename PG_dropbehind
Date: Thu, 30 Jan 2025 12:00:38 +0200
Message-ID: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
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

Once PG_reclaim is gone, we can rename PG_dropbehind to PG_reclaim.

v3:
  - Condition folio_set_dropbehind() call in mapping_try_invalidate() on
    !unevictable and !mapped;
  - Add Reviewed-by tag by Yu Zhao;

Kirill A. Shutemov (11):
  mm/migrate: Transfer PG_dropbehind to the new folio
  drm/i915/gem: Convert __shmem_writeback() to folios
  drm/i915/gem: Use PG_dropbehind instead of PG_reclaim
  mm/zswap: Use PG_dropbehind instead of PG_reclaim
  mm/truncate: Use folio_set_dropbehind() instead of
    deactivate_file_folio()
  mm/vmscan: Use PG_dropbehind instead of PG_reclaim
  mm/vmscan: Use PG_dropbehind instead of PG_reclaim in
    shrink_folio_list()
  mm/mglru: Check PG_dropbehind instead of PG_reclaim in
    lru_gen_folio_seq()
  mm: Remove PG_reclaim
  mm/vmscan: Do not demote PG_dropbehind folios
  mm: Rename PG_dropbehind to PG_reclaim

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  18 ++-
 fs/fuse/dev.c                             |   2 +-
 fs/proc/page.c                            |   2 +-
 include/linux/mm_inline.h                 |  18 +--
 include/linux/page-flags.h                |  23 ++--
 include/linux/pagemap.h                   |   2 +-
 include/trace/events/mmflags.h            |   4 +-
 include/uapi/linux/kernel-page-flags.h    |   2 +-
 mm/filemap.c                              |  46 +++----
 mm/internal.h                             |   1 -
 mm/migrate.c                              |  14 +-
 mm/page-writeback.c                       |  16 +--
 mm/page_io.c                              |  15 +--
 mm/readahead.c                            |   4 +-
 mm/swap.c                                 | 153 +---------------------
 mm/truncate.c                             |   5 +-
 mm/vmscan.c                               |  28 +---
 mm/zswap.c                                |   2 +-
 tools/mm/page-types.c                     |   8 +-
 19 files changed, 68 insertions(+), 295 deletions(-)

-- 
2.47.2


