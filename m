Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B545B8A52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 16:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiINOXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 10:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiINOXU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:23:20 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9224C61A
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 07:23:18 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q9so5339859pgq.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7X3jI/FDmkrBs7DhtU4sYpQT4M91OAzd4bF9ysc8YQA=;
        b=kuTFYHmJmpQFxv2JP6mXl4t7RMOKICwKvTcwLslqUJQ/xIlbxwQYeNKTsYUk2K2fIw
         16zOvbCrZ98E0IA/KYx5UktK/z6ClyAYPoHMSE7uJ30cU5o9IDFy857orY0dbk+oVpLL
         f/C15UDXNwotak1w8D3iBgvVTrcdx0jaXtqGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7X3jI/FDmkrBs7DhtU4sYpQT4M91OAzd4bF9ysc8YQA=;
        b=ZwWpv3F0zLo3suJ94tcN60fhEtClj3W6JOCxxJGPnop2l4PyyNmdOPxw+w+PmDIMTH
         OO0Yn9LLz1it6SIizKc9aM3TlQuQG5di4K1KTAi1HzCcx+qvm7hRRB5d9mFz5b08fs+0
         rKKkd91VFbhuqEaENK0FbpKtf6AlAXQausOEsJlNLZSEMTR+gnGO+orvaLMjQOvIDIsw
         P3duyI47zfc92RicV5Y6nBSoAt3/bi7z3xdLFJE1P/GI9C+RsWUzQxXmS7I8vYhl6Sec
         /ckG77g0rm48OlW+14+c4JCaWjQdMTjywkia6AKyDzH362300cQ55QDkW31AjlT5J0tW
         05xg==
X-Gm-Message-State: ACgBeo3q90bsw9JCVYLf1Ksxj2+egqVI/kYczX2wDzmgYpGDoclgzdt8
        c9Dhv9KSGRts/l78tZhB1LNxZw==
X-Google-Smtp-Source: AA6agR5e0Wb81DIfJkmSV8Voh4NfgntHAxCLTOZXQzJ2lzogbO8SlJVIATVlUY6WISHAYjiZnqvEAw==
X-Received: by 2002:a63:ed18:0:b0:439:4176:3ea6 with SMTP id d24-20020a63ed18000000b0043941763ea6mr7224872pgi.363.1663165397855;
        Wed, 14 Sep 2022 07:23:17 -0700 (PDT)
Received: from fastly.com (c-73-223-190-181.hsd1.ca.comcast.net. [73.223.190.181])
        by smtp.gmail.com with ESMTPSA id q6-20020aa78426000000b0053b9e5d365bsm5350864pfn.216.2022.09.14.07.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Sep 2022 07:23:17 -0700 (PDT)
Date:   Wed, 14 Sep 2022 07:23:14 -0700
From:   Joe Damato <jdamato@fastly.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20220914142313.GB4422@fastly.com>
References: <1663120270-2673-1-git-send-email-jdamato@fastly.com>
 <1663120270-2673-2-git-send-email-jdamato@fastly.com>
 <e0067441-19e2-2ae6-df47-2018672426be@intel.com>
 <YyHB48HSs/1S6S08@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyHB48HSs/1S6S08@hirez.programming.kicks-ass.net>
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

On Wed, Sep 14, 2022 at 01:58:27PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 14, 2022 at 12:40:55AM -0700, Dave Hansen wrote:
> >  Why didn't the tracepoints work for you?
> 
> This; perf should be able to get you per-task slices of those events.

Thanks for taking a look; I replied to Dave with a longer form response,
but IMHO, tracepoints are helpful in specific circumstances.

On a heavily loaded system with O(10,000) or O(100,000) tasks, tracepoints
can be difficult to use... especially if the TLB shootdown events are
anomalous events that happen in large bursts at unknown intervals and are
difficult to reproduce.

IMHO, I think that being able to periodically scrape /proc to see that a
particular process has a large TLB shootdown storm can then instruct you as
to when to apply perf (and to which specific tasks) in order to debug the
issue.
