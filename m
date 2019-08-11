Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB2E88EFA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 03:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfHKBW3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Aug 2019 21:22:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfHKBW3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Aug 2019 21:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x9UEbmW8LJ0lIKjMLHktJ3/c30NE8tEZXrlgaJFgkVE=; b=AaoGjcrC0WoqO1MfO2CSTnPGI
        xpj5lAq2Y9Wl0X5d3XzIXj3RgldrNnIh4XMTJiD/QAm3PVyJZ54O6o7Atg95xOKR/0I0M6yHNVKDm
        QPphw1ZfIX/DEd0Wua3oKgObE8pkvmnCc4JzacvdJH31NfDgA8slYqhUV+VBVweS4WwG2olbBZg/y
        oSgCW4Zwm5pWwrkAqnxUJ6OzyeHs1Es78Bofj4n8UOQYPGyA44gskjjjq7g5TspMpIVABjMg3gcDI
        1f1enarGTp5f/nRmn8ovSkuYCzxjfQYN360kMEJ0FEJtgsk96eqIti+H2WX1IIFfVEyZO0nGsqGaf
        PJz9fm00g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hwcYv-0004on-1g; Sun, 11 Aug 2019 01:22:21 +0000
Date:   Sat, 10 Aug 2019 18:22:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [patch V2 0/7] fs: Substitute bit-spinlocks for PREEMPT_RT and
 debugging
Message-ID: <20190811012220.GB7491@bombadil.infradead.org>
References: <20190801010126.245731659@linutronix.de>
 <20190802075612.GA20962@infradead.org>
 <alpine.DEB.2.21.1908021107090.2285@nanos.tec.linutronix.de>
 <20190806061119.GA17492@infradead.org>
 <alpine.DEB.2.21.1908080858460.2882@nanos.tec.linutronix.de>
 <20190808072807.GA25259@infradead.org>
 <alpine.DEB.2.21.1908080953170.2882@nanos.tec.linutronix.de>
 <20190810081834.GB30426@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810081834.GB30426@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 10, 2019 at 01:18:34AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 08, 2019 at 09:54:03AM +0200, Thomas Gleixner wrote:
> > > I know.  But the problem here is that normally PG_locked is used together 
> > > with wait_on_page_bit_*, but this one instances uses the bit spinlock
> > > helpers.  This is the equivalent of calling spin_lock on a struct mutex
> > > rather than having a mutex_lock_spin helper for this case.
> > 
> > Yes, I know :(
> 
> But this means we should exclude slub from the bit_spin_lock removal.
> It really should use it's own version of it anyhow insted of pretending
> that the page lock is a bit spinlock.

But PG_locked isn't used as a mutex _when the page is allocated by slab_.
Yes, every other user uses PG_locked as a mutex, but I don't see why that
should constrain slub's usage of PG_locked.

