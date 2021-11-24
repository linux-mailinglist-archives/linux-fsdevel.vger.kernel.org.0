Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC045D0FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 00:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352620AbhKXXSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 18:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346272AbhKXXSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:18:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630A5C061574;
        Wed, 24 Nov 2021 15:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/BehJWA378MuzCcNzYeiaptr9YB2kX6SkWqVtJnXf90=; b=M5Qs3grdB16pLj3aU+oKgVtrYf
        +9X53Hc9TEpgvqrxdEacMBLIfLUpIRcdx0pspIrtG0DxItwaTy3rk1K/2OFZDGx0R7+fenta8bzwt
        TREipnX6auLhQV3MwazJgA0BMRl5ForyeKLzFMhhge2Bs/DjIi9Q7yGUjTmP6eIlGrd9aDrgtvuFS
        JW6sS7fevhy+T4aIZTlGhxX3rgLwIsgckJKUGWECBA5vOH+3+uFupDb1zxgzwEBpeYxtogUhDwO3G
        qAPJJftYL3FpkKPNCkBom6O2Mhu1fPFHi6L+oIwyfval9Y3BZZAiM2A7WVL4ZVEnITt4opq1g+XSM
        xlDxcIdA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq1TI-0063zK-TI; Wed, 24 Nov 2021 23:14:36 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        steve@sk2.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        tytso@mit.edu, viro@zeniv.linux.org.uk, pmladek@suse.com,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        linux-scsi@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] sysctl: share unsigned long const values
Date:   Wed, 24 Nov 2021 15:14:35 -0800
Message-Id: <20211124231435.1445213-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124231435.1445213-1-mcgrof@kernel.org>
References: <20211124231435.1445213-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a way to share unsigned long values.
This will allow others to not have to re-invent
these values.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/proc/proc_sysctl.c  | 3 +++
 include/linux/sysctl.h | 6 ++++++
 kernel/sysctl.c        | 9 +++------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index aa743bbb8400..2b73648a19a5 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -29,6 +29,9 @@ static const struct inode_operations proc_sys_dir_operations;
 const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, INT_MAX };
 EXPORT_SYMBOL(sysctl_vals);
 
+const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
+EXPORT_SYMBOL_GPL(sysctl_long_vals);
+
 /* Support for permanently empty directories */
 
 struct ctl_table sysctl_mount_point[] = {
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 7946b532e964..162aaee92daf 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -50,6 +50,12 @@ struct ctl_dir;
 
 extern const int sysctl_vals[];
 
+#define SYSCTL_LONG_ZERO	((void *)&sysctl_long_vals[0])
+#define SYSCTL_LONG_ONE		((void *)&sysctl_long_vals[1])
+#define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[2])
+
+extern const unsigned long sysctl_long_vals[];
+
 typedef int proc_handler(struct ctl_table *ctl, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5812d76ecee1..b8a3dcf7b925 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -99,9 +99,6 @@
 
 /* Constants used for minimum and  maximum */
 
-static const unsigned long zero_ul;
-static const unsigned long one_ul = 1;
-static const unsigned long long_max = LONG_MAX;
 #ifdef CONFIG_PRINTK
 static const int ten_thousand = 10000;
 #endif
@@ -2512,7 +2509,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(dirty_background_bytes),
 		.mode		= 0644,
 		.proc_handler	= dirty_background_bytes_handler,
-		.extra1		= (void *)&one_ul,
+		.extra1		= SYSCTL_LONG_ONE,
 	},
 	{
 		.procname	= "dirty_ratio",
@@ -2930,8 +2927,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(files_stat.max_files),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= (void *)&zero_ul,
-		.extra2		= (void *)&long_max,
+		.extra1		= SYSCTL_LONG_ZERO,
+		.extra2		= SYSCTL_LONG_MAX,
 	},
 	{
 		.procname	= "nr_open",
-- 
2.33.0

