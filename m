Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA8EBADE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfJaXrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:47:08 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55729 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728812AbfJaXqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:34 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 20C713A2710;
        Fri,  1 Nov 2019 10:46:25 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007Cm-TS; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-00042T-RH; Fri, 01 Nov 2019 10:46:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/28] rwsem: introduce down/up_write_non_owner
Date:   Fri,  1 Nov 2019 10:46:17 +1100
Message-Id: <20191031234618.15403-28-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
        a=PQ_rIYW8ek-NpEnsdwgA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

To serialise freeing of inodes against unreferenced lookups, XFS
wants to hold the inode locked from the reclaim context that queues
it from RCU freeing until the grace period that actually frees the
inode. THis means the inode is being unlocked by a context that
didn't lock it, and that makes lockdep unhappy.

This is a very special use case - inodes can be found once marked
for reclaim because of lockless RCU lookups, so we need some
synchronisation that will prevent such inodes from being locked.  To
access an unreferenced inode we need to take the ILOCK rwsem without
blocking and still under rcu_read_lock() to hold off reclaim of the
inode. If the inode has been reclaimed and is queued for freeing,
holding the ILOCK rwsem until the RCU grace period expires means
no lookup that finds it in that grace period will be able to lock it
and use it. Once the grace period expires we are guaranteed that
nothing will ever find the inode again, and we can unlock it and
free it.

This requires down_write_trylock_non_owner() in the reclaim context
before we mark the inode as reclaimed and run call_rcu() to free it.
It require up_write_non_owner() in the RCU callback before we free
the inode.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/rwsem.h  |  6 ++++++
 kernel/locking/rwsem.c | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 00d6054687dd..e557bd994d0e 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -191,6 +191,9 @@ do {								\
  */
 extern void down_read_non_owner(struct rw_semaphore *sem);
 extern void up_read_non_owner(struct rw_semaphore *sem);
+extern void down_write_non_owner(struct rw_semaphore *sem);
+extern int down_write_trylock_non_owner(struct rw_semaphore *sem);
+extern void up_write_non_owner(struct rw_semaphore *sem);
 #else
 # define down_read_nested(sem, subclass)		down_read(sem)
 # define down_write_nest_lock(sem, nest_lock)	down_write(sem)
@@ -198,6 +201,9 @@ extern void up_read_non_owner(struct rw_semaphore *sem);
 # define down_write_killable_nested(sem, subclass)	down_write_killable(sem)
 # define down_read_non_owner(sem)		down_read(sem)
 # define up_read_non_owner(sem)			up_read(sem)
+# define down_write_non_owner(sem)		down_write(sem)
+# define down_write_trylock_non_owner(sem)	down_write_trylock(sem)
+# define up_write_non_owner(sem)		up_write(sem)
 #endif
 
 #endif /* _LINUX_RWSEM_H */
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index eef04551eae7..36162d42fe09 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1654,4 +1654,27 @@ void up_read_non_owner(struct rw_semaphore *sem)
 }
 EXPORT_SYMBOL(up_read_non_owner);
 
+void down_write_non_owner(struct rw_semaphore *sem)
+{
+	might_sleep();
+	__down_write(sem);
+}
+EXPORT_SYMBOL(down_write_non_owner);
+
+/*
+ * trylock for writing -- returns 1 if successful, 0 if contention
+ */
+int down_write_trylock_non_owner(struct rw_semaphore *sem)
+{
+	return __down_write_trylock(sem);
+}
+EXPORT_SYMBOL(down_write_trylock_non_owner);
+
+void up_write_non_owner(struct rw_semaphore *sem)
+{
+	rwsem_set_owner(sem);
+	__up_write(sem);
+}
+EXPORT_SYMBOL(up_write_non_owner);
+
 #endif
-- 
2.24.0.rc0

