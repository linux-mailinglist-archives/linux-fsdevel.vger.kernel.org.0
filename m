Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186066A89DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 20:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCBT6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjCBT5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087C94743A;
        Thu,  2 Mar 2023 11:57:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yj+YRLcxasSK2Pr36OxlyCW12ZJIKbcJmPt2KN23fnk=;
        b=q0zx+CQAWzAd3CsFCV0mps1oEewIWbGVkVJHEYLq3UwUGl0le4p55y3jpO8RtTEJCo1Xu3
        h/nIH3TRoOQRc78cCLN24mxnCZh4PWeeA5Ow/9tP4tNC5r4DJssuYylMYNE/kVNWR/h4Bz
        gJHmefuvh69DrctBafZISV1c0YYxZwkznh3GRZMG++mOyCK10+pqvUUC4Zb+frHnsAq0wl
        JCpTdfDavMFMMFYKxGWy5IEc2t6TyL+bcpaHoUzvnHdAd0ac79Za7OuWtWoSLcLX8g2fYh
        9ZeNeRwtsFioL6DxLwJfYZNaMIR+ai6g2oCPR5th2FoqJKpLKUIFhx5wu8z/IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yj+YRLcxasSK2Pr36OxlyCW12ZJIKbcJmPt2KN23fnk=;
        b=e4u+AHjyLLx27mBhuY/PR6fdYBpXDMV1DR6iEafBPhGU4LP9j8mdaBPYZ6VuNlGlHww0b2
        91WcrEWlX45z9ZCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v1 05/18] printk: Add non-BKL console basic infrastructure
Date:   Thu,  2 Mar 2023 21:02:05 +0106
Message-Id: <20230302195618.156940-6-john.ogness@linutronix.de>
In-Reply-To: <20230302195618.156940-1-john.ogness@linutronix.de>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The current console/printk subsystem is protected by a Big Kernel Lock,
(aka console_lock) which has ill defined semantics and is more or less
stateless. This puts severe limitations on the console subsystem and
makes forced takeover and output in emergency and panic situations a
fragile endavour which is based on try and pray.

The goal of non-BKL consoles is to break out of the console lock jail
and to provide a new infrastructure that avoids the pitfalls and
allows console drivers to be gradually converted over.

The proposed infrastructure aims for the following properties:

  - Per console locking instead of global locking
  - Per console state which allows to make informed decisions
  - Stateful handover and takeover

As a first step state is added to struct console. The per console state
is an atomic_long_t with a 32bit bit field and on 64bit also a 32bit
sequence for tracking the last printed ringbuffer sequence number. On
32bit the sequence is separate from state for obvious reasons which
requires handling a few extra race conditions.

Reserve state bits, which will be populated later in the series. Wire
it up into the console register/unregister functionality and exclude
such consoles from being handled in the console BKL mechanisms. Since
the non-BKL consoles will not depend on the console lock/unlock dance
for printing, only perform said dance if a BKL console is registered.

The decision to use a bitfield was made as using a plain u32 with
mask/shift operations turned out to result in uncomprehensible code.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 fs/proc/consoles.c           |   1 +
 include/linux/console.h      |  33 +++++++++
 kernel/printk/Makefile       |   2 +-
 kernel/printk/internal.h     |  10 +++
 kernel/printk/printk.c       |  50 +++++++++++--
 kernel/printk/printk_nobkl.c | 137 +++++++++++++++++++++++++++++++++++
 6 files changed, 226 insertions(+), 7 deletions(-)
 create mode 100644 kernel/printk/printk_nobkl.c

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index e0758fe7936d..9ce506866e60 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -21,6 +21,7 @@ static int show_console_dev(struct seq_file *m, void *v)
 		{ CON_ENABLED,		'E' },
 		{ CON_CONSDEV,		'C' },
 		{ CON_BOOT,		'B' },
+		{ CON_NO_BKL,		'N' },
 		{ CON_PRINTBUFFER,	'p' },
 		{ CON_BRL,		'b' },
 		{ CON_ANYTIME,		'a' },
diff --git a/include/linux/console.h b/include/linux/console.h
index f7967fb238e0..b9d2ad580128 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -155,6 +155,8 @@ static inline int con_debug_leave(void)
  *			/dev/kmesg which requires a larger output buffer.
  * @CON_SUSPENDED:	Indicates if a console is suspended. If true, the
  *			printing callbacks must not be called.
+ * @CON_NO_BKL:		Console can operate outside of the BKL style console_lock
+ *			constraints.
  */
 enum cons_flags {
 	CON_PRINTBUFFER		= BIT(0),
@@ -165,6 +167,32 @@ enum cons_flags {
 	CON_BRL			= BIT(5),
 	CON_EXTENDED		= BIT(6),
 	CON_SUSPENDED		= BIT(7),
+	CON_NO_BKL		= BIT(8),
+};
+
+/**
+ * struct cons_state - console state for NOBKL consoles
+ * @atom:	Compound of the state fields for atomic operations
+ * @seq:	Sequence for record tracking (64bit only)
+ * @bits:	Compound of the state bits below
+ *
+ * To be used for state read and preparation of atomic_long_cmpxchg()
+ * operations.
+ */
+struct cons_state {
+	union {
+		unsigned long	atom;
+		struct {
+#ifdef CONFIG_64BIT
+			u32	seq;
+#endif
+			union {
+				u32	bits;
+				struct {
+				};
+			};
+		};
+	};
 };
 
 /**
@@ -186,6 +214,8 @@ enum cons_flags {
  * @dropped:		Number of unreported dropped ringbuffer records
  * @data:		Driver private data
  * @node:		hlist node for the console list
+ *
+ * @atomic_state:	State array for NOBKL consoles; real and handover
  */
 struct console {
 	char			name[16];
@@ -205,6 +235,9 @@ struct console {
 	unsigned long		dropped;
 	void			*data;
 	struct hlist_node	node;
+
+	/* NOBKL console specific members */
+	atomic_long_t		__private atomic_state[2];
 };
 
 #ifdef CONFIG_LOCKDEP
diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
index f5b388e810b9..b36683bd2f82 100644
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y	= printk.o
-obj-$(CONFIG_PRINTK)	+= printk_safe.o
+obj-$(CONFIG_PRINTK)	+= printk_safe.o printk_nobkl.o
 obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
 obj-$(CONFIG_PRINTK_INDEX)	+= index.o
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 2a17704136f1..da380579263b 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -3,6 +3,7 @@
  * internal.h - printk internal definitions
  */
 #include <linux/percpu.h>
+#include <linux/console.h>
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
 void __init printk_sysctl_init(void);
@@ -61,6 +62,10 @@ void defer_console_output(void);
 
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
+
+void cons_nobkl_cleanup(struct console *con);
+void cons_nobkl_init(struct console *con);
+
 #else
 
 #define PRINTK_PREFIX_MAX	0
@@ -76,8 +81,13 @@ u16 printk_parse_prefix(const char *text, int *level,
 #define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
 
 static inline bool printk_percpu_data_ready(void) { return false; }
+static inline void cons_nobkl_init(struct console *con) { }
+static inline void cons_nobkl_cleanup(struct console *con) { }
+
 #endif /* CONFIG_PRINTK */
 
+extern bool have_boot_console;
+
 /**
  * struct printk_buffers - Buffers to read/format/output printk messages.
  * @outbuf:	After formatting, contains text to output.
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 626d467c7e9b..b2c7c92c3d79 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -446,6 +446,19 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_MUTEX(syslog_lock);
 
+/*
+ * Specifies if a BKL console was ever registered. Used to determine if the
+ * console lock/unlock dance is needed for console printing.
+ */
+static bool have_bkl_console;
+
+/*
+ * Specifies if a boot console is registered. Used to determine if NOBKL
+ * consoles may be used since NOBKL consoles cannot synchronize with boot
+ * consoles.
+ */
+bool have_boot_console;
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
@@ -2301,7 +2314,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched) {
+	if (!in_sched && have_bkl_console) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2624,7 +2637,7 @@ void resume_console(void)
  */
 static int console_cpu_notify(unsigned int cpu)
 {
-	if (!cpuhp_tasks_frozen) {
+	if (!cpuhp_tasks_frozen && have_bkl_console) {
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
@@ -3098,6 +3111,9 @@ void console_unblank(void)
 	struct console *c;
 	int cookie;
 
+	if (!have_bkl_console)
+		return;
+
 	/*
 	 * Stop console printing because the unblank() callback may
 	 * assume the console is not within its write() callback.
@@ -3135,6 +3151,9 @@ void console_unblank(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
+	if (!have_bkl_console)
+		return;
+
 	/*
 	 * If someone else is holding the console lock, trylock will fail
 	 * and may_schedule may be set.  Ignore and proceed to unlock so
@@ -3310,9 +3329,10 @@ static void try_enable_default_console(struct console *newcon)
 		newcon->flags |= CON_CONSDEV;
 }
 
-#define con_printk(lvl, con, fmt, ...)			\
-	printk(lvl pr_fmt("%sconsole [%s%d] " fmt),	\
-	       (con->flags & CON_BOOT) ? "boot" : "",	\
+#define con_printk(lvl, con, fmt, ...)				\
+	printk(lvl pr_fmt("%s%sconsole [%s%d] " fmt),		\
+	       (con->flags & CON_NO_BKL) ? "" : "legacy ",	\
+	       (con->flags & CON_BOOT) ? "boot" : "",		\
 	       con->name, con->index, ##__VA_ARGS__)
 
 static void console_init_seq(struct console *newcon, bool bootcon_registered)
@@ -3472,6 +3492,14 @@ void register_console(struct console *newcon)
 	newcon->dropped = 0;
 	console_init_seq(newcon, bootcon_registered);
 
+	if (!(newcon->flags & CON_NO_BKL))
+		have_bkl_console = true;
+	else
+		cons_nobkl_init(newcon);
+
+	if (newcon->flags & CON_BOOT)
+		have_boot_console = true;
+
 	/*
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
@@ -3515,6 +3543,9 @@ void register_console(struct console *newcon)
 			if (con->flags & CON_BOOT)
 				unregister_console_locked(con);
 		}
+
+		/* All boot consoles have been unregistered. */
+		have_boot_console = false;
 	}
 unlock:
 	console_list_unlock();
@@ -3563,6 +3594,9 @@ static int unregister_console_locked(struct console *console)
 	 */
 	synchronize_srcu(&console_srcu);
 
+	if (console->flags & CON_NO_BKL)
+		cons_nobkl_cleanup(console);
+
 	console_sysfs_notify();
 
 	if (console->exit)
@@ -3866,11 +3900,15 @@ void wake_up_klogd(void)
  */
 void defer_console_output(void)
 {
+	int val = PRINTK_PENDING_WAKEUP;
+
 	/*
 	 * New messages may have been added directly to the ringbuffer
 	 * using vprintk_store(), so wake any waiters as well.
 	 */
-	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
+	if (have_bkl_console)
+		val |= PRINTK_PENDING_OUTPUT;
+	__wake_up_klogd(val);
 }
 
 void printk_trigger_flush(void)
diff --git a/kernel/printk/printk_nobkl.c b/kernel/printk/printk_nobkl.c
new file mode 100644
index 000000000000..8df3626808dd
--- /dev/null
+++ b/kernel/printk/printk_nobkl.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH, John Ogness
+// Copyright (C) 2022 Intel, Thomas Gleixner
+
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include "internal.h"
+/*
+ * Printk implementation for consoles that do not depend on the BKL style
+ * console_lock mechanism.
+ *
+ * Console is locked on a CPU when state::locked is set and state:cpu ==
+ * current CPU. This is valid for the current execution context.
+ *
+ * Nesting execution contexts on the same CPU can carefully take over
+ * if the driver allows reentrancy via state::unsafe = false. When the
+ * interrupted context resumes it checks the state before entering
+ * an unsafe region and aborts the operation if it detects a takeover.
+ *
+ * In case of panic or emergency the nesting context can take over the
+ * console forcefully. The write callback is then invoked with the unsafe
+ * flag set in the write context data, which allows the driver side to avoid
+ * locks and to evaluate the driver state so it can use an emergency path
+ * or repair the state instead of blindly assuming that it works.
+ *
+ * If the interrupted context touches the assigned record buffer after
+ * takeover, it does not cause harm because at the same execution level
+ * there is no concurrency on the same CPU. A threaded printer always has
+ * its own record buffer so it can never interfere with any of the per CPU
+ * record buffers.
+ *
+ * A concurrent writer on a different CPU can request to take over the
+ * console by:
+ *
+ *	1) Carefully writing the desired state into state[REQ]
+ *	   if there is no same or higher priority request pending.
+ *	   This locks state[REQ] except for higher priority
+ *	   waiters.
+ *
+ *	2) Setting state[CUR].req_prio unless a same or higher
+ *	   priority waiter won the race.
+ *
+ *	3) Carefully spin on state[CUR] until that is locked with the
+ *	   expected state. When the state is not the expected one then it
+ *	   has to verify that state[REQ] is still the same and that
+ *	   state[CUR] has not been taken over or unlocked.
+ *
+ *      The unlocker hands over to state[REQ], but only if state[CUR]
+ *	matches.
+ *
+ * In case that the owner does not react on the request and does not make
+ * observable progress, the waiter will timeout and can then decide to do
+ * a hostile takeover.
+ */
+
+#define copy_full_state(_dst, _src)	do { _dst = _src; } while (0)
+#define copy_bit_state(_dst, _src)	do { _dst.bits = _src.bits; } while (0)
+
+#ifdef CONFIG_64BIT
+#define copy_seq_state64(_dst, _src)	do { _dst.seq = _src.seq; } while (0)
+#else
+#define copy_seq_state64(_dst, _src)	do { } while (0)
+#endif
+
+enum state_selector {
+	CON_STATE_CUR,
+	CON_STATE_REQ,
+};
+
+/**
+ * cons_state_set - Helper function to set the console state
+ * @con:	Console to update
+ * @which:	Selects real state or handover state
+ * @new:	The new state to write
+ *
+ * Only to be used when the console is not yet or no longer visible in the
+ * system. Otherwise use cons_state_try_cmpxchg().
+ */
+static inline void cons_state_set(struct console *con, enum state_selector which,
+				  struct cons_state *new)
+{
+	atomic_long_set(&ACCESS_PRIVATE(con, atomic_state[which]), new->atom);
+}
+
+/**
+ * cons_state_read - Helper function to read the console state
+ * @con:	Console to update
+ * @which:	Selects real state or handover state
+ * @state:	The state to store the result
+ */
+static inline void cons_state_read(struct console *con, enum state_selector which,
+				   struct cons_state *state)
+{
+	state->atom = atomic_long_read(&ACCESS_PRIVATE(con, atomic_state[which]));
+}
+
+/**
+ * cons_state_try_cmpxchg() - Helper function for atomic_long_try_cmpxchg() on console state
+ * @con:	Console to update
+ * @which:	Selects real state or handover state
+ * @old:	Old/expected state
+ * @new:	New state
+ *
+ * Returns: True on success, false on fail
+ */
+static inline bool cons_state_try_cmpxchg(struct console *con,
+					  enum state_selector which,
+					  struct cons_state *old,
+					  struct cons_state *new)
+{
+	return atomic_long_try_cmpxchg(&ACCESS_PRIVATE(con, atomic_state[which]),
+				       &old->atom, new->atom);
+}
+
+/**
+ * cons_nobkl_init - Initialize the NOBKL console specific data
+ * @con:	Console to initialize
+ */
+void cons_nobkl_init(struct console *con)
+{
+	struct cons_state state = { };
+
+	cons_state_set(con, CON_STATE_CUR, &state);
+	cons_state_set(con, CON_STATE_REQ, &state);
+}
+
+/**
+ * cons_nobkl_cleanup - Cleanup the NOBKL console specific data
+ * @con:	Console to cleanup
+ */
+void cons_nobkl_cleanup(struct console *con)
+{
+	struct cons_state state = { };
+
+	cons_state_set(con, CON_STATE_CUR, &state);
+	cons_state_set(con, CON_STATE_REQ, &state);
+}
-- 
2.30.2

