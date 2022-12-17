Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB2E64F6E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 02:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLQB7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 20:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiLQB7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 20:59:39 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F806C76F;
        Fri, 16 Dec 2022 17:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a/I0Z/ZlO9e9LGuO8VIziVIPtAnVdRWKVjtg7u7czyA=; b=Dvpv7Zp3q3V+1b3yW0+sXDN5MA
        m40zL6ch7/mIhRbIkrwasbdtPP+ni/AW3DLaZ3yxd/MVu0iec9vYz3jv1O3SwROjiQnwL08Mm4NbG
        ImTfjlnZBKQkXo0Vw9WCHYvOVIpI2YN27wiNCgOwW5YYv0dO4L7pI8wA1qN8gXDM0AMgg0oSmb/A1
        Ua/kv9V7lq/YAUeFH7uVtvZISzKpAN2fSSmWmrfGZ5O5AeIAIJ9bupuKwQ/8gJgDhp/nmFii9xUGL
        HVUF92OUSsTocaEcY16mfOHdNIxM/9HwdkYVAXvHMLzG7AS6+MIyrwersK+Wh5cQAcMABIrLbaqX6
        axwyZz1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p6MU8-00CMF4-2G;
        Sat, 17 Dec 2022 01:59:32 +0000
Date:   Sat, 17 Dec 2022 01:59:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Wei Chen <harperchen1110@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible deadlock in __ata_sff_interrupt
Message-ID: <Y50ihHKFbderCqH1@ZenIV>
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com>
 <Y5s7F/4WKe8BtftB@ZenIV>
 <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com>
 <Y5vo00v2F4zVKeug@ZenIV>
 <CAHk-=wgOFV=QmwWQW0QxDNkeDt4t5dOty7AvGyWRyj-O=8db9A@mail.gmail.com>
 <Y50BqT3nSF7+JEzt@ZenIV>
 <Y50FIckzrV9sWlid@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y50FIckzrV9sWlid@boqun-archlinux>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 03:54:09PM -0800, Boqun Feng wrote:
> On Fri, Dec 16, 2022 at 11:39:21PM +0000, Al Viro wrote:
> > [Boqun Feng Cc'd]
> > 
> > On Fri, Dec 16, 2022 at 03:26:21AM -0800, Linus Torvalds wrote:
> > > On Thu, Dec 15, 2022 at 7:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > CPU1: ptrace(2)
> > > >         ptrace_check_attach()
> > > >                 read_lock(&tasklist_lock);
> > > >
> > > > CPU2: setpgid(2)
> > > >         write_lock_irq(&tasklist_lock);
> > > >         spins
> > > >
> > > > CPU1: takes an interrupt that would call kill_fasync().  grep and the
> > > > first instance of kill_fasync() is in hpet_interrupt() - it's not
> > > > something exotic.  IRQs disabled on CPU2 won't stop it.
> > > >         kill_fasync(..., SIGIO, ...)
> > > >                 kill_fasync_rcu()
> > > >                         read_lock_irqsave(&fa->fa_lock, flags);
> > > >                         send_sigio()
> > > >                                 read_lock_irqsave(&fown->lock, flags);
> > > >                                 read_lock(&tasklist_lock);
> > > >
> > > > ... and CPU1 spins as well.
> > > 
> > > Nope. See kernel/locking/qrwlock.c:
> > 
> > [snip rwlocks are inherently unfair, queued ones are somewhat milder, but
> > all implementations have writers-starving behaviour for read_lock() at least
> > when in_interrupt()]
> > 
> > D'oh...  Consider requested "Al, you are a moron" duly delivered...  I plead
> > having been on way too low caffeine and too little sleep ;-/
> > 
> > Looking at the original report, looks like the scenario there is meant to be
> > the following:
> > 
> > CPU1: read_lock(&tasklist_lock)
> > 	tasklist_lock grabbed
> > 
> > CPU2: get an sg write(2) feeding request to libata; host->lock is taken,
> > 	request is immediately completed and scsi_done() is about to be called.
> > 	host->lock grabbed
> > 
> > CPU3: write_lock_irq(&tasklist_lock)
> > 	spins on tasklist_lock until CPU1 gets through.
> > 
> > CPU2: get around to kill_fasync() called by sg_rq_end_io() and to grabbing
> > 	tasklist_lock inside send_sigio()
> > 	spins, since it's not in an interrupt and there's a pending writer
> > 	host->lock is held, spin until CPU3 gets through.
> 
> Right, for a reader not in_interrupt(), it may be blocked by a random
> waiting writer because of the fairness, even the lock is currently held
> by a reader:
> 
> 	CPU 1			CPU 2		CPU 3
> 	read_lock(&tasklist_lock); // get the lock
> 
> 						write_lock_irq(&tasklist_lock); // wait for the lock
> 
> 				read_lock(&tasklist_lock); // cannot get the lock because of the fairness

IOW, any caller of scsi_done() from non-interrupt context while
holding a spinlock that is also taken in an interrupt...

And we have drivers/scsi/scsi_error.c:scsi_send_eh_cmnd(), which calls
->queuecommand() under a mutex, with
#define DEF_SCSI_QCMD(func_name) \
        int func_name(struct Scsi_Host *shost, struct scsi_cmnd *cmd)   \
        {                                                               \
                unsigned long irq_flags;                                \
                int rc;                                                 \
                spin_lock_irqsave(shost->host_lock, irq_flags);         \
                rc = func_name##_lck(cmd);                              \
                spin_unlock_irqrestore(shost->host_lock, irq_flags);    \
                return rc;                                              \
        }

being commonly used for ->queuecommand() instances.  So any scsi_done()
in foo_lck() (quite a few of such) + use of ->host_lock in interrupt
for the same driver (also common)...

I wonder why that hadn't triggered the same warning a long time
ago - these warnings had been around for at least two years.

Am I missing something here?
