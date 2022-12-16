Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A3164E66A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 04:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiLPDlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 22:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPDlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 22:41:17 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C454045A;
        Thu, 15 Dec 2022 19:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uFjXacM4V95MITfaVTbj36apFcWXHC9KNgQ5sG+WTEI=; b=G0kCpgSZN1EUotUaOgsFdEeJKi
        nvprcIE7kGY++o1ePwPpDikIET9h5IfUZv5fKlyM9T+MTa1WtL7BcWlQIPJ1qncj5D+3zA5RSHenM
        uuyFF3ICu5NIzeaP0IqVitYV1v16gVRNvoLEa0jQfnaD1i0TEBXhJgRZw8l1Ci4W394x7vfLSaZh+
        6/Krg8qkikKZ4XSbLyCPUHUEHNUNIbxFpj60CINFzQvZ9z22cE+LhEfajKhJruE+eTK0LWmHdw57d
        AKjOOLtlDJvasjaHWIMZUF9PavT5KPIWZU8a2Isujw/v7ohpSBnpKB9dreiKRAvkb6tt6IQnpuBrH
        j2FDVTNw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p61at-00CAKK-2V;
        Fri, 16 Dec 2022 03:41:07 +0000
Date:   Fri, 16 Dec 2022 03:41:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Wei Chen <harperchen1110@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: possible deadlock in __ata_sff_interrupt
Message-ID: <Y5vo00v2F4zVKeug@ZenIV>
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com>
 <Y5s7F/4WKe8BtftB@ZenIV>
 <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 10:44:06AM +0900, Damien Le Moal wrote:

> The original & complete lockdep splat is in the report email here:
> 
> https://marc.info/?l=linux-ide&m=167094379710177&w=2
> 
> It looks like a spinlock is taken for the fasync stuff without irq
> disabled and that same spinlock is needed in kill_fasync() which is
> itself called (potentially) with IRQ disabled. Hence the splat. In any
> case, that is how I understand the issue. But as mentioned above, given
> that I can see many drivers calling kill_fasync() with irq disabled, I
> wonder if this is a genuine potential problem or a false negative.

OK, I'm about to fall asleep, so I might very well be missing something
obvious, but...

CPU1: ptrace(2)
	ptrace_check_attach()
		read_lock(&tasklist_lock);

CPU2: setpgid(2)
        write_lock_irq(&tasklist_lock);
	spins

CPU1: takes an interrupt that would call kill_fasync().  grep and the
first instance of kill_fasync() is in hpet_interrupt() - it's not
something exotic.  IRQs disabled on CPU2 won't stop it.
	kill_fasync(..., SIGIO, ...)
		kill_fasync_rcu()
			read_lock_irqsave(&fa->fa_lock, flags);
			send_sigio()
			        read_lock_irqsave(&fown->lock, flags);
		                read_lock(&tasklist_lock);

... and CPU1 spins as well.

It's not a matter of kill_fasync() called with IRQs disabled; the
problem is kill_fasync() called from interrupt taken while holding
tasklist_lock at least shared.  Somebody trying to grab it on another
CPU exclusive before we get to send_sigio() from kill_fasync() will
end up spinning and will make us spin as well.

I really hope that's just me not seeing something obvious - we had
kill_fasync() called in IRQ handlers since way back and we had
tasklist_lock taken shared without disabling IRQs for just as long.

<goes to sleep, hoping to find "Al, you are a moron, it's obviously OK
for such and such reasons" in the mailbox tomorrow morning>
