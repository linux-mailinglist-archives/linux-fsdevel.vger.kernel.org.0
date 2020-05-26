Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3411E2F6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 21:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390482AbgEZTw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 15:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390284AbgEZTvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 15:51:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250FBC03E96D
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 12:51:32 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so9105493plo.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91LPx4VFG9btmYMQhwNjB8l3CSYHzquXTBOwjvdo+tY=;
        b=iE3qXf/OK07yvdsW8Vb51ZnFfsRrhY/I8AyPsPZBuYDCG+TC8jz9R0D0M+GRoONqmI
         gim5npZm8cxTM+QSweOQXfZsODg5VS6+7bN+CKZ4dMY7gY+QpgkMzMrv59Fphw7RYayS
         JBGmAVIX3BEE46Smv2GYnsm+ImSrUvQiaACUJ58syDnlB+HNG5sK2LsdT4XG1F3dqp/4
         oVhakRyiZ0nYbu4FXaNA5/FJOFFKKsGpp/Hce7YkE5gJePG3prwbUWapZwHq23NDXkHD
         /0mpwLPbH1DZDuHuFhnGHadUwVq75hkc8cYWz+Lkln7BqwK/1OvfBTdLVjGY87S3aO6Z
         QMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91LPx4VFG9btmYMQhwNjB8l3CSYHzquXTBOwjvdo+tY=;
        b=SPcTI+SPeLThMWfqyB1SkAtSrWQDdRahNQsa4/Y67eNDNNerRpCbxa25U5jEzzMsoQ
         D6hW0/K11G/6Iiug7xnPtqzN8hkTZdhaHmS5UfofTJVrIvSXZZa19AVBs2ersgtDtTua
         H3tGsS8/IyOl0lVzFOau7bj+FQTsYpMbn1MD0+k1/IVPD6k1i4Y1gtrDZgsJnkXwjRL9
         wJ3oGb2KzlwgukkCbPX5cgeNECY65ovITI8uImlvPjjNuHTApJQx1BAfYKyjY/FNEvwL
         Ie/DdIQUbLptJH8r2DhAjQcQ5XtwF5V13D7hnVfztKDhwC8gda/LrAW3KjApKQz/2YI6
         uK1w==
X-Gm-Message-State: AOAM530gX5a4Ma6Lc5T1YM+cr97lRJQ02GmBUCByRtRnsu8awb5PAkNI
        sQV1HjPrxZx4wcoOCegsq/DbGQ==
X-Google-Smtp-Source: ABdhPJzk5ZeLZ9PiNns9o7WtuSDeeuU8oJZ8JIZZ0HjXadMCEeQTkM4QJqeJe1UnHKeyrNQoGn1fyg==
X-Received: by 2002:a17:90a:2a0d:: with SMTP id i13mr909880pjd.94.1590522691575;
        Tue, 26 May 2020 12:51:31 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:94bb:59d2:caf6:70e1])
        by smtp.gmail.com with ESMTPSA id c184sm313943pfc.57.2020.05.26.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:51:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/12] mm: add support for async page locking
Date:   Tue, 26 May 2020 13:51:15 -0600
Message-Id: <20200526195123.29053-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526195123.29053-1-axboe@kernel.dk>
References: <20200526195123.29053-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Normally waiting for a page to become unlocked, or locking the page,
requires waiting for IO to complete. Add support for lock_page_async()
and wait_on_page_locked_async(), which are callback based instead. This
allows a caller to get notified when a page becomes unlocked, rather
than wait for it.

We add a new iocb field, ki_waitq, to pass in the necessary data for this
to happen. We can unionize this with ki_cookie, since that is only used
for polled IO. Polled IO can never co-exist with async callbacks, as it is
(by definition) polled completions. struct wait_page_key is made public,
and we define struct wait_page_async as the interface between the caller
and the core.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h      |  7 ++++++-
 include/linux/pagemap.h |  9 +++++++++
 mm/filemap.c            | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d3ebb49189df..ba1fff0e7bca 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -314,6 +314,8 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+/* iocb->ki_waitq is valid */
+#define IOCB_WAITQ		(1 << 8)
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -327,7 +329,10 @@ struct kiocb {
 	int			ki_flags;
 	u16			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
-	unsigned int		ki_cookie; /* for ->iopoll */
+	union {
+		unsigned int		ki_cookie; /* for ->iopoll */
+		struct wait_page_queue	*ki_waitq; /* for async buffered IO */
+	};
 
 	randomized_struct_fields_end
 };
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 53d980f2208d..d3e63c9c61ae 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -495,6 +495,7 @@ static inline int wake_page_match(struct wait_page_queue *wait_page,
 
 extern void __lock_page(struct page *page);
 extern int __lock_page_killable(struct page *page);
+extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
 extern void unlock_page(struct page *page);
@@ -531,6 +532,14 @@ static inline int lock_page_killable(struct page *page)
 	return 0;
 }
 
+static inline int lock_page_async(struct page *page,
+				  struct wait_page_queue *wait)
+{
+	if (!trylock_page(page))
+		return __lock_page_async(page, wait);
+	return 0;
+}
+
 /*
  * lock_page_or_retry - Lock the page, unless this would block and the
  * caller indicated that it can handle a retry.
diff --git a/mm/filemap.c b/mm/filemap.c
index e891b5bee8fd..c746541b1d49 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1183,6 +1183,42 @@ int wait_on_page_bit_killable(struct page *page, int bit_nr)
 }
 EXPORT_SYMBOL(wait_on_page_bit_killable);
 
+static int __wait_on_page_locked_async(struct page *page,
+				       struct wait_page_queue *wait, bool set)
+{
+	struct wait_queue_head *q = page_waitqueue(page);
+	int ret = 0;
+
+	wait->page = page;
+	wait->bit_nr = PG_locked;
+
+	spin_lock_irq(&q->lock);
+	if (set)
+		ret = !trylock_page(page);
+	else
+		ret = PageLocked(page);
+	if (ret) {
+		__add_wait_queue_entry_tail(q, &wait->wait);
+		SetPageWaiters(page);
+		if (set)
+			ret = !trylock_page(page);
+		else
+			ret = PageLocked(page);
+		/*
+		 * If we were succesful now, we know we're still on the
+		 * waitqueue as we're still under the lock. This means it's
+		 * safe to remove and return success, we know the callback
+		 * isn't going to trigger.
+		 */
+		if (!ret)
+			__remove_wait_queue(q, &wait->wait);
+		else
+			ret = -EIOCBQUEUED;
+	}
+	spin_unlock_irq(&q->lock);
+	return ret;
+}
+
 /**
  * put_and_wait_on_page_locked - Drop a reference and wait for it to be unlocked
  * @page: The page to wait for.
@@ -1345,6 +1381,11 @@ int __lock_page_killable(struct page *__page)
 }
 EXPORT_SYMBOL_GPL(__lock_page_killable);
 
+int __lock_page_async(struct page *page, struct wait_page_queue *wait)
+{
+	return __wait_on_page_locked_async(page, wait, true);
+}
+
 /*
  * Return values:
  * 1 - page is locked; mmap_sem is still held.
-- 
2.26.2

