Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D82485A38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 21:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244205AbiAEUrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 15:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244199AbiAEUrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:47:17 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D544FC061201
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jan 2022 12:47:16 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id y130so1375491ybe.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 12:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02ZgXw9c8JzN01gaCGL5VWnFGMxpZF7MLVMkLIy8DNw=;
        b=sjXRrMchZskclkiP4hn18BKjFfN22i1Hpi02tLuMaEcmL+dWrh9T+MqmeGFJxewbZV
         Cp+C6NSEtfwlsmG/dbAVAx2yMl95m9sPeGJo376C4aQwylNlpfk9WYyYngF7mfHPfK0P
         vWRtySS9ZEO8x59S9+n7IjpmuDag2dH5FdW/LJcD4K1mGXyexhbsZb7/xU+Jj0duScdc
         F5HoCoPEx+iujoc10LOC/qqH/GlX0eD3wSzxN++Wrt44IjfjhmKhV4QPQDjzDjDwS5G9
         csjMqbdUOHfwezAvb5E/WobQBG8k9Bnflx9X/Kq4XHYivHSAqTxp+INWEEfST5ZVQgP4
         ZkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02ZgXw9c8JzN01gaCGL5VWnFGMxpZF7MLVMkLIy8DNw=;
        b=fnJSopukf/X1uzOsW2DgWKGCv/HvnTt/7pUW/mWUhMMCScgbsdaxKP1tdG+2xRLQPr
         XkGBAwgGY4+kXg9cUWx/P75cu0IciqXKKKcSpgJfTuXia/8Vj/3xyE1kIY97fIl8Ewgu
         bYrnckcVhdpLwdF5nQGM9us/KumhB/Cd1XA29AID15iSXF39cdomfOWCWiMWX5xvcoUF
         ETpQY/6425JTz9QQqjNXoC5pTVMResbIZJNIQCPswvfs0eDxLlmLe4EMCf8S1ZIK1vUO
         SsLIWVWC+eJ5TntTj9eF4nutIC96o0YR7H/xizsYumLHnF+i0w0y4GBK7aExj96QjLqL
         7Xdg==
X-Gm-Message-State: AOAM530U/wwoH3lgYzj2V5PoT0YcEzuKUPZQOsohXeMFncyL5TVx4xdF
        wEf+2E3qUiY7/YRASaJE20iyuNE6iVjKd2gSOdh/Iw==
X-Google-Smtp-Source: ABdhPJyu2QAwdw8PEqEXDvKhFBnziLwhifsBxZiV/LYEOBnlKms2rVNNYSjY4xNGH1LDNHhy1TqlR1iK1DIv7oTr3hI=
X-Received: by 2002:a25:2e0a:: with SMTP id u10mr47560940ybu.246.1641415635828;
 Wed, 05 Jan 2022 12:47:15 -0800 (PST)
MIME-Version: 1.0
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1640262603-19339-2-git-send-email-CruzZhao@linux.alibaba.com>
 <CABk29NvPJ3S1xq5xm+52OoUGDyuMSxGOLJbopPa3+-QmLnVYeQ@mail.gmail.com> <b02204ea-0683-2879-5843-4cfb31d44d27@linux.alibaba.com>
In-Reply-To: <b02204ea-0683-2879-5843-4cfb31d44d27@linux.alibaba.com>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 5 Jan 2022 12:47:05 -0800
Message-ID: <CABk29Nts4sysjmRcnZ_DWmMzhUrianp55Zgf-Nod8m+aUKiWeA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/core: Cookied forceidle accounting per cpu
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
> Firstly, attributing forced idle time to the specific cpus it happens on
> can help us measure the effect of steal_cookie_task(). We found out that
> steal_cookie_task() conflicts with load balance sometimes, for example,
> a cookie'd task is stolen by steal_cookie_task(), but it'll be migrated
> to another core by load balance soon.

I don't see how this is very helpful for steal_cookie_task(), since it
isn't a targeted metric for that specific case. If you were interested
in that specifically, I'd think you'd want to look at more direct
metrics, such as task migration counts, or adding some
accounting/histogram for the time between steal and load balance away.

> Secondly, a more convenient way of
> summing forced idle instead of iterating cookie'd task is indeed what we
> need. In the multi-rent scenario, it'll be complex to maintain the list
> of cookie'd task and it'll cost a lot to iterate it.

That motivation makes more sense to me. Have you considered
accumulating this at the cgroup level (ie. attributing it as another
type of usage)?
