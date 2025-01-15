Return-Path: <linux-fsdevel+bounces-39250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC8BA11E04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC7E188C6A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2A12419FC;
	Wed, 15 Jan 2025 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VG9yvkoL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5DF1E7C27;
	Wed, 15 Jan 2025 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933523; cv=none; b=O1FHlPhusdFrTLJcsu7blUngzcs4uckr87tRTUHjpedkv+Kxm4jkGbWFRiniIw/F97XGD0YkhfVncwhm2cNdStsW/h2BtE9UrPsgH0k8kJDefxR4A4yhqvvPm0IRUU1nhMLamIXsHPTilaRwsRvnGl1zme9T3m+Z+1eurMffcow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933523; c=relaxed/simple;
	bh=3jpMLKGipPEs+ffoK+nnTQL9X98v+QvM54TECel1oaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=co6qwiL8Vc2FqCfZ5ijzSLSJUIR6J8otgznJoDQZ6ljeoBalcSn0wn7AMWEbC7ZRTcX2rtsTE0lRfpZIpc3Rk/+edHkkFceFMwgZnjxC7PlyUm4ZLmEJaynq0zjn9gWo9IGtq8a8XeddHh7+2/SHHGetxP37Ht3hWAdhI79ngBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VG9yvkoL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736933522; x=1768469522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3jpMLKGipPEs+ffoK+nnTQL9X98v+QvM54TECel1oaE=;
  b=VG9yvkoLurJ6VioDqyzMDlWp72wbazM94F5dixkrjUCXz9OAhBNzinNL
   cpLjhIIjjYDs4TwqytljxHdQUsHxJl8eU4kQnin/zSXsElPK8AJIsHkLI
   US8OpZuOhAb5CVJKttiJcCccrZWF8ZgEG68mRn6zLO4KX4JYUmunuWZh5
   E2sVU8eigNO++NLw4nAHyhayCT2nJ3CQK1ho1drvMJDmhR9UOsyELVL9O
   NDVBuDrEBrJQPUj+0HVSs0nQJ07CAj/I3iXfHO6blnElbfjzONebiu3ar
   L3yoxkhHWbi8sFMyEJ4/G9dqk3031Y4lEx6kE5xodecUdzrXXLXMnNoCn
   Q==;
X-CSE-ConnectionGUID: hYdSIptNTYuxTT9rFBU/+Q==
X-CSE-MsgGUID: p41wjBrYQmKIdY8/9Itecg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="41195168"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="41195168"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 01:32:00 -0800
X-CSE-ConnectionGUID: aK+Z+lJOSQiu5q7r0uSE2w==
X-CSE-MsgGUID: 8MOy57zKRiuhPkJ/vx+WqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109700880"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 15 Jan 2025 01:31:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7E9F34CA; Wed, 15 Jan 2025 11:31:42 +0200 (EET)
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
Subject: [PATCHv2 06/11] mm/vmscan: Use PG_dropbehind instead of PG_reclaim
Date: Wed, 15 Jan 2025 11:31:30 +0200
Message-ID: <20250115093135.3288234-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com>
References: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com>
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
Acked-by: David Hildenbrand <david@redhat.com>
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


