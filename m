Return-Path: <linux-fsdevel+bounces-39015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F12A0B344
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 10:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFE316156E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3FF246347;
	Mon, 13 Jan 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcoapG7Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092FF2451D9;
	Mon, 13 Jan 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760917; cv=none; b=QY3AuhGgWkyHomn9KWPK6tepsYL+ELJgW4j/HB2M7zCGusjub9qa4irv+ROI0Wzx/FiE9xoC0KXMY168et95k4QeDpvZgclaoyMkqo34PjHv4UGizkpxjAci5RCvINx1XMjiFSruO1omaFMLi29kWLLwzGscISeVSSMDmC9E0Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760917; c=relaxed/simple;
	bh=TNGXRP92KylfjqEnTf2oSTorm8trBrBBqsU1BaNYJWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtBrZpMpnixxinV0FHoyOUv3O0SG+O+NYF5gnmbkoFWPAiyHexduSQQUSjXdRvp6io0gMcDtN00WGuLbOp/crDqfy4MUxez0AMTDs8wjUqDRfyY2My1qcYAMYgFGzpT6frpf7fy2eLyhjYZXr/vieXPlElB7ftU9LELB9NZeyGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcoapG7Y; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736760916; x=1768296916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TNGXRP92KylfjqEnTf2oSTorm8trBrBBqsU1BaNYJWE=;
  b=mcoapG7YL5EHWHvDwl98wyR5rqsj9iLCcYmnBtm81KGhNfdtpc2V9CU8
   KrXJc8tMOZdPzY2jIQGbaoZgIiAUicMJx/GAsN8EWaS3O+iZ1Yq6yJL78
   ga7CZEeLKKL1YlZUs9sCWvKSbeykZ0czJdcSVoCAE+UYOvfrp1pPuQvWz
   4uSJb8t//Ucbm2DL0eeHzlNDipam7hnov1JW/M2JaOXXl2I6GiMhAGme4
   KLTGyVm3xpOJBNBpyzc97KSmAutPswV52U8Vuy3WFSDUM86b2BZ9OMQ0o
   /R7artYlSsQjIbfWmO1L5Dh+MNyzotjPq64xsPlWp9s/2lkjaWQgiq0hC
   w==;
X-CSE-ConnectionGUID: /XQcScogTX+YCZpiRbDHuw==
X-CSE-MsgGUID: bxNGXVAlQJu7c2zvnJgz9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40948981"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40948981"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:35:13 -0800
X-CSE-ConnectionGUID: T7ipL8kBRZeAxUscMfKfog==
X-CSE-MsgGUID: WowDcJsZQ9SogBXqcgQJLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104586351"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 13 Jan 2025 01:35:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 34FF949D; Mon, 13 Jan 2025 11:35:04 +0200 (EET)
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
Subject: [PATCH 4/8] mm/swap: Use PG_dropbehind instead of PG_reclaim
Date: Mon, 13 Jan 2025 11:34:49 +0200
Message-ID: <20250113093453.1932083-5-kirill.shutemov@linux.intel.com>
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
lru_deactivate_file().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/swap.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index fc8281ef4241..4eb33b4804a8 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -562,14 +562,8 @@ static void lru_deactivate_file(struct lruvec *lruvec, struct folio *folio)
 	folio_clear_referenced(folio);
 
 	if (folio_test_writeback(folio) || folio_test_dirty(folio)) {
-		/*
-		 * Setting the reclaim flag could race with
-		 * folio_end_writeback() and confuse readahead.  But the
-		 * race window is _really_ small and  it's not a critical
-		 * problem.
-		 */
 		lruvec_add_folio(lruvec, folio);
-		folio_set_reclaim(folio);
+		folio_set_dropbehind(folio);
 	} else {
 		/*
 		 * The folio's writeback ended while it was in the batch.
-- 
2.45.2


