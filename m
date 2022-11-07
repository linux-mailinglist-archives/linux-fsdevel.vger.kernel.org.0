Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CA661F535
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 15:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiKGOQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 09:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiKGOQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DE11D0FE;
        Mon,  7 Nov 2022 06:16:48 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3yaMFjrCtNc3Px6vqfLokWlErUgA/SSe6zXZ59V8XY=;
        b=W7M6kX4aY2WaQhigk++ZxU/cDgnvB3Dl9STk1+geoLoCGHp7UPBDY5v+NeZ90ucRfC2HZc
        lDRqkLNmPbRjBpCbHs5tsKGthjWVMLdZWMxiNEI7NckgFq/qionlE3HamxH3X/5XmEp8i/
        LvYvxgNjfgydovwy55cK34wbW767izonqt76pbi9y9xO0RkwY4CcHMM+xntUfQSktX66yz
        ojtVw2XzoK4YTR9iApgdp4QpWG0d3UrJirmW+3fYtI6H0PCdW8LnrEW/UfVs02EMFXShG/
        ChC8lj5RsSsKp0+AoiQTwUUxu+kE5nZjTLQvr/wycTrZpqCOEAgBCZU8fBxvGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3yaMFjrCtNc3Px6vqfLokWlErUgA/SSe6zXZ59V8XY=;
        b=YNgZvTTcrT+PyJJnxSALPiorJ0D8azX4yxEjkhd6xJt1i0DwjJgqovqxZLibOchEzYHoDL
        88GvZxS2AnRgV7CQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v3 14/40] proc: consoles: document console_lock usage
Date:   Mon,  7 Nov 2022 15:22:12 +0106
Message-Id: <20221107141638.3790965-15-john.ogness@linutronix.de>
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

The console_lock is held throughout the start/show/stop procedure
to print out device/driver information about all registered
consoles. Since the console_lock is being used for multiple reasons,
explicitly document these reasons. This will be useful when the
console_lock is split into fine-grained locking.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
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

