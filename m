Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714CE67B5F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 16:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbjAYPbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 10:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjAYPbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:31:06 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE3B59747
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 07:31:01 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-08M_FhysPKuYZMQaiPJFQg-1; Wed, 25 Jan 2023 10:29:31 -0500
X-MC-Unique: 08M_FhysPKuYZMQaiPJFQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69DC72804832;
        Wed, 25 Jan 2023 15:29:31 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (ovpn-208-16.brq.redhat.com [10.40.208.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A4D72026D76;
        Wed, 25 Jan 2023 15:29:29 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Val Cowan <vcowan@redhat.com>
Subject: [RFC PATCH v1 3/6] proc: Check that subset= option has been set
Date:   Wed, 25 Jan 2023 16:28:50 +0100
Message-Id: <346dd92ea62d8469416e12ab71b67b775eb2494b.1674660533.git.legion@kernel.org>
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

Refactor subset option. Before this option had only one value - pid. Now
another meaning has appeared and therefore their combinations are
possible.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/proc/generic.c        |  4 ++--
 fs/proc/inode.c          | 16 +++++++++++++---
 fs/proc/internal.h       |  6 ------
 fs/proc/proc_allowlist.c | 22 ++++------------------
 fs/proc/root.c           | 27 +++++++++++++++++++--------
 include/linux/proc_fs.h  | 15 +++++----------
 6 files changed, 43 insertions(+), 47 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index d4c8589987e7..71a38b275814 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -269,7 +269,7 @@ struct dentry *proc_lookup(struct inode *dir, struct dentry *dentry,
 {
 	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
 
-	if (fs_info->pidonly == PROC_PIDONLY_ON && !proc_has_allowlist(fs_info))
+	if ((fs_info->subset & PROC_SUBSET_PIDONLY) && !(fs_info->subset & PROC_SUBSET_ALLOWLIST))
 		return ERR_PTR(-ENOENT);
 
 	return proc_lookup_de(dir, dentry, PDE(dir));
@@ -334,7 +334,7 @@ int proc_readdir(struct file *file, struct dir_context *ctx)
 	struct inode *inode = file_inode(file);
 	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 
-	if (fs_info->pidonly == PROC_PIDONLY_ON && !proc_has_allowlist(fs_info))
+	if ((fs_info->subset & PROC_SUBSET_PIDONLY) && !(fs_info->subset & PROC_SUBSET_ALLOWLIST))
 		return 1;
 
 	return proc_readdir_de(file, ctx, PDE(inode));
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index f495fdb39151..4c486237a16b 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -184,9 +184,19 @@ static int proc_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",gid=%u", from_kgid_munged(&init_user_ns, fs_info->pid_gid));
 	if (fs_info->hide_pid != HIDEPID_OFF)
 		seq_printf(seq, ",hidepid=%s", hidepid2str(fs_info->hide_pid));
-	if (fs_info->pidonly != PROC_PIDONLY_OFF)
-		seq_printf(seq, ",subset=pid");
-
+	if (fs_info->subset & PROC_SUBSET_SET) {
+		bool need_delim = false;
+		seq_printf(seq, ",subset=");
+		if (fs_info->subset & PROC_SUBSET_PIDONLY) {
+			seq_printf(seq, "pid");
+			need_delim = true;
+		}
+		if (fs_info->subset & PROC_SUBSET_ALLOWLIST) {
+			if (need_delim)
+				seq_printf(seq, "+");
+			seq_printf(seq, "allowlist");
+		}
+	}
 	return 0;
 }
 
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 999d105f6f96..3e1b1f29b13d 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -334,14 +334,8 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
  * proc_allowlist.c
  */
 #ifdef CONFIG_PROC_ALLOW_LIST
-extern bool proc_has_allowlist(struct proc_fs_info *);
 extern bool proc_pde_access_allowed(struct proc_fs_info *, struct proc_dir_entry *);
 #else
-static inline bool proc_has_allowlist(struct proc_fs_info *fs_info)
-{
-	return false;
-}
-
 static inline bool proc_pde_access_allowed(struct proc_fs_info *fs_info, struct proc_dir_entry *pde)
 {
 	return true;
diff --git a/fs/proc/proc_allowlist.c b/fs/proc/proc_allowlist.c
index b38e11b04199..2153acb8e467 100644
--- a/fs/proc/proc_allowlist.c
+++ b/fs/proc/proc_allowlist.c
@@ -16,38 +16,24 @@
 #define FILE_SEQFILE(f) ((struct seq_file *)((f)->private_data))
 #define FILE_DATA(f) (FILE_SEQFILE(f)->private)
 
-bool proc_has_allowlist(struct proc_fs_info *fs_info)
-{
-	bool ret;
-	unsigned long flags;
-
-	read_lock_irqsave(&fs_info->allowlist_lock, flags);
-	ret = (fs_info->allowlist == NULL);
-	read_unlock_irqrestore(&fs_info->allowlist_lock, flags);
-
-	return ret;
-}
-
 bool proc_pde_access_allowed(struct proc_fs_info *fs_info, struct proc_dir_entry *de)
 {
 	bool ret = false;
 	char *ptr;
 	unsigned long flags;
 
-	read_lock_irqsave(&fs_info->allowlist_lock, flags);
-
-	if (!fs_info->allowlist) {
-		read_unlock_irqrestore(&fs_info->allowlist_lock, flags);
-
+	if (!(fs_info->subset & PROC_SUBSET_ALLOWLIST)) {
 		if (!pde_is_allowlist(de))
 			ret = true;
 
 		return ret;
 	}
 
+	read_lock_irqsave(&fs_info->allowlist_lock, flags);
+
 	ptr = fs_info->allowlist;
 
-	while (*ptr != '\0') {
+	while (ptr && *ptr != '\0') {
 		struct proc_dir_entry *pde;
 		char *sep, *end;
 		size_t len, pathlen;
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 1564f5cd118d..6e9b125072e5 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -31,8 +31,7 @@ struct proc_fs_context {
 	unsigned int		mask;
 	enum proc_hidepid	hidepid;
 	int			gid;
-	enum proc_pidonly	pidonly;
-	enum proc_allowlist	allowlist;
+	unsigned int		subset;
 };
 
 enum proc_param {
@@ -91,6 +90,8 @@ static int proc_parse_subset_param(struct fs_context *fc, char *value)
 {
 	struct proc_fs_context *ctx = fc->fs_private;
 
+	ctx->subset |= PROC_SUBSET_SET;
+
 	while (value) {
 		char *ptr = strchr(value, '+');
 
@@ -99,10 +100,10 @@ static int proc_parse_subset_param(struct fs_context *fc, char *value)
 
 		if (*value != '\0') {
 			if (!strcmp(value, "pid")) {
-				ctx->pidonly = PROC_PIDONLY_ON;
+				ctx->subset |= PROC_SUBSET_PIDONLY;
 			} else if (IS_ENABLED(CONFIG_PROC_ALLOW_LIST) &&
 				   !strcmp(value, "allowlist")) {
-				ctx->allowlist = PROC_ALLOWLIST_ON;
+				ctx->subset |= PROC_SUBSET_ALLOWLIST;
 			} else {
 				return invalf(fc, "proc: unsupported subset option - %s\n", value);
 			}
@@ -169,8 +170,8 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 	if (ctx->mask & (1 << Opt_hidepid))
 		fs_info->hide_pid = ctx->hidepid;
 	if (ctx->mask & (1 << Opt_subset)) {
-		fs_info->pidonly = ctx->pidonly;
-		if (ctx->allowlist == PROC_ALLOWLIST_ON) {
+		fs_info->subset = ctx->subset;
+		if (ctx->subset & PROC_SUBSET_ALLOWLIST) {
 			fs_info->allowlist = proc_init_allowlist();
 		} else {
 			fs_info->allowlist = NULL;
@@ -346,14 +347,21 @@ static int proc_root_getattr(struct user_namespace *mnt_userns,
 
 static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry, unsigned int flags)
 {
-	if (!proc_pid_lookup(dentry, flags))
-		return NULL;
+	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
+
+	if (!(fs_info->subset & PROC_SUBSET_SET) || (fs_info->subset & PROC_SUBSET_PIDONLY)) {
+		if (!proc_pid_lookup(dentry, flags))
+			return NULL;
+	}
 
 	return proc_lookup(dir, dentry, flags);
 }
 
 static int proc_root_readdir(struct file *file, struct dir_context *ctx)
 {
+	struct inode *inode = file_inode(file);
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
+
 	if (ctx->pos < FIRST_PROCESS_ENTRY) {
 		int error = proc_readdir(file, ctx);
 		if (unlikely(error <= 0))
@@ -361,6 +369,9 @@ static int proc_root_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos = FIRST_PROCESS_ENTRY;
 	}
 
+	if ((fs_info->subset & PROC_SUBSET_SET) && !(fs_info->subset & PROC_SUBSET_PIDONLY))
+		return 1;
+
 	return proc_pid_readdir(file, ctx);
 }
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 9105d75aeb18..08d0d0ae6e42 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -53,15 +53,10 @@ enum proc_hidepid {
 	HIDEPID_NOT_PTRACEABLE = 4, /* Limit pids to only ptraceable pids */
 };
 
-/* definitions for proc mount option pidonly */
-enum proc_pidonly {
-	PROC_PIDONLY_OFF = 0,
-	PROC_PIDONLY_ON  = 1,
-};
-
-enum proc_allowlist {
-	PROC_ALLOWLIST_OFF = 0,
-	PROC_ALLOWLIST_ON  = 1,
+enum proc_subset {
+	PROC_SUBSET_SET		= (1 << 0),
+	PROC_SUBSET_PIDONLY	= (1 << 1),
+	PROC_SUBSET_ALLOWLIST	= (1 << 2),
 };
 
 struct proc_fs_info {
@@ -70,7 +65,7 @@ struct proc_fs_info {
 	struct dentry *proc_thread_self; /* For /proc/thread-self */
 	kgid_t pid_gid;
 	enum proc_hidepid hide_pid;
-	enum proc_pidonly pidonly;
+	unsigned int subset;
 	char *allowlist;
 	rwlock_t allowlist_lock;
 };
-- 
2.33.6

