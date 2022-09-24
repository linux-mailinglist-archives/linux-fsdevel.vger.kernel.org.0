Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C3E5E8679
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 02:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiIXAFN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 20:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiIXAFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F50A405A;
        Fri, 23 Sep 2022 17:05:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4OGWc0QkUJ6JpVm6AppOXfX1G2JfqpiTA52+HrwtTY=;
        b=wo5y13ZPqu7DG6xhkiOjxCXrMVZOmvijPkCUMdYOJ31rMot8dZf8lnPnndgkqQZYsRRDNt
        WcmpGX3QbCsXgfqhOZ/s0OqTaoRUq9H+WrPRTlbqbt3ndKez5/S3bqJIkepkMudA5sV10r
        qoAXPDOwTvLKsqeD2aXLPrBY3Pj7pKQk9H9QAn/3C473rVtbmlVWnprk2M9aFDw58A4s+j
        3rvoe1SnJtb1eoJesQ28wBHlgFJXHEo2Kp5SbtxIIJn2A+GCmw+/zJp9XNhb4I3p8rhH3I
        zhtUXfV6wrrVy6nIhaGnJ6NvGP2FWWU3CsDNS8LjzfSM6oEn1cpyo6UH+NOGYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4OGWc0QkUJ6JpVm6AppOXfX1G2JfqpiTA52+HrwtTY=;
        b=uY274NzrecLhyeA7K/R69mxN8EakigvmJU+z/05LIgT426Zvq92N4bWZKZIy8fTjRCVtO5
        5Cwa0yC0zEZz2tDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH printk 07/18] printk: Convert console list walks for readers to list lock
Date:   Sat, 24 Sep 2022 02:10:43 +0206
Message-Id: <20220924000454.3319186-8-john.ogness@linutronix.de>
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

Facilities which expose console information to sysfs or procfs can use the
new list protection to keep the list stable. No need to hold console lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/tty/tty_io.c   | 6 +++---
 fs/proc/consoles.c     | 6 +++---
 kernel/printk/printk.c | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8fec1d8648f5..6fa142155b94 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3535,8 +3535,8 @@ static ssize_t show_cons_active(struct device *dev,
 	struct console *c;
 	ssize_t count = 0;
 
-	console_lock();
-	for_each_console(c) {
+	console_list_lock();
+	for_each_registered_console(c) {
 		if (!c->device)
 			continue;
 		if (!c->write)
@@ -3560,7 +3560,7 @@ static ssize_t show_cons_active(struct device *dev,
 
 		count += sprintf(buf + count, "%c", i ? ' ':'\n');
 	}
-	console_unlock();
+	console_list_unlock();
 
 	return count;
 }
diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index dfe6ce3505ce..6775056eecd5 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -63,8 +63,8 @@ static void *c_start(struct seq_file *m, loff_t *pos)
 	struct console *con;
 	loff_t off = 0;
 
-	console_lock();
-	for_each_console(con)
+	console_list_lock();
+	for_each_registered_console(con)
 		if (off++ == *pos)
 			break;
 
@@ -80,7 +80,7 @@ static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 
 static void c_stop(struct seq_file *m, void *v)
 {
-	console_unlock();
+	console_list_unlock();
 }
 
 static const struct seq_operations consoles_op = {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8c56f6071873..80a728ef9d96 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2990,18 +2990,18 @@ void console_flush_on_panic(enum con_flush_mode mode)
  */
 struct tty_driver *console_device(int *index)
 {
-	struct console *c;
 	struct tty_driver *driver = NULL;
+	struct console *c;
 
-	console_lock();
-	for_each_console(c) {
+	console_list_lock();
+	for_each_registered_console(c) {
 		if (!c->device)
 			continue;
 		driver = c->device(c, index);
 		if (driver)
 			break;
 	}
-	console_unlock();
+	console_list_unlock();
 	return driver;
 }
 
-- 
2.30.2

