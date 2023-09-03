Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6C3790DD0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Sep 2023 21:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347548AbjICTwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Sep 2023 15:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjICTwG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Sep 2023 15:52:06 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED45DA;
        Sun,  3 Sep 2023 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cdr4HXuSMa83ABTNQFcZwygHOnIYSjdKWOIwzIIE72k=; b=QoTuarTLun6Tt/Q/rEVxW8DQ/9
        bZmv6Csabt0fb7bC2xfCVlHmi2JXrHYbNeCCARVF2JYX8vg3qDfaDXXWV9PJwJXXWAlWVqyiFGgt1
        wqLHXamPyobvlRiXLbKTIvKOepgYnCkfjWUu3LOFBQQ5NFo+2sPeehhLmgI8I3Sv78Y0QQi9PX88+
        6NuL2hrwxIZ1isEPxDCYDEMpJKLtCCPEqG74X3b+nzZEugJdkw7Wz6Fm5Tem4p9ap7HRA1udgjEfU
        GlUlRZZ6W3/8knSLW9MIr+Dh9JNhqTQd84Nuc5WcTpZaKS++t6tPwVe+Ln7Oc6ZeN9IlXfu9D4FYC
        +HffB82g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qct8V-0038Xe-0I;
        Sun, 03 Sep 2023 19:51:55 +0000
Date:   Sun, 3 Sep 2023 20:51:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Aleksandr Nogikh <nogikh@google.com>,
        Dave Chinner <david@fromorbit.com>,
        syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
Message-ID: <20230903195155.GM3390869@ZenIV>
References: <000000000000e6432a06046c96a5@google.com>
 <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f>
 <20230903180126.GL3390869@ZenIV>
 <CAGudoHHjnRct1jEAjNSHmmPt9u_y+tYhrb56uRKXez8DKydNaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHjnRct1jEAjNSHmmPt9u_y+tYhrb56uRKXez8DKydNaQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 03, 2023 at 08:57:23PM +0200, Mateusz Guzik wrote:

> This does not dump backtraces, just a list of tasks + some stats.
> 
> The closest to useful here I found are 'w' ("Dumps tasks that are in
> uninterruptable (blocked) state.") and 'l' ("Shows a stack backtrace
> for all active CPUs."), both of which can miss the task which matters
> (e.g., stuck in a very much *interruptible* state with f_pos_lock
> held).
> 
> Unless someone can point at a way to get all these stacks, I'm going
> to hack something up in the upcoming week, if only for immediate
> syzbot usage.

Huh?  Sample of output here:
2023-09-03T15:34:36.271833-04:00 duke kernel: [87367.574459] task:ssh-agent       state:S stack:0     pid:3949  ppid:3947   flags:0x
00000002
2023-09-03T15:34:36.284796-04:00 duke kernel: [87367.582848] Call Trace:
2023-09-03T15:34:36.284797-04:00 duke kernel: [87367.585306]  <TASK>
2023-09-03T15:34:36.284797-04:00 duke kernel: [87367.587423]  __schedule+0x222/0x630
2023-09-03T15:34:36.291459-04:00 duke kernel: [87367.590932]  schedule+0x4b/0x90
2023-09-03T15:34:36.291460-04:00 duke kernel: [87367.594086]  schedule_hrtimeout_range_clock+0xb1/0x110
2023-09-03T15:34:36.300477-04:00 duke kernel: [87367.599245]  ? __hrtimer_init+0xf0/0xf0
2023-09-03T15:34:36.300477-04:00 duke kernel: [87367.603103]  do_sys_poll+0x489/0x580
2023-09-03T15:34:36.308971-04:00 duke kernel: [87367.606702]  ? _raw_spin_unlock_irqrestore+0x9/0x20
2023-09-03T15:34:36.308972-04:00 duke kernel: [87367.611598]  ? __alloc_pages+0x111/0x1a0
2023-09-03T15:34:36.317380-04:00 duke kernel: [87367.615544]  ? select_task_rq_fair+0x1c8/0xf70
2023-09-03T15:34:36.317381-04:00 duke kernel: [87367.620006]  ? _raw_spin_unlock+0x5/0x10
2023-09-03T15:34:36.325273-04:00 duke kernel: [87367.623953]  ? sched_clock_cpu+0x1c/0xd0
2023-09-03T15:34:36.325274-04:00 duke kernel: [87367.627899]  ? default_send_IPI_single_phys+0x21/0x30
2023-09-03T15:34:36.334812-04:00 duke kernel: [87367.632977]  ? ttwu_queue_wakelist+0x109/0x110
2023-09-03T15:34:36.334813-04:00 duke kernel: [87367.637439]  ? _raw_spin_unlock_irqrestore+0x9/0x20
2023-09-03T15:34:36.343753-04:00 duke kernel: [87367.642344]  ? try_to_wake_up+0x1eb/0x300
2023-09-03T15:34:36.343754-04:00 duke kernel: [87367.646380]  ? __pollwait+0x110/0x110
2023-09-03T15:34:36.351376-04:00 duke kernel: [87367.650063]  ? _raw_spin_unlock+0x5/0x10
2023-09-03T15:34:36.351377-04:00 duke kernel: [87367.654001]  ? unix_stream_read_generic+0x528/0xa90
2023-09-03T15:34:36.361179-04:00 duke kernel: [87367.658906]  ? _raw_spin_unlock_irqrestore+0x9/0x20
2023-09-03T15:34:36.361180-04:00 duke kernel: [87367.663805]  ? _raw_spin_unlock_irqrestore+0x9/0x20
2023-09-03T15:34:36.370988-04:00 duke kernel: [87367.668708]  ? __inode_wait_for_writeback+0x68/0xc0
2023-09-03T15:34:36.370989-04:00 duke kernel: [87367.673614]  ? fsnotify_grab_connector+0x49/0x90
2023-09-03T15:34:36.380274-04:00 duke kernel: [87367.678258]  ? fsnotify_destroy_marks+0x11/0x140
2023-09-03T15:34:36.380275-04:00 duke kernel: [87367.682901]  ? enqueue_task_fair+0x211/0x5f0
2023-09-03T15:34:36.389726-04:00 duke kernel: [87367.687196]  ? __rseq_handle_notify_resume+0x2b4/0x3a0
2023-09-03T15:34:36.389728-04:00 duke kernel: [87367.692353]  ? recalibrate_cpu_khz+0x10/0x10
2023-09-03T15:34:36.397884-04:00 duke kernel: [87367.696651]  ? ktime_get_ts64+0x47/0xe0
2023-09-03T15:34:36.397885-04:00 duke kernel: [87367.700509]  __x64_sys_poll+0x93/0x120
2023-09-03T15:34:36.405254-04:00 duke kernel: [87367.704282]  do_syscall_64+0x42/0x90
2023-09-03T15:34:36.405255-04:00 duke kernel: [87367.707880]  entry_SYSCALL_64_after_hwframe+0x4b/0xb5
2023-09-03T15:34:36.413922-04:00 duke kernel: [87367.712959] RIP: 0033:0x7f451858f000
2023-09-03T15:34:36.413923-04:00 duke kernel: [87367.716548] RSP: 002b:00007ffd799cece8 EFLAGS: 00000202 ORIG_RAX: 0000000000000007
2023-09-03T15:34:36.428692-04:00 duke kernel: [87367.724154] RAX: ffffffffffffffda RBX: 00000000000001b0 RCX: 00007f451858f000
2023-09-03T15:34:36.428692-04:00 duke kernel: [87367.731317] RDX: 0000000000002710 RSI: 0000000000000001 RDI: 00005596fc603190
2023-09-03T15:34:36.443022-04:00 duke kernel: [87367.738485] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
2023-09-03T15:34:36.443023-04:00 duke kernel: [87367.745649] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
2023-09-03T15:34:36.457354-04:00 duke kernel: [87367.752818] R13: 0000000000000001 R14: 000000000000000a R15: 00005596fc603190
2023-09-03T15:34:36.457355-04:00 duke kernel: [87367.759981]  </TASK>

Looks like a stack trace to me; seeing one of the callers of fdget_pos()
in that would tell you who's currently holding *some* ->f_pos_lock.

That - on 6.1.42, with fairly bland .config (minimal debugging;
I need that box for fast builds, among other things).  Enable
lockdep and you'll get who's holding which logs in addition
to those stack traces...
