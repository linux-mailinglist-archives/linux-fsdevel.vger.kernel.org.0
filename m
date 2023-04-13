Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA0E6E032B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 02:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDMAZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 20:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDMAZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:25:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C02A72B5;
        Wed, 12 Apr 2023 17:25:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id jx2-20020a17090b46c200b002469a9ff94aso11648786pjb.3;
        Wed, 12 Apr 2023 17:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681345512; x=1683937512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lfvgtq1GkN0CrIBSozWhdgpFNVT9/wsnnGPGOgGQ6EQ=;
        b=Q8s/e44vAP/ox/zkk2jQIbetGwClWZ/k7XE7rQgc37xW35WHiGiXb/pc/QiCf8wSPk
         9H3CCVhyPwg8Xm6d9XT9WNneP+b+/AlbxhlN/ls3Sl7k1DyIX/mi/hnna8266KIcFg16
         7bFIxK0Qdi8sd9e31BpYOXJtYVlcfYeMTLKhZ92uv20n4CHJmOBnwDvYZxhGaSOL8ENm
         yJWJ3a4byBUU/mdFXdOoJvEe4UaZbHc+5OTz8mVq2Omq3FW5C5joCpJ7sIyeQuCbU3Nn
         Z5E2qrhz9SrNW63kux0zrmcBt4ZMTDa/chZ1qgvybWKK90lD1fOJombgk6miIeS2ohUZ
         Z15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681345512; x=1683937512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lfvgtq1GkN0CrIBSozWhdgpFNVT9/wsnnGPGOgGQ6EQ=;
        b=Yo/1Vb/9tgZonIdyDNWD0yrPuRaKLn5hy9CL5bLjbqD3UcUM4xQNq2LG/xRp1rGjNx
         /vA5ajnV5z1f5/RS8j8BO/KhNEnExVyuhL9illWmtVkr2Kq7KGbRHVbiT9gEifRB0f1F
         Ezqo+qcJOAseboUehvvzVHs4Xy4fJK2OalHWQVLzyjuhkfWKNOZypOV1yMQs3IKK+Zh9
         BaOXMuTLsvoyQ3Xb9qH3GEJZalNDCQgp0TLHEaBcZr1AEvKflBahL6Mkg1/0PL/5IWzf
         En3z/bWKH2BZHLU1yrElaEibMEmwi+nY/Is/UfznX7KrMBLqNucy0nuxS+Dz/sCFtPkO
         n1qQ==
X-Gm-Message-State: AAQBX9cDwFTkQfaAffXBM591/UiuOPEVxb4v7CjSyiz5MZF2CJ0YFfLL
        5Ye1mvpNAM3pagf30wqpgJ8=
X-Google-Smtp-Source: AKy350adfUjwp3r+dZrmTD8NvBMDDm6dB1/WtEo95M9lbILkgNOG2NCxY2i3bsAsB2s7cFML7PAIcw==
X-Received: by 2002:a05:6a20:8b0a:b0:da:a7db:48bb with SMTP id l10-20020a056a208b0a00b000daa7db48bbmr187609pzh.42.1681345512215;
        Wed, 12 Apr 2023 17:25:12 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id m14-20020aa7900e000000b005d866d184b5sm52620pfo.46.2023.04.12.17.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 17:25:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Apr 2023 14:25:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, fsverity@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Nathan Huckleberry <nhuck@google.com>,
        Victor Hsieh <victorhsieh@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [GIT PULL] fsverity fixes for v6.3-rc4
Message-ID: <ZDdL5s_wprnlF7ad@slm.duckdns.org>
References: <20230320210724.GB1434@sol.localdomain>
 <CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com>
 <ZBlJJBR7dH4/kIWD@slm.duckdns.org>
 <CAHk-=wh0wxPx1zP1onSs88KB6zOQ0oHyOg_vGr5aK8QJ8fuxnw@mail.gmail.com>
 <ZBulmj3CcYTiCC8z@slm.duckdns.org>
 <CAHk-=wgT2TJO6+B=Pho1VOtND-qC_d1PM1FC-Snf+sRpLhR=hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgT2TJO6+B=Pho1VOtND-qC_d1PM1FC-Snf+sRpLhR=hg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Linus.

Okay, I'm now back online.

On Thu, Mar 23, 2023 at 11:04:25AM -0700, Linus Torvalds wrote:
> On Wed, Mar 22, 2023 at 6:04 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > Thanks for the pointers. They all seem plausible symptoms of work items
> > getting bounced across slow cache boundaries. I'm off for a few weeks so
> > can't really dig in right now but will get to it afterwards.
> 
> So just as a gut feeling, I suspect that one solution would be to
> always *start* the work on the local CPU (where "local" might be the
> same, or at least a sibling).

Yeah, that seems like the sanest way to leverage the scheduler. The only
complication is around tracking which workers were on which CPUs and how
sticky the cpu association should be (e.g. we don't want to unnecessarily
jump workers across CPUs but we probably don't want to maintain strict
per-cpu worker pools either). I'll try to come up with a reasonable
trade-off which isn't too complicated.

> The only reason to migrate to another CPU would be if the work is
> CPU-intensive, and I do suspect that is commonly not really the case.
> 
> And I strongly suspect that our WQ_CPU_INTENSIVE flag is pure garbage,
> and should just be gotten rid of, because what could be considered
> "CPU intensive" in under one situation might not be CPU intensive in
> another one, so trying to use some static knowledge about it is just
> pure guess-work.
> 
> The different situations might be purely contextual things ("heavy
> network traffic when NAPI polling kicks in"), but it might also be
> purely hardware-related (ie "this is heavy if we don't have CPU hw
> acceleration for crypto, but cheap if we do").
> 
> So I really don't think it should be some static decision, either
> through WQ_CPU_INTENSIVE _or_ through "WQ_UNBOUND means schedule on
> first available CPU".
> 
> Wouldn't it be much nicer if we just noticed it dynamically, and
> WQ_UNBOUND would mean that the workqueue _can_ be scheduled on another
> CPU if it ends up being advantageous?
> 
> And we actually kind of have that dynamic flag already, in the form of
> the scheduler. It might even be explicit in the context of the
> workqueue (with "need_resched()" being true and the workqueue code
> itself might notice it and explicitly then try to spread it out), but
> with preemption it's more implicit and maybe it needs a bit of
> tweaking help.

Yeah, CPU_INTENSIVE was added as an easy (to implement) way out for cpu
hogging percpu work items. Given that percpu workers track the scheduling
events anyway whether from preemption or explicit schedule(), it should be
possible to remove it while maintaining most of the benefits of worker
concurrency management. Because the scheduler isn't aware of work item
boundaries, workqueue can't blindly use scheduling events but that's easy to
resolve with an extra timestamp.

I'll think more about whether it'd be a good idea to subject unbound workers
to concurrency management before it gets spread out so that the only
distinction between percpu and unbound is whether the work item can be
booted off cpu when they run for too long while being subject to the same
concurrency control before that point.

> So that's what I mean by "start the work as local CPU work" - use that
> as the baseline decision (since it's going to be the case that has
> cache locality), and actively try to avoid spreading things out unless
> we have an explicit reason to, and that reason we could just get from
> the scheduler.
> 
> The worker code already has that "wq_worker_sleeping()" callback from
> the scheduler, but that only triggers when a worker is going to sleep.
> I'm saying that the "scheduler decided to schedule out a worker" case
> might be used as a "Oh, this is CPU intensive, let's try to spread it
> out".
> 
> See what I'm trying to say?

Yeah, lemme look into it. It'd be great to simplify workqueue usage and
actually make it leverage what the scheduler knows about what should run
where.

Thanks.

-- 
tejun
