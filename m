Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBC8628566
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 17:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbiKNQbC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 11:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237694AbiKNQau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:30:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A80E2F01D;
        Mon, 14 Nov 2022 08:29:50 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLhbxNRRzLzgVuMAENy9jlZuW5IHKymo+X5t98vmt7E=;
        b=mfXS5Cw3dKtbQJm9mn+jcg8yDvbnLClYULmacns+jvjhLW6rZek5GuH88Ux2VGAzSEiGM+
        22pWQ8qF/fPePKGvvi1k6uu4aDqJWXFK1WWBjtv0tmYOVBDYEAs/ROS4JLOyUa1YgTJSBS
        FFFAIJonz5AKb777jVgTUWJqIPr38s89l4QvRMZ07iCVdI/jvx0YXISW0ty7Kco/C2TABd
        qo4nWg+wlTKPATLOpOb3qPPDigJsPiZzdmOHVzXM+cn7TZM8nhVmW2F9ayfwK/EOgNftaP
        j5HxMDyy54fs41BQhQzBQDCOEqhxBVcysteCb/v9FgrJKxSVFyAApdCPeSkvZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLhbxNRRzLzgVuMAENy9jlZuW5IHKymo+X5t98vmt7E=;
        b=YF4kcTgIBdDPE43HzqRI7H6KMWjfmgcTt3tzko7kkdkywT7MIrIQCbxb+24VrZ/T8f2Pt3
        dfouT9kVORt4Q/Dg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v4 33/39] proc: consoles: use console_list_lock for list iteration
Date:   Mon, 14 Nov 2022 17:35:26 +0106
Message-Id: <20221114162932.141883-34-john.ogness@linutronix.de>
In-Reply-To: <20221114162932.141883-1-john.ogness@linutronix.de>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
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

