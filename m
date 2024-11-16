Return-Path: <linux-fsdevel+bounces-35014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBCF9CFF6A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 16:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C4B1F24559
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC60E80BEC;
	Sat, 16 Nov 2024 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="dEtA5uST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73A2942A;
	Sat, 16 Nov 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731770105; cv=none; b=OGwvclRETdXKqPGvDMG4LW/a5Z9K1hLoYFKUBVs+G8Ne6Yy5/bH48wBbXFZQ3cczzdQDjkU2bHaniadWICkcx/rTWeYQ7D2FUNvMd0d8jlFicz8rBd/FfVxVFAJ7GOxKcfauQ9oPQRcA8fhop2S1vDgptG5FWBoOSNwU/dcHOpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731770105; c=relaxed/simple;
	bh=67qCN2LFPj5ydbZda23+LlMAeSW99PpRs7nR715ypmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rwb17qn6H3fStrDwypoWJ7yfi2ueB+nmLMRpL23Slh3pi7NrnP8xxM+3q8b133n2/o8IsYgrknD87zQ0Gu4yaHrFPmCITxcaJbdE9D2QtkZfr3h5v+tq6/OI/MeNZrS+WqUWqoDOm17j9w247T5ny+mu55cioEeIDxo2Qu3Tbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=dEtA5uST; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=+0extUEjVm7z5Ue/B1qKSYMZ5TW6HJx8FZm8Lh/lwwc=; b=dEtA5uSTFAQQQZZC
	oH1LFfT5zoZM9JOA91yS0QtnAOA7VniTJ3D4z5ENVudnGLhWztNqv6k16mkvkez/1J7Ow2BXd8BWB
	3xM/sldeiAVUK2buun5WuTTMTKJwwg0wSOXfqy0mAr/hWCsdja/DAd8+uyYGq3RdX/D/QGQeJvjTG
	acLer2XzFocF4TlxhicSSGvYm0/g4DPjCUZUUpiSxoxKxi8qEAxRHyPris8ZbECtKRAdg0blKnALF
	Mr2zM4k591nmLDlq9FriJ8qPWE8ue3rbo0fyPPXpLcl2cUcwFvB+NqEXGW/I59tkji/Dhwc5XUmGT
	1oxE56rQT9oWma6g/w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tCKVb-000INb-0j;
	Sat, 16 Nov 2024 15:14:47 +0000
From: linux@treblig.org
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] filemap: Remove unused folio_add_wait_queue
Date: Sat, 16 Nov 2024 15:14:46 +0000
Message-ID: <20241116151446.95555-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

folio_add_wait_queue() has been unused since 2021's
commit 850cba069c26 ("cachefiles: Delete the cachefiles driver pending
rewrite")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/pagemap.h |  5 -----
 mm/filemap.c            | 19 -------------------
 2 files changed, 24 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 68a5f1ff3301..4650416cbf6c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1267,11 +1267,6 @@ void folio_end_private_2(struct folio *folio);
 void folio_wait_private_2(struct folio *folio);
 int folio_wait_private_2_killable(struct folio *folio);
 
-/*
- * Add an arbitrary waiter to a page's wait queue
- */
-void folio_add_wait_queue(struct folio *folio, wait_queue_entry_t *waiter);
-
 /*
  * Fault in userspace address range.
  */
diff --git a/mm/filemap.c b/mm/filemap.c
index 56fa431c52af..b1bdd8ce7f49 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1473,25 +1473,6 @@ static int folio_put_wait_locked(struct folio *folio, int state)
 	return folio_wait_bit_common(folio, PG_locked, state, DROP);
 }
 
-/**
- * folio_add_wait_queue - Add an arbitrary waiter to a folio's wait queue
- * @folio: Folio defining the wait queue of interest
- * @waiter: Waiter to add to the queue
- *
- * Add an arbitrary @waiter to the wait queue for the nominated @folio.
- */
-void folio_add_wait_queue(struct folio *folio, wait_queue_entry_t *waiter)
-{
-	wait_queue_head_t *q = folio_waitqueue(folio);
-	unsigned long flags;
-
-	spin_lock_irqsave(&q->lock, flags);
-	__add_wait_queue_entry_tail(q, waiter);
-	folio_set_waiters(folio);
-	spin_unlock_irqrestore(&q->lock, flags);
-}
-EXPORT_SYMBOL_GPL(folio_add_wait_queue);
-
 /**
  * folio_unlock - Unlock a locked folio.
  * @folio: The folio.
-- 
2.47.0


