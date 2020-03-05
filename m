Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA8017B141
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 23:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgCEWM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 17:12:26 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35669 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgCEWM0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:12:26 -0500
Received: by mail-io1-f68.google.com with SMTP id h8so147365iob.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2020 14:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLO01LFdRSFqT4wIw42RwnApKJS//R7HNVPhSavIu5E=;
        b=lSOEVXpUwzFvtYV9lmGONQikqTAtuG6EdUXH5lWDTLve2DThE4B1xwkm9WSm76mNUr
         k5OHw4ZuGMBo7+b4+fVJKErhm5b91u/FFMCVf9hsgub8ILjTywxxIaF3nLWmilri1RFY
         bVOmmMwSmsD7otMDz2bROoDXi/a2zqW5FIa/YQGT3d4V4e2LZTKnx7pM+yqBTa7Fpd+Z
         ZkcqwlFl/2YWKTg6Cl008e9wMsm40T/Ul89O7qGJjK1mL/MNsn3HbqMCiQaLlTT/p3iN
         NeBiQ1ndS49Vo7LW2B7z81RGKHiC0SZ9VgYN3raQ5bld/JqDFAotR0FA9IooxwofPU6x
         cZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLO01LFdRSFqT4wIw42RwnApKJS//R7HNVPhSavIu5E=;
        b=eTAT5q/fRKEspcNhlo0mr15RO49hOr0JxGGffTFqkf4Pu2//PEvzLbbMZmdvCgRd/R
         Ig9W7UJNh9Di4NbfmlFtbPVb0317gwKwS9Xf0pldnacakubwce9QacVEUtoIRhWMa+48
         UbLBHQMaRF73UznRyHuOUTw5wCcQgEVcr+8rulfpNEnw7J71ey134Lup2RS/tgwiwt4U
         WGpHRn3rVnGGc2kvh3u6kUtuYmklJ+of6Jl4cYHsa7Y4nYofHugjFwye0oOp2lSiKwnh
         TaoHMeGJK/RQhwLP7txuf3V5jwdYa2DRq5FN06ZgXP1dbzoUk8Kv4yNRhR5CJiKDTftD
         d38w==
X-Gm-Message-State: ANhLgQ3O6eL13LP7gTCwJk+nORSAvpnDMvI27rJtXRKZL54TREdU+3O9
        654r0yWStJYEMp46mwgxNqHODJldslRENTWl+tl9iQ==
X-Google-Smtp-Source: ADFU+vtr8PA4SQjv1gXhZGUToTCIG22z8a7yUXMj8YNFxabC8mrUU/NGdHrPnu7HyImc63wibQZdJgkJs7O1TlkPbxQ=
X-Received: by 2002:a02:13ca:: with SMTP id 193mr58093jaz.54.1583446345383;
 Thu, 05 Mar 2020 14:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20200304213941.112303-1-xii@google.com> <20200305075742.GR2596@hirez.programming.kicks-ass.net>
In-Reply-To: <20200305075742.GR2596@hirez.programming.kicks-ass.net>
From:   Paul Turner <pjt@google.com>
Date:   Thu, 5 Mar 2020 14:11:49 -0800
Message-ID: <CAPM31RJdNtxmOi2eeRYFyvRKG9nofhqZfPgZGA5U7u8uZ2WXwA@mail.gmail.com>
Subject: Re: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Xi Wang <xii@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 4, 2020 at 11:57 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 04, 2020 at 01:39:41PM -0800, Xi Wang wrote:
> > The main purpose of kernel watchdog is to test whether scheduler can
> > still schedule tasks on a cpu. In order to reduce latency from
> > periodically invoking watchdog reset in thread context, we can simply
> > touch watchdog from pick_next_task in scheduler. Compared to actually
> > resetting watchdog from cpu stop / migration threads, we lose coverage
> > on: a migration thread actually get picked and we actually context
> > switch to the migration thread. Both steps are heavily protected by
> > kernel locks and unlikely to silently fail. Thus the change would
> > provide the same level of protection with less overhead.
> >
> > The new way vs the old way to touch the watchdogs is configurable
> > from:
> >
> > /proc/sys/kernel/watchdog_touch_in_thread_interval
> >
> > The value means:
> > 0: Always touch watchdog from pick_next_task
> > 1: Always touch watchdog from migration thread
> > N (N>0): Touch watchdog from migration thread once in every N
> >          invocations, and touch watchdog from pick_next_task for
> >          other invocations.
> >
>
> This is configurable madness. What are we really trying to do here?

See reply to Thomas, no config is actually required here.  Focusing on
the intended outcome:

The goal is to improve jitter since we're constantly periodically
preempting other classes to run the watchdog.   Even on a single CPU
this is measurable as jitter in the us range.  But, what increases the
motivation is this disruption has been recently magnified by CPU
"gifts" which require evicting the whole core when one of the siblings
schedules one of these watchdog threads.

The majority outcome being asserted here is that we could actually
exercise pick_next_task if required -- there are other potential
things this will catch, but they are much more braindead generally
speaking (e.g. a bug in pick_next_task itself).
