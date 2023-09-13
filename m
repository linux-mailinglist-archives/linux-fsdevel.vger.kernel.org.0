Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C22879ECAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbjIMPXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 11:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241281AbjIMPXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 299BDCE
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694618569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwiF8LaXPlCRmGbcn9XmRBqJ2AqY7t+fHbJYiHgVjoE=;
        b=G1PGCAaLd1+rrJD1Qs8Ky7T0NJM3goJKrCbRucIYz1DTtVMY6Uk+SuLEA1bCZa4XxwcSZm
        pffjYMXrNIUAWbuqFfBIPRZOcexJ0P3/NG1do3/BfYWMJyvlbxF+2Z8EKehPEFWEtI9Ua8
        jiKffMqOLPQDPFTjE9XyLamKIqNGbdk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-oEH141A6N6mV9yEShc_8uw-1; Wed, 13 Sep 2023 11:22:47 -0400
X-MC-Unique: oEH141A6N6mV9yEShc_8uw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bfb2c81664so13682591fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 08:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618565; x=1695223365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwiF8LaXPlCRmGbcn9XmRBqJ2AqY7t+fHbJYiHgVjoE=;
        b=n6ezWhv1ZO9YUw2twmnl/30sYwhKqEkxdXhl08nNEloUk8AqMFjRDV0GfavDhOdLT1
         nkFkLL6ZAyVI7dfY5rn/KOwVGtrh4TguwhaE3iPEYCH3sBXAnhRolwIRtANM2Qlma8v0
         tKzjhUEjhVbqYe3K7eFgwzQ/b06Umtu1p4DQvIa1+UEsE5gRZofxnda73ib2hi6udqGe
         rbz1w9FbSdzGLr+rYXi9c46bpLiky7uO5bXwF2ovpenDELFdUBqp00nJCbeildvKsDev
         gYzyvU36erjv1MpSMIuDhBzXujt7b7QKa2YZAP9nw+hwpO6MljKTE1pzobtqZck8RcEc
         N/2w==
X-Gm-Message-State: AOJu0YznQB4WFwQVv/o1tFkjlT8TaEe61lfupsjJIZ8TWM0bP0tmft/X
        AqHfolXXo/KzxIcRT1hPw0CwHK3X38UkgkuhXhJr0RlmbsPuTvWd/qdJcUx+qfBlYC6Lmbg517k
        +W6WFRy8JGgqdAXOPr0PzdS2o+vYA+OAieM0j2i8P/M1gOOG+uefFcISuBdfsu6K67gP8XAxn5G
        zTjHO+a5nfjw==
X-Received: by 2002:a2e:9f45:0:b0:2bc:f252:6cc4 with SMTP id v5-20020a2e9f45000000b002bcf2526cc4mr2519166ljk.10.1694618565452;
        Wed, 13 Sep 2023 08:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSXitU0Ad99x/6jyUTgIqe2kPq8Rv1RdX0UiXuNzIJotiGoOIjea/xC968OMTLy7Mkx/ifsw==
X-Received: by 2002:a2e:9f45:0:b0:2bc:f252:6cc4 with SMTP id v5-20020a2e9f45000000b002bcf2526cc4mr2519132ljk.10.1694618564839;
        Wed, 13 Sep 2023 08:22:44 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (79-120-253-96.pool.digikabel.hu. [79.120.253.96])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906a09200b0099b8234a9fesm8640663ejy.1.2023.09.13.08.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:22:43 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [RFC PATCH 2/3] add statmnt(2) syscall
Date:   Wed, 13 Sep 2023 17:22:35 +0200
Message-ID: <20230913152238.905247-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913152238.905247-1-mszeredi@redhat.com>
References: <20230913152238.905247-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a way to query attributes of a single mount instead of having to parse
the complete /proc/$PID/mountinfo, which might be huge.

Lookup the mount by the old (32bit) or new (64bit) mount ID.  If a mount
needs to be queried based on path, then statx(2) can be used to first query
the mount ID belonging to the path.

Design is based on a suggestion by Linus:

  "So I'd suggest something that is very much like "statfsat()", which gets
   a buffer and a length, and returns an extended "struct statfs" *AND*
   just a string description at the end."

The interface closely mimics that of statx.

Handle ASCII attributes by appending after the end of the structure (as per
above suggestion).  Allow querying multiple string attributes with
individual offset/length for each.  String are nul terminated (termination
isn't counted in length).

Mount options are also delimited with nul characters.  Unlike proc, special
characters are not quoted.

Link: https://lore.kernel.org/all/CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com/
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/internal.h                          |   5 +
 fs/namespace.c                         | 312 ++++++++++++++++++++++++-
 fs/proc_namespace.c                    |  19 +-
 fs/statfs.c                            |   1 +
 include/linux/syscalls.h               |   3 +
 include/uapi/asm-generic/unistd.h      |   5 +-
 include/uapi/linux/mount.h             |  36 +++
 8 files changed, 373 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 1d6eee30eceb..6d807c30cd16 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -375,6 +375,7 @@
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
+454	common	statmnt			sys_statmnt
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/fs/internal.h b/fs/internal.h
index d64ae03998cc..8f75271428aa 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -83,6 +83,11 @@ int path_mount(const char *dev_name, struct path *path,
 		const char *type_page, unsigned long flags, void *data_page);
 int path_umount(struct path *path, int flags);
 
+/*
+ * proc_namespace.c
+ */
+int show_path(struct seq_file *m, struct dentry *root);
+
 /*
  * fs_struct.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index de47c5f66e17..088a52043bba 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -69,7 +69,8 @@ static DEFINE_IDA(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);
 
 /* Don't allow confusion with mount ID allocated wit IDA */
-static atomic64_t mnt_id_ctr = ATOMIC64_INIT(1ULL << 32);
+#define OLD_MNT_ID_MAX UINT_MAX
+static atomic64_t mnt_id_ctr = ATOMIC64_INIT(OLD_MNT_ID_MAX);
 
 static struct hlist_head *mount_hashtable __read_mostly;
 static struct hlist_head *mountpoint_hashtable __read_mostly;
@@ -4678,6 +4679,315 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 	return err;
 }
 
+static bool mnt_id_match(struct mount *mnt, u64 id)
+{
+	if (id <= OLD_MNT_ID_MAX)
+		return id == mnt->mnt_id;
+	else
+		return id == mnt->mnt_id_unique;
+}
+
+struct vfsmount *lookup_mnt_in_ns(u64 id, struct mnt_namespace *ns)
+{
+	struct mount *mnt;
+	struct vfsmount *res = NULL;
+
+	lock_ns_list(ns);
+	list_for_each_entry(mnt, &ns->list, mnt_list) {
+		if (!mnt_is_cursor(mnt) && mnt_id_match(mnt, id)) {
+			res = &mnt->mnt;
+			break;
+		}
+	}
+	unlock_ns_list(ns);
+	return res;
+}
+
+struct stmt_state {
+	void __user *const buf;
+	size_t const bufsize;
+	struct vfsmount *const mnt;
+	u64 const mask;
+	struct seq_file seq;
+	struct path root;
+	struct statmnt sm;
+	size_t pos;
+	int err;
+};
+
+typedef int (*stmt_func_t)(struct stmt_state *);
+
+static int stmt_string_seq(struct stmt_state *s, stmt_func_t func)
+{
+	struct seq_file *seq = &s->seq;
+	int ret;
+
+	seq->count = 0;
+	seq->size = min_t(size_t, seq->size, s->bufsize - s->pos);
+	seq->buf = kvmalloc(seq->size, GFP_KERNEL_ACCOUNT);
+	if (!seq->buf)
+		return -ENOMEM;
+
+	ret = func(s);
+	if (ret)
+		return ret;
+
+	if (seq_has_overflowed(seq)) {
+		if (seq->size == s->bufsize - s->pos)
+			return -EOVERFLOW;
+		seq->size *= 2;
+		if (seq->size > MAX_RW_COUNT)
+			return -ENOMEM;
+		kvfree(seq->buf);
+		return 0;
+	}
+
+	/* Done */
+	return 1;
+}
+
+static void stmt_string(struct stmt_state *s, u64 mask, stmt_func_t func,
+		       stmt_str_t *str)
+{
+	int ret = s->pos >= s->bufsize ? -EOVERFLOW : 0;
+	struct statmnt *sm = &s->sm;
+	struct seq_file *seq = &s->seq;
+
+	if (s->err || !(s->mask & mask))
+		return;
+
+	seq->size = PAGE_SIZE;
+	while (!ret)
+		ret = stmt_string_seq(s, func);
+
+	if (ret < 0) {
+		s->err = ret;
+	} else {
+		seq->buf[seq->count++] = '\0';
+		if (copy_to_user(s->buf + s->pos, seq->buf, seq->count)) {
+			s->err = -EFAULT;
+		} else {
+			str->off = s->pos;
+			str->len = seq->count - 1;
+			s->pos += seq->count;
+		}
+	}
+	kvfree(seq->buf);
+	sm->mask |= mask;
+}
+
+static void stmt_numeric(struct stmt_state *s, u64 mask, stmt_func_t func)
+{
+	if (s->err || !(s->mask & mask))
+		return;
+
+	s->err = func(s);
+	s->sm.mask |= mask;
+}
+
+static u64 mnt_to_attr_flags(struct vfsmount *mnt)
+{
+	unsigned int mnt_flags = READ_ONCE(mnt->mnt_flags);
+	u64 attr_flags = 0;
+
+	if (mnt_flags & MNT_READONLY)
+		attr_flags |= MOUNT_ATTR_RDONLY;
+	if (mnt_flags & MNT_NOSUID)
+		attr_flags |= MOUNT_ATTR_NOSUID;
+	if (mnt_flags & MNT_NODEV)
+		attr_flags |= MOUNT_ATTR_NODEV;
+	if (mnt_flags & MNT_NOEXEC)
+		attr_flags |= MOUNT_ATTR_NOEXEC;
+	if (mnt_flags & MNT_NODIRATIME)
+		attr_flags |= MOUNT_ATTR_NODIRATIME;
+	if (mnt_flags & MNT_NOSYMFOLLOW)
+		attr_flags |= MOUNT_ATTR_NOSYMFOLLOW;
+
+	if (mnt_flags & MNT_NOATIME)
+		attr_flags |= MOUNT_ATTR_NOATIME;
+	else if (mnt_flags & MNT_RELATIME)
+		attr_flags |= MOUNT_ATTR_RELATIME;
+	else
+		attr_flags |= MOUNT_ATTR_STRICTATIME;
+
+	if (is_idmapped_mnt(mnt))
+		attr_flags |= MOUNT_ATTR_IDMAP;
+
+	return attr_flags;
+}
+
+static u64 mnt_to_propagation_flags(struct mount *m)
+{
+	u64 propagation = 0;
+
+	if (IS_MNT_SHARED(m))
+		propagation |= MS_SHARED;
+	if (IS_MNT_SLAVE(m))
+		propagation |= MS_SLAVE;
+	if (IS_MNT_UNBINDABLE(m))
+		propagation |= MS_UNBINDABLE;
+	if (!propagation)
+		propagation |= MS_PRIVATE;
+
+	return propagation;
+}
+
+static int stmt_sb_basic(struct stmt_state *s)
+{
+	struct super_block *sb = s->mnt->mnt_sb;
+
+	s->sm.sb_dev_major = MAJOR(sb->s_dev);
+	s->sm.sb_dev_minor = MINOR(sb->s_dev);
+	s->sm.sb_magic = sb->s_magic;
+	s->sm.sb_flags = sb->s_flags & (SB_RDONLY|SB_SYNCHRONOUS|SB_DIRSYNC|SB_LAZYTIME);
+
+	return 0;
+}
+
+static int stmt_mnt_basic(struct stmt_state *s)
+{
+	struct mount *m = real_mount(s->mnt);
+
+	s->sm.mnt_id = m->mnt_id_unique;
+	s->sm.mnt_parent_id = m->mnt_parent->mnt_id_unique;
+	s->sm.mnt_id_old = m->mnt_id;
+	s->sm.mnt_parent_id_old = m->mnt_parent->mnt_id;
+	s->sm.mnt_attr = mnt_to_attr_flags(&m->mnt);
+	s->sm.mnt_propagation = mnt_to_propagation_flags(m);
+	s->sm.mnt_peer_group = IS_MNT_SHARED(m) ? m->mnt_group_id : 0;
+	s->sm.mnt_master = IS_MNT_SLAVE(m) ? m->mnt_master->mnt_group_id : 0;
+
+	return 0;
+}
+
+static int stmt_propagate_from(struct stmt_state *s)
+{
+	struct mount *m = real_mount(s->mnt);
+
+	if (!IS_MNT_SLAVE(m))
+		return 0;
+
+	s->sm.propagate_from = get_dominating_id(m, &current->fs->root);
+
+	return 0;
+}
+
+static int stmt_mnt_root(struct stmt_state *s)
+{
+	struct seq_file *seq = &s->seq;
+	int err = show_path(seq, s->mnt->mnt_root);
+
+	if (!err && !seq_has_overflowed(seq)) {
+		seq->buf[seq->count] = '\0';
+		seq->count = string_unescape_inplace(seq->buf, UNESCAPE_OCTAL);
+	}
+	return err;
+}
+
+static int stmt_mountpoint(struct stmt_state *s)
+{
+	struct vfsmount *mnt = s->mnt;
+	struct path mnt_path = { .dentry = mnt->mnt_root, .mnt = mnt };
+	int err = seq_path_root(&s->seq, &mnt_path, &s->root, "");
+
+	return err == SEQ_SKIP ? 0 : err;
+}
+
+static int stmt_fs_type(struct stmt_state *s)
+{
+	struct seq_file *seq = &s->seq;
+	struct super_block *sb = s->mnt->mnt_sb;
+
+	seq_puts(seq, sb->s_type->name);
+	if (sb->s_subtype) {
+		seq_putc(seq, '.');
+		seq_puts(seq, sb->s_subtype);
+	}
+	return 0;
+}
+
+static int stmt_sb_opts(struct stmt_state *s)
+{
+	struct seq_file *seq = &s->seq;
+	struct super_block *sb = s->mnt->mnt_sb;
+	char *p, *end, *next, *u = seq->buf;
+	int err;
+
+	if (!sb->s_op->show_options)
+		return 0;
+
+	err = sb->s_op->show_options(seq, s->mnt->mnt_root);
+	if (err || seq_has_overflowed(seq) || !seq->count)
+		return err;
+
+	end = seq->buf + seq->count;
+	*end = '\0';
+	for (p = seq->buf + 1; p < end; p = next + 1) {
+		next = strchrnul(p, ',');
+		*next = '\0';
+		u += string_unescape(p, u, 0, UNESCAPE_OCTAL) + 1;
+	}
+	seq->count = u - 1 - seq->buf;
+	return 0;
+}
+
+static int do_statmnt(struct stmt_state *s)
+{
+	struct statmnt *sm = &s->sm;
+	struct mount *m = real_mount(s->mnt);
+
+	if (!capable(CAP_SYS_ADMIN) &&
+	    !is_path_reachable(m, m->mnt.mnt_root, &s->root))
+		return -EPERM;
+
+	stmt_numeric(s, STMT_SB_BASIC, stmt_sb_basic);
+	stmt_numeric(s, STMT_MNT_BASIC, stmt_mnt_basic);
+	stmt_numeric(s, STMT_PROPAGATE_FROM, stmt_propagate_from);
+	stmt_string(s, STMT_MNT_ROOT, stmt_mnt_root, &sm->mnt_root);
+	stmt_string(s, STMT_MOUNTPOINT, stmt_mountpoint, &sm->mountpoint);
+	stmt_string(s, STMT_FS_TYPE, stmt_fs_type, &sm->fs_type);
+	stmt_string(s, STMT_SB_OPTS, stmt_sb_opts, &sm->sb_opts);
+
+	if (s->err)
+		return s->err;
+
+	if (copy_to_user(s->buf, sm, min_t(size_t, s->bufsize, sizeof(*sm))))
+		return -EFAULT;
+
+	return 0;
+}
+
+SYSCALL_DEFINE5(statmnt, u64, mnt_id,
+		u64, mask, struct statmnt __user *, buf,
+		size_t, bufsize, unsigned int, flags)
+{
+	struct vfsmount *mnt;
+	int err;
+
+	if (flags)
+		return -EINVAL;
+
+	down_read(&namespace_sem);
+	mnt = lookup_mnt_in_ns(mnt_id, current->nsproxy->mnt_ns);
+	err = -ENOENT;
+	if (mnt) {
+		struct stmt_state s = {
+			.mask = mask,
+			.buf = buf,
+			.bufsize = bufsize,
+			.mnt = mnt,
+			.pos = sizeof(*buf),
+		};
+
+		get_fs_root(current->fs, &s.root);
+		err = do_statmnt(&s);
+		path_put(&s.root);
+	}
+	up_read(&namespace_sem);
+
+	return err;
+}
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 250eb5bf7b52..20681d1f6798 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -132,6 +132,15 @@ static int show_vfsmnt(struct seq_file *m, struct vfsmount *mnt)
 	return err;
 }
 
+int show_path(struct seq_file *m, struct dentry *root)
+{
+	if (root->d_sb->s_op->show_path)
+		return root->d_sb->s_op->show_path(m, root);
+
+	seq_dentry(m, root, " \t\n\\");
+	return 0;
+}
+
 static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
 {
 	struct proc_mounts *p = m->private;
@@ -142,13 +151,9 @@ static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
 
 	seq_printf(m, "%i %i %u:%u ", r->mnt_id, r->mnt_parent->mnt_id,
 		   MAJOR(sb->s_dev), MINOR(sb->s_dev));
-	if (sb->s_op->show_path) {
-		err = sb->s_op->show_path(m, mnt->mnt_root);
-		if (err)
-			goto out;
-	} else {
-		seq_dentry(m, mnt->mnt_root, " \t\n\\");
-	}
+	err = show_path(m, mnt->mnt_root);
+	if (err)
+		goto out;
 	seq_putc(m, ' ');
 
 	/* mountpoints outside of chroot jail will give SEQ_SKIP on this */
diff --git a/fs/statfs.c b/fs/statfs.c
index 96d1c3edf289..cc774c2e2c9a 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -9,6 +9,7 @@
 #include <linux/security.h>
 #include <linux/uaccess.h>
 #include <linux/compat.h>
+#include <uapi/linux/mount.h>
 #include "internal.h"
 
 static int flags_by_mnt(int mnt_flags)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 22bc6bc147f8..1099bd307fa7 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -408,6 +408,9 @@ asmlinkage long sys_statfs64(const char __user *path, size_t sz,
 asmlinkage long sys_fstatfs(unsigned int fd, struct statfs __user *buf);
 asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
 				struct statfs64 __user *buf);
+asmlinkage long sys_statmnt(u64 mnt_id, u64 mask,
+			    struct statmnt __user *buf, size_t bufsize,
+			    unsigned int flags);
 asmlinkage long sys_truncate(const char __user *path, long length);
 asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
 #if BITS_PER_LONG == 32
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index abe087c53b4b..640997231ff6 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -823,8 +823,11 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 
+#define __NR_statmnt   454
+__SYSCALL(__NR_statmnt, sys_statmnt)
+
 #undef __NR_syscalls
-#define __NR_syscalls 453
+#define __NR_syscalls 455
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index bb242fdcfe6b..4ec7308a9259 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -138,4 +138,40 @@ struct mount_attr {
 /* List of all mount_attr versions. */
 #define MOUNT_ATTR_SIZE_VER0	32 /* sizeof first published struct */
 
+struct stmt_str {
+	__u32 off;
+	__u32 len;
+};
+
+struct statmnt {
+	__u64 mask;		/* What results were written [uncond] */
+	__u32 sb_dev_major;	/* Device ID */
+	__u32 sb_dev_minor;
+	__u64 sb_magic;		/* ..._SUPER_MAGIC */
+	__u32 sb_flags;		/* MS_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
+	__u32 __spare1;
+	__u64 mnt_id;		/* Unique ID of mount */
+	__u64 mnt_parent_id;	/* Unique ID of parent (for root == mnt_id) */
+	__u32 mnt_id_old;	/* Reused IDs used in proc/.../mountinfo */
+	__u32 mnt_parent_id_old;
+	__u64 mnt_attr;		/* MOUNT_ATTR_... */
+	__u64 mnt_propagation;	/* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
+	__u64 mnt_peer_group;	/* ID of shared peer group */
+	__u64 mnt_master;	/* Mount receives propagation from this ID */
+	__u64 propagate_from;	/* Propagation from in current namespace */
+	__u64 __spare[20];
+	struct stmt_str mnt_root;	/* Root of mount relative to root of fs */
+	struct stmt_str mountpoint;	/* Mountpoint relative to root of process */
+	struct stmt_str fs_type;	/* Filesystem type[.subtype] */
+	struct stmt_str sb_opts;	/* Super block string options (nul delimted) */
+};
+
+#define STMT_SB_BASIC		0x00000001U     /* Want/got sb_... */
+#define STMT_MNT_BASIC		0x00000002U	/* Want/got mnt_... */
+#define STMT_PROPAGATE_FROM	0x00000004U	/* Want/got propagate_from */
+#define STMT_MNT_ROOT		0x00000008U	/* Want/got mnt_root  */
+#define STMT_MOUNTPOINT		0x00000010U	/* Want/got mountpoint */
+#define STMT_FS_TYPE		0x00000020U	/* Want/got fs_type */
+#define STMT_SB_OPTS		0x00000040U	/* Want/got sb_opts */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.41.0

