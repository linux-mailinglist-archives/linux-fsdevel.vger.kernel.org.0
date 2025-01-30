Return-Path: <linux-fsdevel+bounces-40376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43312A22B30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 11:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A1C1889AF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A52F1BD9DB;
	Thu, 30 Jan 2025 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFmEoazA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A61B87F8;
	Thu, 30 Jan 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231332; cv=none; b=POtBIoEd/H6iSCYy3DxrpC88MjuUEOos9zrSD2tMxAOS5St1kRvo+l2PdyZIhU0ppPUNNzBvJ2deQ2lMBMHM6DZXrblSkteVFxZJB2b/m6eRuhGNp0rSmDLm3Q1xYbFhlBeGtjeYzh4r2J0catScI/FOAVsEW7EprbRkwYqtavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231332; c=relaxed/simple;
	bh=aS6HpbmyxvbjmHbJmaZLMg1p+vRZnZDTOx85EKv2YcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZDBn0rBgH1bOSEEP56UPSN7MC1iHtWb1eyRdalkUgZDq5m8jMNNSB717BMkFrQoVJmIC0OmBU1AkTSBYXtGCHDmWEJ7E5ceBifH0mJE903OyIei7dJupeClodHyiQtQcZ1FcFNzxWvUqZvcCKGWrRJrFlP4XNGXgSL0cYDZ964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFmEoazA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738231332; x=1769767332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aS6HpbmyxvbjmHbJmaZLMg1p+vRZnZDTOx85EKv2YcA=;
  b=BFmEoazAp4vJSom91wSLJnmnzRbIMcl9RACEd/gSHR1a2PlSbEuUoKL9
   bnNXij3srtvpIp30Zu2Rzb68YDvU1qzerDTh+hsA+pxpEZWg9XVj8OqIc
   i3crgHCIlT08JdUPawhF5v3tp9mQSxdErHRdsuhdgOeuQPIHKxXej2pa/
   a+vb6xmwBsBQdRurvVyD8QxRd/mmiUWKBpOKESQEq+0gzQzJjMcJ2N81M
   L62MEDYohHhxYZTT32ixAweLagx15eP4LmBv8h0tOwQ+xjJ1UTQpkfHGn
   mFx0xM/Zcbptym9Qp9xwptddzTj0RZleIaVtErFUBSLTxTa5xm5OyYNxh
   w==;
X-CSE-ConnectionGUID: 38wjL2A/ST6+HQPwKjz8NA==
X-CSE-MsgGUID: Vu7Kql7qQX+4LhLGt7DvBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38648220"
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="38648220"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 02:02:11 -0800
X-CSE-ConnectionGUID: FEElXW6TTEKqjuklFWBz5g==
X-CSE-MsgGUID: 8dwYoa7wR4mkal0gKBUanA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140161515"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 30 Jan 2025 02:01:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id CD0ED116; Thu, 30 Jan 2025 12:01:01 +0200 (EET)
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
Subject: [PATCHv3 04/11] mm/zswap: Use PG_dropbehind instead of PG_reclaim
Date: Thu, 30 Jan 2025 12:00:42 +0200
Message-ID: <20250130100050.1868208-5-kirill.shutemov@linux.intel.com>
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
zswap_writeback_entry().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 6504174fbc6a..611adf3d46a5 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1102,8 +1102,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* folio is up to date */
 	folio_mark_uptodate(folio);
 
-	/* move it to the tail of the inactive list after end_writeback */
-	folio_set_reclaim(folio);
+	/* free the folio after writeback */
+	folio_set_dropbehind(folio);
 
 	/* start writeback */
 	__swap_writepage(folio, &wbc);
-- 
2.47.2


