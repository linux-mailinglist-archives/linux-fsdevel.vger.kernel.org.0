Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E57B45957E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 20:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbhKVT0r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 14:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhKVT0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 14:26:46 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C7AC061574;
        Mon, 22 Nov 2021 11:23:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so81812710edd.3;
        Mon, 22 Nov 2021 11:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Kj/6fY0CyBIrnzweBfbfkn9p9O+tR2P8eBMSn39xNqA=;
        b=UnYwEqJDf/Ofpp+pNzhvOI9/5MYNZRQCC98I7Hw4fm4nPvWcnG44g0VTlCZ3Tjp6C/
         JmvDbvaXXy2+mKfYl4IAFpeTWFZaVdTGUuElPNVwFsGuejxt5shyRyiIa3Gks0pBpaa9
         9M57FsAuMj7EFSJf3qQFQmRY5UOMm3Jdf7vhdCjzR5FPFJWXOwPXLCd4V6eQNiCYZrV4
         XMvCo502qoA9M/RViRDjZp5XUq4Eyrg/HNTubNyzGimNb1d99pCscvCJRfJP4k9SqJyt
         wZgdeMdCIsuaeQ5DsV5r7Dajfi6ElbsUN7MDWp8X3KJFgaFj9Pl1rN/zbFbu2y7DVf4v
         22lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Kj/6fY0CyBIrnzweBfbfkn9p9O+tR2P8eBMSn39xNqA=;
        b=l3dgclgNewirSM/rjxus69tTLxK9Vd8N5GSEJmx5NpS82TeIT6/6knuMoz0FDiiGX1
         nH8W/tSTKZes753wJtyzkVjZ59Yj6RR/kyvOj3WlpPXhtFO3T6k+8rTzWthsiS0SaBar
         OZk3ftuygZ+YxxlRFENeMyOJkpVLEp3d4HKIl55c13Uq/twjuCo8YymB3khQrpjKTg7L
         2CW20aJA+E8E2nvFpA1hrM5UcvCd5f274M2XJuzgnowU0zqQg8xEvHfzdVmD8o7s4pB/
         +daUEvuGy2Ss6IIZMx3fw7m707WiBGFgbPs+yI5TKw73x0WW6KNh164GI09ly/AU+zWJ
         z5ZA==
X-Gm-Message-State: AOAM531zOgXNqIi98I4Zgew2B44iN8WTWRh7fBE/k3Y61SGW8iRwJdHK
        zX2qcwL8MJSWUCqYds2uBA==
X-Google-Smtp-Source: ABdhPJwINrWfS7dj2wG4I2x/1Ur9LlVqco1L3gdI7l4+I2HtB3LftXUDxp5cEXV4hKJlDyQCOcShTw==
X-Received: by 2002:a50:c31c:: with SMTP id a28mr67919677edb.4.1637609017535;
        Mon, 22 Nov 2021 11:23:37 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.234])
        by smtp.gmail.com with ESMTPSA id t20sm4471756edv.81.2021.11.22.11.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:23:37 -0800 (PST)
Date:   Mon, 22 Nov 2021 22:23:35 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     viro@zeniv.linux.org.uk, ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: "mount -o lookup=..." support
Message-ID: <YZvuN0Wqmn7XB4dX@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Docker implements MaskedPaths configuration option

	https://github.com/estesp/docker/blob/9c15e82f19b0ad3c5fe8617a8ec2dddc6639f40a/oci/defaults.go#L97

to disable certain /proc files. It does overmount with /dev/null per
masked file.

Give them proper mount option which selectively disables lookup/readdir
so that MaskedPaths doesn't need to be updated as time goes on.

Syntax is

	mount -t proc proc -o lookup=cpuinfo/uptime /proc

	# ls /proc
				...
	dr-xr-xr-x   8 root       root          0 Nov 22 21:12 995
	-r--r--r--   1 root       root          0 Nov 22 21:12 cpuinfo
	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 self -> 1163
	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 thread-self -> 1163/task/1163
	-r--r--r--   1 root       root          0 Nov 22 21:12 uptime

Works at top level only (1 lookup list per superblock)
Trailing slash is optional but saves 1 allocation.

TODO:
	think what to do with dcache entries across "mount -o remount,lookup=".

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c       |   19 +++++--
 fs/proc/internal.h      |   23 +++++++++
 fs/proc/proc_net.c      |    2 
 fs/proc/root.c          |  115 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/proc_fs.h |    2 
 5 files changed, 152 insertions(+), 9 deletions(-)

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
 
@@ -305,14 +305,18 @@ int proc_readdir_de(struct file *file, struct dir_context *ctx,
 
 	do {
 		struct proc_dir_entry *next;
+
 		pde_get(de);
 		read_unlock(&proc_subdir_lock);
-		if (!dir_emit(ctx, de->name, de->namelen,
-			    de->low_ino, de->mode >> 12)) {
-			pde_put(de);
-			return 0;
+
+		if (ll ? in_lookup_list(ll, de->name, de->namelen) : true) {
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
@@ -330,7 +334,8 @@ int proc_readdir(struct file *file, struct dir_context *ctx)
 	if (fs_info->pidonly == PROC_PIDONLY_ON)
 		return 1;
 
-	return proc_readdir_de(file, ctx, PDE(inode));
+	return proc_readdir_de(file, ctx, PDE(inode),
+				PDE(inode) == &proc_root ? fs_info->lookup_list : NULL);
 }
 
 /*
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
@@ -318,3 +318,24 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
 	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
 	pde->proc_dops = &proc_net_dentry_ops;
 }
+
+/*
+ * "cpuinfo", "uptime" is represented as
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
@@ -234,11 +306,34 @@ static void proc_fs_context_free(struct fs_context *fc)
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
+	get_pid_ns(dst->pid_ns);
+	dst->lookup_list = kmemdup(dst->lookup_list, dst->lookup_list_len, GFP_KERNEL);
+	if (!dst->lookup_list) {
+		kfree(dst);
+		return -ENOMEM;
+	}
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
@@ -274,6 +369,7 @@ static void proc_kill_sb(struct super_block *sb)
 
 	kill_anon_super(sb);
 	put_pid_ns(fs_info->pid_ns);
+	kfree(fs_info->lookup_list);
 	kfree(fs_info);
 }
 
@@ -317,11 +413,30 @@ static int proc_root_getattr(struct user_namespace *mnt_userns,
 	return 0;
 }
 
+bool in_lookup_list(const struct proc_lookup_list *ll, const char *str, unsigned int len)
+{
+	while (ll->len > 0) {
+		if (ll->len == len && strncmp(ll->str, str, len) == 0) {
+			return true;
+		}
+		ll = lookup_list_next(ll);
+	}
+	return false;
+}
+
 static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry, unsigned int flags)
 {
+	struct proc_fs_info *proc_sb = proc_sb_info(dir->i_sb);
+
 	if (!proc_pid_lookup(dentry, flags))
 		return NULL;
 
+	/* Top level only for now */
+	if (proc_sb->lookup_list &&
+	    !in_lookup_list(proc_sb->lookup_list, dentry->d_name.name, dentry->d_name.len)) {
+		    return NULL;
+	}
+
 	return proc_lookup(dir, dentry, flags);
 }
 
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
