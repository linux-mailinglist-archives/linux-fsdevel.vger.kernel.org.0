Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E1F5825DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 13:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiG0LtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 07:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiG0LtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:49:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683894AD7B
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 04:49:13 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658922552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8H4RHHLP/IC4duyp+ci7tktfckRg+ea6zo6aVOrzr/4=;
        b=K5b7X5hiFu6JtSxqKWdUXdwgHOKSw2ACh0cXDIlPx2iNlWJF1YOZJ2TEHO1aybrZ5Zx92o
        XjeSWTd8Plq8u9jBnCCjYUmlasUl5/BsK7pGcgj1SEy25wtPz9euE0xTrcQdUqpJUxp5bn
        kC/K6bqSrCFo5zDvXkcqbarhveQlBj5klJ07YiAqn7fc2yYdK99e7m9gZAqRCbsGewmVxn
        XLEVCrtKzu2E0foQD3RLfh9h0KP5hTDhVK81X1pmumno9QrLiPoHJZ+geVaHlgAEGwOeNM
        YYsUePOPA4TyEb5mJw3EWSJuO/qjTPiB53vBwsYh5NkzHBpKJqNr7WK7fuTbsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658922552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8H4RHHLP/IC4duyp+ci7tktfckRg+ea6zo6aVOrzr/4=;
        b=bIKZ5GdVndf3XmdOYYvPPHAjPeHNYSgOdG7DbKChuYtr9c7k/+vk9ShGQS//3iXuTxh2Sz
        Ez75s8YZcAVjcrCQ==
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleg.Karfich@wago.com
Subject: [PATCH 2/4 v2] fs/dcache: Disable preemption on i_dir_seq write side on PREEMPT_RT
Date:   Wed, 27 Jul 2022 13:49:02 +0200
Message-Id: <20220727114904.130761-3-bigeasy@linutronix.de>
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
Link: https://lkml.kernel.org/r/20220613140712.77932-2-bigeasy@linutronix.de
---
 fs/dcache.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2564,7 +2564,15 @@ EXPORT_SYMBOL(d_rehash);
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
@@ -2576,6 +2584,8 @@ static inline unsigned start_dir_add(str
 static inline void end_dir_add(struct inode *dir, unsigned n)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
=20
 static void d_wait_lookup(struct dentry *dentry)
