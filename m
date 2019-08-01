Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0787E1F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 20:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbfHASJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 14:09:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37517 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731642AbfHASJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:09:15 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1htFVE-0006iz-PV; Thu, 01 Aug 2019 20:08:36 +0200
Date:   Thu, 1 Aug 2019 20:08:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jan Kara <jack@suse.cz>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [patch V2 7/7] fs/jbd2: Free journal head outside of locked
 region
In-Reply-To: <20190801092223.GG25064@quack2.suse.cz>
Message-ID: <alpine.DEB.2.21.1908012007270.1789@nanos.tec.linutronix.de>
References: <20190801010126.245731659@linutronix.de> <20190801010944.549462805@linutronix.de> <20190801092223.GG25064@quack2.suse.cz>
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

On Thu, 1 Aug 2019, Jan Kara wrote:
> On Thu 01-08-19 03:01:33, Thomas Gleixner wrote:
> > On PREEMPT_RT bit-spinlocks have the same semantics as on PREEMPT_RT=n,
> > i.e. they disable preemption. That means functions which are not safe to be
> > called in preempt disabled context on RT trigger a might_sleep() assert.
> Looks mostly good. Just a small suggestion for simplification below:
> 
> > @@ -2559,11 +2568,14 @@ void jbd2_journal_put_journal_head(struc
> >  	J_ASSERT_JH(jh, jh->b_jcount > 0);
> >  	--jh->b_jcount;
> >  	if (!jh->b_jcount) {
> > -		__journal_remove_journal_head(bh);
> > +		size_t b_size = __journal_remove_journal_head(bh);
> > +
> >  		jbd_unlock_bh_journal_head(bh);
> > +		journal_release_journal_head(jh, b_size);
> >  		__brelse(bh);
> 
> The bh is pinned until you call __brelse(bh) above and bh->b_size doesn't
> change during the lifetime of the buffer. So there's no need of
> fetching bh->b_size in __journal_remove_journal_head() and passing it back.
> You can just:
> 
> 		journal_release_journal_head(jh, bh->b_size);

Ah. Nice. I assumed that this would be possible, but then my ignorance
induced paranoia won.

Thanks,

	tglx
