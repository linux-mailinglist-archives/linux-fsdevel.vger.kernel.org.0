Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6417B0D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 22:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgCEVls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 16:41:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41514 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgCEVls (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:41:48 -0500
Received: by mail-ot1-f65.google.com with SMTP id v19so398421ote.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2020 13:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=zTMkBqRXWtuag7VWknouHi7tC0angRdQ/CUfF///Ayk=;
        b=eA/Llucrfq6/R2bMv5UhSMiYGd+gfzDkRFfX5g4+2rcLY7U37DCNU5nY4guXfC0tvb
         gG5ySIDiNSzzx7DdhKLvQAM/bdqRKUbo11GYW4LMPNmItNEIZNOSgPQj7BSCeK3/fFVs
         3AZgJxVPgDXjlf8rKJ2nsewjfa9OavSRyg+cRPfoDsTjNiBhfjDZlfsL4CMwMOD6Kfrh
         DiLGZj2SS4BfC8G3XfH+ZrNwtzH5L7513jWInfFAafSTksVWMqnhcae+hpR01BO0ndiJ
         DaWeWQpN+SLQipoOUYaBoUJAGWTgDhHEh8cx8hMPJShUqAUtkfwEsWzklgBz+ufwkXGH
         UFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=zTMkBqRXWtuag7VWknouHi7tC0angRdQ/CUfF///Ayk=;
        b=pEf0Seij36vyupVP6b0/jZm/uneQDKy2vVSbMArmGBHrK9OXdGp0yRRW2SVmAgz4II
         O/41+vwkHMaNxKJ7ueDyNAHeKjUxKPY9UqhJ7Sx3MZYOpsxyRHJekq3prXv2szFeoS6R
         FpWkNbVLruMpHTD4OP8lmPhgO+H6G8L5sK37TXkgvpeCDDWNAmEFAKYHzZ+pLSsWQB7Q
         5FZfn/1Xdu54n+9lWImcdiGC1TiFzzMEQh5EEx8yTqDgA8xNpaTSr/QOl3Jg7C574G55
         R2e63/SrPlukLUN8PaqGQrDrd01yVVpNGxarajYnJpd1lrG8FWS53tW2OQLmB9tkOz4c
         mQzw==
X-Gm-Message-State: ANhLgQ0nQdBekCPCMfZ56+Zjp1oxVkWuWWZ9QCfLIe8AbgbuKpzk1OSu
        U8+35pat8epSrpnPqspCUW+Um02ufUrJy/TkOo6WkA==
X-Received: by 2002:a9d:7c85:: with SMTP id q5mt438829otn.341.1583444507323;
 Thu, 05 Mar 2020 13:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20200304213941.112303-1-xii@google.com> <20200305075742.GR2596@hirez.programming.kicks-ass.net>
 <87blpad6b2.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87blpad6b2.fsf@nanos.tec.linutronix.de>
From:   Xi Wang <xii@google.com>
Date:   Thu, 5 Mar 2020 13:41:36 -0800
Message-ID: <CAOBoifgTZ_h4MJv7-yJwrQ4jAYQtHfajxBCyZNJkerKko+e9nQ@mail.gmail.com>
Subject: Re: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Measuring jitter from a userspace busy loop showed a 4us peak was
flattened in the histogram (cascadelake). So the effect is likely
reducing overhead/jitter by 4us.

Code in resched_for_watchdog should be ok since it is always called
from the watchdog hrtimer function?

Why supporting the option to alternate between thread context and
touch in sched: Might be a little risky to completely switch to the
touch in sched method. Touch in sched for 9 out of 10 times still
captures most of the latency benefit. I can remove it or change it to
on/off if desired.

Advertising the knob on random blogs: Maybe I should create a blog :)

-Xi


On Thu, Mar 5, 2020 at 10:07 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Peter Zijlstra <peterz@infradead.org> writes:
>
> > On Wed, Mar 04, 2020 at 01:39:41PM -0800, Xi Wang wrote:
> >> The main purpose of kernel watchdog is to test whether scheduler can
> >> still schedule tasks on a cpu. In order to reduce latency from
> >> periodically invoking watchdog reset in thread context, we can simply
> >> touch watchdog from pick_next_task in scheduler. Compared to actually
> >> resetting watchdog from cpu stop / migration threads, we lose coverage
> >> on: a migration thread actually get picked and we actually context
> >> switch to the migration thread. Both steps are heavily protected by
> >> kernel locks and unlikely to silently fail. Thus the change would
> >> provide the same level of protection with less overhead.
> >>
> >> The new way vs the old way to touch the watchdogs is configurable
> >> from:
> >>
> >> /proc/sys/kernel/watchdog_touch_in_thread_interval
> >>
> >> The value means:
> >> 0: Always touch watchdog from pick_next_task
> >> 1: Always touch watchdog from migration thread
> >> N (N>0): Touch watchdog from migration thread once in every N
> >>          invocations, and touch watchdog from pick_next_task for
> >>          other invocations.
> >>
> >
> > This is configurable madness. What are we really trying to do here?
>
> Create yet another knob which will be advertised in random web blogs to
> solve all problems of the world and some more. Like the one which got
> silently turned into a NOOP ~10 years ago :)
>
>
