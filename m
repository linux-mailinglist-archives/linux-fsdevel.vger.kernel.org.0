Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2ED6F62D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 04:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjEDCQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 22:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjEDCQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 22:16:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6851A5;
        Wed,  3 May 2023 19:16:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-24df4ecdb87so13048a91.0;
        Wed, 03 May 2023 19:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683166607; x=1685758607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xki9EImbF8EHplkOG7u13eoQc3pPoVT6i0i48IKNO48=;
        b=AVbZGT9K0r89MqzrSpIR7uMQXdw8u/F4834X6xnRREOGxmDQ4D/A6MjHGUxFG3npis
         aSiP7azLezP1XiGgrGudWR33IUl22a/61L8gQoe/STrWaRoCtDxodSejGGl7LbFwoSoW
         y8er0cowxZ+SiTuo8NZyP0h49wpyK2kMLhUVxrO1AuEfSIV5AQV6s/WtZ233X+EY2wzS
         HnH2l/EQfk2fmkfN3WEcKcwTa+M18CB0b6bZWDe3dFh5+ms0vEqPkw0zF+C7i7OAyOn6
         4mDKRPiK7AP3pPjuxFNw9ey2zSAa4AXCrWoax2bREtiC64a4zO5i43E6Ply2PNr5/uI6
         ybJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683166607; x=1685758607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xki9EImbF8EHplkOG7u13eoQc3pPoVT6i0i48IKNO48=;
        b=MM3dMURXSfcey280qVppIyEXYmxA2k1cqSaGUgC6OyY1mKYPyY1Rqwbl/5AMXA3F5+
         L2KutqNafXDwxulqpMdhu5r2QRmGvFA0qYJV/EmAxCJcleGWVq1QaDOXzWJviEOpgU0f
         mPZabcKYZlSRDLrlaciFQN7RhvfwJ87yp1+nFHaP4TpDpur6QmNP9/qpAj1vjzefFbOo
         wxrjpgkBb0enqT98KbxuAXuaKH9ByBR/RScxprsNnwVduJzvCEufOtJa7MtHNI0eb5/A
         VrJhdjUF9q6LnwZiI14k8K0ki1XOKT5Q+8M3sI2PKZwj/JdbQ0xhMzAbfz8nsaIJ5iMR
         WoCA==
X-Gm-Message-State: AC+VfDzlO5LO6efHztyzEliefkgZFQ96LwxpC8c/19Pdgb6SKlRnnXLX
        YIlukQVBpcjWV6KUYDRRKt8=
X-Google-Smtp-Source: ACHHUZ586dtnZJkOKWi8qtW2XOPFy14umbO1JQg1ZdQXQttGCitXUXieeRChBtu6pNojzrEGrsn1pA==
X-Received: by 2002:a17:902:a60e:b0:1a9:2b7f:a594 with SMTP id u14-20020a170902a60e00b001a92b7fa594mr1984126plq.29.1683166606837;
        Wed, 03 May 2023 19:16:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6454])
        by smtp.gmail.com with ESMTPSA id jd20-20020a170903261400b001a682a195basm3871260plb.28.2023.05.03.19.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 19:16:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 3 May 2023 16:16:44 -1000
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
Message-ID: <ZFMVjAze4tu0DUXs@slm.duckdns.org>
References: <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
 <20230503180726.GA196054@cmpxchg.org>
 <ZFKlrP7nLn93iIRf@slm.duckdns.org>
 <ZFKqh5Dh93UULdse@slm.duckdns.org>
 <ZFKubD/lq7oB4svV@moria.home.lan>
 <ZFKu6zWA00AzArMF@slm.duckdns.org>
 <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
 <CAJuCfpEPkCJZO2svT-GfmpJ+V-jSLyFDKM_atnqPVRBKtzgtnQ@mail.gmail.com>
 <ZFK6pwOelIlhV8Bm@slm.duckdns.org>
 <CAJuCfpG4TmRpT5iU7bJmKcjW2Tghstdo1b=qEG=tDsmtJQYuWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG4TmRpT5iU7bJmKcjW2Tghstdo1b=qEG=tDsmtJQYuWA@mail.gmail.com>
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

On Wed, May 03, 2023 at 01:08:40PM -0700, Suren Baghdasaryan wrote:
> > Yeah, I was wondering whether it'd be useful to have that configurable so
> > that it'd be possible for a user to say "I'm okay with the cost, please
> > track more context per allocation".
> 
> I assume by "more context per allocation" you mean for a specific
> allocation, not for all allocations.
> So, in a sense you are asking if the context capture feature can be
> dropped from this series and implemented using some other means. Is
> that right?

Oh, no, what I meant was whether it'd make sense to allow enable richer
tracking (e.g. record deeper into callstack) for all allocations. For
targeted tracking, it seems that the kernel already has everything needed.
But this is more of an idle thought and the immediate caller tracking is
already a big improvement in terms of visibility, so no need to be hung up
on this part of discussion at all.

Thanks.

-- 
tejun
