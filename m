Return-Path: <linux-fsdevel+bounces-40370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279B4A22B22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 11:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01EC1888C33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 10:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105BD1C1735;
	Thu, 30 Jan 2025 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2g8mI7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C81B4137;
	Thu, 30 Jan 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231282; cv=none; b=VJE4F5HTmGfpVEgId2dOu2osgcRqc+UkK1krr7OAKJw3Fbl0tdvWr+0PKeZoFFgHeYZaJ2G+p9HBho3NQ8BhlTZkBguDQg10T/NuHPr36XMRxcAU8CpFES02m6pLmhDXYQ2hVKC3Mqbmg7o/vlprBRpLFceODgIj0CMkwmB+r1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231282; c=relaxed/simple;
	bh=uLTdxStt6zGk69qmkf/XPay7U8WHi9X9PLQpdfC8JxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFSGv5gdIRdv1ywlfI7dw9IUwjBbt7Y2KnfGVVOkhUCHjEgTOi9LfG8oowjHxsegHLXy7vhTx35Qwd0adLfun0SUXgfSrZV3I4QEI9abWxqzqdsJ9OGyenvKYScTtZbHk/QxY2NzGuLa8R5rMQROIZLFlynTFyD8Fulbw+5f5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2g8mI7n; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738231281; x=1769767281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uLTdxStt6zGk69qmkf/XPay7U8WHi9X9PLQpdfC8JxI=;
  b=F2g8mI7n1MteL7B5pladNsMa/QtVLZn7vRgumyviBWZvAVaiW90y+kFX
   AVyVBHkPWWIqFSni5Xm0HrIdugv1ihAV4PR6JCxrrbRrv2AOY3U9Y2KzN
   ef+trr+8GgivXpt0v9x/lImlftpWgNy4/LRVtIT8bUjXjP+HnzcZrxzRR
   gLW9whlFIM6asplw80P0/4Ctrbt1+7mPfWgHA/HlpiUjin32m+YzyMU6U
   3KDuDyxpjn8JK5KCEKUJh+96CEiV1B/4QOyuPC/ZJIgH7b2UfAxjOdhYM
   eEtrk6NCPnuOFOhMPL+AwajMzCl2YQrbxlMrRHexgc5fspDj1rCj7heZ3
   g==;
X-CSE-ConnectionGUID: fwKWjDEdRkGnA6B3zlyorw==
X-CSE-MsgGUID: P2jxd3tlSBqefbbXaByZ2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="42692515"
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="42692515"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 02:01:20 -0800
X-CSE-ConnectionGUID: wYzGPc89R8eirclNmiOixw==
X-CSE-MsgGUID: RqbTJ6J0Tra8rd9Soq9qMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="114263384"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 30 Jan 2025 02:01:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id F3C4A18B; Thu, 30 Jan 2025 12:01:01 +0200 (EET)
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
Subject: [PATCHv3 07/11] mm/vmscan: Use PG_dropbehind instead of PG_reclaim in shrink_folio_list()
Date: Thu, 30 Jan 2025 12:00:45 +0200
Message-ID: <20250130100050.1868208-8-kirill.shutemov@linux.intel.com>
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
shrink_folio_list().

It is safe to leave PG_dropbehind on the folio if, for some reason
(bug?), the folio is not in a writeback state after ->writepage().
In these cases, the kernel had to clear PG_reclaim as it shared a page
flag bit with PG_readahead.

Also use PG_dropbehind instead PG_reclaim to detect I/O congestion.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/vmscan.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c97adb0fdaa4..db6e4552997c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1140,7 +1140,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * for immediate reclaim are making it to the end of
 		 * the LRU a second time.
 		 */
-		if (writeback && folio_test_reclaim(folio))
+		if (writeback && folio_test_dropbehind(folio))
 			stat->nr_congested += nr_pages;
 
 		/*
@@ -1149,7 +1149,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 *
 		 * 1) If reclaim is encountering an excessive number
 		 *    of folios under writeback and this folio has both
-		 *    the writeback and reclaim flags set, then it
+		 *    the writeback and dropbehind flags set, then it
 		 *    indicates that folios are being queued for I/O but
 		 *    are being recycled through the LRU before the I/O
 		 *    can complete. Waiting on the folio itself risks an
@@ -1173,7 +1173,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 *    would probably show more reasons.
 		 *
 		 * 3) Legacy memcg encounters a folio that already has the
-		 *    reclaim flag set. memcg does not have any dirty folio
+		 *    dropbehind flag set. memcg does not have any dirty folio
 		 *    throttling so we could easily OOM just because too many
 		 *    folios are in writeback and there is nothing else to
 		 *    reclaim. Wait for the writeback to complete.
@@ -1190,30 +1190,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (folio_test_writeback(folio)) {
 			/* Case 1 above */
 			if (current_is_kswapd() &&
-			    folio_test_reclaim(folio) &&
+			    folio_test_dropbehind(folio) &&
 			    test_bit(PGDAT_WRITEBACK, &pgdat->flags)) {
 				stat->nr_immediate += nr_pages;
 				goto activate_locked;
 
 			/* Case 2 above */
 			} else if (writeback_throttling_sane(sc) ||
-			    !folio_test_reclaim(folio) ||
+			    !folio_test_dropbehind(folio) ||
 			    !may_enter_fs(folio, sc->gfp_mask)) {
-				/*
-				 * This is slightly racy -
-				 * folio_end_writeback() might have
-				 * just cleared the reclaim flag, then
-				 * setting the reclaim flag here ends up
-				 * interpreted as the readahead flag - but
-				 * that does not matter enough to care.
-				 * What we do want is for this folio to
-				 * have the reclaim flag set next time
-				 * memcg reclaim reaches the tests above,
-				 * so it will then wait for writeback to
-				 * avoid OOM; and it's also appropriate
-				 * in global reclaim.
-				 */
-				folio_set_reclaim(folio);
+				folio_set_dropbehind(folio);
 				stat->nr_writeback += nr_pages;
 				goto activate_locked;
 
@@ -1368,7 +1354,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			 */
 			if (folio_is_file_lru(folio) &&
 			    (!current_is_kswapd() ||
-			     !folio_test_reclaim(folio) ||
+			     !folio_test_dropbehind(folio) ||
 			     !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
 				/*
 				 * Immediately reclaim when written back.
@@ -1378,7 +1364,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 				 */
 				node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
 						nr_pages);
-				folio_set_reclaim(folio);
+				folio_set_dropbehind(folio);
 
 				goto activate_locked;
 			}
-- 
2.47.2


