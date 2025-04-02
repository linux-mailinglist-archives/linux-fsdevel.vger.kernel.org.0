Return-Path: <linux-fsdevel+bounces-45561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18816A7971A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD023A72C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 21:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C7E1F3B82;
	Wed,  2 Apr 2025 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="suhrBjDL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE261F09B8
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627978; cv=none; b=E0YK2L/YCvQdHG9fQZbDcM5SnAtE+vcxkHwdInjGVYheIbHsiOMTTMH7PRsOsfmOuxtLfIOcpcycEbtfOguYiEvfc8H3ZbN9PAxJWhEyWm6F7PpZkYmtZPpiZRSB8v2517g8QoBmEXhcNnoMS/bQKU+qc8zhzlorwl/tRluz2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627978; c=relaxed/simple;
	bh=xDBMK9tnXE19cE32DvZI9p5KxQe77wUbhlzM80iEwho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dm4MDcgTx2cf3J6gnsTIWryyoyVsbiSUlxEJVE9VDshQpVpUc5OiDx7R/0+ZSl1JZFxLH2YxtFqCgF7jh/I3RIzrG3x+aJDz8Yw1e3SFv1pmnZFzGbSiRgCTLJ4POOk7ZG7bc/Y/0GvBGI8LbMykdleQ44zH35CpI/uDzbUadnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=suhrBjDL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=FK4WOp5c58Z+NW1ocgPzv/oQMmQ5qTAfrmyeSlx2/M4=; b=suhrBjDLDbKfVT2i3Wu1H0JKrE
	eKEkCQRVRl0mJNXbrsfHdzRalicBbWC4MsuV6n1s6xYB52VgXHfx0kSNNqNEpDoKjj7GBAUFfHbTG
	czMv2i+MiYP2o0E33C+tDMxYWm4yFrjstLqzXzFLXnas/vAueK/lVYDAgWj34Mnv0Fp6zxRST9WZC
	LnYcQQDA/6cBiLcCdLptTlovyFQUxY9lngBUcHv+bE8Zz7OhbJDH4+cw67VdyoVvXw5FN+6cv/aRH
	NNoXaVorUlfkGhzlhzgPy7ESETcpmVvcgH98SOiBdYD+kQBGWaoKaYeZwIwt9TB1BGIdK3I2PIvO/
	QF0xapQw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u05Hr-0000000AFqi-1LhK;
	Wed, 02 Apr 2025 21:06:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/8] filemap: Remove readahead_page_batch()
Date: Wed,  2 Apr 2025 22:06:09 +0100
Message-ID: <20250402210612.2444135-8-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402210612.2444135-1-willy@infradead.org>
References: <20250402210612.2444135-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function has no more callers; delete it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c5c9b3770d75..af25fb640463 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1447,20 +1447,6 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 	return i;
 }
 
-/**
- * readahead_page_batch - Get a batch of pages to read.
- * @rac: The current readahead request.
- * @array: An array of pointers to struct page.
- *
- * Context: The pages are locked and have an elevated refcount.  The caller
- * should decreases the refcount once the page has been submitted for I/O
- * and unlock the page once all I/O to that page has completed.
- * Return: The number of pages placed in the array.  0 indicates the request
- * is complete.
- */
-#define readahead_page_batch(rac, array)				\
-	__readahead_batch(rac, array, ARRAY_SIZE(array))
-
 /**
  * readahead_pos - The byte offset into the file of this readahead request.
  * @rac: The readahead request.
-- 
2.47.2


