Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3105E867B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 02:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiIXAFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 20:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiIXAFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BCAA5712;
        Fri, 23 Sep 2022 17:05:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hP5hgE3NqqWAe7NsJh2Zg4V0BgzlJ82nPhD5UvfqL1c=;
        b=ZhjExFnt3DHjT6MAszFYGWDIA+0wrrgI55Wiz/TKYY7681Ifuj3NZatGKcFv+V24ss9EjN
        nnN9VuHE8djfIzuxXeCAdrKVQOc/0xQsbQrV5VjLH4H7CKvhj7lJqUDSMyZR+v2oXKPm4g
        mg5J3lbKrVhB7xaO/OyzCU+4uaOUax0b6jptRyy1YtTSeYgoavf4QsCfgoRUrhjFRO/9Cw
        si5NANo0SfuQKZa0SxWsUgAHo7Z4S/V5jcUjseRBxZ3PVlQDW/zwxV188OF+jONkAwtDJG
        c3qc5d4tUUa2jFibijWRl822uD7E8F8enucx2ScKdzT04dnZEGxZvJwkFIIMwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hP5hgE3NqqWAe7NsJh2Zg4V0BgzlJ82nPhD5UvfqL1c=;
        b=p6mv1TLxByq/wgGx21NhPWw2upD3WUZ/VdIJV4lxWZ71oHLwkrysDugo/cKRsLctIcetVH
        U7JbpTDTxH/BM/Bw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH printk 11/18] printk: Convert console_drivers list to hlist
Date:   Sat, 24 Sep 2022 02:10:47 +0206
Message-Id: <20220924000454.3319186-12-john.ogness@linutronix.de>
In-Reply-To: <20220924000454.3319186-1-john.ogness@linutronix.de>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
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

Replace the open coded single linked list with a hlist so a conversion to
SRCU protected list walks can reuse the existing primitives.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/parisc/kernel/pdc_cons.c | 19 +++----
 fs/proc/consoles.c            |  5 +-
 include/linux/console.h       | 15 ++++--
 kernel/printk/printk.c        | 99 +++++++++++++++++++----------------
 4 files changed, 75 insertions(+), 63 deletions(-)

diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons.c
index 9a0c0932d2f9..3f9abf0263ee 100644
--- a/arch/parisc/kernel/pdc_cons.c
+++ b/arch/parisc/kernel/pdc_cons.c
@@ -147,13 +147,8 @@ static int __init pdc_console_tty_driver_init(void)
 
 	struct console *tmp;
 
-	console_lock();
-	for_each_console(tmp)
-		if (tmp == &pdc_cons)
-			break;
-	console_unlock();
-
-	if (!tmp) {
+	/* Pretend that this works as much as it pretended to work historically */
+	if (hlist_unhashed_lockless(&pdc_cons.node)) {
 		printk(KERN_INFO "PDC console driver not registered anymore, not creating %s\n", pdc_cons.name);
 		return -ENODEV;
 	}
@@ -272,15 +267,17 @@ void pdc_console_restart(bool hpmc)
 	if (pdc_console_initialized)
 		return;
 
-	if (!hpmc && console_drivers)
+	if (!hpmc && !hlist_empty(&console_list))
 		return;
 
 	/* If we've already seen the output, don't bother to print it again */
-	if (console_drivers != NULL)
+	if (!hlist_empty(&console_list))
 		pdc_cons.flags &= ~CON_PRINTBUFFER;
 
-	while ((console = console_drivers) != NULL)
-		unregister_console(console_drivers);
+	while (!hlist_empty(&console_list)) {
+		unregister_console(READ_ONCE(hlist_entry(console_list.first,
+							 struct console, node)));
+	}
 
 	/* force registering the pdc console */
 	pdc_console_init_force();
diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index 6775056eecd5..70994d1e52f6 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -74,8 +74,11 @@ static void *c_start(struct seq_file *m, loff_t *pos)
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct console *con = v;
+
 	++*pos;
-	return con->next;
+	hlist_for_each_entry_continue(con, node)
+		break;
+	return con;
 }
 
 static void c_stop(struct seq_file *m, void *v)
diff --git a/include/linux/console.h b/include/linux/console.h
index 86a6125512b9..1e3d0a50cef1 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -15,6 +15,7 @@
 #define _LINUX_CONSOLE_H_ 1
 
 #include <linux/atomic.h>
+#include <linux/list.h>
 #include <linux/types.h>
 
 struct vc_data;
@@ -154,15 +155,19 @@ struct console {
 	u64	seq;
 	unsigned long dropped;
 	void	*data;
-	struct	 console *next;
+	struct hlist_node node;
 };
 
 #ifdef CONFIG_LOCKDEP
+extern void lockdep_assert_console_lock_held(void);
 extern void lockdep_assert_console_list_lock_held(void);
 #else
+static inline void lockdep_assert_console_lock_held(void) { }
 static inline void lockdep_assert_console_list_lock_held(void) { }
 #endif
 
+extern struct hlist_head console_list;
+
 extern void console_list_lock(void) __acquires(console_mutex);
 extern void console_list_unlock(void) __releases(console_mutex);
 
@@ -175,7 +180,7 @@ extern void console_list_unlock(void) __releases(console_mutex);
  */
 #define for_each_registered_console(con)				\
 	lockdep_assert_console_list_lock_held();			\
-	for (con = console_drivers; con != NULL; con = con->next)
+	hlist_for_each_entry(con, &console_list, node)
 
 /**
  * for_each_console() - Iterator over registered consoles
@@ -185,7 +190,8 @@ extern void console_list_unlock(void) __releases(console_mutex);
  * list is immutable.
  */
 #define for_each_console(con)						\
-	for (con = console_drivers; con != NULL; con = con->next)
+	lockdep_assert_console_lock_held();				\
+	hlist_for_each_entry(con, &console_list, node)
 
 /**
  * for_each_console_kgdb() - Iterator over registered consoles for KGDB
@@ -195,7 +201,7 @@ extern void console_list_unlock(void) __releases(console_mutex);
  * Don't use outside of the KGDB fairy tale land!
  */
 #define for_each_console_kgdb(con)					\
-	for (con = console_drivers; con != NULL; con = con->next)
+	hlist_for_each_entry(con, &console_list, node)
 
 extern int console_set_on_cmdline;
 extern struct console *early_console;
@@ -208,7 +214,6 @@ enum con_flush_mode {
 extern int add_preferred_console(char *name, int idx, char *options);
 extern void register_console(struct console *);
 extern int unregister_console(struct console *);
-extern struct console *console_drivers;
 extern void console_lock(void);
 extern int console_trylock(void);
 extern void console_unlock(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 80a728ef9d96..f1d31dcbd6ba 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -79,20 +79,20 @@ int oops_in_progress;
 EXPORT_SYMBOL(oops_in_progress);
 
 /*
- * console_sem protects the console_drivers list, and also provides
- * serialization for access to the entire console driver system.
+ * console_sem protects onsole_list, and also provides serialization for
+ * access to the entire console driver system.
  *
  * console_mutex serializes register/unregister.
  *
  * console_sem must be taken inside a console_mutex locked section
- * for any list manipulation in order to keep the console BKL
+ * for any console_list manipulation in order to keep the console BKL
  * machinery happy. This requirement also applies to manipulation
  * of console->flags.
  */
 static DEFINE_MUTEX(console_mutex);
 static DEFINE_SEMAPHORE(console_sem);
-struct console *console_drivers;
-EXPORT_SYMBOL_GPL(console_drivers);
+HLIST_HEAD(console_list);
+EXPORT_SYMBOL_GPL(console_list);
 
 /*
  * System may need to suppress printk message under certain
@@ -111,6 +111,11 @@ static struct lockdep_map console_lock_dep_map = {
 	.name = "console_lock"
 };
 
+void lockdep_assert_console_lock_held(void)
+{
+	lockdep_assert(lock_is_held(&console_lock_dep_map));
+}
+
 void lockdep_assert_console_list_lock_held(void)
 {
 	lockdep_assert_held(&console_mutex);
@@ -2591,7 +2596,7 @@ static int console_cpu_notify(unsigned int cpu)
  * console_lock - lock the console system for exclusive use.
  *
  * Acquires a lock which guarantees that the caller has
- * exclusive access to the console system and the console_drivers list.
+ * exclusive access to the console system and console_list.
  *
  * Can sleep, returns nothing.
  */
@@ -2611,7 +2616,7 @@ EXPORT_SYMBOL(console_lock);
  * console_trylock - try to lock the console system for exclusive use.
  *
  * Try to acquire a lock which guarantees that the caller has exclusive
- * access to the console system and the console_drivers list.
+ * access to the console system and console_list.
  *
  * returns 1 on success, and 0 on failure to acquire the lock.
  */
@@ -2979,7 +2984,15 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		u64 seq;
 
 		seq = prb_first_valid_seq(prb);
-		for_each_console(c)
+		/*
+		 * This cannot use for_each_console() because it's not established
+		 * that the current context has console locked and neither there is
+		 * a guarantee that there is no concurrency in that case.
+		 *
+		 * Open code it for documentation purposes and pretend that
+		 * it works.
+		 */
+		hlist_for_each_entry(c, &console_list, node)
 			c->seq = seq;
 	}
 	console_unlock();
@@ -3120,6 +3133,9 @@ static void try_enable_default_console(struct console *newcon)
 	       (con->flags & CON_BOOT) ? "boot" : "",	\
 	       con->name, con->index, ##__VA_ARGS__)
 
+#define cons_first()					\
+	hlist_entry(console_list.first, struct console, node)
+
 static int console_unregister_locked(struct console *console);
 
 /*
@@ -3182,8 +3198,8 @@ void register_console(struct console *newcon)
 	 * flag set and will be first in the list.
 	 */
 	if (preferred_console < 0) {
-		if (!console_drivers || !console_drivers->device ||
-		    console_drivers->flags & CON_BOOT) {
+		if (hlist_empty(&console_list) || !cons_first()->device ||
+		    cons_first()->flags & CON_BOOT) {
 			try_enable_default_console(newcon);
 		}
 	}
@@ -3211,21 +3227,17 @@ void register_console(struct console *newcon)
 	}
 
 	/*
-	 *	Put this console in the list - keep the
-	 *	preferred driver at the head of the list.
+	 * Put this console in the list and keep the referred driver at the
+	 * head of the list.
 	 */
 	console_lock();
-	if ((newcon->flags & CON_CONSDEV) || console_drivers == NULL) {
-		newcon->next = console_drivers;
-		console_drivers = newcon;
-		if (newcon->next)
-			newcon->next->flags &= ~CON_CONSDEV;
-		/* Ensure this flag is always set for the head of the list */
-		newcon->flags |= CON_CONSDEV;
-	} else {
-		newcon->next = console_drivers->next;
-		console_drivers->next = newcon;
-	}
+	if (newcon->flags & CON_CONSDEV || hlist_empty(&console_list))
+		hlist_add_head(&newcon->node, &console_list);
+	else
+		hlist_add_behind(&newcon->node, console_list.first);
+
+	/* Ensure this flag is always set for the head of the list */
+	cons_first()->flags |= CON_CONSDEV;
 
 	newcon->dropped = 0;
 	if (newcon->flags & CON_PRINTBUFFER) {
@@ -3251,7 +3263,9 @@ void register_console(struct console *newcon)
 	if (bootcon_enabled &&
 	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
 	    !keep_bootcon) {
-		for_each_console(con) {
+		struct hlist_node *tmp;
+
+		hlist_for_each_entry_safe(con, tmp, &console_list, node) {
 			if (con->flags & CON_BOOT)
 				console_unregister_locked(con);
 		}
@@ -3263,7 +3277,6 @@ EXPORT_SYMBOL(register_console);
 
 static int console_unregister_locked(struct console *console)
 {
-	struct console *con;
 	int res;
 
 	con_printk(KERN_INFO, console, "disabled\n");
@@ -3274,32 +3287,28 @@ static int console_unregister_locked(struct console *console)
 	if (res > 0)
 		return 0;
 
-	res = -ENODEV;
 	console_lock();
-	if (console_drivers == console) {
-		console_drivers=console->next;
-		res = 0;
-	} else {
-		for_each_console(con) {
-			if (con->next == console) {
-				con->next = console->next;
-				res = 0;
-				break;
-			}
-		}
-	}
 
-	if (res)
-		goto out_disable_unlock;
+	/* Disable it unconditionally */
+	console->flags &= ~CON_ENABLED;
+
+	if (hlist_unhashed(&console->node))
+		goto out_unlock;
+
+	hlist_del_init(&console->node);
 
 	/*
+	 * <HISTORICAL>
 	 * If this isn't the last console and it has CON_CONSDEV set, we
 	 * need to set it on the next preferred console.
+	 * </HISTORICAL>
+	 *
+	 * The above makes no sense as there is no guarantee that the next
+	 * console has any device attached. Oh well....
 	 */
-	if (console_drivers != NULL && console->flags & CON_CONSDEV)
-		console_drivers->flags |= CON_CONSDEV;
+	if (!hlist_empty(&console_list) && console->flags & CON_CONSDEV)
+		cons_first()->flags |= CON_CONSDEV;
 
-	console->flags &= ~CON_ENABLED;
 	console_unlock();
 	console_sysfs_notify();
 
@@ -3308,10 +3317,8 @@ static int console_unregister_locked(struct console *console)
 
 	return res;
 
-out_disable_unlock:
-	console->flags &= ~CON_ENABLED;
+out_unlock:
 	console_unlock();
-
 	return res;
 }
 
-- 
2.30.2

