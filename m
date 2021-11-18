Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422CC455783
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 09:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbhKRJBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 04:01:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49728 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244873AbhKRJB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 04:01:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A9C7D21763;
        Thu, 18 Nov 2021 08:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637225908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DMSRHZltUhfnD0xcd/VgVm+c9gvquxAWnELVPwEVRpw=;
        b=eTz3wXhLogtPJE0sEp1EBos0JswRTRYCM3P//c7jP4riflnr5fp5rUumfYbNWB9PowoDmV
        1qFU8cKyDzO/A2MI5ce/ZebRzPs3Hn+45hmeHmeiES2zw1+sGmCOszTyX+6YPUvtaCfQkG
        V1pmGP51FZBwNQ0W8aqxacp7p/Et9AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637225908;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DMSRHZltUhfnD0xcd/VgVm+c9gvquxAWnELVPwEVRpw=;
        b=yxI91LKMw5KKkwWK2zjWhuX8YRPzaYM8osTHT88mweOattB1kdAk+j+LPfU9xiTjfEm+y3
        LQ+9rRggHIeCX6BQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 523D2A3B84;
        Thu, 18 Nov 2021 08:58:27 +0000 (UTC)
Date:   Thu, 18 Nov 2021 08:58:20 +0000
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
Subject: Re: Re: Re: Re: Re: Re: Re: Re: [PATCH v1] sched/numa: add
 per-process numa_balancing
Message-ID: <20211118085819.GD3301@suse.de>
References: <20211109091951.GW3891@suse.de>
 <7de25e1b-e548-b8b5-dda5-6a2e001f3c1a@bytedance.com>
 <20211109121222.GX3891@suse.de>
 <117d5b88-b62b-f50b-32ff-1a9fe35b9e2e@bytedance.com>
 <20211109162647.GY3891@suse.de>
 <08e95d68-7ba9-44d0-da85-41dc244b4c99@bytedance.com>
 <20211117082952.GA3301@suse.de>
 <816cb511-446d-11eb-ae4a-583c5a7102c4@bytedance.com>
 <20211117101008.GB3301@suse.de>
 <f0193837-2f2c-b55f-cd79-b80d931e7931@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <f0193837-2f2c-b55f-cd79-b80d931e7931@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 18, 2021 at 11:26:30AM +0800, Gang Li wrote:
> On 11/17/21 6:10 PM, Mel Gorman wrote:
> > On Wed, Nov 17, 2021 at 05:38:28PM +0800, Gang Li wrote:
> > > If those APIs are ok with you, I will send v2 soon.
> > > 
> > > 1. prctl(PR_NUMA_BALANCING, PR_SET_THP_DISABLE);
> > 
> > It would be (PR_SET_NUMAB_DISABLE, 1)
> > 
> > > 2. prctl(PR_NUMA_BALANCING, PR_SET_THP_ENABLE);
> > 
> > An enable prctl will have the same problems as
> > prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING, 0/1) -- it should have
> > meaning if the numa_balancing sysctl is disabled.
> > 
> > > 3. prctl(PR_NUMA_BALANCING, PR_GET_THP);
> > > 
> > 
> > PR_GET_NUMAB_DISABLE
> > 
> 
> How about this:
> 
> 1. prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DEFAULT); //follow global
> 2. prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DISABLE); //disable
> 3. prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_ENABLE);  //enable

If PR_SET_NUMAB_ENABLE enables numa balancing for a task when
kernel.numa_balancing == 0 instead of returning an error then sure.

> 4. prctl(PR_NUMA_BALANCING, PR_GET_NUMAB);
> 
> PR_SET_NUMAB_DISABLE/ENABLE can always have meaning whether the
> numa_balancing sysctl is disabled or not,
> 
> -- 
> Thanks,
> Gang Li
> 

-- 
Mel Gorman
SUSE Labs
