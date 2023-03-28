Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC4B6CC195
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 15:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjC1N7l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjC1N7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E7C651;
        Tue, 28 Mar 2023 06:59:18 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680011957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AVBcqEYEGKTnf7WGbkGOAukA8G1Pz6BlAEfJJGZegkE=;
        b=Qr5nmE8Hzfwst5KZgNjYoFM8HsLQhJkEdDi1f8YG7E2l6RW3I42AYUnd3Hj1dvU5eX6ucE
        GVg+jehpW7GdmqKghuc5lozEBjGFsuvQffCAWB3VU0HXTrToz1MAwJdoVuMf2ANcPXbKco
        lhCcdky/Da1Db5huCooHTwdeTfILjgiUjH/GDxsXgH1xX15uImZ9mM3zJv67wmrm+jjGUG
        Q5lPW37rXRdSYabbj2GV/aaDAsbu2UylovBlnI13TApvcR01HhbVh7P9BjmMcZGUuzmuND
        cShYSAlNbZ04zECY/+957ip3qCIjIt1ZT6CJ0lscZ3Se7Zdb0ZYpmMJkoFl8Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680011957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AVBcqEYEGKTnf7WGbkGOAukA8G1Pz6BlAEfJJGZegkE=;
        b=XlMGHhzSeLwTANt8K1piDZMwaiCTaHp3KPSQN9MATRV1Z9q5RIO3cVA0Gj8zfnAzt+Fsrk
        FK/+1PyuIPZ0BcBw==
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
In-Reply-To: <ZCLsuln0nHr7S9a5@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <87wn3zsz5x.fsf@jogness.linutronix.de> <ZCLsuln0nHr7S9a5@alley>
Date:   Tue, 28 Mar 2023 16:03:36 +0206
Message-ID: <87a5zxger3.fsf@jogness.linutronix.de>
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
>> +	if (!__serial8250_clear_IER(up, wctxt, &ier))
>> +		return false;
>> +
>> +	if (console_exit_unsafe(wctxt)) {
>> +		can_print = atomic_print_line(up, wctxt);
>> +		if (!can_print)
>> +			atomic_console_reacquire(wctxt, &wctxt_init);
>
> I am trying to review the 9th patch adding console_can_proceed(),
> console_enter_unsafe(), console_exit_unsafe() API. And I wanted
> to see how the struct cons_write_context was actually used.

First off, I need to post the latest version of the 8250-POC patch. It
is not officially part of this series and is still going through changes
for the PREEMPT_RT tree. I will post the latest version directly after
answering this email.

> I am confused now. I do not understand the motivation for the extra
> @wctxt_init copy and atomic_console_reacquire().

If an atomic context loses ownership while doing certain activities, it
may need to re-acquire ownership in order to finish or cleanup what it
started.

> Why do we need a copy?

When ownership is lost, the context is cleared. In order to re-acquire,
an original copy of the context is needed. There is no technical reason
to clear the context, so maybe the context should not be cleared after a
takeover. Otherwise, many drivers will need to implement the "backup
copy" solution.

> And why we need to reacquire it?

In this particular case the context has disabled interrupts. No other
context will re-enable interrupts because the driver is implemented such
that the one who disables is the one who enables. So this context must
re-acquire ownership in order to re-enable interrupts.

> My feeling is that it is needed only to call
> console_exit_unsafe(wctxt) later. Or do I miss anything?

No. It is only about re-enabling interrupts. The concept of unsafe is
not really relevant if a hostile takeover during unsafe occurs. In that
case it becomes a "hope and pray" effort at the end of panic().

John
