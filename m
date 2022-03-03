Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FB24CB77C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 08:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiCCHKI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 02:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiCCHKH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:10:07 -0500
Received: from smtpbg516.qq.com (smtpbg516.qq.com [203.205.250.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A2716BCDF
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 23:09:16 -0800 (PST)
X-QQ-mid: bizesmtp79t1646291340tzu05l9k
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Mar 2022 15:08:53 +0800 (CST)
X-QQ-SSF: 01400000002000C0G000B00A0000000
X-QQ-FEAT: ArfJXynxbT3RYHVJL3jxEF6aPWeXzqFHXD9jcj0bEjmwKcwGLKKuAi0Q6Ljm4
        DyQoEwdUz0d+hLd3bD63edA58tuvm35BJvXd/IFG/ITJGIOyH7bga/jHLpvpmNwUFyK1QUu
        7jcQtUU5Xm2Opt2VdQ2rVHVmd0ysI/TxgQPoG7zzbahh3pbszckTrFptUeqGMh7QmxM2ksr
        eSZUBp0EJpoYakx3BYd+u2u+F53Yx8vYc1QlYq4mcVDgPpp9fSWv0bt6I3jhMs9+1BZ+zRD
        Ntz6tVL/5Vv7td02hY+CKhCYWmH6pW65XUKgnpWSATUDn+LNPKQd2iR1WQPVYdXGyihHR2k
        6IqGeDJ5ofWkKsL6BkMnjePB+9xq+kKfMSUsnTg
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        ebiederm@xmission.com, willy@infradead.org
Cc:     nixiaoming@huawei.com, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH v4 1/2] fs/proc: optimize exactly register one ctl_table
Date:   Thu,  3 Mar 2022 15:08:46 +0800
Message-Id: <20220303070847.28684-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sysctls are being moved out of kernel/sysctl.c and out to
their own respective subsystems / users to help with easier
maintance and avoid merge conflicts. But when we move just
one entry and to its own new file the last entry for this
new file must be empty, so we are essentialy bloating the
kernel one extra empty entry per each newly moved sysctl.

To help with this, this adds support for registering just
one ctl_table, therefore not bloating the kernel when we
move a single ctl_table to its own file.

Since the process of registering just one single table is the
same as that of registering an array table, so the code is
similar to registering an array table. The difference between
registering just one table and registering an array table is
that we no longer traversal through pointers when registering
a single table. These lead to that we have to add a complete
implementation process for register just one ctl_table, so we
have to add so much code.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 fs/proc/proc_sysctl.c  | 159 +++++++++++++++++++++++++++++------------
 include/linux/sysctl.h |   9 ++-
 2 files changed, 121 insertions(+), 47 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c87c99f0856..e06d2094457a 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -19,6 +19,8 @@
 #include <linux/kmemleak.h>
 #include "internal.h"
 
+#define REGISTER_SINGLE_ONE (register_single_one ? true : false)
+
 static const struct dentry_operations proc_sys_dentry_operations;
 static const struct file_operations proc_sys_file_operations;
 static const struct inode_operations proc_sys_inode_operations;
@@ -100,8 +102,8 @@ static DEFINE_SPINLOCK(sysctl_lock);
 static void drop_sysctl_table(struct ctl_table_header *header);
 static int sysctl_follow_link(struct ctl_table_header **phead,
 	struct ctl_table **pentry);
-static int insert_links(struct ctl_table_header *head);
-static void put_links(struct ctl_table_header *header);
+static int insert_links(struct ctl_table_header *head, bool register_single_one);
+static void put_links(struct ctl_table_header *header, bool register_single_one);
 
 static void sysctl_print_dir(struct ctl_dir *dir)
 {
@@ -200,7 +202,7 @@ static void erase_entry(struct ctl_table_header *head, struct ctl_table *entry)
 
 static void init_header(struct ctl_table_header *head,
 	struct ctl_table_root *root, struct ctl_table_set *set,
-	struct ctl_node *node, struct ctl_table *table)
+	struct ctl_node *node, struct ctl_table *table, bool register_single_one)
 {
 	head->ctl_table = table;
 	head->ctl_table_arg = table;
@@ -215,19 +217,26 @@ static void init_header(struct ctl_table_header *head,
 	INIT_HLIST_HEAD(&head->inodes);
 	if (node) {
 		struct ctl_table *entry;
-		for (entry = table; entry->procname; entry++, node++)
+		for (entry = table; entry->procname; entry++, node++) {
 			node->header = head;
+			if (register_single_one)
+				break;
+		}
 	}
 }
 
-static void erase_header(struct ctl_table_header *head)
+static void erase_header(struct ctl_table_header *head, bool register_single_one)
 {
 	struct ctl_table *entry;
-	for (entry = head->ctl_table; entry->procname; entry++)
+	for (entry = head->ctl_table; entry->procname; entry++) {
 		erase_entry(head, entry);
+		if (register_single_one)
+			break;
+	}
 }
 
-static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
+static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header,
+	bool register_single_one)
 {
 	struct ctl_table *entry;
 	int err;
@@ -245,18 +254,21 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 
 	dir->header.nreg++;
 	header->parent = dir;
-	err = insert_links(header);
+	err = insert_links(header, REGISTER_SINGLE_ONE);
+
 	if (err)
 		goto fail_links;
 	for (entry = header->ctl_table; entry->procname; entry++) {
 		err = insert_entry(header, entry);
 		if (err)
 			goto fail;
+		if (register_single_one)
+			break;
 	}
 	return 0;
 fail:
-	erase_header(header);
-	put_links(header);
+	erase_header(header, REGISTER_SINGLE_ONE);
+	put_links(header, REGISTER_SINGLE_ONE);
 fail_links:
 	if (header->ctl_table == sysctl_mount_point)
 		clear_empty_dir(dir);
@@ -315,7 +327,7 @@ static void start_unregistering(struct ctl_table_header *p)
 	 * list in do_sysctl() relies on that.
 	 */
 	spin_lock(&sysctl_lock);
-	erase_header(p);
+	erase_header(p, false);
 }
 
 static struct ctl_table_header *sysctl_head_grab(struct ctl_table_header *head)
@@ -981,7 +993,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
 	new_name[namelen] = '\0';
 	table[0].procname = new_name;
 	table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
-	init_header(&new->header, set->dir.header.root, set, node, table);
+	init_header(&new->header, set->dir.header.root, set, node, table, false);
 
 	return new;
 }
@@ -1027,7 +1039,7 @@ static struct ctl_dir *get_subdir(struct ctl_dir *dir,
 		goto failed;
 
 	/* Nope.  Use the our freshly made directory entry. */
-	err = insert_header(dir, &new->header);
+	err = insert_header(dir, &new->header, false);
 	subdir = ERR_PTR(err);
 	if (err)
 		goto failed;
@@ -1128,7 +1140,8 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 	return err;
 }
 
-static int sysctl_check_table(const char *path, struct ctl_table *table)
+static int sysctl_check_table(const char *path, struct ctl_table *table,
+		bool register_single_one)
 {
 	int err = 0;
 	for (; table->procname; table++) {
@@ -1159,12 +1172,15 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
 		if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
 			err |= sysctl_err(path, table, "bogus .mode 0%o",
 				table->mode);
+
+		if (register_single_one)
+			break;
 	}
 	return err;
 }
 
 static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table *table,
-	struct ctl_table_root *link_root)
+	struct ctl_table_root *link_root, bool register_single_one)
 {
 	struct ctl_table *link_table, *entry, *link;
 	struct ctl_table_header *links;
@@ -1177,6 +1193,8 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
 	for (entry = table; entry->procname; entry++) {
 		nr_entries++;
 		name_bytes += strlen(entry->procname) + 1;
+		if (register_single_one)
+			break;
 	}
 
 	links = kzalloc(sizeof(struct ctl_table_header) +
@@ -1199,15 +1217,19 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
 		link->mode = S_IFLNK|S_IRWXUGO;
 		link->data = link_root;
 		link_name += len;
+		if (register_single_one)
+			break;
 	}
-	init_header(links, dir->header.root, dir->header.set, node, link_table);
+	init_header(links, dir->header.root, dir->header.set, node, link_table,
+		    REGISTER_SINGLE_ONE);
 	links->nreg = nr_entries;
 
 	return links;
 }
 
 static bool get_links(struct ctl_dir *dir,
-	struct ctl_table *table, struct ctl_table_root *link_root)
+	struct ctl_table *table, struct ctl_table_root *link_root,
+	bool register_single_one)
 {
 	struct ctl_table_header *head;
 	struct ctl_table *entry, *link;
@@ -1218,10 +1240,16 @@ static bool get_links(struct ctl_dir *dir,
 		link = find_entry(&head, dir, procname, strlen(procname));
 		if (!link)
 			return false;
-		if (S_ISDIR(link->mode) && S_ISDIR(entry->mode))
+		if (S_ISDIR(link->mode) && S_ISDIR(entry->mode)) {
+			if (register_single_one)
+				break;
 			continue;
-		if (S_ISLNK(link->mode) && (link->data == link_root))
+		}
+		if (S_ISLNK(link->mode) && (link->data == link_root)) {
+			if (register_single_one)
+				break;
 			continue;
+		}
 		return false;
 	}
 
@@ -1230,11 +1258,13 @@ static bool get_links(struct ctl_dir *dir,
 		const char *procname = entry->procname;
 		link = find_entry(&head, dir, procname, strlen(procname));
 		head->nreg++;
+		if (register_single_one)
+			break;
 	}
 	return true;
 }
 
-static int insert_links(struct ctl_table_header *head)
+static int insert_links(struct ctl_table_header *head, bool register_single_one)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
 	struct ctl_dir *core_parent = NULL;
@@ -1248,13 +1278,13 @@ static int insert_links(struct ctl_table_header *head)
 	if (IS_ERR(core_parent))
 		return 0;
 
-	if (get_links(core_parent, head->ctl_table, head->root))
+	if (get_links(core_parent, head->ctl_table, head->root, REGISTER_SINGLE_ONE))
 		return 0;
 
 	core_parent->header.nreg++;
 	spin_unlock(&sysctl_lock);
 
-	links = new_links(core_parent, head->ctl_table, head->root);
+	links = new_links(core_parent, head->ctl_table, head->root, REGISTER_SINGLE_ONE);
 
 	spin_lock(&sysctl_lock);
 	err = -ENOMEM;
@@ -1262,12 +1292,12 @@ static int insert_links(struct ctl_table_header *head)
 		goto out;
 
 	err = 0;
-	if (get_links(core_parent, head->ctl_table, head->root)) {
+	if (get_links(core_parent, head->ctl_table, head->root, REGISTER_SINGLE_ONE)) {
 		kfree(links);
 		goto out;
 	}
 
-	err = insert_header(core_parent, links);
+	err = insert_header(core_parent, links, REGISTER_SINGLE_ONE);
 	if (err)
 		kfree(links);
 out:
@@ -1276,13 +1306,16 @@ static int insert_links(struct ctl_table_header *head)
 }
 
 /**
- * __register_sysctl_table - register a leaf sysctl table
+ * __register_sysctl_tables - register a leaf sysctl table
  * @set: Sysctl tree to register on
  * @path: The path to the directory the sysctl table is in.
  * @table: the top-level table structure
+ * @register_single_one: register single one and table must be without child
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
- * array. A completely 0 filled entry terminates the table.
+ * array. If multiple tables are need to be registered or there is child in
+ * the table. A completely 0 filled entry terminates the table. If just a
+ * single one table is need to be registered, let 'register_single=true'.
  *
  * The members of the &struct ctl_table structure are used as follows:
  *
@@ -1317,9 +1350,9 @@ static int insert_links(struct ctl_table_header *head)
  * This routine returns %NULL on a failure to register, and a pointer
  * to the table header on success.
  */
-struct ctl_table_header *__register_sysctl_table(
+struct ctl_table_header *__register_sysctl_tables(
 	struct ctl_table_set *set,
-	const char *path, struct ctl_table *table)
+	const char *path, struct ctl_table *table, bool register_single_one)
 {
 	struct ctl_table_root *root = set->dir.header.root;
 	struct ctl_table_header *header;
@@ -1329,8 +1362,11 @@ struct ctl_table_header *__register_sysctl_table(
 	struct ctl_node *node;
 	int nr_entries = 0;
 
-	for (entry = table; entry->procname; entry++)
+	for (entry = table; entry->procname; entry++) {
 		nr_entries++;
+		if (register_single_one)
+			break;
+	}
 
 	header = kzalloc(sizeof(struct ctl_table_header) +
 			 sizeof(struct ctl_node)*nr_entries, GFP_KERNEL);
@@ -1338,8 +1374,8 @@ struct ctl_table_header *__register_sysctl_table(
 		return NULL;
 
 	node = (struct ctl_node *)(header + 1);
-	init_header(header, root, set, node, table);
-	if (sysctl_check_table(path, table))
+	init_header(header, root, set, node, table, REGISTER_SINGLE_ONE);
+	if (sysctl_check_table(path, table, REGISTER_SINGLE_ONE))
 		goto fail;
 
 	spin_lock(&sysctl_lock);
@@ -1367,7 +1403,7 @@ struct ctl_table_header *__register_sysctl_table(
 	}
 
 	spin_lock(&sysctl_lock);
-	if (insert_header(dir, header))
+	if (insert_header(dir, header, REGISTER_SINGLE_ONE))
 		goto fail_put_dir_locked;
 
 	drop_sysctl_table(&dir->header);
@@ -1392,7 +1428,7 @@ struct ctl_table_header *__register_sysctl_table(
  * Register a sysctl table. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
  *
- * See __register_sysctl_table for more details.
+ * See __register_sysctl_tables for more details.
  */
 struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table)
 {
@@ -1401,6 +1437,25 @@ struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *tab
 }
 EXPORT_SYMBOL(register_sysctl);
 
+/**
+ * __register_sysctl_single - register extraly one sysctl table
+ * @path: The path to the directory the sysctl table is in.
+ * @table: the table structure
+ *
+ * Register extraly one sysctl table. @table should be a filled in extraly one
+ * ctl_table. If ctl_table which need to register have child or is not single,
+ * we should use register_sysctl_init or register_sysctl instead of
+ * register_sysctl_single.
+ *
+ * See __register_sysctl_table for more details.
+ */
+struct ctl_table_header *__register_sysctl_single(const char *path, struct ctl_table *table)
+{
+	return __register_sysctl_tables(&sysctl_table_root.default_set,
+					path, table, true);
+}
+EXPORT_SYMBOL(__register_sysctl_single);
+
 /**
  * __register_sysctl_init() - register sysctl table to path
  * @path: path name for sysctl base
@@ -1446,7 +1501,7 @@ static char *append_path(const char *path, char *pos, const char *name)
 	return pos;
 }
 
-static int count_subheaders(struct ctl_table *table)
+static int count_subheaders(struct ctl_table *table, bool register_single_one)
 {
 	int has_files = 0;
 	int nr_subheaders = 0;
@@ -1458,16 +1513,19 @@ static int count_subheaders(struct ctl_table *table)
 
 	for (entry = table; entry->procname; entry++) {
 		if (entry->child)
-			nr_subheaders += count_subheaders(entry->child);
+			nr_subheaders += count_subheaders(entry->child, false);
 		else
 			has_files = 1;
+
+		if (register_single_one)
+			break;
 	}
 	return nr_subheaders + has_files;
 }
 
 static int register_leaf_sysctl_tables(const char *path, char *pos,
 	struct ctl_table_header ***subheader, struct ctl_table_set *set,
-	struct ctl_table *table)
+	struct ctl_table *table, bool register_single_one)
 {
 	struct ctl_table *ctl_table_arg = NULL;
 	struct ctl_table *entry, *files;
@@ -1480,6 +1538,9 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 			nr_dirs++;
 		else
 			nr_files++;
+
+		if (register_single_one)
+			break;
 	}
 
 	files = table;
@@ -1497,13 +1558,15 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 				continue;
 			*new = *entry;
 			new++;
+			if (register_single_one)
+				break;
 		}
 	}
 
 	/* Register everything except a directory full of subdirectories */
 	if (nr_files || !nr_dirs) {
 		struct ctl_table_header *header;
-		header = __register_sysctl_table(set, path, files);
+		header = __register_sysctl_tables(set, path, files, REGISTER_SINGLE_ONE);
 		if (!header) {
 			kfree(ctl_table_arg);
 			goto out;
@@ -1519,8 +1582,11 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 	for (entry = table; entry->procname; entry++) {
 		char *child_pos;
 
-		if (!entry->child)
+		if (!entry->child) {
+			if (register_single_one)
+				break;
 			continue;
+		}
 
 		err = -ENAMETOOLONG;
 		child_pos = append_path(path, pos, entry->procname);
@@ -1528,7 +1594,7 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 			goto out;
 
 		err = register_leaf_sysctl_tables(path, child_pos, subheader,
-						  set, entry->child);
+						  set, entry->child, false);
 		pos[0] = '\0';
 		if (err)
 			goto out;
@@ -1555,7 +1621,7 @@ struct ctl_table_header *__register_sysctl_paths(
 	const struct ctl_path *path, struct ctl_table *table)
 {
 	struct ctl_table *ctl_table_arg = table;
-	int nr_subheaders = count_subheaders(table);
+	int nr_subheaders = count_subheaders(table, false);
 	struct ctl_table_header *header = NULL, **subheaders, **subheader;
 	const struct ctl_path *component;
 	char *new_path, *pos;
@@ -1591,7 +1657,7 @@ struct ctl_table_header *__register_sysctl_paths(
 		header->ctl_table_arg = ctl_table_arg;
 
 		if (register_leaf_sysctl_tables(new_path, pos, &subheader,
-						set, table))
+						set, table, false))
 			goto err_register_leaves;
 	}
 
@@ -1655,7 +1721,7 @@ int __register_sysctl_base(struct ctl_table *base_table)
 	return 0;
 }
 
-static void put_links(struct ctl_table_header *header)
+static void put_links(struct ctl_table_header *header, bool register_single_one)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
 	struct ctl_table_root *root = header->root;
@@ -1686,6 +1752,9 @@ static void put_links(struct ctl_table_header *header)
 			sysctl_print_dir(parent);
 			pr_cont("%s\n", name);
 		}
+
+		if (register_single_one)
+			break;
 	}
 }
 
@@ -1697,7 +1766,7 @@ static void drop_sysctl_table(struct ctl_table_header *header)
 		return;
 
 	if (parent) {
-		put_links(header);
+		put_links(header, false);
 		start_unregistering(header);
 	}
 
@@ -1723,7 +1792,7 @@ void unregister_sysctl_table(struct ctl_table_header * header)
 	if (header == NULL)
 		return;
 
-	nr_subheaders = count_subheaders(header->ctl_table_arg);
+	nr_subheaders = count_subheaders(header->ctl_table_arg, false);
 	if (unlikely(nr_subheaders > 1)) {
 		struct ctl_table_header **subheaders;
 		int i;
@@ -1751,7 +1820,7 @@ void setup_sysctl_set(struct ctl_table_set *set,
 {
 	memset(set, 0, sizeof(*set));
 	set->is_seen = is_seen;
-	init_header(&set->dir.header, root, set, NULL, root_table);
+	init_header(&set->dir.header, root, set, NULL, root_table, false);
 }
 
 void retire_sysctl_set(struct ctl_table_set *set)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 644fd53ad5f1..39215b746a34 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -218,9 +218,11 @@ extern void setup_sysctl_set(struct ctl_table_set *p,
 	int (*is_seen)(struct ctl_table_set *));
 extern void retire_sysctl_set(struct ctl_table_set *set);
 
-struct ctl_table_header *__register_sysctl_table(
+#define __register_sysctl_table(set, path, table) \
+	__register_sysctl_tables(set, path, table, false)
+struct ctl_table_header *__register_sysctl_tables(
 	struct ctl_table_set *set,
-	const char *path, struct ctl_table *table);
+	const char *path, struct ctl_table *table, bool register_single_one);
 struct ctl_table_header *__register_sysctl_paths(
 	struct ctl_table_set *set,
 	const struct ctl_path *path, struct ctl_table *table);
@@ -235,6 +237,9 @@ extern int sysctl_init_bases(void);
 extern void __register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name);
 #define register_sysctl_init(path, table) __register_sysctl_init(path, table, #table)
+extern struct ctl_table_header *__register_sysctl_single(const char *path,
+		struct ctl_table *table);
+#define register_sysctl_single(path, table) __register_sysctl_single(path, table)
 extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
-- 
2.20.1



