Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744215B8A22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 16:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiINOPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 10:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiINOP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:15:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028EF3342B
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 07:15:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b21so15266601plz.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Fo6+GEpLuzEa2C/BIMz3Nj9vBo1YPW/XzxuoQnVqp/A=;
        b=H6N/ovIZoLE0y5wnmEzlCIr1OyzJJa6sooNhhXVOxrWKu/9S+oay6RlSJ6vHRqDcjD
         XJ12wl1OCHkDdGtAUyWTubazxIa+BpZOlSVIXhy1AmKuWNNs/sejGnUAynbLiRQwixRJ
         MrXCt+FGheaBFqRqwWajpbTITyimyTxC2RCdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Fo6+GEpLuzEa2C/BIMz3Nj9vBo1YPW/XzxuoQnVqp/A=;
        b=rdBHyySZ3nVLTtU0+rFAZitH4Enh4Wi6BsCrWhmYJyA5BDRpQ2GOU2RP3bKrNNG0jn
         w3TmV91UyEtQG2crpla2Fl70glC+8sB5qzg68cleQyLimHzmyHh0/j6dAsz23TgurQ03
         q1VjYpSanMvZ0heL6neO50Ws4ZiX1flxIhTN2vcsb4FB25O0diWZithvGf9Hv0wkiZXm
         /VGi8KU6r8uZPOWotA/L2V3CjnvMchPgmKLYn7XjTTD8PsSbcGLn6vcydvQ+G2Uz3247
         716QwUBYE6fYiFLECtqS+2+EsqE/VkXbt84ogrdAwpEcUHV+8HOe8sPkQQXkpjIbADx6
         qQYw==
X-Gm-Message-State: ACrzQf2HPS+WvgfgBPNNW2UEXrgtfnSCBpVfXQWaIEJ41CfIcyWybibO
        EcnEXEu+pdT7/zWAsUojGsAPYw==
X-Google-Smtp-Source: AMsMyM5mWwjLf2UkfbJqu70601uDNKEj6jsNzEl/wEpzPaasp6U0g3jAcjuOcytWRw4tOx9dR1a1oA==
X-Received: by 2002:a17:90a:c782:b0:202:c73e:5488 with SMTP id gn2-20020a17090ac78200b00202c73e5488mr5023101pjb.202.1663164912285;
        Wed, 14 Sep 2022 07:15:12 -0700 (PDT)
Received: from fastly.com (c-73-223-190-181.hsd1.ca.comcast.net. [73.223.190.181])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b00176b63535adsm10958949plc.260.2022.09.14.07.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Sep 2022 07:15:11 -0700 (PDT)
Date:   Wed, 14 Sep 2022 07:15:08 -0700
From:   Joe Damato <jdamato@fastly.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-mm@kvack.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 1/1] mm: Add per-task struct tlb counters
Message-ID: <20220914141507.GA4422@fastly.com>
References: <1663120270-2673-1-git-send-email-jdamato@fastly.com>
 <1663120270-2673-2-git-send-email-jdamato@fastly.com>
 <e0067441-19e2-2ae6-df47-2018672426be@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0067441-19e2-2ae6-df47-2018672426be@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 14, 2022 at 12:40:55AM -0700, Dave Hansen wrote:
> On 9/13/22 18:51, Joe Damato wrote:
> > TLB shootdowns are tracked globally, but on a busy system it can be
> > difficult to disambiguate the source of TLB shootdowns.
> > 
> > Add two counter fields:
> > 	- nrtlbflush: number of tlb flush events received
> > 	- ngtlbflush: number of tlb flush events generated
> > 
> > Expose those fields in /proc/[pid]/stat so that they can be analyzed
> > alongside similar metrics (e.g. min_flt and maj_flt).
> 
> On x86 at least, we already have two other ways to count flushes.  You
> even quoted them with your patch:
> 
> >  	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
> > +	current->ngtlbflush++;
> >  	if (info->end == TLB_FLUSH_ALL)
> >  		trace_tlb_flush(TLB_REMOTE_SEND_IPI, TLB_FLUSH_ALL);
> 
> Granted, the count_vm_tlb...() one is debugging only.  But, did you try
> to use those other mechanisms?  For instance, could you patch
> count_vm_tlb_event()? 

I tried to address this in my cover letter[1], but the count_vm_tlb_event
are system-wide, AFAICT. This is useful, certainly, but it's difficult to
know how many TLB shootdowns are being generated by which tasks without
finer granularity. The goal was to try to account these events on a
per-task basis.

I could patch count_vm_tlb... to account on a per-task basis. That seems
reasonable to me... assuming you and others are convinced that it's a
better approach than tracepoints ;)

> Why didn't the tracepoints work for you?

Tracepoints do work; but IMHO the trouble with tracepoints in this case is:

- You need to actually be running perf to gather the data at the right
  time; if you stop running perf too soon, or if the TLB shootdown storm is
  caused by some anomalous event when you weren't running perf... you are
  out of luck.
- On heavily loaded systems with O(10,000) or O(100,000) tasks, perf
  tracepoint data is hard to analyze, events can be dropped, and
  significant resources can be consumed.

In addition to this, there is existing tooling on Linux for scraping
/proc/[pid]/stat for graphing/analysis/etc.

IMO, possibly an easier way to debug large TLB shootdowns on a system might
be (using a form of this patch):

1. Examine /proc/[pid]/stat to see which process or processes are
responsible for the majority of the shootdowns. Perhaps you have a script
scraping this data at various intervals and recording deltas.

2. Now that you know the timeline of the events, which processes are
responsible, and the magnitude of the deltas... perf tracepoints can help
you determine when and where exactly they occur.

What do you think?

> Can this be done in a more arch-generic way?  It's a shame to
> unconditionally add counters to the task struct and only use them on
> x86.  If someone wanted to generalize the x86 tracepoints, or make them
> available to other architectures, I think that would be fine even if
> they have to change a bit (queue the inevitable argument about
> tracepoint ABI).

I'm not sure; maybe if I tweaked count_vm_tlb then I suppose if archs
other than x86 support count_vm_tlb in the future, they would
automatically get support for this.

> P.S. I'm not a fan of the structure member naming.

Fair enough; I was inspired by nvcsw and nivcsw :) but if you think that
this worth pursuing, I'll use more clear names in the future.

Thanks for taking a look!
