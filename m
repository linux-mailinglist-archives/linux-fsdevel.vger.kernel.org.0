Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D26764F539
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 00:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLPXjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 18:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLPXj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:39:29 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E1F102;
        Fri, 16 Dec 2022 15:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wT46KGKikDaSt9tnXBQ+uhqsdL1NaFa+FYB9ZlSrl2w=; b=SYk8DagKGfIM4fchklGtw6T5nc
        D5GZHk2//+t8yG/tMaR47GMjZ8+OFPg5f9RufoFcCm77sPVNPxiBE6NH+00fY0pvDa8pWYXkst5jC
        IYQGXgh6zYyyHtvyfVjiaFN+havemj89QJLBnggcoosyaK5urjzRc/MKcmhdMioZlHrhwL22x9qHd
        ONfUgXpFoOSVHKrtELLpzhCwa1xZ6oRixkfZY1r7UH7zZnomwifqtgwuNJT7xBpbpLjMKct8RE3ik
        pJHXExdc5YfmpLpe4yhc6KpzPEGMBvzlSWWHPR/tM8lmxKmgjxgviFqy5Pxf5jhY5XzbRL5iY4s+m
        Bx2XmFWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p6KIT-00CL0M-0N;
        Fri, 16 Dec 2022 23:39:21 +0000
Date:   Fri, 16 Dec 2022 23:39:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Wei Chen <harperchen1110@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: possible deadlock in __ata_sff_interrupt
Message-ID: <Y50BqT3nSF7+JEzt@ZenIV>
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com>
 <Y5s7F/4WKe8BtftB@ZenIV>
 <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com>
 <Y5vo00v2F4zVKeug@ZenIV>
 <CAHk-=wgOFV=QmwWQW0QxDNkeDt4t5dOty7AvGyWRyj-O=8db9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgOFV=QmwWQW0QxDNkeDt4t5dOty7AvGyWRyj-O=8db9A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Boqun Feng Cc'd]

On Fri, Dec 16, 2022 at 03:26:21AM -0800, Linus Torvalds wrote:
> On Thu, Dec 15, 2022 at 7:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > CPU1: ptrace(2)
> >         ptrace_check_attach()
> >                 read_lock(&tasklist_lock);
> >
> > CPU2: setpgid(2)
> >         write_lock_irq(&tasklist_lock);
> >         spins
> >
> > CPU1: takes an interrupt that would call kill_fasync().  grep and the
> > first instance of kill_fasync() is in hpet_interrupt() - it's not
> > something exotic.  IRQs disabled on CPU2 won't stop it.
> >         kill_fasync(..., SIGIO, ...)
> >                 kill_fasync_rcu()
> >                         read_lock_irqsave(&fa->fa_lock, flags);
> >                         send_sigio()
> >                                 read_lock_irqsave(&fown->lock, flags);
> >                                 read_lock(&tasklist_lock);
> >
> > ... and CPU1 spins as well.
> 
> Nope. See kernel/locking/qrwlock.c:

[snip rwlocks are inherently unfair, queued ones are somewhat milder, but
all implementations have writers-starving behaviour for read_lock() at least
when in_interrupt()]

D'oh...  Consider requested "Al, you are a moron" duly delivered...  I plead
having been on way too low caffeine and too little sleep ;-/

Looking at the original report, looks like the scenario there is meant to be
the following:

CPU1: read_lock(&tasklist_lock)
	tasklist_lock grabbed

CPU2: get an sg write(2) feeding request to libata; host->lock is taken,
	request is immediately completed and scsi_done() is about to be called.
	host->lock grabbed

CPU3: write_lock_irq(&tasklist_lock)
	spins on tasklist_lock until CPU1 gets through.

CPU2: get around to kill_fasync() called by sg_rq_end_io() and to grabbing
	tasklist_lock inside send_sigio()
	spins, since it's not in an interrupt and there's a pending writer
	host->lock is held, spin until CPU3 gets through.

CPU1: take an interrupt, which on libata will try to grab host->lock
	tasklist_lock is held, spins on host->lock until CPU2 gets through

Am I reading it correctly?
