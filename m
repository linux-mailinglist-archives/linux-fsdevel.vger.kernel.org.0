Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5142644AD38
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 13:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbhKIMPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 07:15:16 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51854 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbhKIMPQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 07:15:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F17EB1FD58;
        Tue,  9 Nov 2021 12:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636459948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kR89D7ZrZQRdZQaPTOGekyWIy76pSZM8sfCYDY4AP7s=;
        b=dJBhGZiVxcndU7kGad1tFglxyaE9whOIVSc5X4oSrKlgOFFqOE8mGMBQgHzkOJH7wBcddz
        8iFfQsHvBwkYx887ZytRBcYa/G0UGd0IY/ZcVQZUek3CrOajxxJiz3pASZPUxg8ySK4oFq
        FLSm/ktLYjHn3RimRRc0aqOp5vvC4MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636459948;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kR89D7ZrZQRdZQaPTOGekyWIy76pSZM8sfCYDY4AP7s=;
        b=ZJxTwqsUWeGgSPBJlLfPpOlFsFFFGLeTRB7UpANTCWi3uFlO1xyMya1qJhleEoiN/9peS1
        ckc1oKaIjvOrv/Cg==
Received: from suse.de (mgorman.tcp.ovpn2.nue.suse.de [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 99194A3B87;
        Tue,  9 Nov 2021 12:12:27 +0000 (UTC)
Date:   Tue, 9 Nov 2021 12:12:22 +0000
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
Subject: Re: Re: Re: Re: [PATCH v1] sched/numa: add per-process numa_balancing
Message-ID: <20211109121222.GX3891@suse.de>
References: <20211027132633.86653-1-ligang.bdlg@bytedance.com>
 <20211028153028.GP3891@suse.de>
 <b884ad7d-48d3-fcc8-d199-9e7643552a9a@bytedance.com>
 <20211029083751.GR3891@suse.de>
 <CAMx52ARF1fVH9=YLQMjE=8ckKJ=q3X2-ovtKuQcoTyo564mQnQ@mail.gmail.com>
 <20211109091951.GW3891@suse.de>
 <7de25e1b-e548-b8b5-dda5-6a2e001f3c1a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <7de25e1b-e548-b8b5-dda5-6a2e001f3c1a@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 06:40:43PM +0800, Gang Li wrote:
> On 11/9/21 5:19 PM, Mel Gorman wrote:
> > On Tue, Nov 09, 2021 at 04:28:28PM +0800, Gang Li wrote:
> > > If the global tuning affects default behaviour and the prctl
> > > affects specific behaviour.  Then when prctl specifies
> > > numa_balancing for a process, there is no way for the
> > > global tuning to affect that process.
> > 
> > While I think it's very likely that the common case will be to disable
> > NUMA balancing for specific processes,
> > prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,1) should still be
> > meaningful.
> > 
> 
> I'm still a bit confused.
> 
> If we really want to enable/disable numa_balancing for all processes, but
> some of them override the global numa_balancing using prctl, what should we
> do?
> 
> Do we iterate through these processes to enable/disable them individually?
> 

That would be a policy decision on how existing tasks should be tuned
if NUMA balancing is enabled at runtime after being disabled at boot
(or some arbitrary time in the past). Introducing the prctl does mean
that there is a semantic change for the runtime enabling/disabling
of NUMA balancing because previously, enabling global balancing affects
existing tasks and with prctl, it affects only future tasks. It could
be handled in the sysctl to some exist

0. Disable for all but prctl specifications
1. Enable for all tasks unless disabled by prctl
2. Ignore all existing tasks, enable for future tasks

While this is more legwork, it makes more sense as an interface than
prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,1) failing if global
NUMA balancing is disabled.

-- 
Mel Gorman
SUSE Labs
