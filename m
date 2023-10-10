Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF307BF16E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 05:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442010AbjJJD2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 23:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441968AbjJJD2n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:28:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E631B9E;
        Mon,  9 Oct 2023 20:28:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-692779f583fso3540242b3a.0;
        Mon, 09 Oct 2023 20:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696908521; x=1697513321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SGVf7q7LnkpOvGfWEYq5TcNZtO9gcsQp7/NyaBpwlnw=;
        b=HOHnMdpz51r3n/PerOw1nV7C7YO7lu/bur0AQDXgSV4ZlGDyp4DdG0o61jSCvD1D2F
         9Cfa8wrbPbLed5k0dArTKrWNSGabMOddwl+VFCHOWZeFU2ChPWiagu04bJW1MMjKAORA
         KG/c1YoEMhBWmOqei0fBBcdEY6Vq9gdMh9SDci74BMeZvuycp6rpW3tUX2oGnkl4luq2
         vDQeXkWnAfL9jV1ashL05cEyeKlWc3E63CLfBFWTo0wN+2h3yVU3QWKljXAx4g1mb2p4
         tEDZNa/NxGIUcE72B6tr7OA8aC4K84CAHUNAr25leWtSQQNhc/n720HpAql6ht4sF+AG
         MxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696908521; x=1697513321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGVf7q7LnkpOvGfWEYq5TcNZtO9gcsQp7/NyaBpwlnw=;
        b=jY0ILXGdRhaoGGsyOBa93DEjFRPdZhTMzU5KRQG4Nu5WaNtSiGx/SJwbbAeVR8ZVaa
         A70qNA9FCJ0tRHhgnZR8u/ZtO7w3PFYzr0osfsC8YPhSyAsw7eF+r1lwdR6o3lFbQGCw
         9qzphDy+lX7IalgcAJvwu+z13TzMGZKLo0g+LHYUOOk+6GhlJ1qO3DDehuEK1Qv99aTl
         OqlkFnQfhOWrqUye2VIWoi6k/CR4LgOHuAqhEr9fe9VYi53juhwprxs3b7YD0UxydZDj
         qjBYfOOZcgWf+sZr2oQIjk1M3NDYPFGrsNnAV3LxJxmFfgVk3kp4eDfSsoR57Zlw/pUj
         x7sA==
X-Gm-Message-State: AOJu0YxaEHtEeLsWau+prUeO9CZWUkCuNY2M1pVD0LSyEjnHlfenqWkD
        y0fpoeIAw83NMuGH0yJSxmE=
X-Google-Smtp-Source: AGHT+IHznTpB4tCFTP+SES9KpvSO9WSZ5MZ0i8ZWpqBUiTTnF2TwBk52JSz7vQv2R0qAbXwdXdyBjQ==
X-Received: by 2002:a05:6a00:2316:b0:690:c5cf:91f5 with SMTP id h22-20020a056a00231600b00690c5cf91f5mr17596309pfh.18.1696908521096;
        Mon, 09 Oct 2023 20:28:41 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.164])
        by smtp.gmail.com with ESMTPSA id 19-20020aa79153000000b00692754580f0sm7123468pfi.187.2023.10.09.20.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 20:28:40 -0700 (PDT)
From:   Bin Lai <sclaibin@gmail.com>
X-Google-Original-From: Bin Lai <robinlai@tencent.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, akpm@linux-foundation.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Bin Lai <robinlai@tencent.com>
Subject: [PATCH] sched/wait: introduce endmark in __wake_up_common
Date:   Tue, 10 Oct 2023 11:28:33 +0800
Message-Id: <20231010032833.398033-1-robinlai@tencent.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Without this patch applied, it can cause the waker to fall into an
infinite loop in some cases. The commit 2554db916586 ("sched/wait: Break
up long wake list walk") introduces WQ_FLAG_BOOKMARK to break up long
wake list walk. When the number of walked entries reach 64, the waker
will record scan position and release the queue lock, which reduces
interrupts and rescheduling latency.

Let's take an example, ltp-aiodio case of runltp-ng create 100 processes
for io testing. These processes write the same test file and wait for page
writing complete. Because these processes are all writing to the same
file, they may all be waiting for the writeback bit of the same page
to be cleared. When the page writeback is completed, the end_page_writeback
will clear the writeback bit of the page and wake up all processes on the
wake list for the page. At the same time, another process could submit
the page and set the writeback bit again. When the awakened processes find
that the writeback bit has not been cleared, thery will try to add
themselves to the wake list immediately. Because of the WQ_FLAG_BOOKMARK
feature, the awakened processes will be added to the tail of wake list
again after the waker releases the queue lock. It causes the waker to
fall into an infinite loop.

Therefore, we introduce the endmark to indicate the end of bookmark state.
When we get the endmark entry, stop placing the bookmark flag and hold the
lock until all remaining entries have been walked.

Signed-off-by: Bin Lai <robinlai@tencent.com>

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 5ec7739400f4..3413babd2db4 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -213,7 +213,8 @@ int __wake_up(struct wait_queue_head *wq_head, unsigned int mode, int nr, void *
 void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
-		unsigned int mode, void *key, wait_queue_entry_t *bookmark);
+		unsigned int mode, void *key, wait_queue_entry_t *bookmark,
+		wait_queue_entry_t *endmark);
 void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_sync_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked(struct wait_queue_head *wq_head, unsigned int mode, int nr);
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 802d98cf2de3..9ecb59193710 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -79,10 +79,11 @@ EXPORT_SYMBOL(remove_wait_queue);
  */
 static int __wake_up_common(struct wait_queue_head *wq_head, unsigned int mode,
 			int nr_exclusive, int wake_flags, void *key,
-			wait_queue_entry_t *bookmark)
+			wait_queue_entry_t *bookmark,
+			wait_queue_entry_t *endmark)
 {
 	wait_queue_entry_t *curr, *next;
-	int cnt = 0;
+	int cnt = 0, touch_endmark = 0;
 
 	lockdep_assert_held(&wq_head->lock);
 
@@ -95,12 +96,17 @@ static int __wake_up_common(struct wait_queue_head *wq_head, unsigned int mode,
 		curr = list_first_entry(&wq_head->head, wait_queue_entry_t, entry);
 
 	if (&curr->entry == &wq_head->head)
-		return nr_exclusive;
+		goto out;
 
 	list_for_each_entry_safe_from(curr, next, &wq_head->head, entry) {
 		unsigned flags = curr->flags;
 		int ret;
 
+		if (curr == endmark) {
+			touch_endmark = 1;
+			continue;
+		}
+
 		if (flags & WQ_FLAG_BOOKMARK)
 			continue;
 
@@ -110,14 +116,24 @@ static int __wake_up_common(struct wait_queue_head *wq_head, unsigned int mode,
 		if (ret && (flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
 			break;
 
-		if (bookmark && (++cnt > WAITQUEUE_WALK_BREAK_CNT) &&
+		if (bookmark && !touch_endmark && (++cnt > WAITQUEUE_WALK_BREAK_CNT) &&
 				(&next->entry != &wq_head->head)) {
 			bookmark->flags = WQ_FLAG_BOOKMARK;
 			list_add_tail(&bookmark->entry, &next->entry);
-			break;
+
+			if (endmark && !(endmark->flags & WQ_FLAG_BOOKMARK)) {
+				endmark->flags = WQ_FLAG_BOOKMARK;
+				list_add_tail(&endmark->entry, &wq_head->head);
+			}
+
+			return nr_exclusive;
 		}
 	}
 
+out:
+	if (endmark && (endmark->flags & WQ_FLAG_BOOKMARK))
+		list_del(&endmark->entry);
+
 	return nr_exclusive;
 }
 
@@ -125,7 +141,7 @@ static int __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int m
 			int nr_exclusive, int wake_flags, void *key)
 {
 	unsigned long flags;
-	wait_queue_entry_t bookmark;
+	wait_queue_entry_t bookmark, endmark;
 	int remaining = nr_exclusive;
 
 	bookmark.flags = 0;
@@ -133,10 +149,15 @@ static int __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int m
 	bookmark.func = NULL;
 	INIT_LIST_HEAD(&bookmark.entry);
 
+	endmark.flags = 0;
+	endmark.private = NULL;
+	endmark.func = NULL;
+	INIT_LIST_HEAD(&endmark.entry);
+
 	do {
 		spin_lock_irqsave(&wq_head->lock, flags);
 		remaining = __wake_up_common(wq_head, mode, remaining,
-						wake_flags, key, &bookmark);
+					     wake_flags, key, &bookmark, &endmark);
 		spin_unlock_irqrestore(&wq_head->lock, flags);
 	} while (bookmark.flags & WQ_FLAG_BOOKMARK);
 
@@ -171,20 +192,21 @@ void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode
  */
 void __wake_up_locked(struct wait_queue_head *wq_head, unsigned int mode, int nr)
 {
-	__wake_up_common(wq_head, mode, nr, 0, NULL, NULL);
+	__wake_up_common(wq_head, mode, nr, 0, NULL, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(__wake_up_locked);
 
 void __wake_up_locked_key(struct wait_queue_head *wq_head, unsigned int mode, void *key)
 {
-	__wake_up_common(wq_head, mode, 1, 0, key, NULL);
+	__wake_up_common(wq_head, mode, 1, 0, key, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(__wake_up_locked_key);
 
 void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
-		unsigned int mode, void *key, wait_queue_entry_t *bookmark)
+		unsigned int mode, void *key, wait_queue_entry_t *bookmark,
+		wait_queue_entry_t *endmark)
 {
-	__wake_up_common(wq_head, mode, 1, 0, key, bookmark);
+	__wake_up_common(wq_head, mode, 1, 0, key, bookmark, endmark);
 }
 EXPORT_SYMBOL_GPL(__wake_up_locked_key_bookmark);
 
@@ -233,7 +255,7 @@ EXPORT_SYMBOL_GPL(__wake_up_sync_key);
 void __wake_up_locked_sync_key(struct wait_queue_head *wq_head,
 			       unsigned int mode, void *key)
 {
-        __wake_up_common(wq_head, mode, 1, WF_SYNC, key, NULL);
+	__wake_up_common(wq_head, mode, 1, WF_SYNC, key, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(__wake_up_locked_sync_key);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 4ea4387053e8..49dc8620271d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1135,7 +1135,7 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
 	wait_queue_head_t *q = folio_waitqueue(folio);
 	struct wait_page_key key;
 	unsigned long flags;
-	wait_queue_entry_t bookmark;
+	wait_queue_entry_t bookmark, endmark;
 
 	key.folio = folio;
 	key.bit_nr = bit_nr;
@@ -1146,8 +1146,13 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
 	bookmark.func = NULL;
 	INIT_LIST_HEAD(&bookmark.entry);
 
+	endmark.flags = 0;
+	endmark.private = NULL;
+	endmark.func = NULL;
+	INIT_LIST_HEAD(&endmark.entry);
+
 	spin_lock_irqsave(&q->lock, flags);
-	__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark);
+	__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark, &endmark);
 
 	while (bookmark.flags & WQ_FLAG_BOOKMARK) {
 		/*
@@ -1159,7 +1164,7 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
 		spin_unlock_irqrestore(&q->lock, flags);
 		cpu_relax();
 		spin_lock_irqsave(&q->lock, flags);
-		__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark);
+		__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark, &endmark);
 	}
 
 	/*
-- 
2.39.3

