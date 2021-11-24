Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8300B45D0F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 00:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346357AbhKXXSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 18:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346119AbhKXXSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:18:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9582EC06173E;
        Wed, 24 Nov 2021 15:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WIg2RMA4JYKIaP1iMAszasochEawTJ8KAp+gJo8930Q=; b=hus/c8h2GJnuuW4FAU5gkFdDXu
        FqdSY7eJVD6Coudhsjsbu+4TuzbdZDYQcLU4jN4NK5X3BFra/xe1ePyvmm5VwuwwsVZ2yJnimy6Ef
        quj8brWL+sJWGnaZkcnZNK0eU2z3c0/u6m34/vAx4j4aKV2UvVq/qNtS45omTNbTGSIrT66QhXJ+m
        oJsk7cysPEQqqRz8o5NkKDAf0FYhU1enI/nOFdTtV5quwDvCd9slaOx+V63Z1ad/pK/OSHzG4T3TT
        GNAB6LWsKLDyYk+/+bPt57H6iKRmgRCO0upKlUvH+/NqKe0EEYyowAQ9/d8OhRlw63fW37cFRD445
        t3vliCLQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq1TI-0063z0-L2; Wed, 24 Nov 2021 23:14:36 +0000
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
Subject: [PATCH v2 2/8] random: move the random sysctl declarations to its own file
Date:   Wed, 24 Nov 2021 15:14:29 -0800
Message-Id: <20211124231435.1445213-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124231435.1445213-1-mcgrof@kernel.org>
References: <20211124231435.1445213-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiaoming Ni <nixiaoming@huawei.com>

The kernel/sysctl.c is a kitchen sink where everyone leaves
their dirty dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to
places where they actually belong. The proc sysctl maintainers
do not want to know what sysctl knobs you wish to add for your own
piece of code, we just care about the core logic.

So move the random sysctls to its own file and use
register_sysctl_init().

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
[mcgrof: commit log update to justify the move]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/char/random.c  | 14 ++++++++++++--
 include/linux/sysctl.h |  1 -
 kernel/sysctl.c        |  5 -----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 605969ed0f96..35fcc09c0228 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2077,8 +2077,7 @@ static int proc_do_entropy(struct ctl_table *table, int write,
 }
 
 static int sysctl_poolsize = INPUT_POOL_WORDS * 32;
-extern struct ctl_table random_table[];
-struct ctl_table random_table[] = {
+static struct ctl_table random_table[] = {
 	{
 		.procname	= "poolsize",
 		.data		= &sysctl_poolsize,
@@ -2140,6 +2139,17 @@ struct ctl_table random_table[] = {
 #endif
 	{ }
 };
+
+/*
+ * rand_initialize() is called before sysctl_init(),
+ * so we cannot call register_sysctl_init() in rand_initialize()
+ */
+static int __init random_sysctls_init(void)
+{
+	register_sysctl_init("kernel/random", random_table);
+	return 0;
+}
+device_initcall(random_sysctls_init);
 #endif 	/* CONFIG_SYSCTL */
 
 struct batched_entropy {
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ae6e66177d88..e4da44567f18 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -216,7 +216,6 @@ extern int unaligned_dump_stack;
 extern int no_unaligned_warning;
 
 extern struct ctl_table sysctl_mount_point[];
-extern struct ctl_table random_table[];
 
 #else /* CONFIG_SYSCTL */
 static inline struct ctl_table_header *register_sysctl_table(struct ctl_table * table)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 3032aaa11ed9..1682714605e6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2143,11 +2143,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sysctl_max_threads,
 	},
-	{
-		.procname	= "random",
-		.mode		= 0555,
-		.child		= random_table,
-	},
 	{
 		.procname	= "usermodehelper",
 		.mode		= 0555,
-- 
2.33.0

