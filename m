Return-Path: <linux-fsdevel+bounces-72129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD54CCDF9B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 13:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A36C300AB16
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 12:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E6E314B82;
	Sat, 27 Dec 2025 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NXWK6S0A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53604314A97
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837841; cv=none; b=DF5ayPskD+LzGO0GnFPUoisKcFBK6OYj6eTmFXPSTwOYZL+8aNvs4ijHqY4UFGcKPW6TEweSQtRv8lSZwVRCfWwgMVYYWZwIo9PmbP3WdshOtCSGUMbgMwb8NEhzsv2Ap5/cCNudR0HxwqFgFBqPbCkAl2N83XugsxM1ktJqyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837841; c=relaxed/simple;
	bh=vcl36sWudeP+4+BFFAGNAn9YWtzCJyjmd2BzAWTnD/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NEoAYykCcAJgwa8T9Sz7eNJ4RPuwYIJxyaOOtmeyBS6U1H1PGHGVtw5ldnTB42mz5JpzlA+rPF2dfEnTh/EkQfoJL33kDqS/FswbxYcP75nxxTVrm0v8fC/efx631TG3q5KZn0U8yiN2qXxvYXIFcGDJGHbhP67VaaxfCJT0zfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NXWK6S0A; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so13334855e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 04:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837835; x=1767442635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTPebJjNeKwkChbLQ9kmEHnfHiLVqL0OXrUmcfcwYxQ=;
        b=NXWK6S0ACaSgQaSFIonroOyyns/rivmpoluuxUW/K9Zi41lIb3jtECLiSX5c5qrZjf
         wqqyIr5VBK7CKSGBktMRkJY3bQs9W7yURvjPpVLUTIpALUUfB+x1A57I9PiJMNgzUzbu
         awDSS40GPWbiEJ2xZq1Fa2mkqbSeCF89UTLwJF6+uN87wIV+Og7lHMIY8u6IYCNB25zF
         anEun/A6wUP7bpF9FO2eD+aRABRDQXPncxnyc5Wkphp5jEIzWSZYkY9/AvKubpKgWQ+h
         fFBE8k9dJZ4W6HqDsio5QTPvIB5Bm4rkT87osuIRyye4YVNZIqkLUbXD5DwCn1LbXAyD
         nTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837835; x=1767442635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uTPebJjNeKwkChbLQ9kmEHnfHiLVqL0OXrUmcfcwYxQ=;
        b=Mq/btCjd7Fid1ChE3BoeFmRLpaBmosmi5o0qOXbNe3fsHOOsVYuiQObkJ4FfWZ5UJe
         /Vfj/e1ygRkJ6BNrLrW6N7TKcSvC7vX8+RXQvBEfLXYfv5ZORCKBwvX6aY2/7isnK3/p
         piszq3L4Atzo56GqFIna0d2csqZr4KNSz7h2hQYtRJ7LJdi56AxsWsOH57lHd7JTNCkg
         HxOlqG6xkYUvBrdE0wqStB0Ix76iB0csQr28M4bgxQzaS2ALUKVmukBGPm3swG5tvDnx
         Z0rHgEIF80O1IXnqFUHhqCOW/a+FXlmNFV3TwYa2qI7gJ0ORfmYk7skApQWlfHiIBQB8
         QaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZS+eOx9LUy3UoW2UUXYORzbS1auIwAZqr4hswHiub0pEa+Ev2CaZw+Xod5CPBj0wTFIu7GVKQG0Kp5UKO@vger.kernel.org
X-Gm-Message-State: AOJu0YxrFqWX49joi191LCra5f/bOdmpzkvHCB+WDYNAXDudHYANiLSd
	1crwv/myXpAPncx6nCTs4B0ZaTJaX1fAcg5c9Ic0+Zi3u957nsIwDgDbYtVurPW85PA=
X-Gm-Gg: AY/fxX71Xiph2NBruKQ/LDF0u4fPLQ/UJ+KpfBJEakQ9stUbwkIVotmA+5orw2U83gd
	HCtLxwXao4ikv/x7o455cHxxgO3RWH/Mg6JD1EUkgB8WYlpUZEn+ebr8bfx+gVQ3r/KU6At47yh
	/Gj5tcYnVhQCDry+UepbWG4cDaTCI5hyKyma3VuotakNDfUlcDrB94lX5mRzfygrzr1q+txj+8S
	XO1+ZuGlNSZ5OoJ/CIx9of0S8N9Txx1x8ymqVg8gANfCv4dbfLwC1zTZWOtfDgkgQnBczU6R19L
	fCF/hSJXex5BfcGWjauRQDQ6Hbk/OViSDjCyakorFnFbQEiAEzSmRO48jZcxXyT/HkBtF5S4sQg
	a/+Yth3jWOC5xYM2fKfVI/86QLGUmXnOJbr5EtcAFSfv5c2yG+ickVYNQCbwmIZF67wSniEHFz4
	R0Lp+Bmcuqk4bmpyF09qU=
X-Google-Smtp-Source: AGHT+IGwp3EjluLXDesoC0JEyXRGphsbQ8YoWlvkj2Od8DQXEn5G/ySQT/x4pqGRl4etLgLjbGQKkA==
X-Received: by 2002:a05:600c:1912:b0:477:89d5:fdac with SMTP id 5b1f17b1804b1-47d1959f714mr329425925e9.31.1766837835139;
        Sat, 27 Dec 2025 04:17:15 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:17:14 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:10 -0300
Subject: [PATCH 03/19] printk: Drop flags argument from console_is_usable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-3-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=9456;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=vcl36sWudeP+4+BFFAGNAn9YWtzCJyjmd2BzAWTnD/U=;
 b=iD+souMtKfrrqeYTmzgK7GoB+YnYwBZz+b3u1u3z79Hjhj/LyjffFTb6T+KYy3fwP+rT9y9HK
 hjNxNGyaArtAX5IV24Lh1tykQ434DvLfReICQgaATUhSR+uxoFOqy3O
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The flags argument was also used to check if CON_NBCON was set, but their
usage was fixed in the last commit. All current users are reading the
variable just to call console_is_usable.

By calling console_srcu_read_flags inside console_is_usable makes the
code cleaner and removes one argument from the function.

Along with it, create a variant called __console_is_usable that can be
used under console_list_lock(), like unregister_console_locked.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/um/kernel/kmsg_dump.c |  3 +--
 include/linux/console.h    | 25 +++++++++++++++++--------
 kernel/debug/kdb/kdb_io.c  |  4 +---
 kernel/printk/nbcon.c      | 15 ++++-----------
 kernel/printk/printk.c     | 20 +++++++-------------
 5 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 8ae38308b67c..ca80232cfa2a 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -31,8 +31,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 		 * expected to output the crash information.
 		 */
 		if (strcmp(con->name, "ttynull") != 0 &&
-		    console_is_usable(con, console_srcu_read_flags(con),
-				      NBCON_USE_ATOMIC)) {
+		    console_is_usable(con, NBCON_USE_ATOMIC)) {
 			break;
 		}
 	}
diff --git a/include/linux/console.h b/include/linux/console.h
index dd4ec7a5bff9..648cf10e3f93 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -656,13 +656,8 @@ extern bool nbcon_kdb_try_acquire(struct console *con,
 				  struct nbcon_write_context *wctxt);
 extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
 
-/*
- * Check if the given console is currently capable and allowed to print
- * records. Note that this function does not consider the current context,
- * which can also play a role in deciding if @con can be used to print
- * records.
- */
-static inline bool console_is_usable(struct console *con, short flags,
+/* Variant of console_is_usable() when the console_list_lock is held. */
+static inline bool __console_is_usable(struct console *con, short flags,
 				     enum nbcon_write_cb nwc)
 {
 	if (!(flags & CON_ENABLED))
@@ -707,6 +702,18 @@ static inline bool console_is_usable(struct console *con, short flags,
 	return true;
 }
 
+/*
+ * Check if the given console is currently capable and allowed to print
+ * records. Note that this function does not consider the current context,
+ * which can also play a role in deciding if @con can be used to print
+ * records.
+ */
+static inline bool console_is_usable(struct console *con,
+				     enum nbcon_write_cb nwc)
+{
+	return __console_is_usable(con, console_srcu_read_flags(con), nwc);
+}
+
 #else
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
@@ -719,7 +726,9 @@ static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
 static inline bool nbcon_kdb_try_acquire(struct console *con,
 					 struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }
-static inline bool console_is_usable(struct console *con, short flags,
+static inline bool __console_is_usable(struct console *con, short flags,
+				       enum nbcon_write_cb nwc) { return false; }
+static inline bool console_is_usable(struct console *con,
 				     enum nbcon_write_cb nwc) { return false; }
 #endif
 
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index d6de512b433a..642eab746577 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -589,9 +589,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		short flags = console_srcu_read_flags(c);
-
-		if (!console_is_usable(c, flags, NBCON_USE_ATOMIC))
+		if (!console_is_usable(c, NBCON_USE_ATOMIC))
 			continue;
 		if (c == dbg_io_ops->cons)
 			continue;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index f0f42e212caa..f0659c1e50ed 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1164,7 +1164,6 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
 static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_context *ctxt)
 {
 	bool ret = false;
-	short flags;
 	int cookie;
 
 	if (kthread_should_stop())
@@ -1183,8 +1182,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 
 	cookie = console_srcu_read_lock();
 
-	flags = console_srcu_read_flags(con);
-	if (console_is_usable(con, flags, NBCON_USE_THREAD)) {
+	if (console_is_usable(con, NBCON_USE_THREAD)) {
 		/* Bring the sequence in @ctxt up to date */
 		ctxt->seq = nbcon_seq_read(con);
 
@@ -1209,7 +1207,6 @@ static int nbcon_kthread_func(void *__console)
 		.ctxt.prio	= NBCON_PRIO_NORMAL,
 	};
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
-	short con_flags;
 	bool backlog;
 	int cookie;
 
@@ -1249,9 +1246,7 @@ static int nbcon_kthread_func(void *__console)
 		 */
 		cookie = console_srcu_read_lock();
 
-		con_flags = console_srcu_read_flags(con);
-
-		if (console_is_usable(con, con_flags, NBCON_USE_THREAD))
+		if (console_is_usable(con, NBCON_USE_THREAD))
 			backlog = nbcon_emit_one(&wctxt, false);
 
 		console_srcu_read_unlock(cookie);
@@ -1645,12 +1640,10 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
-		short flags = console_srcu_read_flags(con);
-
 		if (!console_is_nbcon(con))
 			continue;
 
-		if (!console_is_usable(con, flags, NBCON_USE_ATOMIC))
+		if (!console_is_usable(con, NBCON_USE_ATOMIC))
 			continue;
 
 		if (nbcon_seq_read(con) >= stop_seq)
@@ -1904,7 +1897,7 @@ void nbcon_device_release(struct console *con)
 	 */
 	cookie = console_srcu_read_lock();
 	printk_get_console_flush_type(&ft);
-	if (console_is_usable(con, console_srcu_read_flags(con), NBCON_USE_ATOMIC) &&
+	if (console_is_usable(con, NBCON_USE_ATOMIC) &&
 	    !ft.nbcon_offload &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		/*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index bd0d574be3cf..b03ffc23c27c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3191,7 +3191,6 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
-		short flags = console_srcu_read_flags(con);
 		u64 printk_seq;
 		bool progress;
 
@@ -3203,9 +3202,8 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 		if (console_is_nbcon(con) && (ft.nbcon_atomic || ft.nbcon_offload))
 			continue;
 
-		if (!console_is_usable(con, flags,
-				       do_cond_resched ? NBCON_USE_THREAD
-						       : NBCON_USE_ATOMIC))
+		if (!console_is_usable(con, do_cond_resched ? NBCON_USE_THREAD
+							    : NBCON_USE_ATOMIC))
 			continue;
 		any_usable = true;
 
@@ -3394,7 +3392,7 @@ void console_unblank(void)
 	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if (!console_is_usable(c, console_srcu_read_flags(c), NBCON_USE_ATOMIC))
+		if (!console_is_usable(c, NBCON_USE_ATOMIC))
 			continue;
 
 		if (c->unblank) {
@@ -3434,7 +3432,7 @@ void console_unblank(void)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if (!console_is_usable(c, console_srcu_read_flags(c), NBCON_USE_ATOMIC))
+		if (!console_is_usable(c, NBCON_USE_ATOMIC))
 			continue;
 
 		if (c->unblank)
@@ -3621,7 +3619,6 @@ static bool legacy_kthread_should_wakeup(void)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
-		short flags = console_srcu_read_flags(con);
 		u64 printk_seq;
 
 		/*
@@ -3632,7 +3629,7 @@ static bool legacy_kthread_should_wakeup(void)
 		if (console_is_nbcon(con) && (ft.nbcon_atomic || ft.nbcon_offload))
 			continue;
 
-		if (!console_is_usable(con, flags, NBCON_USE_THREAD))
+		if (!console_is_usable(con, NBCON_USE_THREAD))
 			continue;
 
 		if (console_is_nbcon(con)) {
@@ -4203,7 +4200,7 @@ static int unregister_console_locked(struct console *console)
 
 	if (!console_is_registered_locked(console))
 		res = -ENODEV;
-	else if (console_is_usable(console, console->flags, NBCON_USE_ATOMIC))
+	else if (__console_is_usable(console, console->flags, NBCON_USE_ATOMIC))
 		__pr_flush(console, 1000, true);
 
 	/* Disable it unconditionally */
@@ -4430,7 +4427,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
-	short flags;
 	int cookie;
 	u64 diff;
 	u64 seq;
@@ -4477,14 +4473,12 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (con && con != c)
 				continue;
 
-			flags = console_srcu_read_flags(c);
-
 			/*
 			 * If consoles are not usable, it cannot be expected
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c, flags, NBCON_USE_ANY))
+			if (!console_is_usable(c, NBCON_USE_ANY))
 				continue;
 
 			if (console_is_nbcon(c)) {

-- 
2.52.0


