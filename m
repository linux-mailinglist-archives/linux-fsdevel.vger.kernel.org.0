Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BDE68A233
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 19:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjBCSrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 13:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCSrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:47:15 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FC79A829
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Feb 2023 10:47:14 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s17so4916313ois.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Feb 2023 10:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zGzgsd+21G+envIJlNRx5y9NhgSp6TVSN947NkGcDoU=;
        b=Zys9UuFgbs5lFCJjTVpbZ+9mU4XMeIXJD7J5i83+FTKbduuV0z5gbKI1zNXth8J3Ig
         9OieKh0UeUbYpR5fMMo5857ITLXDQXoVnJGjwWLKt3y+ItiYbqbS8l9E3R1ZZ6v1s4BQ
         ff/KEvQ+xLtaLLYsCi8/34e7BsT10RePYvzGRomTwI5yjyAUsAUezEHnJ+XLddyIms9Z
         BAmwL+/JH3b2TWPdbrH+va8sPyLbW+cqPvYcYJL95tBw9uG8CgKGyacrhAhsfE+bwX2/
         gEMLV3IJBRGGF0nUFXYeLqlLANHgxkRlYZdsme13OQ41K8c96zJfLuv3/KTWidCPPlgo
         dGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGzgsd+21G+envIJlNRx5y9NhgSp6TVSN947NkGcDoU=;
        b=2URroB4CHCkNSXK2/8oyqF7zdoWWz2dUpvdezCfY2iw7s+CeSlgA92UJJagw2fJgiT
         dNHuWVdYwl7kLNPmLRjerpjuA3CkzDhl72J1yoVOft48AbZGflN0AlJrJAZzeJPC5gNL
         hJ2HaxIEcQu2q3T2AVJpMdmRhKcgkyKNlGOlzsj6KhgQU6cKErkLdZIXB/WXglgiGCZm
         tlKC+N59kBKOTBI6vnz5sd5ALO9Ny9VWQSgK1UYuxMD87L3JJHRPD6Y6Jj/Xw1/NyHnk
         oAYDjIvqc8t9vq7yk4TcQdvfhNUxMDyGlc2DKfKuN7tEy1YdbBSZjuJt47elzwN217gO
         +oUg==
X-Gm-Message-State: AO0yUKV2t4arrmGbqcIW/Mh4aDADP69Pp1nXZAfxEBP+Q4KUvTOSOCIT
        fNg7GTqID5IT8PCZk5FL6zCdOEKlpG2vtM0AT/Jg0w==
X-Google-Smtp-Source: AK7set9mhGy7e3QXRzMk/FLsY/CqOQwSMhuyH7EcoU1Eacrih382m5f/4VfIzl0Tkj2qGxwjD2UR1m6mCmdTNn9aDYg=
X-Received: by 2002:a05:6808:2c6:b0:367:eed:a770 with SMTP id
 a6-20020a05680802c600b003670eeda770mr525327oid.282.1675450033511; Fri, 03 Feb
 2023 10:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20230201012032.2874481-1-xii@google.com> <Y9zZDcIua63WOdG7@hirez.programming.kicks-ass.net>
In-Reply-To: <Y9zZDcIua63WOdG7@hirez.programming.kicks-ass.net>
From:   Xi Wang <xii@google.com>
Date:   Fri, 3 Feb 2023 10:47:01 -0800
Message-ID: <CAOBoifgz0pRCBUqo7+X2BKgSuHmQLB6X0LZ9D2eYvboO5yzybg@mail.gmail.com>
Subject: Re: [PATCH] sched: Consider capacity for certain load balancing decisions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 3, 2023 at 1:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 31, 2023 at 05:20:32PM -0800, Xi Wang wrote:
> > After load balancing was split into different scenarios, CPU capacity
> > is ignored for the "migrate_task" case, which means a thread can stay
> > on a softirq heavy cpu for an extended amount of time.
> >
> > By comparing nr_running/capacity instead of just nr_running we can add
> > CPU capacity back into "migrate_task" decisions. This benefits
> > workloads running on machines with heavy network traffic. The change
> > is unlikely to cause serious problems for other workloads but maybe
> > some corner cases still need to be considered.
> >
> > Signed-off-by: Xi Wang <xii@google.com>
> > ---
> >  kernel/sched/fair.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0f8736991427..aad14bc04544 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10368,8 +10368,9 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >                       break;
> >
> >               case migrate_task:
> > -                     if (busiest_nr < nr_running) {
> > +                     if (busiest_nr * capacity < nr_running * busiest_capacity) {
> >                               busiest_nr = nr_running;
> > +                             busiest_capacity = capacity;
> >                               busiest = rq;
> >                       }
> >                       break;
>
> I don't think this is correct. The migrate_task case is work-conserving,
> and your change can severely break that I think.
>

I think you meant this kind of scenario:
cpu 0: idle
cpu 1: 2 tasks
cpu 2: 1 task but only has 30% of capacity
Pulling from cpu 2 is good for the task but lowers the overall cpu
throughput.

The problem we have is:
cpu 0: idle
cpu 1: 1 task
cpu 2: 1 task but only has 60% of capacity due to net softirq
The task on cpu 2 stays there and runs slower. (This can also be
considered non work-conserving if we account softirq like a task.)

Maybe the logic can be merged like this: Use capacity but pick from
nr_running > 1 cpus first, then nr_running == 1 cpus if not found.
