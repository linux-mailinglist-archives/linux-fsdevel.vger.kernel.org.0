Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 638E8134B5F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 20:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgAHTQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 14:16:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38638 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgAHTQQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:16:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so85112wmc.3;
        Wed, 08 Jan 2020 11:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=36jJmMym6/gPFXjbjo3iUPDmu6L1c+Uay/qLqZ4J7aI=;
        b=VqvjqT88YP/n0P0cWitEb1wYeu/CvOIF/x0ijYIZ3lP+nCbD1Jt2L06g1TpmCxqu63
         TTm9TZyy0RckESXGxxtDcax6S5Is373nZ+V1tnLZE5SXkraDrN0BfUhdMF1wgSaudzgc
         DJ9gqT7jYwo7JnYISeloO1Mau/Q5nibySjOUH+txLTKiqn034I9TDxdRmimaJhnF68qx
         K0K7SplYQoDh1rCLNmSFyfPsg0Ebn0AuJTTnHCTSt03kiirTgTCfQAYUIp1eD8NJm6X9
         2SyMDT4hd1b7AjTEqCwe8OqvOTgrGYfZZUMy0+Do/ZGG+hJ/RseyfvRmP++fMlP2lmaZ
         zJWA==
X-Gm-Message-State: APjAAAXCy/UMCRdWANheiMRoDiI/WCatBdNnTaAl8hVIT46gmtwk5dVm
        k0rHDW4ZVFlhFoVxfVAxvho=
X-Google-Smtp-Source: APXvYqwmLbKd65cVkoq7X93kB6uk6sHQvjfaqHg81VOZcOBcr63wxm8Do7eYnkrZ+uCCVrMRSIaUHQ==
X-Received: by 2002:a05:600c:21da:: with SMTP id x26mr177182wmj.4.1578510973649;
        Wed, 08 Jan 2020 11:16:13 -0800 (PST)
Received: from darkstar ([2a04:ee41:4:500b:c62:197d:80dc:1629])
        by smtp.gmail.com with ESMTPSA id g21sm5577384wrb.48.2020.01.08.11.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 11:16:12 -0800 (PST)
Date:   Wed, 8 Jan 2020 20:16:00 +0100
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Quentin Perret <qperret@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        valentin.schneider@arm.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Message-ID: <20200108191600.GC9635@darkstar>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200107134234.GA158998@google.com>
 <8bb17e84-d43f-615f-d04d-c36bb6ede5e0@arm.com>
 <20200108095108.GA153171@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108095108.GA153171@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08-Jan 09:51, Quentin Perret wrote:
> On Tuesday 07 Jan 2020 at 20:30:36 (+0100), Dietmar Eggemann wrote:
> > On 07/01/2020 14:42, Quentin Perret wrote:
> > > Hi Qais,
> > > 
> > > On Friday 20 Dec 2019 at 16:48:38 (+0000), Qais Yousef wrote:
> > 
> > [...]
> > 
> > >> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > >> index e591d40fd645..19572dfc175b 100644
> > >> --- a/kernel/sched/rt.c
> > >> +++ b/kernel/sched/rt.c
> > >> @@ -2147,6 +2147,12 @@ static void pull_rt_task(struct rq *this_rq)
> > >>   */
> > >>  static void task_woken_rt(struct rq *rq, struct task_struct *p)
> > >>  {
> > >> +	/*
> > >> +	 * When sysctl_sched_rt_uclamp_util_min value is changed by the user,
> > >> +	 * we apply any new value on the next wakeup, which is here.
> > >> +	 */
> > >> +	uclamp_rt_sync_default_util_min(p);
> > > 
> > > The task has already been enqueued and sugov has been called by then I
> > > think, so this is a bit late. You could do that in uclamp_rq_inc() maybe?

No, the above sync should neven be done.

For CFS tasks is currenly working by computing the effective clamp
from core.c::enqueue_task() before calling into the scheduling class
callback.

We should use a similar approach for RT tasks thus avoiding rt.c
specific code and ensuring correct effective values are _aggregated_
out of task's _requests_ and system-wide's _constraints_ before
calling sugov.

> > That's probably better.
> > Just to be sure ...we want this feature (an existing rt task gets its
> > UCLAMP_MIN value set when the sysctl changes)

No, that's not a feature. That's an hack I would avoid.

> > because there could be rt tasks running before the sysctl is set?
> 
> Yeah, I was wondering the same thing, but I'd expect sysadmin to want
> this. We could change the min clamp of existing RT tasks in userspace
> instead, but given how simple Qais' lazy update code is, the in-kernel
> looks reasonable to me. No strong opinion, though.
> 
> Thanks,
> Quentin

-- 
#include <best/regards.h>

Patrick Bellasi
