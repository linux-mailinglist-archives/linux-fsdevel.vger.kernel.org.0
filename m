Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819836F62E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 04:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjEDCZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 22:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjEDCZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 22:25:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFE81B1;
        Wed,  3 May 2023 19:25:34 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaf21bb42bso34068115ad.2;
        Wed, 03 May 2023 19:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683167134; x=1685759134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+UY7cUQaVo4x4W0WCSPsCuWeI5BUJEgh7i3Xst55/Y=;
        b=Rp/D+oug52h2Ti6mXmuImpIIDf60HeMLUvF0iIK2vttPwspm5hYlNosuEHVSrbtxTw
         U1aaOkS4o4kHX9lqnCC9bE9Qv4BkTepdXgX1eP7e7ih03h1Znb/fBHAFzIs3ZLAdzyf8
         Bdy+N5QGo07p0OmImH8mBW0eWTxAwcVTxazuYtPxC6BmtMp0/XcbyFMmmZorx8qew2E9
         Ccf9SafoTVOkRODhvQ6MQpCKPYkFE27/aFmb6+IC+s7J6n+xuSEgUyUsQVp7VEWj1Bkv
         v88EEfrZMkPXlnUNcgeQfwXyllZK7EU5nBpftptzpU3ovg2Ugby7Q+WZX0I3unGEo1Nj
         E0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683167134; x=1685759134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+UY7cUQaVo4x4W0WCSPsCuWeI5BUJEgh7i3Xst55/Y=;
        b=dtbjpX7ia57jjlkDaEKOQsfKP9GGygdKnP69Ub91sMr/qJEl2FhiSuQEnEGGo6ViMk
         r4iE9FQj5XxXmQzwhIsx50JXWloVnquad3bm7YrQE6A6fbJJ2TkPkK+NcvcjU7magQwF
         9fhmgJAVN3JmeyWQburIfzoIW9rJLShj/iDzUeqTylXVJ5eAbg6r32KHPH8Qt8jW4Mby
         g7RRYYj76L3mKrWiTsPRcKwo4R6pI2iXUFYtrhDJ+Z6dYMilUuh7U6LeOCu2IVUmB23N
         KKgFtDWHN1T7oTsx98S5rfqPh9ODpUcONmXVGAwl2t6qVG55/slTp3SC16HBc81E218t
         KrUg==
X-Gm-Message-State: AC+VfDxZbVY3WT/1oPiFscFqewhOob2MqOHLWqLNBrefraxZliH6ZF8H
        BqTo9EqMqcs3U5cF88boFOI=
X-Google-Smtp-Source: ACHHUZ50+OLepUnrnAHDGfxFP5Am44d3DN07c8wNpuEHGpwvY2J63vbecqy2vRXUZik9ScPzDJ5gvw==
X-Received: by 2002:a17:902:c94e:b0:1ab:2758:c8a4 with SMTP id i14-20020a170902c94e00b001ab2758c8a4mr2512871pla.0.1683167133231;
        Wed, 03 May 2023 19:25:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6454])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902d70400b0019ac7319ed1sm2987721ply.126.2023.05.03.19.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 19:25:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 3 May 2023 16:25:30 -1000
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
Message-ID: <ZFMXmj9ZhSe5wyaS@slm.duckdns.org>
References: <20230503180726.GA196054@cmpxchg.org>
 <ZFKlrP7nLn93iIRf@slm.duckdns.org>
 <ZFKqh5Dh93UULdse@slm.duckdns.org>
 <ZFKubD/lq7oB4svV@moria.home.lan>
 <ZFKu6zWA00AzArMF@slm.duckdns.org>
 <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
 <CAJuCfpEPkCJZO2svT-GfmpJ+V-jSLyFDKM_atnqPVRBKtzgtnQ@mail.gmail.com>
 <ZFK6pwOelIlhV8Bm@slm.duckdns.org>
 <ZFK9XMSzOBxIFOHm@slm.duckdns.org>
 <CAJuCfpE4YD_BumqFf2-NC8KS9D+kq0s_o4gRyWAH-WK4SgqUbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpE4YD_BumqFf2-NC8KS9D+kq0s_o4gRyWAH-WK4SgqUbA@mail.gmail.com>
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

On Wed, May 03, 2023 at 01:14:57PM -0700, Suren Baghdasaryan wrote:
> On Wed, May 3, 2023 at 1:00 PM Tejun Heo <tj@kernel.org> wrote:
> > Another related question. So, the reason for macro'ing stuff is needed is
> > because you want to print the line directly from kernel, right?
> 
> The main reason is because we want to inject a code tag at the
> location of the call. If we have a code tag injected at every
> allocation call, then finding the allocation counter (code tag) to
> operate takes no time.
>
> > Is that
> > really necessary? Values from __builtin_return_address() can easily be
> > printed out as function+offset from kernel which already gives most of the
> > necessary information for triaging and mapping that back to source line from
> > userspace isn't difficult. Wouldn't using __builtin_return_address() make
> > the whole thing a lot simpler?
> 
> If we do that we have to associate that address with the allocation
> counter at runtime on the first allocation and look it up on all
> following allocations. That introduces the overhead which we are
> trying to avoid by using macros.

I see. I'm a bit skeptical about the performance angle given that the hot
path can be probably made really cheap even with lookups. In most cases,
it's just gonna be an extra pointer deref and a few more arithmetics. That
can show up in microbenchmarks but it's not gonna be much. The benefit of
going that route would be the tracking thing being mostly self contained.

That said, it's nice to not have to worry about allocating tracking slots
and managing hash table, so no strong opinion.

Thanks.

-- 
tejun
