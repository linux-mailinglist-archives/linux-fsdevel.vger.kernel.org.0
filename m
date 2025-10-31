Return-Path: <linux-fsdevel+bounces-66566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D69C24305
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 10:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E14CC4ED211
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36E63321C3;
	Fri, 31 Oct 2025 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GWyXIJXV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931B2E092D;
	Fri, 31 Oct 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903336; cv=none; b=BebbPzffcvCsrdfJbG9IBHbmP4gUdB0LSjQ76LdwLK8CevntX9MjvwY6rZ/t7Hjcf6XyLCilbMn7YXWFvGRtpO10UsuwxhBz8X1dLgQ5F9UMwe/9AJYcbU1fTCaZwFdMhe0bUlLkW9svpMUzV0PNBLJM3z05e6XvE6BnY3r6QSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903336; c=relaxed/simple;
	bh=7JykS0ylxNDYx8W68gBo+u/2uv8liRQg36ZB35iALRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvXe2zxvhRlCOkvKb37ZRQWJKTbufMKufemzYgwaX38miJMjqRGKGadLnggRTM85c5vyijdBgviY68+IdvCVCwWsPRzwG7LLRXY93fRnKnFMGQbrIIOKC4XuK1NRd1cydyVE+/BGlhtXeZbbsiSGzmMX25gvYQbx3wQa9cYcAjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GWyXIJXV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SQcOvR002YBJLomweC4BY3LAL0acld9iJ19aX/ran84=; b=GWyXIJXVjzGfpONv6rx+3Zedht
	Q8fXnuaOXitXgCoQ4omWD8Yp36eBz4GvkA0gJ8HrL+KDQxNu5bLfjZQtOGdolRzn2qczErqgB9qZa
	S7B+4MAsMEe+Wme1p9YQyq9cvUYoL2hvxCDxKt+9uY8mEj0tmQFVf58EX1xhl+ChTbJnREiKsY2a7
	wWGCnUzcmPnMB7ZOFtGKhq9TX46kORy3Q751zOT537q7A7t45RgC+hFvRmvLn3esdZbbU842Q5pv+
	KxIkYfrhtPc1GVSvKgfYsj7HTeOyp9XOKGvnOQHCei01ziYMoCRVCayBYRaT5+Sn8ulTu7he4Xvcy
	aFImWsQg==;
Received: from [2001:4bb8:2dc:1001:a959:25cf:98e9:329b] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vElXg-00000005opk-1qyJ;
	Fri, 31 Oct 2025 09:35:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/9] mempool: add error injection support
Date: Fri, 31 Oct 2025 10:34:32 +0100
Message-ID: <20251031093517.1603379-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031093517.1603379-1-hch@lst.de>
References: <20251031093517.1603379-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a call to should_fail_ex that forces mempool to actually allocate
from the pool to stress the mempool implementation when enabled through
debugfs.  By default should_fail{,_ex} prints a very verbose stack trace
that clutters the kernel log, slows down execution and triggers the
kernel bug detection in xfstests.  Pass FAULT_NOWARN and print a
single-line message notating the caller instead so that full tests
can be run with fault injection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/mempool.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index d7c55a98c2be..15581179c8b9 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -9,7 +9,7 @@
  *  started by Ingo Molnar, Copyright (C) 2001
  *  debugging by David Rientjes, Copyright (C) 2015
  */
-
+#include <linux/fault-inject.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/highmem.h>
@@ -20,6 +20,15 @@
 #include <linux/writeback.h>
 #include "slab.h"
 
+static DECLARE_FAULT_ATTR(fail_mempool_alloc);
+
+static int __init mempool_faul_inject_init(void)
+{
+	return PTR_ERR_OR_ZERO(fault_create_debugfs_attr("fail_mempool_alloc",
+			NULL, &fail_mempool_alloc));
+}
+late_initcall(mempool_faul_inject_init);
+
 #ifdef CONFIG_SLUB_DEBUG_ON
 static void poison_error(mempool_t *pool, void *element, size_t size,
 			 size_t byte)
@@ -399,10 +408,15 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
 
 repeat_alloc:
-
-	element = pool->alloc(gfp_temp, pool->pool_data);
-	if (likely(element != NULL))
-		return element;
+	if (should_fail_ex(&fail_mempool_alloc, 1, FAULT_NOWARN)) {
+		pr_info("forcing mempool usage for pool %pS\n",
+				(void *)_RET_IP_);
+		element = NULL;
+	} else {
+		element = pool->alloc(gfp_temp, pool->pool_data);
+		if (likely(element != NULL))
+			return element;
+	}
 
 	spin_lock_irqsave(&pool->lock, flags);
 	if (likely(pool->curr_nr)) {
-- 
2.47.3


