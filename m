Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5394A43F81A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 09:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhJ2Hv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 03:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhJ2Hvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 03:51:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEC2C061570
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 00:49:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g10so35346606edj.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 00:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjqTlAq/8atUNGknBengC56rv9Dz2YcbvxQpL6f31NE=;
        b=4NWQ97D8av1bcOmAuQzWks2cBvv6sEDFs9N8sqanD4uhWTidcfYo3hBwx+DyCNFz1K
         P4C+s2YWl0gtXhIEz4s/whnD2DqPHxtpemt8r9bU+0/beruJ6D0okHZ8gattocaYAXEv
         Zybb+4y2JNS6+rpvFo4Ectd4zS13QmraLGofH2mPNjDu9wd4ORTSd/6hT5VwdRxXkLxn
         F1ewJRoO/QNgJhKynXm88FBtssDG+yUlM9zauo+3ocX/ytwveSWrB/tl11tDpcdmyEHQ
         cxqna2wQ4HpL7O/dzDhj25Kv2djOE8/xDRnIPI1r/h0QlWADoXnouRt9Tdu3nKvKCxTs
         dQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjqTlAq/8atUNGknBengC56rv9Dz2YcbvxQpL6f31NE=;
        b=TnfjsjSR8MbRvZEXX/dTOgO3f7bv9vSjBd3BrSztTHF4M6LiijywHf6xcmAm0Lrly1
         YzFPjgPSUTaUUbW3fBPHnVUlHYKxFsUgH+afWJJbWy6d+BksY7X8memp3iAZPC/sL1sI
         9apyUmy4e/n3y5TxIZUEBxvzQO2KgmMK31qVoQerGux6u1xxIV2/gtdV9U0AWaT0k5DK
         kwwtluxzaa6VIgaMeqdfXfYB+2P/uH3o1dw1ECC7Vt74CTgqtrC9whXWqalB/oFHVhLc
         w17+rCqOkj4p6fZ8m8cHYpDhvaFGMHhMfgYO2cbKvqQoTGKBSym94z6WuNNSAMuIWPxD
         NaWQ==
X-Gm-Message-State: AOAM533IIONr78hlyF+jJBRXiqEr8vb+LtJYxNHavSRDk0Hrz3ekZVth
        HjGFinuVmVbz0pty/acj7eii0OyF1SF29Pzp1mY1AQ==
X-Google-Smtp-Source: ABdhPJwjitD9q7llnX4M3SYof8U1mUQbFwcD39eUp1B6VYUJIc75/H1aw9+QzCU4himzNKQr5lfz8Bq83cIf+yo39EY=
X-Received: by 2002:a17:906:c18c:: with SMTP id g12mr11994765ejz.458.1635493741880;
 Fri, 29 Oct 2021 00:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211027132633.86653-1-ligang.bdlg@bytedance.com> <20211028153028.GP3891@suse.de>
In-Reply-To: <20211028153028.GP3891@suse.de>
From:   =?UTF-8?B?5p2O5riv?= <ligang.bdlg@bytedance.com>
Date:   Fri, 29 Oct 2021 15:48:50 +0800
Message-ID: <CAMx52AR2h_RifrFPyu4WA3YDij9epuApOzG1zbH9F6pK4m7b9Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1] sched/numa: add per-process numa_balancing
To:     Mel Gorman <mgorman@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 28, 2021 at 11:30 PM Mel Gorman <mgorman@suse.de> wrote:
>
> That aside though, the configuration space could be better. It's possible
> to selectively disable NUMA balance but not selectively enable because
> prctl is disabled if global NUMA balancing is disabled. That could be
> somewhat achieved by having a default value for mm->numa_balancing based on
> whether the global numa balancing is disabled via command line or sysctl
> and enabling the static branch if prctl is used with an informational
> message. This is not the only potential solution but as it stands,
> there are odd semantic corner cases. For example, explicit enabling
> of NUMA balancing by prctl gets silently revoked if numa balancing is
> disabled via sysctl and prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING,
> 1) means nothing.

static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
{
    ...
    if (static_branch_unlikely(&sched_numa_balancing))
        task_tick_numa(rq, curr);
    ...
}

static void task_tick_numa(struct rq *rq, struct task_struct *curr)
{
    ...
    if (!READ_ONCE(curr->mm->numa_balancing))
        return;
    ...
}

When global numa_balancing is disabled, mm->numa_balancing is useless.
So I think
prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING,0/1) should return an
error instead of modifying mm->numa_balancing.

Is it reasonable that prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,0/1)
can still change the value of mm->numa_balancing when global numa_balancing is
disabled?
