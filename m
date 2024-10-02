Return-Path: <linux-fsdevel+bounces-30644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8375D98CBCF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 06:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212FB1F25602
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 04:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E68B36AF2;
	Wed,  2 Oct 2024 04:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LO+loDKm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B511185;
	Wed,  2 Oct 2024 04:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841677; cv=none; b=L8TufwabGEb6YO7z0/18ToPXTTZr0vpRsePeReycvZDOl/scdKcyKZVo6uI5aosW1vXL8pecjVkBQfLUnjxMIP+QfK8I9gprlTxmHoty/LnClWMIzv6WBVo5pWUNeJArpEzRJYwlQGE+k3poSh+CPc/Zea8uump9BlVihH8640s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841677; c=relaxed/simple;
	bh=zgpvJ+ugFCdGRf7tYOqM8GKaecq3gQ8TAsbfKL7OKYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYvoMmr2WSNXE9DzDNXtdT7X588RrxdKjVobeFFuYCtiU3b16fNJNiwXSZaF0/dI+WW5y4L/Vf9ZUyMepb4Ay2jNrnkHkg08nHe2lzeTPlxD/AYoEJjhRKcZBcN/a/4sVjmMCmeSJ3mQrsdAFeM2T6lece/DLL5QxwRf63jizxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LO+loDKm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=81ggZHnEvcBilUrO8Krf1e9LLlvjup5oMzJTQuGKOy0=; b=LO+loDKm3/JWD5V7y98WPxn+jl
	Av3Bs+DCvSL5oytmlwf4y+dDZSmHfDNlVp0R2k/1kAKQ5bAN4KKJa7nyVa1Y9qNAHxDOavZVHV7dw
	1KdwR9Vxb4OeRabK9McNKm7PIle5OaGCwJUUArWv27qAcGdujiWi01+cU/rMP5bjqOuYM1s0KWGsE
	NSHzSCqOqZ2BeT9rEBWim8BAVLbo9kQmv7ZO4LcZCX00vvgFsdmL1RzxR+UlJZlewhuf7dexRMe9g
	rgKItF4kNoFjRRNEmT11nw40ikRG2qJxVjJFISVSWP1HNJab9/kmtfQFliSuSEKMg1xbe4FqgJjc5
	zznsCgnA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svqY6-00000004I8i-0WIO;
	Wed, 02 Oct 2024 04:01:14 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/6] migrate: Remove references to Private2
Date: Wed,  2 Oct 2024 05:01:08 +0100
Message-ID: <20241002040111.1023018-7-willy@infradead.org>
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

These comments are now stale; rewrite them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index df91248755e4..21264c24a404 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -472,7 +472,7 @@ static int folio_expected_refs(struct address_space *mapping,
  * The number of remaining references must be:
  * 1 for anonymous folios without a mapping
  * 2 for folios with a mapping
- * 3 for folios with a mapping and PagePrivate/PagePrivate2 set.
+ * 3 for folios with a mapping and the private flag set.
  */
 static int __folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int expected_count)
@@ -786,7 +786,7 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
  * @mode: How to migrate the page.
  *
  * Common logic to directly migrate a single LRU folio suitable for
- * folios that do not use PagePrivate/PagePrivate2.
+ * folios that do not have private data.
  *
  * Folios are locked upon entry and exit.
  */
-- 
2.43.0


