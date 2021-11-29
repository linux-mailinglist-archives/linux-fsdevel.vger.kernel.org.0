Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5AF462572
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhK2Wj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhK2Wiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:38:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A18EC0F4B2E;
        Mon, 29 Nov 2021 12:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4nCYh3UJ6b4mlExY45MFDyS7x7Wxh5kgRKAdxXTG6uA=; b=1SZLjL7ctrU9IaSLYbmJgpRmm/
        VxNnk3I40Qd8JIxpaPjNtp5uIQ5jE9Nn8t76GLJPpIcSDQxqMqFDh4ZuSdIhHAJtOny/lDtC7PYlq
        zALIYIwEgoN+YKthAvc8TI8eFy71jJgwZhQI61+U2pn2kaG2rhSZtfZghhMKYC1aaR1ffvD/bqjOq
        IOLUIdOWFdy5Lw/kvG+Av2sSLqRncW/i9aM/x67FiFHC/GAm0rWL8/MztA0CeLyEBkf3rEf9ekocd
        tpdFUy7SL0RQGJ7mKijt+hZgCcrl0PuIdCwN3KKLMJG3s/IV96zC4pitSZ6D27SiiDzmYcHTqPcMJ
        p1gTuG5g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrngl-002XZf-58; Mon, 29 Nov 2021 20:55:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        andriy.shevchenko@linux.intel.com, jlayton@kernel.org,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] sysctl: move maxolduid as a sysctl specific const
Date:   Mon, 29 Nov 2021 12:55:43 -0800
Message-Id: <20211129205548.605569-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211129205548.605569-1-mcgrof@kernel.org>
References: <20211129205548.605569-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The maxolduid value is only shared for sysctl purposes for
use on a max range. Just stuff this into our shared const
array.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/proc/proc_sysctl.c  |  2 +-
 include/linux/sysctl.h |  3 +++
 kernel/sysctl.c        | 12 ++++--------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 7dec3d5a9ed4..675b625fa898 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -26,7 +26,7 @@ static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
 /* shared constants to be used in various sysctls */
-const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 3000, INT_MAX };
+const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 65535, INT_MAX };
 EXPORT_SYMBOL(sysctl_vals);
 
 const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 2de6d20d191b..bb921eb8a02d 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -49,6 +49,9 @@ struct ctl_dir;
 #define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[8])
 #define SYSCTL_INT_MAX			((void *)&sysctl_vals[9])
 
+/* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
+#define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[10])
+
 extern const int sysctl_vals[];
 
 #define SYSCTL_LONG_ZERO	((void *)&sysctl_long_vals[0])
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index dbd267d0f014..05d9dd85e17f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -109,10 +109,6 @@ static const int six_hundred_forty_kb = 640 * 1024;
 /* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
 static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
 
-/* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
-static const int maxolduid = 65535;
-/* minolduid is SYSCTL_ZERO */
-
 static const int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
 
@@ -2126,7 +2122,7 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&maxolduid,
+		.extra2		= SYSCTL_MAXOLDUID,
 	},
 	{
 		.procname	= "overflowgid",
@@ -2135,7 +2131,7 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&maxolduid,
+		.extra2		= SYSCTL_MAXOLDUID,
 	},
 #ifdef CONFIG_S390
 	{
@@ -2907,7 +2903,7 @@ static struct ctl_table fs_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&maxolduid,
+		.extra2		= SYSCTL_MAXOLDUID,
 	},
 	{
 		.procname	= "overflowgid",
@@ -2916,7 +2912,7 @@ static struct ctl_table fs_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&maxolduid,
+		.extra2		= SYSCTL_MAXOLDUID,
 	},
 #ifdef CONFIG_FILE_LOCKING
 	{
-- 
2.33.0

