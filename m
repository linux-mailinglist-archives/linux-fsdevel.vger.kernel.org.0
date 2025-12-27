Return-Path: <linux-fsdevel+bounces-72127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A3BCDF9C7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 13:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33B32300F5A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CFE314A80;
	Sat, 27 Dec 2025 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DMUmFiWz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1893148B2
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837821; cv=none; b=pWwCEMAniGl9oxAo5nIX4xTiU4o2wafb4FVqLEumLWBbBtRSvkMsWiMzAj0vxZ2OnD1mxXszoIy7n88iaeZNs7/20YNzsBzTytXzPRgbD8FvJwYD0/T3/O4Xa4RTcfTAbTpT70j14ibmDAFqHvWdIw4z5+fBUv6nHEbSIzgZvtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837821; c=relaxed/simple;
	bh=v10odBRNUVRtYegW6AWVkSJvotaiGNuLgfoYzWWV1rM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=atVKBpDDH2K/6H+i1sPojtVriditUNZq8ZbdyJF89U8/VMWkUqOJojPFu16scj8fF3pi55g8+IWzXBk47IVtrRyOm5ZcEOwlI7DijtLiKw5u3nmjId+xAk+kiKRUMYFgDvM7Cc8SS+6+r6vWhEDXcvCqPO8gjPnmQQJL2SraVSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DMUmFiWz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so81584825e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 04:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837817; x=1767442617; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TucCmhZOA7i1Z82TbHC9/BloO3wYJZCYcsSdo+RW81I=;
        b=DMUmFiWzHX0o702RXlNMcEQ2cD/DjpnfuoHHOJoTIcKKhZIo9omcFr3imdCVOqBaOg
         SVQNjLoTegksSaT63LNuwneYGO4tCgcISdG8wQaQIXAifa+se/Fr4PqdJB9sC8YAUalh
         RM+y7BagUND0Ml2nxuZKJCZMr7qGQfnzG/lF+/8zdVKg8Z9N8WcR+WA1fqxqqg1865bU
         V5sTglDxntuHDXoX9jjEUqtY88NA4CNaWtQhfgXEat2ltH88kk6O4dMte8GJ1N7CnFvy
         +1Qmm3vou72xsyYOlRjnLCNr6BnDjHHtZAcVTTn6jnmQYQpZtvTO9v3HC6v9KZgpSCA4
         xOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837817; x=1767442617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TucCmhZOA7i1Z82TbHC9/BloO3wYJZCYcsSdo+RW81I=;
        b=CIPnA/DtHgIcu2Iz6OmO3q6qLi5cxZBxs0rwivNT+lafz6eh+NmfPYh9diz3oF+fE+
         wuZ7H/Z19/PKey7y9/uq8dYnpaL4RCe/CQ3bRSpO4K6qKI5Lq3EjXOXaG/AmR/L0xoya
         yp+mMyXZoHd2+JG/+2BgvwZNCXjft3ZSaNK+LUtU8C9MdU2gEIJ/Qh7n68ecIveX4laO
         p4NZoUH+zuJRMzAAVVIlJyAycHaJCv44Qc/EWwuhsxbmqWNrMIt4PZDSfrEcLrvD+vux
         8FatUfdd6yCyHabs3La8Vlcvndpp4RJQDUExlWh0PeuqAAVtXuclfyVnNP6wI5H/C4RB
         CGGA==
X-Forwarded-Encrypted: i=1; AJvYcCWK1ViOD5wLjMMYnH1RH3zjIjWxyCui8O7QARiBL3Mt21IsDrGkCOKrJ2ut33ElQ+2e4joNuiKBqf8EX+IH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz39/IpXXJDoU91JI1RETcd5/VnxXpggcxgF2J4WzCqRlZO4Bwx
	UuWxtV/CUcLARAZBc8PmvbvUhlZV1/gyp3fg3sFa7hTAhaWGK9hcPkEZd5tEkUSwLw8=
X-Gm-Gg: AY/fxX5AIJoWowgmlIReR6UiOphiFsJiMuA1PH5PfxKQgAcSY0sLYAxRW59VGQTkXln
	cI5aMN2ganHIV/NMISLB9v+pcWS+FG8Z6EWPrakBi9Kk8DwP0L8clzA7akqBDz0kIUNJYGmQwSm
	0dduYkdYIGs6neTJtLEti5RMhYyu8m75/BVavAhDA1K1RxXDTFWk6EEFSD8kVU8It9HTszYCd1l
	ea6XdOUQpiI5AfCwFKsi+jqEmDQyZeanCWRpcPTh3bM5I85UsS80hf9a9QCz7NrHbyqvWj9bgGc
	3c8EoelMVNL5PcI7aDXmWNqHwqUhYTj1IN/546dHCmfF25pifeFY/gMZF1PrObKr52gn49n5QGQ
	XPGI+WhuMA457L5qEQPpWwKrQd8fjieQv9MHWyRJhx+HjOJBlZSruklTa4FTR0lJGTEC7b+OUp4
	Rz9+XQCV1D
X-Google-Smtp-Source: AGHT+IF/Ogs7VBJ7Lrr7CGG7veshYzlT60dJ+vTxBr8CJY/jnjI8AOD4UQ6PSSMzci7/2/zJylqGqg==
X-Received: by 2002:a05:600c:314f:b0:47d:4fbe:e6cc with SMTP id 5b1f17b1804b1-47d4fbee749mr22553095e9.13.1766837816753;
        Sat, 27 Dec 2025 04:16:56 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:16:56 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:08 -0300
Subject: [PATCH 01/19] printk/nbcon: Use an enum to specify the required
 callback in console_is_usable()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-1-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=7808;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=v10odBRNUVRtYegW6AWVkSJvotaiGNuLgfoYzWWV1rM=;
 b=pFG5z/R9mPhdW0GcbWwBqAYRxphqjaw37XiHB8zK2Svw6cgWPnnbt5ix8LVRTlDSXoMKx6YOe
 j641rf88XbSCyYZnTx7OjU6MTkBS6ecM7BDrludb53BNNBG+/Mhcz0A
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The current usage of console_is_usable() is clumsy. The parameter
@use_atomic is boolean and thus not self-explanatory. The function is
called twice in situations when there are no-strict requirements.

Replace it with enum nbcon_write_cb which provides a more descriptive
values for all 3 situations: atomic, thread or any.

Note that console_is_usable() checks only NBCON_USE_ATOMIC because
.write_thread() callback is mandatory. But the other two values still
make sense because they describe the intention of the caller.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/um/kernel/kmsg_dump.c |  3 ++-
 include/linux/console.h    | 20 +++++++++++++++++---
 kernel/debug/kdb/kdb_io.c  |  2 +-
 kernel/printk/nbcon.c      |  8 ++++----
 kernel/printk/printk.c     | 16 ++++++++--------
 5 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index fc0f543d1d8e..8ae38308b67c 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -31,7 +31,8 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 		 * expected to output the crash information.
 		 */
 		if (strcmp(con->name, "ttynull") != 0 &&
-		    console_is_usable(con, console_srcu_read_flags(con), true)) {
+		    console_is_usable(con, console_srcu_read_flags(con),
+				      NBCON_USE_ATOMIC)) {
 			break;
 		}
 	}
diff --git a/include/linux/console.h b/include/linux/console.h
index fc9f5c5c1b04..35c03fc4ed51 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -202,6 +202,19 @@ enum cons_flags {
 	CON_NBCON_ATOMIC_UNSAFE	= BIT(9),
 };
 
+/**
+ * enum nbcon_write_cb - Defines which nbcon write() callback must be used based
+ *                       on the caller context.
+ * @NBCON_USE_ATOMIC: Use con->write_atomic().
+ * @NBCON_USE_THREAD: Use con->write_thread().
+ * @NBCON_USE_ANY:    The caller does not have any strict requirements.
+ */
+enum nbcon_write_cb {
+	NBCON_USE_ATOMIC,
+	NBCON_USE_THREAD,
+	NBCON_USE_ANY,
+};
+
 /**
  * struct nbcon_state - console state for nbcon consoles
  * @atom:	Compound of the state fields for atomic operations
@@ -622,7 +635,8 @@ extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
  * which can also play a role in deciding if @con can be used to print
  * records.
  */
-static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
+static inline bool console_is_usable(struct console *con, short flags,
+				     enum nbcon_write_cb nwc)
 {
 	if (!(flags & CON_ENABLED))
 		return false;
@@ -631,7 +645,7 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
 		return false;
 
 	if (flags & CON_NBCON) {
-		if (use_atomic) {
+		if (nwc & NBCON_USE_ATOMIC) {
 			/* The write_atomic() callback is optional. */
 			if (!con->write_atomic)
 				return false;
@@ -679,7 +693,7 @@ static inline bool nbcon_kdb_try_acquire(struct console *con,
 					 struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }
 static inline bool console_is_usable(struct console *con, short flags,
-				     bool use_atomic) { return false; }
+				     enum nbcon_write_cb nwc) { return false; }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 61c1690058ed..6ffb962392a4 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -591,7 +591,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	for_each_console_srcu(c) {
 		short flags = console_srcu_read_flags(c);
 
-		if (!console_is_usable(c, flags, true))
+		if (!console_is_usable(c, flags, NBCON_USE_ATOMIC))
 			continue;
 		if (c == dbg_io_ops->cons)
 			continue;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index be5a04367e60..13865ef85990 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1184,7 +1184,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 	cookie = console_srcu_read_lock();
 
 	flags = console_srcu_read_flags(con);
-	if (console_is_usable(con, flags, false)) {
+	if (console_is_usable(con, flags, NBCON_USE_THREAD)) {
 		/* Bring the sequence in @ctxt up to date */
 		ctxt->seq = nbcon_seq_read(con);
 
@@ -1251,7 +1251,7 @@ static int nbcon_kthread_func(void *__console)
 
 		con_flags = console_srcu_read_flags(con);
 
-		if (console_is_usable(con, con_flags, false))
+		if (console_is_usable(con, con_flags, NBCON_USE_THREAD))
 			backlog = nbcon_emit_one(&wctxt, false);
 
 		console_srcu_read_unlock(cookie);
@@ -1650,7 +1650,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
 		if (!(flags & CON_NBCON))
 			continue;
 
-		if (!console_is_usable(con, flags, true))
+		if (!console_is_usable(con, flags, NBCON_USE_ATOMIC))
 			continue;
 
 		if (nbcon_seq_read(con) >= stop_seq)
@@ -1904,7 +1904,7 @@ void nbcon_device_release(struct console *con)
 	 */
 	cookie = console_srcu_read_lock();
 	printk_get_console_flush_type(&ft);
-	if (console_is_usable(con, console_srcu_read_flags(con), true) &&
+	if (console_is_usable(con, console_srcu_read_flags(con), NBCON_USE_ATOMIC) &&
 	    !ft.nbcon_offload &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		/*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7394f1b6033b..5f4b84f9562e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3203,7 +3203,9 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 		if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
 			continue;
 
-		if (!console_is_usable(con, flags, !do_cond_resched))
+		if (!console_is_usable(con, flags,
+				       do_cond_resched ? NBCON_USE_THREAD
+						       : NBCON_USE_ATOMIC))
 			continue;
 		any_usable = true;
 
@@ -3392,7 +3394,7 @@ void console_unblank(void)
 	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if (!console_is_usable(c, console_srcu_read_flags(c), true))
+		if (!console_is_usable(c, console_srcu_read_flags(c), NBCON_USE_ATOMIC))
 			continue;
 
 		if (c->unblank) {
@@ -3432,7 +3434,7 @@ void console_unblank(void)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if (!console_is_usable(c, console_srcu_read_flags(c), true))
+		if (!console_is_usable(c, console_srcu_read_flags(c), NBCON_USE_ATOMIC))
 			continue;
 
 		if (c->unblank)
@@ -3633,7 +3635,7 @@ static bool legacy_kthread_should_wakeup(void)
 		if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
 			continue;
 
-		if (!console_is_usable(con, flags, false))
+		if (!console_is_usable(con, flags, NBCON_USE_THREAD))
 			continue;
 
 		if (flags & CON_NBCON) {
@@ -4204,7 +4206,7 @@ static int unregister_console_locked(struct console *console)
 
 	if (!console_is_registered_locked(console))
 		res = -ENODEV;
-	else if (console_is_usable(console, console->flags, true))
+	else if (console_is_usable(console, console->flags, NBCON_USE_ATOMIC))
 		__pr_flush(console, 1000, true);
 
 	/* Disable it unconditionally */
@@ -4485,10 +4487,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c, flags, true) &&
-			    !console_is_usable(c, flags, false)) {
+			if (!console_is_usable(c, flags, NBCON_USE_ANY))
 				continue;
-			}
 
 			if (flags & CON_NBCON) {
 				printk_seq = nbcon_seq_read(c);

-- 
2.52.0


