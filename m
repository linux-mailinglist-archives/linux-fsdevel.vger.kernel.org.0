Return-Path: <linux-fsdevel+bounces-40369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F00A22B25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 11:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A0C3A8A37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEEC1C07F3;
	Thu, 30 Jan 2025 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQxglEDO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C91B415E;
	Thu, 30 Jan 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231282; cv=none; b=Y6cJ1wxcLkvdi2HYdh7OXXM5rM2oo0wawv0BqiVhFgNl9XGF77MiiMTqPgU4SY+vOWGN0a4yzIlOD6cwzWiawwMkaiw1fdvTMVuryjbe/DFlz4/k6I+ZONiaLGGrtxZnYZInvocfRs0irvg1DcoqyDV6QiqrLH/rYoVVaU+0jWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231282; c=relaxed/simple;
	bh=ZCQ7ik+9XW25QHmj7+OSEt8uhXHwRm2WWtAH03zqXic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfGzJ+ZhcbeUlXeMnyNNAt3ei32DV9LoUlJL4ZFPiCZlS6XSQQiHUPQr3rVb8gv50DadFqW9cMXqU5ButGxU2gVU9xWks6PG8u3ni6+Qld7gopHrrdy9mEIM3NEMQA1t+O/984v1/oImiVm99tHGaKbaJYIHaq4U+D03G/Qp/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQxglEDO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738231281; x=1769767281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZCQ7ik+9XW25QHmj7+OSEt8uhXHwRm2WWtAH03zqXic=;
  b=TQxglEDOcpbkVGb76c23U0i1pFN6y5APNDbwN8rbHyLDVoT6k3L3w+eL
   Vb+E6TY+3OYn+Atho2ZasulhYLmWus6Js9yBA4kRmHd5ed/UVADF/KvtR
   E15HSlORLrSI3KU9l823IBRvZTToi4OpsbqsaZyQHcivq+lFOnpvKrS7b
   NY6H4nzwJY6JNxNTEPFvj2iOD98wdEwo3O+vGxynVhK19kdBJMmoLZ+gx
   6Ns6ZxA8/kMJSHsVl6x3JwRQ/XRaFmqBibv+YeRi03QmmX0CvSUbDHI2J
   c8N5hDuBsp1JdhRACjXbQC9EQVagvw90GeJ95G5DLjykMkyAJULgs8zxh
   Q==;
X-CSE-ConnectionGUID: IoI40siMTYudmnFkqxNSOA==
X-CSE-MsgGUID: oSJGZcT6TkOMCaeRBiJmTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="49752400"
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="49752400"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 02:01:19 -0800
X-CSE-ConnectionGUID: 8Ns0yl4eSvC8UZgQ8nbSkg==
X-CSE-MsgGUID: lldpXDwSSe61zLr95B6law==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="109187920"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 30 Jan 2025 02:01:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id EA239168; Thu, 30 Jan 2025 12:01:01 +0200 (EET)
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
Subject: [PATCHv3 06/11] mm/vmscan: Use PG_dropbehind instead of PG_reclaim
Date: Thu, 30 Jan 2025 12:00:44 +0200
Message-ID: <20250130100050.1868208-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
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
index bc1826020159..c97adb0fdaa4 100644
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
2.47.2


