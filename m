Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA9B604A8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 17:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJSPGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 11:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiJSPFq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACD4BE38;
        Wed, 19 Oct 2022 07:59:24 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vk9lLFSPw7DVFHn+Ltr9+ux4PzL45JriVQ+GTbz1WOY=;
        b=qy+XfEMThEbkLnrE1n36Z2pN+sVWm/xcWaaykneLdYt/vpE15mr9kwHlg/KLo+RWPWYf34
        etPdErRihRuc+qZDB4lMGkJwkzOj0k873ip2RAnXf1ME6l4C75Nr7d+ZfLt0A0Xix765FH
        uOFeEgTaLBDP2HXzMyNMjWIC6zZ5DT5w5YwqCIu/1LYCInpQWEgjFfzVpFkk5Po66g2mEg
        NgEYb4GBaW4tD2U/AaebbabvrhjAUfC3V7esyJ4gKfuPnB8m9poV9ANs+Oggu69i9E/XY4
        u16HcZa6/YcQ4gML73ZuMD0kDTA/mUUFqcAiH6w2xMHdUNjXCQYt02KOINdzng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vk9lLFSPw7DVFHn+Ltr9+ux4PzL45JriVQ+GTbz1WOY=;
        b=Bczhayh0iGG8icRI55cYRrg7pJAHOfB2u8QZ/VTPoePhI61+DqIcsXd3xFHatJNL5JU+gj
        3w0K/ax5IwNRZjBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v2 25/38] proc: consoles: document console_lock usage
Date:   Wed, 19 Oct 2022 17:01:47 +0206
Message-Id: <20221019145600.1282823-26-john.ogness@linutronix.de>
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

The console_lock is held throughout the start/show/stop procedure
to print out device/driver information about all registered
consoles. Since the console_lock is being used for multiple reasons,
explicitly document these reasons. This will be useful when the
console_lock is split into fine-grained locking.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 fs/proc/consoles.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index cf2e0788f9c7..32512b477605 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -63,6 +63,14 @@ static void *c_start(struct seq_file *m, loff_t *pos)
 	struct console *con;
 	loff_t off = 0;
 
+	/*
+	 * Stop console printing because the device() callback may
+	 * assume the console is not within its write() callback.
+	 *
+	 * Hold the console_lock to guarantee safe traversal of the
+	 * console list. SRCU cannot be used because there is no
+	 * place to store the SRCU cookie.
+	 */
 	console_lock();
 	for_each_console(con)
 		if (off++ == *pos)
-- 
2.30.2

