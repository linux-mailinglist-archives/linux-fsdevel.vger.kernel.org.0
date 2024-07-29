Return-Path: <linux-fsdevel+bounces-24512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C9B93FFB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 22:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F11282DA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 20:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE4418C347;
	Mon, 29 Jul 2024 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HfHSfjsf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE5189F20;
	Mon, 29 Jul 2024 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285830; cv=none; b=jpzfYs82O8a5nGAv+f7iU9B2JfdGyJ7NLQkFZidOep0IEalZncxt3IC7MPUSLI09NVtaZiP5MuwLzDL8QGiWWumx6Mpl1Z0K6INvnprE9BlsoXUWxM2/2YFhEmzOKA9yNTVFKNKCtIPk0/KUsa06tXV33hoKx3yPI4LZLJElTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285830; c=relaxed/simple;
	bh=QBMFBfHQ0hS4XM/axBbjz4zqGkS9cNCQXu14+iU6vAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ToJVwK12THCVnnmP6S38cl3/cpxQYwIIR+gVgHIsmXG0BdH1R/kzwqpGGoT3w/YSQEzks2Xko7m0U/n+XiPNShREkKYD2i4xhG+wsUS1XkSOrhJULZ1X/n3pTOCHmRB7Fse3F+9MkNr/gyfXruCL7rNeRxYcosF8SzM1WyW87nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HfHSfjsf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722285818;
	bh=QBMFBfHQ0hS4XM/axBbjz4zqGkS9cNCQXu14+iU6vAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HfHSfjsfSJ5wBaDRlBDCzJSjPMBUrEQ1Pie0bNmpgETRV3ffuIgWcyTk+H58BTDli
	 3EcGpmDV+XWRZPDqlUvbTsRnb9ndhnKvBYcz8tiR40plWvfIISNe1r6yEOv5vcpXaz
	 7kOdFOAght1CjIv2DpIaEo6qKJk4T7m+ESwP/YeI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 29 Jul 2024 22:43:31 +0200
Subject: [PATCH 2/5] sysctl: move internal interfaces to const struct
 ctl_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240729-sysctl-const-api-v1-2-ca628c7a942c@weissschuh.net>
References: <20240729-sysctl-const-api-v1-0-ca628c7a942c@weissschuh.net>
In-Reply-To: <20240729-sysctl-const-api-v1-0-ca628c7a942c@weissschuh.net>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722285818; l=13731;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QBMFBfHQ0hS4XM/axBbjz4zqGkS9cNCQXu14+iU6vAc=;
 b=ccf8CH6WUxmPeg+phZkpqq4ufYqGDmu8TAea+RQFE10vJbdlQyrDogZKu7v2l2R2TDkjWT0GH
 /gbfX8Amw/wAsvRe7Gbq+93zZgd3xA7ote4I97unpYHBJf5AMxy+a6G
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

As a preparation to make all the core sysctl code work with const struct
ctl_table switch over the internal function to use the const variant.

Some pointers to "struct ctl_table" need to stay non-const as they are
newly allocated and modified before registration.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/internal.h     |  2 +-
 fs/proc/proc_sysctl.c  | 81 +++++++++++++++++++++++++-------------------------
 include/linux/sysctl.h |  2 +-
 3 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index a8a8576d8592..fcab5dd7ddb1 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -102,7 +102,7 @@ struct proc_inode {
 	union proc_op op;
 	struct proc_dir_entry *pde;
 	struct ctl_table_header *sysctl;
-	struct ctl_table *sysctl_entry;
+	const struct ctl_table *sysctl_entry;
 	struct hlist_node sibling_inodes;
 	const struct proc_ns_operations *ns_ops;
 	struct inode vfs_inode;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 9553e77c9d31..fa8cf9bf2988 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -83,7 +83,7 @@ static DEFINE_SPINLOCK(sysctl_lock);
 
 static void drop_sysctl_table(struct ctl_table_header *header);
 static int sysctl_follow_link(struct ctl_table_header **phead,
-	struct ctl_table **pentry);
+	const struct ctl_table **pentry);
 static int insert_links(struct ctl_table_header *head);
 static void put_links(struct ctl_table_header *header);
 
@@ -105,11 +105,11 @@ static int namecmp(const char *name1, int len1, const char *name2, int len2)
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
@@ -136,7 +136,7 @@ static struct ctl_table *find_entry(struct ctl_table_header **phead,
 	return NULL;
 }
 
-static int insert_entry(struct ctl_table_header *head, struct ctl_table *entry)
+static int insert_entry(struct ctl_table_header *head, const struct ctl_table *entry)
 {
 	struct rb_node *node = &head->node[entry - head->ctl_table].node;
 	struct rb_node **p = &head->parent->root.rb_node;
@@ -146,7 +146,7 @@ static int insert_entry(struct ctl_table_header *head, struct ctl_table *entry)
 
 	while (*p) {
 		struct ctl_table_header *parent_head;
-		struct ctl_table *parent_entry;
+		const struct ctl_table *parent_entry;
 		struct ctl_node *parent_node;
 		const char *parent_name;
 		int cmp;
@@ -175,7 +175,7 @@ static int insert_entry(struct ctl_table_header *head, struct ctl_table *entry)
 	return 0;
 }
 
-static void erase_entry(struct ctl_table_header *head, struct ctl_table *entry)
+static void erase_entry(struct ctl_table_header *head, const struct ctl_table *entry)
 {
 	struct rb_node *node = &head->node[entry - head->ctl_table].node;
 
@@ -184,7 +184,7 @@ static void erase_entry(struct ctl_table_header *head, struct ctl_table *entry)
 
 static void init_header(struct ctl_table_header *head,
 	struct ctl_table_root *root, struct ctl_table_set *set,
-	struct ctl_node *node, struct ctl_table *table, size_t table_size)
+	struct ctl_node *node, const struct ctl_table *table, size_t table_size)
 {
 	head->ctl_table = table;
 	head->ctl_table_size = table_size;
@@ -199,7 +199,7 @@ static void init_header(struct ctl_table_header *head,
 	head->node = node;
 	INIT_HLIST_HEAD(&head->inodes);
 	if (node) {
-		struct ctl_table *entry;
+		const struct ctl_table *entry;
 
 		list_for_each_table_entry(entry, head) {
 			node->header = head;
@@ -212,7 +212,7 @@ static void init_header(struct ctl_table_header *head,
 
 static void erase_header(struct ctl_table_header *head)
 {
-	struct ctl_table *entry;
+	const struct ctl_table *entry;
 
 	list_for_each_table_entry(entry, head)
 		erase_entry(head, entry);
@@ -220,7 +220,7 @@ static void erase_header(struct ctl_table_header *head)
 
 static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 {
-	struct ctl_table *entry;
+	const struct ctl_table *entry;
 	struct ctl_table_header *dir_h = &dir->header;
 	int err;
 
@@ -339,12 +339,12 @@ lookup_header_set(struct ctl_table_root *root)
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
@@ -369,10 +369,10 @@ static struct ctl_node *first_usable_entry(struct rb_node *node)
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
@@ -386,10 +386,10 @@ static void first_entry(struct ctl_dir *dir,
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
@@ -422,7 +422,7 @@ static int test_perm(int mode, int op)
 	return -EACCES;
 }
 
-static int sysctl_perm(struct ctl_table_header *head, struct ctl_table *table, int op)
+static int sysctl_perm(struct ctl_table_header *head, const struct ctl_table *table, int op)
 {
 	struct ctl_table_root *root = head->root;
 	int mode;
@@ -436,7 +436,7 @@ static int sysctl_perm(struct ctl_table_header *head, struct ctl_table *table, i
 }
 
 static struct inode *proc_sys_make_inode(struct super_block *sb,
-		struct ctl_table_header *head, struct ctl_table *table)
+		struct ctl_table_header *head, const struct ctl_table *table)
 {
 	struct ctl_table_root *root = head->root;
 	struct inode *inode;
@@ -507,7 +507,7 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 	struct ctl_table_header *head = grab_header(dir);
 	struct ctl_table_header *h = NULL;
 	const struct qstr *name = &dentry->d_name;
-	struct ctl_table *p;
+	const struct ctl_table *p;
 	struct inode *inode;
 	struct dentry *err = ERR_PTR(-ENOENT);
 	struct ctl_dir *ctl_dir;
@@ -545,7 +545,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct ctl_table_header *head = grab_header(inode);
-	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
 	size_t count = iov_iter_count(iter);
 	char *kbuf;
 	ssize_t error;
@@ -619,7 +619,7 @@ static ssize_t proc_sys_write(struct kiocb *iocb, struct iov_iter *iter)
 static int proc_sys_open(struct inode *inode, struct file *filp)
 {
 	struct ctl_table_header *head = grab_header(inode);
-	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
 
 	/* sysctl was unregistered */
 	if (IS_ERR(head))
@@ -637,7 +637,7 @@ static __poll_t proc_sys_poll(struct file *filp, poll_table *wait)
 {
 	struct inode *inode = file_inode(filp);
 	struct ctl_table_header *head = grab_header(inode);
-	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
 	__poll_t ret = DEFAULT_POLLMASK;
 	unsigned long event;
 
@@ -668,7 +668,7 @@ static __poll_t proc_sys_poll(struct file *filp, poll_table *wait)
 static bool proc_sys_fill_cache(struct file *file,
 				struct dir_context *ctx,
 				struct ctl_table_header *head,
-				struct ctl_table *table)
+				const struct ctl_table *table)
 {
 	struct dentry *child, *dir = file->f_path.dentry;
 	struct inode *inode;
@@ -712,7 +712,7 @@ static bool proc_sys_fill_cache(struct file *file,
 static bool proc_sys_link_fill_cache(struct file *file,
 				    struct dir_context *ctx,
 				    struct ctl_table_header *head,
-				    struct ctl_table *table)
+				    const struct ctl_table *table)
 {
 	bool ret = true;
 
@@ -730,7 +730,7 @@ static bool proc_sys_link_fill_cache(struct file *file,
 	return ret;
 }
 
-static int scan(struct ctl_table_header *head, struct ctl_table *table,
+static int scan(struct ctl_table_header *head, const struct ctl_table *table,
 		unsigned long *pos, struct file *file,
 		struct dir_context *ctx)
 {
@@ -754,7 +754,7 @@ static int proc_sys_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct ctl_table_header *head = grab_header(file_inode(file));
 	struct ctl_table_header *h = NULL;
-	struct ctl_table *entry;
+	const struct ctl_table *entry;
 	struct ctl_dir *ctl_dir;
 	unsigned long pos;
 
@@ -787,7 +787,7 @@ static int proc_sys_permission(struct mnt_idmap *idmap,
 	 * are _NOT_ writeable, capabilities or not.
 	 */
 	struct ctl_table_header *head;
-	struct ctl_table *table;
+	const struct ctl_table *table;
 	int error;
 
 	/* Executable files are not allowed under /proc/sys/ */
@@ -831,7 +831,7 @@ static int proc_sys_getattr(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct ctl_table_header *head = grab_header(inode);
-	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
 
 	if (IS_ERR(head))
 		return PTR_ERR(head);
@@ -930,7 +930,7 @@ static struct ctl_dir *find_subdir(struct ctl_dir *dir,
 				   const char *name, int namelen)
 {
 	struct ctl_table_header *head;
-	struct ctl_table *entry;
+	const struct ctl_table *entry;
 
 	entry = find_entry(&head, dir, name, namelen);
 	if (!entry)
@@ -1041,12 +1041,12 @@ static struct ctl_dir *xlate_dir(struct ctl_table_set *set, struct ctl_dir *dir)
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
 
@@ -1073,7 +1073,7 @@ static int sysctl_follow_link(struct ctl_table_header **phead,
 	return ret;
 }
 
-static int sysctl_err(const char *path, struct ctl_table *table, char *fmt, ...)
+static int sysctl_err(const char *path, const struct ctl_table *table, char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -1089,7 +1089,7 @@ static int sysctl_err(const char *path, struct ctl_table *table, char *fmt, ...)
 	return -EINVAL;
 }
 
-static int sysctl_check_table_array(const char *path, struct ctl_table *table)
+static int sysctl_check_table_array(const char *path, const struct ctl_table *table)
 {
 	unsigned int extra;
 	int err = 0;
@@ -1128,7 +1128,7 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 
 static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 {
-	struct ctl_table *entry;
+	const struct ctl_table *entry;
 	int err = 0;
 	list_for_each_table_entry(entry, header) {
 		if (!entry->procname)
@@ -1164,8 +1164,9 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 
 static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_header *head)
 {
-	struct ctl_table *link_table, *entry, *link;
+	struct ctl_table *link_table, *link;
 	struct ctl_table_header *links;
+	const struct ctl_table *entry;
 	struct ctl_node *node;
 	char *link_name;
 	int name_bytes;
@@ -1210,7 +1211,7 @@ static bool get_links(struct ctl_dir *dir,
 		      struct ctl_table_root *link_root)
 {
 	struct ctl_table_header *tmp_head;
-	struct ctl_table *entry, *link;
+	const struct ctl_table *entry, *link;
 
 	if (header->ctl_table_size == 0 ||
 	    sysctl_is_perm_empty_ctl_header(header))
@@ -1461,7 +1462,7 @@ static void put_links(struct ctl_table_header *header)
 	struct ctl_table_root *root = header->root;
 	struct ctl_dir *parent = header->parent;
 	struct ctl_dir *core_parent;
-	struct ctl_table *entry;
+	const struct ctl_table *entry;
 
 	if (header->set == root_set)
 		return;
@@ -1472,7 +1473,7 @@ static void put_links(struct ctl_table_header *header)
 
 	list_for_each_table_entry(entry, header) {
 		struct ctl_table_header *link_head;
-		struct ctl_table *link;
+		const struct ctl_table *link;
 		const char *name = entry->procname;
 
 		link = find_entry(&link_head, core_parent, name, strlen(name));
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index aa4c6d44aaa0..a473deaf5a91 100644
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
2.45.2


