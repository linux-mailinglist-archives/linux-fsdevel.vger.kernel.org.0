Return-Path: <linux-fsdevel+bounces-39014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 194E8A0B342
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 10:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8B31697DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD85246330;
	Mon, 13 Jan 2025 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIntNe6t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CD71FDA67;
	Mon, 13 Jan 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760917; cv=none; b=oehvo7ucbRWyJCZiJYmuk/NVd7kCNBD4GdS1qZmkmT0tCOcGFwlbGSgO5RACJVDVbCvRiP+0jxSI/eAdSPCnDWaRCjzos9P2iAiXPSpOSb0M5M2o1sFIR0gftmUOh7CWd6zkN+M83L290zXyPd4pFdlfDguMTUM1hFot2BRPJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760917; c=relaxed/simple;
	bh=IgjaNFBWhujQnq/c6yPPss+dBuUf4OdsPTNtQqXJnW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqbeQNCdOk22JDOqAJ2HOQDXoVvz39vOAbGDvQi5L3xawDKPmtwFcDgazNksJwd71T20sExTyjF8kiGzkU1axhWEFxO6l/W/fbGMqmjnB480sWbNhuNzq91HZUJNXxUk+1TD4Y6SM3UcNda2y7P+FQ+K3ad5GwLUxKTt9be+/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIntNe6t; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736760915; x=1768296915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IgjaNFBWhujQnq/c6yPPss+dBuUf4OdsPTNtQqXJnW4=;
  b=IIntNe6tzj0ggH+8Wz21nD0oCVtXfxNGZPT1nmbWoL94u8Oc6Wc6KV2/
   OjIEewrD3cDXuapZB/vCfl61n8rMAHQqJXZbQO6OCQcPtUAVYyzdtfKt4
   NwesXv7K8h9De+M0qeJvpOPXB1+xCxUMqPGbyaWtEO/E3bfSzcKt1uEij
   4BF96n6DLW1jYky3haJ/JgjMSzqlWuWfeJ63bhrS8Pjww/kj760rE0y8Y
   QEfhnphq1Rp8S0ot3fJi3wKM4Qmu1Mif6x5TnAC2tzNSkhlhMOVbJp8V1
   xNtta5zt2nPIry/stWQ6tvAutqLRpU7HmAKSChHItorPrcKhenkJSdKSc
   A==;
X-CSE-ConnectionGUID: l5y25PlHTgqO2vBSgUzZ4w==
X-CSE-MsgGUID: pg2dYjX7T2qZpCPaZmQVtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40948956"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40948956"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:35:13 -0800
X-CSE-ConnectionGUID: FvOhar42Sdu5F/xuFj0UkQ==
X-CSE-MsgGUID: 2hPQLD4bQZOgY3uq4G9MfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104586348"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 13 Jan 2025 01:35:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 24E5A478; Mon, 13 Jan 2025 11:35:04 +0200 (EET)
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
Subject: [PATCH 3/8] mm/zswap: Use PG_dropbehind instead of PG_reclaim
Date: Mon, 13 Jan 2025 11:34:48 +0200
Message-ID: <20250113093453.1932083-4-kirill.shutemov@linux.intel.com>
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
zswap_writeback_entry().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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


