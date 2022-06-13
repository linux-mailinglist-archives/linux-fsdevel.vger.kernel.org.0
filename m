Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D8D549B33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 20:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243347AbiFMSMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 14:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244988AbiFMSMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:12:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8E9939E0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 07:07:19 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655129237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87EpkWmEwWgOBFozevPLbLZSYBNCHi4bNcpHTmRBRbk=;
        b=wD/5DhCWrF+p6Sk/uKX/ZEEQ1dqfOjkpV3UPf2L728JwuQMPZUUMjKl+F9OvG+j9AXicfj
        qHCBv2FqBOCFbk2LfvLJp1u2KwMMB6mZkES4Ym/VM+1LKdcE4KRbaCcfFLIoldbvDJY8sK
        ytASSt8TWVYeyRwRcVHlF1eecX8XdjPTh5coEIdmSjuB/79rMd1GcpefKK7K0CBD55n+kN
        03lbpz5tTYbzx7Wbgvii9cPf9YkGh2z0z1GLjeA+rmKB6MlZ0kr6gZGc1cA8KOmXazI3LO
        0o5Pu2MP/wyXjB0E/JBtT6lrzVSeRJtLEN5Jc791VgmldZamqpP8jXUxq+6bNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655129237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87EpkWmEwWgOBFozevPLbLZSYBNCHi4bNcpHTmRBRbk=;
        b=b33OmkOqNwmF4Yblp1XTB+nDyB1Dx8aXGPiJ/jyhwmS7ArX3AbOL7FigCEiyMVzl9LCyJi
        TEd/HtuX0yhAuFBA==
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/4] fs/dcache: Split __d_lookup_done()
Date:   Mon, 13 Jun 2022 16:07:10 +0200
Message-Id: <20220613140712.77932-3-bigeasy@linutronix.de>
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

__d_lookup_done() wakes waiters on dentry::d_wait inside a preemption
disabled region. This violates the PREEMPT_RT constraints as the wake up
acquires wait_queue_head::lock which is a "sleeping" spinlock on RT.

As a first step to solve this, move the wake up outside of the
hlist_bl_lock() held section.

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

Let __d_lookup_unhash():

  1) Lock the lookup hash and clear DCACHE_PAR_LOOKUP
  2) Unhash the dentry
  3) Retrieve and clear dentry::d_wait
  4) Unlock the hash and return the retrieved waitqueue head pointer
  5) Let the caller handle the wake up.

This does not yet solve the PREEMPT_RT problem completely because
preemption is still disabled due to i_dir_seq being held for write. This
will be addressed in subsequent steps.

An alternative solution would be to switch the waitqueue to a simple
waitqueue, but aside of Linus not being a fan of them, moving the wake up
closer to the place where dentry::lock is unlocked reduces lock contention
time for the woken up waiter.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/dcache.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 92aa72fce5e2e..fae4689a9a409 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2711,18 +2711,33 @@ struct dentry *d_alloc_parallel(struct dentry *pare=
nt,
 }
 EXPORT_SYMBOL(d_alloc_parallel);
=20
-void __d_lookup_done(struct dentry *dentry)
+/*
+ * - Unhash the dentry
+ * - Retrieve and clear the waitqueue head in dentry
+ * - Return the waitqueue head
+ */
+static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
 {
-	struct hlist_bl_head *b =3D in_lookup_hash(dentry->d_parent,
-						 dentry->d_name.hash);
+	wait_queue_head_t *d_wait;
+	struct hlist_bl_head *b;
+
+	lockdep_assert_held(&dentry->d_lock);
+
+	b =3D in_lookup_hash(dentry->d_parent, dentry->d_name.hash);
 	hlist_bl_lock(b);
 	dentry->d_flags &=3D ~DCACHE_PAR_LOOKUP;
 	__hlist_bl_del(&dentry->d_u.d_in_lookup_hash);
-	wake_up_all(dentry->d_wait);
+	d_wait =3D dentry->d_wait;
 	dentry->d_wait =3D NULL;
 	hlist_bl_unlock(b);
 	INIT_HLIST_NODE(&dentry->d_u.d_alias);
 	INIT_LIST_HEAD(&dentry->d_lru);
+	return d_wait;
+}
+
+void __d_lookup_done(struct dentry *dentry)
+{
+	wake_up_all(__d_lookup_unhash(dentry));
 }
 EXPORT_SYMBOL(__d_lookup_done);
=20
--=20
2.36.1

