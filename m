Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504F23EAC51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhHLVSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbhHLVSG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:18:06 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94488C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 14:17:40 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id c5so1505511ybn.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 14:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qu4o1I3M93sE2VQo23LV2q9+zdykxwyzqA6gaNwHTrI=;
        b=i/PhwSlyEhJT2UabSNF83lq62QeMBSsMxN6A0Yg6nBYpbIQjPLcryqJxIu8F/j+arL
         908AAxSUErr8HfkLu/k8CFHrf9uKiNIpLHhC+DGGCS0Jvo/F8EXvAtkhNU5PgWN/fU4J
         Ghw/NXvY6jdU1jE2jxLFAElr2t5rthjtNHJfbl0BdFAk+nI0Z8hBQcgCU1QlSK5AbOff
         rncyyiFXGlFtP1r0NUlcdoRmB4AyVUi/9HhKh69QDa6iVSMkmbKVjubKjh8+NjW9simV
         7M4WVVGxBRgvgC45QXklnsV6ZahDdgtOGWjAP7XAs6kubf2Sv+KB7sw4xtMfBlDOpHoa
         eNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qu4o1I3M93sE2VQo23LV2q9+zdykxwyzqA6gaNwHTrI=;
        b=sbXbtz2M5M9Qr2nHb+T9kHN3fBFDaVNZj2gMLXnDZWo0eDEcHrg2V01hhbvSIRgTYV
         jMoB0skZqSbwF/lVlmtqA6l4FWX7ZFJAORSfCwYD9JiyXCroJQ2O2FoX3G+9yl3BrTF9
         mxTmnUZ4opy9h6E/e8q8kj/Ysthu7VpW20DjQ1jKS8y3idWVztYFnCLR0mNtP05KL6p4
         NB/in7gEEMlSiVznHdQcgAvQ3H7/L0ogt3WQSBW5E+XA5+M7rOjoZh/gCeHa+WivRHXx
         mgR3AdoXJWu47gImCT4IQGE1KKadA4rARuCUBNK6JxkPkrfakXvs7opDzE39iSCFcVYX
         dj1A==
X-Gm-Message-State: AOAM533lIcaIJm347TyAEkByFdWfUlIHs+qMHrrXN2oNLfOq5OHzIDyw
        dAaTUMIhs5omT55EIazxJA+F8prwr8Ar2N4LtZnYqw==
X-Google-Smtp-Source: ABdhPJzhjW6JGTAG2LHjmzp5sLnLJ3Z+oNhMZtVIBPHA3soyn7xJBgUxbF6q9p6kfwwWrVB5fZdWKRF1R+YvnHwCqQU=
X-Received: by 2002:a5b:d45:: with SMTP id f5mr6990079ybr.179.1628803059559;
 Thu, 12 Aug 2021 14:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210812203137.2880834-1-joshdon@google.com> <CANn89iJK-PzFrN2S_jojN2rvZBfBJY4cLTg6q+uzF-vcrfrAeQ@mail.gmail.com>
In-Reply-To: <CANn89iJK-PzFrN2S_jojN2rvZBfBJY4cLTg6q+uzF-vcrfrAeQ@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 12 Aug 2021 14:17:28 -0700
Message-ID: <CABk29NuoSxJnVb8jdGB6n=zM9fxF4=kU9oAU-a37Mz5h+zS7vA@mail.gmail.com>
Subject: Re: [PATCH] fs/proc/uptime.c: fix idle time reporting in /proc/uptime
To:     Eric Dumazet <edumazet@google.com>
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

On Thu, Aug 12, 2021 at 1:42 PM Eric Dumazet <edumazet@google.com> wrote:
>
> Not sure why you moved get_idle_time() in kernel/sched/cputime.c
>
> For builds where CONFIG_PROC_FS is not set, this function is not used/needed.

Consolidate the kernel idle accounting code; seemed a little strange
to have this implemented in proc/stat.c, especially if it also needed
to be used elsewhere.

Does a __maybe_unused/#ifdef CONFIG_PROC_FS seem reasonable, or would
you advocate leaving it in fs/proc?
