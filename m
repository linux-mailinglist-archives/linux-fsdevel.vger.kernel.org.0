Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4B1549B32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 20:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244882AbiFMSMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 14:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239904AbiFMSMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:12:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B175939DD
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 07:07:19 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655129236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cCYjpXpgc4YqTKn6saNVbAhQFexxS1txRKqlFVDovZw=;
        b=B7SF4JVh1vOP7C8qRmwnwznL+JbnoBUlpQBBAmrCpKNxAJkbsPOhbytmWi01NB0eyDhBYC
        BmJEhbb+dR6BIYkIElHVjfM9AgAcYFfbMLkUFxJo51nRjCELjhbi2la5yn8JWv0HodKtQ0
        W3Y5SBtzW8gGNt3Mo66Rx6+gf1XtgUzd8zS95NqD93BYC+wqF2qE9MmUCYIbF0Qs1G6/aW
        1broQtUryeI1QQuoMPUt6+5VKct+P6YpOq1cybOiKnOqMW9OsFjFP+RlQ6DZCNxV/QJDY/
        iDgnTdPEgmD576BwJcbvIaRqGZsfVb1FQHAiAD1A4dv9b+dlZaxheBnwGz0m/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655129236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cCYjpXpgc4YqTKn6saNVbAhQFexxS1txRKqlFVDovZw=;
        b=CFJM5tSRnZl/JIB4tQ2XsHr6BB1BUjV6lp0pwhUC/NxKrHK9XMmCUrMGwefva5BH1+Df5s
        OxkctxTlENrZcRDw==
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: fs/dcache: Resolve the last RT woes.
Date:   Mon, 13 Jun 2022 16:07:08 +0200
Message-Id: <20220613140712.77932-1-bigeasy@linutronix.de>
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



