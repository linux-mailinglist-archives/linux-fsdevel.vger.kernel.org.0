Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 012FE14526F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 11:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAVKUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 05:20:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44749 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAVKUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:20:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so6594293wrm.11;
        Wed, 22 Jan 2020 02:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W9vz51s1vrbvzc6TfStsYZ6xEAoe9Pb+qp5mfQDyZwk=;
        b=ELjREihzvRPfaE31UW+qTE1m3fCfK4Jz6g3A5Gw3CaGFwymjLe6WXD9/x+vQAQmg/U
         o3LPTYebYzS0woP7NuSzytwgtehryzBFmM1uwMugjzXiUxI6sLH9zrN5PjzMuIENQd/s
         04j+sQsR0bDVOk+E/yD3t3EHCUnXArx1Hk8Gzg2Y0mUuC+t4Tzl8e/EUAaUawt0Ea4BG
         oFgoy5EIYlUHvNzKIialai54Qyp0pNpJPBCb+x18yKGOhwC2/VMu243hxEE17OBtNl2X
         VtqFWCkCBnH9toCJIcVTqbG/aH1l1rYALgdbpX0qnV4v//gt8Ko4xLcy9mobuGMFk1Bs
         86IA==
X-Gm-Message-State: APjAAAV18y54kiJby0rOPAEK5kku0/l5w0fOgpC5dlcvxmzZ0lcG6XYI
        Scx+LqubnjUTrObjMQ9InGM=
X-Google-Smtp-Source: APXvYqyApF20bX7mcRfLENn1zB2Q9DdjmGTw4PCC65kaL9HiVp/JdaYlhCUVTUmOGw3S3qUThPpCxA==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr10241949wrq.348.1579688406118;
        Wed, 22 Jan 2020 02:20:06 -0800 (PST)
Received: from darkstar ([2a00:79e1:abc:308:3084:a9fa:af54:d880])
        by smtp.gmail.com with ESMTPSA id o4sm56503828wrw.97.2020.01.22.02.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 02:20:04 -0800 (PST)
Date:   Wed, 22 Jan 2020 11:19:44 +0100
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        qperret@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Message-ID: <20200122101944.GA12533@darkstar>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200108185650.GA9635@darkstar>
 <026e46e4-5d09-6260-0fa7-e365b0795c9a@arm.com>
 <20200109092137.GA2811@darkstar>
 <20200114213403.cur6gydan6kmplqb@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114213403.cur6gydan6kmplqb@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14-Jan 21:34, Qais Yousef wrote:
> On 01/09/20 10:21, Patrick Bellasi wrote:
> > That's not entirely true. In that patch we introduce cgroup support
> > but, if you look at the code before that patch, for CFS tasks there is
> > only:
> >  - CFS task-specific values (min,max)=(0,1024) by default
> >  - CFS system-wide tunables (min,max)=(1024,1024) by default
> > and a change on the system-wide tunable allows for example to enforce
> > a uclamp_max=200 on all tasks.
> > 
> > A similar solution can be implemented for RT tasks, where we have:
> >  - RT task-specific values (min,max)=(1024,1024) by default
> >  - RT system-wide tunables (min,max)=(1024,1024) by default
> >  and a change on the system-wide tunable allows for example to enforce
> >  a uclamp_min=200 on all tasks.
> 
> I feel I'm already getting lost in the complexity of the interaction here. Do
> we really need to go that path?
> 
> So we will end up with a default system wide for all tasks + a CFS system wide
> default + an RT system wide default?
> 
> As I understand it, we have a single system wide default now.

Right now we have one system wide default and that's both for all
CFS/RT tasks, when cgroups are not in use, or for root group and
autogroup CFS/RT tasks, when cgroups are in use.

What I'm proposing is to limit the usage of the current system wide
default to CFS tasks only, while we add a similar new one specifically
for RT tasks.

At the end we will have two system wide defaults, not three.

> > > (Would we need CONFIG_RT_GROUP_SCHED for this? IIRC there's a few pain points
> > > when turning it on, but I think we don't have to if we just want things like
> > > uclamp value propagation?)
> > 
> > No, the current design for CFS tasks works also on !CONFIG_CFS_GROUP_SCHED.
> > That's because in this case:
> >   - uclamp_tg_restrict() returns just the task requested value
> >   - uclamp_eff_get() _always_ restricts the requested value considering
> >     the system defaults
> >  
> > > It's quite more work than the simple thing Qais is introducing (and on both
> > > user and kernel side).
> > 
> > But if in the future we will want to extend CGroups support to RT then
> > we will feel the pains because we do the effective computation in two
> > different places.
> 
> Hmm what you're suggesting here is that we want to have
> cpu.rt.uclamp.{min,max}? I'm not sure I can agree this is a good idea.

That's exactly what we already do for other controllers. For example,
if you look at the bandwidth controller, we have separate knobs for
CFS and RT tasks.

> It makes more sense to create a special group for all rt tasks rather than
> treat rt tasks in a cgroup differently.

Don't see why that should make more sense. This can work of course but
it would enforce a more strict configuration and usage of cgroups to
userspace.

I also have some doubths about this approach matching the delegation
model principles.

> > Do note that a proper CGroup support requires that the system default
> > values defines the values for the root group and are consistently
> > propagated down the hierarchy. Thus we need to add a dedicated pair of
> > cgroup attributes, e.g. cpu.util.rt.{min.max}.
> > 
> > To recap, we don't need CGROUP support right now but just to add a new
> > default tracking similar to what we do for CFS.
> >
> > We already proposed such a support in one of the initial versions of
> > the uclamp series:
> >    Message-ID: <20190115101513.2822-10-patrick.bellasi@arm.com>
> >    https://lore.kernel.org/lkml/20190115101513.2822-10-patrick.bellasi@arm.com/
> 
> IIUC what you're suggesting is:
> 
> 	1. Use the sysctl to specify the default_rt_uclamp_min
> 	2. Enforce this value in uclamp_eff_get() rather than my sync logic
> 	3. Remove the current hack to always set
> 	   rt_task->uclamp_min = uclamp_none(UCLAMP_MAX)

Right, that's the essence...

> If I got it correctly I'd be happy to experiment with it if this is what
> you're suggesting. Otherwise I'm afraid I'm failing to see the crust of the
> problem you're trying to highlight.

... from what your write above I think you got it right.

In my previous posting:

   Message-ID: <20200109092137.GA2811@darkstar>
   https://lore.kernel.org/lkml/20200109092137.GA2811@darkstar/

there is also the code snippet which should be good enough to extend
uclamp_eff_get(). Apart from that, what remains is:
- to add the two new sysfs knobs for sysctl_sched_uclamp_util_{min,max}_rt
- make a call about how rt tasks in cgroups are clamped, a simple
  proposal is in the second snippet of my message above.

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
