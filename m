Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9578467B612
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 16:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbjAYPiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 10:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjAYPiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:38:09 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3258E521EB
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 07:38:07 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-s0K0uYCeMX6KY8aP2rrCxQ-1; Wed, 25 Jan 2023 10:29:36 -0500
X-MC-Unique: s0K0uYCeMX6KY8aP2rrCxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A695811E6E;
        Wed, 25 Jan 2023 15:29:35 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (ovpn-208-16.brq.redhat.com [10.40.208.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C796A2026D4B;
        Wed, 25 Jan 2023 15:29:33 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Val Cowan <vcowan@redhat.com>
Subject: [RFC PATCH v1 5/6] proc: Validate incoming allowlist
Date:   Wed, 25 Jan 2023 16:28:52 +0100
Message-Id: <18bb5a8c0c81211cba5b865b4fbb5c2dd6b9e688.1674660533.git.legion@kernel.org>
In-Reply-To: <cover.1674660533.git.legion@kernel.org>
References: <cover.1674660533.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/proc/internal.h       |  10 +++
 fs/proc/proc_allowlist.c | 165 ++++++++++++++++++++++++++++++---------
 fs/proc/root.c           |  22 +-----
 include/linux/proc_fs.h  |   7 +-
 4 files changed, 149 insertions(+), 55 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 3e1b1f29b13d..2ca4e53a4b4b 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -334,8 +334,18 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
  * proc_allowlist.c
  */
 #ifdef CONFIG_PROC_ALLOW_LIST
+extern int proc_allowlist_append(struct list_head *, const char *, size_t);
+extern void proc_allowlist_free(struct list_head *);
 extern bool proc_pde_access_allowed(struct proc_fs_info *, struct proc_dir_entry *);
 #else
+static inline int proc_allowlist_append(struct list_head *, const char *, size_t)
+{
+	return 0;
+}
+static inline void proc_allowlist_free(struct list_head *)
+{
+	return;
+}
 static inline bool proc_pde_access_allowed(struct proc_fs_info *fs_info, struct proc_dir_entry *pde)
 {
 	return true;
diff --git a/fs/proc/proc_allowlist.c b/fs/proc/proc_allowlist.c
index c605f73622bd..0115015c74f0 100644
--- a/fs/proc/proc_allowlist.c
+++ b/fs/proc/proc_allowlist.c
@@ -11,16 +11,56 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/rwlock.h>
+#include <linux/list_sort.h>
 #include "internal.h"
 
 #define FILE_SEQFILE(f) ((struct seq_file *)((f)->private_data))
 #define FILE_DATA(f) (FILE_SEQFILE(f)->private)
 
+int proc_allowlist_append(struct list_head *allowlist, const char *path, size_t len)
+{
+	struct allowlist_entry *new;
+
+	if (!len)
+		return 0;
+
+	new = kmalloc(sizeof(*new), GFP_KERNEL_ACCOUNT);
+	if (!new)
+		goto nomem;
+
+	new->path = kstrndup(path, len, GFP_KERNEL_ACCOUNT);
+	if (!new->path)
+		goto nomem;
+
+	INIT_LIST_HEAD(&new->list);
+	list_add_tail(&new->list, allowlist);
+
+	return 0;
+nomem:
+	if (new) {
+		kfree(new->path);
+		kfree(new);
+	}
+	return -ENOMEM;
+}
+
+void proc_allowlist_free(struct list_head *allowlist)
+{
+	struct list_head *el, *next;
+	struct allowlist_entry *entry;
+
+	list_for_each_safe(el, next, allowlist) {
+		entry = list_entry(el, struct allowlist_entry, list);
+		kfree(entry->path);
+		kfree(entry);
+	}
+}
+
 bool proc_pde_access_allowed(struct proc_fs_info *fs_info, struct proc_dir_entry *de)
 {
 	bool ret = false;
-	char *ptr;
 	unsigned long flags;
+	struct list_head *el, *next;
 
 	if (!(fs_info->subset & PROC_SUBSET_ALLOWLIST)) {
 		if (!pde_is_allowlist(de))
@@ -31,24 +71,13 @@ bool proc_pde_access_allowed(struct proc_fs_info *fs_info, struct proc_dir_entry
 
 	read_lock_irqsave(&fs_info->allowlist_lock, flags);
 
-	ptr = fs_info->allowlist;
-
-	while (ptr && *ptr != '\0') {
-		struct proc_dir_entry *pde;
-		char *sep, *end;
-		size_t len, pathlen;
+	list_for_each_safe(el, next, &fs_info->allowlist) {
+		struct allowlist_entry *entry = list_entry(el, struct allowlist_entry, list);
 
-		if (!(sep = strchr(ptr, '\n')))
-			pathlen = strlen(ptr);
-		else
-			pathlen = (sep - ptr);
-
-		if (!pathlen)
-			goto next;
-
-		pde = de;
-		end = NULL;
-		len = pathlen;
+		struct proc_dir_entry *pde = de;
+		char  *end = NULL;
+		char  *ptr = entry->path;
+		size_t len = strlen(entry->path);
 
 		while (ptr != end && len > 0) {
 			end = ptr + len - 1;
@@ -72,8 +101,7 @@ bool proc_pde_access_allowed(struct proc_fs_info *fs_info, struct proc_dir_entry
 
 		ret = true;
 		break;
-next:
-		ptr += pathlen + 1;
+next:		;
 	}
 
 	read_unlock_irqrestore(&fs_info->allowlist_lock, flags);
@@ -84,12 +112,18 @@ bool proc_pde_access_allowed(struct proc_fs_info *fs_info, struct proc_dir_entry
 static int show_allowlist(struct seq_file *m, void *v)
 {
 	struct proc_fs_info *fs_info = proc_sb_info(m->file->f_inode->i_sb);
-	char *p = fs_info->allowlist;
 	unsigned long flags;
+	struct list_head *el, *next;
+	struct allowlist_entry *entry;
 
 	read_lock_irqsave(&fs_info->allowlist_lock, flags);
-	if (p)
-		seq_puts(m, p);
+
+	list_for_each_safe(el, next, &fs_info->allowlist) {
+		entry = list_entry(el, struct allowlist_entry, list);
+		seq_puts(m, entry->path);
+		seq_puts(m, "\n");
+	}
+
 	read_unlock_irqrestore(&fs_info->allowlist_lock, flags);
 
 	return 0;
@@ -155,34 +189,93 @@ static ssize_t write_allowlist(struct file *file, const char __user *buffer, siz
 	return count;
 }
 
+static int allowlist_cmp(void *priv, const struct list_head *a, const struct list_head *b)
+{
+	struct allowlist_entry *ia = list_entry(a, struct allowlist_entry, list);
+	struct allowlist_entry *ib = list_entry(b, struct allowlist_entry, list);
+
+	return strcmp(ia->path, ib->path);
+}
+
+static int recreate_allowlist(struct proc_fs_info *fs_info, const char *buf, size_t buflen)
+{
+	const char *ptr = buf;
+	size_t len = buflen;
+	size_t lineno = 1;
+	int ret = 0;
+	LIST_HEAD(allowlist);
+
+	while (len > 0) {
+		char *sep;
+		size_t pathlen;
+
+		if (!(sep = memchr(ptr, '\n', len)))
+			pathlen = buflen;
+		else
+			pathlen = (sep - ptr);
+
+		if (pathlen > 0) {
+			ret = -ENAMETOOLONG;
+			if (pathlen >= PATH_MAX) {
+				pr_crit("allowlist:%lu: pathname is too long\n", lineno);
+				goto err;
+			}
+
+			ret = -EINVAL;
+			if (*ptr == '/') {
+				pr_crit("allowlist:%lu: the name must be relative to the mount point\n", lineno);
+				goto err;
+			}
+			if (!isalpha(*ptr)) {
+				pr_crit("allowlist:%lu: name must start with a letter\n", lineno);
+				goto err;
+			}
+
+			proc_allowlist_append(&allowlist, ptr, pathlen);
+		}
+
+		ptr += pathlen + 1;
+		len -= pathlen + 1;
+
+		lineno++;
+	}
+
+	proc_allowlist_free(&fs_info->allowlist);
+	INIT_LIST_HEAD(&fs_info->allowlist);
+
+	if (!list_empty(&allowlist)) {
+		list_replace(&allowlist, &fs_info->allowlist);
+		list_sort(NULL, &fs_info->allowlist, allowlist_cmp);
+	}
+
+	return 0;
+err:
+	proc_allowlist_free(&allowlist);
+	return ret;
+}
+
 static int close_allowlist(struct inode *inode, struct file *file)
 {
 	struct seq_file *seq_file = FILE_SEQFILE(file);
 	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 
 	if (seq_file->buf && (file->f_mode & FMODE_WRITE)) {
+		unsigned long flags;
 		char *buf;
 
 		if (!seq_get_buf(seq_file, &buf))
 			return -EIO;
 		*buf = '\0';
 
-		if (strcmp(seq_file->buf, fs_info->allowlist)) {
-			unsigned long flags;
-
-			buf = kstrndup(seq_file->buf, seq_file->count, GFP_KERNEL_ACCOUNT);
-			if (!buf)
-				return -EIO;
-
-			write_lock_irqsave(&fs_info->allowlist_lock, flags);
-
-			shrink_dcache_sb(inode->i_sb);
-
-			kfree(fs_info->allowlist);
-			fs_info->allowlist = buf;
+		write_lock_irqsave(&fs_info->allowlist_lock, flags);
 
+		if (recreate_allowlist(fs_info, seq_file->buf, seq_file->count) < 0) {
 			write_unlock_irqrestore(&fs_info->allowlist_lock, flags);
+			return -EIO;
 		}
+
+		shrink_dcache_sb(inode->i_sb);
+		write_unlock_irqrestore(&fs_info->allowlist_lock, flags);
 	}
 
 	return single_release(inode, file);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 6e9b125072e5..18436d70bb12 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -147,18 +147,6 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
-static char *proc_init_allowlist(void)
-{
-	char *content = kstrdup("allowlist\n", GFP_KERNEL_ACCOUNT);
-
-	if (!content) {
-		pr_err("proc_init_allowlist: allocation allowlist failed\n");
-		return NULL;
-	}
-
-	return content;
-}
-
 static void proc_apply_options(struct proc_fs_info *fs_info,
 			       struct fs_context *fc,
 			       struct user_namespace *user_ns)
@@ -171,11 +159,8 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 		fs_info->hide_pid = ctx->hidepid;
 	if (ctx->mask & (1 << Opt_subset)) {
 		fs_info->subset = ctx->subset;
-		if (ctx->subset & PROC_SUBSET_ALLOWLIST) {
-			fs_info->allowlist = proc_init_allowlist();
-		} else {
-			fs_info->allowlist = NULL;
-		}
+		if (ctx->subset & PROC_SUBSET_ALLOWLIST)
+			proc_allowlist_append(&fs_info->allowlist, "allowlist", 10);
 	}
 }
 
@@ -191,6 +176,7 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 		return -ENOMEM;
 
 	rwlock_init(&fs_info->allowlist_lock);
+	INIT_LIST_HEAD(&fs_info->allowlist);
 
 	fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
 	proc_apply_options(fs_info, fc, current_user_ns());
@@ -296,7 +282,7 @@ static void proc_kill_sb(struct super_block *sb)
 
 	kill_anon_super(sb);
 	put_pid_ns(fs_info->pid_ns);
-	kfree(fs_info->allowlist);
+	proc_allowlist_free(&fs_info->allowlist);
 	kfree(fs_info);
 }
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 08d0d0ae6e42..81c6b4b2ae97 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -59,6 +59,11 @@ enum proc_subset {
 	PROC_SUBSET_ALLOWLIST	= (1 << 2),
 };
 
+struct allowlist_entry {
+	struct list_head list;
+	char *path;
+};
+
 struct proc_fs_info {
 	struct pid_namespace *pid_ns;
 	struct dentry *proc_self;        /* For /proc/self */
@@ -66,8 +71,8 @@ struct proc_fs_info {
 	kgid_t pid_gid;
 	enum proc_hidepid hide_pid;
 	unsigned int subset;
-	char *allowlist;
 	rwlock_t allowlist_lock;
+	struct list_head allowlist;
 };
 
 static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
-- 
2.33.6

