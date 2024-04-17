Return-Path: <linux-fsdevel+bounces-17198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96DC8A8AAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64576287132
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87658177983;
	Wed, 17 Apr 2024 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DkOHoJG3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6415317334F
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376627; cv=none; b=Elzdn/6uho8hEpj1KUQfAd1Q2BpFugFd+A6u5BlYPd4zk7lp4tX06KlmFwZ0TKbh/cK+je7qpBKbk0ZVP4qEg562d2GoenpRnVBlct0Ymb31QaTwpVdWWj/BUg0je6IzNRicDR5EefK5b4oJlu7kxV9cwTDAA6xGdtMu6p1W7bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376627; c=relaxed/simple;
	bh=OxDhZvC9Amw+hMKnDgjDSanKx8dE/+7jO0T9i9ELEuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2GtG7VVJoVWd77FppzfL544k6IX92ChSnn4C0g+UrPlFe/gXXmjGN1qwHt8ug2MAfVXv2BC+eaaKBLn4hjLEljvVTaToStCEKQq9hsB+GhU62yFrCf+VxNcMpXikxDwEbyNJkKHNhe+YJZqxI5oFqF0dP8+c1v+JjTe/pJr7AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DkOHoJG3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=3F2REPprGFU3NAO/d/I198nnDhbiMS319KeFMfWiBPg=; b=DkOHoJG3mlz7vONEam1pM4aTTe
	q2GT0LreR2yevYFYSlTL/V+tjIxSsC+nk7VjqD+8zXX5H36XjoUZzEXMI6rdrIXehMTjvM3KXEdeZ
	GGse1/srcJ/ECYGUpUfMkvj1qZuNNBfueSNXFJB+FfvNd6V80fJRzLLHW5Oc2NV+1DSUrlc5oBGaC
	p5p0EB70kFnyOJ4jC4LHRj2kpxaVJr6iWRRM4KULHsMWTGYG94B+WJ+cMqg8Sl1yesPrmg3q0ytjQ
	S9PGbQfxykyYgg7TLIOd6b0UuMRe8n6VYnrkgpie3BhDt3ULvzlJsstec7lQsXRFEdYRNLoq6wdVe
	8CiW2/Rg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9Wo-00000003Qtq-31jc;
	Wed, 17 Apr 2024 17:57:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 11/13] jfs: Convert force_metapage to use a folio
Date: Wed, 17 Apr 2024 18:56:55 +0100
Message-ID: <20240417175659.818299-12-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417175659.818299-1-willy@infradead.org>
References: <20240417175659.818299-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the mp->page to a folio and operate on it.  That lets us
convert metapage_write_one() to take a folio.  Replaces five calls to
compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index f03e217ec1cb..c88a7bc3f736 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -689,9 +689,8 @@ void grab_metapage(struct metapage * mp)
 	unlock_page(mp->page);
 }
 
-static int metapage_write_one(struct page *page)
+static int metapage_write_one(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct address_space *mapping = folio->mapping;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_ALL,
@@ -720,17 +719,17 @@ static int metapage_write_one(struct page *page)
 
 void force_metapage(struct metapage *mp)
 {
-	struct page *page = mp->page;
+	struct folio *folio = page_folio(mp->page);
 	jfs_info("force_metapage: mp = 0x%p", mp);
 	set_bit(META_forcewrite, &mp->flag);
 	clear_bit(META_sync, &mp->flag);
-	get_page(page);
-	lock_page(page);
-	set_page_dirty(page);
-	if (metapage_write_one(page))
+	folio_get(folio);
+	folio_lock(folio);
+	folio_mark_dirty(folio);
+	if (metapage_write_one(folio))
 		jfs_error(mp->sb, "metapage_write_one() failed\n");
 	clear_bit(META_forcewrite, &mp->flag);
-	put_page(page);
+	folio_put(folio);
 }
 
 void hold_metapage(struct metapage *mp)
@@ -771,7 +770,7 @@ void release_metapage(struct metapage * mp)
 		folio_mark_dirty(folio);
 		if (test_bit(META_sync, &mp->flag)) {
 			clear_bit(META_sync, &mp->flag);
-			if (metapage_write_one(&folio->page))
+			if (metapage_write_one(folio))
 				jfs_error(mp->sb, "metapage_write_one() failed\n");
 			folio_lock(folio);
 		}
-- 
2.43.0


