Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6785F1642
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 00:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiI3WmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 18:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbiI3WmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:42:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24361BBEC0;
        Fri, 30 Sep 2022 15:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664577695;
        bh=T8OlTVTcSxDpUAgoSCbcb9XsLgSMab3h//3zHeGP0cU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hIoq6HW190O7XJkjsOq6tn7jiFXNp6bi7p072gM3x95JTAAwttS9kGdod9GZZkzvl
         fX1jJkKbVX1WATcHA3Mo+p6Ut/p0xAK/a/Ck/9jhfpoqqlqcNR4OF0R4C31brFIuVg
         ghwOJP16lnofqPlX5bEmOYCMsa1RwgnXg6lRkU9s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.169.174]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1pKDiQ3xLE-016PPG; Sat, 01
 Oct 2022 00:41:35 +0200
Date:   Sat, 1 Oct 2022 00:41:30 +0200
From:   Helge Deller <deller@gmx.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Helge Deller <deller@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk 11/18] printk: Convert console_drivers list to
 hlist
Message-ID: <YzdwmvHo+po9/lT9@p100>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-12-john.ogness@linutronix.de>
 <Yzb7Oh2Y8feej+Eh@alley>
 <db7bdf7a-597f-398e-9877-01e898733664@gmx.de>
 <8735c88x2c.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735c88x2c.fsf@jogness.linutronix.de>
X-Provags-ID: V03:K1:JkQz1krv3JtQx7JyJFQpjQclQIFfP1fmBIfv3Kou4sZTxryDXpY
 4xVsOHDLXyAl2sGiZ4ZkxG0sMpM5f2iRK1WsbPXuReALt2fv9iyl/VdnGoc+dBkP8+U4Os0
 nT9RX2GDABrkNwIT+x6MqqnY3VAvqbHpcsEkTWOcSj1uzioLQrmx8A7ek4uitQYv8aQRvkp
 UuoU9t2FDXgZW5AtxK0sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xbA5w3vuyPs=:pUlQK50/ap6KUjXPluxczs
 sS2RlUu5XIZmdjuM4gvDSfVV0a5Ct0dmCSBpkm/TdY7D7Wy2VPrgVRXb9Gio7VENEeAZYoR32
 Ts+RIAKV9IhWivPslaanLFpgorweryM9/raD2k6z5VMKVxxSqdxW6kDgAAeA2TiDAaYjsHuyP
 8YP/VdUX4F8MAm+1BLshft7jrtpASSe26R4V1AlhQGvV1bp6AteXA6p1n73Hl4m327yWNzbAA
 ObF8eCJew9SCxegcfaFL0Rop2uax4rbzwRcTZRKKIf+dWkGs9Qlhrz4nSvbnjxfEPdEtta0d3
 je74IHOXD/lltKph7qh6bbSA+M7AVJNYHjL8Y/k7+7GXQCDxTfdkgnN4OXVVAvTEVer+aWYYs
 MabOlR5t8bGdUU1/nbziYpZOF62Sstj+lKPULokY1lVSxLy+qb2STTR1hJiS+/TvAHJIT9nt5
 iwINLzlsj1gklB+SWy8kea+HNN4e0S/IEU3uzVyO4Qmfp6aom/PZjdAZBMuWTm3X4o5p2srKZ
 vkvhxSNSkgnx3jrpFkocratUjgVwqisb4wAfs+RYrglFQV3Fe8sNczIDaq9ygx+Zqa95NxE+1
 GVpo+uTIlkuAElMs+KUgdrWARA2e7iNOq5rXyfhA35uZAhvcKU7JrA8hXi4yNysOfq4uK8AK4
 sTLxDqhBX+otEyn4CTKy0Eo6aKE9o1Or/dvkVOaQwsI6Se8tABizVhOs19BSKJvMl0px1ZQQD
 AKh3fumrxH72Mjp8OjEd6zQ2n0YlQUqbOw+VQD4PNeeVlloTwfrgP0u9+yBD2Rd5fhQCwNt8a
 VnTdmHpGn0Mqamv4q3JFvH6x1o6dtJ2wGHH1gzHs904GHp/jAI8myfa0Y/k6bM0s490tJ6Cyg
 +7o3vUoaZK++Kpdfw5X5o1S9yXu5qGLY3dvK7Xxd3GTWKSt3IHBfBJxc6+B6sff1H7QtXk2Ly
 owrGNbtJC/JQjPobPXU/CCzZDzilZ+MdEwuXro9KmxZHh1OJ8PvlcMuG7FNZJK3UZFn5a0rCQ
 to764XB6o0Wg+A6gNompwq8Alc2tzc/LQxhxGgHfI3SxQRtg9q0Hq8P7w7IvvzFVzexySHINH
 ooQ47m7Q0ZyPYU/HGXF3PZa7775tuhh3OsFTDie0M9slWZuLMkliC7HChiwb2snGZORJ5jolX
 q/yENyr1rK4sxn/lJ+DwZvBrvv
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* John Ogness <john.ogness@linutronix.de>:
> On 2022-09-30, Helge Deller <deller@gmx.de> wrote:
> >> I know that it is all hope for good. But there is also a race between
> >> the hlist_empty() and hlist_entry().
> >
> > I wonder if pdc_console() is still needed as it is today.  When this
> > was written, early_console and such didn't worked for parisc as it
> > should. That's proably why we have this register/unregister in here.
> >
> > Would it make sense, and would we gain something for this
> > printk-series, if I'd try to convert pdc_console to a standard
> > earlycon or earlyprintk device?
>
> Having an earlycon or earlyprintk device will not really help you here
> since those drivers will have already unregistered.
>
> However, once we get the new atomic/kthread interface available, it
> certainly would be useful to implement the pdc_console as an atomic
> console.

My idea was to drop most of the pdc console, so that patch #8 and parts
of patch #11 of the printk patch series could be dropped and you won't
need to take care of those parts when introducing the printk
threaded/atomic printing changes.

See patch below. Basically it drops all of the offending code.
I haven't yet checked it into my parisc for-next tree to not break
something.

Helge



=46rom 5b697874e10729136ce7dd7b362b276f35fae56d Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Date: Sat, 1 Oct 2022 00:32:07 +0200
Subject: [PATCH] parisc: Drop PDC console and convert it to an early conso=
le

Rewrite the PDC console to become an early console, which can be used
for kgdb as well.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/arch/parisc/include/asm/pdc.h b/arch/parisc/include/asm/pdc.h
index b643092d4b98..fcbcf9a96c11 100644
=2D-- a/arch/parisc/include/asm/pdc.h
+++ b/arch/parisc/include/asm/pdc.h
@@ -19,9 +19,6 @@ extern unsigned long parisc_pat_pdc_cap; /* PDC capabili=
ties (PAT) */
 #define PDC_TYPE_SYSTEM_MAP	 1 /* 32-bit, but supports PDC_SYSTEM_MAP */
 #define PDC_TYPE_SNAKE		 2 /* Doesn't support SYSTEM_MAP */

-void pdc_console_init(void);	/* in pdc_console.c */
-void pdc_console_restart(void);
-
 void setup_pdc(void);		/* in inventory.c */

 /* wrapper-functions from pdc.c */
diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons.c
index 2661cdd256ae..45a4d2994857 100644
=2D-- a/arch/parisc/kernel/pdc_cons.c
+++ b/arch/parisc/kernel/pdc_cons.c
@@ -1,46 +1,24 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *    PDC Console support - ie use firmware to dump text via boot console
+ *    PDC early console support - ie use firmware to dump text via boot c=
onsole
  *
- *    Copyright (C) 1999-2003 Matthew Wilcox <willy at parisc-linux.org>
- *    Copyright (C) 2000 Martin K Petersen <mkp at mkp.net>
- *    Copyright (C) 2000 John Marvin <jsm at parisc-linux.org>
- *    Copyright (C) 2000-2003 Paul Bame <bame at parisc-linux.org>
- *    Copyright (C) 2000 Philipp Rumpf <prumpf with tux.org>
- *    Copyright (C) 2000 Michael Ang <mang with subcarrier.org>
- *    Copyright (C) 2000 Grant Grundler <grundler with parisc-linux.org>
- *    Copyright (C) 2001-2002 Ryan Bradetich <rbrad at parisc-linux.org>
- *    Copyright (C) 2001 Helge Deller <deller at parisc-linux.org>
- *    Copyright (C) 2001 Thomas Bogendoerfer <tsbogend at parisc-linux.or=
g>
- *    Copyright (C) 2002 Randolph Chung <tausq with parisc-linux.org>
- *    Copyright (C) 2010 Guy Martin <gmsoft at tuxicoman.be>
+ *    Copyright (C) 2001-2022 Helge Deller <deller@gmx.de>
  */

 /*
- *  The PDC console is a simple console, which can be used for debugging
- *  boot related problems on HP PA-RISC machines. It is also useful when =
no
- *  other console works.
- *
  *  This code uses the ROM (=3DPDC) based functions to read and write cha=
racters
  *  from and to PDC's boot path.
  */

-/* Define EARLY_BOOTUP_DEBUG to debug kernel related boot problems.
- * On production kernels EARLY_BOOTUP_DEBUG should be undefined. */
-#define EARLY_BOOTUP_DEBUG
-
-
 #include <linux/kernel.h>
 #include <linux/console.h>
-#include <linux/string.h>
 #include <linux/init.h>
-#include <linux/major.h>
-#include <linux/tty.h>
+#include <linux/serial_core.h>
+#include <linux/kgdb.h>
 #include <asm/page.h>		/* for PAGE0 */
 #include <asm/pdc.h>		/* for iodc_call() proto and friends */

 static DEFINE_SPINLOCK(pdc_console_lock);
-static struct console pdc_cons;

 static void pdc_console_write(struct console *co, const char *s, unsigned=
 count)
 {
@@ -54,210 +32,47 @@ static void pdc_console_write(struct console *co, con=
st char *s, unsigned count)
 	spin_unlock_irqrestore(&pdc_console_lock, flags);
 }

-int pdc_console_poll_key(struct console *co)
+static int kgdb_pdc_read_char(void)
 {
-	int c;
 	unsigned long flags;
+	int c;

 	spin_lock_irqsave(&pdc_console_lock, flags);
 	c =3D pdc_iodc_getc();
 	spin_unlock_irqrestore(&pdc_console_lock, flags);

-	return c;
-}
-
-static int pdc_console_setup(struct console *co, char *options)
-{
-	return 0;
-}
-
-#if defined(CONFIG_PDC_CONSOLE)
-#include <linux/vt_kern.h>
-#include <linux/tty_flip.h>
-
-#define PDC_CONS_POLL_DELAY (30 * HZ / 1000)
-
-static void pdc_console_poll(struct timer_list *unused);
-static DEFINE_TIMER(pdc_console_timer, pdc_console_poll);
-static struct tty_port tty_port;
-
-static int pdc_console_tty_open(struct tty_struct *tty, struct file *filp=
)
-{
-	tty_port_tty_set(&tty_port, tty);
-	mod_timer(&pdc_console_timer, jiffies + PDC_CONS_POLL_DELAY);
-
-	return 0;
-}
-
-static void pdc_console_tty_close(struct tty_struct *tty, struct file *fi=
lp)
-{
-	if (tty->count =3D=3D 1) {
-		del_timer_sync(&pdc_console_timer);
-		tty_port_tty_set(&tty_port, NULL);
-	}
+	return (c <=3D 0) ? NO_POLL_CHAR : c;
 }

-static int pdc_console_tty_write(struct tty_struct *tty, const unsigned c=
har *buf, int count)
+static void kgdb_pdc_write_char(u8 chr)
 {
-	pdc_console_write(NULL, buf, count);
-	return count;
+	if (PAGE0->mem_cons.cl_class !=3D CL_DUPLEX)
+		pdc_console_write(NULL, &chr, 1);
 }

-static unsigned int pdc_console_tty_write_room(struct tty_struct *tty)
-{
-	return 32768; /* no limit, no buffer used */
-}
-
-static const struct tty_operations pdc_console_tty_ops =3D {
-	.open =3D pdc_console_tty_open,
-	.close =3D pdc_console_tty_close,
-	.write =3D pdc_console_tty_write,
-	.write_room =3D pdc_console_tty_write_room,
+static struct kgdb_io kgdb_pdc_io_ops =3D {
+	.name =3D "kgdb_pdc",
+	.read_char =3D kgdb_pdc_read_char,
+	.write_char =3D kgdb_pdc_write_char,
 };

-static void pdc_console_poll(struct timer_list *unused)
-{
-	int data, count =3D 0;
-
-	while (1) {
-		data =3D pdc_console_poll_key(NULL);
-		if (data =3D=3D -1)
-			break;
-		tty_insert_flip_char(&tty_port, data & 0xFF, TTY_NORMAL);
-		count ++;
-	}
-
-	if (count)
-		tty_flip_buffer_push(&tty_port);
-
-	if (pdc_cons.flags & CON_ENABLED)
-		mod_timer(&pdc_console_timer, jiffies + PDC_CONS_POLL_DELAY);
-}
-
-static struct tty_driver *pdc_console_tty_driver;
-
-static int __init pdc_console_tty_driver_init(void)
-{
-	struct tty_driver *driver;
-	int err;
-
-	/* Check if the console driver is still registered.
-	 * It is unregistered if the pdc console was not selected as the
-	 * primary console. */
-
-	struct console *tmp;
-
-	console_lock();
-	for_each_console(tmp)
-		if (tmp =3D=3D &pdc_cons)
-			break;
-	console_unlock();
-
-	if (!tmp) {
-		printk(KERN_INFO "PDC console driver not registered anymore, not creati=
ng %s\n", pdc_cons.name);
-		return -ENODEV;
-	}
-
-	printk(KERN_INFO "The PDC console driver is still registered, removing C=
ON_BOOT flag\n");
-	pdc_cons.flags &=3D ~CON_BOOT;
-
-	driver =3D tty_alloc_driver(1, TTY_DRIVER_REAL_RAW |
-			TTY_DRIVER_RESET_TERMIOS);
-	if (IS_ERR(driver))
-		return PTR_ERR(driver);
-
-	tty_port_init(&tty_port);
-
-	driver->driver_name =3D "pdc_cons";
-	driver->name =3D "ttyB";
-	driver->major =3D MUX_MAJOR;
-	driver->minor_start =3D 0;
-	driver->type =3D TTY_DRIVER_TYPE_SYSTEM;
-	driver->init_termios =3D tty_std_termios;
-	tty_set_operations(driver, &pdc_console_tty_ops);
-	tty_port_link_device(&tty_port, driver, 0);
-
-	err =3D tty_register_driver(driver);
-	if (err) {
-		printk(KERN_ERR "Unable to register the PDC console TTY driver\n");
-		tty_port_destroy(&tty_port);
-		tty_driver_kref_put(driver);
-		return err;
-	}
-
-	pdc_console_tty_driver =3D driver;
-
-	return 0;
-}
-device_initcall(pdc_console_tty_driver_init);
-
-static struct tty_driver * pdc_console_device (struct console *c, int *in=
dex)
+static int __init pdc_earlycon_setup(struct earlycon_device *device,
+				     const char *opt)
 {
-	*index =3D c->index;
-	return pdc_console_tty_driver;
-}
-#else
-#define pdc_console_device NULL
-#endif
-
-static struct console pdc_cons =3D {
-	.name =3D		"ttyB",
-	.write =3D	pdc_console_write,
-	.device =3D	pdc_console_device,
-	.setup =3D	pdc_console_setup,
-	.flags =3D	CON_BOOT | CON_PRINTBUFFER,
-	.index =3D	-1,
-};
+	struct console *earlycon_console;

-static int pdc_console_initialized;
-
-static void pdc_console_init_force(void)
-{
-	if (pdc_console_initialized)
-		return;
-	++pdc_console_initialized;
-
 	/* If the console is duplex then copy the COUT parameters to CIN. */
 	if (PAGE0->mem_cons.cl_class =3D=3D CL_DUPLEX)
 		memcpy(&PAGE0->mem_kbd, &PAGE0->mem_cons, sizeof(PAGE0->mem_cons));

-	/* register the pdc console */
-	register_console(&pdc_cons);
-}
-
-void __init pdc_console_init(void)
-{
-#if defined(EARLY_BOOTUP_DEBUG) || defined(CONFIG_PDC_CONSOLE)
-	pdc_console_init_force();
-#endif
-#ifdef EARLY_BOOTUP_DEBUG
-	printk(KERN_INFO "Initialized PDC Console for debugging.\n");
-#endif
-}
-
-
-/*
- * Used for emergencies. Currently only used if an HPMC occurs. If an
- * HPMC occurs, it is possible that the current console may not be
- * properly initialised after the PDC IO reset. This routine unregisters
- * all of the current consoles, reinitializes the pdc console and
- * registers it.
- */
-
-void pdc_console_restart(void)
-{
-	struct console *console;
+	earlycon_console =3D device->con;
+	earlycon_console->write =3D pdc_console_write;
+	device->port.iotype =3D UPIO_MEM32BE;

-	if (pdc_console_initialized)
-		return;
+	if (IS_ENABLED(CONFIG_KGDB))
+		kgdb_register_io_module(&kgdb_pdc_io_ops);

-	/* If we've already seen the output, don't bother to print it again */
-	if (console_drivers !=3D NULL)
-		pdc_cons.flags &=3D ~CON_PRINTBUFFER;
-
-	while ((console =3D console_drivers) !=3D NULL)
-		unregister_console(console_drivers);
-
-	/* force registering the pdc console */
-	pdc_console_init_force();
+	return 0;
 }
+
+EARLYCON_DECLARE(pdc, pdc_earlycon_setup);
diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index f005ddedb50e..375f38d6e1a4 100644
=2D-- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -70,6 +70,10 @@ void __init setup_cmdline(char **cmdline_p)
 			strlcat(p, "tty0", COMMAND_LINE_SIZE);
 	}

+	/* default to use early console */
+	if (!strstr(p, "earlycon"))
+		strlcat(p, " earlycon=3Dpdc", COMMAND_LINE_SIZE);
+
 #ifdef CONFIG_BLK_DEV_INITRD
 		if (boot_args[2] !=3D 0) /* did palo pass us a ramdisk? */
 		{
@@ -139,8 +143,6 @@ void __init setup_arch(char **cmdline_p)
 	if (__pa((unsigned long) &_end) >=3D KERNEL_INITIAL_SIZE)
 		panic("KERNEL_INITIAL_ORDER too small!");

-	pdc_console_init();
-
 #ifdef CONFIG_64BIT
 	if(parisc_narrow_firmware) {
 		printk(KERN_INFO "Kernel is using PDC in 32-bit mode.\n");
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index b78f1b9d45c1..f9696fbf646c 100644
=2D-- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -239,13 +239,6 @@ void die_if_kernel(char *str, struct pt_regs *regs, l=
ong err)
 	/* unlock the pdc lock if necessary */
 	pdc_emergency_unlock();

-	/* maybe the kernel hasn't booted very far yet and hasn't been able
-	 * to initialize the serial or STI console. In that case we should
-	 * re-enable the pdc console, so that the user will be able to
-	 * identify the problem. */
-	if (!console_drivers)
-		pdc_console_restart();
-
 	if (err)
 		printk(KERN_CRIT "%s (pid %d): %s (code %ld)\n",
 			current->comm, task_pid_nr(current), str, err);
@@ -429,10 +422,6 @@ void parisc_terminate(char *msg, struct pt_regs *regs=
, int code, unsigned long o
 	/* unlock the pdc lock if necessary */
 	pdc_emergency_unlock();

-	/* restart pdc console if necessary */
-	if (!console_drivers)
-		pdc_console_restart();
-
 	/* Not all paths will gutter the processor... */
 	switch(code){

@@ -482,9 +471,7 @@ void notrace handle_interruption(int code, struct pt_r=
egs *regs)
 	unsigned long fault_space =3D 0;
 	int si_code;

-	if (code =3D=3D 1)
-	    pdc_console_restart();  /* switch back to pdc if HPMC */
-	else if (!irqs_disabled_flags(regs->gr[0]))
+	if (!irqs_disabled_flags(regs->gr[0]))
 	    local_irq_enable();

 	/* Security check:
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 877173907c53..898728ab2c18 100644
=2D-- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -602,21 +602,6 @@ config SERIAL_MUX_CONSOLE
 	select SERIAL_CORE_CONSOLE
 	default y

-config PDC_CONSOLE
-	bool "PDC software console support"
-	depends on PARISC && !SERIAL_MUX && VT
-	help
-	  Saying Y here will enable the software based PDC console to be
-	  used as the system console.  This is useful for machines in
-	  which the hardware based console has not been written yet.  The
-	  following steps must be completed to use the PDC console:
-
-	    1. create the device entry (mknod /dev/ttyB0 c 11 0)
-	    2. Edit the /etc/inittab to start a getty listening on /dev/ttyB0
-	    3. Add device ttyB0 to /etc/securetty (if you want to log on as
-		 root on this console.)
-	    4. Change the kernel command console parameter to: console=3DttyB0
-
 config SERIAL_SUNSAB
 	tristate "Sun Siemens SAB82532 serial support"
 	depends on SPARC && PCI
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index 05dae05b6cc9..3b9a44008433 100644
=2D-- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -121,7 +121,7 @@ config KDB_DEFAULT_ENABLE

 config KDB_KEYBOARD
 	bool "KGDB_KDB: keyboard as input device"
-	depends on VT && KGDB_KDB
+	depends on VT && KGDB_KDB && !PARISC
 	default n
 	help
 	  KDB can use a PS/2 type keyboard for an input device
