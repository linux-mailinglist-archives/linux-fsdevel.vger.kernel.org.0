Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A31F6C6FEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 19:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjCWSEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 14:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjCWSEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:04:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B965610242
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 11:04:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i5so43521144eda.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679594685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cf+dDkaWjCdhFGTseyhJ1TYIdXnZViE1IHL8Z04nLU=;
        b=SeEtrJingXLDxc2TLzv7QBF2wfL9DQ94O+dSKlQ4Ti1iZ+X7K20WRqUzmjh7K/A8EL
         P0LDt6aU89zBgxG5p+bF/KuZuYm8Wel4E9VdPD1UpeVwpe5sHUYo8Og/sDimHTcn/vhC
         6zXSKMO94wdRcSdkPJZRiQ2s6oSClGyReWh50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679594685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cf+dDkaWjCdhFGTseyhJ1TYIdXnZViE1IHL8Z04nLU=;
        b=n8ab73keoSgrAEoPwGQfytEIb48JUJTasYHfmOK9RPFM30Om6d+eAXWKlDDuDhVGAY
         TbJZDiKha6KPF3n9xJjoowhNOQvNQXPaSUqz6NCSCwcvOCkvt0RGK1JHVAMQ45oMTMkC
         jIz71EBWIXG7GK9jRCBcO74LnlunwLuBMJPsIaJKvPscdqfzInSm8q7xtk00HAMHsgL/
         7ClL5vU4aTl6XarFpQHlZUJJiM51gVF8vJhbvXYVXLmzZt+cNPWrXW/+iIvb+L2BpsfG
         5vk5cH/TcC7vUe0QLH/jIW/VHK3xZJIjV/mYRhjksroU49xYWrdC/q9U4ER5ZNJRl5LV
         mxrQ==
X-Gm-Message-State: AO0yUKUdvspqQF3xJOjkxF0JOMVWYCRNQmsJBf+jHmNK+/tt9VgmP+62
        ofY+PsNCrUTfoJioMjSEH3CtHRC9xDm3Bd+KL50eQQ==
X-Google-Smtp-Source: AK7set/4oa7h2+y8qrDxGhkxpawi75ipMZWhUjvmV7PvXAyuJj/Z07xu7mvi4p3n6H5WeKd+ibv3Dw==
X-Received: by 2002:a17:906:5a8f:b0:878:5372:a34b with SMTP id l15-20020a1709065a8f00b008785372a34bmr11591840ejq.45.1679594684800;
        Thu, 23 Mar 2023 11:04:44 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id rv17-20020a17090710d100b00932fa67b48fsm7760123ejb.183.2023.03.23.11.04.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 11:04:44 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id x3so90381527edb.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 11:04:43 -0700 (PDT)
X-Received: by 2002:a17:906:2c04:b0:931:6e39:3d0b with SMTP id
 e4-20020a1709062c0400b009316e393d0bmr5389177ejh.15.1679594683563; Thu, 23 Mar
 2023 11:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230320210724.GB1434@sol.localdomain> <CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com>
 <ZBlJJBR7dH4/kIWD@slm.duckdns.org> <CAHk-=wh0wxPx1zP1onSs88KB6zOQ0oHyOg_vGr5aK8QJ8fuxnw@mail.gmail.com>
 <ZBulmj3CcYTiCC8z@slm.duckdns.org>
In-Reply-To: <ZBulmj3CcYTiCC8z@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Mar 2023 11:04:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgT2TJO6+B=Pho1VOtND-qC_d1PM1FC-Snf+sRpLhR=hg@mail.gmail.com>
Message-ID: <CAHk-=wgT2TJO6+B=Pho1VOtND-qC_d1PM1FC-Snf+sRpLhR=hg@mail.gmail.com>
Subject: Re: [GIT PULL] fsverity fixes for v6.3-rc4
To:     Tejun Heo <tj@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, fsverity@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Huckleberry <nhuck@google.com>,
        Victor Hsieh <victorhsieh@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 6:04=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Thanks for the pointers. They all seem plausible symptoms of work items
> getting bounced across slow cache boundaries. I'm off for a few weeks so
> can't really dig in right now but will get to it afterwards.

So just as a gut feeling, I suspect that one solution would be to
always *start* the work on the local CPU (where "local" might be the
same, or at least a sibling).

The only reason to migrate to another CPU would be if the work is
CPU-intensive, and I do suspect that is commonly not really the case.

And I strongly suspect that our WQ_CPU_INTENSIVE flag is pure garbage,
and should just be gotten rid of, because what could be considered
"CPU intensive" in under one situation might not be CPU intensive in
another one, so trying to use some static knowledge about it is just
pure guess-work.

The different situations might be purely contextual things ("heavy
network traffic when NAPI polling kicks in"), but it might also be
purely hardware-related (ie "this is heavy if we don't have CPU hw
acceleration for crypto, but cheap if we do").

So I really don't think it should be some static decision, either
through WQ_CPU_INTENSIVE _or_ through "WQ_UNBOUND means schedule on
first available CPU".

Wouldn't it be much nicer if we just noticed it dynamically, and
WQ_UNBOUND would mean that the workqueue _can_ be scheduled on another
CPU if it ends up being advantageous?

And we actually kind of have that dynamic flag already, in the form of
the scheduler. It might even be explicit in the context of the
workqueue (with "need_resched()" being true and the workqueue code
itself might notice it and explicitly then try to spread it out), but
with preemption it's more implicit and maybe it needs a bit of
tweaking help.

So that's what I mean by "start the work as local CPU work" - use that
as the baseline decision (since it's going to be the case that has
cache locality), and actively try to avoid spreading things out unless
we have an explicit reason to, and that reason we could just get from
the scheduler.

The worker code already has that "wq_worker_sleeping()" callback from
the scheduler, but that only triggers when a worker is going to sleep.
I'm saying that the "scheduler decided to schedule out a worker" case
might be used as a "Oh, this is CPU intensive, let's try to spread it
out".

See what I'm trying to say?

And yes, the WQ_UNBOUND case does have a weak "prefer local CPU" in
how it basically tends to try to pick the current CPU unless there is
some active reason not to (ie the whole "wq_select_unbound_cpu()"
code), but I suspect that is then counter-acted by the fact that it
will always pick the workqueue pool by node - so the "current CPU"
ends up probably being affected by what random CPU that pool was
running on.

An alternative to any scheduler interaction thing might be to just
tweak "first_idle_worker()". I get the feeling that that choice is
just horrid, and that is another area that could really try to take
locality into account. insert_work() realyl seems to pick a random
worker from the pool - which is fine when the pool is per-cpu, but
when it's the unbound "random node" pool, I really suspect that it
might be much better to try to pick a worker that is on the right cpu.

But hey, I may be missing something. You know this code much better than I =
do.

                  Linus
