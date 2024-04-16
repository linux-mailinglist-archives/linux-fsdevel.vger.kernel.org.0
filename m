Return-Path: <linux-fsdevel+bounces-17013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090A28A6170
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 05:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1651F21372
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 03:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294622075;
	Tue, 16 Apr 2024 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ne7/6EiI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329612B7F;
	Tue, 16 Apr 2024 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237480; cv=none; b=Wem3sBzY41RLQZhJQSl4Nqw5avvIFwf9wuDUBiky24s135QybIy9JahCzBqag4AMqwUIehFSsOUcSv7dEbG6Ne/Hv53k6jM9Vs4sZUS941aBmxsAjOzHK6QxpK4vmy0ggNy6Ndy0FwvEbxyedroMWJgVHWlHnJsmpWhAflOu5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237480; c=relaxed/simple;
	bh=gfmKDcd9YWE/Cir+i8fsK+4kZ7g8NKRJF3hQTcwcF2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DN3m3iHlIis8/Ud7lxx/pkhc7659YG4arv8UzQWeWC+3iFGQdftPEPzCRaMB4vEUzAuFxskAwFHp6WBK/OrQp6JwGemZ6ijTkBjkOGxjgKzBdC/pmJqH+4EUgfSYQaQ3Bv6tzD01onI0t5Ls3Nb4SCCx1bnGt2f9VmRhIa/DJLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ne7/6EiI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=DjzRuP73q58spUrrIonqOCGah9N8XwVh2uAGIuI3AVE=; b=Ne7/6EiIYH3cUo0cIyllU/Vgm7
	VKkO0zh2mLQy61Y2Ne/j89FWd7Cljqj6Us6C1LN67NKmC6cEzHfXKJAIt9r5jpuBiCRS+asbXUGMB
	2T8Zi6F2aHHwMI760ZySpyOVe/Jsr9f4rvlL50Ynfv9dFfjwkndE2Lnz+OU1paEVXqvLf7YpENQey
	pMeX2oDTsjtlpoO9cBNS/NWpf2YuNW1g24C6GCOXnaKgZByhK4fsJpoyfP8oCUg48iOAH8GF8+f0J
	Lusvhl5OL7FRJLrSYMJ8imO40JlUt3T6W4an3FCihYYvVbEL26P4EM1yf4Ja3uh2Z+reo0inFIbVI
	BJSLGGlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwZKW-0000000H6b9-1c63;
	Tue, 16 Apr 2024 03:17:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 7/8] buffer: Improve bdev_getblk documentation
Date: Tue, 16 Apr 2024 04:17:51 +0100
Message-ID: <20240416031754.4076917-8-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416031754.4076917-1-willy@infradead.org>
References: <20240416031754.4076917-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some more information about the state of the buffer_head returned.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 60829312787a..ed698caa8834 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1424,6 +1424,11 @@ EXPORT_SYMBOL(__find_get_block);
  * @size: The size of buffer_heads for this @bdev.
  * @gfp: The memory allocation flags to use.
  *
+ * The returned buffer head has its reference count incremented, but is
+ * not locked.  The caller should call brelse() when it has finished
+ * with the buffer.  The buffer may not be uptodate.  If needed, the
+ * caller can bring it uptodate either by reading it or overwriting it.
+ *
  * Return: The buffer head, or NULL if memory could not be allocated.
  */
 struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
-- 
2.43.0


