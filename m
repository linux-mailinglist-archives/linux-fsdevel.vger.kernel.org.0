Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE885B35
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 09:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfHHHDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 03:03:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52377 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHHHDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:03:31 -0400
Received: from p200300ddd71876597e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7659:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hvcRp-0001ck-0m; Thu, 08 Aug 2019 09:02:53 +0200
Date:   Thu, 8 Aug 2019 09:02:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [patch V2 0/7] fs: Substitute bit-spinlocks for PREEMPT_RT and
 debugging
In-Reply-To: <20190806061119.GA17492@infradead.org>
Message-ID: <alpine.DEB.2.21.1908080858460.2882@nanos.tec.linutronix.de>
References: <20190801010126.245731659@linutronix.de> <20190802075612.GA20962@infradead.org> <alpine.DEB.2.21.1908021107090.2285@nanos.tec.linutronix.de> <20190806061119.GA17492@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 5 Aug 2019, Christoph Hellwig wrote:
> On Fri, Aug 02, 2019 at 11:07:53AM +0200, Thomas Gleixner wrote:
> > Last time I did, there was resistance :)
> 
> Do you have a pointer?  Note that in the buffer head case maybe
> a hash lock based on the page address is even better, as we only
> ever use the lock in the first buffer head of a page anyway..

I need to search my archives, but I'm on a spotty and slow connection right
now. Will do so when back home.
 
> > What about the page lock?
> > 
> >   mm/slub.c:      bit_spin_lock(PG_locked, &page->flags);
> 
> One caller ouf of a gazillion that spins on the page lock instead of
> sleepign on it like everyone else.  That should not have passed your
> smell test to start with :)

I surely stared at it, but that cannot sleep. It's in the middle of a
preempt and interrupt disabled region and used on architectures which do
not support CMPXCHG_DOUBLE and ALIGNED_STRUCT_PAGE ...

Thanks,

	tglx



