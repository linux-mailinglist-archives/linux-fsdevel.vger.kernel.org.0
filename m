Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A673D6CCC41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjC1VtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjC1VtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:49:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40DA1B8;
        Tue, 28 Mar 2023 14:48:59 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680040137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x82kiQTdgOmZzPuRLld3tUQlZDNUyZj9dPSJErAcQnY=;
        b=Gxt8IPQX5DvhqpfTMWR6evLosGpzTLD8Aocv8NcJKFX/u4L9B2hzd6YcJuBCHr+QjbT4xg
        GX/0rz8525+SYZfgXmzm/Xzs02lvGvSJ85FzFeniPf6KusZVT8r2T9kbNOaFEMdZDnTTGH
        pytZ3/OWIQOwfSIRVaqNZvh7BQXm4hZPqFzcNtEJJoyyeShYh2nE8Vw3AETRPJFbtKdg5Q
        j+jfbc+vp+bjP4KYRqtzpaP1hcYDPdIInJn4sh1KMxOh1CwbAzSonrYp9Pp2zKs17WEXSW
        sNJyHtdPGV2YgNvcugWzxBMBnzX1H3EGdS5oStfL1MCdTgAgte52XjW5edywKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680040137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x82kiQTdgOmZzPuRLld3tUQlZDNUyZj9dPSJErAcQnY=;
        b=9lZBip3wqG2//KEJ8BNUvFFe4hNUifeJzz8jtjLtaJPLUWTVjcc5ASPGsvxtvB6iBP8Vjc
        D5hsgEXZJLswIVDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        David Gow <davidgow@google.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        tangmeng <tangmeng@uniontech.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: locking API: was: [PATCH printk v1 00/18] serial: 8250:
 implement non-BKL console
In-Reply-To: <ZCMDVKy1Ir0rvi5g@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <87wn3zsz5x.fsf@jogness.linutronix.de> <ZCLsuln0nHr7S9a5@alley>
 <87a5zxger3.fsf@jogness.linutronix.de> <ZCMDVKy1Ir0rvi5g@alley>
Date:   Tue, 28 Mar 2023 23:53:16 +0206
Message-ID: <87ilekmtuj.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-28, Petr Mladek <pmladek@suse.com> wrote:
>> If an atomic context loses ownership while doing certain activities,
>> it may need to re-acquire ownership in order to finish or cleanup
>> what it started.
>
> This sounds suspicious. If a console/writer context has lost the lock
> then all shared/locked resources might already be used by the new
> owner.

Correct.

> I would expect that the context could touch only non-shared resources
> after loosing the lock.

Correct.

> If it re-acquires the lock then the shared resource might be in
> another state. So, doing any further changes might be dangerous.

That is the responsibility of the driver to implement it safely if it is
needed.

> I could imagine that incrementing/decrementing some counter might
> make sense but setting some value sounds strange.

The 8250 driver must disable interrupts before writing to the TX
FIFO. After writing it re-enables the interrupts. However, it might be
the case that the interrupts were already disabled, in which case after
writing they are left disabled.

IOW, whatever context disabled the interrupts is the context that is
expected to re-enable them. This simple rule makes it really easy to
handle nested printing because a context is only concerned with
restoring the IER state that it originally saw.

Using counters or passing around interrupt re-enabling responsibility
would be considerably trickier.

>>> And why we need to reacquire it?
>> 
>> In this particular case the context has disabled interrupts. No other
>> context will re-enable interrupts because the driver is implemented
>> such that the one who disables is the one who enables. So this
>> context must re-acquire ownership in order to re-enable interrupts.
>
> My understanding is that the driver might lose the lock only
> during hostile takeover. Is it safe to re-enable interrupts
> in this case?

Your understanding is incorrect. If a more important outputting context
should arrive, the non-important outputting context will happily and
kindly handover to the higher priority. From the perspective of the
atomic console driver, it lost ownership.

Simple example: The kthread printer is printing and some WARN_ON() is
triggered on another CPU. The warning will be output at a higher
priority and print from the context/CPU of the WARN_ON(). The kthread
printer will lose its ownership by handing over to the warning CPU.

Note that we are _not_ talking about when the unsafe bit is set. We are
talking about a printer that owns the console, is in a safe section, and
loses ownership. If that context was the one that disabled interrupts,
it needs to re-acquire the console in order to safely re-enable the
interrupts. The context that tookover ownership saw that interrupts are
disabled and does _not_ re-enable them when it is finished printing.

John
