Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C4A45D108
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 00:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352650AbhKXXSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 18:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352596AbhKXXSa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:18:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5063AC06173E;
        Wed, 24 Nov 2021 15:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YOCaAhMw9YLDCgTfpG+2eW9rcYLXz1DpCoqTIRrFUVE=; b=LWf6ociu10XekpBoiJtTXgR+Ts
        k5laF2zyD13Ve6dZ9qbUgTDexIOFieCo3KTvtsiY3REYapU3xOL43vf2y5LkrgPU3gwtlC5AyFyli
        Wwc0YC1BhDVFOTDpI2A4ZQiLc209k6KO7kS9BSm4dhILpCqY8fj9nmnzo9vBETjtZKCZiVMCIMgBE
        KNGWbWnaiIkCdZGRDv1V9Q3cloMXcXAEvCoa9S/TZUK18YPhDwIe5EPIt5K0NCfL0Z4Gt30jVMy3C
        hExc6dk1dI277VuNDyb2hbI0QRa/sITDyx297GzytmfyEjcAtulwDNz75d2L3OWHfIjntat2a9Usz
        Sh76Kvnw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq1TI-0063z6-NX; Wed, 24 Nov 2021 23:14:36 +0000
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
Subject: [PATCH v2 4/8] fs: move binfmt_misc sysctl to its own file
Date:   Wed, 24 Nov 2021 15:14:31 -0800
Message-Id: <20211124231435.1445213-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124231435.1445213-1-mcgrof@kernel.org>
References: <20211124231435.1445213-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel/sysctl.c is a kitchen sink where everyone leaves
their dirty dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to
places where they actually belong. The proc sysctl maintainers
do not want to know what sysctl knobs you wish to add for your own
piece of code, we just care about the core logic.

This moves the binfmt_misc sysctl to its own file to help remove
clutter from kernel/sysctl.c.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/binfmt_misc.c | 6 +++++-
 kernel/sysctl.c  | 7 -------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index e1eae7ea823a..ddea6acbddde 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -822,7 +822,11 @@ static int __init init_misc_binfmt(void)
 	int err = register_filesystem(&bm_fs_type);
 	if (!err)
 		insert_binfmt(&misc_format);
-	return err;
+	if (!register_sysctl_mount_point("fs/binfmt_misc")) {
+		pr_warn("Failed to create fs/binfmt_misc sysctl mount point");
+		return -ENOMEM;
+	}
+	return 0;
 }
 
 static void __exit exit_misc_binfmt(void)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1682714605e6..7745c9b72bda 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3126,13 +3126,6 @@ static struct ctl_table fs_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
-#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
-	{
-		.procname	= "binfmt_misc",
-		.mode		= 0555,
-		.child		= sysctl_mount_point,
-	},
-#endif
 	{
 		.procname	= "pipe-max-size",
 		.data		= &pipe_max_size,
-- 
2.33.0

