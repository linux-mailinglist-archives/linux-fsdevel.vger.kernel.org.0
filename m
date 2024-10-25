Return-Path: <linux-fsdevel+bounces-32835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B9A9AF6B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 03:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D261C20DC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 01:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A410139D1B;
	Fri, 25 Oct 2024 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qnj7/ylT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEB386AE3
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 01:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819420; cv=none; b=PW81cpy23xO+K71n5jle8kPnpq9vAEFu14El1921VTqh5xRxy64enhqCh9TlsN8+9KNw7vejxoT0tTdlVFpybc1uf7xNlNCMI3zDYIQSZdMLwnPBQS4l5sbx41zpaKduQJI1iJHuGrleJvWVdAG6Zp4VJbMRDcEEU/2PIKAsDFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819420; c=relaxed/simple;
	bh=IqWXEzb3620Vwxa10Snp0uinoB5WLkZnT6RRj0E2ZOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWvmluyRMm99rSQ+QNjt8pBrlhucUmj3EZLI/VRwQ5ShmKtmqLJEjliaLlsVqaiNJW5NhES/5VDihJIqbTxDCuZJG9lCIp2Mf8xUfVxlYYTmqxcgQY2VAwJ5Tb9EindoDRWxhkJN7UnW4d/tq5vwd63g3Owb1g9kXYMNnsAl+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qnj7/ylT; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729819416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ea/MjMCn/PUwsZr9oC0H1/BbJ/TXP7i5xCISmkGKoYY=;
	b=Qnj7/ylTgj6qu/raQvuKWAyO7g8JdotVpJCyFMYSo3WFE7xF7Z+WM55uL9HFpK1rmXhc2+
	0IN2sQ/XwvawwCMrgzk03NlVPJPW0VfZskrXjGkZycB05364Ktq7ebY8tvS9oZteVpPoB/
	kixS1n6ATSFM4zxELJsS/AoqmrK8yDI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v1 3/6] memcg-v1: no need for memcg locking for dirty tracking
Date: Thu, 24 Oct 2024 18:23:00 -0700
Message-ID: <20241025012304.2473312-4-shakeel.butt@linux.dev>
In-Reply-To: <20241025012304.2473312-1-shakeel.butt@linux.dev>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

During the era of memcg charge migration, the kernel has to be make sure
that the dirty stat updates do not race with the charge migration.
Otherwise it might update the dirty stats of the wrong memcg. Now with
the memcg charge migration deprecated, there is no more race for dirty
stat updates and the previous locking can be removed.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 fs/buffer.c         |  5 -----
 mm/page-writeback.c | 16 +++-------------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1fc9a50def0b..88e765b0699f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -736,15 +736,12 @@ bool block_dirty_folio(struct address_space *mapping, struct folio *folio)
 	 * Lock out page's memcg migration to keep PageDirty
 	 * synchronized with per-memcg dirty page counters.
 	 */
-	folio_memcg_lock(folio);
 	newly_dirty = !folio_test_set_dirty(folio);
 	spin_unlock(&mapping->i_private_lock);
 
 	if (newly_dirty)
 		__folio_mark_dirty(folio, mapping, 1);
 
-	folio_memcg_unlock(folio);
-
 	if (newly_dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 
@@ -1194,13 +1191,11 @@ void mark_buffer_dirty(struct buffer_head *bh)
 		struct folio *folio = bh->b_folio;
 		struct address_space *mapping = NULL;
 
-		folio_memcg_lock(folio);
 		if (!folio_test_set_dirty(folio)) {
 			mapping = folio->mapping;
 			if (mapping)
 				__folio_mark_dirty(folio, mapping, 0);
 		}
-		folio_memcg_unlock(folio);
 		if (mapping)
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 1d7179aba8e3..a76a73529fd9 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2743,8 +2743,6 @@ EXPORT_SYMBOL(noop_dirty_folio);
 /*
  * Helper function for set_page_dirty family.
  *
- * Caller must hold folio_memcg_lock().
- *
  * NOTE: This relies on being atomic wrt interrupts.
  */
 static void folio_account_dirtied(struct folio *folio,
@@ -2777,7 +2775,6 @@ static void folio_account_dirtied(struct folio *folio,
 /*
  * Helper function for deaccounting dirty page without writeback.
  *
- * Caller must hold folio_memcg_lock().
  */
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
 {
@@ -2795,9 +2792,8 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
  * If warn is true, then emit a warning if the folio is not uptodate and has
  * not been truncated.
  *
- * The caller must hold folio_memcg_lock().  It is the caller's
- * responsibility to prevent the folio from being truncated while
- * this function is in progress, although it may have been truncated
+ * It is the caller's responsibility to prevent the folio from being truncated
+ * while this function is in progress, although it may have been truncated
  * before this function is called.  Most callers have the folio locked.
  * A few have the folio blocked from truncation through other means (e.g.
  * zap_vma_pages() has it mapped and is holding the page table lock).
@@ -2841,14 +2837,10 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
  */
 bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-	folio_memcg_lock(folio);
-	if (folio_test_set_dirty(folio)) {
-		folio_memcg_unlock(folio);
+	if (folio_test_set_dirty(folio))
 		return false;
-	}
 
 	__folio_mark_dirty(folio, mapping, !folio_test_private(folio));
-	folio_memcg_unlock(folio);
 
 	if (mapping->host) {
 		/* !PageAnon && !swapper_space */
@@ -2975,14 +2967,12 @@ void __folio_cancel_dirty(struct folio *folio)
 		struct bdi_writeback *wb;
 		struct wb_lock_cookie cookie = {};
 
-		folio_memcg_lock(folio);
 		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 
 		if (folio_test_clear_dirty(folio))
 			folio_account_cleaned(folio, wb);
 
 		unlocked_inode_to_wb_end(inode, &cookie);
-		folio_memcg_unlock(folio);
 	} else {
 		folio_clear_dirty(folio);
 	}
-- 
2.43.5


