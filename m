Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E53D6F5F6A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 21:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjECTtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 15:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjECTs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 15:48:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0987AA0;
        Wed,  3 May 2023 12:48:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b5465fc13so4281480b3a.3;
        Wed, 03 May 2023 12:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683143337; x=1685735337;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0rUD0Br2hVe3zymEpoVc3T4TI1iG6AHKLcBxAchx6c=;
        b=WRBBKM6Ry5r7jdgtwiYn+VkQZ8oJVQRWR7eY6Q4gywAy/AIvKMLTc5lvr+I7cWBcM8
         TVhHYYvOx67ydwBdoukq9sxuHpDbTIx22fG3/FumxSshOm9pmxX92bnYtvASSZ4zbmzc
         16xIn+Y67YCqR06ozsQt3kblulDkmNtdmkspoxukxm7NEnp7dppq9zXv9usUpK/QejVj
         uG3paayH7MDDf0m/MWp/ZvWKY2r+v95ayLq3zeaaad/ime6aEDAhxIb3bCUzDcMlE+HN
         t35RGIt3UP+SFV37LJD1LcRWQFcEBQWiLoyXLJmQezSeP5APJKrU5xq4XYO73ImZOIXL
         Vu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683143337; x=1685735337;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0rUD0Br2hVe3zymEpoVc3T4TI1iG6AHKLcBxAchx6c=;
        b=Zc05avD7vDx3W4vWNqPQgUXyYHNTO6EFJGI6V6ddGu8U9S0rR3afScUtXiOVo4nlY5
         hcRhWnSIYeN11SX5CiUbvs6QJNJ8bReunBUrkXxTxnyTotrk/rXW4aDxyzExE6mtipws
         P6Nqfs1fYPPwDE9S7pwRKssDCdFiZXLbcwUIxPTfSXBvuNXVQSil4Kt7qwkOAL/rgJP4
         NdHBS34P2aa3FHZC6xtjJRy+qh8KRjGm7MU7TG09B7k9J0HAvBbRawyCWXoCQDJZFtqe
         kT6sr0YJo5hzwZria8oiKkwVdvIYW0A/tpjaAeTl4XFxiFfRAi9wXQItMeTTUJT49I/5
         1jcQ==
X-Gm-Message-State: AC+VfDw4dJXMYF3H3U/aTfgVPOFu1uZhW2D4YtxZ32KD5w7ARrDV7sZv
        TXB7MSo6PVdyMsVmfdK8x6E=
X-Google-Smtp-Source: ACHHUZ7PCAia8qenUZjVuL3CxoAfpPOTz+pVitg644DoS55sSsvwsR0a2zZvJ1yLsyH/3euEv2JSdw==
X-Received: by 2002:a05:6a00:16ca:b0:641:23df:e914 with SMTP id l10-20020a056a0016ca00b0064123dfe914mr31263008pfc.13.1683143337337;
        Wed, 03 May 2023 12:48:57 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6454])
        by smtp.gmail.com with ESMTPSA id s12-20020a056a00178c00b0062e12f945adsm23909517pfg.135.2023.05.03.12.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 12:48:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 3 May 2023 09:48:55 -1000
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
Message-ID: <ZFK6pwOelIlhV8Bm@slm.duckdns.org>
References: <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <ZFIVtB8JyKk0ddA5@moria.home.lan>
 <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
 <20230503180726.GA196054@cmpxchg.org>
 <ZFKlrP7nLn93iIRf@slm.duckdns.org>
 <ZFKqh5Dh93UULdse@slm.duckdns.org>
 <ZFKubD/lq7oB4svV@moria.home.lan>
 <ZFKu6zWA00AzArMF@slm.duckdns.org>
 <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
 <CAJuCfpEPkCJZO2svT-GfmpJ+V-jSLyFDKM_atnqPVRBKtzgtnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEPkCJZO2svT-GfmpJ+V-jSLyFDKM_atnqPVRBKtzgtnQ@mail.gmail.com>
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

On Wed, May 03, 2023 at 12:41:08PM -0700, Suren Baghdasaryan wrote:
> On Wed, May 3, 2023 at 12:09 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Wed, May 03, 2023 at 08:58:51AM -1000, Tejun Heo wrote:
> > > On Wed, May 03, 2023 at 02:56:44PM -0400, Kent Overstreet wrote:
> > > > On Wed, May 03, 2023 at 08:40:07AM -1000, Tejun Heo wrote:
> > > > > > Yeah, easy / default visibility argument does make sense to me.
> > > > >
> > > > > So, a bit of addition here. If this is the thrust, the debugfs part seems
> > > > > rather redundant, right? That's trivially obtainable with tracing / bpf and
> > > > > in a more flexible and performant manner. Also, are we happy with recording
> > > > > just single depth for persistent tracking?
> 
> IIUC, by single depth you mean no call stack capturing?

Yes.

> If so, that's the idea behind the context capture feature so that we
> can enable it on specific allocations only after we determine there is
> something interesting there. So, with low-cost persistent tracking we
> can determine the suspects and then pay some more to investigate those
> suspects in more detail.

Yeah, I was wondering whether it'd be useful to have that configurable so
that it'd be possible for a user to say "I'm okay with the cost, please
track more context per allocation". Given that tracking the immediate caller
is already a huge improvement and narrowing it down from there using
existing tools shouldn't be that difficult, I don't think this is a blocker
in any way. It just bothers me a bit that the code is structured so that
source line is the main abstraction.

> > > > Not sure what you're envisioning?
> > > >
> > > > I'd consider the debugfs interface pretty integral; it's much more
> > > > discoverable for users, and it's hardly any code out of the whole
> > > > patchset.
> > >
> > > You can do the same thing with a bpftrace one liner tho. That's rather
> > > difficult to beat.
> 
> debugfs seemed like a natural choice for such information. If another
> interface is more appropriate I'm happy to explore that.
> 
> >
> > Ah, shit, I'm an idiot. Sorry. I thought allocations was under /proc and
> > allocations.ctx under debugfs. I meant allocations.ctx is redundant.
> 
> Do you mean that we could display allocation context in
> debugfs/allocations file (for the allocations which we explicitly
> enabled context capturing)?

Sorry about the fumbled communication. Here's what I mean:

* Improving memory allocation visibility makes sense to me. To me, a more
  natural place for that feels like /proc/allocations next to other memory
  info files rather than under debugfs.

* The default visibility provided by "allocations" provides something which
  is more difficult or at least cumbersome to obtain using existing tracing
  tools. However, what's provided by "allocations.ctx" can be trivially
  obtained using kprobe and BPF and seems redundant.

Thanks.

-- 
tejun
