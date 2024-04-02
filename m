Return-Path: <linux-fsdevel+bounces-15921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B924F895D64
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0E31C22AC8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1F815D5C5;
	Tue,  2 Apr 2024 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hHgsV95r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6231515B996
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088778; cv=none; b=jzOmybG8wU92MwBr8O5m1lpnUeAmZe2ER4TjPyPPQ5eETJx21jq+MjDd5oHhqR+IWK8LNxh7yGn9DuizxmbeBVGUmsjWAZpdxcRZOhCLY6kIo/uqp82BqXzpsd4H8+0mJs+Nq2to77Fl/A4BleNmTgpjcGh3igI1LUe6X69e0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088778; c=relaxed/simple;
	bh=9ns8nWQh2DkqdjvUOA1YeWPXGfE+LqqSDxIgIr1QXOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5/qy+Oj4KLQY5H++EWUFx5vuuRBjuiaZWLH5yhhsSN5T6YQqGAO/hnfCzSHNenuhN1olzLa2gm3+9k5MpV0tbG8UR3ckQFAm2ZaXyhTJUe1cMW1DGjpuBUyC+jw7AeYI6TYV4mKtNyPNPvDuJlVW6Hr7NMUxHaXh3HbHvLfJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hHgsV95r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=XgHhtlpvJ49Xweosp373tZJsyvHxh++z1AM8v71Pnes=; b=hHgsV95re1YND5Pn+Vd6K76jiD
	0JSEzVWXDoAxskW7k5TUtQE8pr1/EyqcnIjIW9mbirxrDeD2VzKD37AeUl4+kutzYrNvSfqQ8MPr3
	B5p3dcaBk6f8EJTUoG7GM/XP9nwnNVh2G6/7qayZXzH/9gwjXYHHUUp7PuCk1pagf9WY/a2ZChrL8
	ZESIJsjFR+mq9R7TT3KNCKihnHAAUie61zErnCeJ4uAgbcmZRGS953T57sU7k1/nPAtVcngZe3K+E
	kmFz28kgYOofRQn0a3IVbKvAnhnfS5nC57zpGZba4wj5vWG2AC/0CxuaXiL/bYiv9tYCTwL4VqGbI
	ByUM+yyw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrkV5-00000003qeF-33C2;
	Tue, 02 Apr 2024 20:12:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] mm: Remove page_idle and page_young wrappers
Date: Tue,  2 Apr 2024 21:12:50 +0100
Message-ID: <20240402201252.917342-4-willy@infradead.org>
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

All users have now been converted to the folio equivalents, so
remove the page wrappers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page_idle.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
index 511e22ef459f..6357f1e7918a 100644
--- a/include/linux/page_idle.h
+++ b/include/linux/page_idle.h
@@ -119,29 +119,4 @@ static inline void folio_clear_idle(struct folio *folio)
 }
 
 #endif /* CONFIG_PAGE_IDLE_FLAG */
-
-static inline bool page_is_young(struct page *page)
-{
-	return folio_test_young(page_folio(page));
-}
-
-static inline void set_page_young(struct page *page)
-{
-	folio_set_young(page_folio(page));
-}
-
-static inline bool test_and_clear_page_young(struct page *page)
-{
-	return folio_test_clear_young(page_folio(page));
-}
-
-static inline bool page_is_idle(struct page *page)
-{
-	return folio_test_idle(page_folio(page));
-}
-
-static inline void set_page_idle(struct page *page)
-{
-	folio_set_idle(page_folio(page));
-}
 #endif /* _LINUX_MM_PAGE_IDLE_H */
-- 
2.43.0


