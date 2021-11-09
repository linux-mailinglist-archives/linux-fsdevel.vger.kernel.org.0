Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20D744B121
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 17:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbhKIQ3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 11:29:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38580 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbhKIQ3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:29:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 22DFC21B0F;
        Tue,  9 Nov 2021 16:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636475214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8Yqvda4MK4hO1EoRB5r6GQpCOHroX0LfHlyY83Mevo=;
        b=n8ph54cGxVOKEPgM+5p+AqZuytCKD7lxxc15YQWS+b1GoVVNoE7JvM7hjMyftp49vlScBU
        f2/eNLWys935rjcfCs1KkeQk4OlCtKccHw7Gpz+zZAZKvlPMvPkKrYLmIrBn9bQnrkLEOa
        cPl2eGrYMSNatVZji2GFhQsf56KKYgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636475214;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8Yqvda4MK4hO1EoRB5r6GQpCOHroX0LfHlyY83Mevo=;
        b=qwFDV487ASDanqQnKIcVp/7as4MKVz9GWVpyA/v0PuOU7WIQy6b0ukq0Y9msnQ0/vN84P0
        lHzuydjgE/8IlqDQ==
Received: from suse.de (mgorman.tcp.ovpn2.nue.suse.de [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 818C3A3B88;
        Tue,  9 Nov 2021 16:26:52 +0000 (UTC)
Date:   Tue, 9 Nov 2021 16:26:47 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: Re: Re: Re: Re: [PATCH v1] sched/numa: add per-process
 numa_balancing
Message-ID: <20211109162647.GY3891@suse.de>
References: <20211027132633.86653-1-ligang.bdlg@bytedance.com>
 <20211028153028.GP3891@suse.de>
 <b884ad7d-48d3-fcc8-d199-9e7643552a9a@bytedance.com>
 <20211029083751.GR3891@suse.de>
 <CAMx52ARF1fVH9=YLQMjE=8ckKJ=q3X2-ovtKuQcoTyo564mQnQ@mail.gmail.com>
 <20211109091951.GW3891@suse.de>
 <7de25e1b-e548-b8b5-dda5-6a2e001f3c1a@bytedance.com>
 <20211109121222.GX3891@suse.de>
 <117d5b88-b62b-f50b-32ff-1a9fe35b9e2e@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <117d5b88-b62b-f50b-32ff-1a9fe35b9e2e@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:58:34PM +0800, Gang Li wrote:
> On 11/9/21 8:12 PM, Mel Gorman wrote:
> > 
> > That would be a policy decision on how existing tasks should be tuned
> > if NUMA balancing is enabled at runtime after being disabled at boot
> > (or some arbitrary time in the past). Introducing the prctl does mean
> > that there is a semantic change for the runtime enabling/disabling
> > of NUMA balancing because previously, enabling global balancing affects
> > existing tasks and with prctl, it affects only future tasks. It could
> > be handled in the sysctl to some exist
> > 
> > 0. Disable for all but prctl specifications
> > 1. Enable for all tasks unless disabled by prctl
> > 2. Ignore all existing tasks, enable for future tasks
> > 
> > While this is more legwork, it makes more sense as an interface than
> > prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,1) failing if global
> > NUMA balancing is disabled.
> > 
> 
> Why prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,1) must work while global
> numa_balancing is disabled? No offense, I think that is a bit redundant.

For symmetry and consistency of the tuning. Either there is per-process
control or there is not. Right now, there is only the ability to turn
off NUMA balancing via prctl if globally enabled. There is no option to
turn NUMA balancing on for a single task if globally disabled.

> And
> it's complicated to implement.
> 

That is true.

> It's hard for me to understand the whole vision of your idea. I'm very
> sorry. Can you explain your full thoughts more specifically?
> 

I'm not sure how I can be more clear.

> ----------------------------------------------------
> 
> Also in case of misunderstanding, let me re-explain my patch using circuit
> diagram.
> 

I understood what you are proposing. In your case, global disabling
is an absolute -- it's disabled regardless of prctl therefore
prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,1) has no meaning and it
either does nothing at all or fails so why does the option even exist?

> Why global numa_balancing has high priority? There are two reasons:
> 1. numa_balancing is useful to most processes, so there is no need to
> consider how to enable numa_balancing for a few processes while disabling it
> globally.
> 2. It is easy to implement. The more we think, the more complex the code
> becomes.

Of those two, I agree with the second one, it would be tricky to implement
but the first one is less clear. This is based on an assumption. If prctl
exists to enable/disable NUMA baalancing, it's possible that someone
else would want to control NUMA balancing on a cgroup basis instead of
globally which would run into the same type of concerns -- different
semantics depending on the global tunable.

-- 
Mel Gorman
SUSE Labs
