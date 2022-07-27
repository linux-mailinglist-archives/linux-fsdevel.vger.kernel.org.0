Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8FC5825E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiG0LtX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 07:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiG0LtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:49:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685D74AD7D
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 04:49:13 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658922551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xRKJXpuPOY37Ota4Hpp5h4OjuhB+djpnafgzHxMM0tk=;
        b=4C54cDG57KD1DEFXMj3/3DvbLuA1EnYC9vSJagp3/kgrOri8zkZ3ShMDKqxE7w7O/K9FrP
        KApNJ7h8h6E9Nw3GJM0oQPEX3ODR3HAENQFvC93ax5EXB/6aThpwY4OFpBU6Z/c0vq6EK9
        ZSj+/NyFHypscrBdEYokxamPFO4QCQEGlhMTKj4yS7vcbEoPr52yskFRi06yoFL4wz2WMZ
        Lf+K1ZEO5KK0cNaLf0SiFW05Ss2cuojoh7pQd9mwDSJHbecycr0+/WWQF/4J/z01NguRlS
        7XCyphmyEOHHlc21ZtmIVjx+ZkpcX/ETbnnBaFEvejeAW64+YybW+ffAD24NeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658922551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xRKJXpuPOY37Ota4Hpp5h4OjuhB+djpnafgzHxMM0tk=;
        b=yPVNNViplcdC41IZMg1Q5WtzDCBZgjxVsPl9IXg3EN24/Pmjhp/SuI+UZSRWgvmuQzAZl2
        KnoQADLANYcTb1Cg==
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/4 v2] fs/dcache: Resolve the last RT woes.
Date:   Wed, 27 Jul 2022 13:49:00 +0200
Message-Id: <20220727114904.130761-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is v2 of the series, v1 is available at
   https://https://lkml.kernel.org/r/.kernel.org/all/20220613140712.77932-1=
-bigeasy@linutronix.de/

v1=E2=80=A6v2:
   - Make patch around Al's description of a bug in d_add_ci(). I took
     the liberty to make him Author and added his signed-off-by since I
     sinmply added a patch-body around his words.

   - The reasoning of why delaying the wakeup is reasonable has been
     replaced with Al's analysis of the code.

   - The split of wake up has been done differently (and I hope this is
     what Al meant). First the wake up has been pushed to the caller and
     then delayed to end_dir_add() after preemption has been enabled.

   - There is still __d_lookup_unhash(), __d_lookup_unhash_wake() and
     __d_lookup_done() is removed.
     __d_lookup_done() is removed because it is exported and the return
     value changes which will affect OOT users which are not aware of
     it.
     There is still d_lookup_done() which invokes
     __d_lookup_unhash_wake(). This can't remain in the header file due
     to cyclic depencies which in turn can't resolve wake_up_all()
     within the inline function.

The original cover letter:

PREEMPT_RT has two issues with the dcache code:

   1) i_dir_seq is a special cased sequence counter which uses the lowest
      bit as writer lock. This requires that preemption is disabled.

      On !RT kernels preemption is implictly disabled by spin_lock(), but
      that's not the case on RT kernels.

      Replacing i_dir_seq on RT with a seqlock_t comes with its own
      problems due to arbitrary lock nesting. Using a seqcount with an
      associated lock is not possible either because the locks held by the
      callers are not necessarily related.

      Explicitly disabling preemption on RT kernels across the i_dir_seq
      write held critical section is the obvious and simplest solution. The
      critical section is small, so latency is not really a concern.

   2) The wake up of dentry::d_wait waiters is in a preemption disabled
      section, which violates the RT constraints as wake_up_all() has
      to acquire the wait queue head lock which is a 'sleeping' spinlock
      on RT.

      There are two reasons for the non-preemtible section:

         A) The wake up happens under the hash list bit lock

         B) The wake up happens inside the i_dir_seq write side
            critical section

       #A is solvable by moving it outside of the hash list bit lock held=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
       section.

       Making #B preemptible on RT is hard or even impossible due to lock
       nesting constraints.

       A possible solution would be to replace the waitqueue by a simple
       waitqueue which can be woken up inside atomic sections on RT.

       But aside of Linus not being a fan of simple waitqueues, there is
       another observation vs. this wake up. It's likely for the woken up
       waiter to immediately contend on dentry::lock.

       It turns out that there is no reason to do the wake up within the
       i_dir_seq write held region. The only requirement is to do the wake
       up within the dentry::lock held region. Further details in the
       individual patches.

       That allows to move the wake up out of the non-preemptible section
       on RT, which also reduces the dentry::lock held time after wake up.

Thanks,

Sebastian


