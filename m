Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0694FB326
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 07:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244705AbiDKFPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 01:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244704AbiDKFPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 01:15:05 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F073EF11
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Apr 2022 22:12:51 -0700 (PDT)
X-QQ-mid: bizesmtp73t1649653934thmrjuas
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 11 Apr 2022 13:12:08 +0800 (CST)
X-QQ-SSF: 01400000002000E0J000B00A0000000
X-QQ-FEAT: Ut0pB98mtT/gFdKHPfoA7at3zaJVoBJOhcyE/M+UJ2/MLKcSy/JQcggkV+Krt
        0aRzpV2M0Uv+gUPWgYDcXS2fpy2S3WJj+/tBy6WnbI39Iax/LjjW0yveVGjCZBXsv2DkT3x
        FkRxWIidJVwJyMWfk3AjKBLxU2fyMo2N4evxl2Vu2oTOVWEkwzffZsw0D/HU5kMSO9gYQj/
        WX4KaiEdnL5CoNNCqTbuNLpNuzziJ+giSkcEFrSCRLPPVN69P8vzP9JllHI08QM8J6iVmIC
        zevGiFs8i6YDMr4WdcDyRJ8pCVqgTkY8T9yJdv0xDnyVkJQ6mJuUnWBcXJpXZ6+cFWvvvv2
        GW4eb4+0fioZMav/F9T2UX+KIGjQEtKFOgzJbXk
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        nixiaoming@huawei.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] fs/proc: Introduce list_for_each_table_entry for proc sysctl
Date:   Mon, 11 Apr 2022 13:12:05 +0800
Message-Id: <20220411051205.6694-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_XBL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the list_for_each_table_entry macro to optimize the scenario
of traverse ctl_table. This make the code neater and easier to
understand.

Suggested-by: Davidlohr Bueso<dave@stgolabs.net>
Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 fs/proc/proc_sysctl.c | 81 +++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index fea2561d773b..4f31c68e8ed9 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -13,6 +13,9 @@
 #include <linux/module.h>
 #include "internal.h"
 
+#define list_for_each_table_entry(entry, table) \
+	for ((entry) = (table); (entry)->procname; (entry)++)
+
 static const struct dentry_operations proc_sys_dentry_operations;
 static const struct file_operations proc_sys_file_operations;
 static const struct inode_operations proc_sys_inode_operations;
@@ -170,15 +173,19 @@ static void init_header(struct ctl_table_header *head,
 	head->node = node;
 	if (node) {
 		struct ctl_table *entry;
-		for (entry = table; entry->procname; entry++, node++)
+
+		list_for_each_table_entry(entry, table) {
 			node->header = head;
+			node++;
+		}
 	}
 }
 
 static void erase_header(struct ctl_table_header *head)
 {
 	struct ctl_table *entry;
-	for (entry = head->ctl_table; entry->procname; entry++)
+
+	list_for_each_table_entry(entry, head->ctl_table)
 		erase_entry(head, entry);
 }
 
@@ -192,7 +199,7 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 	err = insert_links(header);
 	if (err)
 		goto fail_links;
-	for (entry = header->ctl_table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, header->ctl_table) {
 		err = insert_entry(header, entry);
 		if (err)
 			goto fail;
@@ -989,30 +996,32 @@ static int sysctl_err(const char *path, struct ctl_table *table, char *fmt, ...)
 
 static int sysctl_check_table(const char *path, struct ctl_table *table)
 {
+	struct ctl_table *entry;
 	int err = 0;
-	for (; table->procname; table++) {
-		if (table->child)
-			err = sysctl_err(path, table, "Not a file");
-
-		if ((table->proc_handler == proc_dostring) ||
-		    (table->proc_handler == proc_dointvec) ||
-		    (table->proc_handler == proc_dointvec_minmax) ||
-		    (table->proc_handler == proc_dointvec_jiffies) ||
-		    (table->proc_handler == proc_dointvec_userhz_jiffies) ||
-		    (table->proc_handler == proc_dointvec_ms_jiffies) ||
-		    (table->proc_handler == proc_doulongvec_minmax) ||
-		    (table->proc_handler == proc_doulongvec_ms_jiffies_minmax)) {
-			if (!table->data)
-				err = sysctl_err(path, table, "No data");
-			if (!table->maxlen)
-				err = sysctl_err(path, table, "No maxlen");
+
+	list_for_each_table_entry(entry, table) {
+		if (entry->child)
+			err = sysctl_err(path, entry, "Not a file");
+
+		if ((entry->proc_handler == proc_dostring) ||
+		    (entry->proc_handler == proc_dointvec) ||
+		    (entry->proc_handler == proc_dointvec_minmax) ||
+		    (entry->proc_handler == proc_dointvec_jiffies) ||
+		    (entry->proc_handler == proc_dointvec_userhz_jiffies) ||
+		    (entry->proc_handler == proc_dointvec_ms_jiffies) ||
+		    (entry->proc_handler == proc_doulongvec_minmax) ||
+		    (entry->proc_handler == proc_doulongvec_ms_jiffies_minmax)) {
+			if (!entry->data)
+				err = sysctl_err(path, entry, "No data");
+			if (!entry->maxlen)
+				err = sysctl_err(path, entry, "No maxlen");
 		}
-		if (!table->proc_handler)
-			err = sysctl_err(path, table, "No proc_handler");
+		if (!entry->proc_handler)
+			err = sysctl_err(path, entry, "No proc_handler");
 
-		if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
-			err = sysctl_err(path, table, "bogus .mode 0%o",
-				table->mode);
+		if ((entry->mode & (S_IRUGO|S_IWUGO)) != entry->mode)
+			err = sysctl_err(path, entry, "bogus .mode 0%o",
+				entry->mode);
 	}
 	return err;
 }
@@ -1028,7 +1037,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
 
 	name_bytes = 0;
 	nr_entries = 0;
-	for (entry = table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, table) {
 		nr_entries++;
 		name_bytes += strlen(entry->procname) + 1;
 	}
@@ -1045,14 +1054,16 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
 	node = (struct ctl_node *)(links + 1);
 	link_table = (struct ctl_table *)(node + nr_entries);
 	link_name = (char *)&link_table[nr_entries + 1];
+	link = link_table;
 
-	for (link = link_table, entry = table; entry->procname; link++, entry++) {
+	list_for_each_table_entry(entry, table) {
 		int len = strlen(entry->procname) + 1;
 		memcpy(link_name, entry->procname, len);
 		link->procname = link_name;
 		link->mode = S_IFLNK|S_IRWXUGO;
 		link->data = link_root;
 		link_name += len;
+		link++;
 	}
 	init_header(links, dir->header.root, dir->header.set, node, link_table);
 	links->nreg = nr_entries;
@@ -1067,7 +1078,7 @@ static bool get_links(struct ctl_dir *dir,
 	struct ctl_table *entry, *link;
 
 	/* Are there links available for every entry in table? */
-	for (entry = table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, table) {
 		const char *procname = entry->procname;
 		link = find_entry(&head, dir, procname, strlen(procname));
 		if (!link)
@@ -1080,7 +1091,7 @@ static bool get_links(struct ctl_dir *dir,
 	}
 
 	/* The checks passed.  Increase the registration count on the links */
-	for (entry = table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, table) {
 		const char *procname = entry->procname;
 		link = find_entry(&head, dir, procname, strlen(procname));
 		head->nreg++;
@@ -1183,7 +1194,7 @@ struct ctl_table_header *__register_sysctl_table(
 	struct ctl_node *node;
 	int nr_entries = 0;
 
-	for (entry = table; entry->procname; entry++)
+	list_for_each_table_entry(entry, table)
 		nr_entries++;
 
 	header = kzalloc(sizeof(struct ctl_table_header) +
@@ -1278,7 +1289,7 @@ static int count_subheaders(struct ctl_table *table)
 	if (!table || !table->procname)
 		return 1;
 
-	for (entry = table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, table) {
 		if (entry->child)
 			nr_subheaders += count_subheaders(entry->child);
 		else
@@ -1297,7 +1308,7 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 	int nr_dirs = 0;
 	int err = -ENOMEM;
 
-	for (entry = table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, table) {
 		if (entry->child)
 			nr_dirs++;
 		else
@@ -1314,7 +1325,9 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 			goto out;
 
 		ctl_table_arg = files;
-		for (new = files, entry = table; entry->procname; entry++) {
+		new = files;
+
+		list_for_each_table_entry(entry, table) {
 			if (entry->child)
 				continue;
 			*new = *entry;
@@ -1338,7 +1351,7 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 	}
 
 	/* Recurse into the subdirectories. */
-	for (entry = table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, table) {
 		char *child_pos;
 
 		if (!entry->child)
@@ -1483,7 +1496,7 @@ static void put_links(struct ctl_table_header *header)
 	if (IS_ERR(core_parent))
 		return;
 
-	for (entry = header->ctl_table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, header->ctl_table) {
 		struct ctl_table_header *link_head;
 		struct ctl_table *link;
 		const char *name = entry->procname;
-- 
2.20.1



