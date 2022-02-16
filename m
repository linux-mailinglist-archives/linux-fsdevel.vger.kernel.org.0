Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379254B7F82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 05:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbiBPEeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 23:34:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiBPEeQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:34:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDADB7C6E;
        Tue, 15 Feb 2022 20:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VTnUeYEN/ux3yU4giIFFK259vlfxLfwy7+DV+rNURNo=; b=AtozEhme1vnLMD/TWoB8IIDEFL
        R6tadFetshclOhJLIVIpFqRhbxTDXTJ7BTLSDyENrf3HD4HTn3QmRnwcG/GLW315O4+X16t92795G
        1OG6FnVToqynAjjvbbL0s2Vd8FjQ1SoK5ytLW1gqJHR4a2yOkHWiLo0g2amMEcjQ8zFlexF8qy1Zc
        1Wsu1Fg8sk/TE9Qj3FVSmcCEDwcyx6AISbAblirEKVuEiCAE20Ea2SlUXMkPrNlY8bnxmQ/aT9U9c
        lDbPwsVz2aXuu6UfBEQINHQFCcgXgFcEu68UHFLIRDHlSdpV/iMzBZjNJNWi8p25ZzYT38Imx3vLm
        FWHf4KFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKC0b-00EQi5-HP; Wed, 16 Feb 2022 04:33:41 +0000
Date:   Wed, 16 Feb 2022 04:33:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        david@fromorbit.com, amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: Report in unix_stream_read_generic()
Message-ID: <Ygx+pRo1+b1RBLJg@casper.infradead.org>
References: <1644984767-26886-1-git-send-email-byungchul.park@lge.com>
 <1644985024-28757-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644985024-28757-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 16, 2022 at 01:17:03PM +0900, Byungchul Park wrote:
> [    7.013330] ===================================================
> [    7.013331] DEPT: Circular dependency has been detected.
> [    7.013332] 5.17.0-rc1-00014-gcf3441bb2012 #2 Tainted: G        W        
> [    7.013333] ---------------------------------------------------
> [    7.013334] summary
> [    7.013334] ---------------------------------------------------
> [    7.013335] *** DEADLOCK ***
> [    7.013335] 
> [    7.013335] context A
> [    7.013336]     [S] (unknown)(&(&ei->socket.wq.wait)->dmap:0)
> [    7.013337]     [W] __mutex_lock_common(&u->iolock:0)
> [    7.013338]     [E] event(&(&ei->socket.wq.wait)->dmap:0)
> [    7.013340] 
> [    7.013340] context B
> [    7.013341]     [S] __raw_spin_lock(&u->lock:0)
> [    7.013342]     [W] wait(&(&ei->socket.wq.wait)->dmap:0)
> [    7.013343]     [E] spin_unlock(&u->lock:0)

This seems unlikely to be real.  We're surely not actually waiting
while holding a spinlock; existing debug checks would catch it.

> [    7.013407] ---------------------------------------------------
> [    7.013407] context B's detail
> [    7.013408] ---------------------------------------------------
> [    7.013408] context B
> [    7.013409]     [S] __raw_spin_lock(&u->lock:0)
> [    7.013410]     [W] wait(&(&ei->socket.wq.wait)->dmap:0)
> [    7.013411]     [E] spin_unlock(&u->lock:0)
> [    7.013412] 
> [    7.013412] [S] __raw_spin_lock(&u->lock:0):
> [    7.013413] [<ffffffff81aa451f>] unix_stream_read_generic+0x6bf/0xb60
> [    7.013416] stacktrace:
> [    7.013416]       _raw_spin_lock+0x6e/0x90
> [    7.013418]       unix_stream_read_generic+0x6bf/0xb60

It would be helpful if you'd run this through scripts/decode_stacktrace.sh
so we could see line numbers instead of hex offsets (which arene't much
use without the binary kernel).

> [    7.013420]       unix_stream_recvmsg+0x40/0x50
> [    7.013422]       sock_read_iter+0x85/0xd0
> [    7.013424]       new_sync_read+0x162/0x180
> [    7.013426]       vfs_read+0xf3/0x190
> [    7.013428]       ksys_read+0xa6/0xc0
> [    7.013429]       do_syscall_64+0x3a/0x90
> [    7.013431]       entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    7.013433] 
> [    7.013434] [W] wait(&(&ei->socket.wq.wait)->dmap:0):
> [    7.013434] [<ffffffff810bb017>] prepare_to_wait+0x47/0xd0

... this may be the source of confusion.  Just because we prepare to
wait doesn't mean we end up actually waiting.  For example, look at
unix_wait_for_peer():

        prepare_to_wait_exclusive(&u->peer_wait, &wait, TASK_INTERRUPTIBLE);

        sched = !sock_flag(other, SOCK_DEAD) &&
                !(other->sk_shutdown & RCV_SHUTDOWN) &&
                unix_recvq_full(other);

        unix_state_unlock(other);

        if (sched)
                timeo = schedule_timeout(timeo);

        finish_wait(&u->peer_wait, &wait);

We *prepare* to wait, *then* drop the lock, then actually schedule.

