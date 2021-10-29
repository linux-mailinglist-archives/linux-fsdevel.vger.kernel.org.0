Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E062643F909
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 10:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhJ2Ik1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 04:40:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44990 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhJ2Ik0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:40:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8DF1621979;
        Fri, 29 Oct 2021 08:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635496677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qZJtw3MieBAJxz2bywPNILccd9LrIRNQXFA0JlaFMeY=;
        b=t6GZqZ2ZrA/zWvBOmb2gYMX4wpzmCFE/5vROmmF10stABpPd4Vix4z1Av+pYE9LvhJqnJg
        XSGg1+c6+utFRvFbwllDCEwAkiejlzTQqeHcgSDCiefdpUUc91ZU6EbZCCgVxeEnvEfmLU
        +8yKiddofh2oiONcJ5SAK3Vch4rgK/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635496677;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qZJtw3MieBAJxz2bywPNILccd9LrIRNQXFA0JlaFMeY=;
        b=6v5ygUCQdTegipKV02UYgWAHs+kPuWGntkmtDP/e3QhMktilEhvPCS/5fzjCEcqJGMyixs
        Y/gQKRaBvasxCQAA==
Received: from suse.de (mgorman.udp.ovpn2.nue.suse.de [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CED32A3B83;
        Fri, 29 Oct 2021 08:37:55 +0000 (UTC)
Date:   Fri, 29 Oct 2021 09:37:51 +0100
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
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: Re: [PATCH v1] sched/numa: add per-process numa_balancing
Message-ID: <20211029083751.GR3891@suse.de>
References: <20211027132633.86653-1-ligang.bdlg@bytedance.com>
 <20211028153028.GP3891@suse.de>
 <b884ad7d-48d3-fcc8-d199-9e7643552a9a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <b884ad7d-48d3-fcc8-d199-9e7643552a9a@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 02:12:28PM +0800, Gang Li wrote:
> On 10/28/21 11:30 PM, Mel Gorman wrote:
> > 
> > That aside though, the configuration space could be better. It's possible
> > to selectively disable NUMA balance but not selectively enable because
> > prctl is disabled if global NUMA balancing is disabled. That could be
> > somewhat achieved by having a default value for mm->numa_balancing based on
> > whether the global numa balancing is disabled via command line or sysctl
> > and enabling the static branch if prctl is used with an informational
> > message. This is not the only potential solution but as it stands,
> > there are odd semantic corner cases. For example, explicit enabling
> > of NUMA balancing by prctl gets silently revoked if numa balancing is
> > disabled via sysctl and prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING,
> > 1) means nothing.
> > 
> static void task_tick_fair(struct rq *rq, struct task_struct *curr, int
> queued)
> {
> 	...
> 	if (static_branch_unlikely(&sched_numa_balancing))
> 		task_tick_numa(rq, curr);
> 	...
> }
> 
> static void task_tick_numa(struct rq *rq, struct task_struct *curr)
> {
> 	...
> 	if (!READ_ONCE(curr->mm->numa_balancing))
> 		return;
> 	...
> }
> 
> When global numa_balancing is disabled, mm->numa_balancing is useless.

I'm aware that this is the behaviour of the patch as-is.

> So I
> think prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING,0/1) should return
> error instead of modify mm->numa_balancing.
> 
> Is it reasonable that prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,0/1)
> can still change the value of mm->numa_balancing when global numa_balancing
> is disabled?
> 

My point is that as it stands,
prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,1) either does nothing or
fails. If per-process numa balancing is to be introduced, it should have
meaning with the global tuning affecting default behaviour and the prctl
affecting specific behaviour.

-- 
Mel Gorman
SUSE Labs
