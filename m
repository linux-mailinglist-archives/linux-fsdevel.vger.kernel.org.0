Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB1F45AD3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 21:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhKWU1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 15:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhKWU12 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:27:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C686C061757;
        Tue, 23 Nov 2021 12:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9vP1zP3QdfTpUfByYc9kwk44D+BFC6gxB7JyD+inJOw=; b=25bT3WJefmOBBH+LM92UIoPHXK
        4DE45kclyZvw2vFlR4v7f7VmWfgTd3PcrGpC2inUarS5f3cNZbkeY91HdzxAlCL72/K9KIyNsJd0i
        Ch5G/wVYZ4delQs7GoxdRy2Gr/TZTXF0sRoIUY7Be+uYlYHWFPK0IDitXjniOYhn0vgKQSfdhIDXY
        +6k9vcQCDX20bZ7VifHHJcn5LGbu9pri1avlIQ/xX9wXZF8unaIDLyk9Z4Nk5FrfANavNuCZbmL/b
        9S1Tk9qNbmDcc2fVVMzMWr5YgLoGSyTvLmwCecC9t5khuZeaKd8aQctDGPPiAD5y7FpMtQgmGfEtC
        HTzlFeSg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpcKS-003Qr4-BF; Tue, 23 Nov 2021 20:23:48 +0000
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
Subject: [PATCH v2 7/9] sysctl: use SYSCTL_ZERO to replace some static int zero uses
Date:   Tue, 23 Nov 2021 12:23:45 -0800
Message-Id: <20211123202347.818157-8-mcgrof@kernel.org>
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

Use the variable SYSCTL_ZERO to replace some static int boundary
variables with a value of 0 (minolduid, min_extfrag_threshold,
min_wakeup_granularity_ns).

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/sysctl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 03bbd26d4df0..597ab5ad4879 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -122,7 +122,7 @@ static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static const int maxolduid = 65535;
-static const int minolduid;
+/* minolduid is SYSCTL_ZERO */
 
 static const int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
@@ -170,7 +170,7 @@ int sysctl_legacy_va_layout;
 #endif
 
 #ifdef CONFIG_COMPACTION
-static const int min_extfrag_threshold;
+/* min_extfrag_threshold is SYSCTL_ZERO */;
 static const int max_extfrag_threshold = 1000;
 #endif
 
@@ -2175,7 +2175,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&minolduid,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= (void *)&maxolduid,
 	},
 	{
@@ -2184,7 +2184,7 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&minolduid,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= (void *)&maxolduid,
 	},
 #ifdef CONFIG_S390
@@ -2758,7 +2758,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&min_extfrag_threshold,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= (void *)&max_extfrag_threshold,
 	},
 	{
@@ -3070,7 +3070,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&minolduid,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= (void *)&maxolduid,
 	},
 	{
@@ -3079,7 +3079,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&minolduid,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= (void *)&maxolduid,
 	},
 #ifdef CONFIG_FILE_LOCKING
-- 
2.33.0

