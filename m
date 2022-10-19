Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52844604AA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiJSPIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 11:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiJSPGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:06:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C213F36798;
        Wed, 19 Oct 2022 07:59:31 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9ps/+3zFTTMX/Xw+H343+FOn0pASHbTafsRYfPyD80=;
        b=xryRBIthFWhP4UrwlfzbLHB1wneSnBcBBrCWGbfzhFtyZZ62blHFAAWadbR3RfJ0xiS3D8
        E8G/EiTVA2QAo78BFXu4HLdwD+wAF6JL8ZZPT3fT3XiPQ0U3QnQkiqFxYtRNWpb8fxr2Cx
        A/Cmed+jZKcC1QRl0fM0J5BhpF3Ep4COPsunR9DMwyMVrS6nOyn1FZdHgAvIlS9jd3c3/u
        DNATXphbwlgI1vTSZ6DZy++PAOL/yQeAkH6xkw/VIyWpUi46a/OKZkof+PQOokG1dN51E3
        ScxR1SESvRXx3+MDvobD2S55zRzzj6vOpkbNnDYcWKvXBeaZ6jqGRdPZWw68+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9ps/+3zFTTMX/Xw+H343+FOn0pASHbTafsRYfPyD80=;
        b=nK0TpZ0gm/hS4UwI6UaYUoHDooyjpXsBf4rDrK5NbkFeKSjWQqGLTzLJJFbqmldTgUwgZh
        deKrFqZ6DM/L2uDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v2 36/38] proc: consoles: use console_list_lock for list iteration
Date:   Wed, 19 Oct 2022 17:01:58 +0206
Message-Id: <20221019145600.1282823-37-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-1-john.ogness@linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
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
repsponsibility will be removed from the console_lock in a later
change.

Note, the console_lock is still needed to stop console printing.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 fs/proc/consoles.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index 32512b477605..77409b176569 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -33,7 +33,15 @@ static int show_console_dev(struct seq_file *m, void *v)
 	if (con->device) {
 		const struct tty_driver *driver;
 		int index;
+
+		/*
+		 * Stop console printing because the device() callback may
+		 * assume the console is not within its write() callback.
+		 */
+		console_lock();
 		driver = con->device(con, &index);
+		console_unlock();
+
 		if (driver) {
 			dev = MKDEV(driver->major, driver->minor_start);
 			dev += index;
@@ -64,14 +72,11 @@ static void *c_start(struct seq_file *m, loff_t *pos)
 	loff_t off = 0;
 
 	/*
-	 * Stop console printing because the device() callback may
-	 * assume the console is not within its write() callback.
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
@@ -89,7 +94,7 @@ static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 
 static void c_stop(struct seq_file *m, void *v)
 {
-	console_unlock();
+	console_list_unlock();
 }
 
 static const struct seq_operations consoles_op = {
-- 
2.30.2

