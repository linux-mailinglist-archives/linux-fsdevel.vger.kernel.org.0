Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EA6549B36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 20:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244772AbiFMSMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 14:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiFMSMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:12:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AD8939D9
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 07:07:18 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655129236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXvpzTKK6kImxAfJ/1ZX0l3M0MzAghGg+baWoltyoCM=;
        b=EM1a8mm0p3Eq81bf3kzqOSVkHFu+7eYdWYpx9HxizfhBpGQ4X6GxWAxsFbVNAe9e6svl/N
        2OQj0VQ80Mu/jEg7aNkpPhEYZddg0hIeaCtUFsAcvHYETJZDdi85Q4YGDim3bgHQlX2QNr
        PMNpMtMFeEJKvmJ7Ky6m1KE5lFM6K68SwvrMN2kMYS2O5nyw9bNj4Rd/21thB5XbUKfROH
        x2M17Z8sDcl7aDmcZdj+MtEz/GPjf/fl18KwpFVjlkol8HhmVz5iVMo2FUmxrbni+9npX7
        SXVytfYUnlzdAMIEDrWc1EQeo9eq3e7drE1Yj1tTt1YediPR5ZpkxWstvL9+oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655129236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXvpzTKK6kImxAfJ/1ZX0l3M0MzAghGg+baWoltyoCM=;
        b=KsQ4OYdxTtWV8iYHDUkuB6YQYLaDZkXY4mCoeQEFm1yrfalbrZDNkdCSznnhPaFegBoQYC
        PZRVb3dpOLu9hMAg==
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleg.Karfich@wago.com
Subject: [PATCH 1/4] fs/dcache: Disable preemption on i_dir_seq write side on PREEMPT_RT
Date:   Mon, 13 Jun 2022 16:07:09 +0200
Message-Id: <20220613140712.77932-2-bigeasy@linutronix.de>
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

i_dir_seq is a sequence counter with a lock which is represented by the
lowest bit. The writer atomically updates the counter which ensures that it
can be modified by only one writer at a time. This requires preemption to
be disabled across the write side critical section.

On !PREEMPT_RT kernels this is implicit by the caller acquiring
dentry::lock. On PREEMPT_RT kernels spin_lock() does not disable preemption
which means that a preempting writer or reader would live lock. It's
therefore required to disable preemption explicitly.

An alternative solution would be to replace i_dir_seq with a seqlock_t for
PREEMPT_RT, but that comes with its own set of problems due to arbitrary
lock nesting. A pure sequence count with an associated spinlock is not
possible because the locks held by the caller are not necessarily related.

As the critical section is small, disabling preemption is a sensible
solution.

Reported-by: Oleg.Karfich@wago.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/dcache.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 93f4f5ee07bfd..92aa72fce5e2e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2563,7 +2563,15 @@ EXPORT_SYMBOL(d_rehash);
=20
 static inline unsigned start_dir_add(struct inode *dir)
 {
-
+	/*
+	 * The caller holds a spinlock (dentry::d_lock). On !PREEMPT_RT
+	 * kernels spin_lock() implicitly disables preemption, but not on
+	 * PREEMPT_RT.  So for RT it has to be done explicitly to protect
+	 * the sequence count write side critical section against a reader
+	 * or another writer preempting, which would result in a live lock.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 	for (;;) {
 		unsigned n =3D dir->i_dir_seq;
 		if (!(n & 1) && cmpxchg(&dir->i_dir_seq, n, n + 1) =3D=3D n)
@@ -2575,6 +2583,8 @@ static inline unsigned start_dir_add(struct inode *di=
r)
 static inline void end_dir_add(struct inode *dir, unsigned n)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
=20
 static void d_wait_lookup(struct dentry *dentry)
--=20
2.36.1

