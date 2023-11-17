Return-Path: <linux-fsdevel+bounces-3035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C917EF5F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 17:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3E82802A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27BB3DBB3;
	Fri, 17 Nov 2023 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cP4vkMrj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA2DA4
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 08:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=zgKIMNO9SoWoamx4nfeJw6ay/xwbZPsNF5ZtmzNQz8s=; b=cP4vkMrj4ZpFOH9Q3bcgXCdmVK
	v7qVSAJdIVOD50Uf5a496mO7tImj5kJgldjKrv0Tq2fbmqV/M1sByRDx1dCoCvXxWLcOJ03Lh1EUB
	ozuILp2raG7J9TXGwKi+IYSpJOGltR0J3LlopzajD11deTId2zJl9cNtdudORtwEDgX/4DjCVvd+L
	QgQ0bISL9h9rL9OAq9h5Rt/Jdj7xciZsrukosx8e6sEb4mbv0vEGlNZu7aJECz1aDc8+M4UxhdhKA
	KdVD/Jx48zE+W3qXgwZSvHqC6drT4UJtm9xJzRsZWFZwKQaqoQHjuajoUGCS0dsQ6lo+nX5gUeEIs
	akTRRVmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r41Uc-00AKXs-J5; Fri, 17 Nov 2023 16:14:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/6] memory-failure: Use a folio in me_pagecache_dirty()
Date: Fri, 17 Nov 2023 16:14:43 +0000
Message-Id: <20231117161447.2461643-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231117161447.2461643-1-willy@infradead.org>
References: <20231117161447.2461643-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaces three hidden calls to compound_head() with one visible one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory-failure.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 496e8ecd8496..d2764fd3e448 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1138,15 +1138,16 @@ static int me_pagecache_dirty(struct page_state *ps, struct page *p)
  */
 static int me_swapcache_dirty(struct page_state *ps, struct page *p)
 {
+	struct folio *folio = page_folio(p);
 	int ret;
 	bool extra_pins = false;
 
-	ClearPageDirty(p);
+	folio_clear_dirty(folio);
 	/* Trigger EIO in shmem: */
-	ClearPageUptodate(p);
+	folio_clear_uptodate(folio);
 
 	ret = delete_from_lru_cache(p) ? MF_FAILED : MF_DELAYED;
-	unlock_page(p);
+	folio_unlock(folio);
 
 	if (ret == MF_DELAYED)
 		extra_pins = true;
-- 
2.42.0


