Return-Path: <linux-fsdevel+bounces-30645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B6998CBD0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 06:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66C71F2559B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 04:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA8539AE3;
	Wed,  2 Oct 2024 04:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cZ7AVepj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4537A28FF;
	Wed,  2 Oct 2024 04:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841677; cv=none; b=Z9sltuLivcPyzgwql71rtfIr6ltzPnDhA3VA/ZPJhGya4AiSU5p681qyvzVBMZeVuOLUXGyW5fRctUn2+sKOyEqSEXoGvYKd0wtqmLQNYK2kfv5JTwJIhNfGmDwxdYcs8fnk2J0dFi3VZg4mw84feVg2GmY2h9kfXNoji9alVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841677; c=relaxed/simple;
	bh=lVV2srICDVqZiN0AicH0F8iHk9+Z0d3qEuNZMdFBki8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEIrpaNKitRtwAon05tbWZeSWuNeCKiaUL3IDnXgjo1dRVAB9IHRcuZFRUnJKF1MNtzPukI0rrCuWp6IqUcFN37ylNmvdRv5oocKvWaug32yGhnQaBYA4pfQonVVJd9iyDL97IS39hVzhtGtbcF0JPGx313E8w6Jk21Lk0SDmfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cZ7AVepj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=COJ8f3y8IG0H+Q9xXoJdJ9ujTm4oeQQb1jUdkdnvJ4Q=; b=cZ7AVepjiSMgq/Oh5aKY9/VDa0
	gRhmlq5wCZ23wsBbm/Ko4q2nW+MPdwngGy0X3df0Zvy4L/zpwvaLBy8VGiVdFbJwCNZhLXMMsZ1wt
	/pB8l05ekw0/hTNr3boaDx7x2KmJWkL9y+KIMcSNQcUgmP3pOn+60JPFz5nkH1GZnVtE0+kWHOo5p
	u4LbdLTtiHAJ6rwONcKSdCxpgmIYHOkTXnqyc3QovQUVpzE2w6iVNh+nqUbZOyptS4klJsACK34Rm
	xGZ6zrsbHGsmgwF9lSof4rXDk9i4ok3DkyOQHEMs9ECO7U3XNb9XdcavFpe8MAC8kl0hxbM5Uafxo
	6kA9ylbA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svqY6-00000004I8b-09mw;
	Wed, 02 Oct 2024 04:01:14 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/6] ceph: Remove call to PagePrivate2()
Date: Wed,  2 Oct 2024 05:01:07 +0100
Message-ID: <20241002040111.1023018-6-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002040111.1023018-1-willy@infradead.org>
References: <20241002040111.1023018-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the folio that we already have to call folio_test_private_2()
instead.  This is the last call to PagePrivate2(), so replace its
PAGEFLAG() definition with FOLIO_FLAG().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c             | 20 ++++++++++----------
 include/linux/page-flags.h |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 53fef258c2bc..a8788e300dc7 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1051,7 +1051,9 @@ static int ceph_writepages_start(struct address_space *mapping,
 		if (!nr_folios && !locked_pages)
 			break;
 		for (i = 0; i < nr_folios && locked_pages < max_pages; i++) {
-			page = &fbatch.folios[i]->page;
+			struct folio *folio = fbatch.folios[i];
+
+			page = &folio->page;
 			doutc(cl, "? %p idx %lu\n", page, page->index);
 			if (locked_pages == 0)
 				lock_page(page);  /* first page */
@@ -1078,8 +1080,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 				continue;
 			}
 			if (page_offset(page) >= ceph_wbc.i_size) {
-				struct folio *folio = page_folio(page);
-
 				doutc(cl, "folio at %lu beyond eof %llu\n",
 				      folio->index, ceph_wbc.i_size);
 				if ((ceph_wbc.size_stable ||
@@ -1095,16 +1095,16 @@ static int ceph_writepages_start(struct address_space *mapping,
 				unlock_page(page);
 				break;
 			}
-			if (PageWriteback(page) ||
-			    PagePrivate2(page) /* [DEPRECATED] */) {
+			if (folio_test_writeback(folio) ||
+			    folio_test_private_2(folio) /* [DEPRECATED] */) {
 				if (wbc->sync_mode == WB_SYNC_NONE) {
-					doutc(cl, "%p under writeback\n", page);
-					unlock_page(page);
+					doutc(cl, "%p under writeback\n", folio);
+					folio_unlock(folio);
 					continue;
 				}
-				doutc(cl, "waiting on writeback %p\n", page);
-				wait_on_page_writeback(page);
-				folio_wait_private_2(page_folio(page)); /* [DEPRECATED] */
+				doutc(cl, "waiting on writeback %p\n", folio);
+				folio_wait_writeback(folio);
+				folio_wait_private_2(folio); /* [DEPRECATED] */
 			}
 
 			if (!clear_page_dirty_for_io(page)) {
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 35d08c30d4a6..4c2dfe289046 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -543,7 +543,7 @@ FOLIO_FLAG(swapbacked, FOLIO_HEAD_PAGE)
  * - PG_private and PG_private_2 cause release_folio() and co to be invoked
  */
 PAGEFLAG(Private, private, PF_ANY)
-PAGEFLAG(Private2, private_2, PF_ANY) TESTSCFLAG(Private2, private_2, PF_ANY)
+FOLIO_FLAG(private_2, FOLIO_HEAD_PAGE)
 
 /* owner_2 can be set on tail pages for anon memory */
 FOLIO_FLAG(owner_2, FOLIO_HEAD_PAGE)
-- 
2.43.0


