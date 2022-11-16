Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C4662C436
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 17:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbiKPQYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 11:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbiKPQXD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:23:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6617658BE1;
        Wed, 16 Nov 2022 08:22:15 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLhbxNRRzLzgVuMAENy9jlZuW5IHKymo+X5t98vmt7E=;
        b=qybUVOHQ3lcpPJORwUZxfRKNSDT/E1lW8xR9jQFAUnk+CmGFCk6egkthMCR3TQeua2DtWM
        VyojWSc5t+MeGT9e4X2IlZEDixaROC4FQDK+95FFmvVk3mBvNNZZurhDgYXAjTiINlLEpF
        qg4PxKKgKoK5ZTSTBHifiUwP480lYx3KbdCcXDHRTbRcqsdmOZnVSY0fGJZ8UV9PZv5U3V
        o2INZ38YMktP/5lqXKutOY83w6LM0Iv/JvaPFKxh05++GiySPm5y//mPl3U1g2AGNuTkCg
        CJFulvLQk226W5njRJXauh3efYaiUiH+LlheE8AI7XiIf0Zi9/Vf7eqCzK8qTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLhbxNRRzLzgVuMAENy9jlZuW5IHKymo+X5t98vmt7E=;
        b=HsEGN6tMo3uc7PUkebWaEn1oYTUp5bx/ZwX+WR68pMluY1e7aak5EW/DR9K2+PrfNPUAQ1
        iiHhLYBATOPUnIDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v5 34/40] proc: consoles: use console_list_lock for list iteration
Date:   Wed, 16 Nov 2022 17:27:46 +0106
Message-Id: <20221116162152.193147-35-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
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

The console_lock is used in part to guarantee safe list iteration.
The console_list_lock should be used because list synchronization
responsibility will be removed from the console_lock in a later
change.

Note, the console_lock is still needed to serialize the device()
callback with other console operations.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 fs/proc/consoles.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index 46b305fa04ed..e0758fe7936d 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -33,7 +33,16 @@ static int show_console_dev(struct seq_file *m, void *v)
 	if (con->device) {
 		const struct tty_driver *driver;
 		int index;
+
+		/*
+		 * Take console_lock to serialize device() callback with
+		 * other console operations. For example, fg_console is
+		 * modified under console_lock when switching vt.
+		 */
+		console_lock();
 		driver = con->device(con, &index);
+		console_unlock();
+
 		if (driver) {
 			dev = MKDEV(driver->major, driver->minor_start);
 			dev += index;
@@ -64,15 +73,11 @@ static void *c_start(struct seq_file *m, loff_t *pos)
 	loff_t off = 0;
 
 	/*
-	 * Take console_lock to serialize device() callback with
-	 * other console operations. For example, fg_console is
-	 * modified under console_lock when switching vt.
-	 *
-	 * Hold the console_lock to guarantee safe traversal of the
+	 * Hold the console_list_lock to guarantee safe traversal of the
 	 * console list. SRCU cannot be used because there is no
 	 * place to store the SRCU cookie.
 	 */
-	console_lock();
+	console_list_lock();
 	for_each_console(con)
 		if (off++ == *pos)
 			break;
@@ -90,7 +95,7 @@ static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 
 static void c_stop(struct seq_file *m, void *v)
 {
-	console_unlock();
+	console_list_unlock();
 }
 
 static const struct seq_operations consoles_op = {
-- 
2.30.2

