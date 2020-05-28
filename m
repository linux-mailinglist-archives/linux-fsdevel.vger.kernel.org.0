Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597331E6727
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 18:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404871AbgE1QLo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 12:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404835AbgE1QLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 12:11:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81410C08C5C6;
        Thu, 28 May 2020 09:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kRC/+FIcZ4k+ifItO6DbNpd5GQju/3x9FnPOlNayotE=; b=rA1d677t4JDNdFjAL5EEHPVJsg
        hn5MRkG1J7uKsvREMqJFTsCb/CzK6XjIwNqsbaYPNrkYsOu5pBnGO0QX9LJltIwsxqiLgmsjsv0Tr
        ia/8QB9JZetagdeoKXkdD9mDZbVnDa8vIX4K+aKQC4P7AyZ+Y1KLpQkUM9uO4orKy3iJEXpcaBdEX
        Kkqpu+VsqykVCfeu+3AHuWXfnnqy6xP6UQmlAp8TwZ3JRR8gYSIUfvF3q6mRlODZ0vxGXbJf3VFio
        uX/souRgHWy8f8d39bliP/1vuGhX5SPZ1YeEuUxedNA5TSwzKT++veANQQhzsdW8N1pDzwDDnaOMu
        yu/arHUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeL7n-0004er-Qq; Thu, 28 May 2020 16:11:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 142119836F8; Thu, 28 May 2020 18:11:12 +0200 (CEST)
Date:   Thu, 28 May 2020 18:11:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200528161112.GI2483@worktop.programming.kicks-ass.net>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 04:58:01PM +0100, Qais Yousef wrote:
> On 05/28/20 15:23, Peter Zijlstra wrote:

> > So afaict this is directly added to the enqueue/dequeue path, and we've
> > recently already had complaints that uclamp is too slow.
> 
> I wanted to keep this function simpler.

Right; I appreciate that, but as always it's a balance between simple
and performance :-)

> > Is there really no other way?
> 
> There is my first attempt which performs the sync @ task_woken_rt().
> 
> https://lore.kernel.org/lkml/20191220164838.31619-1-qais.yousef@arm.com/
> 
> I can revert the sync function to the simpler version defined in that patch
> too.
> 
> I can potentially move this to uclamp_eff_value() too. Will need to think more
> if this is enough. If task_woken_rt() is good for you, I'd say that's more
> obviously correct and better to go with it.

task_woken_rt() is better, because that only slows down RT tasks, but
I'm thinking we can do even better by simply setting the default such
that new tasks pick it up and then (rcu) iterating all existing tasks
and modiying them.

It's more code, but it is all outside of the normal paths where we care
about performance.

> FWIW, I think you're referring to Mel's notice in OSPM regarding the overhead.
> Trying to see what goes on in there.

Indeed, that one. The fact that regular distros cannot enable this
feature due to performance overhead is unfortunate. It means there is a
lot less potential for this stuff.
