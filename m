Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B00799FA7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 22:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjIJUTb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 16:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjIJUTX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 16:19:23 -0400
Received: from out-216.mta0.migadu.com (out-216.mta0.migadu.com [91.218.175.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F1136
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 13:19:18 -0700 (PDT)
Date:   Sun, 10 Sep 2023 16:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694377156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jVBQqFWrLjOALr1mhigpuNsiQIccFsNmxNNJpRqMr7w=;
        b=OMptgYHhfdgVFP/Lha/YOMc90szy2oH+ZYvF3ptjiCuZquyFsyBCVXYvmM/oDZZmXH+pe/
        IIZ0A//AMyht7hPsy+v+HghsCXaJ704+faeSdps0m0ckTc9OHETZVVBxmF+pNY19p0ARNM
        QPga1rvCKR7woXwNyhgmHzZrpXDs1r4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <20230910201911.sppmyepeu5lmaqj3@moria.home.lan>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
 <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
 <ZPyS4J55gV8DBn8x@casper.infradead.org>
 <a21038464ad0afd5dfb88355e1c244152db9b8da.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a21038464ad0afd5dfb88355e1c244152db9b8da.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 10, 2023 at 03:51:42PM -0400, James Bottomley wrote:
> OK, so now we've strayed into the causes of maintainer burnout.  Syzbot
> is undoubtedly a stressor, but one way of coping with a stressor is to
> put it into perspective: Syzbot is really a latter day coverity and
> everyone was much happier when developers ignored coverity reports and
> they went into a dedicated pile that was looked over by a team of
> people trying to sort the serious issues from the wrong but not
> exploitable ones.  I'd also have to say that anyone who allows older
> filesystems into customer facing infrastructure is really signing up
> themselves for the risk they're running, so I'd personally be happy if
> older fs teams simply ignored all the syzbot reports.

The problem with syzbot, and fuzzing in general is that reports come out
at random which makes it impossible to pick a think and work on it, i.e.
focus on the task at hand.

To be able to work productively, it's critical that we be able to find
out if our code is broken /when we're still working on it/, which means
getting quick testing feedback. Failing that, if we have to go back and
fix up old code, we really want to be able to look at a file/module/some
reasonably sized chunk, load it up into our brains, fix up what's wrong,
and move onto the next thing.

Syzbot is the absolute worst for developer productivity.

I've been talking about code coverage analysis as a partial replacement
for fuzz testing because you can look at the report for a file, figure
out what tests are missing, and do the work all at once. We'll never
catch all the bugs fuzz testing will find that way, but anything that
reduces our reliance on it would be a good thing.

The real long term solution is, of course, to start rewriting stuff in
Rust.

> > Burnout amongst fs maintainers is a real problem.  I have no idea how
> > to solve it.
> 
> I already suggested we should share coping strategies:
> 
> https://lore.kernel.org/ksummit/ab9cfd857e32635f626a906410ad95877a22f0db.camel@HansenPartnership.com/
> 
> The sources of stress aren't really going to decrease, but how people
> react to them could change.  Syzbot (and bugs in general) are a case in
> point.  We used not to treat seriously untriaged bug reports, but now
> lots of people feel they can't ignore any fuzzer report.  We've tipped
> to far into "everything's a crisis" mode and we really need to come
> back and think that not every bug is actually exploitable or even
> important.

Yeah, burnout is a symptom of too many impossible to meet priorities;
the solution is to figure out what our priorities actually are.

As the codebases I've written have grown, my own mentality has
shifted... when I was younger, every bug was something that had to be
fixed. Now I have to think more in terms of "how much time am I spending
fixing bugs, which bugs am I fixing, and how do I balance that against
my long term priorities".

in particular, the stuff that shows up in a dashboard may be the
/easiest/ to work on - it's in a nice todo list! - but if I spent all my
time on that I wouldn't get to the bugs and issues users are reporting.

Of course, if users are reporting too many bugs that means test coverage
is missing or the automated tests aren't being looked at enough, so it's
a real balancing act.

The other big change in my thinking has been going from trying to fix
every bug when I first see it (and at times going through real heroics
to do so) - to now trying to focus more on making debugging easy; if I
can't figure out a bug right away I'll often add more assertions/debug
output and wait for it to pop next time. That kind of thing has a real
long term impact; the thing I strive for is a codebase where when
something goes wrong it tells you /everything/ about what went wrong.
