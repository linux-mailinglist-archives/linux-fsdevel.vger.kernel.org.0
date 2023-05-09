Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29BB6FCBEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjEIQ5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjEIQ5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:57:17 -0400
Received: from out-3.mta1.migadu.com (out-3.mta1.migadu.com [IPv6:2001:41d0:203:375::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3DD30D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:13 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7HXn4Ai3HCc0Fe34KxBMMS4Cno5NneBVwyeI+DfOSZ4=;
        b=aTfDXF9VG6rJ5VBr/J1ipGa3nA3Clu74t98FmSTVJUFgFARXPIpxAfp1Ovgk+6ZiaUeFjD
        bH5CLS4lIqmGRgG9Baix4APh2l4XUo2b6AeytH8ospRhzCz+fIjSQqKysb/odZULWx+TVC
        bs/XLATI6OhaENIAq7yonjl8pTvBAKc=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 03/32] locking/lockdep: lockdep_set_no_check_recursion()
Date:   Tue,  9 May 2023 12:56:28 -0400
Message-Id: <20230509165657.1735798-4-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a method to tell lockdep not to check lock ordering within a
lock class - but to still check lock ordering w.r.t. other lock types.

This is for bcachefs, where for btree node locks we have our own
deadlock avoidance strategy w.r.t. other btree node locks (cycle
detection), but we still want lockdep to check lock ordering w.r.t.
other lock types.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h       |  6 ++++++
 include/linux/lockdep_types.h |  2 +-
 kernel/locking/lockdep.c      | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index e858c288c7..f6cc8709e2 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -665,4 +665,10 @@ lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 }
 #endif
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void lockdep_set_no_check_recursion(struct lockdep_map *map);
+#else
+static inline void lockdep_set_no_check_recursion(struct lockdep_map *map) {}
+#endif
+
 #endif /* __LINUX_LOCKDEP_H */
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index d22430840b..506e769b4a 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -128,7 +128,7 @@ struct lock_class {
 	u8				wait_type_inner;
 	u8				wait_type_outer;
 	u8				lock_type;
-	/* u8				hole; */
+	u8				no_check_recursion;
 
 #ifdef CONFIG_LOCK_STAT
 	unsigned long			contention_point[LOCKSTAT_POINTS];
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e631464070..f022b58dfa 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3024,6 +3024,9 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
 		if ((next->read == 2) && prev->read)
 			continue;
 
+		if (hlock_class(next)->no_check_recursion)
+			continue;
+
 		/*
 		 * We're holding the nest_lock, which serializes this lock's
 		 * nesting behaviour.
@@ -3085,6 +3088,10 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		return 2;
 	}
 
+	if (hlock_class(prev) == hlock_class(next) &&
+	    hlock_class(prev)->no_check_recursion)
+		return 2;
+
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
 	 * create a circular dependency in the graph. (We do this by
@@ -6620,3 +6627,22 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void lockdep_set_no_check_recursion(struct lockdep_map *lock)
+{
+	struct lock_class *class = lock->class_cache[0];
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	lockdep_recursion_inc();
+
+	if (!class)
+		class = register_lock_class(lock, 0, 0);
+	if (class)
+		class->no_check_recursion = true;
+	lockdep_recursion_finish();
+	raw_local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(lockdep_set_no_check_recursion);
+#endif
-- 
2.40.1

