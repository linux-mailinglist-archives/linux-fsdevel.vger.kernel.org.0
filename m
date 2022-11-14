Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4712628538
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 17:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiKNQ3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 11:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbiKNQ3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:29:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C99426B;
        Mon, 14 Nov 2022 08:29:40 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WyGtVM99u5kVDH70iZExE1J1KzxzFf6H5/dTCHJGWmg=;
        b=FqAoNjaBB2Rlp2mNiLSbghpPzLzwe/mxSu1PahgKtAnhy0JYz8REmdtNz9jHFQFaj113nY
        ywZ/YEc1WnqLUt/lbm8feA+MyPzbJIRZv3VyR+hVIHoOTru/KIzygWDs2cWOkXnelZvsoo
        32AkyhpdUEvPRj7CPilKpeib4j1jznLqH+nKWXz7/7IBnl7Xk86MCDk0tWzXGSqSVG/RUv
        QRAw1Gqdw/S2PhYt+lV+WuN3kZ8zlf7KMaF8BftoCfYw9WENgLe5lBCaUXBOUsalZFaZAb
        9ZPCStORGaRXJVDKwcBdwVGTJacSupeBxD5165H9Ma8QabshUKzxXOyMSguQiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WyGtVM99u5kVDH70iZExE1J1KzxzFf6H5/dTCHJGWmg=;
        b=TSOchCPgjdlhJPka+GKTvoyPM/0XtrZC5Yjg7o2tlsAmZW/yw3oP7dxd3MB5cXFma4zBBg
        1gDZE59V6J1GTfDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v4 09/39] proc: consoles: document console_lock usage
Date:   Mon, 14 Nov 2022 17:35:02 +0106
Message-Id: <20221114162932.141883-10-john.ogness@linutronix.de>
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

