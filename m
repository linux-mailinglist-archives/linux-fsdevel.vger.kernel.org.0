Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3918B4C9B92
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 03:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbiCBC4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 21:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239191AbiCBC4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:56:19 -0500
X-Greylist: delayed 54087 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 18:55:35 PST
Received: from smtpbg152.qq.com (smtpbg152.qq.com [13.245.186.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EA1AD11C
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 18:55:34 -0800 (PST)
X-QQ-mid: bizesmtp79t1646189720t1a5vrwx
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Mar 2022 10:55:13 +0800 (CST)
X-QQ-SSF: 01400000002000C0G000B00A0000000
X-QQ-FEAT: eTtJes0duVsOQsQJ+4M0d7Ho8po3Y03mueR2iIIyjSX/4m2oaFzsAtnECTtJ8
        C9u2f0TCsJN1N+VyJGLTCGMRItjc/sE46bBGXR8sHKaI9UUEX3stGX64Z2D8rqu79+MeNCN
        k9u5AIWg30EeMG8jixf/sv4sn3IYF0lYY11e0QE8zUKE9MDv5sZ/ECUresMSro5yw0vEtve
        hhKaMdT+mNLNz9yBZRPNAS8iokgwFhcQbAfXY2WOFS9zdaETiFEzjgzU/cjOdwVgTb27N5F
        OrcaWWKeklRS3Wh6q9yquH4nJ0uOf8kY5hAJLiqDSyv+z8k9BcZ6ipmAGk2o9bOXXvgZMPh
        bWXcQ4RwuEkHvnvjaWKqdqWfDZBz0nOQgLEIDOKrC6vyqFl2AKgUoqPTdd1IQ==
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        ebiederm@xmission.com, willy@infradead.org
Cc:     nixiaoming@huawei.com, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH v3 1/2] fs/proc: optimize exactly register one ctl_table
Date:   Wed,  2 Mar 2022 10:55:10 +0800
Message-Id: <20220302025511.20374-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
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
 fs/proc/proc_sysctl.c  | 313 +++++++++++++++++++++++++++++++++++++++++
 include/linux/sysctl.h |   6 +
 2 files changed, 319 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c87c99f0856..5eb6ddf9dfd7 100644
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
@@ -1163,6 +1254,41 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
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
+	memcpy(link_name, table->procname, strlen(table->procname) + 1);
+	link_table->procname = link_name;
+	link_table->mode = S_IFLNK|S_IRWXUGO;
+	link_table->data = link_root;
+	link_name += strlen(table->procname) + 1;
+
+	init_header_single(links, dir->header.root, dir->header.set, node, link_table);
+	links->nreg = 1;
+
+	return links;
+}
 static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table *table,
 	struct ctl_table_root *link_root)
 {
@@ -1206,6 +1332,27 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
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
@@ -1234,6 +1381,47 @@ static bool get_links(struct ctl_dir *dir,
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
@@ -1401,6 +1589,102 @@ struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *tab
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
+ * The members of the &struct ctl_table structure are used refer to
+ * __register_sysctl_table.
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
@@ -1655,6 +1939,35 @@ int __register_sysctl_base(struct ctl_table *base_table)
 	return 0;
 }
 
+static void put_links_single(struct ctl_table_header *header)
+{
+	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
+	struct ctl_table_root *root = header->root;
+	struct ctl_dir *parent = header->parent;
+	struct ctl_dir *core_parent;
+	struct ctl_table_header *link_head;
+	struct ctl_table *link;
+
+	if (header->set == root_set)
+		return;
+
+	core_parent = xlate_dir(root_set, parent);
+	if (IS_ERR(core_parent))
+		return;
+
+	link = find_entry(&link_head, core_parent, header->ctl_table->procname,
+			   strlen(header->ctl_table->procname));
+	if (link &&
+	    ((S_ISDIR(link->mode) && S_ISDIR(header->ctl_table->mode)) ||
+	     (S_ISLNK(link->mode) && (link->data == root)))) {
+		drop_sysctl_table(link_head);
+	} else {
+		pr_err("sysctl link missing during unregister: ");
+		sysctl_print_dir(parent);
+		pr_cont("%s\n", header->ctl_table->procname);
+	}
+}
+
 static void put_links(struct ctl_table_header *header)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 644fd53ad5f1..2f1754aad68c 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -218,6 +218,9 @@ extern void setup_sysctl_set(struct ctl_table_set *p,
 	int (*is_seen)(struct ctl_table_set *));
 extern void retire_sysctl_set(struct ctl_table_set *set);
 
+struct ctl_table_header *__register_sysctl_table_single(
+	struct ctl_table_set *set,
+	const char *path, struct ctl_table *table);
 struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
 	const char *path, struct ctl_table *table);
@@ -235,6 +238,9 @@ extern int sysctl_init_bases(void);
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



