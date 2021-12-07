Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2347F46B8B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 11:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhLGKYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 05:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhLGKYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:24:42 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A36EC061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 02:21:12 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id p37so25455942uae.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 02:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4sG/SOx5tu52e/2a0OpiHKkLpDXBGwNNoUVY5hcGbiU=;
        b=oAsT5UTKueZlViskq6nTTVFikXgjBm8SAhbk/OciE3iAlmqTq3ffLTzstIOKULNenD
         YB8dafhdoIH8qW32lGGd26xwaVeSBpsnMZKTU6IR5bhjpMlqSP8q5OL6adklSGpvAwso
         qKAVtW3vtdwGE6tBbYkxMRSlPA7pfjLrCr8SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4sG/SOx5tu52e/2a0OpiHKkLpDXBGwNNoUVY5hcGbiU=;
        b=U9Gy272evxgqUrAA/JVBslsyoBUvxTyvmZb3AFe8oKZFypU1Vi0kvsbqefEK3mII7U
         fan01/ot9YIEH5Bj0xl4qoJ1qTYCFlDZeL7APiY5kslIh69oj3XGBdKAhqcOIKRllWnv
         3cx2iWU5wQN1M4WAcbh/FTwSKGofwUGm2ugKO/ZtImp5TO8iNdVL3nP6Jj5pZil8bZpq
         BUf7Axbp7i3UIBEVXP4CDhRcnJz5xFmv7YDqmytZHeXp36yirn+lRkUNSHmzR/PvWACf
         neM7pawKysfzVDsIov+lsDoHVYYsZMluet/XGkbUfUo3HkbQrrC/9iYHpYwgoZrdmzEl
         8NZw==
X-Gm-Message-State: AOAM532xVRM9jTDLwNTFmdQmOgkT1KYrxHLkWx7F6RqKhEjkAiD5dLoy
        Jmpvy6qKgh7cSQW+2jeg3OJQlEf+5YZ9nTJqSIFbqA==
X-Google-Smtp-Source: ABdhPJy8k6FetKP4/kjU8He50+y1rs/uMkmYWqd+gRpbwQ3rqCeZjFh26rQWS5NBsudD63Pb2zgHIDez27f0T+cLd80=
X-Received: by 2002:a05:6102:c4e:: with SMTP id y14mr45353031vss.61.1638872470605;
 Tue, 07 Dec 2021 02:21:10 -0800 (PST)
MIME-Version: 1.0
References: <1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com>
 <CAJfpegvDfc9JUo6VASRyYXzj1=j3t6oU9W3QGWO08vhfWHf-UA@mail.gmail.com> <Ya8ycLODlcvLx4xB@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya8ycLODlcvLx4xB@hirez.programming.kicks-ass.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Dec 2021 11:20:59 +0100
Message-ID: <CAJfpegsVg2K0CvrPvXGSu=Jz_R3VZZOy49Jw51rThQUJ1_9e6g@mail.gmail.com>
Subject: Re: [PATCH V1] fuse: give wakeup hints to the scheduler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, quic_stummala@quicinc.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_sayalil@quicinc.com,
        quic_aiquny@quicinc.com, quic_zljing@quicinc.com,
        quic_blong@quicinc.com, quic_richardp@quicinc.com,
        quic_cdevired@quicinc.com,
        Pradeep P V K <quic_pragalla@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 7 Dec 2021 at 11:07, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Dec 07, 2021 at 10:07:45AM +0100, Miklos Szeredi wrote:
> > On Mon, 6 Dec 2021 at 09:47, Pradeep P V K <quic_pragalla@quicinc.com> wrote:
> > >
> > > The synchronous wakeup interface is available only for the
> > > interruptible wakeup. Add it for normal wakeup and use this
> > > synchronous wakeup interface to wakeup the userspace daemon.
> > > Scheduler can make use of this hint to find a better CPU for
> > > the waker task.
>
> That's a horrendoubly bad changelog :-/ Also, if you need it for
> UNINTERRUPTIBLE that's trivial to do ofc.
>
> > Ingo, Peter,
> >
> > What exactly does WF_SYNC do?   Does it try to give the waker's CPU
> > immediately to the waked?
> >
> > If that doesn't work (e.g. in this patch the wake up is done with a
> > spin lock held) does it do anything?
> >
> > Does it give a hint that the waked task should be scheduled on this
> > CPU at the next scheduling point?
>
> WF_SYNC is a hint to the scheduler that the waker is about to go sleep
> and as such it is reasonable to stack the woken thread on this CPU
> instead of going to find an idle CPU for it.
>
> Typically it also means that the waker and wakee share data, and thus
> having them share the CPU is beneficial for cache locality.

Okay, so it doesn't give up the CPU immediately to the woken task,
just marks the woken task as a "successor" when the current task goes
to sleep.  Right?

That may be good for fuse as the data is indeed shared.  It would be
even better if the woken task had already a known affinity to this
CPU, since that would mean thread local data wouldn't have to be
migrated each time...   So I'm not sure sync wakeup alone is worth it,
needs real life benchmarking.

Thanks,
Miklos
