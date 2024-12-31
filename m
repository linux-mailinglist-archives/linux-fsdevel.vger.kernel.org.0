Return-Path: <linux-fsdevel+bounces-38293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBCB9FEF10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 12:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD47160A45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 11:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CAE1993BD;
	Tue, 31 Dec 2024 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b="JXcjPrnn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C52114
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735643686; cv=none; b=UDKLR79Xlukm4XJI8/AEIlwVloRNeO5Z4TOo/FHzJVgeVZeN7riFfIBEfgg6rR7urrXIjl9RMVnkasqWx3udcrk0xifp1SgenLoBGXTVpmBoXuFNH69plqtOHJ7/Dw09yZNO3CLITx8NuYpNXsMrZFIREqwGFtd1rqEnJtZkpug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735643686; c=relaxed/simple;
	bh=rq/DxHG9rMHRWsWAy2l+UZxbUbez/GjIShBVfWWjWyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khP+fseYJM+5wfviLF6GOzp9LRiYF0b9qQd8tSsd2Pv3ZIPEmQvrWKcSRzd5VYyNd/E4Q4BiAbGbZv7657cASQSvODCZLrlav/S0K7wkAmFUtPxjuc6t3xlxYGLtS6BROQSlVsdpC8QTyZ0e/P+r4e+MLERWVPfavZHVVoyeRoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com; spf=pass smtp.mailfrom=colorfullife.com; dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b=JXcjPrnn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorfullife.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e44654ae3so1620508266b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 03:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20230601.gappssmtp.com; s=20230601; t=1735643683; x=1736248483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmObXSgsMQGxcaUjzd2u+bVoecE4js+QkvAZp6+RrvE=;
        b=JXcjPrnn/tCg46hE/WMnm0uP3rXsQi8DoXdj50U0+89neI9erjq599so7GR8Ip0MSK
         BqFCEw5HL2au6OAy9I3hV/dbTx9/jnuuCQR4H2z+TATP8kgpxxe5UfS4gbPSmjUtRNtm
         IUXqL+F+WZInJ4y27xeJez8Tnc2FDM5umA5WofCI3oScB0riZQT83Qj6AATk6yn0Igxp
         an5DyRcP60a8V5Kqq6umnqc0YXLSLDK0bK5C8NYuJBxBBky7E0YXQTx5//ul1kcZaPCE
         tLfT9o2ffgLGX5nI6aKq/DzOCx/D5hnFpZ++NAAelNv0jyvk4MnmkSvcArvuhMkIbB+A
         66SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735643683; x=1736248483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmObXSgsMQGxcaUjzd2u+bVoecE4js+QkvAZp6+RrvE=;
        b=iUJXdPc1KcFBBP0WN3rLOxZUhUX4evK1AEopIffMVzxxcZ7y+dM+Cn09p1Hz0vmq1v
         j7MNlTybVHmWIcAqpWJ1+SQimi1AQcKwOBLHcZjYHYHGJmdOUfTLo6Syr1YT8UmgTZMw
         tHeMMLUfLUH1fDevaQdFrhECSy5LZR2qMId1eTOHfxg/EA8hx0gy8Aif++0POOgtb7vP
         OSPj0Rp1zqm6rXTz4pg56XZ8ZvD8HroerRyx5aVEt4EJLVYOLvVqLZpjO9EIJkQzdEpg
         toidwgr0XJIOH1dtlgVugDmm5eDNlUdVEGZrc1CPfkUgSw38g3n1DVfl22IAvO5O6FMy
         jlNA==
X-Forwarded-Encrypted: i=1; AJvYcCXDevzR3yySNfEGg1aCUAdNwMjKXfUcyLStwutyIcJzHP03T+D8rYhPfmHKJkcQ8hZrtgkpe+xXq8yP77M0@vger.kernel.org
X-Gm-Message-State: AOJu0YwjGR8c6b0yUFxhkNMkCRjjnC4WGMG2plWAggTDgsGQYdxfPrA7
	qH4p/Zh/moKBAei60735aMPiQWLJAVim+BP+/pkouaOlk7SygpHZoAKUd98+/Q==
X-Gm-Gg: ASbGncvhYJCtOPMReLBiz+pCYhcWOq14hxZXR3msFFsWpAHR5fvjU1tC5w9K8gNLBm1
	62Vr8IkuvNdoEs9CuDKFAFdhTn9A20fkawB66iKiGkcXGCdICylvU37YGIVFztFifNb06al5IJW
	14Z20E8M23AvaadTP2CBrgPbk+QmsxK1x6pgjTdt2CDACx4CnkFH1IwUSOJNwA3pwbpY2PStk1L
	iNHGWBivdx8mIUixSSzVZ2srIrwrlVUWuTjWcm4ngMLcBGR1GQN4kRspneAvjCAHflFXh+fxM79
	BhWpUmG+smX4tGwxNTLxkqHYn5bcmEM1DJPfjJOaebo8TUvvNcdD0He9lxyUrIY=
X-Google-Smtp-Source: AGHT+IF2Rh/r6l9SuGGmJwEZqBUTjQ/v9V27hkd4TmS2UKd1ztjF1aEv68oCNfDmXfhxEH727T5mpw==
X-Received: by 2002:a17:906:6a28:b0:aa5:391e:cadf with SMTP id a640c23a62f3a-aac334f637fmr3261763366b.42.1735643682798;
        Tue, 31 Dec 2024 03:14:42 -0800 (PST)
Received: from localhost.localdomain (p200300d9971255001e3d0644a090dcde.dip0.t-ipconnect.de. [2003:d9:9712:5500:1e3d:644:a090:dcde])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fedca8sm16233558a12.61.2024.12.31.03.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 03:14:41 -0800 (PST)
From: Manfred Spraul <manfred@colorfullife.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	1vier1@web.de,
	Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping processes during pipe read/write
Date: Tue, 31 Dec 2024 12:14:28 +0100
Message-ID: <20241231111428.5510-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230153844.GA15134@redhat.com>
References: <20241230153844.GA15134@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Oleg,

just FYI, I did some quick tests with:
- your changes to fs/pipe.c
- my change, to skip locking in wake-up (and some smp_mb())
- statistics, to check how often wake_up is called/how often the list is
  wait queue is actually empty

Known issue: Statistic printing every 10 seconds doesn't work, it prints
at eratic times. And the comment in __wake_up is still wrong, the
memory barrier would pair with smp_mb() after updating wq_head->head.

Result: (all with a 2 core 4 thread i3, fully idle system)
- your change has no impact on 'find /proc /sys | grep doesnotexist'
  (using busybox)
- Running your test app for around 100 seconds
   - 3 wakeups with non-empty queue
   - 26 wakeup with empty queue
   - 2107 __add_wait_queue
- find|grep produces insane numbers of wakeup. I've seen 20k, I've
  now seen 50k wakeup calls. With just around 2k __add_wait_queue,
  ...

Thus, at least for pipe:
Should we add the missing memory barriers and switch to
wait_queue_active() in front of all wakeup calls?

---
 fs/pipe.c            | 13 +++++++------
 include/linux/wait.h |  5 +++++
 kernel/sched/wait.c  | 45 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 12b22c2723b7..27ffb650f131 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -253,7 +253,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	size_t total_len = iov_iter_count(to);
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
-	bool was_full, wake_next_reader = false;
+	bool wake_writer = false, wake_next_reader = false;
 	ssize_t ret;
 
 	/* Null read succeeds. */
@@ -271,7 +271,6 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	 * (WF_SYNC), because we want them to get going and generate more
 	 * data for us.
 	 */
-	was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
 	for (;;) {
 		/* Read ->head with a barrier vs post_one_notification() */
 		unsigned int head = smp_load_acquire(&pipe->head);
@@ -340,8 +339,10 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				buf->len = 0;
 			}
 
-			if (!buf->len)
+			if (!buf->len) {
+				wake_writer |= pipe_full(head, tail, pipe->max_usage);
 				tail = pipe_update_tail(pipe, buf, tail);
+			}
 			total_len -= chars;
 			if (!total_len)
 				break;	/* common path: read succeeded */
@@ -377,7 +378,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		 * _very_ unlikely case that the pipe was full, but we got
 		 * no data.
 		 */
-		if (unlikely(was_full))
+		if (unlikely(wake_writer))
 			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
 		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 
@@ -391,14 +392,14 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			return -ERESTARTSYS;
 
 		mutex_lock(&pipe->mutex);
-		was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
 		wake_next_reader = true;
+		wake_writer = false;
 	}
 	if (pipe_empty(pipe->head, pipe->tail))
 		wake_next_reader = false;
 	mutex_unlock(&pipe->mutex);
 
-	if (was_full)
+	if (wake_writer)
 		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
 	if (wake_next_reader)
 		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 6d90ad974408..0fdad3c3c513 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -166,6 +166,7 @@ extern void add_wait_queue_exclusive(struct wait_queue_head *wq_head, struct wai
 extern void add_wait_queue_priority(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry);
 extern void remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry);
 
+extern atomic_t g_add_count;
 static inline void __add_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry)
 {
 	struct list_head *head = &wq_head->head;
@@ -177,6 +178,8 @@ static inline void __add_wait_queue(struct wait_queue_head *wq_head, struct wait
 		head = &wq->entry;
 	}
 	list_add(&wq_entry->entry, head);
+	smp_mb();
+	atomic_inc(&g_add_count);
 }
 
 /*
@@ -192,6 +195,8 @@ __add_wait_queue_exclusive(struct wait_queue_head *wq_head, struct wait_queue_en
 static inline void __add_wait_queue_entry_tail(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry)
 {
 	list_add_tail(&wq_entry->entry, &wq_head->head);
+	smp_mb();
+	atomic_inc(&g_add_count);
 }
 
 static inline void
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 51e38f5f4701..07487429dddf 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -110,6 +110,10 @@ static int __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int m
 	return nr_exclusive - remaining;
 }
 
+#if 1
+atomic_t g_add_count = ATOMIC_INIT(0);
+#endif
+
 /**
  * __wake_up - wake up threads blocked on a waitqueue.
  * @wq_head: the waitqueue
@@ -124,6 +128,47 @@ static int __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int m
 int __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
 	      int nr_exclusive, void *key)
 {
+#if 1
+static atomic_t g_slow = ATOMIC_INIT(0);
+static atomic_t g_mid = ATOMIC_INIT(0);
+static atomic_t g_fast = ATOMIC_INIT(0);
+static u64 printtime = 10*HZ;
+#endif
+	if (list_empty(&wq_head->head)) {
+		struct list_head *pn;
+
+		/*
+		 * pairs with spin_unlock_irqrestore(&wq_head->lock);
+		 * We actually do not need to acquire wq_head->lock, we just
+		 * need to be sure that there is no prepare_to_wait() that
+		 * completed on any CPU before __wake_up was called.
+		 * Thus instead of load_acquiring the spinlock and dropping
+		 * it again, we load_acquire the next list entry and check
+		 * that the list is not empty.
+		 */
+		pn = smp_load_acquire(&wq_head->head.next);
+
+		if(pn == &wq_head->head) {
+#if 1
+			atomic_inc(&g_fast);
+#endif
+			return 0;
+		} else {
+#if 1
+			atomic_inc(&g_mid);
+#endif
+		}
+	} else {
+#if 1
+		atomic_inc(&g_slow);
+#endif
+	}
+#if 1
+	if (get_jiffies_64() > printtime) {
+		printtime = get_jiffies_64() + 10*HZ;
+		pr_info("__wakeup: slow/obvious: %d, mid/nearly raced: %d, fast: %d, add: %d.\n", atomic_read(&g_slow), atomic_read(&g_mid), atomic_read(&g_fast), atomic_read(&g_add_count));
+	}
+#endif
 	return __wake_up_common_lock(wq_head, mode, nr_exclusive, 0, key);
 }
 EXPORT_SYMBOL(__wake_up);
-- 
2.47.1


