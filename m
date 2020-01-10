Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED792136E4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 14:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgAJNkY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 08:40:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40236 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgAJNkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eg00gB5MIhosfgx54pb6m/6BTbun0f1ISZugspfmb0Y=; b=FmFQpjHOHVqGjrXsr25KBEkQY
        ZZWqukYHz+36aJ9r8c/zVY5l+S6Pj+cjcgn2j+tFg5tSMoVNvAyuCHX7YfU282PakvlTT7G+gpLuv
        A865RDnXjV+NasjD38XTI4f8jhAr4uNVZYhTgy6/zf+JTpCcXgUzk5hOjVv5L0lNyUu3WEwu5eJPC
        CcBU6coeZW+1sHmoXcQ0NS7wMSys7IG0Ho+my/nmbDXUve77AUaKNITc/WunW4LZ6JkAh0J8Evjl5
        Hc82u4te9BuKQLb7Rj/DcrXp4C7RgtwnzfgeeqK9JP6oRh1gDY1RIevO4aikYeE312Oon1thbOHu8
        jyvV8Gefw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipuW6-0003f2-M1; Fri, 10 Jan 2020 13:39:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0AE123043C9;
        Fri, 10 Jan 2020 14:38:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C32142B612615; Fri, 10 Jan 2020 14:39:56 +0100 (CET)
Date:   Fri, 10 Jan 2020 14:39:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        valentin.schneider@arm.com, qperret@google.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Message-ID: <20200110133956.GL2844@hirez.programming.kicks-ass.net>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200108134448.GG2844@hirez.programming.kicks-ass.net>
 <20200109130052.feebuwuuvwvm324w@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109130052.feebuwuuvwvm324w@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 09, 2020 at 01:00:58PM +0000, Qais Yousef wrote:
> On 01/08/20 14:44, Peter Zijlstra wrote:
> > On Fri, Dec 20, 2019 at 04:48:38PM +0000, Qais Yousef wrote:
> > > RT tasks by default try to run at the highest capacity/performance
> > > level. When uclamp is selected this default behavior is retained by
> > > enforcing the uclamp_util_min of the RT tasks to be
> > > uclamp_none(UCLAMP_MAX), which is SCHED_CAPACITY_SCALE; the maximum
> > > value.
> > > 
> > > See commit 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks").
> > > 
> > > On battery powered devices, this default behavior could consume more
> > > power, and it is desired to be able to tune it down. While uclamp allows
> > > tuning this by changing the uclamp_util_min of the individual tasks, but
> > > this is cumbersome and error prone.
> > > 
> > > To control the default behavior globally by system admins and device
> > > integrators, introduce the new sysctl_sched_rt_uclamp_util_min to
> > > change the default uclamp_util_min value of the RT tasks.
> > > 
> > > Whenever the new default changes, it'd be applied on the next wakeup of
> > > the RT task, assuming that it still uses the system default value and
> > > not a user applied one.
> > 
> > This is because these RT tasks are not in a cgroup or not affected by
> > cgroup settings? I feel the justification is a little thin here.
> 
> The uclamp_min for RT tasks is always hardcoded to 1024 at the moment. So even
> if they belong to a cgroup->uclamp_min = 0, they'll still run at max frequency,
> no?

Argh, this is that counter intuitive max aggregate nonsense biting me.

