Return-Path: <linux-fsdevel+bounces-55799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FC0B0EFA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB28D1C8425D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5019528DB47;
	Wed, 23 Jul 2025 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cvVJ+cjO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECDA28D837;
	Wed, 23 Jul 2025 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266000; cv=none; b=hCnQc9GpFPqNzDqPxobMMj3OXLa9V+9HmSGwQgQoImxv38tB3WeePUckSGuM0DKbBU2UGvwlvm5E2x/ID7xQ9Jy1ZW2WqzY5ex6LbRnSd9TILNbvFQO54t3WdrlIwLcBf4qkAt8ixLck5r62UnEVeWxeUKuSj1QahxuIMHvJmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266000; c=relaxed/simple;
	bh=K/LMjARgw8yRx0dnUdhIdHCetxgEKd4xEX13GnydfXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j902HiL48ZWdBAlDISSbYWReyXMyEjpIh6dKn1KtuA6gnTq/NCgs0CjHg0I0JrC/So8LztEfQMEDF5SV9dWsQ/cNBfK9dIqGl+cH0OpTvb3P6iVJ2voHA7pXDNAjZM78jcbLjbopDcyZypg5kS0Bu7dA29Jcv8ny/egdl+0khho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cvVJ+cjO; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ud
	CM1lsYiKDqT/YgXrbnqPpuwPrKh4p4pm/0FsOfkOQ=; b=cvVJ+cjO79ogm1pZIH
	FG4mYvRNpETiEHgDuyk/LeM4xumeFz9Vz4d3oyotark5XFrNNLErXOoS4Kmzh59+
	+mfZy0k6E6j3fURxJDbXPvSUJEcWXHOP6na0O6o5ZnGeQ69GGUNUIoBLMvSWthWf
	hXcc0p4TZFImJ9s3HX/qe7roc=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXpNEAt4BoaJF8HA--.11729S4;
	Wed, 23 Jul 2025 18:18:41 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [RFC PATCH 2/3] mm/filemap: Avoid modifying iocb->ki_flags for AIO in filemap_get_pages()
Date: Wed, 23 Jul 2025 18:18:24 +0800
Message-ID: <20250723101825.607184-3-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723101825.607184-1-chizhiling@163.com>
References: <20250723101825.607184-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXpNEAt4BoaJF8HA--.11729S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw17Cr17GFyDZw48WryxAFb_yoW5Gr1fpF
	WrGas5KayxXFy29rWfJasrua15WF18J3yayFy3Ka17Z3Z8tr95KF4SkFy8KF43AryrJF12
	qF18tayUCFWjvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFOJnUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiTwyTnWiArAz2oQAAsS

From: Chi Zhiling <chizhiling@kylinos.cn>

Setting IOCB_NOWAIT in filemap_get_pages() for AIO is only used to
indicate not to block in the filemap_update_page(), with no other purpose.
Moreover, in filemap_read(), IOCB_NOWAIT will be set again for AIO.

Therefore, adding a parameter to the filemap_update_page function to
explicitly indicate not to block serves the same purpose as indicating
through iocb->ki_flags, thus avoiding modifications to iocb->ki_flags.

This patch does not change the original logic and is preparation for the
next patch.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/filemap.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index af12d1cecc7d..350080f579ef 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2454,11 +2454,15 @@ static bool filemap_range_uptodate(struct address_space *mapping,
 
 static int filemap_update_page(struct kiocb *iocb,
 		struct address_space *mapping, size_t count,
-		struct folio *folio, bool need_uptodate)
+		struct folio *folio, bool need_uptodate,
+		bool no_wait)
 {
 	int error;
+	int flags = iocb->ki_flags;
+	if (no_wait)
+		flags |= IOCB_NOWAIT;
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
+	if (flags & IOCB_NOWAIT) {
 		if (!filemap_invalidate_trylock_shared(mapping))
 			return -EAGAIN;
 	} else {
@@ -2467,9 +2471,9 @@ static int filemap_update_page(struct kiocb *iocb,
 
 	if (!folio_trylock(folio)) {
 		error = -EAGAIN;
-		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
+		if (flags & (IOCB_NOWAIT | IOCB_NOIO))
 			goto unlock_mapping;
-		if (!(iocb->ki_flags & IOCB_WAITQ)) {
+		if (!(flags & IOCB_WAITQ)) {
 			filemap_invalidate_unlock_shared(mapping);
 			/*
 			 * This is where we usually end up waiting for a
@@ -2493,7 +2497,7 @@ static int filemap_update_page(struct kiocb *iocb,
 		goto unlock;
 
 	error = -EAGAIN;
-	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
+	if (flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
 		goto unlock;
 
 	error = filemap_read_folio(iocb->ki_filp, mapping->a_ops->read_folio,
@@ -2621,11 +2625,13 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 			goto err;
 	}
 	if (!folio_test_uptodate(folio)) {
+		bool no_wait = false;
+
 		if ((iocb->ki_flags & IOCB_WAITQ) &&
 		    folio_batch_count(fbatch) > 1)
-			iocb->ki_flags |= IOCB_NOWAIT;
+			no_wait = true;
 		err = filemap_update_page(iocb, mapping, count, folio,
-					  need_uptodate);
+					  need_uptodate, no_wait);
 		if (err)
 			goto err;
 	}
-- 
2.43.0


