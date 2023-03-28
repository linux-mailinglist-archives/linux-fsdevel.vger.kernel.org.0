Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9096CC1A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjC1OCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjC1OC1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:02:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F242ECDC4;
        Tue, 28 Mar 2023 07:01:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680012064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OPRp4Ax1RiJSvFoiX1wWlEGoPCAJbm9ARjbhwmyJTlg=;
        b=vcCtO7AHHW2t08bARuMuV4QLdXbL6AZNRg9oe8tPiC5v8Vc+MD2/JAoC1y7gzU1VHKAtEJ
        88DsDk7tP5VRd5VM3AjwQcjm1xciD0SkHPl/e7yI0KZ7ybj+Ez0Yo4K+aGW/S/Pi2V0T8I
        DLPDh53oSfbfgDswfRHOdZ5KqPOAVibl3JD3fhCPo3IEPiBdXam9TlZJ05tQTxWvXhAnaH
        OFxCNTeTfxhUlqIgXhfrT1ou/6OJ6CqwkjpkrUUfXPEAyeyadlEwESaBuyoBZM/biX3tXT
        hMRVLe/DPKJeAX+BVcbH8vGxdcCNCdVz3eei0Y37gQ8tSoYNeM5l2hXpaP1SOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680012064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OPRp4Ax1RiJSvFoiX1wWlEGoPCAJbm9ARjbhwmyJTlg=;
        b=9cZSsc0e/WWMsmAWDfwktVKB2uAEk9ubsT4lLXL5RMoAPR2Nhg922DHfv7P5yVVpYiT3/H
        sP5zGTEyDpEOahAw==
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
Subject: Re: [PATCH printk v1 00/18] POC: serial: 8250: implement nbcon console
In-Reply-To: <87wn3zsz5x.fsf@jogness.linutronix.de>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <87wn3zsz5x.fsf@jogness.linutronix.de>
Date:   Tue, 28 Mar 2023 16:05:23 +0206
Message-ID: <877cv1geo4.fsf@jogness.linutronix.de>
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

Implement the necessary callbacks to allow the 8250 console driver
to perform as a nbcon console. Remove the implementation for the
legacy console callback (write) and add implementations for the
nbcon consoles (write_atomic, write_thread, port_lock) and add
CON_NBCON to the initial flags.

Although nbcon consoles can coexist with legacy consoles, you
will only receive all the benefits of the nbcon consoles if
this console driver is the only console. That means no netconsole,
no tty1, no earlyprintk, no earlycon. Just the uart8250.

For example: console=ttyS0,115200

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250.h              | 269 +++++++++++++-
 drivers/tty/serial/8250/8250_aspeed_vuart.c |   2 +-
 drivers/tty/serial/8250/8250_bcm7271.c      |  23 +-
 drivers/tty/serial/8250/8250_core.c         |  50 ++-
 drivers/tty/serial/8250/8250_exar.c         |   8 +-
 drivers/tty/serial/8250/8250_fsl.c          |   3 +-
 drivers/tty/serial/8250/8250_mtk.c          |  30 +-
 drivers/tty/serial/8250/8250_omap.c         |  36 +-
 drivers/tty/serial/8250/8250_port.c         | 369 +++++++++++++++-----
 drivers/tty/serial/8250/Kconfig             |   1 +
 drivers/tty/serial/serial_core.c            |  10 +-
 include/linux/serial_8250.h                 |  11 +-
 12 files changed, 686 insertions(+), 126 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 287153d32536..beb77af4ec62 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -177,12 +177,277 @@ static inline void serial_dl_write(struct uart_8250_port *up, int value)
 	up->dl_write(up, value);
 }
 
+static inline bool serial8250_is_console(struct uart_port *port)
+{
+	return uart_console(port) && !hlist_unhashed_lockless(&port->cons->node);
+}
+
+/**
+ * serial8250_init_wctxt - Initialize a write context for
+ *	non-console-printing usage
+ * @wctxt:	The write context to initialize
+ * @cons:	The console to assign to the write context
+ *
+ * In order to mark an unsafe region, drivers must acquire the console. This
+ * requires providing an initialized write context (even if that driver will
+ * not be doing any printing).
+ *
+ * This function should not be used for console printing contexts.
+ */
+static inline void serial8250_init_wctxt(struct nbcon_write_context *wctxt,
+					 struct console *cons)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	memset(wctxt, 0, sizeof(*wctxt));
+	ctxt->console = cons;
+	ctxt->prio = NBCON_PRIO_NORMAL;
+}
+
+/**
+ * __serial8250_console_acquire - Acquire a console for
+ *	non-console-printing usage
+ * @wctxt:	An uninitialized write context to use for acquiring
+ * @cons:	The console to assign to the write context
+ *
+ * The caller is holding the port->lock.
+ * The caller is holding the console_srcu_read_lock.
+ *
+ * This function should not be used for console printing contexts.
+ */
+static inline void __serial8250_console_acquire(struct nbcon_write_context *wctxt,
+						struct console *cons)
+{
+	for (;;) {
+		serial8250_init_wctxt(wctxt, cons);
+		if (nbcon_try_acquire(wctxt))
+			break;
+		cpu_relax();
+	}
+}
+
+/**
+ * serial8250_enter_unsafe - Mark the beginning of an unsafe region for
+ *		non-console-printing usage
+ * @up:	The port that is entering the unsafe state
+ *
+ * The caller should ensure @up is a console before calling this function.
+ *
+ * The caller is holding the port->lock.
+ * This function takes the console_srcu_read_lock and becomes owner of the
+ * console associated with @up.
+ *
+ * This function should not be used for console printing contexts.
+ */
+static inline void serial8250_enter_unsafe(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+
+	lockdep_assert_held_once(&port->lock);
+
+	for (;;) {
+		up->cookie = console_srcu_read_lock();
+
+		__serial8250_console_acquire(&up->wctxt, port->cons);
+
+		if (nbcon_enter_unsafe(&up->wctxt))
+			break;
+
+		console_srcu_read_unlock(up->cookie);
+		cpu_relax();
+	}
+}
+
+/**
+ * serial8250_exit_unsafe - Mark the end of an unsafe region for
+ *		non-console-printing usage
+ * @up:	The port that is exiting the unsafe state
+ *
+ * The caller is holding the port->lock.
+ * This function releases ownership of the console associated with @up and
+ * releases the console_srcu_read_lock.
+ *
+ * This function should not be used for console printing contexts.
+ */
+static inline void serial8250_exit_unsafe(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+
+	lockdep_assert_held_once(&port->lock);
+
+	if (nbcon_exit_unsafe(&up->wctxt))
+		nbcon_release(&up->wctxt);
+
+	console_srcu_read_unlock(up->cookie);
+}
+
+/**
+ * serial8250_in_IER - Read the IER register for
+ *		non-console-printing usage
+ * @up:	The port to work on
+ *
+ * Returns:	The value read from IER
+ *
+ * The caller is holding the port->lock.
+ *
+ * This is the top-level function for non-console-printing contexts to
+ * read the IER register. The caller does not need to care if @up is a
+ * console before calling this function.
+ *
+ * This function should not be used for printing contexts.
+ */
+static inline int serial8250_in_IER(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	bool is_console;
+	int ier;
+
+	is_console = serial8250_is_console(port);
+
+	if (is_console)
+		serial8250_enter_unsafe(up);
+
+	ier = serial_in(up, UART_IER);
+
+	if (is_console)
+		serial8250_exit_unsafe(up);
+
+	return ier;
+}
+
+/**
+ * __serial8250_set_IER - Directly write to the IER register
+ * @up:		The port to work on
+ * @wctxt:	The current write context
+ * @ier:	The value to write
+ *
+ * Returns:	True if IER was written to. False otherwise
+ *
+ * The caller is holding the port->lock.
+ * The caller is holding the console_srcu_read_unlock.
+ * The caller is the owner of the console associated with @up.
+ *
+ * This function should only be directly called within console printing
+ * contexts. Other contexts should use serial8250_set_IER().
+ */
+static inline bool __serial8250_set_IER(struct uart_8250_port *up,
+					struct nbcon_write_context *wctxt,
+					int ier)
+{
+	if (wctxt && !nbcon_can_proceed(wctxt))
+		return false;
+	serial_out(up, UART_IER, ier);
+	return true;
+}
+
+/**
+ * serial8250_set_IER - Write a new value to the IER register for
+ *	non-console-printing usage
+ * @up:		The port to work on
+ * @ier:	The value to write
+ *
+ * The caller is holding the port->lock.
+ *
+ * This is the top-level function for non-console-printing contexts to
+ * write to the IER register. The caller does not need to care if @up is a
+ * console before calling this function.
+ *
+ * This function should not be used for printing contexts.
+ */
+static inline void serial8250_set_IER(struct uart_8250_port *up, int ier)
+{
+	struct uart_port *port = &up->port;
+	bool is_console;
+
+	is_console = serial8250_is_console(port);
+
+	if (is_console) {
+		serial8250_enter_unsafe(up);
+		while (!__serial8250_set_IER(up, &up->wctxt, ier)) {
+			console_srcu_read_unlock(up->cookie);
+			nbcon_enter_unsafe(&up->wctxt);
+		}
+		serial8250_exit_unsafe(up);
+	} else {
+		__serial8250_set_IER(up, NULL, ier);
+	}
+}
+
+/**
+ * __serial8250_clear_IER - Directly clear the IER register
+ * @up:		The port to work on
+ * @wctxt:	The current write context
+ * @prior:	Gets set to the previous value of IER
+ *
+ * Returns:	True if IER was cleared and @prior points to the previous
+ *		value of IER. False otherwise and @prior is invalid
+ *
+ * The caller is holding the port->lock.
+ * The caller is holding the console_srcu_read_unlock.
+ * The caller is the owner of the console associated with @up.
+ *
+ * This function should only be directly called within console printing
+ * contexts. Other contexts should use serial8250_clear_IER().
+ */
+static inline bool __serial8250_clear_IER(struct uart_8250_port *up,
+					  struct nbcon_write_context *wctxt,
+					  int *prior)
+{
+	unsigned int clearval = 0;
+
+	if (up->capabilities & UART_CAP_UUE)
+		clearval = UART_IER_UUE;
+
+	*prior = serial_in(up, UART_IER);
+	if (wctxt && !nbcon_can_proceed(wctxt))
+		return false;
+	serial_out(up, UART_IER, clearval);
+	return true;
+}
+
+/**
+ * serial8250_clear_IER - Clear the IER register for
+ *		non-console-printing usage
+ * @up:	The port to work on
+ *
+ * Returns:	The previous value of IER
+ *
+ * The caller is holding the port->lock.
+ *
+ * This is the top-level function for non-console-printing contexts to
+ * clear the IER register. The caller does not need to care if @up is a
+ * console before calling this function.
+ *
+ * This function should not be used for printing contexts.
+ */
+static inline int serial8250_clear_IER(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	bool is_console;
+	int prior;
+
+	is_console = serial8250_is_console(port);
+
+	if (is_console) {
+		serial8250_enter_unsafe(up);
+		while (!__serial8250_clear_IER(up, &up->wctxt, &prior)) {
+			console_srcu_read_unlock(up->cookie);
+			nbcon_enter_unsafe(&up->wctxt);
+		}
+		serial8250_exit_unsafe(up);
+	} else {
+		__serial8250_clear_IER(up, NULL, &prior);
+	}
+
+	return prior;
+}
+
 static inline bool serial8250_set_THRI(struct uart_8250_port *up)
 {
 	if (up->ier & UART_IER_THRI)
 		return false;
 	up->ier |= UART_IER_THRI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier);
 	return true;
 }
 
@@ -191,7 +456,7 @@ static inline bool serial8250_clear_THRI(struct uart_8250_port *up)
 	if (!(up->ier & UART_IER_THRI))
 		return false;
 	up->ier &= ~UART_IER_THRI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier);
 	return true;
 }
 
diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 9d2a7856784f..7cc6b527c088 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -278,7 +278,7 @@ static void __aspeed_vuart_set_throttle(struct uart_8250_port *up,
 	up->ier &= ~irqs;
 	if (!throttle)
 		up->ier |= irqs;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier);
 }
 static void aspeed_vuart_set_throttle(struct uart_port *port, bool throttle)
 {
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index ed5a94747692..c6f2cd3f19b5 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -606,8 +606,10 @@ static int brcmuart_startup(struct uart_port *port)
 	 * Disable the Receive Data Interrupt because the DMA engine
 	 * will handle this.
 	 */
+	spin_lock_irq(&port->lock);
 	up->ier &= ~UART_IER_RDI;
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier);
+	spin_unlock_irq(&port->lock);
 
 	priv->tx_running = false;
 	priv->dma.rx_dma = NULL;
@@ -787,6 +789,12 @@ static int brcmuart_handle_irq(struct uart_port *p)
 		spin_lock_irqsave(&p->lock, flags);
 		status = serial_port_in(p, UART_LSR);
 		if ((status & UART_LSR_DR) == 0) {
+			bool is_console;
+
+			is_console = serial8250_is_console(p);
+
+			if (is_console)
+				serial8250_enter_unsafe(up);
 
 			ier = serial_port_in(p, UART_IER);
 			/*
@@ -807,6 +815,9 @@ static int brcmuart_handle_irq(struct uart_port *p)
 				serial_port_in(p, UART_RX);
 			}
 
+			if (is_console)
+				serial8250_exit_unsafe(up);
+
 			handled = 1;
 		}
 		spin_unlock_irqrestore(&p->lock, flags);
@@ -844,12 +855,22 @@ static enum hrtimer_restart brcmuart_hrtimer_func(struct hrtimer *t)
 	/* re-enable receive unless upper layer has disabled it */
 	if ((up->ier & (UART_IER_RLSI | UART_IER_RDI)) ==
 	    (UART_IER_RLSI | UART_IER_RDI)) {
+		bool is_console;
+
+		is_console = serial8250_is_console(p);
+
+		if (is_console)
+			serial8250_enter_unsafe(up);
+
 		status = serial_port_in(p, UART_IER);
 		status |= (UART_IER_RLSI | UART_IER_RDI);
 		serial_port_out(p, UART_IER, status);
 		status = serial_port_in(p, UART_MCR);
 		status |= UART_MCR_RTS;
 		serial_port_out(p, UART_MCR, status);
+
+		if (is_console)
+			serial8250_exit_unsafe(up);
 	}
 	spin_unlock_irqrestore(&p->lock, flags);
 	return HRTIMER_NORESTART;
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ab63c308be0a..6910160a5cec 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -256,6 +256,7 @@ static void serial8250_timeout(struct timer_list *t)
 static void serial8250_backup_timeout(struct timer_list *t)
 {
 	struct uart_8250_port *up = from_timer(up, t, timer);
+	struct uart_port *port = &up->port;
 	unsigned int iir, ier = 0, lsr;
 	unsigned long flags;
 
@@ -266,8 +267,23 @@ static void serial8250_backup_timeout(struct timer_list *t)
 	 * based handler.
 	 */
 	if (up->port.irq) {
+		bool is_console;
+
+		/*
+		 * Do not use serial8250_clear_IER() because this code
+		 * ignores capabilties.
+		 */
+
+		is_console = serial8250_is_console(port);
+
+		if (is_console)
+			serial8250_enter_unsafe(up);
+
 		ier = serial_in(up, UART_IER);
 		serial_out(up, UART_IER, 0);
+
+		if (is_console)
+			serial8250_exit_unsafe(up);
 	}
 
 	iir = serial_in(up, UART_IIR);
@@ -290,7 +306,7 @@ static void serial8250_backup_timeout(struct timer_list *t)
 		serial8250_tx_chars(up);
 
 	if (up->port.irq)
-		serial_out(up, UART_IER, ier);
+		serial8250_set_IER(up, ier);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
@@ -576,12 +592,30 @@ serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
-static void univ8250_console_write(struct console *co, const char *s,
-				   unsigned int count)
+static void univ8250_console_port_lock(struct console *con, bool do_lock, unsigned long *flags)
+{
+	struct uart_8250_port *up = &serial8250_ports[con->index];
+
+	if (do_lock)
+		spin_lock_irqsave(&up->port.lock, *flags);
+	else
+		spin_unlock_irqrestore(&up->port.lock, *flags);
+}
+
+static bool univ8250_console_write_atomic(struct console *co,
+					  struct nbcon_write_context *wctxt)
+{
+	struct uart_8250_port *up = &serial8250_ports[co->index];
+
+	return serial8250_console_write_atomic(up, wctxt);
+}
+
+static bool univ8250_console_write_thread(struct console *co,
+					  struct nbcon_write_context *wctxt)
 {
 	struct uart_8250_port *up = &serial8250_ports[co->index];
 
-	serial8250_console_write(up, s, count);
+	return serial8250_console_write_thread(up, wctxt);
 }
 
 static int univ8250_console_setup(struct console *co, char *options)
@@ -669,12 +703,14 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 
 static struct console univ8250_console = {
 	.name		= "ttyS",
-	.write		= univ8250_console_write,
+	.write_atomic	= univ8250_console_write_atomic,
+	.write_thread	= univ8250_console_write_thread,
+	.port_lock	= univ8250_console_port_lock,
 	.device		= uart_console_device,
 	.setup		= univ8250_console_setup,
 	.exit		= univ8250_console_exit,
 	.match		= univ8250_console_match,
-	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
+	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON,
 	.index		= -1,
 	.data		= &serial8250_reg,
 };
@@ -962,7 +998,7 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
 	spin_lock_irqsave(&port->lock, flags);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
 	up->port.read_status_mask |= UART_LSR_DR;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 64770c62bbec..ccb70b20b1f4 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -185,6 +185,10 @@ static void xr17v35x_set_divisor(struct uart_port *p, unsigned int baud,
 
 static int xr17v35x_startup(struct uart_port *port)
 {
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	spin_lock_irq(&port->lock);
+
 	/*
 	 * First enable access to IER [7:5], ISR [5:4], FCR [5:4],
 	 * MCR [7:5] and MSR [7:0]
@@ -195,7 +199,9 @@ static int xr17v35x_startup(struct uart_port *port)
 	 * Make sure all interrups are masked until initialization is
 	 * complete and the FIFOs are cleared
 	 */
-	serial_port_out(port, UART_IER, 0);
+	serial8250_set_IER(up, 0);
+
+	spin_unlock_irq(&port->lock);
 
 	return serial8250_do_startup(port);
 }
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 8adfaa183f77..eaf148245a10 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -58,7 +58,8 @@ int fsl8250_handle_irq(struct uart_port *port)
 	if ((orig_lsr & UART_LSR_OE) && (up->overrun_backoff_time_ms > 0)) {
 		unsigned long delay;
 
-		up->ier = port->serial_in(port, UART_IER);
+		up->ier = serial8250_in_IER(up);
+
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
 		} else {
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index fb1d5ec0940e..bf7ab55c8923 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -222,12 +222,38 @@ static void mtk8250_shutdown(struct uart_port *port)
 
 static void mtk8250_disable_intrs(struct uart_8250_port *up, int mask)
 {
-	serial_out(up, UART_IER, serial_in(up, UART_IER) & (~mask));
+	struct uart_port *port = &up->port;
+	bool is_console;
+	int ier;
+
+	is_console = serial8250_is_console(port);
+
+	if (is_console)
+		serial8250_enter_unsafe(up);
+
+	ier = serial_in(up, UART_IER);
+	serial_out(up, UART_IER, ier & (~mask));
+
+	if (is_console)
+		serial8250_exit_unsafe(up);
 }
 
 static void mtk8250_enable_intrs(struct uart_8250_port *up, int mask)
 {
-	serial_out(up, UART_IER, serial_in(up, UART_IER) | mask);
+	struct uart_port *port = &up->port;
+	bool is_console;
+	int ier;
+
+	is_console = serial8250_is_console(port);
+
+	if (is_console)
+		serial8250_enter_unsafe(up);
+
+	ier = serial_in(up, UART_IER);
+	serial_out(up, UART_IER, ier | mask);
+
+	if (is_console)
+		serial8250_exit_unsafe(up);
 }
 
 static void mtk8250_set_flow_ctrl(struct uart_8250_port *up, int mode)
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 734f092ef839..bfa50a26349d 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -334,8 +334,7 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 
 	/* drop TCR + TLR access, we setup XON/XOFF later */
 	serial8250_out_MCR(up, mcr);
-
-	serial_out(up, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_dl_write(up, priv->quot);
@@ -523,16 +522,21 @@ static void omap_8250_pm(struct uart_port *port, unsigned int state,
 	u8 efr;
 
 	pm_runtime_get_sync(port->dev);
+
+	spin_lock_irq(&port->lock);
+
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	efr = serial_in(up, UART_EFR);
 	serial_out(up, UART_EFR, efr | UART_EFR_ECB);
 	serial_out(up, UART_LCR, 0);
 
-	serial_out(up, UART_IER, (state != 0) ? UART_IERX_SLEEP : 0);
+	serial8250_set_IER(up, (state != 0) ? UART_IERX_SLEEP : 0);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
 
+	spin_unlock_irq(&port->lock);
+
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
 }
@@ -649,7 +653,8 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 	if ((lsr & UART_LSR_OE) && up->overrun_backoff_time_ms > 0) {
 		unsigned long delay;
 
-		up->ier = port->serial_in(port, UART_IER);
+		spin_lock(&port->lock);
+		up->ier = serial8250_in_IER(up);
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
 		} else {
@@ -658,6 +663,7 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 			 */
 			cancel_delayed_work(&up->overrun_backoff);
 		}
+		spin_unlock(&port->lock);
 
 		delay = msecs_to_jiffies(up->overrun_backoff_time_ms);
 		schedule_delayed_work(&up->overrun_backoff, delay);
@@ -707,8 +713,10 @@ static int omap_8250_startup(struct uart_port *port)
 	if (ret < 0)
 		goto err;
 
+	spin_lock_irq(&port->lock);
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier);
+	spin_unlock_irq(&port->lock);
 
 #ifdef CONFIG_PM
 	up->capabilities |= UART_CAP_RPM;
@@ -748,8 +756,10 @@ static void omap_8250_shutdown(struct uart_port *port)
 	if (priv->habit & UART_HAS_EFR2)
 		serial_out(up, UART_OMAP_EFR2, 0x0);
 
+	spin_lock_irq(&port->lock);
 	up->ier = 0;
-	serial_out(up, UART_IER, 0);
+	serial8250_set_IER(up, 0);
+	spin_unlock_irq(&port->lock);
 
 	if (up->dma)
 		serial8250_release_dma(up);
@@ -797,7 +807,7 @@ static void omap_8250_unthrottle(struct uart_port *port)
 		up->dma->rx_dma(up);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
 	port->read_status_mask |= UART_LSR_DR;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	pm_runtime_mark_last_busy(port->dev);
@@ -956,7 +966,7 @@ static void __dma_rx_complete(void *param)
 	__dma_rx_do_complete(p);
 	if (!priv->throttled) {
 		p->ier |= UART_IER_RLSI | UART_IER_RDI;
-		serial_out(p, UART_IER, p->ier);
+		serial8250_set_IER(p, p->ier);
 		if (!(priv->habit & UART_HAS_EFR2))
 			omap_8250_rx_dma(p);
 	}
@@ -1013,7 +1023,7 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
 			 * callback to run.
 			 */
 			p->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
-			serial_out(p, UART_IER, p->ier);
+			serial8250_set_IER(p, p->ier);
 		}
 		goto out;
 	}
@@ -1226,12 +1236,12 @@ static void am654_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir,
 		 * periodic timeouts, re-enable interrupts.
 		 */
 		up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
-		serial_out(up, UART_IER, up->ier);
+		serial8250_set_IER(up, up->ier);
 		omap_8250_rx_dma_flush(up);
 		serial_in(up, UART_IIR);
 		serial_out(up, UART_OMAP_EFR2, 0x0);
 		up->ier |= UART_IER_RLSI | UART_IER_RDI;
-		serial_out(up, UART_IER, up->ier);
+		serial8250_set_IER(up, up->ier);
 	}
 }
 
@@ -1717,12 +1727,16 @@ static int omap8250_runtime_resume(struct device *dev)
 
 	up = serial8250_get_port(priv->line);
 
+	spin_lock_irq(&up->port.lock);
+
 	if (omap8250_lost_context(up))
 		omap8250_restore_regs(up);
 
 	if (up->dma && up->dma->rxchan && !(priv->habit & UART_HAS_EFR2))
 		omap_8250_rx_dma(up);
 
+	spin_unlock_irq(&up->port.lock);
+
 	priv->latency = priv->calc_latency;
 	schedule_work(&priv->qos_work);
 	return 0;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fa43df05342b..4378349862e6 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -744,6 +744,7 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 	serial8250_rpm_get(p);
 
 	if (p->capabilities & UART_CAP_SLEEP) {
+		spin_lock_irq(&p->port.lock);
 		if (p->capabilities & UART_CAP_EFR) {
 			lcr = serial_in(p, UART_LCR);
 			efr = serial_in(p, UART_EFR);
@@ -751,25 +752,18 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 			serial_out(p, UART_EFR, UART_EFR_ECB);
 			serial_out(p, UART_LCR, 0);
 		}
-		serial_out(p, UART_IER, sleep ? UART_IERX_SLEEP : 0);
+		serial8250_set_IER(p, sleep ? UART_IERX_SLEEP : 0);
 		if (p->capabilities & UART_CAP_EFR) {
 			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
 			serial_out(p, UART_EFR, efr);
 			serial_out(p, UART_LCR, lcr);
 		}
+		spin_unlock_irq(&p->port.lock);
 	}
 
 	serial8250_rpm_put(p);
 }
 
-static void serial8250_clear_IER(struct uart_8250_port *up)
-{
-	if (up->capabilities & UART_CAP_UUE)
-		serial_out(up, UART_IER, UART_IER_UUE);
-	else
-		serial_out(up, UART_IER, 0);
-}
-
 #ifdef CONFIG_SERIAL_8250_RSA
 /*
  * Attempts to turn on the RSA FIFO.  Returns zero on failure.
@@ -1033,8 +1027,10 @@ static int broken_efr(struct uart_8250_port *up)
  */
 static void autoconfig_16550a(struct uart_8250_port *up)
 {
+	struct uart_port *port = &up->port;
 	unsigned char status1, status2;
 	unsigned int iersave;
+	bool is_console;
 
 	up->port.type = PORT_16550A;
 	up->capabilities |= UART_CAP_FIFO;
@@ -1150,6 +1146,11 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 		return;
 	}
 
+	is_console = serial8250_is_console(port);
+
+	if (is_console)
+		serial8250_enter_unsafe(up);
+
 	/*
 	 * Try writing and reading the UART_IER_UUE bit (b6).
 	 * If it works, this is probably one of the Xscale platform's
@@ -1185,6 +1186,9 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	}
 	serial_out(up, UART_IER, iersave);
 
+	if (is_console)
+		serial8250_exit_unsafe(up);
+
 	/*
 	 * We distinguish between 16550A and U6 16550A by counting
 	 * how many bytes are in the FIFO.
@@ -1226,6 +1230,13 @@ static void autoconfig(struct uart_8250_port *up)
 	up->bugs = 0;
 
 	if (!(port->flags & UPF_BUGGY_UART)) {
+		bool is_console;
+
+		is_console = serial8250_is_console(port);
+
+		if (is_console)
+			serial8250_enter_unsafe(up);
+
 		/*
 		 * Do a simple existence test first; if we fail this,
 		 * there's no point trying anything else.
@@ -1255,6 +1266,10 @@ static void autoconfig(struct uart_8250_port *up)
 #endif
 		scratch3 = serial_in(up, UART_IER) & UART_IER_ALL_INTR;
 		serial_out(up, UART_IER, scratch);
+
+		if (is_console)
+			serial8250_exit_unsafe(up);
+
 		if (scratch2 != 0 || scratch3 != UART_IER_ALL_INTR) {
 			/*
 			 * We failed; there's nothing here
@@ -1376,6 +1391,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	unsigned char save_ICP = 0;
 	unsigned int ICP = 0;
 	unsigned long irqs;
+	bool is_console;
 	int irq;
 
 	if (port->flags & UPF_FOURPORT) {
@@ -1385,8 +1401,12 @@ static void autoconfig_irq(struct uart_8250_port *up)
 		inb_p(ICP);
 	}
 
-	if (uart_console(port))
+	is_console = serial8250_is_console(port);
+
+	if (is_console) {
 		console_lock();
+		serial8250_enter_unsafe(up);
+	}
 
 	/* forget possible initially masked and pending IRQ */
 	probe_irq_off(probe_irq_on());
@@ -1418,8 +1438,10 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	if (port->flags & UPF_FOURPORT)
 		outb_p(save_ICP, ICP);
 
-	if (uart_console(port))
+	if (is_console) {
+		serial8250_exit_unsafe(up);
 		console_unlock();
+	}
 
 	port->irq = (irq > 0) ? irq : 0;
 }
@@ -1432,7 +1454,7 @@ static void serial8250_stop_rx(struct uart_port *port)
 
 	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
 	up->port.read_status_mask &= ~UART_LSR_DR;
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier);
 
 	serial8250_rpm_put(up);
 }
@@ -1462,7 +1484,7 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
 		serial8250_clear_and_reinit_fifos(p);
 
 		p->ier |= UART_IER_RLSI | UART_IER_RDI;
-		serial_port_out(&p->port, UART_IER, p->ier);
+		serial8250_set_IER(p, p->ier);
 	}
 }
 EXPORT_SYMBOL_GPL(serial8250_em485_stop_tx);
@@ -1709,7 +1731,7 @@ static void serial8250_disable_ms(struct uart_port *port)
 	mctrl_gpio_disable_ms(up->gpios);
 
 	up->ier &= ~UART_IER_MSI;
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier);
 }
 
 static void serial8250_enable_ms(struct uart_port *port)
@@ -1725,7 +1747,7 @@ static void serial8250_enable_ms(struct uart_port *port)
 	up->ier |= UART_IER_MSI;
 
 	serial8250_rpm_get(up);
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier);
 	serial8250_rpm_put(up);
 }
 
@@ -2160,9 +2182,10 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	serial8250_rpm_get(up);
 	/*
 	 *	First save the IER then disable the interrupts
+	 *
+	 *	Best-effort IER access because other CPUs are quiesced.
 	 */
-	ier = serial_port_in(port, UART_IER);
-	serial8250_clear_IER(up);
+	__serial8250_clear_IER(up, NULL, &ier);
 
 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
 	/*
@@ -2175,7 +2198,7 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
-	serial_port_out(port, UART_IER, ier);
+	__serial8250_set_IER(up, NULL, ier);
 	serial8250_rpm_put(up);
 }
 
@@ -2186,6 +2209,7 @@ int serial8250_do_startup(struct uart_port *port)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
 	unsigned char iir;
+	bool is_console;
 	int retval;
 	u16 lsr;
 
@@ -2203,21 +2227,25 @@ int serial8250_do_startup(struct uart_port *port)
 	serial8250_rpm_get(up);
 	if (port->type == PORT_16C950) {
 		/* Wake up and initialize UART */
+		spin_lock_irqsave(&port->lock, flags);
 		up->acr = 0;
 		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
 		serial_port_out(port, UART_EFR, UART_EFR_ECB);
-		serial_port_out(port, UART_IER, 0);
+		serial8250_set_IER(up, 0);
 		serial_port_out(port, UART_LCR, 0);
 		serial_icr_write(up, UART_CSR, 0); /* Reset the UART */
 		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
 		serial_port_out(port, UART_EFR, UART_EFR_ECB);
 		serial_port_out(port, UART_LCR, 0);
+		spin_unlock_irqrestore(&port->lock, flags);
 	}
 
 	if (port->type == PORT_DA830) {
 		/* Reset the port */
-		serial_port_out(port, UART_IER, 0);
+		spin_lock_irqsave(&port->lock, flags);
+		serial8250_set_IER(up, 0);
 		serial_port_out(port, UART_DA830_PWREMU_MGMT, 0);
+		spin_unlock_irqrestore(&port->lock, flags);
 		mdelay(10);
 
 		/* Enable Tx, Rx and free run mode */
@@ -2315,6 +2343,8 @@ int serial8250_do_startup(struct uart_port *port)
 	if (retval)
 		goto out;
 
+	is_console = serial8250_is_console(port);
+
 	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
 		unsigned char iir1;
 
@@ -2331,6 +2361,9 @@ int serial8250_do_startup(struct uart_port *port)
 		 */
 		spin_lock_irqsave(&port->lock, flags);
 
+		if (is_console)
+			serial8250_enter_unsafe(up);
+
 		wait_for_xmitr(up, UART_LSR_THRE);
 		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
 		udelay(1); /* allow THRE to set */
@@ -2341,6 +2374,9 @@ int serial8250_do_startup(struct uart_port *port)
 		iir = serial_port_in(port, UART_IIR);
 		serial_port_out(port, UART_IER, 0);
 
+		if (is_console)
+			serial8250_exit_unsafe(up);
+
 		spin_unlock_irqrestore(&port->lock, flags);
 
 		if (port->irqflags & IRQF_SHARED)
@@ -2395,10 +2431,14 @@ int serial8250_do_startup(struct uart_port *port)
 	 * Do a quick test to see if we receive an interrupt when we enable
 	 * the TX irq.
 	 */
+	if (is_console)
+		serial8250_enter_unsafe(up);
 	serial_port_out(port, UART_IER, UART_IER_THRI);
 	lsr = serial_port_in(port, UART_LSR);
 	iir = serial_port_in(port, UART_IIR);
 	serial_port_out(port, UART_IER, 0);
+	if (is_console)
+		serial8250_exit_unsafe(up);
 
 	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
 		if (!(up->bugs & UART_BUG_TXEN)) {
@@ -2430,7 +2470,7 @@ int serial8250_do_startup(struct uart_port *port)
 	if (up->dma) {
 		const char *msg = NULL;
 
-		if (uart_console(port))
+		if (is_console)
 			msg = "forbid DMA for kernel console";
 		else if (serial8250_request_dma(up))
 			msg = "failed to request DMA";
@@ -2481,7 +2521,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 */
 	spin_lock_irqsave(&port->lock, flags);
 	up->ier = 0;
-	serial_port_out(port, UART_IER, 0);
+	serial8250_set_IER(up, 0);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	synchronize_irq(port->irq);
@@ -2847,7 +2887,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (up->capabilities & UART_CAP_RTOIE)
 		up->ier |= UART_IER_RTOIE;
 
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_set_IER(up, up->ier);
 
 	if (up->capabilities & UART_CAP_EFR) {
 		unsigned char efr = 0;
@@ -3312,12 +3352,21 @@ EXPORT_SYMBOL_GPL(serial8250_set_defaults);
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
-static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
+static bool serial8250_console_putchar(struct uart_port *port, unsigned char ch,
+				       struct nbcon_write_context *wctxt)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
 	wait_for_xmitr(up, UART_LSR_THRE);
+	if (!nbcon_can_proceed(wctxt))
+		return false;
 	serial_port_out(port, UART_TX, ch);
+	if (ch == '\n')
+		up->console_newline_needed = false;
+	else
+		up->console_newline_needed = true;
+
+	return true;
 }
 
 /*
@@ -3346,33 +3395,119 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
 
-/*
- * Print a string to the serial port using the device FIFO
- *
- * It sends fifosize bytes and then waits for the fifo
- * to get empty.
- */
-static void serial8250_console_fifo_write(struct uart_8250_port *up,
-					  const char *s, unsigned int count)
+static bool __serial8250_console_write(struct uart_port *port, struct nbcon_write_context *wctxt,
+		const char *s, unsigned int count,
+		bool (*putchar)(struct uart_port *, unsigned char, struct nbcon_write_context *))
 {
-	int i;
-	const char *end = s + count;
-	unsigned int fifosize = up->tx_loadsz;
-	bool cr_sent = false;
-
-	while (s != end) {
-		wait_for_lsr(up, UART_LSR_THRE);
-
-		for (i = 0; i < fifosize && s != end; ++i) {
-			if (*s == '\n' && !cr_sent) {
-				serial_out(up, UART_TX, '\r');
-				cr_sent = true;
-			} else {
-				serial_out(up, UART_TX, *s++);
-				cr_sent = false;
-			}
+	bool finished = false;
+	unsigned int i;
+
+	for (i = 0; i < count; i++, s++) {
+		if (*s == '\n') {
+			if (!putchar(port, '\r', wctxt))
+				goto out;
+		}
+		if (!putchar(port, *s, wctxt))
+			goto out;
+	}
+	finished = true;
+out:
+	return finished;
+}
+
+static bool serial8250_console_write(struct uart_port *port, struct nbcon_write_context *wctxt,
+		const char *s, unsigned int count,
+		bool (*putchar)(struct uart_port *, unsigned char, struct nbcon_write_context *))
+{
+	return __serial8250_console_write(port, wctxt, s, count, putchar);
+}
+
+static bool atomic_print_line(struct uart_8250_port *up,
+			      struct nbcon_write_context *wctxt)
+{
+	struct uart_port *port = &up->port;
+
+	if (up->console_newline_needed &&
+	    !__serial8250_console_write(port, wctxt, "\n", 1, serial8250_console_putchar)) {
+		return false;
+	}
+
+	return __serial8250_console_write(port, wctxt, wctxt->outbuf, wctxt->len,
+					  serial8250_console_putchar);
+}
+
+static void atomic_console_reacquire(struct nbcon_write_context *wctxt,
+				     struct nbcon_write_context *wctxt_init)
+{
+	memcpy(wctxt, wctxt_init, sizeof(*wctxt));
+	while (!nbcon_try_acquire(wctxt)) {
+		cpu_relax();
+		memcpy(wctxt, wctxt_init, sizeof(*wctxt));
+	}
+}
+
+bool serial8250_console_write_atomic(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt)
+{
+	struct nbcon_write_context wctxt_init = { };
+	struct nbcon_context *ctxt_init = &ACCESS_PRIVATE(&wctxt_init, ctxt);
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	bool finished = false;
+	unsigned int ier;
+
+	touch_nmi_watchdog();
+
+	/* With write_atomic, another context may hold the port->lock. */
+
+	ctxt_init->console = ctxt->console;
+	ctxt_init->prio = ctxt->prio;
+	ctxt_init->thread = ctxt->thread;
+
+	/*
+	 * Enter unsafe in order to disable interrupts. If the console is
+	 * lost before the interrupts are disabled, bail out because another
+	 * context took over the printing. If the console is lost after the
+	 * interrutps are disabled, the console must be reacquired in order
+	 * to re-enable the interrupts. However in that case no printing is
+	 * allowed because another context took over the printing.
+	 */
+
+	if (!nbcon_enter_unsafe(wctxt))
+		return false;
+
+	if (!__serial8250_clear_IER(up, wctxt, &ier))
+		return false;
+
+	if (!nbcon_exit_unsafe(wctxt)) {
+		atomic_console_reacquire(wctxt, &wctxt_init);
+		goto enable_irq;
+	}
+
+	if (!atomic_print_line(up, wctxt)) {
+		atomic_console_reacquire(wctxt, &wctxt_init);
+		goto enable_irq;
+	}
+
+	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
+	finished = true;
+enable_irq:
+	/*
+	 * Enter unsafe in order to enable interrupts. If the console is
+	 * lost before the interrupts are enabled, the console must be
+	 * reacquired in order to re-enable the interrupts.
+	 */
+	for (;;) {
+		if (nbcon_enter_unsafe(wctxt) &&
+		    __serial8250_set_IER(up, wctxt, ier)) {
+			break;
 		}
+
+		/* HW-IRQs still disabled. Reacquire to enable them. */
+		atomic_console_reacquire(wctxt, &wctxt_init);
 	}
+	nbcon_exit_unsafe(wctxt);
+
+	return finished;
 }
 
 /*
@@ -3384,78 +3519,116 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
  *	Doing runtime PM is really a bad idea for the kernel console.
  *	Thus, we assume the function is called when device is powered up.
  */
-void serial8250_console_write(struct uart_8250_port *up, const char *s,
-			      unsigned int count)
+bool serial8250_console_write_thread(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt)
 {
+	struct nbcon_write_context wctxt_init = { };
+	struct nbcon_context *ctxt_init = &ACCESS_PRIVATE(&wctxt_init, ctxt);
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 	struct uart_8250_em485 *em485 = up->em485;
 	struct uart_port *port = &up->port;
-	unsigned long flags;
-	unsigned int ier, use_fifo;
-	int locked = 1;
-
-	touch_nmi_watchdog();
+	unsigned int count = wctxt->len;
+	const char *s = wctxt->outbuf;
+	bool rs485_started = false;
+	bool finished = false;
+	unsigned int ier;
 
-	if (oops_in_progress)
-		locked = spin_trylock_irqsave(&port->lock, flags);
-	else
-		spin_lock_irqsave(&port->lock, flags);
+	ctxt_init->console = ctxt->console;
+	ctxt_init->prio = ctxt->prio;
+	ctxt_init->thread = ctxt->thread;
 
 	/*
-	 *	First save the IER then disable the interrupts
+	 * Enter unsafe in order to disable interrupts. If the console is
+	 * lost before the interrupts are disabled, bail out because another
+	 * context took over the printing. If the console is lost after the
+	 * interrutps are disabled, the console must be reacquired in order
+	 * to re-enable the interrupts. However in that case no printing is
+	 * allowed because another context took over the printing.
 	 */
-	ier = serial_port_in(port, UART_IER);
-	serial8250_clear_IER(up);
+
+	if (!nbcon_enter_unsafe(wctxt))
+		return false;
+
+	if (!__serial8250_clear_IER(up, wctxt, &ier))
+		return false;
+
+	if (!nbcon_exit_unsafe(wctxt)) {
+		atomic_console_reacquire(wctxt, &wctxt_init);
+		goto enable_irq;
+	}
 
 	/* check scratch reg to see if port powered off during system sleep */
 	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
+		if (!nbcon_enter_unsafe(wctxt)) {
+			atomic_console_reacquire(wctxt, &wctxt_init);
+			goto enable_irq;
+		}
 		serial8250_console_restore(up);
+		if (!nbcon_exit_unsafe(wctxt)) {
+			atomic_console_reacquire(wctxt, &wctxt_init);
+			goto enable_irq;
+		}
 		up->canary = 0;
 	}
 
 	if (em485) {
-		if (em485->tx_stopped)
+		if (em485->tx_stopped) {
+			if (!nbcon_enter_unsafe(wctxt)) {
+				atomic_console_reacquire(wctxt, &wctxt_init);
+				goto enable_irq;
+			}
 			up->rs485_start_tx(up);
-		mdelay(port->rs485.delay_rts_before_send);
+			rs485_started = true;
+			if (!nbcon_exit_unsafe(wctxt)) {
+				atomic_console_reacquire(wctxt, &wctxt_init);
+				goto enable_irq;
+			}
+		}
+		if (port->rs485.delay_rts_before_send) {
+			mdelay(port->rs485.delay_rts_before_send);
+			if (!nbcon_can_proceed(wctxt)) {
+				atomic_console_reacquire(wctxt, &wctxt_init);
+				goto enable_irq;
+			}
+		}
 	}
 
-	use_fifo = (up->capabilities & UART_CAP_FIFO) &&
-		/*
-		 * BCM283x requires to check the fifo
-		 * after each byte.
-		 */
-		!(up->capabilities & UART_CAP_MINI) &&
-		/*
-		 * tx_loadsz contains the transmit fifo size
-		 */
-		up->tx_loadsz > 1 &&
-		(up->fcr & UART_FCR_ENABLE_FIFO) &&
-		port->state &&
-		test_bit(TTY_PORT_INITIALIZED, &port->state->port.iflags) &&
-		/*
-		 * After we put a data in the fifo, the controller will send
-		 * it regardless of the CTS state. Therefore, only use fifo
-		 * if we don't use control flow.
-		 */
-		!(up->port.flags & UPF_CONS_FLOW);
-
-	if (likely(use_fifo))
-		serial8250_console_fifo_write(up, s, count);
-	else
-		uart_console_write(port, s, count, serial8250_console_putchar);
+	if (!serial8250_console_write(port, wctxt, s, count, serial8250_console_putchar)) {
+		atomic_console_reacquire(wctxt, &wctxt_init);
+		goto enable_irq;
+	}
 
+	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
+	finished = true;
+enable_irq:
 	/*
-	 *	Finally, wait for transmitter to become empty
-	 *	and restore the IER
+	 * Enter unsafe in order to stop rs485_tx. If the console is
+	 * lost before the rs485_tx is stopped, the console must be
+	 * reacquired in order to stop rs485_tx.
 	 */
-	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
-
 	if (em485) {
 		mdelay(port->rs485.delay_rts_after_send);
-		if (em485->tx_stopped)
+		if (em485->tx_stopped && rs485_started) {
+			while (!nbcon_enter_unsafe(wctxt))
+				atomic_console_reacquire(wctxt, &wctxt_init);
 			up->rs485_stop_tx(up);
+			if (!nbcon_exit_unsafe(wctxt))
+				atomic_console_reacquire(wctxt, &wctxt_init);
+		}
 	}
 
-	serial_port_out(port, UART_IER, ier);
+	/*
+	 * Enter unsafe in order to enable interrupts. If the console is
+	 * lost before the interrupts are enabled, the console must be
+	 * reacquired in order to re-enable the interrupts.
+	 */
+	for (;;) {
+		if (nbcon_enter_unsafe(wctxt) &&
+		    __serial8250_set_IER(up, wctxt, ier)) {
+			break;
+		}
+		atomic_console_reacquire(wctxt, &wctxt_init);
+	}
 
 	/*
 	 *	The receive handling will happen properly because the
@@ -3467,8 +3640,9 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	if (up->msr_saved_flags)
 		serial8250_modem_status(up);
 
-	if (locked)
-		spin_unlock_irqrestore(&port->lock, flags);
+	nbcon_exit_unsafe(wctxt);
+
+	return finished;
 }
 
 static unsigned int probe_baud(struct uart_port *port)
@@ -3488,6 +3662,7 @@ static unsigned int probe_baud(struct uart_port *port)
 
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 {
+	struct uart_8250_port *up = up_to_u8250p(port);
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
@@ -3497,6 +3672,8 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 	if (!port->iobase && !port->membase)
 		return -ENODEV;
 
+	up->console_newline_needed = false;
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else if (probe)
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 5313aa31930f..16715f01bdb5 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -9,6 +9,7 @@ config SERIAL_8250
 	depends on !S390
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
+	select HAVE_ATOMIC_CONSOLE
 	help
 	  This selects whether you want to include the driver for the standard
 	  serial ports.  The standard answer is Y.  People who might say N
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2bd32c8ece39..9901f916dc1a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2336,8 +2336,11 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 	 * able to Re-start_rx later.
 	 */
 	if (!console_suspend_enabled && uart_console(uport)) {
-		if (uport->ops->start_rx)
+		if (uport->ops->start_rx) {
+			spin_lock_irq(&uport->lock);
 			uport->ops->stop_rx(uport);
+			spin_unlock_irq(&uport->lock);
+		}
 		goto unlock;
 	}
 
@@ -2430,8 +2433,11 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		if (console_suspend_enabled)
 			uart_change_pm(state, UART_PM_STATE_ON);
 		uport->ops->set_termios(uport, &termios, NULL);
-		if (!console_suspend_enabled && uport->ops->start_rx)
+		if (!console_suspend_enabled && uport->ops->start_rx) {
+			spin_lock_irq(&uport->lock);
 			uport->ops->start_rx(uport);
+			spin_unlock_irq(&uport->lock);
+		}
 		if (console_suspend_enabled)
 			console_start(uport->cons);
 	}
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 19376bee9667..cf73a99232d4 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -125,6 +125,8 @@ struct uart_8250_port {
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
 
+	bool			console_newline_needed;
+
 	struct uart_8250_dma	*dma;
 	const struct uart_8250_ops *ops;
 
@@ -139,6 +141,9 @@ struct uart_8250_port {
 	/* Serial port overrun backoff */
 	struct delayed_work overrun_backoff;
 	u32 overrun_backoff_time_ms;
+
+	struct nbcon_write_context wctxt;
+	int cookie;
 };
 
 static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
@@ -178,8 +183,10 @@ void serial8250_tx_chars(struct uart_8250_port *up);
 unsigned int serial8250_modem_status(struct uart_8250_port *up);
 void serial8250_init_port(struct uart_8250_port *up);
 void serial8250_set_defaults(struct uart_8250_port *up);
-void serial8250_console_write(struct uart_8250_port *up, const char *s,
-			      unsigned int count);
+bool serial8250_console_write_atomic(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt);
+bool serial8250_console_write_thread(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt);
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe);
 int serial8250_console_exit(struct uart_port *port);
 
-- 
2.30.2
