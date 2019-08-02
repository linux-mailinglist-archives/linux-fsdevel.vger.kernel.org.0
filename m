Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A71A7FB22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393288AbfHBNhR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 09:37:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:59048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388919AbfHBNhR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:37:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA545AFA4;
        Fri,  2 Aug 2019 13:37:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 186BF1E433B; Fri,  2 Aug 2019 15:37:15 +0200 (CEST)
Date:   Fri, 2 Aug 2019 15:37:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.com>,
        Theodore Tso <tytso@mit.edu>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>, linux-ext4@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2 6/7] fs/jbd2: Make state lock a spinlock
Message-ID: <20190802133714.GN25064@quack2.suse.cz>
References: <20190801010126.245731659@linutronix.de>
 <20190801010944.457499601@linutronix.de>
 <20190801175703.GH25064@quack2.suse.cz>
 <alpine.DEB.2.21.1908012010020.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908012010020.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-08-19 20:12:11, Thomas Gleixner wrote:
> On Thu, 1 Aug 2019, Jan Kara wrote:
> > On Thu 01-08-19 03:01:32, Thomas Gleixner wrote:
> > > As almost all functions which use this lock have a journal head pointer
> > > readily available, it makes more sense to remove the lock helper inlines
> > > and write out spin_*lock() at all call sites.
> > > 
> > 
> > Just a heads up that I didn't miss this patch. Just it has some bugs and I
> > figured that rather than explaining to you subtleties of jh lifetime it is
> > easier to fix up the problems myself since you're probably not keen on
> > becoming jbd2 developer ;)... which was more complex than I thought so I'm
> > not completely done yet. Hopefuly tomorrow.
> 
> I'm curious where I was too naive :)

Well, the most obvious where places where the result ended up being like

	jbd2_journal_put_journal_head(jh);
	spin_unlock(&jh->state_lock);

That's possible use-after-free.

But there were also other more subtle places where
jbd2_journal_put_journal_head() was not directly visible as it was hidden
inside journal list handling functions such as __jbd2_journal_refile_buffer()
or so. And these needed some more work.

Anyway, I'm now done fixing up the patch, doing some xfstests runs to verify
things didn't break in any obvious way...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
