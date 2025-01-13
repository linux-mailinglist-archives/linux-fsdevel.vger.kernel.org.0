Return-Path: <linux-fsdevel+bounces-39018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BB5A0B354
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 10:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F1D7A2D34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 09:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED13284A68;
	Mon, 13 Jan 2025 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lr0cCryS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594B01FDA79;
	Mon, 13 Jan 2025 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760924; cv=none; b=EGKJNrmCGLKUH8ooYH3lkYRcusBcH27Zy5iGCsKmPYK8Qtyc1Atn+7vXTGM+LRuOGLXmZQOobweJr8RzXnfbU6iSVjnFymrJH66vZiyUYG2sDxqtVi6fdZGkEGeINX1jH+T+Kt9P5xxVkmCK6DlGMmkhQc9DUqkYqsuCrJ/Qto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760924; c=relaxed/simple;
	bh=jJrpfq76m3vQIYJgXgCzbJfE1zr1AyR7lITQuXNlGAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKmKv48VzzrUVzXx32oJr1iqSe64RQuC9MvlPis+sOXcfAWlZmSpPtnKXHRJOwja7cqjgHG1Yf4Vkuee1e6+h1kAcB3eYHQYX7pVfbeFFLC5n7/gUArf9hF89xUYGPFuWwNE8o1vzL0lKALVx+PL5Lc1OJOkgqdTqYgC8xhFQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lr0cCryS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736760923; x=1768296923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jJrpfq76m3vQIYJgXgCzbJfE1zr1AyR7lITQuXNlGAM=;
  b=Lr0cCrySQEBpF6ostdq758OR/yteAm0kbuHnzuj6Q/RaaZaa5cfa/E6m
   i5G1bssU0aBLskFiWgah6BXp2/3duK9drY3SdXo66b8nPynrf7ECic6Rx
   OKoWwNxWLFC9fAAuBFvQh59D1NOjFZgr5kz2aQ5fienC+DTyzEDHLTkSS
   MFKJxzkn+d6+UMU5nXqfhJMCfAjIpC/t6/Rcf8vjvT44vwehJiNngZHSl
   CoOjmpCaEB/mveV+WkuFzMJ98Kp/EwASIigIxqst/IYxbnjmI7KDxRxn6
   +mv7cPdEIWbxX98cuTLeqjLodJlgCo5uQYB2/t9c3rvIEIdyiu3srRh4N
   w==;
X-CSE-ConnectionGUID: PAiLr4KhTY2V68WsRKD7EA==
X-CSE-MsgGUID: K5OdnLYgTrS0vMlxDcwXyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40949103"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40949103"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:35:22 -0800
X-CSE-ConnectionGUID: iRfJD88RTbCEE7NJr+FuSA==
X-CSE-MsgGUID: 8qvuIIumQI6LRh7Z8DIP0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104303082"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 13 Jan 2025 01:35:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 45BE54AB; Mon, 13 Jan 2025 11:35:04 +0200 (EET)
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
Subject: [PATCH 5/8] mm/vmscan: Use PG_dropbehind instead of PG_reclaim
Date: Mon, 13 Jan 2025 11:34:50 +0200
Message-ID: <20250113093453.1932083-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recently introduced PG_dropbehind allows for freeing folios
immediately after writeback. Unlike PG_reclaim, it does not need vmscan
to be involved to get the folio freed.

Instead of using folio_set_reclaim(), use folio_set_dropbehind() in
pageout().

It is safe to leave PG_dropbehind on the folio if, for some reason
(bug?), the folio is not in a writeback state after ->writepage().
In these cases, the kernel had to clear PG_reclaim as it shared a page
flag bit with PG_readahead.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/vmscan.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a099876fa029..d15f80333d6b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -692,19 +692,16 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 		if (shmem_mapping(mapping) && folio_test_large(folio))
 			wbc.list = folio_list;
 
-		folio_set_reclaim(folio);
+		folio_set_dropbehind(folio);
+
 		res = mapping->a_ops->writepage(&folio->page, &wbc);
 		if (res < 0)
 			handle_write_error(mapping, folio, res);
 		if (res == AOP_WRITEPAGE_ACTIVATE) {
-			folio_clear_reclaim(folio);
+			folio_clear_dropbehind(folio);
 			return PAGE_ACTIVATE;
 		}
 
-		if (!folio_test_writeback(folio)) {
-			/* synchronous write or broken a_ops? */
-			folio_clear_reclaim(folio);
-		}
 		trace_mm_vmscan_write_folio(folio);
 		node_stat_add_folio(folio, NR_VMSCAN_WRITE);
 		return PAGE_SUCCESS;
-- 
2.45.2


