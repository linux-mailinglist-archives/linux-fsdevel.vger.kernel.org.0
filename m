Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DCA346427
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 16:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhCWP66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 11:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbhCWP6p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:58:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B747C061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 08:58:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b9so21315757wrt.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cyK9GwZbrXgU/Gi6qb7KmMrpgs6Gz19VbNc5ko69Bxg=;
        b=QvHJQk94nhdpZIpLpS8pC7Tlh0fNSviZlXkMnUDJKnNPuSmdT6Q+5JXnCTk/6GI3x/
         vgmZ6p64/5ZcKERKyFRdvkxyoLLKOl1ZRnvEUNfdOACvF02pdG+9o4e3lCAEN478L50/
         YQ8o+/ZOBCMbihsgK+Kk2CHOV6Tzff9UI6A/vYu9iA23C2CdEBbuyhjXmMk9Q7vYLzD/
         Yv3O/dqNSVLC3aVA4AYGW6Xg89krtqa3y0DAVsDPHVY81I5JxbHeizOlDIYe3CkUWPZx
         kTHQaUiZifKwn4OiJW/QSzkWIIJwEh8BFeVvares8RwnCT+ZVc/KDbWpy32VLn2vrwM4
         FAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cyK9GwZbrXgU/Gi6qb7KmMrpgs6Gz19VbNc5ko69Bxg=;
        b=MG9pmU83Y/fwq3i4tu4KN5jHsnfM9W69R4YL9lR1Y8GMrfHbXbDFZyYVQFJtNEZK+U
         uytPGAqidgvyuxhshAksD/l5i6D9JhA0Sme0J0wiZs5q/aGEdvGdLRULxCm46qFqqPBn
         E4QqFR+9htpUMP7qyDGxLkbrUmIWeyz6ppEyMRUA459+ME2y5e36A1dGMmwMOHXzpEAt
         IdgmpEJ1HemNIwOLnx68kq7ewV4qIX/EXpa8YqSmoBYVXWTwxVRPW3XfkOb1mjQqywBn
         RARetpbMa34CKxxGaBRbtlTTPEIQIDcX5GZ2J+sFUt9NMfeAquHIVPwLl2nK1hBuOar0
         t8kQ==
X-Gm-Message-State: AOAM5334RwfiOrYAG/CC3v6DJx+ffkyRbzPDswwp0xhLcfykeLu/+1Gv
        hLUcDWmtfh+iA6/LlAWdJmfFOA==
X-Google-Smtp-Source: ABdhPJz8cnWW2wVZ8muoCssomvubYn8mNfgOqi/4zhknz6k8122Olf0TUYv2Djj79RY0e51HmPKViA==
X-Received: by 2002:adf:dc91:: with SMTP id r17mr4692370wrj.293.1616515124001;
        Tue, 23 Mar 2021 08:58:44 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:4cfd:1405:ab5d:85f8])
        by smtp.gmail.com with ESMTPSA id t20sm3076962wmi.15.2021.03.23.08.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 08:58:43 -0700 (PDT)
Date:   Tue, 23 Mar 2021 16:58:37 +0100
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, glider@google.com,
        viro@zeniv.linux.org.uk, arnd@arndb.de, christian@brauner.io,
        dvyukov@google.com, jannh@google.com, axboe@kernel.dk,
        mascasa@google.com, pcc@google.com, irogers@google.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 8/8] selftests/perf: Add kselftest for
 remove_on_exec
Message-ID: <YFoQLfsZXPn9zuT4@elver.google.com>
References: <20210310104139.679618-1-elver@google.com>
 <20210310104139.679618-9-elver@google.com>
 <YFiamKX+xYH2HJ4E@elver.google.com>
 <YFjI5qU0z3Q7J/jF@hirez.programming.kicks-ass.net>
 <YFm6aakSRlF2nWtu@elver.google.com>
 <YFnDo7dczjDzLP68@hirez.programming.kicks-ass.net>
 <YFn/I3aKF+TOjGcl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFn/I3aKF+TOjGcl@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 03:45PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 23, 2021 at 11:32:03AM +0100, Peter Zijlstra wrote:
> > And at that point there's very little value in still using
> > perf_event_exit_event()... let me see if there's something to be done
> > about that.
> 
> I ended up with something like the below. Which then simplifies
> remove_on_exec() to:
> 
[...]
> 
> Very lightly tested with that {1..1000} thing.
> 
> ---
> 
> Subject: perf: Rework perf_event_exit_event()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Mar 23 15:16:06 CET 2021
> 
> Make perf_event_exit_event() more robust, such that we can use it from
> other contexts. Specifically the up and coming remove_on_exec.
> 
> For this to work we need to address a few issues. Remove_on_exec will
> not destroy the entire context, so we cannot rely on TASK_TOMBSTONE to
> disable event_function_call() and we thus have to use
> perf_remove_from_context().
> 
> When using perf_remove_from_context(), there's two races to consider.
> The first is against close(), where we can have concurrent tear-down
> of the event. The second is against child_list iteration, which should
> not find a half baked event.
> 
> To address this, teach perf_remove_from_context() to special case
> !ctx->is_active and about DETACH_CHILD.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Very nice, thanks! It seems to all hold up to testing as well.

Unless you already have this on some branch somewhere, I'll prepend it
to the series for now. I'll test some more and try to get v3 out
tomorrow.

Thanks,
-- Marco
