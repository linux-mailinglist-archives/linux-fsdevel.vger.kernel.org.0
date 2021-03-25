Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B703495B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 16:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhCYPfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 11:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhCYPfp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:35:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E06C06174A;
        Thu, 25 Mar 2021 08:35:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bf3so2904075edb.6;
        Thu, 25 Mar 2021 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1QKElLhOfCduB4W2ZnttsXzaaUpOx3i5hzbEvc+SfaM=;
        b=vReFbpzUBBXDyQUErdI0nstv8yW0OW75oySEvy3/KYNqcwbs8aHjOCdxuz7BaMFh3U
         UF+583vXaR5SNWYyaebRJ2npbrVh4f2FBE1HP0gXRRziMzcAxQynTX0+I2M9YnqKNMv2
         wRcELASUKOjdxmiAuBnjEVzm7bveC8y1SyLfBrk+qwaVMRND4BEMUzyEQzO/cN2B+o5v
         Lvn9XVEv4yi4jKI6S4bCugs0E5kJRol1NWonhvNfY6RtQUcjmB0Src2XvhzgK+ykZap2
         KZCpV61fJAt2PEtl/i0j7ck/e7Vf8BtUOVN3JYzbOrIKyAcfRWVqlbnzW+lN8MpQx1KC
         fwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1QKElLhOfCduB4W2ZnttsXzaaUpOx3i5hzbEvc+SfaM=;
        b=joQIGIrEqsUVi5PDEy4oK5TwU0zjCrox19klHdc1oDwxks4zR8JvGqAALkCX28sB3e
         U8fgZ775tc91X1piKQ1/BRZjtzBQ5GfrHz9k2xGISNgGeYwzs6Olx+5RScJJh/a5BqEw
         uPT8zDBjPYLuFVoqNNNLyTUJglyp3xj3jtDPdzOU6De2EZjwTQpO7G95ons8uKegLsEg
         ZRukiBReMmb9RV7kEvWE4xHyxAM2WUD/pOzhFiX4mcVogv31McAVaom2gomKCPC7uQt1
         avpZd7L5VSBPZzzTblAtbD3MHCARu5VfA93VBU+EqR5n2S41pLS2Jfmgd9Rs1JjIRg6k
         +bcw==
X-Gm-Message-State: AOAM5313PSgRQs8Qd6WASB8Vv4sbg9+WCh4wsV3FZya5FxaoL5FcKZTW
        tb8re6F8ZLD+7j5VutaBff4=
X-Google-Smtp-Source: ABdhPJy/1eWCFTCJH7El48i7bPgctwSRVRauBoblIf5Y4tbBowf/F2Xp7Kn8apN23vTJwgVJ8ljFTg==
X-Received: by 2002:a05:6402:17d5:: with SMTP id s21mr9755769edy.65.1616686542501;
        Thu, 25 Mar 2021 08:35:42 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id r19sm2868681edp.52.2021.03.25.08.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:35:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 25 Mar 2021 16:35:33 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 07/11] perf: Add breakpoint information to siginfo on
 SIGTRAP
Message-ID: <20210325153056.GA1895212@gmail.com>
References: <20210324112503.623833-8-elver@google.com>
 <YFs2XHqepwtlLinx@hirez.programming.kicks-ass.net>
 <YFs4RDKfbjw89tf3@hirez.programming.kicks-ass.net>
 <YFs84dx8KcAtSt5/@hirez.programming.kicks-ass.net>
 <YFtB+Ta9pkMg4C2h@hirez.programming.kicks-ass.net>
 <YFtF8tEPHrXnw7cX@hirez.programming.kicks-ass.net>
 <CANpmjNPkBQwmNFO_hnUcjYGM=1SXJy+zgwb2dJeuOTAXphfDsw@mail.gmail.com>
 <CACT4Y+aKmdsXhRZi2f3LsX3m=krdY4kPsEUcieSugO2wY=xA-Q@mail.gmail.com>
 <20210325141820.GA1456211@gmail.com>
 <CANpmjNNcYSGCC7587YzMzX1UpDvTA8ewAJRsKFdzQRdmWEO7Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNcYSGCC7587YzMzX1UpDvTA8ewAJRsKFdzQRdmWEO7Yw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


* Marco Elver <elver@google.com> wrote:

> > Yeah, so why cannot we allocate enough space from the signal 
> > handler user-space stack and put the attr there, and point to it 
> > from sig_info?
> >
> > The idea would be to create a stable, per-signal snapshot of 
> > whatever the perf_attr state is at the moment the event happens 
> > and the signal is generated - which is roughly what user-space 
> > wants, right?
> 
> I certainly couldn't say how feasible this is. Is there 
> infrastructure in place to do this? Or do we have to introduce 
> support for stashing things on the signal stack?
> 
> From what we can tell, the most flexible option though appears to be 
> just some user settable opaque data in perf_event_attr, that is 
> copied to siginfo. It'd allow user space to store a pointer or a 
> hash/key, or just encode the relevant information it wants; but 
> could also go further, and add information beyond perf_event_attr, 
> such as things like a signal receiver filter (e.g. task ID or set of 
> threads which should process the signal etc.).
> 
> So if there's no strong objection to the additional field in 
> perf_event_attr, I think it'll give us the simplest and most 
> flexible option.

Sounds good to me - it's also probably measurably faster than copying 
the not-so-small-anymore perf_attr structure.

Thanks,

	Ingo
