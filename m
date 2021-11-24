Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAB645D101
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 00:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352644AbhKXXSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 18:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352559AbhKXXSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:18:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C1DC061574;
        Wed, 24 Nov 2021 15:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZIp+i0z2hHQkQDFt8Oy6NqiFYaMGrNHUuHYsXiXH/UY=; b=qcMHtHvUvCgQ1TRNbIdQiQ0PBm
        zQeEXSdqS/4m6nQBRzyhA8+mAeryp6pEkrGa6t7BPLR6F5vLATVcMVxFgBntidKPi8UWUu4AjtkeW
        +n9lg3B9z4aTmzZnKRnbwhSuQMQI/XIcirVx0GSeLDw5JpRXB3zC8fX/3xrR+h8/gHFzFSgqXrkvq
        ZXzT4eJuT1UHzpET99gWuVYooveLSfTdOJYmSQR+cA7sZZgCgSLKUy5GpwyiHn/8bKwnTvRWqh3Bd
        RftFyBEaXgSfRNEGPHfUJ6MWhBrWFLcYiAtHD0jj3lKHV+XzFakV1EMyEpK/pu7WvID18xpMvK7Lv
        wCZFkdBA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq1TI-0063z3-MM; Wed, 24 Nov 2021 23:14:36 +0000
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
Subject: [PATCH v2 3/8] sysctl: add helper to register a sysctl mount point
Date:   Wed, 24 Nov 2021 15:14:30 -0800
Message-Id: <20211124231435.1445213-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124231435.1445213-1-mcgrof@kernel.org>
References: <20211124231435.1445213-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The way to create a subdirectory on top of sysctl_mount_point is
a bit obscure, and *why* we do that even so more. Provide a helper
which makes it clear why we do this.

Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/proc/proc_sysctl.c  | 13 +++++++++++++
 include/linux/sysctl.h |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6d462644bb00..aa743bbb8400 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -35,6 +35,19 @@ struct ctl_table sysctl_mount_point[] = {
 	{ }
 };
 
+/**
+ * register_sysctl_mount_point() - registers a sysctl mount point
+ * @path: path for the mount point
+ *
+ * Used to create a permanently empty directory to serve as mount point.
+ * There are some subtle but important permission checks this allows in the
+ * case of unprivileged mounts.
+ */
+struct ctl_table_header *register_sysctl_mount_point(const char *path)
+{
+	return register_sysctl(path, sysctl_mount_point);
+}
+
 static bool is_empty_dir(struct ctl_table_header *head)
 {
 	return head->ctl_table[0].child == sysctl_mount_point;
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index e4da44567f18..7946b532e964 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -208,6 +208,8 @@ extern int sysctl_init(void);
 extern void __register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name);
 #define register_sysctl_init(path, table) __register_sysctl_init(path, table, #table)
+extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
+
 void do_sysctl_args(void);
 
 extern int pwrsw_enabled;
@@ -223,6 +225,11 @@ static inline struct ctl_table_header *register_sysctl_table(struct ctl_table *
 	return NULL;
 }
 
+static inline struct sysctl_header *register_sysctl_mount_point(const char *path)
+{
+	return NULL;
+}
+
 static inline struct ctl_table_header *register_sysctl_paths(
 			const struct ctl_path *path, struct ctl_table *table)
 {
-- 
2.33.0

