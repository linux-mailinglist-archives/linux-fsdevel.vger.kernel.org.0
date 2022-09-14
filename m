Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADC05B8A6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 16:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiINO0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiINO0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:26:06 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E997F122
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 07:25:28 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id l65so15074491pfl.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=hdSD8tJb664Fr8pl0NO+kf8L2z4TDzTohEl0wY+gzYc=;
        b=W15M6v323Iel/iK6eFB5fJmsZj9UgNfzHvij6SGJNxbTuWnqIovbfOPRNq3jRPbdSH
         0oyEjnHDaHKU56TfRiVWrQ8OK4AkxXGpiH4n2ZY07EN7lKx2rh0fiNP/u3aArQnoqFKx
         /juLxkWKnaA99ijCsePo3+Yh3Qbi1J71jaTZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hdSD8tJb664Fr8pl0NO+kf8L2z4TDzTohEl0wY+gzYc=;
        b=iKJaVb/8fKjIA4LLpYknsQDdNj6i8G80FmKc5k5U1LAKLy6WgmXTT8WiuAACgbJEiT
         ypNsjdCHrg/gQmyYwknccXvwCcH6D1FTyXk/5Vp3GHdeD3pKn1pcIGF8iuA15EF/drje
         tobChfCpSlw9uZ0Ipun1tlHKEtxCHlMTykTjNprsx9DEmhhRBOvj7NYV4XWd/qwsDRmm
         f5n+z++DXmkBRAwvdg6mIR0aC/DuPI36FKH14KZmwus4eHOm9Tlx7ytsO0eHeAv8/GyW
         fNhkX10wGwS+OoZHc9MVjFHhAbZ4GzA0yjbNlqeAczXTXATEBLVksBXPI0NF0GIfDPaJ
         nnug==
X-Gm-Message-State: ACgBeo3QqZ/cCxW9iWptUpf1KnRszZVuuNwZ2YGQjTqen8Z4RkIREAWA
        PXyUm5pSzbGU48lK9JcgagCg1Q==
X-Google-Smtp-Source: AA6agR6En5JhEov24TDmvwIDj3j1j5VGKylIZcdmOMCIY6+KUUuqabgXpORLodRAghUj4fpa4NlpVw==
X-Received: by 2002:aa7:97b4:0:b0:547:f861:1fc3 with SMTP id d20-20020aa797b4000000b00547f8611fc3mr2784496pfq.42.1663165527599;
        Wed, 14 Sep 2022 07:25:27 -0700 (PDT)
Received: from fastly.com (c-73-223-190-181.hsd1.ca.comcast.net. [73.223.190.181])
        by smtp.gmail.com with ESMTPSA id e19-20020a656bd3000000b004351358f056sm9642274pgw.85.2022.09.14.07.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Sep 2022 07:25:27 -0700 (PDT)
Date:   Wed, 14 Sep 2022 07:25:24 -0700
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
Message-ID: <20220914142523.GC4422@fastly.com>
References: <1663120270-2673-1-git-send-email-jdamato@fastly.com>
 <1663120270-2673-2-git-send-email-jdamato@fastly.com>
 <e0067441-19e2-2ae6-df47-2018672426be@intel.com>
 <20220914141507.GA4422@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914141507.GA4422@fastly.com>
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

On Wed, Sep 14, 2022 at 07:15:07AM -0700, Joe Damato wrote:
> On Wed, Sep 14, 2022 at 12:40:55AM -0700, Dave Hansen wrote:
> > On 9/13/22 18:51, Joe Damato wrote:
> > > TLB shootdowns are tracked globally, but on a busy system it can be
> > > difficult to disambiguate the source of TLB shootdowns.
> > > 
> > > Add two counter fields:
> > > 	- nrtlbflush: number of tlb flush events received
> > > 	- ngtlbflush: number of tlb flush events generated
> > > 
> > > Expose those fields in /proc/[pid]/stat so that they can be analyzed
> > > alongside similar metrics (e.g. min_flt and maj_flt).
> > 
> > On x86 at least, we already have two other ways to count flushes.  You
> > even quoted them with your patch:
> > 
> > >  	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
> > > +	current->ngtlbflush++;
> > >  	if (info->end == TLB_FLUSH_ALL)
> > >  		trace_tlb_flush(TLB_REMOTE_SEND_IPI, TLB_FLUSH_ALL);
> > 
> > Granted, the count_vm_tlb...() one is debugging only.  But, did you try
> > to use those other mechanisms?  For instance, could you patch
> > count_vm_tlb_event()? 
> 
> I tried to address this in my cover letter[1]...

Err, I forgot the [1]:
https://lore.kernel.org/linux-mm/1663120270-2673-1-git-send-email-jdamato@fastly.com/
