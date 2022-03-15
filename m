Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3A4D9455
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 07:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345120AbiCOGIF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 02:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345117AbiCOGIF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:08:05 -0400
Received: from smtpbg152.qq.com (smtpbg152.qq.com [13.245.186.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9D549FA2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 23:06:51 -0700 (PDT)
X-QQ-mid: bizesmtp72t1647324388tpkqndkg
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Mar 2022 14:06:22 +0800 (CST)
X-QQ-SSF: 01400000002000D0H000B00A0000000
X-QQ-FEAT: LVBOaDZ5gPpMzvCJEg6pDN8IckuawBlvyYOya+4uTTD0CX+0I0yv5amwd3Xz/
        P6QtKM695uyr6aXKOF1b5rsu5qVJhNP+Wd/eqw+45c+5xNrJKY0jI7mNQConJb43XrnAGj4
        WN3wqgBPK9K1WJ1wJjKoMMercL1dASCb9b8TVs4SzSzGWcc/v63O/arcgSz/0gKXwvsevf2
        bXDgiRSMnI6aQ6vIdYyA+hNAtdwm5jCIWFerKV5Y4J2ZrQjjsSGYma6z1Are69ZZfUqUBVD
        U5uEdKEs6nFoXsRA1VzgsdvZJ2s55aythLhvGWOx9iMxauWNJPuH+zuuaVvroZookLvEFoI
        UYRi1YnFOGy6AVTygw=
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dave@stgolabs.net, nixiaoming@huawei.com,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] fs/proc: Introduce list_for_each_table_entry for proc sysctl
Date:   Tue, 15 Mar 2022 14:06:16 +0800
Message-Id: <20220315060616.31850-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 fs/proc/proc_sysctl.c | 89 +++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 38 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c87c99f0856..5b14db1f691d 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -19,6 +19,9 @@
 #include <linux/kmemleak.h>
 #include "internal.h"
 
+#define list_for_each_table_entry(entry, table) \
+	for ((entry) = (table); (entry)->procname; (entry)++)
+
 static const struct dentry_operations proc_sys_dentry_operations;
 static const struct file_operations proc_sys_file_operations;
 static const struct inode_operations proc_sys_inode_operations;
@@ -215,15 +218,19 @@ static void init_header(struct ctl_table_header *head,
 	INIT_HLIST_HEAD(&head->inodes);
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
 
@@ -248,7 +255,7 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 	err = insert_links(header);
 	if (err)
 		goto fail_links;
-	for (entry = header->ctl_table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, header->ctl_table) {
 		err = insert_entry(header, entry);
 		if (err)
 			goto fail;
@@ -1131,34 +1138,36 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 static int sysctl_check_table(const char *path, struct ctl_table *table)
 {
 	int err = 0;
-	for (; table->procname; table++) {
-		if (table->child)
-			err |= sysctl_err(path, table, "Not a file");
-
-		if ((table->proc_handler == proc_dostring) ||
-		    (table->proc_handler == proc_dointvec) ||
-		    (table->proc_handler == proc_douintvec) ||
-		    (table->proc_handler == proc_douintvec_minmax) ||
-		    (table->proc_handler == proc_dointvec_minmax) ||
-		    (table->proc_handler == proc_dou8vec_minmax) ||
-		    (table->proc_handler == proc_dointvec_jiffies) ||
-		    (table->proc_handler == proc_dointvec_userhz_jiffies) ||
-		    (table->proc_handler == proc_dointvec_ms_jiffies) ||
-		    (table->proc_handler == proc_doulongvec_minmax) ||
-		    (table->proc_handler == proc_doulongvec_ms_jiffies_minmax)) {
-			if (!table->data)
-				err |= sysctl_err(path, table, "No data");
-			if (!table->maxlen)
-				err |= sysctl_err(path, table, "No maxlen");
+	struct ctl_table *entry;
+
+	list_for_each_table_entry(entry, table) {
+		if (entry->child)
+			err |= sysctl_err(path, entry, "Not a file");
+
+		if ((entry->proc_handler == proc_dostring) ||
+		    (entry->proc_handler == proc_dointvec) ||
+		    (entry->proc_handler == proc_douintvec) ||
+		    (entry->proc_handler == proc_douintvec_minmax) ||
+		    (entry->proc_handler == proc_dointvec_minmax) ||
+		    (entry->proc_handler == proc_dou8vec_minmax) ||
+		    (entry->proc_handler == proc_dointvec_jiffies) ||
+		    (entry->proc_handler == proc_dointvec_userhz_jiffies) ||
+		    (entry->proc_handler == proc_dointvec_ms_jiffies) ||
+		    (entry->proc_handler == proc_doulongvec_minmax) ||
+		    (entry->proc_handler == proc_doulongvec_ms_jiffies_minmax)) {
+			if (!entry->data)
+				err |= sysctl_err(path, entry, "No data");
+			if (!entry->maxlen)
+				err |= sysctl_err(path, entry, "No maxlen");
 			else
-				err |= sysctl_check_table_array(path, table);
+				err |= sysctl_check_table_array(path, entry);
 		}
-		if (!table->proc_handler)
-			err |= sysctl_err(path, table, "No proc_handler");
+		if (!entry->proc_handler)
+			err |= sysctl_err(path, entry, "No proc_handler");
 
-		if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
-			err |= sysctl_err(path, table, "bogus .mode 0%o",
-				table->mode);
+		if ((entry->mode & (S_IRUGO|S_IWUGO)) != entry->mode)
+			err |= sysctl_err(path, entry, "bogus .mode 0%o",
+				entry->mode);
 	}
 	return err;
 }
@@ -1174,7 +1183,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
 
 	name_bytes = 0;
 	nr_entries = 0;
-	for (entry = table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, table) {
 		nr_entries++;
 		name_bytes += strlen(entry->procname) + 1;
 	}
@@ -1191,14 +1200,16 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
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
@@ -1213,7 +1224,7 @@ static bool get_links(struct ctl_dir *dir,
 	struct ctl_table *entry, *link;
 
 	/* Are there links available for every entry in table? */
-	for (entry = table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, table) {
 		const char *procname = entry->procname;
 		link = find_entry(&head, dir, procname, strlen(procname));
 		if (!link)
@@ -1226,7 +1237,7 @@ static bool get_links(struct ctl_dir *dir,
 	}
 
 	/* The checks passed.  Increase the registration count on the links */
-	for (entry = table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, table) {
 		const char *procname = entry->procname;
 		link = find_entry(&head, dir, procname, strlen(procname));
 		head->nreg++;
@@ -1329,7 +1340,7 @@ struct ctl_table_header *__register_sysctl_table(
 	struct ctl_node *node;
 	int nr_entries = 0;
 
-	for (entry = table; entry->procname; entry++)
+	list_for_each_table_entry(entry, table)
 		nr_entries++;
 
 	header = kzalloc(sizeof(struct ctl_table_header) +
@@ -1456,7 +1467,7 @@ static int count_subheaders(struct ctl_table *table)
 	if (!table || !table->procname)
 		return 1;
 
-	for (entry = table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, table) {
 		if (entry->child)
 			nr_subheaders += count_subheaders(entry->child);
 		else
@@ -1475,7 +1486,7 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 	int nr_dirs = 0;
 	int err = -ENOMEM;
 
-	for (entry = table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, table) {
 		if (entry->child)
 			nr_dirs++;
 		else
@@ -1492,7 +1503,9 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 			goto out;
 
 		ctl_table_arg = files;
-		for (new = files, entry = table; entry->procname; entry++) {
+		new = files;
+
+		list_for_each_table_entry(entry, table) {
 			if (entry->child)
 				continue;
 			*new = *entry;
@@ -1516,7 +1529,7 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 	}
 
 	/* Recurse into the subdirectories. */
-	for (entry = table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, table) {
 		char *child_pos;
 
 		if (!entry->child)
@@ -1670,7 +1683,7 @@ static void put_links(struct ctl_table_header *header)
 	if (IS_ERR(core_parent))
 		return;
 
-	for (entry = header->ctl_table; entry->procname; entry++) {
+	list_for_each_table_entry(entry, header->ctl_table) {
 		struct ctl_table_header *link_head;
 		struct ctl_table *link;
 		const char *name = entry->procname;
-- 
2.20.1



