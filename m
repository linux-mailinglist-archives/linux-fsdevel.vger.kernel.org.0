Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652CF6CC526
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 17:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjC1PMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 11:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjC1PMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:12:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E94EEB78;
        Tue, 28 Mar 2023 08:12:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4BDAA1FD86;
        Tue, 28 Mar 2023 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680016215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J7qeg0GFz1ZJRgmxl9x8sxycF9AB5MggAXwN1oT3If0=;
        b=My/k51tQYydUiJotUmioUM5T7ItvWH7XNP/9KkTNuidF9vQbDg6SwA+Gl3FHdHaCrKhvBx
        wlXbU2mWUG4HP0pEoLhafKjLu8e0ysCc87/WRryaSqooRB5zj3Y+Q2yL6Xzy1L9HmPCOe/
        0VduxhGei5VgNRbmlG36gF1FvHubPOw=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A2E3A2C141;
        Tue, 28 Mar 2023 15:10:13 +0000 (UTC)
Date:   Tue, 28 Mar 2023 17:10:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
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
Message-ID: <ZCMDVKy1Ir0rvi5g@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <87wn3zsz5x.fsf@jogness.linutronix.de>
 <ZCLsuln0nHr7S9a5@alley>
 <87a5zxger3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5zxger3.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2023-03-28 16:03:36, John Ogness wrote:
> On 2023-03-28, Petr Mladek <pmladek@suse.com> wrote:
> >> +	if (!__serial8250_clear_IER(up, wctxt, &ier))
> >> +		return false;
> >> +
> >> +	if (console_exit_unsafe(wctxt)) {
> >> +		can_print = atomic_print_line(up, wctxt);
> >> +		if (!can_print)
> >> +			atomic_console_reacquire(wctxt, &wctxt_init);
> >
> > I am trying to review the 9th patch adding console_can_proceed(),
> > console_enter_unsafe(), console_exit_unsafe() API. And I wanted
> > to see how the struct cons_write_context was actually used.
> 
> First off, I need to post the latest version of the 8250-POC patch. It
> is not officially part of this series and is still going through changes
> for the PREEMPT_RT tree. I will post the latest version directly after
> answering this email.

Sure. I know that it is just a kind of POC.

> > I am confused now. I do not understand the motivation for the extra
> > @wctxt_init copy and atomic_console_reacquire().
> 
> If an atomic context loses ownership while doing certain activities, it
> may need to re-acquire ownership in order to finish or cleanup what it
> started.

This sounds suspicious. If a console/writer context has lost the lock
then all shared/locked resources might already be used by the new
owner.

I would expect that the context could touch only non-shared resources after
loosing the lock.

If it re-acquires the lock then the shared resource might be in
another state. So, doing any further changes might be dangerous.

I could imagine that incrementing/decrementing some counter might
make sense but setting some value sounds strange.


> > Why do we need a copy?
> 
> When ownership is lost, the context is cleared. In order to re-acquire,
> an original copy of the context is needed. There is no technical reason
> to clear the context, so maybe the context should not be cleared after a
> takeover. Otherwise, many drivers will need to implement the "backup
> copy" solution.

It might make sense to clear values that are not longer valid, e.g.
some state values or .len of the buffer. But I would keep the values
that might still be needed to re-acquire the lock. It might be
needed when the context want to re-start the entire operation,

I guess that you wanted to clean the structure to catch potential
misuse. It makes some sense but the copying is really weird.

I think that we might/should add some paranoid checks into all
functions manipulating the shared state instead.


> > And why we need to reacquire it?
> 
> In this particular case the context has disabled interrupts. No other
> context will re-enable interrupts because the driver is implemented such
> that the one who disables is the one who enables. So this context must
> re-acquire ownership in order to re-enable interrupts.

My understanding is that the driver might lose the lock only
during hostile takeover. Is it safe to re-enable interrupts
in this case?

Well, it actually might make sense if the interrupts should
be enabled when the port is unused.

Well, I guess that they will get enabled by the other hostile
owner. It should leave the serial port in a good state when
it releases the lock a normal way.

Anyway, thanks a lot for the info. I still have to scratch my
head around this.

Best Regards,
Petr
