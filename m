Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676BA60E293
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 15:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiJZNud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 09:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiJZNuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:50:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CFBB21
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Oct 2022 06:49:25 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666792163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J6fdA2PuNf7lAKCg4xeCD6LMsriAUCedCbXOb0fH3no=;
        b=Xfu1AhiG5mM50qHXxgKR5zxDonMaJjNja7V8PdW8xZ1QLKGnTXQ1cNXw8/50Fblm8SrfCj
        Nwd1vL/H+OL8NZMQfnwWEEqJjeNWI3Cd9AsgIOpeKEl+ydDMyC0CZHT28BanqMgz7q4vy0
        /1kcFdeEsr+uCiXn0G/KwIdje029zhZ4vwbzUxhxrzWP+IdsBjoR1tBKGERkbAk/k5SFCB
        xZIHWAyb6q5sEkY3qjjYsyIVKH7VCauosAc4CwjJ6Dnfy47fSvzmvvTQtFasclDlby85zh
        35YKTwSb/Ou3gnT356zqMXy6i7zShGBI4UZHFjACGcB/qJbJa7OjYlF9HcHEuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666792163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J6fdA2PuNf7lAKCg4xeCD6LMsriAUCedCbXOb0fH3no=;
        b=DzOoRUCi24YEy0pYcWsZar/4gotUFL4lx0JK0RgQDP666u+uSENZXto66B5Z864gLU2Jzn
        ACHXovuDmTI12vBQ==
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] mm: multi-gen LRU: Move lru_gen_add_mm() out of IRQ-off region.
Date:   Wed, 26 Oct 2022 15:48:30 +0200
Message-Id: <20221026134830.711887-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

lru_gen_add_mm() has been added within an IRQ-off region in the commit
mentioned below. The other invocations of lru_gen_add_mm() are not within
an IRQ-off region.
The invocation within IRQ-off region is problematic on PREEMPT_RT
because the function is using a spin_lock_t which must not be used
within IRQ-disabled regions.

The other invocations of lru_gen_add_mm() occur while task_struct::alloc_lo=
ck
is acquired.
Move lru_gen_add_mm() after interrupts are enabled and before
task_unlock().

Fixes: bd74fdaea1460 ("mm: multi-gen LRU: support page table walks")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/exec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1012,7 +1012,6 @@ static int exec_mmap(struct mm_struct *m
 	active_mm =3D tsk->active_mm;
 	tsk->active_mm =3D mm;
 	tsk->mm =3D mm;
-	lru_gen_add_mm(mm);
 	/*
 	 * This prevents preemption while active_mm is being loaded and
 	 * it and mm are being updated, which could cause problems for
@@ -1025,6 +1024,7 @@ static int exec_mmap(struct mm_struct *m
 	activate_mm(active_mm, mm);
 	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
 		local_irq_enable();
+	lru_gen_add_mm(mm);
 	task_unlock(tsk);
 	lru_gen_use_mm(mm);
 	if (old_mm) {
