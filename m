Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264984096C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244125AbhIMPJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 11:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346512AbhIMPJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:09:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3D3C05BD39;
        Mon, 13 Sep 2021 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2o21f40djM5aANch+hnWzvwqswYsNlXu0JdbF+Uae8M=; b=mWd0MfFrYPorMZMCayG9Lpi5bE
        rLijC/+hxixhFynqqbncqSv+QEA9/PlikAsaBRJ8mQO98jTSBPQms5OVQpg2r+5hXWC1TA4C0YCuD
        C3s5oO6mRfl6yAfjOJVy+5pKQmUsvDvQ+7q/DrRyPEpG1ouTZ2xZ3dBDP1oTzcR+BD46BffJLZspd
        J8iHJ0PJVJL6GqE+BsKKB6uW4xgVOsRWdzCpB01AuEkTZJKTBhSupoIt9e7jhsBkgc17jAoOPAkrq
        ckJpxG6xVkNbtcLr643bS48LpVGZqB4G6JOrYZpZbDr/SiWYYcFcAq2kxbpMVigDWQn+EWgCwxsxV
        +e3UiqbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPmES-00DXOQ-6Z; Mon, 13 Sep 2021 13:43:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F13369862C3; Mon, 13 Sep 2021 15:42:45 +0200 (CEST)
Date:   Mon, 13 Sep 2021 15:42:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     CGEL <cgel.zte@gmail.com>
Cc:     yzaikin@google.com, liu.hailong6@zte.com.cn, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, mcgrof@kernel.org,
        keescook@chromium.org, pjt@google.com, yang.yang29@zte.com.cn,
        joshdon@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zeal Robot <zealci@zte.com.cm>
Subject: Re: [PATCH] sched: Add a new version sysctl to control child runs
 first
Message-ID: <20210913134245.GD4323@worktop.programming.kicks-ass.net>
References: <20210912041222.59480-1-yang.yang29@zte.com.cn>
 <YT8IQioxUARMus9w@hirez.programming.kicks-ass.net>
 <613f37fc.1c69fb81.9092.a4f5@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <613f37fc.1c69fb81.9092.a4f5@mx.google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:37:31AM +0000, CGEL wrote:
> On Mon, Sep 13, 2021 at 10:13:54AM +0200, Peter Zijlstra wrote:
> > On Sun, Sep 12, 2021 at 04:12:23AM +0000, cgel.zte@gmail.com wrote:
> > > From: Yang Yang <yang.yang29@zte.com.cn>
> > > 
> > > The old version sysctl has some problems. First, it allows set value
> > > bigger than 1, which is unnecessary. Second, it didn't follow the
> > > rule of capabilities. Thirdly, it didn't use static key. This new
> > > version fixes all the problems.
> > 
> > Does any of that actually matter?
> 
> For the first problem, I think the reason why sysctl_schedstats() only
> accepts 0 or 1, is suitbale for sysctl_child_runs_first(). Since
> task_fork_fair() only need sysctl_sched_child_runs_first to be
> zero or non-zero.

This could potentially break people that already write a larger value in
it -- by accident or otherwise.

> For the second problem, I remember there is a rule: try to
> administration system through capilities but not depends on
> root identity. Just like sysctl_schedstats() or other
> sysctl_xx().

It seems entirely daft to me; those files are already 644, if root opens
the file and passes it along, it gets to keep the pieces.

> For the thirdly problem, sysctl_child_runs_first maynot changes
> often, but may accessed often, like static_key delayacct_key
> controlled by sysctl_delayacct().

Can you actually show it makes a performance difference in a fork
micro-bench? Given the amount of gunk fork() already does, I don't think
it'll matter one way or the other, and in that case, simpler is better.
