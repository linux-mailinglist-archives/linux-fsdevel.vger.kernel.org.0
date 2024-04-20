Return-Path: <linux-fsdevel+bounces-17351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372018AB904
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695501C20F58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5DB1863F;
	Sat, 20 Apr 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s3iILuB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C037E199C7
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581466; cv=none; b=uBY9oiSGA2wRwy6QbXZm/9FaRBloRkS9lZkCet1reLKdZzroi5vksbv/u66u0eRnZELniJVlinCPtWG6cp24WZ0hznPYHAWAktcuNQwMLmI/61NwGZCWPw5ejQxDDQ0i+FFi9hViTmE4u0zffTThqLf9yLXlljN/dFk1HIT13m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581466; c=relaxed/simple;
	bh=benssiDwMQD78ZuwTIOs6vpaSfYkzmdv4DjzHfx326M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPGiUYrLV28/uSv5vZo1LHsc32YYCljwOogUNBfnlUVvPPMkfqxZDAfYsBlnpIcyKo08gWMIlY0u7XEeXRynUp1LUln4T29lALVBt38iPz2/8PZtZHM4/sEwETdCoGlnpGv1Neo4fWI/WOB2hIv9vfI//wXIapsxBJqvzSGcazI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s3iILuB+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=s2FH+8vqQm67u6hInWQscZRvoUgnyhqNAlj8cATZmvM=; b=s3iILuB+2U9U5Sf+rSqY//nvsg
	qKv7z72lINSg/Rl6cxNpLaALWFeGolmsQnNBzHaqmn8hI5tmv5N6TELdls0mwGfdIGszHNFspAcu9
	PfSYZLR6vcA+6YiVXzrB8j8u1MrsEvKLBzCUDd6SFfuZ2nHrEcyW/NjC/BPL9kANsR4ofd2NPr9+2
	arReARGEPhMGwnGz/Ng5n1eOGyh79nnjxnXxG7/jyLEeP5a3k2btQrAbwadEiMyj/icWxAQ1IrtEX
	HHHkODNqPfrYFDUn2GHAteEQ7J6QO845iY+6zhmmP2EHZCXB2ll9xIgxe45UnyETCfYAp4S4OGwcP
	q3UNTH3A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0og-000000095h1-2jVl;
	Sat, 20 Apr 2024 02:51:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org
Subject: [PATCH 30/30] mm: Remove PG_error
Date: Sat, 20 Apr 2024 03:50:25 +0100
Message-ID: <20240420025029.2166544-31-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PG_error bit is now unused; delete it and free up a bit in
page->flags.

Cc: linux-mm@kvack.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/page.c                         | 1 -
 include/linux/page-flags.h             | 6 +-----
 include/trace/events/mmflags.h         | 1 -
 include/uapi/linux/kernel-page-flags.h | 2 +-
 mm/migrate.c                           | 2 --
 5 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 2fb64bdb64eb..05eb6617668a 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -186,7 +186,6 @@ u64 stable_page_flags(const struct page *page)
 #endif
 
 	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
-	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
 	u |= kpf_copy_bit(k, KPF_DIRTY,		PG_dirty);
 	u |= kpf_copy_bit(k, KPF_UPTODATE,	PG_uptodate);
 	u |= kpf_copy_bit(k, KPF_WRITEBACK,	PG_writeback);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a9a6e0f7367e..931820c8ea95 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -71,8 +71,6 @@
  * PG_referenced, PG_reclaim are used for page reclaim for anonymous and
  * file-backed pagecache (see mm/vmscan.c).
  *
- * PG_error is set to indicate that an I/O error occurred on this page.
- *
  * PG_arch_1 is an architecture specific page state bit.  The generic code
  * guarantees that this bit is cleared for a page when it first is entered into
  * the page cache.
@@ -108,7 +106,6 @@ enum pageflags {
 	PG_waiters,		/* Page has waiters, check its waitqueue. Must be bit #7 and in the same byte as "PG_locked" */
 	PG_active,
 	PG_workingset,
-	PG_error,
 	PG_owner_priv_1,	/* Owner use. If pagecache, fs may use*/
 	PG_arch_1,
 	PG_reserved,
@@ -188,7 +185,7 @@ enum pageflags {
 	 */
 
 	/* At least one page in this folio has the hwpoison flag set */
-	PG_has_hwpoisoned = PG_error,
+	PG_has_hwpoisoned = PG_active,
 	PG_large_rmappable = PG_workingset, /* anon or file-backed */
 };
 
@@ -511,7 +508,6 @@ static inline int TestClearPage##uname(struct page *page) { return 0; }
 
 __PAGEFLAG(Locked, locked, PF_NO_TAIL)
 FOLIO_FLAG(waiters, FOLIO_HEAD_PAGE)
-PAGEFLAG(Error, error, PF_NO_TAIL) TESTCLEARFLAG(Error, error, PF_NO_TAIL)
 PAGEFLAG(Referenced, referenced, PF_HEAD)
 	TESTCLEARFLAG(Referenced, referenced, PF_HEAD)
 	__SETPAGEFLAG(Referenced, referenced, PF_HEAD)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index e46d6e82765e..4f2a18a11970 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -100,7 +100,6 @@
 #define __def_pageflag_names						\
 	DEF_PAGEFLAG_NAME(locked),					\
 	DEF_PAGEFLAG_NAME(waiters),					\
-	DEF_PAGEFLAG_NAME(error),					\
 	DEF_PAGEFLAG_NAME(referenced),					\
 	DEF_PAGEFLAG_NAME(uptodate),					\
 	DEF_PAGEFLAG_NAME(dirty),					\
diff --git a/include/uapi/linux/kernel-page-flags.h b/include/uapi/linux/kernel-page-flags.h
index 6f2f2720f3ac..ff8032227876 100644
--- a/include/uapi/linux/kernel-page-flags.h
+++ b/include/uapi/linux/kernel-page-flags.h
@@ -7,7 +7,7 @@
  */
 
 #define KPF_LOCKED		0
-#define KPF_ERROR		1
+#define KPF_ERROR		1	/* Now unused */
 #define KPF_REFERENCED		2
 #define KPF_UPTODATE		3
 #define KPF_DIRTY		4
diff --git a/mm/migrate.c b/mm/migrate.c
index 2594a00279f1..c0acb52ac4e4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -561,8 +561,6 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 {
 	int cpupid;
 
-	if (folio_test_error(folio))
-		folio_set_error(newfolio);
 	if (folio_test_referenced(folio))
 		folio_set_referenced(newfolio);
 	if (folio_test_uptodate(folio))
-- 
2.43.0


