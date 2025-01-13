Return-Path: <linux-fsdevel+bounces-39020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB193A0B365
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCBD3A9725
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 09:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595928EC72;
	Mon, 13 Jan 2025 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvSeEOGB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD22284A45;
	Mon, 13 Jan 2025 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760926; cv=none; b=da9bAmVJJUBfNrlivqARplBKBFa/aQipq427xIToEVKdKP0ObUsyQjbag9mhx8z/pCKtJ38dAYQ5gfriNLqr+mXhP/uZCA8sw9BxUxiCwNLFhVM206sjnRScALhz4lKMKRKgrcOVliWTfgGthupR43RqsKR86k7VB+594RJ9pUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760926; c=relaxed/simple;
	bh=3isjMJSZcf5W5aeqy7AwK5YpbZSgqyLtVLMRx7T66oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+5vEn7PB/0SG6F5AvMtdqW825v3SpR8p9WZE7AGXHQf2OpO6G2RQAm+tp3JgbPTo5ZqvTuJv0bUlWxyZ+WuWnj1cBOyhgAuPu7wWYokmP2dIoECzXf+LleCvkbniRWJy1e7aauIJdS7AT6LPsg+lQJJcWchv1DmWkkvx2/eHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvSeEOGB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736760925; x=1768296925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3isjMJSZcf5W5aeqy7AwK5YpbZSgqyLtVLMRx7T66oQ=;
  b=QvSeEOGBJ0F8Fx8wqAQOsPKj4Xi4E6qZMtE4C419y7TsFNw6TlTbligM
   KZveoMSKY5Ys7txib29nJuMyOnBiMgF6AFLhUmojJDe2jY1wYqBWd71In
   QJ6oiFOAswK6boPKVrLC3GbY89oLoZscbB14sQFELqD46PfztfSj9Mvcz
   ljoQC+DeihxXbz2if3ms5EqdiBouuuql9ViPr1lgx0JBuhmSNH5m6vzFi
   1guDRCsUTrPlF36w/4ZuaUfVPyynJaFm3N4EIKh952hrSfDuhrsfBm1ZO
   w3jbK+UepG8mw5fe7OgnpoBAZpIVF6JKXZBw0hH6hA4ctkhhio6vxx+6m
   w==;
X-CSE-ConnectionGUID: x6zOWA5jTVqiRHGsLEtliQ==
X-CSE-MsgGUID: fuK67OxbQF2x1M9U8gznXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40949180"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40949180"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:35:22 -0800
X-CSE-ConnectionGUID: DEKeSvlxRkqbGVBH2c0tpg==
X-CSE-MsgGUID: e2AXZi8iSmWaz75vxHTbCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104303089"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 13 Jan 2025 01:35:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5EBCB4CA; Mon, 13 Jan 2025 11:35:04 +0200 (EET)
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
Subject: [PATCH 7/8] mm/mglru: Check PG_dropcache instead of PG_reclaim in lru_gen_folio_seq()
Date: Mon, 13 Jan 2025 11:34:52 +0200
Message-ID: <20250113093453.1932083-8-kirill.shutemov@linux.intel.com>
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

Kernel sets PG_dropcache instead of PG_reclaim everywhere. Check
PG_dropcache in lru_gen_folio_seq().

No need to check for dirty and writeback as there's no conflict with
PG_readahead anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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
2.45.2


