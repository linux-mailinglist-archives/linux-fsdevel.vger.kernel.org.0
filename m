Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4AD44AA74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 10:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244785AbhKIJWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 04:22:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38126 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbhKIJWm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 04:22:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AA69221B00;
        Tue,  9 Nov 2021 09:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636449595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VoQShqrcwMMqCYR87MExPor8l+jSneq67M2Mu0n4wrs=;
        b=brU2ckUAzDP9fY6EgbYi7+Z8zMVdlLDMoZeLW418r0Rdhxtdsb5rHDuAeCtLPyuvpn0gdu
        PZ8VU4wtHr3JCzG1w/1pBMDvC0zZwApT0yVg/NCzIms3zyYyAM44zzQCY7FooAClUkuJhx
        Zs04Dgo8H+MRYyAo32fpGragKOMGV6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636449595;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VoQShqrcwMMqCYR87MExPor8l+jSneq67M2Mu0n4wrs=;
        b=nA9UNAuEOKWz7kpODy4vpSFxr1zRLBEmxm7gjQjkFzPXkOVXgfAIKsZHX0gglsSOkKTI/4
        0vssiUI+Brc7NeDA==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0AF12A3B85;
        Tue,  9 Nov 2021 09:19:53 +0000 (UTC)
Date:   Tue, 9 Nov 2021 09:19:51 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     ?????? <ligang.bdlg@bytedance.com>
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
Subject: Re: Re: Re: [PATCH v1] sched/numa: add per-process numa_balancing
Message-ID: <20211109091951.GW3891@suse.de>
References: <20211027132633.86653-1-ligang.bdlg@bytedance.com>
 <20211028153028.GP3891@suse.de>
 <b884ad7d-48d3-fcc8-d199-9e7643552a9a@bytedance.com>
 <20211029083751.GR3891@suse.de>
 <CAMx52ARF1fVH9=YLQMjE=8ckKJ=q3X2-ovtKuQcoTyo564mQnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAMx52ARF1fVH9=YLQMjE=8ckKJ=q3X2-ovtKuQcoTyo564mQnQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 04:28:28PM +0800, ?????? wrote:
> Hi, sorry for the late reply.
> 
> On Fri, Oct 29, 2021 at 4:37 PM Mel Gorman <mgorman@suse.de> wrote:
> >
> > My point is that as it stands,
> > prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,1) either does nothing or
> > fails. If per-process numa balancing is to be introduced, it should have
> > meaning with the global tuning affecting default behaviour and the prctl
> > affecting specific behaviour.
> >
> 
> If the global tuning affects default behaviour and the prctl
> affects specific behaviour.  Then when prctl specifies
> numa_balancing for a process, there is no way for the
> global tuning to affect that process.

Yes.

> In other words, global tuning
> become a default value, not a switch for global numa_balancing.
> 

Also yes. The global tuning becomes "all processes default to using NUMA
balancing unless overridden by prctl".

The main difficulty is that one task using prctl to enable NUMA balancing
needs to enable the static branch so there is a small global hit.

> My idea is that the global numa_balancning still has absolute control, and prctl
> can only optionally turn off numa_balancing for process when the global is on.
> After all, It is more common to enable global numa_balancing and disable it in
> several processes than to disable global numa_balancing and enable it in
> several processes.

Then this comment would still apply

 My point is that as it stands,
 prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,1) either does nothing
 or fails.

While I think it's very likely that the common case will be to disable
NUMA balancing for specific processes,
prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,1) should still be
meaningful.

-- 
Mel Gorman
SUSE Labs
