Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832D76CC10C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 15:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjC1Neh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 09:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjC1Nef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:34:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40967C677;
        Tue, 28 Mar 2023 06:33:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EF8E71FD68;
        Tue, 28 Mar 2023 13:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680010430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BoN+48VeBrXOxliIGKwWmQ5Q5D6Gju28AqzttPr2pQ=;
        b=NDBPOWONkO/XyopTbjq7QQi+LbxwWvkVhmZUlpn1UEodXmVBKItnP5UxQj+Ez4GFFrckhx
        HxqxIgvG9W+FK23aN5uy1xUt/vFy5zg/u2OsZdE2oW3ygPdQhq72roeGMSeIYiIjy6D5IZ
        022BVxN4ShNQMFBkS/jUDs8jxMcmUoM=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E706B2C141;
        Tue, 28 Mar 2023 13:33:46 +0000 (UTC)
Date:   Tue, 28 Mar 2023 15:33:46 +0200
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
Subject: locking API: was: [PATCH printk v1 00/18] serial: 8250: implement
 non-BKL console
Message-ID: <ZCLsuln0nHr7S9a5@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <87wn3zsz5x.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn3zsz5x.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 2023-03-02 21:04:50, John Ogness wrote:
> Implement the necessary callbacks to allow the 8250 console driver
> to perform as a non-BKL console. Remove the implementation for the
> legacy console callback (write) and add implementations for the
> non-BKL consoles (write_atomic, write_thread, port_lock) and add
> CON_NO_BKL to the initial flags.
> 
> This is an all-in-one commit meant only for testing the new printk
> non-BKL infrastructure. It is not meant to be included mainline in
> this form. In particular, it includes mainline driver fixes that
> need to be submitted individually.
> 
> Although non-BKL consoles can coexist with legacy consoles, you
> will only receive all the benefits of the non-BKL consoles, if
> this console driver is the only console. That means no netconsole,
> no tty1, no earlyprintk, no earlycon. Just the uart8250.
> 
> For example: console=ttyS0,115200
> 
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> +static void atomic_console_reacquire(struct cons_write_context *wctxt,
> +				     struct cons_write_context *wctxt_init)
> +{
> +	memcpy(wctxt, wctxt_init, sizeof(*wctxt));
> +	while (!console_try_acquire(wctxt)) {
> +		cpu_relax();
> +		memcpy(wctxt, wctxt_init, sizeof(*wctxt));
> +	}
> +}
> +
>  /*
> - * Print a string to the serial port using the device FIFO
> - *
> - * It sends fifosize bytes and then waits for the fifo
> - * to get empty.
> + * It should be possible to support a hostile takeover in an unsafe
> + * section if it is write_atomic() that is being taken over. But where
> + * to put this policy?
>   */
> -static void serial8250_console_fifo_write(struct uart_8250_port *up,
> -					  const char *s, unsigned int count)
> +bool serial8250_console_write_atomic(struct uart_8250_port *up,
> +				     struct cons_write_context *wctxt)
>  {
> -	int i;
> -	const char *end = s + count;
> -	unsigned int fifosize = up->tx_loadsz;
> -	bool cr_sent = false;
> -
> -	while (s != end) {
> -		wait_for_lsr(up, UART_LSR_THRE);
> -
> -		for (i = 0; i < fifosize && s != end; ++i) {
> -			if (*s == '\n' && !cr_sent) {
> -				serial_out(up, UART_TX, '\r');
> -				cr_sent = true;
> -			} else {
> -				serial_out(up, UART_TX, *s++);
> -				cr_sent = false;
> -			}
> +	struct cons_write_context wctxt_init = {};
> +	struct cons_context *ctxt_init = &ACCESS_PRIVATE(&wctxt_init, ctxt);
> +	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	bool can_print = true;
> +	unsigned int ier;
> +
> +	/* With write_atomic, another context may hold the port->lock. */
> +
> +	ctxt_init->console = ctxt->console;
> +	ctxt_init->prio = ctxt->prio;
> +	ctxt_init->thread = ctxt->thread;
> +
> +	touch_nmi_watchdog();
> +
> +	/*
> +	 * Enter unsafe in order to disable interrupts. If the console is
> +	 * lost before the interrupts are disabled, bail out because another
> +	 * context took over the printing. If the console is lost after the
> +	 * interrutps are disabled, the console must be reacquired in order
> +	 * to re-enable the interrupts. However in that case no printing is
> +	 * allowed because another context took over the printing.
> +	 */
> +
> +	if (!console_enter_unsafe(wctxt))
> +		return false;
> +
> +	if (!__serial8250_clear_IER(up, wctxt, &ier))
> +		return false;
> +
> +	if (console_exit_unsafe(wctxt)) {
> +		can_print = atomic_print_line(up, wctxt);
> +		if (!can_print)
> +			atomic_console_reacquire(wctxt, &wctxt_init);

I am trying to review the 9th patch adding console_can_proceed(),
console_enter_unsafe(), console_exit_unsafe() API. And I wanted
to see how the struct cons_write_context was actually used.

I am confused now. I do not understand the motivation for the extra
@wctxt_init copy and atomic_console_reacquire().

Why do we need a copy? And why we need to reacquire it?

My feeling is that it is needed only to call
console_exit_unsafe(wctxt) later. Or do I miss anything?

> +
> +		if (can_print) {
> +			can_print = console_can_proceed(wctxt);
> +			if (can_print)
> +				wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
> +			else
> +				atomic_console_reacquire(wctxt, &wctxt_init);
> +		}
> +	} else {
> +		atomic_console_reacquire(wctxt, &wctxt_init);
> +	}
> +
> +	/*
> +	 * Enter unsafe in order to enable interrupts. If the console is
> +	 * lost before the interrupts are enabled, the console must be
> +	 * reacquired in order to re-enable the interrupts.
> +	 */
> +
> +	for (;;) {
> +		if (console_enter_unsafe(wctxt) &&
> +		    __serial8250_set_IER(up, wctxt, ier)) {
> +			break;
>  		}
> +
> +		/* HW-IRQs still disabled. Reacquire to enable them. */
> +		atomic_console_reacquire(wctxt, &wctxt_init);
>  	}
> +
> +	console_exit_unsafe(wctxt);
> +
> +	return can_print;
>  }

Best Regards,
Petr
