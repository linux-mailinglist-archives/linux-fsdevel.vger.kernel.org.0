Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349284216BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 20:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbhJDSoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 14:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbhJDSoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:44:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D28C061745;
        Mon,  4 Oct 2021 11:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M3MCGNtC32L47sTZ2qKzzynee6LhYMUb7wH0lcWQ2k0=; b=sy9wcq9CiqHPkeKE/Dc0z3FezB
        ZkphCwajzy21jd0HUQToVpYWTOPqnlrL50YgzfjSowWx18/ni/uKbEyeN91/WHf1Gqz0iAykFL23A
        zqP8JvtYKxZCVIBrxIpnxIF/yoMPfHFd1Un5LqkkoNN3cwapmI+u3UMZgTTgay/m5DtDo4v7T48xv
        99Xc8VfRmnQ923fmeqISaQqmYthJkMf63qiBfgW3sygpkcmV3M4TEWTUmU7Fj0yCQRGgbD8WlvFFk
        8fWUq6SKHJ1FBKXkniVVzcRh+lcp/ODJ9eXIm/ohW5nPpfilUbkBn65tcRiuJ6enlL7n8zadN+Tq9
        6ftcVgwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXSu8-00HCrh-Q9; Mon, 04 Oct 2021 18:41:51 +0000
Date:   Mon, 4 Oct 2021 19:41:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 0/1] proc: Allow pid_revalidate() during LOOKUP_RCU
Message-ID: <YVtK4E/KBMR82hKd@casper.infradead.org>
References: <20211004175629.292270-1-stephen.s.brennan@oracle.com>
 <YVtF3lm/JjhlnF09@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVtF3lm/JjhlnF09@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:20:14PM +0100, Matthew Wilcox wrote:
> On Mon, Oct 04, 2021 at 10:56:28AM -0700, Stephen Brennan wrote:
> > Problem Description:
> > 
> > When running running ~128 parallel instances of "TZ=/etc/localtime ps
> > -fe >/dev/null" on a 128CPU machine, the %sys utilization reaches 97%,
> > and perf shows the following code path as being responsible for heavy
> > contention on the d_lockref spinlock:
> > 
> >       walk_component()
> >         lookup_fast()
> >           d_revalidate()
> >             pid_revalidate() // returns -ECHILD
> >           unlazy_child()
> >             lockref_get_not_dead(&nd->path.dentry->d_lockref) <-- contention
> > 
> > The reason is that pid_revalidate() is triggering a drop from RCU to ref
> > path walk mode. All concurrent path lookups thus try to grab a reference
> > to the dentry for /proc/, before re-executing pid_revalidate() and then
> > stepping into the /proc/$pid directory. Thus there is huge spinlock
> > contention. This patch allows pid_revalidate() to execute in RCU mode,
> > meaning that the path lookup can successfully enter the /proc/$pid
> > directory while still in RCU mode. Later on, the path lookup may still
> > drop into ref mode, but the contention will be much reduced at this
> > point.
> > 
> > By applying this patch, %sys utilization falls to around 85% under the
> > same workload, and the number of ps processes executed per unit time
> > increases by 3x-4x. Although this particular workload is a bit
> > contrived, we have seen some large collections of eager monitoring
> > scripts which produced similarly high %sys time due to contention in the
> > /proc directory.
> 
> I think it's perhaps also worth noting that this is a performance
> regression relative to ... v5.4?  v4.14?  I forget the details; do you
> have those to hand, Stephen?
> 
> (Yes, this is a stupid workload.  Yes, a customer really does have
> this workload.)

OK, it's not a performance regression.  My apologies; I misremembered
the ticket.  What happens with 4.14 is that the tasks all sleep on
the directory's i_mutex.  When i_mutex became i_rwsem, all the lookups
would now contend on the dentry spinlock.  That turns "lots of processes
sleeping" into "lots of processes spinning", which looks like a regression
if you're asking "Why has my system time increased a lot?"
