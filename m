Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431704CD356
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 12:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiCDLZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 06:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbiCDLZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:25:00 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C63E18BA4E
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Mar 2022 03:24:10 -0800 (PST)
X-QQ-mid: bizesmtp91t1646393029tw1bsme9
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 04 Mar 2022 19:23:42 +0800 (CST)
X-QQ-SSF: 00400000002000C0G000000A0000000
X-QQ-FEAT: dpyQmELDBxEFTv1ES0F605CBas6bRFMCszmKDjmg2GbiKM45ScSeFVFoGNSoc
        2nb5dxAg/c74wYb7Kozv3VbtZlySEbfW7FfCF3bEOCC0ZkxhbYqPSA8ShdKcU+0LsJD1BHM
        nLxkmtFkD8qhqEHBKxJEEXaWbuBeb8kMA2RueE5nzJhERucgpTqmQeZYHi5/EX6HyE7qhXg
        TF5Ota84G3/CgiABuPyaCyts6MOvACesK1TYj6aS/HDQ0aGlobSzR+dh8ESUY2X5wQZl1N8
        KvKtV6RiZ/E1nvztEceGSweyjIL+NGLMoqU6Nw7fP++iDCSw5DQmjw2IL21TEreonoBr8p7
        MDz2xy2rKfQcXF3uxtBGunSEg5TOv7xizgU8sX4aN5C9ZIyAEs=
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        ebiederm@xmission.com, willy@infradead.org
Cc:     nixiaoming@huawei.com, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH v5 1/2] fs/proc: optimize register ctl_tables
Date:   Fri,  4 Mar 2022 19:23:40 +0800
Message-Id: <20220304112341.19528-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sysctls are being moved out of kernel/sysctl.c and out to
their own respective subsystems / users to help with easier
maintance and avoid merge conflicts. But when we move entries
and to its own new file the last entry for this new file must
be empty, so we are essentialy bloating the kernel one extra
empty entry per each newly moved sysctl.

To help with this, this adds support for registering ctl_tables
by register nums, therefore not bloating the kernel when we
move ctl_tables to its own file.

Due to child, empty table and other scenarios that use pointers,
some scenarios cannot obtain the value of ARRAY_SIZE(), so two
loop conditions are currently used. The newly added num is used
as a judgment condition. I use the writing method of
‘if(--num == 0)‘ to realize the function and reduce code changes
as much as possible. After that, when 'register_by_num > 0', exit
the loop until register_by_num is decreased to 0.
when 'register_by_num = 0', 'if(--num == 0)' will never hold and
will not affect the original loop condition.

However, due to the particularity of child, if a child table needs
to be registered, the child table still needs to end with an empty
one. But this will save space for most scenarios anyway.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 fs/proc/proc_sysctl.c  | 177 ++++++++++++++++++++++++++++-------------
 include/linux/sysctl.h |  15 ++--
 2 files changed, 131 insertions(+), 61 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c87c99f0856..407c88847a6a 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -100,8 +100,8 @@ static DEFINE_SPINLOCK(sysctl_lock);
 static void drop_sysctl_table(struct ctl_table_header *header);
 static int sysctl_follow_link(struct ctl_table_header **phead,
 	struct ctl_table **pentry);
-static int insert_links(struct ctl_table_header *head);
-static void put_links(struct ctl_table_header *header);
+static int insert_links(struct ctl_table_header *head, int register_by_num);
+static void put_links(struct ctl_table_header *header, int register_by_num);
 
 static void sysctl_print_dir(struct ctl_dir *dir)
 {
@@ -200,7 +200,7 @@ static void erase_entry(struct ctl_table_header *head, struct ctl_table *entry)
 
 static void init_header(struct ctl_table_header *head,
 	struct ctl_table_root *root, struct ctl_table_set *set,
-	struct ctl_node *node, struct ctl_table *table)
+	struct ctl_node *node, struct ctl_table *table, int register_by_num)
 {
 	head->ctl_table = table;
 	head->ctl_table_arg = table;
@@ -212,25 +212,34 @@ static void init_header(struct ctl_table_header *head,
 	head->set = set;
 	head->parent = NULL;
 	head->node = node;
+
 	INIT_HLIST_HEAD(&head->inodes);
 	if (node) {
 		struct ctl_table *entry;
-		for (entry = table; entry->procname; entry++, node++)
+		for (entry = table; entry->procname; entry++, node++) {
 			node->header = head;
+			if (--register_by_num == 0)
+				break;
+		}
 	}
 }
 
-static void erase_header(struct ctl_table_header *head)
+static void erase_header(struct ctl_table_header *head, int register_by_num)
 {
 	struct ctl_table *entry;
-	for (entry = head->ctl_table; entry->procname; entry++)
+
+	for (entry = head->ctl_table; entry->procname; entry++) {
 		erase_entry(head, entry);
+		if (--register_by_num == 0)
+			break;
+	}
 }
 
-static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
+static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header,
+	int register_by_num)
 {
 	struct ctl_table *entry;
-	int err;
+	int err, num;
 
 	/* Is this a permanently empty directory? */
 	if (is_empty_dir(&dir->header))
@@ -245,18 +254,23 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 
 	dir->header.nreg++;
 	header->parent = dir;
-	err = insert_links(header);
+	err = insert_links(header, register_by_num);
+
 	if (err)
 		goto fail_links;
+
+	num = register_by_num;
 	for (entry = header->ctl_table; entry->procname; entry++) {
 		err = insert_entry(header, entry);
 		if (err)
 			goto fail;
+		if (--num == 0)
+			break;
 	}
 	return 0;
 fail:
-	erase_header(header);
-	put_links(header);
+	erase_header(header, register_by_num);
+	put_links(header, register_by_num);
 fail_links:
 	if (header->ctl_table == sysctl_mount_point)
 		clear_empty_dir(dir);
@@ -315,7 +329,7 @@ static void start_unregistering(struct ctl_table_header *p)
 	 * list in do_sysctl() relies on that.
 	 */
 	spin_lock(&sysctl_lock);
-	erase_header(p);
+	erase_header(p, 0);
 }
 
 static struct ctl_table_header *sysctl_head_grab(struct ctl_table_header *head)
@@ -981,7 +995,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
 	new_name[namelen] = '\0';
 	table[0].procname = new_name;
 	table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
-	init_header(&new->header, set->dir.header.root, set, node, table);
+	init_header(&new->header, set->dir.header.root, set, node, table, 0);
 
 	return new;
 }
@@ -1027,7 +1041,7 @@ static struct ctl_dir *get_subdir(struct ctl_dir *dir,
 		goto failed;
 
 	/* Nope.  Use the our freshly made directory entry. */
-	err = insert_header(dir, &new->header);
+	err = insert_header(dir, &new->header, 0);
 	subdir = ERR_PTR(err);
 	if (err)
 		goto failed;
@@ -1128,7 +1142,8 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 	return err;
 }
 
-static int sysctl_check_table(const char *path, struct ctl_table *table)
+static int sysctl_check_table(const char *path, struct ctl_table *table,
+		int register_by_num)
 {
 	int err = 0;
 	for (; table->procname; table++) {
@@ -1159,24 +1174,30 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
 		if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
 			err |= sysctl_err(path, table, "bogus .mode 0%o",
 				table->mode);
+		if (--register_by_num == 0)
+			break;
 	}
 	return err;
 }
 
 static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table *table,
-	struct ctl_table_root *link_root)
+	struct ctl_table_root *link_root, int register_by_num)
 {
 	struct ctl_table *link_table, *entry, *link;
 	struct ctl_table_header *links;
 	struct ctl_node *node;
 	char *link_name;
-	int nr_entries, name_bytes;
+	int nr_entries, name_bytes, num;
 
 	name_bytes = 0;
 	nr_entries = 0;
+	num = register_by_num;
+
 	for (entry = table; entry->procname; entry++) {
 		nr_entries++;
 		name_bytes += strlen(entry->procname) + 1;
+		if (--num == 0)
+			break;
 	}
 
 	links = kzalloc(sizeof(struct ctl_table_header) +
@@ -1191,6 +1212,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
 	node = (struct ctl_node *)(links + 1);
 	link_table = (struct ctl_table *)(node + nr_entries);
 	link_name = (char *)&link_table[nr_entries + 1];
+	num = register_by_num;
 
 	for (link = link_table, entry = table; entry->procname; link++, entry++) {
 		int len = strlen(entry->procname) + 1;
@@ -1199,42 +1221,56 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
 		link->mode = S_IFLNK|S_IRWXUGO;
 		link->data = link_root;
 		link_name += len;
+		if (--num == 0)
+			break;
 	}
-	init_header(links, dir->header.root, dir->header.set, node, link_table);
+	init_header(links, dir->header.root, dir->header.set, node, link_table,
+		    register_by_num);
 	links->nreg = nr_entries;
 
 	return links;
 }
 
 static bool get_links(struct ctl_dir *dir,
-	struct ctl_table *table, struct ctl_table_root *link_root)
+	struct ctl_table *table, struct ctl_table_root *link_root,
+	int register_by_num)
 {
 	struct ctl_table_header *head;
 	struct ctl_table *entry, *link;
 
+	int num = register_by_num;
 	/* Are there links available for every entry in table? */
 	for (entry = table; entry->procname; entry++) {
 		const char *procname = entry->procname;
 		link = find_entry(&head, dir, procname, strlen(procname));
 		if (!link)
 			return false;
-		if (S_ISDIR(link->mode) && S_ISDIR(entry->mode))
+		if (S_ISDIR(link->mode) && S_ISDIR(entry->mode)) {
+			if (--num == 0)
+				break;
 			continue;
-		if (S_ISLNK(link->mode) && (link->data == link_root))
+		}
+		if (S_ISLNK(link->mode) && (link->data == link_root)) {
+			if (--num == 0)
+				break;
 			continue;
+		}
 		return false;
 	}
 
+	num = register_by_num;
 	/* The checks passed.  Increase the registration count on the links */
 	for (entry = table; entry->procname; entry++) {
 		const char *procname = entry->procname;
 		link = find_entry(&head, dir, procname, strlen(procname));
 		head->nreg++;
+		if (--num == 0)
+			break;
 	}
 	return true;
 }
 
-static int insert_links(struct ctl_table_header *head)
+static int insert_links(struct ctl_table_header *head, int register_by_num)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
 	struct ctl_dir *core_parent = NULL;
@@ -1248,13 +1284,13 @@ static int insert_links(struct ctl_table_header *head)
 	if (IS_ERR(core_parent))
 		return 0;
 
-	if (get_links(core_parent, head->ctl_table, head->root))
+	if (get_links(core_parent, head->ctl_table, head->root, register_by_num))
 		return 0;
 
 	core_parent->header.nreg++;
 	spin_unlock(&sysctl_lock);
 
-	links = new_links(core_parent, head->ctl_table, head->root);
+	links = new_links(core_parent, head->ctl_table, head->root, register_by_num);
 
 	spin_lock(&sysctl_lock);
 	err = -ENOMEM;
@@ -1262,12 +1298,12 @@ static int insert_links(struct ctl_table_header *head)
 		goto out;
 
 	err = 0;
-	if (get_links(core_parent, head->ctl_table, head->root)) {
+	if (get_links(core_parent, head->ctl_table, head->root, register_by_num)) {
 		kfree(links);
 		goto out;
 	}
 
-	err = insert_header(core_parent, links);
+	err = insert_header(core_parent, links, register_by_num);
 	if (err)
 		kfree(links);
 out:
@@ -1276,13 +1312,15 @@ static int insert_links(struct ctl_table_header *head)
 }
 
 /**
- * __register_sysctl_table - register a leaf sysctl table
+ * __register_sysctl_table_with_num - register a leaf sysctl table
  * @set: Sysctl tree to register on
  * @path: The path to the directory the sysctl table is in.
  * @table: the top-level table structure
+ * @register_by_num: register single one and table must be without child
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
- * array. A completely 0 filled entry terminates the table.
+ * array. If there is child in the table. A completely 0 filled entry terminates
+ * the child table.
  *
  * The members of the &struct ctl_table structure are used as follows:
  *
@@ -1317,9 +1355,9 @@ static int insert_links(struct ctl_table_header *head)
  * This routine returns %NULL on a failure to register, and a pointer
  * to the table header on success.
  */
-struct ctl_table_header *__register_sysctl_table(
+struct ctl_table_header *__register_sysctl_table_with_num(
 	struct ctl_table_set *set,
-	const char *path, struct ctl_table *table)
+	const char *path, struct ctl_table *table, int register_by_num)
 {
 	struct ctl_table_root *root = set->dir.header.root;
 	struct ctl_table_header *header;
@@ -1328,9 +1366,13 @@ struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table *entry;
 	struct ctl_node *node;
 	int nr_entries = 0;
+	int num = register_by_num;
 
-	for (entry = table; entry->procname; entry++)
+	for (entry = table; entry->procname; entry++) {
 		nr_entries++;
+		if (--num == 0)
+			break;
+	}
 
 	header = kzalloc(sizeof(struct ctl_table_header) +
 			 sizeof(struct ctl_node)*nr_entries, GFP_KERNEL);
@@ -1338,8 +1380,8 @@ struct ctl_table_header *__register_sysctl_table(
 		return NULL;
 
 	node = (struct ctl_node *)(header + 1);
-	init_header(header, root, set, node, table);
-	if (sysctl_check_table(path, table))
+	init_header(header, root, set, node, table, register_by_num);
+	if (sysctl_check_table(path, table, register_by_num))
 		goto fail;
 
 	spin_lock(&sysctl_lock);
@@ -1367,7 +1409,7 @@ struct ctl_table_header *__register_sysctl_table(
 	}
 
 	spin_lock(&sysctl_lock);
-	if (insert_header(dir, header))
+	if (insert_header(dir, header, register_by_num))
 		goto fail_put_dir_locked;
 
 	drop_sysctl_table(&dir->header);
@@ -1388,23 +1430,26 @@ struct ctl_table_header *__register_sysctl_table(
  * register_sysctl - register a sysctl table
  * @path: The path to the directory the sysctl table is in.
  * @table: the table structure
+ * @register_by_num: register single one and table must be without child
  *
  * Register a sysctl table. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
  *
  * See __register_sysctl_table for more details.
  */
-struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table)
+struct ctl_table_header *register_sysctl_with_num(const char *path,
+		struct ctl_table *table, int register_by_num)
 {
-	return __register_sysctl_table(&sysctl_table_root.default_set,
-					path, table);
+	return __register_sysctl_table_with_num(&sysctl_table_root.default_set,
+					path, table, register_by_num);
 }
-EXPORT_SYMBOL(register_sysctl);
+EXPORT_SYMBOL(register_sysctl_with_num);
 
 /**
  * __register_sysctl_init() - register sysctl table to path
  * @path: path name for sysctl base
  * @table: This is the sysctl table that needs to be registered to the path
+ * @register_by_num: register single one and table must be without child
  * @table_name: The name of sysctl table, only used for log printing when
  *              registration fails
  *
@@ -1422,9 +1467,9 @@ EXPORT_SYMBOL(register_sysctl);
  * sysctl_init_bases().
  */
 void __init __register_sysctl_init(const char *path, struct ctl_table *table,
-				 const char *table_name)
+				 int register_by_num, const char *table_name)
 {
-	struct ctl_table_header *hdr = register_sysctl(path, table);
+	struct ctl_table_header *hdr = register_sysctl_with_num(path, table, register_by_num);
 
 	if (unlikely(!hdr)) {
 		pr_err("failed when register_sysctl %s to %s\n", table_name, path);
@@ -1446,10 +1491,11 @@ static char *append_path(const char *path, char *pos, const char *name)
 	return pos;
 }
 
-static int count_subheaders(struct ctl_table *table)
+static int count_subheaders(struct ctl_table *table, int register_by_num)
 {
 	int has_files = 0;
 	int nr_subheaders = 0;
+	int num = register_by_num;
 	struct ctl_table *entry;
 
 	/* special case: no directory and empty directory */
@@ -1458,28 +1504,33 @@ static int count_subheaders(struct ctl_table *table)
 
 	for (entry = table; entry->procname; entry++) {
 		if (entry->child)
-			nr_subheaders += count_subheaders(entry->child);
+			nr_subheaders += count_subheaders(entry->child, 0);
 		else
 			has_files = 1;
+		if (--num == 0)
+			break;
 	}
 	return nr_subheaders + has_files;
 }
 
 static int register_leaf_sysctl_tables(const char *path, char *pos,
 	struct ctl_table_header ***subheader, struct ctl_table_set *set,
-	struct ctl_table *table)
+	struct ctl_table *table, int register_by_num)
 {
 	struct ctl_table *ctl_table_arg = NULL;
 	struct ctl_table *entry, *files;
 	int nr_files = 0;
 	int nr_dirs = 0;
 	int err = -ENOMEM;
+	int num = register_by_num;
 
 	for (entry = table; entry->procname; entry++) {
 		if (entry->child)
 			nr_dirs++;
 		else
 			nr_files++;
+		if (--num == 0)
+			break;
 	}
 
 	files = table;
@@ -1492,18 +1543,24 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 			goto out;
 
 		ctl_table_arg = files;
+		num = register_by_num;
 		for (new = files, entry = table; entry->procname; entry++) {
-			if (entry->child)
+			if (entry->child) {
+				if (--num == 0)
+					break;
 				continue;
+			}
 			*new = *entry;
 			new++;
+			if (--num == 0)
+				break;
 		}
 	}
 
 	/* Register everything except a directory full of subdirectories */
 	if (nr_files || !nr_dirs) {
 		struct ctl_table_header *header;
-		header = __register_sysctl_table(set, path, files);
+		header = __register_sysctl_table_with_num(set, path, files, register_by_num);
 		if (!header) {
 			kfree(ctl_table_arg);
 			goto out;
@@ -1515,12 +1572,16 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 		(*subheader)++;
 	}
 
+	num = register_by_num;
 	/* Recurse into the subdirectories. */
 	for (entry = table; entry->procname; entry++) {
 		char *child_pos;
 
-		if (!entry->child)
+		if (!entry->child) {
+			if (--num == 0)
+				break;
 			continue;
+		}
 
 		err = -ENAMETOOLONG;
 		child_pos = append_path(path, pos, entry->procname);
@@ -1528,10 +1589,12 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 			goto out;
 
 		err = register_leaf_sysctl_tables(path, child_pos, subheader,
-						  set, entry->child);
+						  set, entry->child, 0);
 		pos[0] = '\0';
 		if (err)
 			goto out;
+		if (--num == 0)
+			break;
 	}
 	err = 0;
 out:
@@ -1555,7 +1618,7 @@ struct ctl_table_header *__register_sysctl_paths(
 	const struct ctl_path *path, struct ctl_table *table)
 {
 	struct ctl_table *ctl_table_arg = table;
-	int nr_subheaders = count_subheaders(table);
+	int nr_subheaders = count_subheaders(table, 0);
 	struct ctl_table_header *header = NULL, **subheaders, **subheader;
 	const struct ctl_path *component;
 	char *new_path, *pos;
@@ -1591,7 +1654,7 @@ struct ctl_table_header *__register_sysctl_paths(
 		header->ctl_table_arg = ctl_table_arg;
 
 		if (register_leaf_sysctl_tables(new_path, pos, &subheader,
-						set, table))
+						set, table, 0))
 			goto err_register_leaves;
 	}
 
@@ -1655,13 +1718,14 @@ int __register_sysctl_base(struct ctl_table *base_table)
 	return 0;
 }
 
-static void put_links(struct ctl_table_header *header)
+static void put_links(struct ctl_table_header *header, int register_by_num)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
 	struct ctl_table_root *root = header->root;
 	struct ctl_dir *parent = header->parent;
 	struct ctl_dir *core_parent;
 	struct ctl_table *entry;
+	int num;
 
 	if (header->set == root_set)
 		return;
@@ -1669,7 +1733,7 @@ static void put_links(struct ctl_table_header *header)
 	core_parent = xlate_dir(root_set, parent);
 	if (IS_ERR(core_parent))
 		return;
-
+	num = register_by_num;
 	for (entry = header->ctl_table; entry->procname; entry++) {
 		struct ctl_table_header *link_head;
 		struct ctl_table *link;
@@ -1680,12 +1744,13 @@ static void put_links(struct ctl_table_header *header)
 		    ((S_ISDIR(link->mode) && S_ISDIR(entry->mode)) ||
 		     (S_ISLNK(link->mode) && (link->data == root)))) {
 			drop_sysctl_table(link_head);
-		}
-		else {
+		} else {
 			pr_err("sysctl link missing during unregister: ");
 			sysctl_print_dir(parent);
 			pr_cont("%s\n", name);
 		}
+		if (--num == 0)
+			break;
 	}
 }
 
@@ -1697,7 +1762,7 @@ static void drop_sysctl_table(struct ctl_table_header *header)
 		return;
 
 	if (parent) {
-		put_links(header);
+		put_links(header, 0);
 		start_unregistering(header);
 	}
 
@@ -1723,7 +1788,7 @@ void unregister_sysctl_table(struct ctl_table_header * header)
 	if (header == NULL)
 		return;
 
-	nr_subheaders = count_subheaders(header->ctl_table_arg);
+	nr_subheaders = count_subheaders(header->ctl_table_arg, 0);
 	if (unlikely(nr_subheaders > 1)) {
 		struct ctl_table_header **subheaders;
 		int i;
@@ -1751,7 +1816,7 @@ void setup_sysctl_set(struct ctl_table_set *set,
 {
 	memset(set, 0, sizeof(*set));
 	set->is_seen = is_seen;
-	init_header(&set->dir.header, root, set, NULL, root_table);
+	init_header(&set->dir.header, root, set, NULL, root_table, 0);
 }
 
 void retire_sysctl_set(struct ctl_table_set *set)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 644fd53ad5f1..cd6048f471e3 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -218,13 +218,17 @@ extern void setup_sysctl_set(struct ctl_table_set *p,
 	int (*is_seen)(struct ctl_table_set *));
 extern void retire_sysctl_set(struct ctl_table_set *set);
 
-struct ctl_table_header *__register_sysctl_table(
+#define __register_sysctl_table(set, path, table) \
+	__register_sysctl_table_with_num(set, path, table, 0)
+struct ctl_table_header *__register_sysctl_table_with_num(
 	struct ctl_table_set *set,
-	const char *path, struct ctl_table *table);
+	const char *path, struct ctl_table *table, int register_by_num);
 struct ctl_table_header *__register_sysctl_paths(
 	struct ctl_table_set *set,
 	const struct ctl_path *path, struct ctl_table *table);
-struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table);
+#define register_sysctl(path, table) register_sysctl_with_num(path, table, ARRAY_SIZE(table))
+struct ctl_table_header *register_sysctl_with_num(const char *path,
+	struct ctl_table *table, int register_by_num);
 struct ctl_table_header *register_sysctl_table(struct ctl_table * table);
 struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
 						struct ctl_table *table);
@@ -233,8 +237,9 @@ void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init_bases(void);
 extern void __register_sysctl_init(const char *path, struct ctl_table *table,
-				 const char *table_name);
-#define register_sysctl_init(path, table) __register_sysctl_init(path, table, #table)
+				 int register_by_num, const char *table_name);
+#define register_sysctl_init(path, table) \
+	__register_sysctl_init(path, table, ARRAY_SIZE(table), #table)
 extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
-- 
2.20.1



