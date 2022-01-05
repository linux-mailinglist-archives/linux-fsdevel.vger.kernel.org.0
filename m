Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19CD485A5B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 21:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244292AbiAEU7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 15:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244281AbiAEU7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:59:39 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B72C061201
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jan 2022 12:59:39 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id j83so1554265ybg.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 12:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHN3V6rGFAjZqTE98LW5j/OdiBYr+BnRu7fESXZdXAA=;
        b=EOujwg7Lt+M9kKd1CpYMP2JmoSUOjGqKaNI2ystvZP6dwPdkHzORlbzs+lHMYq3jaX
         pqf5d9NYuhfKacE6PY5RFB50uONfUWdXocEF/qMzzQ0Ru4mJ87LJd2XsnWLsYd4i0qTh
         uSRlzGKkV0el1/OB3OoTDO8rn5H3w5j8Oca4AyzXGjhVslDcuPK1Osj2tno4CMZ4oy61
         AZVebq/fB8ZOg+2QV+u3cWcpBHG4cr/At58SnkiYt9j8cI3i+uRhRQIXyUUJdYuqdVYf
         9ttIuzanlWDLkFQjCcMWtbUpSiLKV1gCaG+wsCYx03cfBa1q8i33eOWAJznKXquCHmwe
         hREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHN3V6rGFAjZqTE98LW5j/OdiBYr+BnRu7fESXZdXAA=;
        b=VilDBAWmmHH3CqhgmJSbtRe/4wLnvnpdV5GzGMuAa7SHYRwcZ15msL5VnR/JIgeEZL
         mdAQXFW6AeMI7hmx41l4hBFRumwTRPYeY0tGOF/fxMrwViQ/3h4drXto4aS/KPeDGT4T
         ikPtohmqP+fQGA9iV9NHKqKJi8RmZYF/j1iGngek4PQIGcGVdFq6VV+4JKkNY5MUyd3v
         jr7KnjtiMZwfS1fIeeUnUMLmUhD/cM+J7ucP5LDOipU8TfGgeAUNy7nN3DyKi4nRJPPq
         K1WEdLm1zdp9Ps3zedypNDZKcyypH5uOyqHP/bCIJ4/B432vuvAHthvcOM+kmdNFkNHB
         0xJQ==
X-Gm-Message-State: AOAM5335pln9KR0cLvmPShziHssd8X5Je5KIgks051NlFCZfvH0/2ekX
        g4lY+5k4AmRG1cvABoDDL1Q3pT1ZjNThG1vkrV1gxw==
X-Google-Smtp-Source: ABdhPJww6RfBJZ1OKyIA8XTeoEexUQa1i441gxVOC4qmLVDlvmiHO7KjnA1/srQdLczQ+qS2nbQklUv4hhEW/ZnfRL4=
X-Received: by 2002:a25:90e:: with SMTP id 14mr53975180ybj.430.1641416378297;
 Wed, 05 Jan 2022 12:59:38 -0800 (PST)
MIME-Version: 1.0
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1640262603-19339-3-git-send-email-CruzZhao@linux.alibaba.com>
 <CABk29NsP+sMQPRwS2e3zoeBsX1+p2aevFFO+i9GdB5VQ0ujEbA@mail.gmail.com> <8be4679f-632b-97e5-9e48-1e1a37727ddf@linux.alibaba.com>
In-Reply-To: <8be4679f-632b-97e5-9e48-1e1a37727ddf@linux.alibaba.com>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 5 Jan 2022 12:59:27 -0800
Message-ID: <CABk29Nv4OXnNz5-ZdYmAE8o0YpmhkbH=GooksaKYY7n0YYUQxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/core: Uncookied force idle accounting per cpu
To:     cruzzhao <cruzzhao@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 5, 2022 at 3:33 AM cruzzhao <cruzzhao@linux.alibaba.com> wrote:
>
> When we care about capacity loss, we care about all but not some of it.
> The forced idle time from uncookie'd task is actually caused by the
> cookie'd task in runqueue indirectly, and it's more accurate to measure
> the capacity loss with the sum of cookie'd forced idle time and
> uncookie'd forced idle time, as far as I'm concerned.
>
> Assuming cpu x and cpu y are a pair of smt siblings, consider the
> following scenarios:
> 1. There's a cookie'd task A running on cpu x, and there're 4 uncookie'd
> tasks B~E running on cpu y. For cpu x, there will be 80% forced idle
> time(from uncookie'd task); for cpu y, there will be 20% forced idle
> time(from cookie'd task).
> 2. There's a uncookie'd task A running on cpu x, and there're 4 cookie'd
> tasks B~E running on cpu y. For cpu x, there will be 80% forced idle
> time(from cookie'd task); for cpu y, there will be 20% forced idle
> time(from uncookie'd task).
> The scenario1 can recurrent by stress-ng(scenario2 can recurrent similary):
> (cookie'd)taskset -c x stress-ng -c 1 -l 100
> (uncookie'd)taskset -c y stress-ng -c 4 -l 100
>
> In the above two scenarios, the capacity loss is 1 cpu, but in
> scenario1, the cookie'd forced idle time tells us 20%cpu loss, in
> scenario2, the cookie'd forced idle time tells us 80% forced idle time,
> which are not accurate. It'll be more accurate with the sum of cookie'd
> forced idle time and uncookie'd forced idle time.

Why do you need this separated out into two fields then? Could we just
combine the uncookie'd and cookie'd forced idle into a single sum?

IMO it is fine to account the forced idle from uncookie'd tasks, but
we should then also change the task accounting to do the same, for
consistency.
