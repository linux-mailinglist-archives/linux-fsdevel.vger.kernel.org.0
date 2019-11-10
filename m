Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1217F6BA1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2019 22:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfKJVbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Nov 2019 16:31:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfKJVbj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:31:39 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [65.158.186.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6BB92077C;
        Sun, 10 Nov 2019 21:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573421498;
        bh=Q68vMzI6w6dZmtgy63CNXyLK03/E3+1LL6PTxO1oyPY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DooNjrT6nGFATrUQyrrZzUbjXlXoR2dAsPi0CDtCcMv9hmAh4xZvseurxrv/sdliE
         b/hBhAPUIhVRJNNBqIlebSxG/szTkXZ92+k09V5Ook1/DEf+t5W3vYH4Aod3+MDGSP
         EIG9pVgjW8NJcMgpzmaGsYJzDjuXQR6vUgb7pq3g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A209535227E6; Sun, 10 Nov 2019 13:31:38 -0800 (PST)
Date:   Sun, 10 Nov 2019 13:31:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
Message-ID: <20191110213138.GH2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAHk-=wjB61GNmqpX0BLA5tpL4tsjWV7akaTc2Roth7uGgax+mw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911101034180.29192-100000@netrider.rowland.org>
 <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
 <CAHk-=wghq7rmtskFj7EbngpXUTJfc4H9sDcx10E6kMHoH2EsKA@mail.gmail.com>
 <20191110204442.GA2865@paulmck-ThinkPad-P72>
 <CAHk-=wjm40mcf7tk9DZQXd=dftZw_VpmE837c7pTZ1_cR+t4Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjm40mcf7tk9DZQXd=dftZw_VpmE837c7pTZ1_cR+t4Mw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 10, 2019 at 01:10:39PM -0800, Linus Torvalds wrote:
> On Sun, Nov 10, 2019 at 12:44 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > But will "one size fits all" be practical and useful?
> 
> Oh, I do agree that if KCSAN has some mode where it says "I'll ignore
> repeated writes with the same value" (or whatever), it could/should
> likely be behind some flag.
> 
> I don't think it should be a subsystem flag, though. More of a "I'm
> willing to actually analyze and ignore false positives" flag. Because
> I don't think it's so much about the code, as it is about the person
> who looks at the results.
> 
> For example, we're already getting push-back from people on some of
> the KCSAN-inspired patches. If we have people sending patches to add
> READ_ONCE/WRITE_ONCE to random places to shut up KCSAN reports, I
> don't think that's good.
> 
> But if we have people who _work_ on memory ordering issues etc, and
> want to see a strict mode, knowing there are false positives and able
> to handle them, that's a completely different thing..
> 
> No?

Understood on the pushback!  And I especially agree that it is bad to
automatically add *_ONCE() just to shut up KCSAN.  For one thing, doing
that inconveniences people later on who might want to take a closer look.

As long as I can get the full-up reports for RCU.  And as long as the
others who want the full-up reports can also get them.  ;-)

And agreed, if the results are adjusted based on who is processing them,
that should be good.

							Thanx, Paul
