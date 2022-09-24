Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24125E8671
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 02:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiIXAFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 20:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiIXAFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A839DFAB;
        Fri, 23 Sep 2022 17:04:58 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5V3Z6AhMdpsVP4d3DckyHZHpUKQGjS72cEceALWthyY=;
        b=YbT35guZgiSYqZPsZ7HEpaJ0sOvKpQbPePGoaeyTUm7H/wO1/IFAkSjQMkNg4HoC1rMjla
        jOG2WQmkJFxhuw2YenY92/zVcdEBo8eSRyStxb7OnII/aJAGAhnWzSRDfyJebHiDKEtYsH
        VNDjMh4g98gPQQl/3zb/cwRcC7g7EU9DyDPbTqF/6nqU9EH06kz9Dc6JPBe3Kgtp2H0HBH
        dzs1e8znzH4R2m53tahOEpKMFCwYjvzSFUCrkVqO/G6He6rIqI0eJfHtg/e0V6xFjFnvHn
        e5shoEqTJMDYCVlN2zoS/cBXquWRftl9TI/0+Iz99De6KVyJMNk7i3vBAsXKLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5V3Z6AhMdpsVP4d3DckyHZHpUKQGjS72cEceALWthyY=;
        b=bbbCxJXlhztbHC/ejFyxV3FY+WbK3/0ecpHf3f2KN7q4Su9QrnsgmRYIkGnOJILcTg0FE5
        gaPedLj1PMB++VDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH printk 02/18] printk: Declare log_wait properly
Date:   Sat, 24 Sep 2022 02:10:38 +0206
Message-Id: <20220924000454.3319186-3-john.ogness@linutronix.de>
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

kernel/printk/printk.c:365:1: warning: symbol 'log_wait' was not declared. Should it be static?

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 fs/proc/kmsg.c         | 2 --
 include/linux/syslog.h | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/proc/kmsg.c b/fs/proc/kmsg.c
index b38ad552887f..9d6950ac10fe 100644
--- a/fs/proc/kmsg.c
+++ b/fs/proc/kmsg.c
@@ -18,8 +18,6 @@
 #include <linux/uaccess.h>
 #include <asm/io.h>
 
-extern wait_queue_head_t log_wait;
-
 static int kmsg_open(struct inode * inode, struct file * file)
 {
 	return do_syslog(SYSLOG_ACTION_OPEN, NULL, 0, SYSLOG_FROM_PROC);
diff --git a/include/linux/syslog.h b/include/linux/syslog.h
index 86af908e2663..955f80e34d4f 100644
--- a/include/linux/syslog.h
+++ b/include/linux/syslog.h
@@ -8,6 +8,8 @@
 #ifndef _LINUX_SYSLOG_H
 #define _LINUX_SYSLOG_H
 
+#include <linux/wait.h>
+
 /* Close the log.  Currently a NOP. */
 #define SYSLOG_ACTION_CLOSE          0
 /* Open the log. Currently a NOP. */
@@ -35,5 +37,6 @@
 #define SYSLOG_FROM_PROC             1
 
 int do_syslog(int type, char __user *buf, int count, int source);
+extern wait_queue_head_t log_wait;
 
 #endif /* _LINUX_SYSLOG_H */
-- 
2.30.2

