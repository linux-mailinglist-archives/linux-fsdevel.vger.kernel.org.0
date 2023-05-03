Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD926F5F8F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 22:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjECUAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 16:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjECUAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 16:00:32 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1793883D6;
        Wed,  3 May 2023 13:00:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64115e652eeso7674923b3a.0;
        Wed, 03 May 2023 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683144030; x=1685736030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0HV83qXSxt0rJsxUhYqPsLXk4a5FBTNhGHWC84tLfFA=;
        b=T5ytdzQZFR/i6X3PRt8GPpsG1Y8I62q5m+7bcocFY5Cvsi6WjKKciTo/qMildNoBZe
         u85rUJbf90oBHRO2tw11PhVl1/2+PBLQR5fvlp3hzuHC/CfV94InI4lPsLH/RfX1qbI8
         ausoXPd6AA+d24SrubrUATq5ZGbTkNJHhzAmb4/I8cKntvdRB5ITs5umOnT9xtLYVW6J
         XelWqPKoBht+a4RuNCfbFoX3W+hTDToV7mxgM9rNIWkoPMCAeRQG8Dr+8MzArcAuR1Md
         bQM+fnzNC44jQ5pJFy8Oos8cJXJygO15rVG3lH4kT1O7gkNi5v7N3Otc1cZyartcRwPg
         eT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683144030; x=1685736030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HV83qXSxt0rJsxUhYqPsLXk4a5FBTNhGHWC84tLfFA=;
        b=D85uzd0Xgft5mPfwBk68Ckxiihu/dLSxwTHOGrOyvFktrCpg+h70x05/9d3Hn51vWu
         p2DMYZ3pfvI40Es+E4I7bP0MNnCSvP+t1VxNV3EXWfQajhIhmsKDbLtPoHLVulxRGBAo
         /wL8Au9x733a6ZlvzkduFECy4gEW+8ttYHYaw/X4ESPIFBQ3l1dxaAhmTMWdz8Tw3H3s
         rl9eGo4xXM/Xrqx1pzO1oOUWiosVceOM18rdvKmDiYmODHltz4MkO6wJX6NCXCS9QfiO
         bCrKNww9ied3T88ALAOtBX19cHoPm5zBYs2D+Nz4YGj4hJG6tg+tVcZPSDYoM0LRug1o
         8e4w==
X-Gm-Message-State: AC+VfDw0T3h3jAWpS/7vacHU0sQZO1i5LESdDlLJkyq5T07T0Q71Q70O
        32YWHMa0mlDFrke/wreCW/o=
X-Google-Smtp-Source: ACHHUZ5olDzdTm5Ey2E+MQulD+SLoYUhuLqQV+Y8D7lSbEkzX4uIXZlIewj6XWYcqZ1z8grZ/iYmXg==
X-Received: by 2002:a05:6a20:1587:b0:f6:592a:7e3d with SMTP id h7-20020a056a20158700b000f6592a7e3dmr3740358pzj.7.1683144030189;
        Wed, 03 May 2023 13:00:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6454])
        by smtp.gmail.com with ESMTPSA id w22-20020a63f516000000b0052873a7cecesm3042624pgh.0.2023.05.03.13.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 13:00:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 3 May 2023 10:00:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, muchun.song@linux.dev,
        rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <ZFK9XMSzOBxIFOHm@slm.duckdns.org>
References: <ZFIVtB8JyKk0ddA5@moria.home.lan>
 <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
 <20230503180726.GA196054@cmpxchg.org>
 <ZFKlrP7nLn93iIRf@slm.duckdns.org>
 <ZFKqh5Dh93UULdse@slm.duckdns.org>
 <ZFKubD/lq7oB4svV@moria.home.lan>
 <ZFKu6zWA00AzArMF@slm.duckdns.org>
 <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
 <CAJuCfpEPkCJZO2svT-GfmpJ+V-jSLyFDKM_atnqPVRBKtzgtnQ@mail.gmail.com>
 <ZFK6pwOelIlhV8Bm@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFK6pwOelIlhV8Bm@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed, May 03, 2023 at 09:48:55AM -1000, Tejun Heo wrote:
> > If so, that's the idea behind the context capture feature so that we
> > can enable it on specific allocations only after we determine there is
> > something interesting there. So, with low-cost persistent tracking we
> > can determine the suspects and then pay some more to investigate those
> > suspects in more detail.
> 
> Yeah, I was wondering whether it'd be useful to have that configurable so
> that it'd be possible for a user to say "I'm okay with the cost, please
> track more context per allocation". Given that tracking the immediate caller
> is already a huge improvement and narrowing it down from there using
> existing tools shouldn't be that difficult, I don't think this is a blocker
> in any way. It just bothers me a bit that the code is structured so that
> source line is the main abstraction.

Another related question. So, the reason for macro'ing stuff is needed is
because you want to print the line directly from kernel, right? Is that
really necessary? Values from __builtin_return_address() can easily be
printed out as function+offset from kernel which already gives most of the
necessary information for triaging and mapping that back to source line from
userspace isn't difficult. Wouldn't using __builtin_return_address() make
the whole thing a lot simpler?

Thanks.

-- 
tejun
