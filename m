Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D68BBAFF92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 17:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfIKPGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 11:06:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbfIKPGW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:06:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63CF5307D925;
        Wed, 11 Sep 2019 15:06:22 +0000 (UTC)
Received: from llong.com (ovpn-125-196.rdu2.redhat.com [10.10.125.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D361D5D9E2;
        Wed, 11 Sep 2019 15:06:19 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 4/5] locking/rwsem: Enable timeout check when staying in the OSQ
Date:   Wed, 11 Sep 2019 16:05:36 +0100
Message-Id: <20190911150537.19527-5-longman@redhat.com>
In-Reply-To: <20190911150537.19527-1-longman@redhat.com>
References: <20190911150537.19527-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 11 Sep 2019 15:06:22 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the break function allowed by the new osq_lock() to enable early
break from the OSQ when a timeout value is specified and expiration
time has been reached.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c15926ecb21e..78708097162a 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -794,23 +794,50 @@ static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
 	return sched_clock() + delta;
 }
 
+struct rwsem_break_arg {
+	u64 timeout;
+	int loopcnt;
+};
+
+static bool rwsem_osq_break(void *brk_arg)
+{
+	struct rwsem_break_arg *arg = brk_arg;
+
+	arg->loopcnt++;
+	/*
+	 * Check sched_clock() only once every 256 iterations.
+	 */
+	if (!(arg->loopcnt++ & 0xff) && (sched_clock() >= arg->timeout))
+		return true;
+	return false;
+}
+
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock,
 				  ktime_t timeout)
 {
-	bool taken = false;
+	bool taken = false, locked;
 	int prev_owner_state = OWNER_NULL;
 	int loop = 0;
 	u64 rspin_threshold = 0, curtime;
+	struct rwsem_break_arg break_arg;
 	unsigned long nonspinnable = wlock ? RWSEM_WR_NONSPINNABLE
 					   : RWSEM_RD_NONSPINNABLE;
 
 	preempt_disable();
 
 	/* sem->wait_lock should not be held when doing optimistic spinning */
-	if (!osq_lock(&sem->osq, NULL, NULL))
-		goto done;
+	if (timeout) {
+		break_arg.timeout = ktime_to_ns(timeout);
+		break_arg.loopcnt = 0;
+		locked = osq_lock(&sem->osq, rwsem_osq_break, &break_arg);
+		curtime = sched_clock();
+	} else {
+		locked = osq_lock(&sem->osq, NULL, NULL);
+		curtime = 0;
+	}
 
-	curtime = timeout ? sched_clock() : 0;
+	if (!locked)
+		goto done;
 
 	/*
 	 * Optimistically spin on the owner field and attempt to acquire the
-- 
2.18.1

