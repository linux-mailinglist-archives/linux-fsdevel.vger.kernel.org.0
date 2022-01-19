Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE0F493D97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 16:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350173AbiASPsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 10:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344115AbiASPsH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:48:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6321FC061574;
        Wed, 19 Jan 2022 07:48:07 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m11so13910893edi.13;
        Wed, 19 Jan 2022 07:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7frCPH4nqBlV5+ZOewVXS3CW/DJLkXkmtAmMhXBZKfQ=;
        b=YIEqOueRxC5CQLNnWQW44y99dnugZ/ot1r9QLBC6lf/UKhzHBigzZ+QTzU7UCRGkGP
         vUkgSYoxcFGwLh9c1+HK1gnWPsuXa20va206l+Ud4X3+nFsjae8WLh/8ZKnUEYA3neNI
         mqUm82jvIViSTXQ4vb5TJuKitNXhFcNeSCAK5ijbXsJZ05KokTNPOMNLmzONrWzKNJnH
         FitseHe/z5wx+S1L6wrCYkDkhepsGvmxLR8lR2Y24ez1YSsdif54ARymVeLThin+k32i
         m5xa5v47qckIy1PCq3Vt28b1hOw1pqR4LPlgjp5guZWHGImHOvgysLgs3TuikYxpgzeF
         SXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7frCPH4nqBlV5+ZOewVXS3CW/DJLkXkmtAmMhXBZKfQ=;
        b=nPU6e0HCMF86sG2qYbhYick1L0Q1vE/LzCz/RWdPmTfgaxFL5A3rE8Sj1QAytPeKZX
         Nk+jPiscg6Wj5+QiG6PxF0Fcig5X9Zbdh9TJODBrvaR2iscKiInfLw2tz+5Lphy5JH6f
         /AYHIry3HnfOon5R3wtoYixgU9Y4SLLY+5/+iE4+wQRZuaDN2+TMwrigPDYbpZKknXzC
         NO89RXYCzeve/BWHBkfjWWs/5nTAsnhudwQ4y0C0HJN48AxxRBo07wnuGe+RRmRD1+b4
         yjdrdVWY/2T0ikILwG2jBRxASrrMDwhLjdTIH14Fr6CkgX0nbP7s/7AjeJL4hIPFXmWb
         ElfA==
X-Gm-Message-State: AOAM533x23bZgH6c1EIowIzdNcRF8aGFWHNb3vjohRKxtp85uoaZ1MX5
        gHSf62yoCkYbLwfJR9+/qw==
X-Google-Smtp-Source: ABdhPJxhgGbA5hZeh0VMgaaOm7IJtVKz/cw+rKbVY9pSfoUL/yA+IC7FyoJ1k1FrOqTUEtmiOO/MUQ==
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr24393589ejw.70.1642607285951;
        Wed, 19 Jan 2022 07:48:05 -0800 (PST)
Received: from localhost.localdomain ([46.53.251.254])
        by smtp.gmail.com with ESMTPSA id p8sm14461ejm.140.2022.01.19.07.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:48:05 -0800 (PST)
Date:   Wed, 19 Jan 2022 18:48:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stephen.s.brennan@oracle.com, legion@kernel.org
Subject: [PATCH v2] proc: "mount -o lookup=" support
Message-ID: <YegysyqL3LvljK66@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From 61376c85daab50afb343ce50b5a97e562bc1c8d3 Mon Sep 17 00:00:00 2001
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Mon, 22 Nov 2021 20:41:06 +0300
Subject: [PATCH 1/1] proc: "mount -o lookup=..." support

Docker implements MaskedPaths configuration option

	https://github.com/estesp/docker/blob/9c15e82f19b0ad3c5fe8617a8ec2dddc6639f40a/oci/defaults.go#L97

to disable certain /proc files. It overmounts them with /dev/null.

Implement proper mount option which selectively disables lookup/readdir
in the top level /proc directory so that MaskedPaths doesn't need
to be updated as time goes on.

Syntax is

			Filter everything
	# mount -t proc -o lookup=/ proc /proc
	# ls /proc
	dr-xr-xr-x   8 root       root          0 Nov 22 21:12 995
	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 self -> 1163
	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 thread-self -> 1163/task/1163

			Allow /proc/cpuinfo and /proc/uptime
	# mount -t proc proc -o lookup=cpuinfo/uptime /proc

	# ls /proc
				...
	dr-xr-xr-x   8 root       root          0 Nov 22 21:12 995
	-r--r--r--   1 root       root          0 Nov 22 21:12 cpuinfo
	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 self -> 1163
	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 thread-self -> 1163/task/1163
	-r--r--r--   1 root       root          0 Nov 22 21:12 uptime

Trailing slash is optional but saves 1 allocation.
Trailing slash is mandatory for "filter everything".

Remounting with lookup= is disabled so that files and dcache entries
don't stay active while filter list is changed. Users are supposed
to unmount and mount again with different lookup= set.
Remount rules may change in the future. (Eric W. Biederman)

Re: speed
This is the price for filtering, given that lookup= is whitelist it is
not supposed to be very long. Second, it is one linear memory scan per
lookup, there are no linked lists. It may be faster than rbtree in fact.
It consumes 1 allocation per superblock which is list of names itself.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	v2
	documentation!
	descriptive comments!
	disable remount

 Documentation/filesystems/proc.rst |   8 ++
 fs/proc/generic.c                  |  18 ++--
 fs/proc/internal.h                 |  31 ++++++-
 fs/proc/proc_net.c                 |   2 +-
 fs/proc/root.c                     | 127 ++++++++++++++++++++++++++++-
 include/linux/proc_fs.h            |   2 +
 6 files changed, 178 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 8d7f141c6fc7..9a328f0b4346 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2186,6 +2186,7 @@ The following mount options are supported:
 	hidepid=	Set /proc/<pid>/ access mode.
 	gid=		Set the group authorized to learn processes information.
 	subset=		Show only the specified subset of procfs.
+        lookup=         Top-level /proc filter, independent of subset=
 	=========	========================================================
 
 hidepid=off or hidepid=0 means classic mode - everybody may access all
@@ -2218,6 +2219,13 @@ information about processes information, just add identd to this group.
 subset=pid hides all top level files and directories in the procfs that
 are not related to tasks.
 
+lookup= mount option makes available only listed files/directories in
+the top-level /proc directory. Individual names are separated
+by slash. Empty list is equivalent to subset=pid. lookup= filters before
+subset= if both options are supplied. lookup= doesn't affect /proc/${pid}
+directories availability as well as /proc/self and /proc/thread-self
+symlinks. More fine-grained filtering is not supported at the moment.
+
 Chapter 5: Filesystem behavior
 ==============================
 
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 5b78739e60e4..4d04f8d89cdc 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -282,7 +282,7 @@ struct dentry *proc_lookup(struct inode *dir, struct dentry *dentry,
  * for success..
  */
 int proc_readdir_de(struct file *file, struct dir_context *ctx,
-		    struct proc_dir_entry *de)
+		    struct proc_dir_entry *de, const struct proc_lookup_list *ll)
 {
 	int i;
 
@@ -307,12 +307,15 @@ int proc_readdir_de(struct file *file, struct dir_context *ctx,
 		struct proc_dir_entry *next;
 		pde_get(de);
 		read_unlock(&proc_subdir_lock);
-		if (!dir_emit(ctx, de->name, de->namelen,
-			    de->low_ino, de->mode >> 12)) {
-			pde_put(de);
-			return 0;
+
+		if (in_lookup_list(ll, de->name, de->namelen)) {
+			if (!dir_emit(ctx, de->name, de->namelen, de->low_ino, de->mode >> 12)) {
+				pde_put(de);
+				return 0;
+			}
+			ctx->pos++;
 		}
-		ctx->pos++;
+
 		read_lock(&proc_subdir_lock);
 		next = pde_subdir_next(de);
 		pde_put(de);
@@ -330,7 +333,8 @@ int proc_readdir(struct file *file, struct dir_context *ctx)
 	if (fs_info->pidonly == PROC_PIDONLY_ON)
 		return 1;
 
-	return proc_readdir_de(file, ctx, PDE(inode));
+	return proc_readdir_de(file, ctx, PDE(inode),
+				PDE(inode) == &proc_root ? fs_info->lookup_list : NULL);
 }
 
 /*
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 03415f3fb3a8..e74acb437c56 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -190,7 +190,7 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int);
 struct dentry *proc_lookup_de(struct inode *, struct dentry *, struct proc_dir_entry *);
 extern int proc_readdir(struct file *, struct dir_context *);
-int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *);
+int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *, const struct proc_lookup_list *);
 
 static inline void pde_get(struct proc_dir_entry *pde)
 {
@@ -318,3 +318,32 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
 	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
 	pde->proc_dops = &proc_net_dentry_ops;
 }
+
+/*
+ * Pascal strings stiched together making filtering memory access pattern linear.
+ *
+ * "mount -t proc -o lookup=/" results in
+ *
+ *	(u8[]){
+ *		0
+ *	}
+ *
+ * "mount -t proc -o lookup=cpuinfo/uptime/" results in
+ *
+ *	(u8[]){
+ *		7, 'c', 'p', 'u', 'i', 'n', 'f', 'o',
+ *		6, 'u', 'p', 't', 'i', 'm', 'e',
+ *		0
+ *	}
+ */
+struct proc_lookup_list {
+	u8 len;
+	char str[];
+};
+
+static inline struct proc_lookup_list *lookup_list_next(const struct proc_lookup_list *ll)
+{
+	return (struct proc_lookup_list *)((void *)ll + 1 + ll->len);
+}
+
+bool in_lookup_list(const struct proc_lookup_list *ll, const char *str, unsigned int len);
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 15c2e55d2ed2..7941df2d3d74 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -321,7 +321,7 @@ static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)
 	ret = -EINVAL;
 	net = get_proc_task_net(file_inode(file));
 	if (net != NULL) {
-		ret = proc_readdir_de(file, ctx, net->proc_net);
+		ret = proc_readdir_de(file, ctx, net->proc_net, NULL);
 		put_net(net);
 	}
 	return ret;
diff --git a/fs/proc/root.c b/fs/proc/root.c
index c7e3b1350ef8..8000558d7d2c 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -35,18 +35,22 @@ struct proc_fs_context {
 	enum proc_hidepid	hidepid;
 	int			gid;
 	enum proc_pidonly	pidonly;
+	struct proc_lookup_list	*lookup_list;
+	unsigned int		lookup_list_len;
 };
 
 enum proc_param {
 	Opt_gid,
 	Opt_hidepid,
 	Opt_subset,
+	Opt_lookup,
 };
 
 static const struct fs_parameter_spec proc_fs_parameters[] = {
 	fsparam_u32("gid",	Opt_gid),
 	fsparam_string("hidepid",	Opt_hidepid),
 	fsparam_string("subset",	Opt_subset),
+	fsparam_string("lookup",	Opt_lookup),
 	{}
 };
 
@@ -112,6 +116,65 @@ static int proc_parse_subset_param(struct fs_context *fc, char *value)
 	return 0;
 }
 
+static int proc_parse_lookup_param(struct fs_context *fc, char *str0)
+{
+	struct proc_fs_context *ctx = fc->fs_private;
+	struct proc_lookup_list *ll;
+	char *str;
+	const char *slash;
+	const char *src;
+	unsigned int len;
+	int rv;
+
+	/* Force trailing slash, simplify loops below. */
+	len = strlen(str0);
+	if (len > 0 && str0[len - 1] == '/') {
+		str = str0;
+	} else {
+		str = kmalloc(len + 2, GFP_KERNEL);
+		if (!str) {
+			rv = -ENOMEM;
+			goto out;
+		}
+		memcpy(str, str0, len);
+		str[len] = '/';
+		str[len + 1] = '\0';
+	}
+
+	len = 0;
+	for (src = str; (slash = strchr(src, '/')); src = slash + 1) {
+		if (slash - src >= 256) {
+			rv = -EINVAL;
+			goto out_free_str;
+		}
+		len += 1 + (slash - src);
+	}
+	len += 1;
+
+	ctx->lookup_list = ll = kmalloc(len, GFP_KERNEL);
+	ctx->lookup_list_len = len;
+	if (!ll) {
+		rv = -ENOMEM;
+		goto out_free_str;
+	}
+
+	for (src = str; (slash = strchr(src, '/')); src = slash + 1) {
+		ll->len = slash - src;
+		memcpy(ll->str, src, ll->len);
+		ll = lookup_list_next(ll);
+	}
+	ll->len = 0;
+
+	rv = 0;
+
+out_free_str:
+	if (str != str0) {
+		kfree(str);
+	}
+out:
+	return rv;
+}
+
 static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct proc_fs_context *ctx = fc->fs_private;
@@ -137,6 +200,11 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		break;
 
+	case Opt_lookup:
+		if (proc_parse_lookup_param(fc, param->string) < 0)
+			return -EINVAL;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -157,6 +225,10 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 		fs_info->hide_pid = ctx->hidepid;
 	if (ctx->mask & (1 << Opt_subset))
 		fs_info->pidonly = ctx->pidonly;
+	if (ctx->mask & (1 << Opt_lookup)) {
+		fs_info->lookup_list = ctx->lookup_list;
+		ctx->lookup_list = NULL;
+	}
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)
@@ -218,6 +290,14 @@ static int proc_reconfigure(struct fs_context *fc)
 	struct super_block *sb = fc->root->d_sb;
 	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
+	/*
+	 * "Hide everything" lookup filter is not a problem as only
+	 * /proc/${pid}, /proc/self and /proc/thread-self are accessible.
+	 */
+	if (fs_info->lookup_list && fs_info->lookup_list->len > 0) {
+		return invalfc(fc, "'-o remount,lookup=' is unsupported, unmount and mount instead");
+	}
+
 	sync_filesystem(sb);
 
 	proc_apply_options(fs_info, fc, current_user_ns());
@@ -234,11 +314,34 @@ static void proc_fs_context_free(struct fs_context *fc)
 	struct proc_fs_context *ctx = fc->fs_private;
 
 	put_pid_ns(ctx->pid_ns);
+	kfree(ctx->lookup_list);
 	kfree(ctx);
 }
 
+static int proc_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
+{
+	struct proc_fs_context *src = fc->fs_private;
+	struct proc_fs_context *dst;
+
+	dst = kmemdup(src, sizeof(struct proc_fs_context), GFP_KERNEL);
+	if (!dst) {
+		return -ENOMEM;
+	}
+
+	dst->lookup_list = kmemdup(dst->lookup_list, dst->lookup_list_len, GFP_KERNEL);
+	if (!dst->lookup_list) {
+		kfree(dst);
+		return -ENOMEM;
+	}
+	get_pid_ns(dst->pid_ns);
+
+	fc->fs_private = dst;
+	return 0;
+}
+
 static const struct fs_context_operations proc_fs_context_ops = {
 	.free		= proc_fs_context_free,
+	.dup		= proc_fs_context_dup,
 	.parse_param	= proc_parse_param,
 	.get_tree	= proc_get_tree,
 	.reconfigure	= proc_reconfigure,
@@ -274,6 +377,7 @@ static void proc_kill_sb(struct super_block *sb)
 
 	kill_anon_super(sb);
 	put_pid_ns(fs_info->pid_ns);
+	kfree(fs_info->lookup_list);
 	kfree(fs_info);
 }
 
@@ -317,12 +421,33 @@ static int proc_root_getattr(struct user_namespace *mnt_userns,
 	return 0;
 }
 
+bool in_lookup_list(const struct proc_lookup_list *ll, const char *str, unsigned int len)
+{
+	if (ll) {
+		for (; ll->len > 0; ll = lookup_list_next(ll)) {
+			if (ll->len == len && strncmp(ll->str, str, len) == 0) {
+				return true;
+			}
+		}
+		return false;
+	} else {
+		return true;
+	}
+}
+
 static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry, unsigned int flags)
 {
+	struct proc_fs_info *proc_sb = proc_sb_info(dir->i_sb);
+
 	if (!proc_pid_lookup(dentry, flags))
 		return NULL;
 
-	return proc_lookup(dir, dentry, flags);
+	if (in_lookup_list(proc_sb->lookup_list, dentry->d_name.name, dentry->d_name.len)) {
+		return proc_lookup(dir, dentry, flags);
+	} else {
+		return NULL;
+	}
+
 }
 
 static int proc_root_readdir(struct file *file, struct dir_context *ctx)
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 069c7fd95396..d2c067560bf9 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 
 struct proc_dir_entry;
+struct proc_lookup_list;
 struct seq_file;
 struct seq_operations;
 
@@ -65,6 +66,7 @@ struct proc_fs_info {
 	kgid_t pid_gid;
 	enum proc_hidepid hide_pid;
 	enum proc_pidonly pidonly;
+	const struct proc_lookup_list *lookup_list;
 };
 
 static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
-- 
2.31.1

