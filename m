Return-Path: <linux-fsdevel+bounces-39249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC38A11E01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08711695BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D812419F6;
	Wed, 15 Jan 2025 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KecdHtCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E01AB533;
	Wed, 15 Jan 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933523; cv=none; b=V4ke93ikc8K9ahXqtKL50+V0yTuJw42C5zllpt5LYvjvkhWGbalkc81GwlmUJpscuz97musZewnRnoWn3yWf+nDK6pfhguvqM9D8b3ZB5+K7jyj8wRMxrN2JHMMO7oRXMx+OJIIophvTU37bHjqaOTJuH0MRG154jGgIImeGWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933523; c=relaxed/simple;
	bh=fPl/3uszqP/MJsjmU538XrAMkh1t/gARp9Ryfe4CQVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ba6s+I9VoKJ6wSMHa8fvRA3Bh473Ja9zPIohFUmRjAEVDeKDclaVrFvM4hYkx/Bmo41EEpl2BhBBHjzphc6tcp06Td0Vfimrb2wpipDdaggEmi0DdyCmD4VFSJLvcnOkPyiVVRrhdvqKy3L2S917YmUL0jgEUDM7kYBL9Z4HpV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KecdHtCS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736933522; x=1768469522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fPl/3uszqP/MJsjmU538XrAMkh1t/gARp9Ryfe4CQVc=;
  b=KecdHtCSeOjTuxYhOX8dFlVsRhYTSvUMad9UW1AaB1CaHVj/PNlXZXxl
   ghe1fcJZm7FmNiisGzfs7i+MrW++fPMVUcfepDqF5easGaCyb8MxbDBWb
   6MGfM4V//zHRqjpPkO7lO708Z6ZSxS+udrBjlCG0zjOBDI1PyRwlZBEXU
   uwk+Z7hgtw+6+EWaSK6VvOg0bUmES9UG9H2XWfRvxkm4ubp0pYvA9GAbp
   kgfYZgm5abOUpZQyLrP3DYM5/p4Crr2duZq6P5PCdzS9W+KSJEBCSlDLA
   b8XmI5NSo5i26TWAK8ueAsndYLHXngxsmwtdxALX4JfdZtz6z3Tt8SeD9
   g==;
X-CSE-ConnectionGUID: l8Ba/gnZSOOowgVAhZIb6g==
X-CSE-MsgGUID: N7CDWstgRi2RQVY1/vrYNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36540242"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="36540242"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 01:32:01 -0800
X-CSE-ConnectionGUID: +suySKEDRgueK6JuCHJvFg==
X-CSE-MsgGUID: gIRIFIkaRY2UOYWbdzUmkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="105153452"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 15 Jan 2025 01:31:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8F3E95D8; Wed, 15 Jan 2025 11:31:42 +0200 (EET)
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
Subject: [PATCHv2 07/11] mm/vmscan: Use PG_dropbehind instead of PG_reclaim in shrink_folio_list()
Date: Wed, 15 Jan 2025 11:31:31 +0200
Message-ID: <20250115093135.3288234-8-kirill.shutemov@linux.intel.com>
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
index d15f80333d6b..bb5ec22f97b5 100644
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
@@ -1174,7 +1174,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 *    would probably show more reasons.
 		 *
 		 * 3) Legacy memcg encounters a folio that already has the
-		 *    reclaim flag set. memcg does not have any dirty folio
+		 *    dropbehind flag set. memcg does not have any dirty folio
 		 *    throttling so we could easily OOM just because too many
 		 *    folios are in writeback and there is nothing else to
 		 *    reclaim. Wait for the writeback to complete.
@@ -1193,31 +1193,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
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
 			    !may_enter_fs(folio, sc->gfp_mask) ||
 			    (mapping && mapping_writeback_indeterminate(mapping))) {
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
 
@@ -1372,7 +1358,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			 */
 			if (folio_is_file_lru(folio) &&
 			    (!current_is_kswapd() ||
-			     !folio_test_reclaim(folio) ||
+			     !folio_test_dropbehind(folio) ||
 			     !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
 				/*
 				 * Immediately reclaim when written back.
@@ -1382,7 +1368,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 				 */
 				node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
 						nr_pages);
-				folio_set_reclaim(folio);
+				folio_set_dropbehind(folio);
 
 				goto activate_locked;
 			}
-- 
2.45.2


