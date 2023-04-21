Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9D56EB478
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Apr 2023 00:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjDUWN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 18:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjDUWNY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:13:24 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D533319A1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 15:13:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b73203e0aso17102407b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 15:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682115202; x=1684707202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/AkHMm2p+EP+a6U0DbEFYOuvSo1i83VDzuubdv1yU4=;
        b=gWPYUh/qJS3hKUZOK+9h4MWoL8QjpqBENZF1/R77mtm+LeEDasMRdSowMwEpPxxS78
         EP2q9aDYBJHna1dXO/vRjzhgMH3xXjajRzj+Gem3tqcctYYdBwGqaQ29Kog5RyRfy0yp
         UjVmuXQ923zKnlvwr5/ZYrwLOML+t858ymiAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682115202; x=1684707202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/AkHMm2p+EP+a6U0DbEFYOuvSo1i83VDzuubdv1yU4=;
        b=dQlWoNbJuOOi3AzJsvfz8rwgrcrbbodRu7ne2a2dmIIJOJ9GCzAV6ubU2cQCkuYJXr
         0lIU0wUtxwq0S6BxV2qvp7Wd0bDG/hz+I/2hkbRFXR/efvqqaOjajs7DKHp8kMxGmnIs
         1L579wSQcNSN+wYehzh6ygjCIJnJVxe7B6svJRANuerFQrdGn8+XQM5vHNdyLWpYMlbP
         jqXWAU0SIlRINb0k+MHRsfim4HZ9XcvOJE5nZIzOwtHXXkeR89NsxydNINxnWSOEnB9b
         wyjvcfVuqDmtOdxYlVLpfYVDE8KOpvE+ZjTKoS5A8sKXhfS4uLreOhFaB2nGYpTUPkSr
         ktWg==
X-Gm-Message-State: AAQBX9cyUdfMjpA7Ih6bxZXYc8qBDH1MY9M1ePZ7NrRA35WIrNhaOeHL
        bc9VKjgvgIxRmrj0DopJ9Kjesw==
X-Google-Smtp-Source: AKy350bcHsIIY4k+lLMfZH1OxrXb0oxc9pTN/Ivx+wmbrGQA//e/eiBuiaIqWiD0BPfrEISD1XsY2A==
X-Received: by 2002:a05:6a20:8426:b0:f0:8708:2341 with SMTP id c38-20020a056a20842600b000f087082341mr7837599pzd.26.1682115202268;
        Fri, 21 Apr 2023 15:13:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:87cc:9018:e569:4a27])
        by smtp.gmail.com with ESMTPSA id y72-20020a62644b000000b006372791d708sm3424715pfb.104.2023.04.21.15.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:13:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Ying <ying.huang@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
Date:   Fri, 21 Apr 2023 15:12:45 -0700
Message-ID: <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230421221249.1616168-1-dianders@chromium.org>
References: <20230421221249.1616168-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a variant of folio_lock() that can timeout. This is useful to
avoid unbounded waits for the page lock in kcompactd.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- "Add folio_lock_timeout()" new for v2.

 include/linux/pagemap.h | 16 ++++++++++++++
 mm/filemap.c            | 47 +++++++++++++++++++++++++++++------------
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0acb8e1fb7af..0f3ef9f79300 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -892,6 +892,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 }
 
 void __folio_lock(struct folio *folio);
+int __folio_lock_timeout(struct folio *folio, long timeout);
 int __folio_lock_killable(struct folio *folio);
 bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
 				unsigned int flags);
@@ -952,6 +953,21 @@ static inline void folio_lock(struct folio *folio)
 		__folio_lock(folio);
 }
 
+/**
+ * folio_lock_timeout() - Lock this folio, with a timeout.
+ * @folio: The folio to lock.
+ * @timeout: The timeout in jiffies; %MAX_SCHEDULE_TIMEOUT means wait forever.
+ *
+ * Return: 0 upon success; -ETIMEDOUT upon failure.
+ */
+static inline int folio_lock_timeout(struct folio *folio, long timeout)
+{
+	might_sleep();
+	if (!folio_trylock(folio))
+		return __folio_lock_timeout(folio, timeout);
+	return 0;
+}
+
 /**
  * lock_page() - Lock the folio containing this page.
  * @page: The page to lock.
diff --git a/mm/filemap.c b/mm/filemap.c
index 2723104cc06a..c6056ec41284 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1220,7 +1220,7 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 int sysctl_page_lock_unfairness = 5;
 
 static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
-		int state, enum behavior behavior)
+		int state, enum behavior behavior, long timeout)
 {
 	wait_queue_head_t *q = folio_waitqueue(folio);
 	int unfairness = sysctl_page_lock_unfairness;
@@ -1229,6 +1229,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	bool thrashing = false;
 	unsigned long pflags;
 	bool in_thrashing;
+	int err;
 
 	if (bit_nr == PG_locked &&
 	    !folio_test_uptodate(folio) && folio_test_workingset(folio)) {
@@ -1295,10 +1296,13 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		/* Loop until we've been woken or interrupted */
 		flags = smp_load_acquire(&wait->flags);
 		if (!(flags & WQ_FLAG_WOKEN)) {
+			if (!timeout)
+				break;
+
 			if (signal_pending_state(state, current))
 				break;
 
-			io_schedule();
+			timeout = io_schedule_timeout(timeout);
 			continue;
 		}
 
@@ -1324,10 +1328,10 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	}
 
 	/*
-	 * If a signal happened, this 'finish_wait()' may remove the last
-	 * waiter from the wait-queues, but the folio waiters bit will remain
-	 * set. That's ok. The next wakeup will take care of it, and trying
-	 * to do it here would be difficult and prone to races.
+	 * If a signal/timeout happened, this 'finish_wait()' may remove the
+	 * last waiter from the wait-queues, but the folio waiters bit will
+	 * remain set. That's ok. The next wakeup will take care of it, and
+	 * trying to do it here would be difficult and prone to races.
 	 */
 	finish_wait(q, wait);
 
@@ -1336,6 +1340,13 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		psi_memstall_leave(&pflags);
 	}
 
+	/*
+	 * If we don't meet the success criteria below then we've got an error
+	 * of some sort. Differentiate between the two error cases. If there's
+	 * no time left it must have been a timeout.
+	 */
+	err = !timeout ? -ETIMEDOUT : -EINTR;
+
 	/*
 	 * NOTE! The wait->flags weren't stable until we've done the
 	 * 'finish_wait()', and we could have exited the loop above due
@@ -1350,9 +1361,9 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	 * waiter, but an exclusive one requires WQ_FLAG_DONE.
 	 */
 	if (behavior == EXCLUSIVE)
-		return wait->flags & WQ_FLAG_DONE ? 0 : -EINTR;
+		return wait->flags & WQ_FLAG_DONE ? 0 : err;
 
-	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
+	return wait->flags & WQ_FLAG_WOKEN ? 0 : err;
 }
 
 #ifdef CONFIG_MIGRATION
@@ -1442,13 +1453,15 @@ void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
 
 void folio_wait_bit(struct folio *folio, int bit_nr)
 {
-	folio_wait_bit_common(folio, bit_nr, TASK_UNINTERRUPTIBLE, SHARED);
+	folio_wait_bit_common(folio, bit_nr, TASK_UNINTERRUPTIBLE, SHARED,
+			      MAX_SCHEDULE_TIMEOUT);
 }
 EXPORT_SYMBOL(folio_wait_bit);
 
 int folio_wait_bit_killable(struct folio *folio, int bit_nr)
 {
-	return folio_wait_bit_common(folio, bit_nr, TASK_KILLABLE, SHARED);
+	return folio_wait_bit_common(folio, bit_nr, TASK_KILLABLE, SHARED,
+				     MAX_SCHEDULE_TIMEOUT);
 }
 EXPORT_SYMBOL(folio_wait_bit_killable);
 
@@ -1467,7 +1480,8 @@ EXPORT_SYMBOL(folio_wait_bit_killable);
  */
 static int folio_put_wait_locked(struct folio *folio, int state)
 {
-	return folio_wait_bit_common(folio, PG_locked, state, DROP);
+	return folio_wait_bit_common(folio, PG_locked, state, DROP,
+				     MAX_SCHEDULE_TIMEOUT);
 }
 
 /**
@@ -1662,17 +1676,24 @@ EXPORT_SYMBOL_GPL(page_endio);
 void __folio_lock(struct folio *folio)
 {
 	folio_wait_bit_common(folio, PG_locked, TASK_UNINTERRUPTIBLE,
-				EXCLUSIVE);
+				EXCLUSIVE, MAX_SCHEDULE_TIMEOUT);
 }
 EXPORT_SYMBOL(__folio_lock);
 
 int __folio_lock_killable(struct folio *folio)
 {
 	return folio_wait_bit_common(folio, PG_locked, TASK_KILLABLE,
-					EXCLUSIVE);
+					EXCLUSIVE, MAX_SCHEDULE_TIMEOUT);
 }
 EXPORT_SYMBOL_GPL(__folio_lock_killable);
 
+int __folio_lock_timeout(struct folio *folio, long timeout)
+{
+	return folio_wait_bit_common(folio, PG_locked, TASK_KILLABLE,
+					EXCLUSIVE, timeout);
+}
+EXPORT_SYMBOL_GPL(__folio_lock_timeout);
+
 static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 {
 	struct wait_queue_head *q = folio_waitqueue(folio);
-- 
2.40.0.634.g4ca3ef3211-goog

