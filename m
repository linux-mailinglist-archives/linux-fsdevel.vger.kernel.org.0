Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FCB3FA138
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 23:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhH0Vlx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 17:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhH0Vlw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 17:41:52 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BE3C061796
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 14:41:03 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id o204so5148490ybg.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ELnHnxXQ3QKSTdHlPecFhJXpaQDWJHo6ZXwtcu8mbA=;
        b=Gakvhq/oe6wU40pIbOYYGPVeL5YgWg0l54zjb5tE81IMBOtnBqEEVvNmMDgEXYWo13
         71KoElCe/ZiIC6qzbwxH94bercCT1Jg1oXjMo3KNJVVP2oHS5yV+fnZkUPWckJ/KB0l8
         piME4THWlyVVM82Bivlb+Ig7+TRnsDFuY5pEUZqDUtkaiboEM+FXMdoMlyyQzXhlZ/Ad
         bDRDHWvsmSgQhGQnqqd39pgtB+zAVrYv6kYBzBgZuDkHtRjJVc9qDnZy3FfhjOdLLBs3
         2p/Qiesaw2WmneOZ0IomHmDanONP1LsTtw8N8rqLjk/KT35TpWeQlLzRJorcHhn21a8M
         W1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ELnHnxXQ3QKSTdHlPecFhJXpaQDWJHo6ZXwtcu8mbA=;
        b=gSRaWPC6d+gwQF4JnPZC4Od/Tbpsub+OSyjyF1lBHnGozPRSF1OLT27aJck5kWK618
         uVvDiz7VP1ocaurN5S/5dXfElh/HgKUGv0742asmEP6mT5w1zgNUacw5UgYEC0enAYny
         YU1FvijhfsFKAcs9dR4RD33Jz3P3LP0RN24UYHuyjK9sXk48uQ4WBB/S5nTbPv/vHPES
         r6UONsI6+5yPJ9h0T5/Lke/jE7Z5AksavMBmLBH1OQs2qxasbNM4RCBDmedE56brsU+N
         Zdvussv7Tr2uVSKfXEj/7qm5YqfnkK73lDVR71qtBtiFZBCOTAdewLlDEEjn7AJrYd2c
         IgZQ==
X-Gm-Message-State: AOAM530/Bl3Mi+3rAcdn+GF3Lkr5HwlChGXe2HpmjHfUDqcwZb3ENUA+
        H4eT1RcnuUHgLJE0qy7fSLWI59u54xEs70FU48z5WQ==
X-Google-Smtp-Source: ABdhPJy5n7jbk99nqbGBpad3XSf1FlO1SZfJHp1ei/llIwEUOHBR8CcP6NEx4ig0dovWgxsj5xRd9Lts7rsQ36dLWx0=
X-Received: by 2002:a25:e747:: with SMTP id e68mr7919019ybh.446.1630100462006;
 Fri, 27 Aug 2021 14:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210827165438.3280779-1-joshdon@google.com>
In-Reply-To: <20210827165438.3280779-1-joshdon@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 27 Aug 2021 14:40:50 -0700
Message-ID: <CANn89iJV+VUgS5mBmtN6An83pRS4LU61efw=VLBvM1_FGYCN5A@mail.gmail.com>
Subject: Re: [PATCH v2] fs/proc/uptime.c: fix idle time reporting in /proc/uptime
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 9:55 AM Josh Don <joshdon@google.com> wrote:
>
> /proc/uptime reports idle time by reading the CPUTIME_IDLE field from
> the per-cpu kcpustats. However, on NO_HZ systems, idle time is not
> continually updated on idle cpus, leading this value to appear
> incorrectly small.
>
> /proc/stat performs an accounting update when reading idle time; we can
> use the same approach for uptime.
>
> With this patch, /proc/stat and /proc/uptime now agree on idle time.
> Additionally, the following shows idle time tick up consistently on an
> idle machine:
> (while true; do cat /proc/uptime; sleep 1; done) | awk '{print $2-prev; prev=$2}'
>
> Reported-by: Luigi Rizzo <lrizzo@google.com>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>

SGTM thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>
