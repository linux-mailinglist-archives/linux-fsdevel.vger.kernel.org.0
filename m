Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 581FB10FAF7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 10:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLCJpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 04:45:52 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:45428 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLCJpw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:45:52 -0500
Received: by mail-lj1-f181.google.com with SMTP id d20so2950428ljc.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2019 01:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neTWFwuJR4Jukr2kV185rqamwxRtM5mkOfSfynGkp0Q=;
        b=xTItXRhlAS9cxWUEh9q8wXyZXw8qmon9lBOU+YKk3+jsr5zYrJpuOg82lsWCWE9x9X
         5ADlxer0aiEW2iYzfNSLNiOj63PrR3F1nhK2PdD9hq2kxZiTHUou7Za4v3ekOJ7tCxNy
         uRMpB5tImy3zbNIFsWsk4L7/gH0FrKa1N+yCJoJNBcz+PC4S+b23G+oB15oopcBSChz8
         vw7VojQo7xfiSfrnHHarbkiSjhP5VOgbvWWWTzDRZWe8vebQavuihtriA4mlUGNONjmQ
         +H1/t6RNLmdxVGu0iujLQM/DXgUOSvnjT5FObcWKUE4m/qL+FYOTUVsV0EepEalnzDnn
         /Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neTWFwuJR4Jukr2kV185rqamwxRtM5mkOfSfynGkp0Q=;
        b=rs+zJPrdHlO1kj7Bb0HLy24u6JuTlV0zK2X6NEekm+JGxE1W77cBwktnbQU+z8EAz4
         V3Kn5WAZTSgmW0d8V52RodLth9hYLbJ7xXM4u80ys/FbvaA8DVGdr7KyFp4yfi2vXK5j
         QBBpGqDf8Lbjdtif989SkLvLDJzIX4Rpf0V+UDebrcXtcCPZRxyNTWl6uEPPglkybH+f
         +9/xYP0uQjv1oq6Jo+Zo96HYat4n6XnSBxKVvACWZ4rlNG5ED+oUWvNq7iH7Ym0CYPh7
         Y3GU5tVHj9JigTR1pEYohF9Ebo93P29MVKfaR1fWT/sywaPouxONhrduXsxK/vm+Elhz
         d7Bg==
X-Gm-Message-State: APjAAAW+sfPvxCWMzZeLJbdYe03/VE6mTkFLyyXf2Qhkha/+WsaTvytE
        zxlC+MR4EtXuUoB9U1fivJhk32DRDZcWv/RZWFL/2A==
X-Google-Smtp-Source: APXvYqxO6Zl+Be503YP0jAYAavrPaOI2DIRf25Dn1MebkTGcAo5eS2qEtOQyNDnZeVQ/ba9f3n7gueV/EICnAEhnbiU=
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr1372846ljj.206.1575366350405;
 Tue, 03 Dec 2019 01:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20191114113153.GB4213@ming.t460p> <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p> <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p> <20191128094003.752-1-hdanton@sina.com>
 <CAKfTPtA23ErKGCEJVmg6vk-QoufkiUM3NbXd31mZmKnuwbTkFw@mail.gmail.com>
 <20191202024625.GD24512@ming.t460p> <20191202040256.GE2695@dread.disaster.area>
 <CAKfTPtD8Q97qJ_+hdCXQRt=gy7k96XrhnFmGYP1G88YSFW0vNA@mail.gmail.com> <20191202212210.GA32767@lorien.usersys.redhat.com>
In-Reply-To: <20191202212210.GA32767@lorien.usersys.redhat.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 3 Dec 2019 10:45:38 +0100
Message-ID: <CAKfTPtC7uycC3b2ngOFUqOh9-Fcz7h-151aaYJbLJFXrNq-gkw@mail.gmail.com>
Subject: Re: single aio thread is migrated crazily by scheduler
To:     Phil Auld <pauld@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>, Ming Lei <ming.lei@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Rong Chen <rong.a.chen@intel.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2 Dec 2019 at 22:22, Phil Auld <pauld@redhat.com> wrote:
>
> Hi Vincent,
>
> On Mon, Dec 02, 2019 at 02:45:42PM +0100 Vincent Guittot wrote:
> > On Mon, 2 Dec 2019 at 05:02, Dave Chinner <david@fromorbit.com> wrote:
>
> ...
>
> > > So, we can fiddle with workqueues, but it doesn't address the
> > > underlying issue that the scheduler appears to be migrating
> > > non-bound tasks off a busy CPU too easily....
> >
> > The root cause of the problem is that the sched_wakeup_granularity_ns
> > is in the same range or higher than load balance period. As Peter
> > explained, This make the kworker waiting for the CPU for several load
> > period and a transient unbalanced state becomes a stable one that the
> > scheduler to fix. With default value, the scheduler doesn't try to
> > migrate any task.
>
> There are actually two issues here.   With the high wakeup granularity
> we get the user task actively migrated. This causes the significant
> performance hit Ming was showing. With the fast wakeup_granularity
> (or smaller IOs - 512 instead of 4k) we get, instead, the user task
> migrated at wakeup to a new CPU for every IO completion.

Ok, I haven't noticed that this one was a problem too. Do we have perf
regression ?

>
> This is the 11k migrations per sec doing 11k iops.  In this test it
> is not by itself causing the measured performance issue. It generally
> flips back and forth between 2 cpus for large periods. I think it is
> crossing cache boundaries at times (but I have not looked closely
> at the traces compared to the topology, yet).

At task wake up, scheduler compares local and previous CPU to decide
where to place the task and will then try to find an idle one which
shares cache so I don't expect that it will cross cache boundary as
local and previous are in your case.

>
> The active balances are what really hurts in thie case but I agree
> that seems to be a tuning problem.
>
>
> Cheers,
> Phil
>
>
> >
> > Then, I agree that having an ack close to the request makes sense but
> > forcing it on the exact same CPU is too restrictive IMO. Being able to
> > use another CPU on the same core should not harm the performance and
> > may even improve it. And that may still be the case while CPUs share
> > their cache.
> >
> > >
> > > -Dave.
> > >
> > > [*] Pay attention to the WQ_POWER_EFFICIENT definition for a work
> > > queue: it's designed for interrupt routines that defer work via work
> > > queues to avoid doing work on otherwise idle CPUs. It does this by
> > > turning the per-cpu wq into an unbound wq so that work gets
> > > scheduled on a non-idle CPUs in preference to the local idle CPU
> > > which can then remain in low power states.
> > >
> > > That's the exact opposite of what using WQ_UNBOUND ends up doing in
> > > this IO completion context: it pushes the work out over idle CPUs
> > > rather than keeping them confined on the already busy CPUs where CPU
> > > affinity allows the work to be done quickly. So while WQ_UNBOUND
> > > avoids the user task being migrated frequently, it results in the
> > > work being spread around many more CPUs and we burn more power to do
> > > the same work.
> > >
> > > --
> > > Dave Chinner
> > > david@fromorbit.com
> >
>
> --
>
