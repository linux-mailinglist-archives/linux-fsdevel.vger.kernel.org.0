Return-Path: <linux-fsdevel+bounces-26539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B28295A555
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62DC283853
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD1316F27F;
	Wed, 21 Aug 2024 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WylXN9Ka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6275A1684AB
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268898; cv=none; b=FZzbwv97NgKWSyQGNMQw9PAEIuSCa8r5Fz3AXWO7BAqbH68DjmqSpGa2ITOVAW36paIKoySTTZQeGVvPq+8lG7DKlvGe54iyG8wqU9gYo73HC7jiAK/tjKSNroO/tzJ/RSvt6YHUnDAiDap3O9gqPd4UqnUC0yS/xTaor2z7mFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268898; c=relaxed/simple;
	bh=Sbi7u/F05xjUQGNDJZ2A6rIQmJj66v+ZWRoN7Pc5mB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuhaJOrfQvMDi16rpNKVUVqpqnZpoIghVw2lkecTHJBdL5HuJEWm6kyEhknN9VrdEhKfCJWyZtwpav40xCJybDVDgrFJHWkwO83q3QgJ1DkNRh40UA+rnHpjjPy9wZf3LpcTqkanOCBBySYAeLZFqvpe+IvJRR2Klm5grxWf49E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WylXN9Ka; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=uK8Vt42wFQRzdcmG5GR/Wkh51WwyJybLOsQGLqtZDk0=; b=WylXN9KaKLZCC27qUPd+VKLvzI
	EEywSDbKYBo1MyvJbciFl8KGyL2yLzGdrPEZ3uKpBHk01qt8OMll5J4+luB2P0CKHS3XazzH19/vk
	VnF7KdvducHWtJYgDK7RFspQ7razapMZQ/3Nu4AaedbJBRGxiyvqJMr1zjS6PvHId9b+EmD2Z9gb3
	VSNUG2wL456sm7IGFeOhAHbB/N/1U3EXity8fcoUbar3SLRB8ZsxMGdy1A8Z4e2BYMLhGU/+Y2YU1
	6cdKUXUNwO7yMDl9Pordxy+JPhxLXfBqshlhHmdZaeCFV4ZXUnWRtTcmL0eQdYj9B/L63KQWtJ0Qj
	3C8+5NOw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgr6V-00000009cql-19FT;
	Wed, 21 Aug 2024 19:34:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 06/10] mm: Remove PageMlocked
Date: Wed, 21 Aug 2024 20:34:39 +0100
Message-ID: <20240821193445.2294269-7-willy@infradead.org>
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
 Documentation/mm/unevictable-lru.rst |  4 ++--
 include/linux/page-flags.h           | 13 ++++++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/mm/unevictable-lru.rst b/Documentation/mm/unevictable-lru.rst
index 2feb2ed51ae2..255ef12a432b 100644
--- a/Documentation/mm/unevictable-lru.rst
+++ b/Documentation/mm/unevictable-lru.rst
@@ -253,8 +253,8 @@ Basic Management
 
 mlocked pages - pages mapped into a VM_LOCKED VMA - are a class of unevictable
 pages.  When such a page has been "noticed" by the memory management subsystem,
-the page is marked with the PG_mlocked flag.  This can be manipulated using the
-PageMlocked() functions.
+the folio is marked with the PG_mlocked flag.  This can be manipulated using
+folio_set_mlocked() and folio_clear_mlocked() functions.
 
 A PG_mlocked page will be placed on the unevictable list when it is added to
 the LRU.  Such pages can be "noticed" by memory management in several places:
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index bdf24f65d998..f1358f86a673 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -585,12 +585,15 @@ FOLIO_FLAG(unevictable, FOLIO_HEAD_PAGE)
 	FOLIO_TEST_CLEAR_FLAG(unevictable, FOLIO_HEAD_PAGE)
 
 #ifdef CONFIG_MMU
-PAGEFLAG(Mlocked, mlocked, PF_NO_TAIL)
-	__CLEARPAGEFLAG(Mlocked, mlocked, PF_NO_TAIL)
-	TESTSCFLAG(Mlocked, mlocked, PF_NO_TAIL)
+FOLIO_FLAG(mlocked, FOLIO_HEAD_PAGE)
+	__FOLIO_CLEAR_FLAG(mlocked, FOLIO_HEAD_PAGE)
+	FOLIO_TEST_CLEAR_FLAG(mlocked, FOLIO_HEAD_PAGE)
+	FOLIO_TEST_SET_FLAG(mlocked, FOLIO_HEAD_PAGE)
 #else
-PAGEFLAG_FALSE(Mlocked, mlocked) __CLEARPAGEFLAG_NOOP(Mlocked, mlocked)
-	TESTSCFLAG_FALSE(Mlocked, mlocked)
+FOLIO_FLAG_FALSE(mlocked)
+	__FOLIO_CLEAR_FLAG_NOOP(mlocked)
+	FOLIO_TEST_CLEAR_FLAG_FALSE(mlocked)
+	FOLIO_TEST_SET_FLAG_FALSE(mlocked)
 #endif
 
 #ifdef CONFIG_ARCH_USES_PG_UNCACHED
-- 
2.43.0


