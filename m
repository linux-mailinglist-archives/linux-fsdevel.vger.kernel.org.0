Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3027C549B34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 20:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbiFMSMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 14:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243526AbiFMSMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:12:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B55D939DF
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 07:07:19 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655129237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IG13RLOoPvGR+qM//UejEuxu7S13GlSV9DmStF4ErgY=;
        b=UkJX3pnGnoeWOJoCbDihwzhMUKYhZlkr/xk/Vi5+1ln3jpOHnANSxlOSORGh6mB6GU4PNl
        aO7ZJOKpQVRMDfpIv/LYe1S/Ks5UbLW4QzY+OWBk5BHW0G8DU2nkW8ccA5dcHTKNTCev9a
        WHZGFfx8lBDZDNz3pmP4hJyaIxHzffz7bCa48dZdVzSw9j9zFFEgqj0u9zR1/qV8fidbkX
        JI5ohxeuweE5hzxKUYaQFvFKGWO7YYObeDrEfciueSL51GgGUsFrBstBLxy+dCpNXlcXOb
        CYW6nugajSn5weqJ5h03i8aRjKzFUyeGyopziT5YEAdhRND5LBadDhkkRCfhBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655129237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IG13RLOoPvGR+qM//UejEuxu7S13GlSV9DmStF4ErgY=;
        b=UhOD4ei8tiD3Rfx8VfwZTTIT8bR3KwBuCdSt5Z7q2fc0+CyK0p5eGwAKboxzjj8ByQUCwz
        WxMv64RDEiiuN6Dw==
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/4] fs/dcache: Move wakeup out of i_seq_dir write held region
Date:   Mon, 13 Jun 2022 16:07:12 +0200
Message-Id: <20220613140712.77932-5-bigeasy@linutronix.de>
In-Reply-To: <20220613140712.77932-1-bigeasy@linutronix.de>
References: <20220613140712.77932-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__d_add() and __d_move() wake up waiters on dentry::d_wait from within the
i_seq_dir write held region.  This violates the PREEMPT_RT constraints as
the wake up acquires wait_queue_head::lock which is a "sleeping" spinlock
on RT.

There is no requirement to do so. __d_lookup_unhash() has cleared
DCACHE_PAR_LOOKUP and dentry::d_wait and returned the now unreachable wait
queue head pointer to the caller, so the actual wake up can be postponed
until the i_dir_seq write side critical section is left. The only
requirement is that dentry::lock is held across the whole sequence
including the wake up.

This is safe because:

  1) The whole sequence including the wake up is protected by dentry::lock.

  2) The waitqueue head is allocated by the caller on stack and can't go
     away until the whole callchain completes.

  3) If a queued waiter is woken by a spurious wake up, then it is blocked
     on dentry:lock before it can observe DCACHE_PAR_LOOKUP cleared and
     return from d_wait_lookup().

     As the wake up is inside the dentry:lock held region it's guaranteed
     that the waiters waitq is dequeued from the waitqueue head before the
     waiter returns.

     Moving the wake up past the unlock of dentry::lock would allow the
     waiter to return with the on stack waitq still enqueued due to a
     spurious wake up.

  4) New waiters have to acquire dentry::lock before checking whether the
     DCACHE_PAR_LOOKUP flag is set.

Move the wake up past end_dir_add() which leaves the i_dir_seq write side
critical section and enables preemption.

For non RT kernels there is no difference because preemption is still
disabled due to dentry::lock being held, but it shortens the time between
wake up and unlocking dentry::lock, which reduces the contention for the
woken up waiter.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/dcache.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 6ef1f5c32bc0f..0b5fd3a17ff7c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2747,13 +2747,15 @@ EXPORT_SYMBOL(__d_lookup_done);
=20
 static inline void __d_add(struct dentry *dentry, struct inode *inode)
 {
+	wait_queue_head_t *d_wait;
 	struct inode *dir =3D NULL;
 	unsigned n;
+
 	spin_lock(&dentry->d_lock);
 	if (unlikely(d_in_lookup(dentry))) {
 		dir =3D dentry->d_parent->d_inode;
 		n =3D start_dir_add(dir);
-		wake_up_all(__d_lookup_unhash(dentry));
+		d_wait =3D __d_lookup_unhash(dentry);
 	}
 	if (inode) {
 		unsigned add_flags =3D d_flags_for_inode(inode);
@@ -2764,8 +2766,10 @@ static inline void __d_add(struct dentry *dentry, st=
ruct inode *inode)
 		fsnotify_update_flags(dentry);
 	}
 	__d_rehash(dentry);
-	if (dir)
+	if (dir) {
 		end_dir_add(dir, n);
+		wake_up_all(d_wait);
+	}
 	spin_unlock(&dentry->d_lock);
 	if (inode)
 		spin_unlock(&inode->i_lock);
@@ -2912,6 +2916,7 @@ static void __d_move(struct dentry *dentry, struct de=
ntry *target,
 		     bool exchange)
 {
 	struct dentry *old_parent, *p;
+	wait_queue_head_t *d_wait;
 	struct inode *dir =3D NULL;
 	unsigned n;
=20
@@ -2942,7 +2947,7 @@ static void __d_move(struct dentry *dentry, struct de=
ntry *target,
 	if (unlikely(d_in_lookup(target))) {
 		dir =3D target->d_parent->d_inode;
 		n =3D start_dir_add(dir);
-		wake_up_all(__d_lookup_unhash(target));
+		d_wait =3D __d_lookup_unhash(target);
 	}
=20
 	write_seqcount_begin(&dentry->d_seq);
@@ -2977,8 +2982,10 @@ static void __d_move(struct dentry *dentry, struct d=
entry *target,
 	write_seqcount_end(&target->d_seq);
 	write_seqcount_end(&dentry->d_seq);
=20
-	if (dir)
+	if (dir) {
 		end_dir_add(dir, n);
+		wake_up_all(d_wait);
+	}
=20
 	if (dentry->d_parent !=3D old_parent)
 		spin_unlock(&dentry->d_parent->d_lock);
--=20
2.36.1

