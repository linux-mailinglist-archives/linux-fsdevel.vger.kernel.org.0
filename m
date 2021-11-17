Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996B34542A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 09:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbhKQIc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 03:32:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50668 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhKQIc5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:32:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4C23C218F6;
        Wed, 17 Nov 2021 08:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637137798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0pK3KJ3GdBoScQYF4lRP70cesfMJ5sZVeDywKrYlzGI=;
        b=xtQiMQUSEWSgjYM86BL5QZbpmMhGk4qS2LiSusLfS9WirtsT/IhplmYYNbV0dRpbL4bJc+
        GXYGDU0Y+1B3c+d0KLn09qzQkWnuVFw6XJIjLtkI43t4vk5ywsKRMRKx+RyoORH1XkYlC4
        kKgHSqaI3tqvhTQe8/zNqac2pupVVjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637137798;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0pK3KJ3GdBoScQYF4lRP70cesfMJ5sZVeDywKrYlzGI=;
        b=rwfEHGWn630X8LB/fsn0y4tbmvXUI2hf5j21l7EWw8SX1KCOP4kvUkDjow9ESpFMm0f5uD
        PO9WPYfec4UJ8FAA==
Received: from suse.de (mgorman.udp.ovpn2.nue.suse.de [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DA665A3B83;
        Wed, 17 Nov 2021 08:29:56 +0000 (UTC)
Date:   Wed, 17 Nov 2021 08:29:52 +0000
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
Subject: Re: Re: Re: Re: Re: Re: [PATCH v1] sched/numa: add per-process
 numa_balancing
Message-ID: <20211117082952.GA3301@suse.de>
References: <20211028153028.GP3891@suse.de>
 <b884ad7d-48d3-fcc8-d199-9e7643552a9a@bytedance.com>
 <20211029083751.GR3891@suse.de>
 <CAMx52ARF1fVH9=YLQMjE=8ckKJ=q3X2-ovtKuQcoTyo564mQnQ@mail.gmail.com>
 <20211109091951.GW3891@suse.de>
 <7de25e1b-e548-b8b5-dda5-6a2e001f3c1a@bytedance.com>
 <20211109121222.GX3891@suse.de>
 <117d5b88-b62b-f50b-32ff-1a9fe35b9e2e@bytedance.com>
 <20211109162647.GY3891@suse.de>
 <08e95d68-7ba9-44d0-da85-41dc244b4c99@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <08e95d68-7ba9-44d0-da85-41dc244b4c99@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 03:07:43PM +0800, Gang Li wrote:
> On 11/10/21 12:26 AM, Mel Gorman wrote:
> > 
> > Of those two, I agree with the second one, it would be tricky to implement
> > but the first one is less clear. This is based on an assumption. If prctl
> > exists to enable/disable NUMA baalancing, it's possible that someone
> > else would want to control NUMA balancing on a cgroup basis instead of
> > globally which would run into the same type of concerns -- different
> > semantics depending on the global tunable.
> > 
> 
> Hi!
> 
> You talk about the "semantics" of NUMA balancing between global, cgroup and
> process. While I read the kernel doc "NUMA Memory Policy", it occur to me
> that we may have a "NUMA Balancing Policy".
> 
> Since you are the reviewer of CONFIG_NUMA_BALANCING. I would like to discuss
> the need for introducing "NUMA Balancing Policy" with you. Is this worth
> doing?
> 

It's a bit vague but if you wanted to put together the outline, I'd read
over it. Note that this was all in the context of trying to introduce an
API like

Disable/enable per-process numa balancing:
        prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING, 0/1);

i.e. one that controlled both enabling and disabling. You also have
the option of introducing the NUMAB equivalent of PR_SET_THP_DISABLE --
an API that is explicitly about disabling *only*.

-- 
Mel Gorman
SUSE Labs
