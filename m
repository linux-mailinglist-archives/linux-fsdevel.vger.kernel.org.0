Return-Path: <linux-fsdevel+bounces-4747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10302802D41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6908AB20521
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1360FBED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jvhWRH89"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CC7D40;
	Sun,  3 Dec 2023 23:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676352;
	bh=9nBMacsanlhzZJASTxZhPJi991jsWkTabtKO81fhipo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jvhWRH89Ic9vDUHTzSt8Uh+iGp7YizRcPKiVw81WlZX1yZnc/R2JZUORrhSjYpzeo
	 DRxt93ZsBTvHlu/kMmI4oH4Yh317qatN1y4rxBg696Q5SkxftQrOMSY3ez1kgHUF4T
	 Boi8nAL7vzG5r+kw9udhZbdDALc2GjNei+vbt+bU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:27 +0100
Subject: [PATCH v2 14/18] sysctl: move internal interfaces to const struct
 ctl_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-14-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=13639;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9nBMacsanlhzZJASTxZhPJi991jsWkTabtKO81fhipo=;
 b=d9aQrvd48wyO+t/Vy/qlJHL1hqbyG3yItKw5Tjbj44p8a6JshvGWXkVDo+4pPt8ZadWp4E9TJ
 8AIbS1RDcJ1ADppPe9iRU6AOt5P7CSzSZEz0Tu8nAC3q4oJ5YZ0Hb5Q
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

As a preparation to make all the sysctl code work with
const struct ctl_table switch over the internal function to use the
const variant.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/internal.h     |  2 +-
 fs/proc/proc_sysctl.c  | 81 +++++++++++++++++++++++++-------------------------
 include/linux/sysctl.h |  2 +-
 3 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 9a8f32f21ff5..36d6bf581688 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -101,7 +101,7 @@ struct proc_inode {
 	union proc_op op;
 	struct proc_dir_entry *pde;
 	struct ctl_table_header *sysctl;
-	struct ctl_table *sysctl_entry;
+	const struct ctl_table *sysctl_entry;
 	struct hlist_node sibling_inodes;
 	const struct proc_ns_operations *ns_ops;
 	struct inode vfs_inode;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index a398cc77637f..e7fd1680d479 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -86,7 +86,7 @@ static DEFINE_SPINLOCK(sysctl_lock);
 
 static void drop_sysctl_table(struct ctl_table_header *header);
 static int sysctl_follow_link(struct ctl_table_header **phead,
-	struct ctl_table **pentry);
+	const struct ctl_table **pentry);
 static int insert_links(struct ctl_table_header *head);
 static void put_links(struct ctl_table_header *header);
 
@@ -108,11 +108,11 @@ static int namecmp(const char *name1, int len1, const char *name2, int len2)
 }
 
 /* Called under sysctl_lock */
-static struct ctl_table *find_entry(struct ctl_table_header **phead,
+static const struct ctl_table *find_entry(struct ctl_table_header **phead,
 	struct ctl_dir *dir, const char *name, int namelen)
 {
 	struct ctl_table_header *head;
-	struct ctl_table *entry;
+	const struct ctl_table *entry;
 	struct rb_node *node = dir->root.rb_node;
 
 	while (node)
@@ -139,7 +139,7 @@ static struct ctl_table *find_entry(struct ctl_table_header **phead,
 	return NULL;
 }
 
-static int insert_entry(struct ctl_table_header *head, struct ctl_table *entry)
+static int insert_entry(struct ctl_table_header *head, const struct ctl_table *entry)
 {
 	struct rb_node *node = &head->node[entry - head->ctl_table].node;
 	struct rb_node **p = &head->parent->root.rb_node;
@@ -149,7 +149,7 @@ static int insert_entry(struct ctl_table_header *head, struct ctl_table *entry)
 
 	while (*p) {
 		struct ctl_table_header *parent_head;
-		struct ctl_table *parent_entry;
+		const struct ctl_table *parent_entry;
 		struct ctl_node *parent_node;
 		const char *parent_name;
 		int cmp;
@@ -178,7 +178,7 @@ static int insert_entry(struct ctl_table_header *head, struct ctl_table *entry)
 	return 0;
 }
 
-static void erase_entry(struct ctl_table_header *head, struct ctl_table *entry)
+static void erase_entry(struct ctl_table_header *head, const struct ctl_table *entry)
 {
 	struct rb_node *node = &head->node[entry - head->ctl_table].node;
 
@@ -187,7 +187,7 @@ static void erase_entry(struct ctl_table_header *head, struct ctl_table *entry)
 
 static void init_header(struct ctl_table_header *head,
 	struct ctl_table_root *root, struct ctl_table_set *set,
-	struct ctl_node *node, struct ctl_table *table, size_t table_size)
+	struct ctl_node *node, const struct ctl_table *table, size_t table_size)
 {
 	head->ctl_table = table;
 	head->ctl_table_size = table_size;
@@ -202,7 +202,7 @@ static void init_header(struct ctl_table_header *head,
 	head->node = node;
 	INIT_HLIST_HEAD(&head->inodes);
 	if (node) {
-		struct ctl_table *entry;
+		const struct ctl_table *entry;
 
 		list_for_each_table_entry(entry, head) {
 			node->header = head;
@@ -213,7 +213,7 @@ static void init_header(struct ctl_table_header *head,
 
 static void erase_header(struct ctl_table_header *head)
 {
-	struct ctl_table *entry;
+	const struct ctl_table *entry;
 
 	list_for_each_table_entry(entry, head)
 		erase_entry(head, entry);
@@ -221,7 +221,7 @@ static void erase_header(struct ctl_table_header *head)
 
 static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 {
-	struct ctl_table *entry;
+	const struct ctl_table *entry;
 	struct ctl_table_header *dir_h = &dir->header;
 	int err;
 
@@ -341,12 +341,12 @@ lookup_header_set(struct ctl_table_root *root)
 	return set;
 }
 
-static struct ctl_table *lookup_entry(struct ctl_table_header **phead,
-				      struct ctl_dir *dir,
-				      const char *name, int namelen)
+static const struct ctl_table *lookup_entry(struct ctl_table_header **phead,
+					    struct ctl_dir *dir,
+					    const char *name, int namelen)
 {
 	struct ctl_table_header *head;
-	struct ctl_table *entry;
+	const struct ctl_table *entry;
 
 	spin_lock(&sysctl_lock);
 	entry = find_entry(&head, dir, name, namelen);
@@ -371,10 +371,10 @@ static struct ctl_node *first_usable_entry(struct rb_node *node)
 }
 
 static void first_entry(struct ctl_dir *dir,
-	struct ctl_table_header **phead, struct ctl_table **pentry)
+	struct ctl_table_header **phead, const struct ctl_table **pentry)
 {
 	struct ctl_table_header *head = NULL;
-	struct ctl_table *entry = NULL;
+	const struct ctl_table *entry = NULL;
 	struct ctl_node *ctl_node;
 
 	spin_lock(&sysctl_lock);
@@ -388,10 +388,10 @@ static void first_entry(struct ctl_dir *dir,
 	*pentry = entry;
 }
 
-static void next_entry(struct ctl_table_header **phead, struct ctl_table **pentry)
+static void next_entry(struct ctl_table_header **phead, const struct ctl_table **pentry)
 {
 	struct ctl_table_header *head = *phead;
-	struct ctl_table *entry = *pentry;
+	const struct ctl_table *entry = *pentry;
 	struct ctl_node *ctl_node = &head->node[entry - head->ctl_table];
 
 	spin_lock(&sysctl_lock);
@@ -424,7 +424,7 @@ static int test_perm(int mode, int op)
 	return -EACCES;
 }
 
-static int sysctl_perm(struct ctl_table_header *head, struct ctl_table *table, int op)
+static int sysctl_perm(struct ctl_table_header *head, const struct ctl_table *table, int op)
 {
 	struct ctl_table_root *root = head->root;
 	int mode;
@@ -438,7 +438,7 @@ static int sysctl_perm(struct ctl_table_header *head, struct ctl_table *table, i
 }
 
 static struct inode *proc_sys_make_inode(struct super_block *sb,
-		struct ctl_table_header *head, struct ctl_table *table)
+		struct ctl_table_header *head, const struct ctl_table *table)
 {
 	struct ctl_table_root *root = head->root;
 	struct inode *inode;
@@ -511,7 +511,7 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 	struct ctl_table_header *head = grab_header(dir);
 	struct ctl_table_header *h = NULL;
 	const struct qstr *name = &dentry->d_name;
-	struct ctl_table *p;
+	const struct ctl_table *p;
 	struct inode *inode;
 	struct dentry *err = ERR_PTR(-ENOENT);
 	struct ctl_dir *ctl_dir;
@@ -554,7 +554,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct ctl_table_header *head = grab_header(inode);
-	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
 	size_t count = iov_iter_count(iter);
 	char *kbuf;
 	ssize_t error;
@@ -628,7 +628,7 @@ static ssize_t proc_sys_write(struct kiocb *iocb, struct iov_iter *iter)
 static int proc_sys_open(struct inode *inode, struct file *filp)
 {
 	struct ctl_table_header *head = grab_header(inode);
-	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
 
 	/* sysctl was unregistered */
 	if (IS_ERR(head))
@@ -646,7 +646,7 @@ static __poll_t proc_sys_poll(struct file *filp, poll_table *wait)
 {
 	struct inode *inode = file_inode(filp);
 	struct ctl_table_header *head = grab_header(inode);
-	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
 	__poll_t ret = DEFAULT_POLLMASK;
 	unsigned long event;
 
@@ -677,7 +677,7 @@ static __poll_t proc_sys_poll(struct file *filp, poll_table *wait)
 static bool proc_sys_fill_cache(struct file *file,
 				struct dir_context *ctx,
 				struct ctl_table_header *head,
-				struct ctl_table *table)
+				const struct ctl_table *table)
 {
 	struct dentry *child, *dir = file->f_path.dentry;
 	struct inode *inode;
@@ -726,7 +726,7 @@ static bool proc_sys_fill_cache(struct file *file,
 static bool proc_sys_link_fill_cache(struct file *file,
 				    struct dir_context *ctx,
 				    struct ctl_table_header *head,
-				    struct ctl_table *table)
+				    const struct ctl_table *table)
 {
 	bool ret = true;
 
@@ -744,7 +744,7 @@ static bool proc_sys_link_fill_cache(struct file *file,
 	return ret;
 }
 
-static int scan(struct ctl_table_header *head, struct ctl_table *table,
+static int scan(struct ctl_table_header *head, const struct ctl_table *table,
 		unsigned long *pos, struct file *file,
 		struct dir_context *ctx)
 {
@@ -768,7 +768,7 @@ static int proc_sys_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct ctl_table_header *head = grab_header(file_inode(file));
 	struct ctl_table_header *h = NULL;
-	struct ctl_table *entry;
+	const struct ctl_table *entry;
 	struct ctl_dir *ctl_dir;
 	unsigned long pos;
 
@@ -801,7 +801,7 @@ static int proc_sys_permission(struct mnt_idmap *idmap,
 	 * are _NOT_ writeable, capabilities or not.
 	 */
 	struct ctl_table_header *head;
-	struct ctl_table *table;
+	const struct ctl_table *table;
 	int error;
 
 	/* Executable files are not allowed under /proc/sys/ */
@@ -845,7 +845,7 @@ static int proc_sys_getattr(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct ctl_table_header *head = grab_header(inode);
-	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
 
 	if (IS_ERR(head))
 		return PTR_ERR(head);
@@ -944,7 +944,7 @@ static struct ctl_dir *find_subdir(struct ctl_dir *dir,
 				   const char *name, int namelen)
 {
 	struct ctl_table_header *head;
-	struct ctl_table *entry;
+	const struct ctl_table *entry;
 
 	entry = find_entry(&head, dir, name, namelen);
 	if (!entry)
@@ -1055,12 +1055,12 @@ static struct ctl_dir *xlate_dir(struct ctl_table_set *set, struct ctl_dir *dir)
 }
 
 static int sysctl_follow_link(struct ctl_table_header **phead,
-	struct ctl_table **pentry)
+	const struct ctl_table **pentry)
 {
 	struct ctl_table_header *head;
+	const struct ctl_table *entry;
 	struct ctl_table_root *root;
 	struct ctl_table_set *set;
-	struct ctl_table *entry;
 	struct ctl_dir *dir;
 	int ret;
 
@@ -1087,7 +1087,7 @@ static int sysctl_follow_link(struct ctl_table_header **phead,
 	return ret;
 }
 
-static int sysctl_err(const char *path, struct ctl_table *table, char *fmt, ...)
+static int sysctl_err(const char *path, const struct ctl_table *table, char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -1103,7 +1103,7 @@ static int sysctl_err(const char *path, struct ctl_table *table, char *fmt, ...)
 	return -EINVAL;
 }
 
-static int sysctl_check_table_array(const char *path, struct ctl_table *table)
+static int sysctl_check_table_array(const char *path, const struct ctl_table *table)
 {
 	int err = 0;
 
@@ -1128,7 +1128,7 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 
 static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 {
-	struct ctl_table *entry;
+	const struct ctl_table *entry;
 	int err = 0;
 	list_for_each_table_entry(entry, header) {
 		if ((entry->proc_handler == proc_dostring) ||
@@ -1162,8 +1162,9 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 
 static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_header *head)
 {
-	struct ctl_table *link_table, *entry, *link;
+	struct ctl_table *link_table, *link;
 	struct ctl_table_header *links;
+	const struct ctl_table *entry;
 	struct ctl_node *node;
 	char *link_name;
 	int nr_entries, name_bytes;
@@ -1210,7 +1211,7 @@ static bool get_links(struct ctl_dir *dir,
 		      struct ctl_table_root *link_root)
 {
 	struct ctl_table_header *tmp_head;
-	struct ctl_table *entry, *link;
+	const struct ctl_table *entry, *link;
 
 	/* Are there links available for every entry in table? */
 	list_for_each_table_entry(entry, header) {
@@ -1463,7 +1464,7 @@ static void put_links(struct ctl_table_header *header)
 	struct ctl_table_root *root = header->root;
 	struct ctl_dir *parent = header->parent;
 	struct ctl_dir *core_parent;
-	struct ctl_table *entry;
+	const struct ctl_table *entry;
 
 	if (header->set == root_set)
 		return;
@@ -1474,7 +1475,7 @@ static void put_links(struct ctl_table_header *header)
 
 	list_for_each_table_entry(entry, header) {
 		struct ctl_table_header *link_head;
-		struct ctl_table *link;
+		const struct ctl_table *link;
 		const char *name = entry->procname;
 
 		link = find_entry(&link_head, core_parent, name, strlen(name));
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 061ea65104be..2f4d577f2e93 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -162,7 +162,7 @@ struct ctl_node {
 struct ctl_table_header {
 	union {
 		struct {
-			struct ctl_table *ctl_table;
+			const struct ctl_table *ctl_table;
 			int ctl_table_size;
 			int used;
 			int count;

-- 
2.43.0


