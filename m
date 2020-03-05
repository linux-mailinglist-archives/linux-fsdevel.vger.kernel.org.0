Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A350F17ADD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 19:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgCESH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 13:07:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51098 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCESH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:07:28 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j9utt-0002uN-Ug; Thu, 05 Mar 2020 19:07:14 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 2546210408A; Thu,  5 Mar 2020 19:07:13 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>, Xi Wang <xii@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Paul Turner <pjt@google.com>
Subject: Re: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
In-Reply-To: <20200305075742.GR2596@hirez.programming.kicks-ass.net>
References: <20200304213941.112303-1-xii@google.com> <20200305075742.GR2596@hirez.programming.kicks-ass.net>
Date:   Thu, 05 Mar 2020 19:07:13 +0100
Message-ID: <87blpad6b2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Mar 04, 2020 at 01:39:41PM -0800, Xi Wang wrote:
>> The main purpose of kernel watchdog is to test whether scheduler can
>> still schedule tasks on a cpu. In order to reduce latency from
>> periodically invoking watchdog reset in thread context, we can simply
>> touch watchdog from pick_next_task in scheduler. Compared to actually
>> resetting watchdog from cpu stop / migration threads, we lose coverage
>> on: a migration thread actually get picked and we actually context
>> switch to the migration thread. Both steps are heavily protected by
>> kernel locks and unlikely to silently fail. Thus the change would
>> provide the same level of protection with less overhead.
>> 
>> The new way vs the old way to touch the watchdogs is configurable
>> from:
>> 
>> /proc/sys/kernel/watchdog_touch_in_thread_interval
>> 
>> The value means:
>> 0: Always touch watchdog from pick_next_task
>> 1: Always touch watchdog from migration thread
>> N (N>0): Touch watchdog from migration thread once in every N
>>          invocations, and touch watchdog from pick_next_task for
>>          other invocations.
>> 
>
> This is configurable madness. What are we really trying to do here?

Create yet another knob which will be advertised in random web blogs to
solve all problems of the world and some more. Like the one which got
silently turned into a NOOP ~10 years ago :)


