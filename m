Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA0161F56B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 15:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiKGOSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 09:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiKGORk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:17:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10171D315;
        Mon,  7 Nov 2022 06:16:57 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLhbxNRRzLzgVuMAENy9jlZuW5IHKymo+X5t98vmt7E=;
        b=biEAGa+Rugsj2SX4G+BNsq8EPIYMc1nSHftM4sNymF14x7nqnHnqTM5bbTrZC4Ao72JdFD
        eTy9sSnuQ/YAdPEZmjeT39aFM4mepO2NY5cv7tgSQN2ng7Gm+FW5FWq4V0zEJ+Rp0Qhjvp
        D5EmBmxObSSi6Z/MBmXKgXU7wzspNfdcTkPvjiNC6PGqowBwn21MikFz/RTx0ZSe6a3WvK
        GCyQUMHYmlc9dRQ0lruWDtK9A2vkliI2cC+r41Jo8RkhUyycUsPBPPzKGGCgUWnwbGWcTV
        4/XDTbEtoaG7rBuDjtnF+UqOmm2kRbKMvRA3cXZa7n008/WBKIM/yFusvkZFfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLhbxNRRzLzgVuMAENy9jlZuW5IHKymo+X5t98vmt7E=;
        b=SH/lU/D4g49aRYA0T5dcgahfw8R97npuTuD4r52dmy41thUx2GTJ6aduLe1DBo7JG4JFCb
        zYNyNAOKDVecz9AA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v3 35/40] proc: consoles: use console_list_lock for list iteration
Date:   Mon,  7 Nov 2022 15:22:33 +0106
Message-Id: <20221107141638.3790965-36-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
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

