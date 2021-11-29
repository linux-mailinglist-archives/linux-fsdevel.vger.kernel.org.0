Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB06C4627C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 00:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbhK2XKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 18:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbhK2XJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:09:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09E5C08EA3B;
        Mon, 29 Nov 2021 13:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Fzwqvl+8bOJJ9b6ETdWIWLuhRqMFob2LTNWwL3xgXnI=; b=ztcEnADoh7xfJ2ArYQlCYdNWYy
        nOZQT0weEPBSowUEYpBE4HqlAllH+ruNUXnLxCrami5s73ZTGIHNXv6F7nXjM1K4LKf2W5xZjIjiK
        BrgsnYUOJwjm1KY7JGJin0d79Tk3YrLzfIqzPeYnIQow01gevO77lA247+Hs7mbpJoH0hzs8ax2dJ
        cpojSiOYaWHFr8/ZlMbr70oUgXWG9fUOom9y/aU5x4+nNgQqYphl20hgLOurePP2ajb+N1gvnPKtO
        cFYynEc0tS92acPeXOucsWrMNq5j0PE5VTRTw6t2LcLvyMkv3zhodNRLeLsUg4OAqL3QiNv+XKcQD
        XlGkADuQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mro3s-002ga5-RZ; Mon, 29 Nov 2021 21:19:44 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        christian.brauner@ubuntu.com, ebiggers@google.com,
        naveen.n.rao@linux.ibm.com, davem@davemloft.net,
        mhiramat@kernel.org, anil.s.keshavamurthy@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] printk: fix build warning when CONFIG_PRINTK=n
Date:   Mon, 29 Nov 2021 13:19:41 -0800
Message-Id: <20211129211943.640266-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211129211943.640266-1-mcgrof@kernel.org>
References: <20211129211943.640266-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiaoming Ni <nixiaoming@huawei.com>

build warning when CONFIG_PRINTK=n
	kernel/printk/printk.c:175:5: warning: no previous prototype for
	 'devkmsg_sysctl_set_loglvl' [-Wmissing-prototypes]

devkmsg_sysctl_set_loglvl() is only used in sysctl.c when CONFIG_PRINTK=y,
but it participates in the build when CONFIG_PRINTK=n. So add compile
dependency CONFIG_PRINTK=y && CONFIG_SYSCTL=y to fix the build warning.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/printk.h   | 4 ----
 kernel/printk/internal.h | 2 ++
 kernel/printk/printk.c   | 3 ++-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 9497f6b98339..1522df223c0f 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -183,10 +183,6 @@ extern bool printk_timed_ratelimit(unsigned long *caller_jiffies,
 extern int printk_delay_msec;
 extern int dmesg_restrict;
 
-extern int
-devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write, void *buf,
-			  size_t *lenp, loff_t *ppos);
-
 extern void wake_up_klogd(void);
 
 char *log_buf_addr_get(void);
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6b1c4b399845..d947ca6c84f9 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -6,6 +6,8 @@
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
 void __init printk_sysctl_init(void);
+int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos);
 #else
 #define printk_sysctl_init() do { } while (0)
 #endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dbb44086ba65..55722b94909b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -171,7 +171,7 @@ static int __init control_devkmsg(char *str)
 __setup("printk.devkmsg=", control_devkmsg);
 
 char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE] = "ratelimit";
-
+#if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
 int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -210,6 +210,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 
 	return 0;
 }
+#endif /* CONFIG_PRINTK && CONFIG_SYSCTL */
 
 /* Number of registered extended console drivers. */
 static int nr_ext_console_drivers;
-- 
2.33.0

