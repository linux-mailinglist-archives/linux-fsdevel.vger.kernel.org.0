Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198984544B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 11:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhKQKNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 05:13:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56600 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbhKQKNN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 05:13:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C3E99212CC;
        Wed, 17 Nov 2021 10:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637143812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mhmJLrVhVIw+GLz9j0MpAB8YGPGJGnv5SXbaFK+Gc38=;
        b=XYP3U/Mpbh/hBbiTpSeUdKXWaJyZFBtfvo7BZvfcR9WaGpitiiTVQ/H9AAn5GlJGoOfWcd
        n6zIHdUIsGgweIMyeGwlmExXn9vQh2AB6wY4b12yNF1Jt7pTM6f9MJdENBq3JMa6aF/e4m
        thPlfI270FoAN+qCE1FiCqWxyDVB7hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637143812;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mhmJLrVhVIw+GLz9j0MpAB8YGPGJGnv5SXbaFK+Gc38=;
        b=JFPWMr0zJZBSRfVCV3s+phhItvmsiWmJXNjfkQnnwocGhgek68agiFfCK3HBemnqgy9iIO
        XVCpn6miAs51VVBg==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 90F83A3B8A;
        Wed, 17 Nov 2021 10:10:10 +0000 (UTC)
Date:   Wed, 17 Nov 2021 10:10:08 +0000
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
Subject: Re: Re: Re: Re: Re: Re: Re: [PATCH v1] sched/numa: add per-process
 numa_balancing
Message-ID: <20211117101008.GB3301@suse.de>
References: <20211029083751.GR3891@suse.de>
 <CAMx52ARF1fVH9=YLQMjE=8ckKJ=q3X2-ovtKuQcoTyo564mQnQ@mail.gmail.com>
 <20211109091951.GW3891@suse.de>
 <7de25e1b-e548-b8b5-dda5-6a2e001f3c1a@bytedance.com>
 <20211109121222.GX3891@suse.de>
 <117d5b88-b62b-f50b-32ff-1a9fe35b9e2e@bytedance.com>
 <20211109162647.GY3891@suse.de>
 <08e95d68-7ba9-44d0-da85-41dc244b4c99@bytedance.com>
 <20211117082952.GA3301@suse.de>
 <816cb511-446d-11eb-ae4a-583c5a7102c4@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <816cb511-446d-11eb-ae4a-583c5a7102c4@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 05:38:28PM +0800, Gang Li wrote:
> On 11/17/21 4:29 PM, Mel Gorman wrote:
> > 
> > It's a bit vague but if you wanted to put together the outline, I'd read
> > over it. Note that this was all in the context of trying to introduce an
> 
> Sorry, maybe I shouldn't propose new feature in this context.
> 
> > API like
> > 
> > Disable/enable per-process numa balancing:
> >          prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING, 0/1);
> > 
> > i.e. one that controlled both enabling and disabling. You also have
> > the option of introducing the NUMAB equivalent of PR_SET_THP_DISABLE --
> > an API that is explicitly about disabling *only*.
> > 
> 
> If those APIs are ok with you, I will send v2 soon.
> 
> 1. prctl(PR_NUMA_BALANCING, PR_SET_THP_DISABLE);

It would be (PR_SET_NUMAB_DISABLE, 1) 

> 2. prctl(PR_NUMA_BALANCING, PR_SET_THP_ENABLE);

An enable prctl will have the same problems as
prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING, 0/1) -- it should have
meaning if the numa_balancing sysctl is disabled.

> 3. prctl(PR_NUMA_BALANCING, PR_GET_THP);
> 

PR_GET_NUMAB_DISABLE

-- 
Mel Gorman
SUSE Labs
