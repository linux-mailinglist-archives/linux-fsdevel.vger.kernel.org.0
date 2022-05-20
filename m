Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AB152F54B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 23:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353671AbiETVpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 17:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352695AbiETVpj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 17:45:39 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB7D185CBA;
        Fri, 20 May 2022 14:45:37 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24KLjCF7022100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 17:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1653083116; bh=Kena1s74NfZpE/ieHVoWi+W9Tj+cPireegTJMkTYQ9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=K/MlzjrH88/7BkC/Pt1fYXFhfFSaNv5AOfMMqBDmZulnsCbvSIu6afJzH18Dg3TFL
         TPmv6srejeH0g5cbsCqb8RZmScwyeYzw0JVoKL6khT0y2cT1eYk3xiVM3XdQQlQjnh
         /AhfdW4LJv7dC2bstYXB1OxiMNdD3Woc2wauGpfYhR4uOkYzdlbsX2NDapwRePK/jw
         WtV9a80O7fuBLDD4zOw9mZ8CfqZ8YyrKhsvyYvvcnFUV2yfyWjqfZsFM9wnTWwG9cF
         C/4f0wISNRYBkXD6WFzUHT+F9k0VNT9z8E/uxG985iDW3oMz9rgAcmnBief4IDKylz
         nKv1dY/zFuzFg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 84DFA15C3EC0; Fri, 20 May 2022 17:45:12 -0400 (EDT)
Date:   Fri, 20 May 2022 17:45:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+9c3fb12e9128b6e1d7eb@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] INFO: task hung in jbd2_journal_commit_transaction (3)
Message-ID: <YogL6MCdYVrqGcRf@mit.edu>
References: <00000000000032992d05d370f75f@google.com>
 <20211219023540.1638-1-hdanton@sina.com>
 <Yb6zKVoxuD3lQMA/@casper.infradead.org>
 <20211221090804.1810-1-hdanton@sina.com>
 <20211222022527.1880-1-hdanton@sina.com>
 <YcKrHc11B/2tcfRS@mit.edu>
 <CACT4Y+YHxkL5aAgd4wXPe-J+RG6_VBcPs=e8QpRM8=3KJe+GCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YHxkL5aAgd4wXPe-J+RG6_VBcPs=e8QpRM8=3KJe+GCg@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 01:57:07PM +0200, Dmitry Vyukov wrote:
> 
> Hi Ted,
> 
> Reviving this old thread re syzkaller using SCHED_FIFO.
> 
> It's a bit hard to restrict what the fuzzer can do if we give it
> sched_setattr() and friends syscalls. We could remove them from the
> fuzzer entirely, but it's probably suboptimal as well.
> 
> I see that setting up SCHED_FIFO is guarded by CAP_SYS_NICE:
> https://elixir.bootlin.com/linux/v5.18-rc7/source/kernel/sched/core.c#L7264
> 
> And I see we drop CAP_SYS_NICE from the fuzzer process since 2019
> (after a similar discussion):
> https://github.com/google/syzkaller/commit/f3ad68446455a
>
> The latest C reproducer contains: ....

For this particular report, there *was* no C reproducer.  There was
only a syz reproducer:

> syzbot found the following issue on:
> 
> HEAD commit:    5472f14a3742 Merge tag 'for_linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11132113b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3bdfd29b408d1b6
> dashboard link: https://syzkaller.appspot.com/bug?extid=9c3fb12e9128b6e1d7eb
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14559113b00000

So let me ask a counter question.  I thought syzbot tries to create a
minimal reproducer?  So if the sched_setattr is a no-op, and is
returning EPERM, why wasn't the sched_setattr line removed from the
syz repro?

As a side note, since in many cases running a reproducer can be
painful, would it be possible for the syzkiller dashboard to provide
the output of running "strace -f" while the reproducer is running?

That would also especially help since even when there is a C
reproducer, trying to understand what it is doing from reading the
syzbot-generated C source code is often non-trivial, and strace does a
much better job decoding what the !@#?@ the reproducer.  Another
advantage of using strace is that it will also show us the return code
from the system call, which would very quickly confirm whether the
sched_setattr() was actually returning EPERM or not --- and it will
decode the system call arguments in a way that I often wished would be
included as comments in the syzbot-generated reproducer.

Providing the strace output could significantly reduce the amount of
upstream developer toil, and might therefore improve upstream
developer engagement with syzkaller.

Cheers,

						- Ted
