Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7ED4C8B28
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 12:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbiCALyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 06:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbiCALyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:54:53 -0500
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0DA8BE0B
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 03:54:11 -0800 (PST)
X-QQ-mid: bizesmtp74t1646135629t46lpr6u
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Mar 2022 19:53:42 +0800 (CST)
X-QQ-SSF: 01400000002000C0G000B00B0000000
X-QQ-FEAT: 4LFlwc+MlXkyM36aVsxYCxN/s0RJFTkM33ZRdiF2BVR6y1v2KbKrq2qqf944J
        GsDw9i3suRVf317wB+bwb6yTZxhfUpdqndUVv2e15Kjv0IrJMrKctCyOxxCWDkXTJeSpWD9
        1t5w7WEajCV4/B0k1+0rrlX+4WX93zl4CgdD5N1oHu9ZefjyJz09ovMOmA+gYJHleDjhhcC
        H0t80l+sPrD91mCX1J7/dYFJwda5fwFjNAsbsT66OvzdnlckTHX8Jg8OAZXvUAdPN7e1ByL
        R8FH2zDdzHaoSukIcmGrNW/mu7nJPkGt3r3qAyu26pNHy+Z894hJ00xuy8+RqUrWpNlEowA
        5yTbSDUR/yCgdUOkYza+elWx/2doxxtTqWACn+7
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        ebiederm@xmission.com, willy@infradead.org
Cc:     nixiaoming@huawei.com, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH v2 1/2] fs/proc: optimize exactly register one ctl_table
Date:   Tue,  1 Mar 2022 19:53:40 +0800
Message-Id: <20220301115341.30101-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
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

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 fs/proc/proc_sysctl.c  | 346 +++++++++++++++++++++++++++++++++++++++++
 include/linux/sysctl.h |   3 +
 2 files changed, 349 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c87c99f0856..28c54e494c6a 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -101,7 +101,9 @@ static void drop_sysctl_table(struct ctl_table_header *header);
 static int sysctl_follow_link(struct ctl_table_header **phead,
 	struct ctl_table **pentry);
 static int insert_links(struct ctl_table_header *head);
+static int insert_links_single(struct ctl_table_header *head);
 static void put_links(struct ctl_table_header *header);
+static void put_links_single(struct ctl_table_header *header);
 
 static void sysctl_print_dir(struct ctl_dir *dir)
 {
@@ -198,6 +200,25 @@ static void erase_entry(struct ctl_table_header *head, struct ctl_table *entry)
 	rb_erase(node, &head->parent->root);
 }
 
+static void init_header_single(struct ctl_table_header *head,
+	struct ctl_table_root *root, struct ctl_table_set *set,
+	struct ctl_node *node, struct ctl_table *table)
+{
+	head->ctl_table = table;
+	head->ctl_table_arg = table;
+	head->used = 0;
+	head->count = 1;
+	head->nreg = 1;
+	head->unregistering = NULL;
+	head->root = root;
+	head->set = set;
+	head->parent = NULL;
+	head->node = node;
+	INIT_HLIST_HEAD(&head->inodes);
+	if (node)
+		node->header = head;
+}
+
 static void init_header(struct ctl_table_header *head,
 	struct ctl_table_root *root, struct ctl_table_set *set,
 	struct ctl_node *node, struct ctl_table *table)
@@ -227,6 +248,42 @@ static void erase_header(struct ctl_table_header *head)
 		erase_entry(head, entry);
 }
 
+static int insert_header_single(struct ctl_dir *dir, struct ctl_table_header *header)
+{
+	int err;
+
+	/* Is this a permanently empty directory? */
+	if (is_empty_dir(&dir->header))
+		return -EROFS;
+
+	/* Am I creating a permanently empty directory? */
+	if (header->ctl_table == sysctl_mount_point) {
+		if (!RB_EMPTY_ROOT(&dir->root))
+			return -EINVAL;
+		set_empty_dir(dir);
+	}
+
+	dir->header.nreg++;
+	header->parent = dir;
+	err = insert_links_single(header);
+	if (err)
+		goto fail_links;
+
+	err = insert_entry(header, header->ctl_table);
+	if (err)
+		goto fail;
+
+	return 0;
+fail:
+	erase_entry(header, header->ctl_table);
+	put_links_single(header);
+fail_links:
+	if (header->ctl_table == sysctl_mount_point)
+		clear_empty_dir(dir);
+	header->parent = NULL;
+	drop_sysctl_table(&dir->header);
+	return err;
+}
 static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 {
 	struct ctl_table *entry;
@@ -1128,6 +1185,40 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 	return err;
 }
 
+static int sysctl_check_table_single(const char *path, struct ctl_table *table)
+{
+	int err = 0;
+
+	if (table->child)
+		err |= sysctl_err(path, table, "Not a file");
+
+	if ((table->proc_handler == proc_dostring) ||
+	    (table->proc_handler == proc_dointvec) ||
+	    (table->proc_handler == proc_douintvec) ||
+	    (table->proc_handler == proc_douintvec_minmax) ||
+	    (table->proc_handler == proc_dointvec_minmax) ||
+	    (table->proc_handler == proc_dou8vec_minmax) ||
+	    (table->proc_handler == proc_dointvec_jiffies) ||
+	    (table->proc_handler == proc_dointvec_userhz_jiffies) ||
+	    (table->proc_handler == proc_dointvec_ms_jiffies) ||
+	    (table->proc_handler == proc_doulongvec_minmax) ||
+	    (table->proc_handler == proc_doulongvec_ms_jiffies_minmax)) {
+		if (!table->data)
+			err |= sysctl_err(path, table, "No data");
+		if (!table->maxlen)
+			err |= sysctl_err(path, table, "No maxlen");
+		else
+			err |= sysctl_check_table_array(path, table);
+	}
+	if (!table->proc_handler)
+		err |= sysctl_err(path, table, "No proc_handler");
+
+	if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
+		err |= sysctl_err(path, table, "bogus .mode 0%o",
+			table->mode);
+	return err;
+}
+
 static int sysctl_check_table(const char *path, struct ctl_table *table)
 {
 	int err = 0;
@@ -1163,6 +1254,43 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
 	return err;
 }
 
+static struct ctl_table_header *new_links_single(struct ctl_dir *dir, struct ctl_table *table,
+	struct ctl_table_root *link_root)
+{
+	struct ctl_table *link_table;
+	struct ctl_table_header *links;
+	struct ctl_node *node;
+	char *link_name;
+	int name_bytes = 0;
+
+	name_bytes += strlen(table->procname) + 1;
+
+	links = kzalloc(sizeof(struct ctl_table_header) +
+			sizeof(struct ctl_node) +
+			sizeof(struct ctl_table)*2 +
+			name_bytes,
+			GFP_KERNEL);
+
+	if (!links)
+		return NULL;
+
+	node = (struct ctl_node *)(links + 1);
+	link_table = (struct ctl_table *)(node + 1);
+	link_name = (char *)&link_table[2];
+
+	int len = strlen(table->procname) + 1;
+
+	memcpy(link_name, table->procname, len);
+	link_table->procname = link_name;
+	link_table->mode = S_IFLNK|S_IRWXUGO;
+	link_table->data = link_root;
+	link_name += len;
+
+	init_header_single(links, dir->header.root, dir->header.set, node, link_table);
+	links->nreg = 1;
+
+	return links;
+}
 static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table *table,
 	struct ctl_table_root *link_root)
 {
@@ -1206,6 +1334,27 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
 	return links;
 }
 
+static bool get_links_single(struct ctl_dir *dir,
+	struct ctl_table *table, struct ctl_table_root *link_root)
+{
+	struct ctl_table_header *head;
+	struct ctl_table *link;
+
+	/* Is there link available for table? */
+	const char *procname = table->procname;
+
+	link = find_entry(&head, dir, procname, strlen(procname));
+	if (!link)
+		return false;
+	if ((S_ISDIR(link->mode) && S_ISDIR(table->mode)) ||
+	    (S_ISLNK(link->mode) && (link->data == link_root))) {
+		head->nreg++;
+		return true;
+	}
+
+	return false;
+}
+
 static bool get_links(struct ctl_dir *dir,
 	struct ctl_table *table, struct ctl_table_root *link_root)
 {
@@ -1234,6 +1383,47 @@ static bool get_links(struct ctl_dir *dir,
 	return true;
 }
 
+static int insert_links_single(struct ctl_table_header *head)
+{
+	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
+	struct ctl_dir *core_parent = NULL;
+	struct ctl_table_header *links;
+	int err;
+
+	if (head->set == root_set)
+		return 0;
+
+	core_parent = xlate_dir(root_set, head->parent);
+	if (IS_ERR(core_parent))
+		return 0;
+
+	if (get_links_single(core_parent, head->ctl_table, head->root))
+		return 0;
+
+	core_parent->header.nreg++;
+	spin_unlock(&sysctl_lock);
+
+	links = new_links_single(core_parent, head->ctl_table, head->root);
+
+	spin_lock(&sysctl_lock);
+	err = -ENOMEM;
+	if (!links)
+		goto out;
+
+	err = 0;
+	if (get_links_single(core_parent, head->ctl_table, head->root)) {
+		kfree(links);
+		goto out;
+	}
+
+	err = insert_header_single(core_parent, links);
+	if (err)
+		kfree(links);
+out:
+	drop_sysctl_table(&core_parent->header);
+	return err;
+}
+
 static int insert_links(struct ctl_table_header *head)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
@@ -1401,6 +1591,132 @@ struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *tab
 }
 EXPORT_SYMBOL(register_sysctl);
 
+/**
+ * __register_sysctl_table_single - register a leaf sysctl table
+ * @set: Sysctl tree to register on
+ * @path: The path to the directory the sysctl table is in.
+ * @table: the top-level table structure
+ *
+ * Register extraly one sysctl table. @table should be a filled in extraly one
+ * ctl_table. If ctl_table which need to register have child or is not single,
+ * we should use register_sysctl_init or register_sysctl instead of
+ * register_sysctl_single.
+ *
+ * The members of the &struct ctl_table structure are used as follows:
+ *
+ * procname - the name of the sysctl file under /proc/sys. Set to %NULL to not
+ *            enter a sysctl file
+ *
+ * data - a pointer to data for use by proc_handler
+ *
+ * maxlen - the maximum size in bytes of the data
+ *
+ * mode - the file permissions for the /proc/sys file
+ *
+ * child - must be %NULL.
+ *
+ * proc_handler - the text handler routine (described below)
+ *
+ * extra1, extra2 - extra pointers usable by the proc handler routines
+ *
+ * Leaf nodes in the sysctl tree will be represented by a single file
+ * under /proc; non-leaf nodes will be represented by directories.
+ *
+ * There must be a proc_handler routine for any terminal nodes.
+ * Several default handlers are available to cover common cases -
+ *
+ * proc_dostring(), proc_dointvec(), proc_dointvec_jiffies(),
+ * proc_dointvec_userhz_jiffies(), proc_dointvec_minmax(),
+ * proc_doulongvec_ms_jiffies_minmax(), proc_doulongvec_minmax()
+ *
+ * It is the handler's job to read the input buffer from user memory
+ * and process it. The handler should return 0 on success.
+ *
+ * This routine returns %NULL on a failure to register, and a pointer
+ * to the table header on success.
+ */
+struct ctl_table_header *__register_sysctl_table_single(
+	struct ctl_table_set *set,
+	const char *path, struct ctl_table *table)
+{
+	struct ctl_table_root *root = set->dir.header.root;
+	struct ctl_table_header *header;
+	const char *name, *nextname;
+	struct ctl_dir *dir;
+	struct ctl_node *node;
+
+	header = kzalloc(sizeof(struct ctl_table_header) +
+			 sizeof(struct ctl_node), GFP_KERNEL);
+	if (!header)
+		return NULL;
+
+	node = (struct ctl_node *)(header + 1);
+	init_header_single(header, root, set, node, table);
+	if (sysctl_check_table_single(path, table))
+		goto fail;
+
+	spin_lock(&sysctl_lock);
+	dir = &set->dir;
+	/* Reference moved down the diretory tree get_subdir */
+	dir->header.nreg++;
+	spin_unlock(&sysctl_lock);
+
+	/* Find the directory for the ctl_table */
+	for (name = path; name; name = nextname) {
+		int namelen;
+
+		nextname = strchr(name, '/');
+		if (nextname) {
+			namelen = nextname - name;
+			nextname++;
+		} else {
+			namelen = strlen(name);
+		}
+		if (namelen == 0)
+			continue;
+
+		dir = get_subdir(dir, name, namelen);
+		if (IS_ERR(dir))
+			goto fail;
+	}
+
+	spin_lock(&sysctl_lock);
+	if (insert_header_single(dir, header))
+		goto fail_put_dir_locked;
+
+	drop_sysctl_table(&dir->header);
+	spin_unlock(&sysctl_lock);
+
+	return header;
+
+fail_put_dir_locked:
+	drop_sysctl_table(&dir->header);
+	spin_unlock(&sysctl_lock);
+fail:
+	kfree(header);
+	dump_stack();
+	return NULL;
+}
+
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
+ * See __register_sysctl_table_single for more details.
+ */
+struct ctl_table_header *__register_sysctl_single(const char *path, struct ctl_table *table)
+{
+	return __register_sysctl_table_single(&sysctl_table_root.default_set,
+					path, table);
+}
+EXPORT_SYMBOL(__register_sysctl_single);
+
 /**
  * __register_sysctl_init() - register sysctl table to path
  * @path: path name for sysctl base
@@ -1655,6 +1971,36 @@ int __register_sysctl_base(struct ctl_table *base_table)
 	return 0;
 }
 
+static void put_links_single(struct ctl_table_header *header)
+{
+	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
+	struct ctl_table_root *root = header->root;
+	struct ctl_dir *parent = header->parent;
+	struct ctl_dir *core_parent;
+
+	if (header->set == root_set)
+		return;
+
+	core_parent = xlate_dir(root_set, parent);
+	if (IS_ERR(core_parent))
+		return;
+
+	struct ctl_table_header *link_head;
+	struct ctl_table *link;
+	const char *name = header->ctl_table->procname;
+
+	link = find_entry(&link_head, core_parent, name, strlen(name));
+	if (link &&
+	    ((S_ISDIR(link->mode) && S_ISDIR(header->ctl_table->mode)) ||
+	     (S_ISLNK(link->mode) && (link->data == root)))) {
+		drop_sysctl_table(link_head);
+	} else {
+		pr_err("sysctl link missing during unregister: ");
+		sysctl_print_dir(parent);
+		pr_cont("%s\n", name);
+	}
+}
+
 static void put_links(struct ctl_table_header *header)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 644fd53ad5f1..a7a5c3f25da9 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -235,6 +235,9 @@ extern int sysctl_init_bases(void);
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



