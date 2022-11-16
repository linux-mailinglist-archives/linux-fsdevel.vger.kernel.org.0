Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEC262C414
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 17:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiKPQWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 11:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiKPQWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE17D49B68;
        Wed, 16 Nov 2022 08:22:03 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WyGtVM99u5kVDH70iZExE1J1KzxzFf6H5/dTCHJGWmg=;
        b=OkggJBlHCa9L4cp9ZDwwAsfL5ubRsoOncME3GDT90isJ+qp7J73h9NygngEEZiEoWr+es/
        3Upl4H1KrQnB9vC4v5gJ8xNfgM03fTyq0Hvw3HyW+NTRBO9RDXHTzuY5yyRaWNip4KoUlo
        jv8o3KtDRDJ5vnJjCybJF2iNMAlOfQr0Z0EssP9z6UoZbQUp+vf741jMgzncq8Q944gZyU
        q/EDZaCvZe+84tYeDpcZt+1MrsFtlBB5PuIi0o6f70Fv1eF0z3tUS8sMp3rL7kwVtceE+v
        QzzsEhnN/iuaaeQLCD0aYQE0OgwigXV3QCHRchsu1ujqaQU2+c+KX3u9rJFQzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WyGtVM99u5kVDH70iZExE1J1KzxzFf6H5/dTCHJGWmg=;
        b=05p9Fgr9oIC1rseJZa7drAisqg0/FWrb79iEbbJ3VXznN77H03kThzDxWjsXNFc/82FzCY
        mJAwymv7Gr0kdEBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v5 10/40] proc: consoles: document console_lock usage
Date:   Wed, 16 Nov 2022 17:27:22 +0106
Message-Id: <20221116162152.193147-11-john.ogness@linutronix.de>
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

The console_lock is held throughout the start/show/stop procedure
to print out device/driver information about all registered
consoles. Since the console_lock is being used for multiple reasons,
explicitly document these reasons. This will be useful when the
console_lock is split into fine-grained locking.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 fs/proc/consoles.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index cf2e0788f9c7..46b305fa04ed 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -63,6 +63,15 @@ static void *c_start(struct seq_file *m, loff_t *pos)
 	struct console *con;
 	loff_t off = 0;
 
+	/*
+	 * Take console_lock to serialize device() callback with
+	 * other console operations. For example, fg_console is
+	 * modified under console_lock when switching vt.
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

