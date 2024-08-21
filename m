Return-Path: <linux-fsdevel+bounces-26537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA61195A553
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D681F22DDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8DE16F0DD;
	Wed, 21 Aug 2024 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vjof5RZh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279E16DC12
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268897; cv=none; b=gCUNFMVkEivkeyW9Sy4LbWcvTi+oj2gZIZ1y0L6rsqkhD7yZZZ8yl5AafrwS4VFl2DLJweU1wHiqbLXqC5lblSF1uQcI9wONxImWTsO5A3s9POJ3mnStlo9nmYJoab1xeHkTqaHQGE0DUiuLoMtuxIEzJKqkGNqHvVUvMf1Hu9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268897; c=relaxed/simple;
	bh=27rn/nZFzFSkNAIMnk5FQ5GGWC4NbJUaFzjbhmG52cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9dk6pEXRZmFLkNLwFXt1EUZFxyypcOXWWZF3vElF7cnDOhtCJ4FAZYjwzfH9Mn9bYh/pKsmbaPoqaIKm7dkyTkXb7T8SvbayMTMGQnzUhJSoW3NarIF7luiFvs/LISp8z9dAjpy9LamwROQPzjcxlQiLfWoi8p0zQhmWLbaV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vjof5RZh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=7V2bV5roZ/7Rqnt/F40jOHr7KxmrZpegYZisQPKdM5k=; b=Vjof5RZhhPS5QZIffxl8qmogr9
	p70RfChVk3jAbVsrkyyxa7n4sXS9NhofK5bepKsqxla8i7NTXVFHk+Zumc9/MmDxFUAb3LEGFHfDk
	5IjTtzIknToelA7DkoVqLwmITzeaTvYDzDz6g4sjXK0Y4eqp3AdKR0hc2mPW08uZB/FnbnTyzRMPi
	JPNKR3yeiJNtl+1GlSuhO+zVRw/yuZY8RREZIGCcEiOwEar60rvX2WkVw7tSi+L69D4AZ/ZVFscY3
	/yi5TrjyT5nB9NhkChfB6uuhxFdgrCxDaBKNmbssd7f6bDTx4hdNG0NRMANPI+iSz+BD4nGQIE/UE
	5BiCtH+w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgr6V-00000009cr6-2vRi;
	Wed, 21 Aug 2024 19:34:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 09/10] mm: Rename PG_mappedtodisk to PG_owner_2
Date: Wed, 21 Aug 2024 20:34:42 +0100
Message-ID: <20240821193445.2294269-10-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821193445.2294269-1-willy@infradead.org>
References: <20240821193445.2294269-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag has similar constraints to PG_owner_priv_1 -- it is ignored
by core code, and is entirely for the use of the code which allocated
the folio.  Since the pagecache does not use it, individual filesystems
can use it.  The bufferhead code does use it, so filesystems which use
the buffer cache must not use it for another purpose.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/page.c                    |  2 +-
 include/linux/kernel-page-flags.h |  2 +-
 include/linux/page-flags.h        | 24 ++++++++++++++++--------
 include/trace/events/mmflags.h    |  2 +-
 tools/mm/page-types.c             | 10 +++++-----
 5 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 73a0f872d97f..e74e639893be 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -211,7 +211,7 @@ u64 stable_page_flags(const struct page *page)
 #endif
 
 	u |= kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
-	u |= kpf_copy_bit(k, KPF_MAPPEDTODISK,	PG_mappedtodisk);
+	u |= kpf_copy_bit(k, KPF_OWNER_2,	PG_owner_2);
 	u |= kpf_copy_bit(k, KPF_PRIVATE,	PG_private);
 	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
 	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
diff --git a/include/linux/kernel-page-flags.h b/include/linux/kernel-page-flags.h
index 859f4b0c1b2b..7c587a711be1 100644
--- a/include/linux/kernel-page-flags.h
+++ b/include/linux/kernel-page-flags.h
@@ -10,7 +10,7 @@
  */
 #define KPF_RESERVED		32
 #define KPF_MLOCKED		33
-#define KPF_MAPPEDTODISK	34
+#define KPF_OWNER_2		34
 #define KPF_PRIVATE		35
 #define KPF_PRIVATE_2		36
 #define KPF_OWNER_PRIVATE	37
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 3513aa666c31..c001e3c29c4c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -101,12 +101,12 @@ enum pageflags {
 	PG_waiters,		/* Page has waiters, check its waitqueue. Must be bit #7 and in the same byte as "PG_locked" */
 	PG_active,
 	PG_workingset,
-	PG_owner_priv_1,	/* Owner use. If pagecache, fs may use*/
+	PG_owner_priv_1,	/* Owner use. If pagecache, fs may use */
+	PG_owner_2,		/* Owner use. If pagecache, fs may use */
 	PG_arch_1,
 	PG_reserved,
 	PG_private,		/* If pagecache, has fs-private data */
 	PG_private_2,		/* If pagecache, has fs aux data */
-	PG_mappedtodisk,	/* Has blocks allocated on-disk */
 	PG_reclaim,		/* To be reclaimed asap */
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
@@ -131,6 +131,11 @@ enum pageflags {
 
 	PG_readahead = PG_reclaim,
 
+	/* Anonymous memory (and shmem) */
+	PG_swapcache = PG_owner_priv_1, /* Swap page: swp_entry_t in private */
+	/* Some filesystems */
+	PG_checked = PG_owner_priv_1,
+
 	/*
 	 * Depending on the way an anonymous folio can be mapped into a page
 	 * table (e.g., single PMD/PUD/CONT of the head page vs. PTE-mapped
@@ -138,13 +143,13 @@ enum pageflags {
 	 * tail pages of an anonymous folio. For now, we only expect it to be
 	 * set on tail pages for PTE-mapped THP.
 	 */
-	PG_anon_exclusive = PG_mappedtodisk,
-
-	/* Filesystems */
-	PG_checked = PG_owner_priv_1,
+	PG_anon_exclusive = PG_owner_2,
 
-	/* SwapBacked */
-	PG_swapcache = PG_owner_priv_1,	/* Swap page: swp_entry_t in private */
+	/*
+	 * Set if all buffer heads in the folio are mapped.
+	 * Filesystems which do not use BHs can use it for their own purpose.
+	 */
+	PG_mappedtodisk = PG_owner_2,
 
 	/* Two page bits are conscripted by FS-Cache to maintain local caching
 	 * state.  These bits are set on pages belonging to the netfs's inodes
@@ -540,6 +545,9 @@ FOLIO_FLAG(swapbacked, FOLIO_HEAD_PAGE)
 PAGEFLAG(Private, private, PF_ANY)
 PAGEFLAG(Private2, private_2, PF_ANY) TESTSCFLAG(Private2, private_2, PF_ANY)
 
+/* owner_2 can be set on tail pages for anon memory */
+FOLIO_FLAG(owner_2, FOLIO_HEAD_PAGE)
+
 /*
  * Only test-and-set exist for PG_writeback.  The unconditional operators are
  * risky: they bypass page accounting.
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index c151cc21d367..3b51558cdc9b 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -107,13 +107,13 @@
 	DEF_PAGEFLAG_NAME(active),					\
 	DEF_PAGEFLAG_NAME(workingset),					\
 	DEF_PAGEFLAG_NAME(owner_priv_1),				\
+	DEF_PAGEFLAG_NAME(owner_2),					\
 	DEF_PAGEFLAG_NAME(arch_1),					\
 	DEF_PAGEFLAG_NAME(reserved),					\
 	DEF_PAGEFLAG_NAME(private),					\
 	DEF_PAGEFLAG_NAME(private_2),					\
 	DEF_PAGEFLAG_NAME(writeback),					\
 	DEF_PAGEFLAG_NAME(head),					\
-	DEF_PAGEFLAG_NAME(mappedtodisk),				\
 	DEF_PAGEFLAG_NAME(reclaim),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
 	DEF_PAGEFLAG_NAME(unevictable)					\
diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
index 8d5595b6c59f..8ca41c41105e 100644
--- a/tools/mm/page-types.c
+++ b/tools/mm/page-types.c
@@ -71,7 +71,7 @@
 /* [32-] kernel hacking assistances */
 #define KPF_RESERVED		32
 #define KPF_MLOCKED		33
-#define KPF_MAPPEDTODISK	34
+#define KPF_OWNER_2		34
 #define KPF_PRIVATE		35
 #define KPF_PRIVATE_2		36
 #define KPF_OWNER_PRIVATE	37
@@ -129,7 +129,7 @@ static const char * const page_flag_names[] = {
 
 	[KPF_RESERVED]		= "r:reserved",
 	[KPF_MLOCKED]		= "m:mlocked",
-	[KPF_MAPPEDTODISK]	= "d:mappedtodisk",
+	[KPF_OWNER_2]		= "d:owner_2",
 	[KPF_PRIVATE]		= "P:private",
 	[KPF_PRIVATE_2]		= "p:private_2",
 	[KPF_OWNER_PRIVATE]	= "O:owner_private",
@@ -472,9 +472,9 @@ static int bit_mask_ok(uint64_t flags)
 
 static uint64_t expand_overloaded_flags(uint64_t flags, uint64_t pme)
 {
-	/* Anonymous pages overload PG_mappedtodisk */
-	if ((flags & BIT(ANON)) && (flags & BIT(MAPPEDTODISK)))
-		flags ^= BIT(MAPPEDTODISK) | BIT(ANON_EXCLUSIVE);
+	/* Anonymous pages use PG_owner_2 for anon_exclusive */
+	if ((flags & BIT(ANON)) && (flags & BIT(OWNER_2)))
+		flags ^= BIT(OWNER_2) | BIT(ANON_EXCLUSIVE);
 
 	/* SLUB overloads several page flags */
 	if (flags & BIT(SLAB)) {
-- 
2.43.0


