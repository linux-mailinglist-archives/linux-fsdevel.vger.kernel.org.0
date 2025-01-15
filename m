Return-Path: <linux-fsdevel+bounces-39244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE8A11E05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64AD3AADB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E9320CCF1;
	Wed, 15 Jan 2025 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTKEqOtL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4505D248198;
	Wed, 15 Jan 2025 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933515; cv=none; b=YQKWOb2ESlkvdWFZ9tqS02OHOJtwsaP1kg5cNSRkDEa6Brxcnd6X2rRBLTWtbp/041ectWizdALA8v0Ws4cgY3uJUoQlcr7OxVgbIIh5jZnIH77rweqvyJ1jfrVGAWc/nV3U2h/asN+at0v4tSN0fQRWCPH92udoF2uhbFbO5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933515; c=relaxed/simple;
	bh=k2lsym+qDVzKv9xw6jXrzzrI1X1AkqT6RG6cr0mZKIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GoE727Xzz4Hv4Vtt1xATf2YtQ1JJEZ60HHsDwjuYNv9nne/ajjGe42JBfC4zQBeJrLYJhmA9HMh7nAcSTvxeHf9bZmUSOV25RGO6HFHjvp7UUVdNKvJyKXhVeI/H7JzSECF3pGrS6QRhSTIZQudyz9e1psCDVvhdQy3AwNMSlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTKEqOtL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736933514; x=1768469514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k2lsym+qDVzKv9xw6jXrzzrI1X1AkqT6RG6cr0mZKIk=;
  b=ZTKEqOtLgmEUUS6hhBKHZe/T/3CMiq9c2At5j0QXRV+l/rTa3qXM5bqA
   OeE80OkciODVb8/fVJGtx+ZPI7wiL6+U+cJrEUmGgutY910TIpfnFd4N7
   7t2c94jF3MqKirrjRXss9Rfdt6DdA0AxD3w8IVPD5QcH8YidxVisB9eIp
   UJRDeZgfc8Sa5vICKLEw5kujIENsxB98W1h+qUQOMPDegrlq8HezgW5mE
   d6JskQ1wnviHC1KRy7uJghw3wjjkvt89XWWhYIxyuSePJC+6qCEZY4aZR
   tXqU4N7cOAkDkvLZSGqry3Axz2ixUJGUS+uK1Z9Kn1TYhTjHkJra5zDIt
   A==;
X-CSE-ConnectionGUID: dPAW5H/iSIe0XqHd5Rc0JA==
X-CSE-MsgGUID: uiH+2vL/QNmjBZWXJM0lMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="41195042"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="41195042"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 01:31:51 -0800
X-CSE-ConnectionGUID: HG/PN139TYG9PTCef9M0Ww==
X-CSE-MsgGUID: 2NCfXhHxSjamavT8r97mJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109700830"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 15 Jan 2025 01:31:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 22B113B7; Wed, 15 Jan 2025 11:31:42 +0200 (EET)
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
Subject: [PATCHv2 00/11] Get rid of PG_reclaim and rename PG_dropbehind
Date: Wed, 15 Jan 2025 11:31:24 +0200
Message-ID: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com>
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

Once PG_reclaim is gone, we can rename PG_dropbehind to PG_reclaim.

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
 mm/truncate.c                             |   2 +-
 mm/vmscan.c                               |  28 +---
 mm/zswap.c                                |   2 +-
 tools/mm/page-types.c                     |   8 +-
 19 files changed, 65 insertions(+), 295 deletions(-)

-- 
2.45.2


