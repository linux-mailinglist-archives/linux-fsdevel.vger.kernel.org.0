Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95FF3DCEDF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 05:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhHBDUf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Aug 2021 23:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhHBDUe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Aug 2021 23:20:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1693BC06175F;
        Sun,  1 Aug 2021 20:20:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l19so23467032pjz.0;
        Sun, 01 Aug 2021 20:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FBEypF8PtZzHGWJIbK6kxhqMWYcW5O58D8wRuLNdb4=;
        b=iwwjWFWbErUgwSZ5JTFABHWAFz6RQdWExB+ejf+w67NBrAt4zwVjSvTtOkKrTVW7Mc
         WUWO3SU8vUF2SRCxZzqTZMBSYNrtDax6yMqnZYeAvVI01wFGQIRaFYsAvk/JFKKhRQd3
         hWovFI7C5mGOhzQI1m2ltVIzStRVAJiKPJQoeUM4R3DUZso8lh+gkC/Mo7cukHlC8IRt
         szhMJ6uOJQdr5sSUZiWnkWJLEUyUHtlKH7UZJgSHHJt+XPErXsdBp4JlrEgEAoF/DAff
         kwJPgQO03kYe+HrP+FQxZhaz0gs4Oy03Nbrmlhde94809h0BPvySmpamjUwkHCjjwvKy
         NykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FBEypF8PtZzHGWJIbK6kxhqMWYcW5O58D8wRuLNdb4=;
        b=iB0Levy4/VZxzdn0e+nZpI4rWnN42XaQ4aTorsnTR/brkZOsf/QrjIxkIkHhwjc0nR
         eUb2wZUikSEiyvoaK71eMJwoJCLaKKbaysGsywwajI6oIxRzzfhF1/wsZXahXTa0y+0J
         acmIWHR1HtLieRWMoxaH0duBQf/1528NiHd4iqD4vgmDmdwsaZXDb9502WxxMh9pV/x7
         WJ4K535AYPxD1XAP9rgZohJ+8bAqtdPGj+QJEmcrRUo3kIFcplmkjHWhJ5z9OCbJGP+y
         SQHbjcTAjxPAvLm40nX6ytuCGdavD16jvKlEXjhQhEbIxXRHqJ/aJNj04YfT5VMcgHBq
         L/pg==
X-Gm-Message-State: AOAM531Y+2OKzvoxXd+HGQBgG5JQVl+VomkQWw3O9Mq6jgzUYtymYHqJ
        mxeXm3FSJ/iTFvfcgQ0tYqct7OLbsI0=
X-Google-Smtp-Source: ABdhPJwgZMSERCqtNCFOMa8STVZ80VB2G2omeD/flIXfdfGp+ZPB4sx6hA6XKMlbSOJszJzAKlVtwg==
X-Received: by 2002:a17:902:a50f:b029:11a:cd45:9009 with SMTP id s15-20020a170902a50fb029011acd459009mr12632574plq.38.1627874424669;
        Sun, 01 Aug 2021 20:20:24 -0700 (PDT)
Received: from bobo.ibm.com (60-242-181-102.static.tpgi.com.au. [60.242.181.102])
        by smtp.gmail.com with ESMTPSA id u27sm678055pfg.83.2021.08.01.20.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 20:20:24 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH v1] fs/epoll: use a per-cpu counter for user's watches count
Date:   Mon,  2 Aug 2021 13:20:13 +1000
Message-Id: <20210802032013.2751916-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This counter tracks the number of watches a user has, to compare against
the 'max_user_watches' limit. This causes a scalability bottleneck on
SPECjbb2015 on large systems as there is only one user. Changing to a
per-cpu counter increases throughput of the benchmark by about 30% on a
16-socket, > 1000 thread system.

Reported-by: Anton Blanchard <anton@ozlabs.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 fs/eventpoll.c             | 18 ++++++++++--------
 include/linux/sched/user.h |  3 ++-
 kernel/user.c              |  9 +++++++++
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1e596e1d0bba..648ed77f4164 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -723,7 +723,7 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 	 */
 	call_rcu(&epi->rcu, epi_rcu_free);
 
-	atomic_long_dec(&ep->user->epoll_watches);
+	percpu_counter_dec(&ep->user->epoll_watches);
 
 	return 0;
 }
@@ -1439,7 +1439,6 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 {
 	int error, pwake = 0;
 	__poll_t revents;
-	long user_watches;
 	struct epitem *epi;
 	struct ep_pqueue epq;
 	struct eventpoll *tep = NULL;
@@ -1449,11 +1448,15 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 
 	lockdep_assert_irqs_enabled();
 
-	user_watches = atomic_long_read(&ep->user->epoll_watches);
-	if (unlikely(user_watches >= max_user_watches))
+	if (unlikely(percpu_counter_compare(&ep->user->epoll_watches,
+					    max_user_watches) >= 0))
 		return -ENOSPC;
-	if (!(epi = kmem_cache_zalloc(epi_cache, GFP_KERNEL)))
+	percpu_counter_inc(&ep->user->epoll_watches);
+
+	if (!(epi = kmem_cache_zalloc(epi_cache, GFP_KERNEL))) {
+		percpu_counter_dec(&ep->user->epoll_watches);
 		return -ENOMEM;
+	}
 
 	/* Item initialization follow here ... */
 	INIT_LIST_HEAD(&epi->rdllink);
@@ -1466,17 +1469,16 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 		mutex_lock_nested(&tep->mtx, 1);
 	/* Add the current item to the list of active epoll hook for this file */
 	if (unlikely(attach_epitem(tfile, epi) < 0)) {
-		kmem_cache_free(epi_cache, epi);
 		if (tep)
 			mutex_unlock(&tep->mtx);
+		kmem_cache_free(epi_cache, epi);
+		percpu_counter_dec(&ep->user->epoll_watches);
 		return -ENOMEM;
 	}
 
 	if (full_check && !tep)
 		list_file(tfile);
 
-	atomic_long_inc(&ep->user->epoll_watches);
-
 	/*
 	 * Add the current item to the RB tree. All RB tree operations are
 	 * protected by "mtx", and ep_insert() is called with "mtx" held.
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 2462f7d07695..00ed419dd464 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -4,6 +4,7 @@
 
 #include <linux/uidgid.h>
 #include <linux/atomic.h>
+#include <linux/percpu_counter.h>
 #include <linux/refcount.h>
 #include <linux/ratelimit.h>
 
@@ -13,7 +14,7 @@
 struct user_struct {
 	refcount_t __count;	/* reference count */
 #ifdef CONFIG_EPOLL
-	atomic_long_t epoll_watches; /* The number of file descriptors currently watched */
+	struct percpu_counter epoll_watches; /* The number of file descriptors currently watched */
 #endif
 	unsigned long unix_inflight;	/* How many files in flight in unix sockets */
 	atomic_long_t pipe_bufs;  /* how many pages are allocated in pipe buffers */
diff --git a/kernel/user.c b/kernel/user.c
index c82399c1618a..a2673f940506 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -138,6 +138,7 @@ static void free_user(struct user_struct *up, unsigned long flags)
 {
 	uid_hash_remove(up);
 	spin_unlock_irqrestore(&uidhash_lock, flags);
+	percpu_counter_destroy(&up->epoll_watches);
 	kmem_cache_free(uid_cachep, up);
 }
 
@@ -185,6 +186,10 @@ struct user_struct *alloc_uid(kuid_t uid)
 
 		new->uid = uid;
 		refcount_set(&new->__count, 1);
+		if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
+			kmem_cache_free(uid_cachep, new);
+			return NULL;
+		}
 		ratelimit_state_init(&new->ratelimit, HZ, 100);
 		ratelimit_set_flags(&new->ratelimit, RATELIMIT_MSG_ON_RELEASE);
 
@@ -195,6 +200,7 @@ struct user_struct *alloc_uid(kuid_t uid)
 		spin_lock_irq(&uidhash_lock);
 		up = uid_hash_find(uid, hashent);
 		if (up) {
+			percpu_counter_destroy(&new->epoll_watches);
 			kmem_cache_free(uid_cachep, new);
 		} else {
 			uid_hash_insert(new, hashent);
@@ -216,6 +222,9 @@ static int __init uid_cache_init(void)
 	for(n = 0; n < UIDHASH_SZ; ++n)
 		INIT_HLIST_HEAD(uidhash_table + n);
 
+	if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
+		panic("percpu cpunter alloc failed");
+
 	/* Insert the root user immediately (init already runs as root) */
 	spin_lock_irq(&uidhash_lock);
 	uid_hash_insert(&root_user, uidhashentry(GLOBAL_ROOT_UID));
-- 
2.23.0

