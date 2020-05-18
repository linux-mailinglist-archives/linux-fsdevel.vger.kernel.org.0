Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6A61D6F7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 06:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgEREAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 00:00:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbgEREAM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 00:00:12 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6E54E5E5E0121A94F1E0;
        Mon, 18 May 2020 12:00:09 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 18 May 2020 11:59:59 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <patrick.bellasi@arm.com>,
        <mingo@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>, <Jisheng.Zhang@synaptics.com>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>,
        <alex.huangjianhui@huawei.com>
Subject: [PATCH v3 1/4] sysctl: Add register_sysctl_init() interface
Date:   Mon, 18 May 2020 11:59:54 +0800
Message-ID: <1589774397-42485-2-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1589774397-42485-1-git-send-email-nixiaoming@huawei.com>
References: <1589774397-42485-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to eliminate the duplicate code for registering the sysctl
interface during the initialization of each feature, add the
register_sysctl_init() interface

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/sysctl.h |  2 ++
 kernel/sysctl.c        | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 02fa844..43f8ef9 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -206,6 +206,8 @@ struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init(void);
+extern void register_sysctl_init(const char *path, struct ctl_table *table,
+				 const char *table_name);
 
 extern struct ctl_table sysctl_mount_point[];
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8..c96122f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1968,6 +1968,25 @@ int __init sysctl_init(void)
 	return 0;
 }
 
+/*
+ * The sysctl interface is used to modify the interface value,
+ * but the feature interface has default values. Even if register_sysctl fails,
+ * the feature body function can also run. At the same time, malloc small
+ * fragment of memory during the system initialization phase, almost does
+ * not fail. Therefore, the function return is designed as void
+ */
+void __init register_sysctl_init(const char *path, struct ctl_table *table,
+				 const char *table_name)
+{
+	struct ctl_table_header *hdr = register_sysctl(path, table);
+
+	if (unlikely(!hdr)) {
+		pr_err("failed when register_sysctl %s to %s\n", table_name, path);
+		return;
+	}
+	kmemleak_not_leak(hdr);
+}
+
 #endif /* CONFIG_SYSCTL */
 
 /*
-- 
1.8.5.6

