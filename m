Return-Path: <linux-fsdevel+bounces-26545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B495A55B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1020DB21511
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB5516F0D0;
	Wed, 21 Aug 2024 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DjAQCtnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC20016EC1B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268911; cv=none; b=Qebgzu/il6QXfAWxS4d8tCqGo5lhgsSCMEjebJBIVWtXaOtjFMW+bDi4/VRhbtnaxoXPzVIm6DEDKZ9I022vOflBmCxf5SiiDzrMuj+KF4GcNIgSVBb7aZ2hM0QiZe0cO6IeXD8HjlsEBx25IVqRBBYzp3YWl/7wqUB6j/BpVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268911; c=relaxed/simple;
	bh=wtH1AjxGt8vYQLDKVnTMA95IJzj/nJ1aUZEg7EXtr0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUcAeiQcGytJA6ZxvajNsM7D35m/CjLHGTu7ahFc0Fecp02hi+83SocuhRhiOSKzDipTdZ8dSM981PiCQWl4ySwwtac456vadLj2vrGk+I59Y5M5GJtgOSjAr8hZAbTDvBBLV09R8ZGpE2LBKb5UeUxb6z5ERgMFcMG1Jy7cSYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DjAQCtnV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=WTfKAvywvhG7fx5/3Y/15ASwygZFYxxage+aqiSBrsU=; b=DjAQCtnV3jMm8iu067wu+Qr5Cu
	CjerHrxRxu836V35pS0wiXRDF4UYquh2YNJp3b3fCuu5mWuvXOP5xwgyAXjwCXgi4zazW9XsFqUaq
	YybU3J67oxBHAr/ISIvG0C4729Wo8A/KDerpkOCJuTl82sMdMXlFiPMPUKvrUn+PMAvHhMEruW3hF
	5U+uX86iARzUbClb28wJuZ/nehUlFmwOQfE6JWzEc7Ji2mlb+cIaQmXBaWCyCcGadbpUO4aiI7p0+
	+6KgZqGe/GR2u4HZALZetISi1tz6x89FZXjQ9Tt71ekeyResehRCRbW0xi9RXFhUqozRKeB6BeewN
	Z2OEaoxg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgr6U-00000009cqb-3Pnq;
	Wed, 21 Aug 2024 19:34:46 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 01/10] mm: Remove PageActive
Date: Wed, 21 Aug 2024 20:34:34 +0100
Message-ID: <20240821193445.2294269-2-willy@infradead.org>
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

This flag is now only used on folios, so we can remove all the page
accessors.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0c738bda5d98..65171b8fd661 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -510,8 +510,9 @@ PAGEFLAG(Dirty, dirty, PF_HEAD) TESTSCFLAG(Dirty, dirty, PF_HEAD)
 	__CLEARPAGEFLAG(Dirty, dirty, PF_HEAD)
 PAGEFLAG(LRU, lru, PF_HEAD) __CLEARPAGEFLAG(LRU, lru, PF_HEAD)
 	TESTCLEARFLAG(LRU, lru, PF_HEAD)
-PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
-	TESTCLEARFLAG(Active, active, PF_HEAD)
+FOLIO_FLAG(active, FOLIO_HEAD_PAGE)
+	__FOLIO_CLEAR_FLAG(active, FOLIO_HEAD_PAGE)
+	FOLIO_TEST_CLEAR_FLAG(active, FOLIO_HEAD_PAGE)
 PAGEFLAG(Workingset, workingset, PF_HEAD)
 	TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)	   /* Used by some filesystems */
-- 
2.43.0


