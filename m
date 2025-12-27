Return-Path: <linux-fsdevel+bounces-72132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B7ACDFA1A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 13:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25602305D111
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 12:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6C4315D3B;
	Sat, 27 Dec 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FBrHxmDD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C0A26B755
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837870; cv=none; b=jJvaNyCwQ9YlEg7hAMy/va8hc2pwe7laX2ExM8k8t9LjmDAZK1SOd51+q7mNK/lV1RMlEJ9XSNqkLA930JUhwnOl7hB9vHFkJ67oFHzpehIIqNJMvARbfFFTHLxKZ/8GhInFWQRPTtYtosYo7e+osNjeuigwm83pW2BOB7sAxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837870; c=relaxed/simple;
	bh=yZ/nvvnmmkaNmxpD4iXjZtoziYkh4kvSpXf/WZXovX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpAjWtXxBso6mhT+tZB8zWVwc18A2TA2PASq0ovgSf+bQb+Ip+hLAOnGJrVrWBqwT2rAy5DRyvOm/HNkmEsxSLIrEE+LcQgeE+0iBc5Plrpm35+Rw6Y4xC1lYpKRb31dg+pSbaZ9DLFVLaRD2Teuy85qHR43uopmks0jNND/NiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FBrHxmDD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47774d3536dso61933995e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 04:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837863; x=1767442663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qC0U4cjRdxCF4b/YJbgVpXPFvwbnk17NoVL2cOfc8A=;
        b=FBrHxmDDFdYfINgqhAiqXYPMrsW8mIbvLbhCfbQv4l5Sxl2hJQZHMkjCc7mhVHQ0de
         hWg+gYDPPRQX11AVLkMVF3VbhKVRunkr2P3ECneKx5lC45Jnc3x4LwBCwju8hi1PCNGd
         T3Lh13k94jDuOtjOOADU500Sr7XyAlcEjQ1n4Ruw1gPFdpNZ1tjPmnI3g0Mx27+9W4Uo
         IPNcbryhOqj1WUt9IGOZjBV04iL5Zg0P+orF1AOvz/lOk5tMhRwLbj6LJqCVz9jBW7n6
         FZ7x9a7Iw6UO9fy/IBn50ekomFNhj61VPhbhh+ELnIoNiK/qdKJFj/cjQdRfYdhBoC3Z
         2nBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837863; x=1767442663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8qC0U4cjRdxCF4b/YJbgVpXPFvwbnk17NoVL2cOfc8A=;
        b=aW/3kwz2ty+HBITZGvTdMaYyGVgOhg8tQ96DZ7df3ne8wI520SAQP3Yx1Lx/mpGv9E
         EQ48ROF5RJdiI0/gJ0LooFZ82h+pkp545+E/5mDpqAE0DSWIyLuyZu9v2FqJSSPfKawc
         8GghVgloX87DQFzAft4LYJJ92N+HD81FI//Pse096RRvh2reqPxBnM3V7NtShk1jG4V7
         xUcIgO+IrsSmPAga19iNyFlUTUfG+UNk4UoyqfmmRutoe938XA7wNtDjG/XXV9sOrlvT
         uC9JBaalC5+Bo4tkzM9GQ15AfVM7MFHVHEKOQenRPJUZelQNnASlvi9q0P9oKaTZ8Ar3
         DSJg==
X-Forwarded-Encrypted: i=1; AJvYcCVx9W8W58KOHAIGfptZg3ZgyCf7uA7a92siBULUcqbEBIHnPey/JvbtIBasKSQao16jygaH8XDcW1fY5+Vy@vger.kernel.org
X-Gm-Message-State: AOJu0YwflwjHHelcpC/LEmHOdxndP5MdLXocjtvapDN7I3HwNSO9SqEj
	zqRPvEyaJzwW8Fn2+/TnYUq1GXsKyaWJaTvs1hYMyx9wJdpFsxvFKGqs0GLJTiVykHg=
X-Gm-Gg: AY/fxX5DF76SXTqHQG2RBtfJ8qvajgiY9gnVaL37sDCWf3Dgg9Fms+ukpYw5I7VGiPO
	WmNvpn8b1VLgFhc1dZrUNmuTB9kcJx3DksE5HfH+38GwhodF6eEfSECe7TkpDbcNA1iTmtgNNCx
	SAOcBBs8Oj/FgzcLSL+FifjYNeWnMTF/e1JFVOq4q0o/QKs7iFhsTZgveh9Y2lw+/jYNc3lfDyE
	QYMy338MGCmeiJ2t8kR7LA4r7d2LkaSrhrQabriID02ohZ5sAkJ296KtEY4QeRcMjTXtEBUwEt6
	lKGKdwFr29mzs01mbo0UMpcVeGd8EPiKIHT+OSRMAjFkPeHVVi0RjJ1H3u0oezmDAWsfuGIgwlt
	JwOr3CFVlBTBtMYqvAavh1DKlx9vO/WOhHxKgVijEkZ2C4iZdrz0NsD41512SybaPrG0u0P+RD2
	5oKptMVts3VCp3EQZT/NI=
X-Google-Smtp-Source: AGHT+IG9JI4KghQQLO4JoQ5Zx3PCxaurUWQYnoyI9pepg6l828D4iHu4xsQcwAkRrVG/7RHQ7XMpOg==
X-Received: by 2002:a05:600c:3397:b0:475:d91d:28fb with SMTP id 5b1f17b1804b1-47be2999657mr224830455e9.4.1766837862676;
        Sat, 27 Dec 2025 04:17:42 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:17:42 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:13 -0300
Subject: [PATCH 06/19] printk: Introduce register_console_force
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-6-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=5702;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=yZ/nvvnmmkaNmxpD4iXjZtoziYkh4kvSpXf/WZXovX8=;
 b=Bzarxjf3B7CuE6yunxTz81Z6xrtzP/oSyuvyRHrm78aAxtHdfrdz9xczyh+zQMNScnR1tQowx
 BZmWRp2B3qfBQ9NUKyPZEo6SC7UASze6iocMjN2ThffW7UbTy1hRyur
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function will register a console even if it
wasn't specified on boot. The new function will act like all consoles
being registered were using the CON_ENABLED flag.

The CON_ENABLED flag will be removed in the following patches and the
drivers that use it will migrate to register_console_force instead.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h |  1 +
 kernel/printk/printk.c  | 65 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index caf9b0951129..7d374a29a625 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -792,6 +792,7 @@ enum con_flush_mode {
 extern int add_preferred_console(const char *name, const short idx, char *options);
 extern void console_force_preferred_locked(struct console *con);
 extern void register_console(struct console *);
+extern void register_console_force(struct console *c);
 extern int unregister_console(struct console *);
 extern void console_lock(void);
 extern int console_trylock(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 85a8b6521d9e..c5c05e4d0a67 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3858,7 +3858,7 @@ static int console_call_setup(struct console *newcon, char *options)
  * enabled such as netconsole
  */
 static int try_enable_preferred_console(struct console *newcon,
-					bool user_specified)
+					bool user_specified, bool force)
 {
 	struct console_cmdline *c;
 	int i, err;
@@ -3896,12 +3896,15 @@ static int try_enable_preferred_console(struct console *newcon,
 		return 0;
 	}
 
+	if (force)
+		newcon->flags |= CON_ENABLED;
+
 	/*
 	 * Some consoles, such as pstore and netconsole, can be enabled even
 	 * without matching. Accept the pre-enabled consoles only when match()
 	 * and setup() had a chance to be called.
 	 */
-	if (newcon->flags & CON_ENABLED && c->user_specified ==	user_specified)
+	if (newcon->flags & CON_ENABLED && c->user_specified == user_specified)
 		return 0;
 
 	return -ENOENT;
@@ -4001,26 +4004,11 @@ static u64 get_init_console_seq(struct console *newcon, bool bootcon_registered)
 
 static int unregister_console_locked(struct console *console);
 
-/*
- * The console driver calls this routine during kernel initialization
- * to register the console printing procedure with printk() and to
- * print any messages that were printed by the kernel before the
- * console driver was initialized.
- *
- * This can happen pretty early during the boot process (because of
- * early_printk) - sometimes before setup_arch() completes - be careful
- * of what kernel features are used - they may not be initialised yet.
- *
- * There are two types of consoles - bootconsoles (early_printk) and
- * "real" consoles (everything which is not a bootconsole) which are
- * handled differently.
- *  - Any number of bootconsoles can be registered at any time.
- *  - As soon as a "real" console is registered, all bootconsoles
- *    will be unregistered automatically.
- *  - Once a "real" console is registered, any attempt to register a
- *    bootconsoles will be rejected
+/**
+ * __register_console: Register a new console
+ * @force: Register the console even if not specified on boot
  */
-void register_console(struct console *newcon)
+static void __register_console(struct console *newcon, bool force)
 {
 	bool use_device_lock = (newcon->flags & CON_NBCON) && newcon->write_atomic;
 	bool bootcon_registered = false;
@@ -4080,11 +4068,11 @@ void register_console(struct console *newcon)
 	}
 
 	/* See if this console matches one we selected on the command line */
-	err = try_enable_preferred_console(newcon, true);
+	err = try_enable_preferred_console(newcon, true, force);
 
 	/* If not, try to match against the platform default(s) */
 	if (err == -ENOENT)
-		err = try_enable_preferred_console(newcon, false);
+		err = try_enable_preferred_console(newcon, false, force);
 
 	/* printk() messages are not printed to the Braille console. */
 	if (err || newcon->flags & CON_BRL) {
@@ -4185,8 +4173,39 @@ void register_console(struct console *newcon)
 unlock:
 	console_list_unlock();
 }
+
+/*
+ * The console driver calls this routine during kernel initialization
+ * to register the console printing procedure with printk() and to
+ * print any messages that were printed by the kernel before the
+ * console driver was initialized.
+ *
+ * This can happen pretty early during the boot process (because of
+ * early_printk) - sometimes before setup_arch() completes - be careful
+ * of what kernel features are used - they may not be initialised yet.
+ *
+ * There are two types of consoles - bootconsoles (early_printk) and
+ * "real" consoles (everything which is not a bootconsole) which are
+ * handled differently.
+ *  - Any number of bootconsoles can be registered at any time.
+ *  - As soon as a "real" console is registered, all bootconsoles
+ *    will be unregistered automatically.
+ *  - Once a "real" console is registered, any attempt to register a
+ *    bootconsoles will be rejected
+ */
+void register_console(struct console *newcon)
+{
+	__register_console(newcon, false);
+}
 EXPORT_SYMBOL(register_console);
 
+
+void register_console_force(struct console *newcon)
+{
+	__register_console(newcon, true);
+}
+EXPORT_SYMBOL(register_console_force);
+
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {

-- 
2.52.0


