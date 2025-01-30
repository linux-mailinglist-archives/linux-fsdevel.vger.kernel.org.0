Return-Path: <linux-fsdevel+bounces-40371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1509A22B26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 11:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8A3165A4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4ED1DDC03;
	Thu, 30 Jan 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeDbI2ao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B011B425D;
	Thu, 30 Jan 2025 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231283; cv=none; b=W5r68BlcgEzgA+9AIZEzDaqrM0UnocJdfwnR4p5rrW/IUtDW7iBjCDK5ZUbsUSNRWGQ+xQ0603vS+jdaj3T6K2owUaOB29CH3wGZEQYAlEQZt/4WH1WBP+GbXqAk+zcUjRsOdXloo0J5bOZ3m4r9V0UOUNyfwYeutJYXBENcsLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231283; c=relaxed/simple;
	bh=5OJMCwKJ2eiQBjQpL5TDjVdfD5oQ07qBePa+QeSVgXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac6j8bYOoRLGHoOHu9eJKxdlTXsO0DvhYEFyegzIz5H4mPEmCydUa/UCg5Q/YSaEakx4kk0G8lDNFuX6cWtPdZvyRGTrr8xCHhJtpU4STHX3KEL1lN9p2f9gV6g9uUWrkZg8O263hzQi06VT/7plx4y0b1IQMkqxkO2OznjHdL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeDbI2ao; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738231282; x=1769767282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5OJMCwKJ2eiQBjQpL5TDjVdfD5oQ07qBePa+QeSVgXo=;
  b=jeDbI2aoQBJ56onr6pZv68w4XRSrZ5RyhFbj2pwY2Uyl40MYZtI2PHxl
   dQwz7fEXtYTE5H0rILfEQMZUH76CmDrmAh+unn14CZSWW6Mb1DEc1u3sC
   vn2/3R+NkyOJZA63oRENt3NotZzQ9Oe/pgKABDiQnNLOt+7gEGUzCCGen
   SrbwNO6+etIINWCnZEBDD29Zrx5xrBFPgQNzoxQS72UY9lSjiU/2RmfcT
   JwA8fnXHtdIwIdJQ51vNUExgFi1fApnSAQzgYWjUTlS0nUgk/olZd1k67
   77mBlG192kqBjmo7h3oZJJxLpYJO39yGG+pImtl360wN7/Sutk0k4Ot+x
   A==;
X-CSE-ConnectionGUID: JzQ20m04RN6SYCyk/djVxw==
X-CSE-MsgGUID: YzI7jntdQ5+5s4rLob/ePA==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="49752432"
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="49752432"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 02:01:19 -0800
X-CSE-ConnectionGUID: g5p59eYbT7GNX0T7qHuo1g==
X-CSE-MsgGUID: +zRYybF/S9iMPoERKTw43Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="109187922"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 30 Jan 2025 02:01:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0944C1B2; Thu, 30 Jan 2025 12:01:02 +0200 (EET)
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
Subject: [PATCHv3 08/11] mm/mglru: Check PG_dropbehind instead of PG_reclaim in lru_gen_folio_seq()
Date: Thu, 30 Jan 2025 12:00:46 +0200
Message-ID: <20250130100050.1868208-9-kirill.shutemov@linux.intel.com>
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

Kernel sets PG_dropcache instead of PG_reclaim everywhere. Check
PG_dropcache in lru_gen_folio_seq().

No need to check for dirty and writeback as there's no conflict with
PG_readahead anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_inline.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f9157a0c42a5..f353d3c610ac 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -241,8 +241,7 @@ static inline unsigned long lru_gen_folio_seq(struct lruvec *lruvec, struct foli
 	else if (reclaiming)
 		gen = MAX_NR_GENS;
 	else if ((!folio_is_file_lru(folio) && !folio_test_swapcache(folio)) ||
-		 (folio_test_reclaim(folio) &&
-		  (folio_test_dirty(folio) || folio_test_writeback(folio))))
+		 folio_test_dropbehind(folio))
 		gen = MIN_NR_GENS;
 	else
 		gen = MAX_NR_GENS - folio_test_workingset(folio);
-- 
2.47.2


