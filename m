Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A1159742C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 18:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbiHQQ1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 12:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240992AbiHQQ1k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:27:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90366A026D;
        Wed, 17 Aug 2022 09:27:38 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660753656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0Ok6MUAk8x3w8mPmM/6Qoan0Ip4Uzec0QyzMU/ssm0=;
        b=R9L/lild30rdOVsQc6pLpf3scnK6BTt6SxBcaGCg103/2NyevPy7UhkQWpNkeTFph/5n6p
        5DLaTNT8/q8nhhqaqlc4+/VAZAi5hos4h4H214aL2Ug+lzm7UUWEyhATRLpPoFSDAw1lfG
        eXJISnCWkZYoDag28Ubv+oRd6Vj68u7r5fPS84bAySnR3MQf16TpQ1411jCEwT2lKstoDh
        GIiA/vCl6WMat5bmP16QKxByD9zdl7QP/AeXIq3f/L6cuhoGvzY/ArEZHd69sas1TINAjj
        mPWk+IX0Cd6IVQCyjD+Z7hluH0hNmYfpxvIvx6WaLwH6Q2jXj9xpJVje6Ru2QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660753656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0Ok6MUAk8x3w8mPmM/6Qoan0Ip4Uzec0QyzMU/ssm0=;
        b=TFIefRo56E8S2+NDTHAb/IgOFgHMaOeEPY0cPRNmU9q0IJdS03M6Fr8tg6vagcUmQqUdXw
        zLwNRJApEbVTx7Ag==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/9] dentry: Use preempt_[dis|en]able_nested()
Date:   Wed, 17 Aug 2022 18:26:57 +0200
Message-Id: <20220817162703.728679-4-bigeasy@linutronix.de>
In-Reply-To: <20220817162703.728679-1-bigeasy@linutronix.de>
References: <20220817162703.728679-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Replace the open coded CONFIG_PREEMPT_RT conditional
preempt_disable/enable() with the new helper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/dcache.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c5dc32a59c769..e633b20623d0f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2571,15 +2571,7 @@ EXPORT_SYMBOL(d_rehash);
=20
 static inline unsigned start_dir_add(struct inode *dir)
 {
-	/*
-	 * The caller holds a spinlock (dentry::d_lock). On !PREEMPT_RT
-	 * kernels spin_lock() implicitly disables preemption, but not on
-	 * PREEMPT_RT.  So for RT it has to be done explicitly to protect
-	 * the sequence count write side critical section against a reader
-	 * or another writer preempting, which would result in a live lock.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 	for (;;) {
 		unsigned n =3D dir->i_dir_seq;
 		if (!(n & 1) && cmpxchg(&dir->i_dir_seq, n, n + 1) =3D=3D n)
@@ -2592,8 +2584,7 @@ static inline void end_dir_add(struct inode *dir, uns=
igned int n,
 			       wait_queue_head_t *d_wait)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 	wake_up_all(d_wait);
 }
=20
--=20
2.37.2

