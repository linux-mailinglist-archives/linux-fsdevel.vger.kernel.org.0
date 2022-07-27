Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F415825E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 13:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiG0LtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiG0LtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:49:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684EE4AD7C
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 04:49:14 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658922552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/FOS4ONZOEScBk2DyiWA/nhAEuypXKhytyCAeqticw=;
        b=M6WlP+Q5YZKVsIMBtwPfVjIHFqXYdyLlhgC0e0LPgoeHNfRkLJut0CMORJEHMHfgHwvs/U
        4d9oeV6naEOBog5kchOkQMA/+AvAUycx5sNQ4m23iUdEYQFk8MuDRhydqP/4gkA91L31t2
        L/YpthKfdcCDETtregE9ILJVLyJPKbSmD7fRb92Dqg+sAYrOF9QYV6KaeXz5v4I9VwNZV4
        E8DbKshbjy9cJp0azEqb4y1U4nDVumtjm/f0hsU2qPuEh4Rbm7P2QHnWcJO/8NkgFyORdU
        cSUMggNY5A/Wm/YC3/YCFKqWupfh9DDq/IADchvVTUcRqyJG+F8vPfGK5UXAxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658922552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/FOS4ONZOEScBk2DyiWA/nhAEuypXKhytyCAeqticw=;
        b=7vqBqG6gM2WhPx5qo0MR3CQFdFhH5Vwd6raYDwrsdHf90ka+hKlXCR387Gm6hElhcBjQYV
        W5eslVdcypdEXuAQ==
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/4 v2] fs/dcache: Move wakeup out of i_seq_dir write held region.
Date:   Wed, 27 Jul 2022 13:49:04 +0200
Message-Id: <20220727114904.130761-5-bigeasy@linutronix.de>
In-Reply-To: <20220727114904.130761-1-bigeasy@linutronix.de>
References: <20220727114904.130761-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__d_add() and __d_move() wake up waiters on dentry::d_wait from within
the i_seq_dir write held region.  This violates the PREEMPT_RT
constraints as the wake up acquires wait_queue_head::lock which is a
"sleeping" spinlock on RT.

There is no requirement to do so. __d_lookup_unhash() has cleared
DCACHE_PAR_LOOKUP and dentry::d_wait and returned the now unreachable wait
queue head pointer to the caller, so the actual wake up can be postponed
until the i_dir_seq write side critical section is left. The only
requirement is that dentry::lock is held across the whole sequence
including the wake up. The previous commit includes an analysis why this
is considered safe.

Move the wake up past end_dir_add() which leaves the i_dir_seq write side
critical section and enables preemption.

For non RT kernels there is no difference because preemption is still
disabled due to dentry::lock being held, but it shortens the time between
wake up and unlocking dentry::lock, which reduces the contention for the
woken up waiter.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/dcache.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2581,11 +2581,13 @@ static inline unsigned start_dir_add(str
 	}
 }
=20
-static inline void end_dir_add(struct inode *dir, unsigned n)
+static inline void end_dir_add(struct inode *dir, unsigned int n,
+			       wait_queue_head_t *d_wait)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
+	wake_up_all(d_wait);
 }
=20
 static void d_wait_lookup(struct dentry *dentry)
@@ -2756,7 +2758,6 @@ static inline void __d_add(struct dentry
 		dir =3D dentry->d_parent->d_inode;
 		n =3D start_dir_add(dir);
 		d_wait =3D __d_lookup_unhash(dentry);
-		wake_up_all(d_wait);
 	}
 	if (inode) {
 		unsigned add_flags =3D d_flags_for_inode(inode);
@@ -2768,7 +2769,7 @@ static inline void __d_add(struct dentry
 	}
 	__d_rehash(dentry);
 	if (dir)
-		end_dir_add(dir, n);
+		end_dir_add(dir, n, d_wait);
 	spin_unlock(&dentry->d_lock);
 	if (inode)
 		spin_unlock(&inode->i_lock);
@@ -2947,7 +2948,6 @@ static void __d_move(struct dentry *dent
 		dir =3D target->d_parent->d_inode;
 		n =3D start_dir_add(dir);
 		d_wait =3D __d_lookup_unhash(target);
-		wake_up_all(d_wait);
 	}
=20
 	write_seqcount_begin(&dentry->d_seq);
@@ -2983,7 +2983,7 @@ static void __d_move(struct dentry *dent
 	write_seqcount_end(&dentry->d_seq);
=20
 	if (dir)
-		end_dir_add(dir, n);
+		end_dir_add(dir, n, d_wait);
=20
 	if (dentry->d_parent !=3D old_parent)
 		spin_unlock(&dentry->d_parent->d_lock);
