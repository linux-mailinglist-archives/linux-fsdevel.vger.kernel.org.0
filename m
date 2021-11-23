Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3202545AD43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 21:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhKWU1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 15:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhKWU1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:27:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715A8C06173E;
        Tue, 23 Nov 2021 12:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kpK3O5hUJnitXuHZHTTXCzkk1EYAUTYCXhJFjMHudUU=; b=1Bnl8vDvfWmE5SXr+SoW94qFb6
        8TSp2bgg9hlWdZgEruHXd5+WutWGKHG6Aa1Ts6qVY1HGr3z/r77oPb46jdvnfmhdOYqLn3cxEnO2r
        3r7m51Sw9roSH5FUl1UEdhmKkC/Kd2f8jJ06L9ADdZ8UgVE8vmrXlmbvUQN/AQYTBxRlQfdk8ik3X
        cXNn4cOS7DSHzBchbRaBS/QDxbFevoJs/b3R9/pQ8HH6Z9zTTov9tF0JDnoIoY1gpfpgv8UPSCvif
        mP4lcmijNy+9X35dKv1IBqbHTUI3SXvisX3o5H0ntr9VoJknNFVv4NFb7oufiEOaBK6sd9YrbNDN/
        YBWr1BLw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpcKS-003Qr2-A4; Tue, 23 Nov 2021 20:23:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        peterz@infradead.org, gregkh@linuxfoundation.org, pjt@google.com,
        liu.hailong6@zte.com.cn, andriy.shevchenko@linux.intel.com,
        sre@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        pmladek@suse.com, senozhatsky@chromium.org, wangqing@vivo.com,
        bcrl@kvack.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 6/9] sysctl: use const for typically used max/min proc sysctls
Date:   Tue, 23 Nov 2021 12:23:44 -0800
Message-Id: <20211123202347.818157-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211123202347.818157-1-mcgrof@kernel.org>
References: <20211123202347.818157-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiaoming Ni <nixiaoming@huawei.com>

When proc_dointvec_minmax() or proc_doulongvec_minmax() are used we
are using the extra1 and extra2 parameters on the sysctl table only
for a min and max boundary, these extra1 and extra2 arguments are
then used for read-only operations. So make them const to reflect
this.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
[mcgrof: commit log love]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/sysctl.c | 53 ++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b22149c46fa8..03bbd26d4df0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -107,27 +107,26 @@
 
 /* Constants used for minimum and  maximum */
 
-static unsigned long zero_ul;
-static unsigned long one_ul = 1;
-static unsigned long long_max = LONG_MAX;
+static const unsigned long zero_ul;
+static const unsigned long one_ul = 1;
+static const unsigned long long_max = LONG_MAX;
 #ifdef CONFIG_PRINTK
-static int ten_thousand = 10000;
+static const int ten_thousand = 10000;
 #endif
 #ifdef CONFIG_PERF_EVENTS
-static int six_hundred_forty_kb = 640 * 1024;
+static const int six_hundred_forty_kb = 640 * 1024;
 #endif
 
 /* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
-static unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
+static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
-static int maxolduid = 65535;
-static int minolduid;
+static const int maxolduid = 65535;
+static const int minolduid;
 
 static const int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
 
-
 #ifdef CONFIG_INOTIFY_USER
 #include <linux/inotify.h>
 #endif
@@ -171,8 +170,8 @@ int sysctl_legacy_va_layout;
 #endif
 
 #ifdef CONFIG_COMPACTION
-static int min_extfrag_threshold;
-static int max_extfrag_threshold = 1000;
+static const int min_extfrag_threshold;
+static const int max_extfrag_threshold = 1000;
 #endif
 
 #endif /* CONFIG_SYSCTL */
@@ -2176,8 +2175,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &minolduid,
-		.extra2		= &maxolduid,
+		.extra1		= (void *)&minolduid,
+		.extra2		= (void *)&maxolduid,
 	},
 	{
 		.procname	= "overflowgid",
@@ -2185,8 +2184,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &minolduid,
-		.extra2		= &maxolduid,
+		.extra1		= (void *)&minolduid,
+		.extra2		= (void *)&maxolduid,
 	},
 #ifdef CONFIG_S390
 	{
@@ -2260,7 +2259,7 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &ten_thousand,
+		.extra2		= (void *)&ten_thousand,
 	},
 	{
 		.procname	= "printk_devkmsg",
@@ -2472,7 +2471,7 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= perf_event_max_stack_handler,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &six_hundred_forty_kb,
+		.extra2		= (void *)&six_hundred_forty_kb,
 	},
 	{
 		.procname	= "perf_event_max_contexts_per_stack",
@@ -2628,7 +2627,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(dirty_background_bytes),
 		.mode		= 0644,
 		.proc_handler	= dirty_background_bytes_handler,
-		.extra1		= &one_ul,
+		.extra1		= (void *)&one_ul,
 	},
 	{
 		.procname	= "dirty_ratio",
@@ -2645,7 +2644,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(vm_dirty_bytes),
 		.mode		= 0644,
 		.proc_handler	= dirty_bytes_handler,
-		.extra1		= &dirty_bytes_min,
+		.extra1		= (void *)&dirty_bytes_min,
 	},
 	{
 		.procname	= "dirty_writeback_centisecs",
@@ -2759,8 +2758,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_extfrag_threshold,
-		.extra2		= &max_extfrag_threshold,
+		.extra1		= (void *)&min_extfrag_threshold,
+		.extra2		= (void *)&max_extfrag_threshold,
 	},
 	{
 		.procname	= "compact_unevictable_allowed",
@@ -3046,8 +3045,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(files_stat.max_files),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &zero_ul,
-		.extra2		= &long_max,
+		.extra1		= (void *)&zero_ul,
+		.extra2		= (void *)&long_max,
 	},
 	{
 		.procname	= "nr_open",
@@ -3071,8 +3070,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &minolduid,
-		.extra2		= &maxolduid,
+		.extra1		= (void *)&minolduid,
+		.extra2		= (void *)&maxolduid,
 	},
 	{
 		.procname	= "overflowgid",
@@ -3080,8 +3079,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &minolduid,
-		.extra2		= &maxolduid,
+		.extra1		= (void *)&minolduid,
+		.extra2		= (void *)&maxolduid,
 	},
 #ifdef CONFIG_FILE_LOCKING
 	{
-- 
2.33.0

