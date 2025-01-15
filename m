Return-Path: <linux-fsdevel+bounces-39245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DD4A11DF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75FC87A104A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EB822F82F;
	Wed, 15 Jan 2025 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pnt62ecs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E51E7C04;
	Wed, 15 Jan 2025 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933516; cv=none; b=OCTaXkzG6jFOxOLsB1Dx3a+taplduttbG0gD5CSTfV2jcokHVS26qlH5JfNSt/Z4DpwYXW/xJuGL3Lc1wDIyZP3Hv5tTR/BkLzarbPIkmu7VklLdbaj2IT39I7jdWi8yJSIsRy+7VqE4NIoK80DGNPrTj1sjxeOtYzYAkTqk1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933516; c=relaxed/simple;
	bh=a239UknTIxW2CKH5kemCn7/leZfYKcHiwL8zSp/0EiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxENzneJcHbm5yTMZtMUdh8/E7rws4KYTXw9FL07j8CRPLOUun4wR0waGeDtRJQSOD5N4bHQTK5q8XPlAyuKNW9p8n0acrS/2HqUGTzsAeWPpToib1Gke4CnkDf4oNGOEB8sjyjGl3Nlz5Mz2cWXf3Bs5PYmeUgmt/nhbI7m4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pnt62ecs; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736933514; x=1768469514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a239UknTIxW2CKH5kemCn7/leZfYKcHiwL8zSp/0EiM=;
  b=Pnt62ecstSYFVx4flN20SZSx3mU7J+YpZ5mgVf4Mp3mcL4x1uyQhSIkR
   qrY61uWGvqF3xoy31iDcyFMMU4OxuucwIDGlgguB/qjcO9zTC7cfnp1u2
   TlsxIs4UQC0gPoPDEqI9MG0v4aqeeXcRJIFbh2Kst9cdsJQWcWsIGl4q0
   wl6RXNKpO3+MvhPHforwLFC5jrzQ7S//Akr+hf7qMycQPYEm7T6rh93jj
   4X4u1aJq1RYAHBfsTqPbbsLlFewrFhPnrJ0cadvAPHL/mroLWkmdw6xE/
   iDnJqef7k25ojcAhVPj4L5ec5AnMGM9bqu3Q6NAqKRnneGhSbA9hE9u1q
   w==;
X-CSE-ConnectionGUID: 0kQxYKsORKKuVwgcbRAItg==
X-CSE-MsgGUID: dk33gebdTU6jzgQWgjS3eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37371856"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37371856"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 01:31:52 -0800
X-CSE-ConnectionGUID: ltRxBoJPQditDzSqg/CR1A==
X-CSE-MsgGUID: ewfu1EWYS/iNJTs2vK9cyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="110066758"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 15 Jan 2025 01:31:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 652314AB; Wed, 15 Jan 2025 11:31:42 +0200 (EET)
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
Subject: [PATCHv2 04/11] mm/zswap: Use PG_dropbehind instead of PG_reclaim
Date: Wed, 15 Jan 2025 11:31:28 +0200
Message-ID: <20250115093135.3288234-5-kirill.shutemov@linux.intel.com>
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
zswap_writeback_entry().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 167ae641379f..c20bad0b0978 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1096,8 +1096,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* folio is up to date */
 	folio_mark_uptodate(folio);
 
-	/* move it to the tail of the inactive list after end_writeback */
-	folio_set_reclaim(folio);
+	/* free the folio after writeback */
+	folio_set_dropbehind(folio);
 
 	/* start writeback */
 	__swap_writepage(folio, &wbc);
-- 
2.45.2


