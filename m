Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D65B45D9C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 13:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhKYMM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 07:12:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51594 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbhKYMK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:10:28 -0500
Date:   Thu, 25 Nov 2021 13:07:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637842033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QGtmjng0PQbgY5OOuYF6+GO6/GjAM82C+oLaqmZOAVM=;
        b=qMThQXLxv8PCwup2/gMtETbCUM29cEvnN095rQHS0BfvC8O3F2lATfXQ7YyaItTw6BSi0K
        fw7e7oU621Ah+GgYUzFqUDIBsQGKxQL2foPnqh+wnImsa0T4zS+6DU5mOQeAAW4WbI2JPV
        CXiIEnhXbXYJeI5/rbWMWXY/mQTLmwcTBn9/z6zygN8VjgLcWT23F74uA6fCuUfXtO+0X9
        RXBBmyI2haiO7zLZ+YFI8BHHHYW1G6vuCBbpbGwc8K/ISRoeXK51XaV/cceSp+sbOZlWab
        eW/nagMCXN5Dm4eQ6Nf2B0fYe6nRt8EmUdtLcYVQ2G27DbOl78Cp7mjeuX7qWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637842033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QGtmjng0PQbgY5OOuYF6+GO6/GjAM82C+oLaqmZOAVM=;
        b=IgdbA1hMaulEE/LbL2Fa41Ba7yMk/4t/ChPSSn5HqWbnRQWbhYOw4oUDL4aTMqoosmx9qm
        SHH9oqwQF9hb8+AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH REPOST] fs/namespace: Boost the mount_lock.lock owner instead
 of spinning on PREEMPT_RT.
Message-ID: <20211125120711.dgbsienyrsxfzpoi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The MNT_WRITE_HOLD flag is used to hold back any new writers while the
mount point is about to be made read-only. __mnt_want_write() then loops
with disabled preemption until this flag disappears. Callers of
mnt_hold_writers() (which sets the flag) hold the spinlock_t of
mount_lock (seqlock_t) which disables preemption on !PREEMPT_RT and
ensures the task is not scheduled away so that the spinning side spins
for a long time.

On PREEMPT_RT the spinlock_t does not disable preemption and so it is
possible that the task setting MNT_WRITE_HOLD is preempted by task with
higher priority which then spins infinitely waiting for MNT_WRITE_HOLD
to get removed.

Acquire mount_lock::lock which is held by setter of MNT_WRITE_HOLD. This
will PI-boost the owner and wait until the lock is dropped and which
means that MNT_WRITE_HOLD is cleared again.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Link: https://lore.kernel.org/r/20211025152218.opvcqfku2lhqvp4o@linutronix.de
---
 fs/namespace.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 659a8f39c61af..3ab45b47b2860 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -343,8 +343,24 @@ int __mnt_want_write(struct vfsmount *m)
 	 * incremented count after it has set MNT_WRITE_HOLD.
 	 */
 	smp_mb();
-	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD)
-		cpu_relax();
+	might_lock(&mount_lock.lock);
+	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD) {
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			cpu_relax();
+		} else {
+			/*
+			 * This prevents priority inversion, if the task
+			 * setting MNT_WRITE_HOLD got preempted on a remote
+			 * CPU, and it prevents life lock if the task setting
+			 * MNT_WRITE_HOLD has a lower priority and is bound to
+			 * the same CPU as the task that is spinning here.
+			 */
+			preempt_enable();
+			lock_mount_hash();
+			unlock_mount_hash();
+			preempt_disable();
+		}
+	}
 	/*
 	 * After the slowpath clears MNT_WRITE_HOLD, mnt_is_readonly will
 	 * be set to match its requirements. So we must not load that until
-- 
2.34.0

