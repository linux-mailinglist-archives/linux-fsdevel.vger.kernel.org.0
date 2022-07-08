Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8814556BD51
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbiGHPwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 11:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiGHPwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:52:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CE174357
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 08:52:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657295561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g2UDaaX3nPtP0j8WaJY8yyVFXLz0Wfv/zDVZFCoib/E=;
        b=4g2U8RS944txEFgibfllugk134YktNRAdZUK+IUJ7sCa0VY98Icptt577+3lbKwjiv8SPp
        WvYN7YQhZJSlwFlC5yjmZXLQjt+4M3wGxMtnYl0NPojzZKGNrpqzTede5VMU71nOi29jHC
        f9H92THN9CAmEDoKkWgsITSSPDmoRwWeuryX9t2ffcrLnor+leftfRCja2PUI4viUTnMcZ
        OjbKc2D7zZMYELbStkcHMRY9IfuRnTKuyjqSF7M9sn0gApFcJ6c+LthIKJ4OFcv8Yh+Tj3
        u6Cg+vEIAsJ9iLuouxbNZwNJINa+XVbPTSait2QvYjbeeahYQQ1JXKDveBwfIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657295561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g2UDaaX3nPtP0j8WaJY8yyVFXLz0Wfv/zDVZFCoib/E=;
        b=3/zE/VliDdPAZgUiE8ejcUEpT/S/PrWW50eYOYVutV3CwfRTlbUebeKpnCPO149IEI2Vq6
        uGQsqXGk03ksT8Cw==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: fs/dcache: Resolve the last RT woes.
In-Reply-To: <20220613140712.77932-1-bigeasy@linutronix.de>
References: <20220613140712.77932-1-bigeasy@linutronix.de>
Date:   Fri, 08 Jul 2022 17:52:40 +0200
Message-ID: <877d4nvbxz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 13 2022 at 16:07, Sebastian Andrzej Siewior wrote:

Polite ping ....


> PREEMPT_RT has two issues with the dcache code:
>
>    1) i_dir_seq is a special cased sequence counter which uses the lowest
>       bit as writer lock. This requires that preemption is disabled.
>
>       On !RT kernels preemption is implictly disabled by spin_lock(), but
>       that's not the case on RT kernels.
>
>       Replacing i_dir_seq on RT with a seqlock_t comes with its own
>       problems due to arbitrary lock nesting. Using a seqcount with an
>       associated lock is not possible either because the locks held by the
>       callers are not necessarily related.
>
>       Explicitly disabling preemption on RT kernels across the i_dir_seq
>       write held critical section is the obvious and simplest solution. The
>       critical section is small, so latency is not really a concern.
>
>    2) The wake up of dentry::d_wait waiters is in a preemption disabled
>       section, which violates the RT constraints as wake_up_all() has
>       to acquire the wait queue head lock which is a 'sleeping' spinlock
>       on RT.
>
>       There are two reasons for the non-preemtible section:
>
>          A) The wake up happens under the hash list bit lock
>
>          B) The wake up happens inside the i_dir_seq write side
>             critical section
>
>        #A is solvable by moving it outside of the hash list bit lock held                                                                                                                      
>        section.
>
>        Making #B preemptible on RT is hard or even impossible due to lock
>        nesting constraints.
>
>        A possible solution would be to replace the waitqueue by a simple
>        waitqueue which can be woken up inside atomic sections on RT.
>
>        But aside of Linus not being a fan of simple waitqueues, there is
>        another observation vs. this wake up. It's likely for the woken up
>        waiter to immediately contend on dentry::lock.
>
>        It turns out that there is no reason to do the wake up within the
>        i_dir_seq write held region. The only requirement is to do the wake
>        up within the dentry::lock held region. Further details in the
>        individual patches.
>
>        That allows to move the wake up out of the non-preemptible section
>        on RT, which also reduces the dentry::lock held time after wake up.
>
> Thanks,
>
> Sebastian
