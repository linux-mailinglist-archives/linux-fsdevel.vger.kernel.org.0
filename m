Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F8B439A5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 17:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhJYPYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 11:24:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55324 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbhJYPYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:24:43 -0400
Date:   Mon, 25 Oct 2021 17:22:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635175340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tXdRmOYW2kGdF+1FZaIRpehB56z37OH2PyhMORWw+Kc=;
        b=4tBntR1FljNLp19gDsFXFa/5cC0bl46T3YVXfhwyeunrVy+SsiPGyO+YUZSETmYBmr0cOv
        Q6jsPCa+II4WshxoE8R5b51CM1uLbQye10LN3jYvudSg9Sa4RhZxRZxXo/2xVJVw8CIZhh
        sT7M4W3quX6CMjuJCSgNwTsKkTyDMWVKoVj4BVn9JFJ/q+tgShjZ1gO9v6w5Ozh0ysTcGq
        jAlgXKVv+eb0amTKkKqv0kWjgrgmYxO/WCyGX1MYv88qTgLaau2P3P0RnYxjCSiSjg06+J
        bKXN1tjYIN1esWSIv6Iw1ajrFI8JQNlgUtSgGWfpT3NgtBP6fPQH6HKkX7t/cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635175340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tXdRmOYW2kGdF+1FZaIRpehB56z37OH2PyhMORWw+Kc=;
        b=rgzbVWFUjakS4xLRAsDFPq1sCjrFCu1pIYuhWfP9zM/3MRjJ2Mm1g8lEL2GmIJRFJrFKaE
        X0tyvGVQMoNnnOAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] fs/namespace: Boost the mount_lock.lock owner instead of
 spinning on PREEMPT_RT.
Message-ID: <20211025152218.opvcqfku2lhqvp4o@linutronix.de>
References: <20211021220102.bm5bvldjtzsabbfn@linutronix.de>
 <20211025091504.6k7d57awbfpqmmqs@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211025091504.6k7d57awbfpqmmqs@wittgenstein>
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
2.33.0

