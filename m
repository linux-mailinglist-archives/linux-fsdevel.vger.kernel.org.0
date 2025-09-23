Return-Path: <linux-fsdevel+bounces-62472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A88DB941E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 05:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5427718A2640
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 03:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A4E2641E7;
	Tue, 23 Sep 2025 03:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vz8X+aqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12D154BF5;
	Tue, 23 Sep 2025 03:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758598709; cv=none; b=Zd+gxnj/ng3DMMrGbMpjTViHnVy120Ienm6218r1syxVTuXwiUs6J5BWmnUlGvCol2hWGLuNzVt6ImvVO2CL15Y3wKcH8UKw+656uN1vDJO55kq6yZ0Bxn/pWjIVp+KhMzI/O6rl/rdrQkKjqSgnfdlWIU9C1DE7i6HcHaZWEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758598709; c=relaxed/simple;
	bh=FizkU2Y4iQmHbh9eGNnE1mk6hmTzfCGAiCcr2jNaicI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qr8PjwVBEU+rcJBjqnTmY3/U83md3XGtkfCpWVtLJ9mMHfMwFFywo1wBrEJk24GNByL1FSgTv5N2/DW+nsy/A1A44uCp5kOS+ujnjgVphw7WF7iev1L5XlHynkVxtwBRyJrUJKmNqzAt9lgToc8Gor6vusOYV78PwhOp+/i+R9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vz8X+aqm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758598706; x=1790134706;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FizkU2Y4iQmHbh9eGNnE1mk6hmTzfCGAiCcr2jNaicI=;
  b=Vz8X+aqmgppxsBa/S5DIamFizRjTQDtSIR+xJRaBHyOgA4Q+DnLIBk0C
   uWAZVz7mkxHccoRntYqn+EhPyxrGBzvDzPbFEDAze3xwHinOnsjNboxX5
   Pyr+YZnYAnaBcyDiZ1ygQ4ViUSZMFCdHDAkont6Y4SP7pgv/k40pc/1LR
   kK2jWVKUaHFuVXhJUhwFAvsaXZKZLQOuQ6rI87eYpuQqir/EUJ4L1oUbR
   Ju7IdtzPVjRpP2y+nhBwC1niUA+07WSnJl7x8F4H8GwfxpOkAvVSbb0P2
   IPbO8GzOo4oTkHWosRcN9EFsL3MegBv5QCSzCQjeeAUTlAVZC5UOF3CpA
   A==;
X-CSE-ConnectionGUID: Val9Na/OSjqutWAbRXhDAQ==
X-CSE-MsgGUID: tJiYklCbRHSf+CIOuXgtCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60810732"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60810732"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 20:38:25 -0700
X-CSE-ConnectionGUID: QmgsTgPHTca/mCjKADKtww==
X-CSE-MsgGUID: khgnW+CHSdObyFHd7PV7xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="176231201"
Received: from alc-spr.sh.intel.com ([10.239.53.113])
  by orviesa009.jf.intel.com with ESMTP; 22 Sep 2025 20:38:23 -0700
From: Aubrey Li <aubrey.li@linux.intel.com>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nanhai Zou <nanhai.zou@intel.com>,
	Gang Deng <gang.deng@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Vinicius Gomes <vinicius.gomes@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Chen Yu <yu.c.chen@intel.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH] mm/readahead: Skip fully overlapped range
Date: Tue, 23 Sep 2025 11:59:46 +0800
Message-ID: <20250923035946.2560876-1-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RocksDB sequential read benchmark under high concurrency shows severe
lock contention. Multiple threads may issue readahead on the same file
simultaneously, which leads to heavy contention on the xas spinlock in
filemap_add_folio(). Perf profiling indicates 30%~60% of CPU time spent
there.

To mitigate this issue, a readahead request will be skipped if its
range is fully covered by an ongoing readahead. This avoids redundant
work and significantly reduces lock contention. In one-second sampling,
contention on xas spinlock dropped from 138,314 times to 2,144 times,
resulting in a large performance improvement in the benchmark.

				w/o patch       w/ patch
RocksDB-readseq (ops/sec)
(32-threads)			1.2M		2.4M

Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Vinicius Gomes <vinicius.gomes@intel.com>
Cc: Tianyou Li <tianyou.li@intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Suggested-by: Nanhai Zou <nanhai.zou@intel.com>
Tested-by: Gang Deng <gang.deng@intel.com>
Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 mm/readahead.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 20d36d6b055e..57ae1a137730 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -337,7 +337,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	struct address_space *mapping = ractl->mapping;
 	struct file_ra_state *ra = ractl->ra;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
-	unsigned long max_pages;
+	unsigned long max_pages, index;
 
 	if (unlikely(!mapping->a_ops->read_folio && !mapping->a_ops->readahead))
 		return;
@@ -348,6 +348,19 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	 */
 	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
 	nr_to_read = min_t(unsigned long, nr_to_read, max_pages);
+
+	index = readahead_index(ractl);
+	/*
+	 * Skip this readahead if the requested range is fully covered
+	 * by the ongoing readahead range. This typically occurs in
+	 * concurrent scenarios.
+	 */
+	if (index >= ra->start && index + nr_to_read  <= ra->start + ra->size)
+		return;
+
+	ra->start = index;
+	ra->size = nr_to_read;
+
 	while (nr_to_read) {
 		unsigned long this_chunk = (2 * 1024 * 1024) / PAGE_SIZE;
 
@@ -357,6 +370,10 @@ void force_page_cache_ra(struct readahead_control *ractl,
 
 		nr_to_read -= this_chunk;
 	}
+
+	/* Reset readahead state to allow the next readahead */
+	ra->start = 0;
+	ra->size = 0;
 }
 
 /*
-- 
2.43.0


