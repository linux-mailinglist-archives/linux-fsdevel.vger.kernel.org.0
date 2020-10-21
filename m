Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11D4294BFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 13:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442061AbgJULtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 07:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439630AbgJULti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:49:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ED6C0613CE;
        Wed, 21 Oct 2020 04:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8JwSKiY59c2E1giG6DTwV0+SKJg4VCdk89g9m35u9xI=; b=pdojZfDTpn2BJz574aeDNpai+O
        tanBOR2mW3feD8BRvzHrzS4XGk3PhjGD1ihatzx1OpQxr1UXBId6IXz/40Lr9RXE0sO8E7H/f3+hh
        3Lo/ALO+SYneEXGl0XM+p1wZTXOQnIZ+xu51uwL0KdRYormXu14eybCvbw0llEB79JwMKd4Zs3HqR
        3mxh1tibj4ph7g9HPD/5LqL0PqFx5EYZ3gsM8OhLvaXZZQVkD1CgW+O/ojN+wuU9GfqBNuKZ8oJ5G
        72qztb2maWDzt4lfY4Cuhu38mxw9S+mTU6Am4Ibbq0ldDlmFzUKP8xjH2ktW4yucYLBfssMRacOqT
        qB2Jmj3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVCbZ-0002yH-UC; Wed, 21 Oct 2020 11:48:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BAE7B304BAE;
        Wed, 21 Oct 2020 13:48:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5CD3214528C1; Wed, 21 Oct 2020 13:48:31 +0200 (CEST)
Date:   Wed, 21 Oct 2020 13:48:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Redha <redha.gouicem@gmail.com>
Cc:     julien.sopena@lip6.fr, julia.lawall@inria.fr,
        gilles.muller@inria.fr, carverdamien@gmail.com,
        jean-pierre.lozi@oracle.com, baptiste.lepers@sydney.edu.au,
        nicolas.palix@univ-grenoble-alpes.fr,
        willy.zwaenepoel@sydney.edu.au,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Ignatov <rdna@fb.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] sched: delayed thread migration
Message-ID: <20201021114831.GE2628@hirez.programming.kicks-ass.net>
References: <20201020154445.119701-1-redha.gouicem@gmail.com>
 <20201021072612.GV2628@hirez.programming.kicks-ass.net>
 <ad9b8a29-7f14-d8bf-0c6d-5aeb8c6c7912@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad9b8a29-7f14-d8bf-0c6d-5aeb8c6c7912@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 21, 2020 at 12:40:44PM +0200, Redha wrote:

> >> The main idea behind this patch series is to bring to light the frequency
> >> inversion problem that will become more and more prominent with new CPUs
> >> that feature per-core DVFS. The solution proposed is a first idea for
> >> solving this problem that still needs to be tested across more CPUs and
> >> with more applications.
> > Which is why schedutil (the only cpufreq gov anybody should be using) is
> > integrated with the scheduler and closes the loop and tells the CPU
> > about the expected load.
> >
> While I agree that schedutil is probably a good option, I'm not sure we
> treat exactly the same problem. schedutil aims at mapping the frequency of
> the CPU to the actual load. What I'm saying is that since it takes some
> time for the frequency to match the load, why not account for the frequency
> when making placement/migration decisions.

Because overhead, mostly :/ EAS does some of that. Mostly wakeup CPU
selection is already a bottle-neck for some applications (see the fight
over select_idle_sibling()).

Programming a timer is out of budget for high rate wakeup workloads.
Worse, you also don't prime the CPU to ramp up during the enforced
delay.

Also, two new config knobs :-(

> I know that with the frequency invariance code, capacity accounts for
> frequency, which means that thread placement decisions do account for
> frequency indirectly. However, we still have performance improvements
> with our patch for the workloads with fork/wait patterns. I really
> believe that we can still gain performance if we make decisions while
> accounting for the frequency more directly.

So I don't think that's fundamentally a DVFS problem though, just
something that's exacerbated by it. There's a long history with trying
to detect this pattern, see for example WF_SYNC and wake_affine().

(we even had some code in the early CFS days that measured overlap
between tasks, to account for the period between waking up the recipient
and blocking on the answer, but that never worked reliably either, so
that went the way of the dodo)

The classical micro-benchmark is pipe-bench, which ping-pongs a single
byte between two tasks over a pipe. If you run that on a single CPU it
is _much_ faster then when the tasks get split up. DVFS is just like
caches here, yet another reason.

schedutil does solve the problem where, when we migrate a task, the CPU
would have to individually re-learn the DVFS state. By using the
scheduler statistics we can program the DVFS state up-front, on
migration. Instead of waiting for it.

So from that PoV, schedutil fundamentally solves the individual DVFS
problem as best is possible. It closes the control loop; we no longer
have individually operating control loops that are unaware of one
another.
