Return-Path: <linux-fsdevel+bounces-15920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B366895D63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2581C21AFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1AD15D5C2;
	Tue,  2 Apr 2024 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dJw40H3t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC9712BF20
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088778; cv=none; b=asQacPEhkWXOVMFDTU3VAc0XJx0x9Z+QEPA9y9wQfGIW8MlVARZazDFWUOZvo2cTVoi9fM/QQWpoK714CPaT1/mJ/Q6O9Gr7nL0wHHlHc4Bju8Um4RVMviI5sbP4/y0Q4H3nrnSWdmNfqifHw2vldiXeXVgWiJVuEUh32WU8PyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088778; c=relaxed/simple;
	bh=Ddj20Dmm2VkJBDrWMi/jFBgm4P50XBEZk+6ivSXSQ/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNMUDEOZ/dQmRCaLXMkI6hdmgTgYnzF3SgcdWYTGVGVFqbU2qaEIZDqNFsa/aVbGSRn34iSOASaoals5JG7FuxYJaRQ3+BXdG8BBrDFw1PUPLJLNRAQGe6lCLHjofyO67QdT+kelCN3DObNA110vnSzZv4VGnCSothZFy7CzQLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dJw40H3t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QwLgf2EYj+juUDGhuHAn9rfAj5hC3bzzsJxsabP0fBQ=; b=dJw40H3tN3hNRovf1r8NCLPJ2f
	eB16leQKR+jHC7/IoLHhW8S3puuGssGFOJxDOsA6f3E5A6GtSj8egTzso2O/M0Xmh/hr6vRvV7udp
	bAtsgOq9wAbnenEbFp5pRxE7d2C/ou5scvJuy24Aat1E3iEppZG4Ptwg8e68I/naY6AWMdHYZIPxz
	mtgnvJBxqrN9DB/pjTGkEGqMs3F+/A+oY2hj5vatkdlXTKB63UatHsoJgCGGaCyEeE3YYkOEreHM8
	W0Ge/vmkJMT9p5k/ZvLgg8O0n3+30FuX1j4wWe45QxZ09zYCklVkNGHR91z5Ldw2pAc/LQLRAC5po
	E/l9FeMg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrkV5-00000003qeM-3Y1u;
	Tue, 02 Apr 2024 20:12:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] mm: Generate PAGE_IDLE_FLAG definitions
Date: Tue,  2 Apr 2024 21:12:51 +0100
Message-ID: <20240402201252.917342-5-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402201252.917342-1-willy@infradead.org>
References: <20240402201252.917342-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_PAGE_IDLE_FLAG is not set, we can use FOLIO_FLAG_FALSE()
to generate these definitions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h |  9 ++++++++-
 include/linux/page_idle.h  | 37 ++-----------------------------------
 2 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 888353c209c0..a49739a67005 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -626,12 +626,19 @@ PAGEFLAG_FALSE(HWPoison, hwpoison)
 #define __PG_HWPOISON 0
 #endif
 
-#if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
+#ifdef CONFIG_PAGE_IDLE_FLAG
+#ifdef CONFIG_64BIT
 FOLIO_TEST_FLAG(young, FOLIO_HEAD_PAGE)
 FOLIO_SET_FLAG(young, FOLIO_HEAD_PAGE)
 FOLIO_TEST_CLEAR_FLAG(young, FOLIO_HEAD_PAGE)
 FOLIO_FLAG(idle, FOLIO_HEAD_PAGE)
 #endif
+/* See page_idle.h for !64BIT workaround */
+#else /* !CONFIG_PAGE_IDLE_FLAG */
+FOLIO_FLAG_FALSE(young)
+FOLIO_TEST_CLEAR_FLAG_FALSE(young)
+FOLIO_FLAG_FALSE(idle)
+#endif
 
 /*
  * PageReported() is used to track reported free pages within the Buddy
diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
index 6357f1e7918a..89ca0d5dc1e7 100644
--- a/include/linux/page_idle.h
+++ b/include/linux/page_idle.h
@@ -6,9 +6,7 @@
 #include <linux/page-flags.h>
 #include <linux/page_ext.h>
 
-#ifdef CONFIG_PAGE_IDLE_FLAG
-
-#ifndef CONFIG_64BIT
+#if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
 /*
  * If there is not enough space to store Idle and Young bits in page flags, use
  * page ext flags instead.
@@ -87,36 +85,5 @@ static inline void folio_clear_idle(struct folio *folio)
 	clear_bit(PAGE_EXT_IDLE, &page_ext->flags);
 	page_ext_put(page_ext);
 }
-#endif /* !CONFIG_64BIT */
-
-#else /* !CONFIG_PAGE_IDLE_FLAG */
-
-static inline bool folio_test_young(const struct folio *folio)
-{
-	return false;
-}
-
-static inline void folio_set_young(struct folio *folio)
-{
-}
-
-static inline bool folio_test_clear_young(struct folio *folio)
-{
-	return false;
-}
-
-static inline bool folio_test_idle(const struct folio *folio)
-{
-	return false;
-}
-
-static inline void folio_set_idle(struct folio *folio)
-{
-}
-
-static inline void folio_clear_idle(struct folio *folio)
-{
-}
-
-#endif /* CONFIG_PAGE_IDLE_FLAG */
+#endif /* CONFIG_PAGE_IDLE_FLAG && !64BIT */
 #endif /* _LINUX_MM_PAGE_IDLE_H */
-- 
2.43.0


