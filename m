Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10BA2199F6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 21:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgCaTrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 15:47:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54650 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728617AbgCaTre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585684051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zke1bQfhGjm9SVfCRt3+6gXZ2knsTK8YPQ5Emgti0ys=;
        b=TCYnHwI0KQAxv4m7d0MVsIsAOOvbHv5bNLNpFCi7XWyipPlH77ukq3+vt4qwt3Mqrm+rIB
        xABddP42dXFzyRUJvttt+GXm7MbL718DYM8xxvZDDvmI9Nz9HRZniYX9/nubHfQxeLXFMn
        MLKZJESIykBkh9YKw2m+qOtOVFQNhd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-qCSsFZlzNHy2gSahbic7sA-1; Tue, 31 Mar 2020 15:47:29 -0400
X-MC-Unique: qCSsFZlzNHy2gSahbic7sA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 207EA8017DF;
        Tue, 31 Mar 2020 19:47:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6257960BE1;
        Tue, 31 Mar 2020 19:47:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegtn1A=dL9VZJQ2GRWsOiP+YSs-4ezE9YgEYNmb-AF0OLA@mail.gmail.com>
References: <CAJfpegtn1A=dL9VZJQ2GRWsOiP+YSs-4ezE9YgEYNmb-AF0OLA@mail.gmail.com> <1445647.1585576702@warthog.procyon.org.uk> <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com> <2294742.1585675875@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 31 Mar 2020 20:47:22 +0100
Message-ID: <2303960.1585684042@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> Cool, thanks for testing.  Unfortunately the test-fsinfo-perf.c file
> didn't make it into the patch.   Can you please refresh and resend?

Oops - I forgot to add it.  See attached.

David
---
commit b7239021cb7660bf328bb7fcce05e3a35ce5842b
Author: David Howells <dhowells@redhat.com>
Date:   Tue Mar 31 14:39:07 2020 +0100

    Performance test Mikl=C3=B3s's patch vs fsinfo

diff --git a/fs/Makefile b/fs/Makefile
index b6bf2424c7f7..ac0627176db1 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -137,3 +137,4 @@ obj-$(CONFIG_EFIVAR_FS)		+=3D efivarfs/
 obj-$(CONFIG_EROFS_FS)		+=3D erofs/
 obj-$(CONFIG_VBOXSF_FS)		+=3D vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+=3D zonefs/
+obj-y				+=3D mountfs/
diff --git a/fs/mount.h b/fs/mount.h
index 063f41bc2e93..89b091fc482f 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -82,6 +82,7 @@ struct mount {
 	atomic_t mnt_subtree_notifications;	/* Number of notifications in subtree=
 */
 	struct watch_list *mnt_watchers; /* Watches on dentries within this mount=
 */
 #endif
+	struct mountfs_entry *mnt_mountfs_entry;
 } __randomize_layout;
=20
 #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespac=
e */
@@ -177,3 +178,11 @@ static inline void notify_mount(struct mount *triggere=
d,
 {
 }
 #endif
+
+void mnt_namespace_lock_read(void);
+void mnt_namespace_unlock_read(void);
+
+void mountfs_create(struct mount *mnt);
+extern void mountfs_remove(struct mount *mnt);
+int mountfs_lookup_internal(struct vfsmount *m, struct path *path);
+
diff --git a/fs/mountfs/Makefile b/fs/mountfs/Makefile
new file mode 100644
index 000000000000..35a65e9a966f
--- /dev/null
+++ b/fs/mountfs/Makefile
@@ -0,0 +1 @@
+obj-y				+=3D super.o
diff --git a/fs/mountfs/super.c b/fs/mountfs/super.c
new file mode 100644
index 000000000000..82c01eb6154d
--- /dev/null
+++ b/fs/mountfs/super.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "../pnode.h"
+#include <linux/fs.h>
+#include <linux/kref.h>
+#include <linux/nsproxy.h>
+#include <linux/fs_struct.h>
+#include <linux/fs_context.h>
+
+#define MOUNTFS_SUPER_MAGIC 0x4e756f4d
+
+static DEFINE_SPINLOCK(mountfs_lock);
+static struct rb_root mountfs_entries =3D RB_ROOT;
+static struct vfsmount *mountfs_mnt __read_mostly;
+
+struct mountfs_entry {
+	struct kref kref;
+	struct mount *mnt;
+	struct rb_node node;
+	int id;
+};
+
+static const char *mountfs_attrs[] =3D {
+	"root", "mountpoint", "id", "parent", "options", "children",
+	"group", "master", "propagate_from"
+};
+
+#define MOUNTFS_INO(id) (((unsigned long) id + 1) * \
+			 (ARRAY_SIZE(mountfs_attrs) + 1))
+
+void mountfs_entry_release(struct kref *kref)
+{
+	kfree(container_of(kref, struct mountfs_entry, kref));
+}
+
+void mountfs_entry_put(struct mountfs_entry *entry)
+{
+	kref_put(&entry->kref, mountfs_entry_release);
+}
+
+static bool mountfs_entry_visible(struct mountfs_entry *entry)
+{
+	struct mount *mnt;
+	bool visible =3D false;
+
+	rcu_read_lock();
+	mnt =3D rcu_dereference(entry->mnt);
+	if (mnt && mnt->mnt_ns =3D=3D current->nsproxy->mnt_ns)
+		visible =3D true;
+	rcu_read_unlock();
+
+	return visible;
+}
+static int mountfs_attr_show(struct seq_file *sf, void *v)
+{
+	const char *name =3D sf->file->f_path.dentry->d_name.name;
+	struct mountfs_entry *entry =3D sf->private;
+	struct mount *mnt;
+	struct vfsmount *m;
+	struct super_block *sb;
+	struct path root;
+	int tmp, err =3D -ENODEV;
+
+	mnt_namespace_lock_read();
+
+	mnt =3D entry->mnt;
+	if (!mnt || !mnt->mnt_ns)
+		goto out;
+
+	err =3D 0;
+	m =3D &mnt->mnt;
+	sb =3D m->mnt_sb;
+
+	if (strcmp(name, "root") =3D=3D 0) {
+		if (sb->s_op->show_path) {
+			err =3D sb->s_op->show_path(sf, m->mnt_root);
+		} else {
+			seq_dentry(sf, m->mnt_root, " \t\n\\");
+		}
+		seq_putc(sf, '\n');
+	} else if (strcmp(name, "mountpoint") =3D=3D 0) {
+		struct path mnt_path =3D { .dentry =3D m->mnt_root, .mnt =3D m };
+
+		get_fs_root(current->fs, &root);
+		err =3D seq_path_root(sf, &mnt_path, &root, " \t\n\\");
+		if (err =3D=3D SEQ_SKIP) {
+			seq_puts(sf, "(unreachable)");
+			err =3D 0;
+		}
+		seq_putc(sf, '\n');
+		path_put(&root);
+	} else if (strcmp(name, "id") =3D=3D 0) {
+		seq_printf(sf, "%i\n", mnt->mnt_id);
+	} else if (strcmp(name, "parent") =3D=3D 0) {
+		tmp =3D rcu_dereference(mnt->mnt_parent)->mnt_id;
+		seq_printf(sf, "%i\n", tmp);
+	} else if (strcmp(name, "options") =3D=3D 0) {
+		int mnt_flags =3D READ_ONCE(m->mnt_flags);
+
+		seq_puts(sf, mnt_flags & MNT_READONLY ? "ro" : "rw");
+		seq_mnt_opts(sf, mnt_flags);
+		seq_putc(sf, '\n');
+	} else if (strcmp(name, "children") =3D=3D 0) {
+		struct mount *child;
+		bool first =3D true;
+
+		list_for_each_entry(child, &mnt->mnt_mounts, mnt_child) {
+			if (!first)
+				seq_putc(sf, ',');
+			else
+				first =3D false;
+			seq_printf(sf, "%i", child->mnt_id);
+		}
+		if (!first)
+			seq_putc(sf, '\n');
+	} else if (strcmp(name, "group") =3D=3D 0) {
+		if (IS_MNT_SHARED(mnt))
+			seq_printf(sf, "%i\n", mnt->mnt_group_id);
+	} else if (strcmp(name, "master") =3D=3D 0) {
+		if (IS_MNT_SLAVE(mnt)) {
+			tmp =3D rcu_dereference(mnt->mnt_master)->mnt_group_id;
+			seq_printf(sf, "%i\n", tmp);
+		}
+	} else if (strcmp(name, "propagate_from") =3D=3D 0) {
+		if (IS_MNT_SLAVE(mnt)) {
+			get_fs_root(current->fs, &root);
+			tmp =3D get_dominating_id(mnt, &root);
+			if (tmp)
+				seq_printf(sf, "%i\n", tmp);
+		}
+	} else {
+		WARN_ON(1);
+		err =3D -EIO;
+	}
+out:
+	mnt_namespace_unlock_read();
+
+	return err;
+}
+
+static int mountfs_attr_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mountfs_attr_show, inode->i_private);
+}
+
+static const struct file_operations mountfs_attr_fops =3D {
+	.open		=3D mountfs_attr_open,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
+static struct mountfs_entry *mountfs_node_to_entry(struct rb_node *node)
+{
+	return rb_entry(node, struct mountfs_entry, node);
+}
+
+static struct rb_node **mountfs_find_node(int id, struct rb_node **parent)
+{
+	struct rb_node **link =3D &mountfs_entries.rb_node;
+
+	*parent =3D NULL;
+	while (*link) {
+		struct mountfs_entry *entry =3D mountfs_node_to_entry(*link);
+
+		*parent =3D *link;
+		if (id < entry->id)
+			link =3D &entry->node.rb_left;
+		else if (id > entry->id)
+			link =3D &entry->node.rb_right;
+		else
+			break;
+	}
+	return link;
+}
+
+void mountfs_create(struct mount *mnt)
+{
+	struct mountfs_entry *entry;
+	struct rb_node **link, *parent;
+
+	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		WARN(1, "failed to allocate mountfs entry");
+		return;
+	}
+	kref_init(&entry->kref);
+	entry->mnt =3D mnt;
+	entry->id =3D mnt->mnt_id;
+
+	spin_lock(&mountfs_lock);
+	link =3D mountfs_find_node(entry->id, &parent);
+	if (!WARN_ON(*link)) {
+		rb_link_node(&entry->node, parent, link);
+		rb_insert_color(&entry->node, &mountfs_entries);
+		mnt->mnt_mountfs_entry =3D entry;
+	} else {
+		kfree(entry);
+	}
+	spin_unlock(&mountfs_lock);
+}
+
+void mountfs_remove(struct mount *mnt)
+{
+	struct mountfs_entry *entry =3D mnt->mnt_mountfs_entry;
+
+	if (!entry)
+		return;
+	spin_lock(&mountfs_lock);
+	entry->mnt =3D NULL;
+	rb_erase(&entry->node, &mountfs_entries);
+	spin_unlock(&mountfs_lock);
+
+	mountfs_entry_put(entry);
+
+	mnt->mnt_mountfs_entry =3D NULL;
+}
+
+static struct mountfs_entry *mountfs_get_entry(const char *name)
+{
+	struct mountfs_entry *entry =3D NULL;
+	struct rb_node **link, *dummy;
+	unsigned long mnt_id;
+	char buf[32];
+	int ret;
+
+	ret =3D kstrtoul(name, 10, &mnt_id);
+	if (ret || mnt_id > INT_MAX)
+		return NULL;
+
+	snprintf(buf, sizeof(buf), "%lu", mnt_id);
+	if (strcmp(buf, name) !=3D 0)
+		return NULL;
+
+	spin_lock(&mountfs_lock);
+	link =3D mountfs_find_node(mnt_id, &dummy);
+	if (*link) {
+		entry =3D mountfs_node_to_entry(*link);
+		if (!mountfs_entry_visible(entry))
+			entry =3D NULL;
+		else
+			kref_get(&entry->kref);
+	}
+	spin_unlock(&mountfs_lock);
+
+	return entry;
+}
+
+static void mountfs_init_inode(struct inode *inode, umode_t mode);
+
+static struct dentry *mountfs_lookup_entry(struct dentry *dentry,
+					   struct mountfs_entry *entry,
+					   int idx)
+{
+	struct inode *inode;
+
+	inode =3D new_inode(dentry->d_sb);
+	if (!inode) {
+		mountfs_entry_put(entry);
+		return ERR_PTR(-ENOMEM);
+	}
+	inode->i_private =3D entry;
+	inode->i_ino =3D MOUNTFS_INO(entry->id) + idx;
+	mountfs_init_inode(inode, idx ? S_IFREG | 0444 : S_IFDIR | 0555);
+	return d_splice_alias(inode, dentry);
+
+}
+
+static struct dentry *mountfs_lookup(struct inode *dir, struct dentry *den=
try,
+				     unsigned int flags)
+{
+	struct mountfs_entry *entry =3D dir->i_private;
+	int i =3D 0;
+
+	if (entry) {
+		for (i =3D 0; i < ARRAY_SIZE(mountfs_attrs); i++)
+			if (strcmp(mountfs_attrs[i], dentry->d_name.name) =3D=3D 0)
+				break;
+		if (i =3D=3D ARRAY_SIZE(mountfs_attrs))
+			return ERR_PTR(-ENOMEM);
+		i++;
+		kref_get(&entry->kref);
+	} else {
+		entry =3D mountfs_get_entry(dentry->d_name.name);
+		if (!entry)
+			return ERR_PTR(-ENOENT);
+	}
+
+	return mountfs_lookup_entry(dentry, entry, i);
+}
+
+static int mountfs_d_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	struct mountfs_entry *entry =3D dentry->d_inode->i_private;
+
+	/* root: valid */
+	if (!entry)
+		return 1;
+
+	/* removed: invalid */
+	if (!entry->mnt)
+		return 0;
+
+	/* attribute or visible in this namespace: valid */
+	if (!d_can_lookup(dentry) || mountfs_entry_visible(entry))
+		return 1;
+
+	/* invlisible in this namespace: valid but deny entry*/
+	return -ENOENT;
+}
+
+static int mountfs_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct rb_node *node;
+	struct mountfs_entry *entry =3D file_inode(file)->i_private;
+	char name[32];
+	const char *s;
+	unsigned int len, pos, id;
+
+	if (ctx->pos - 2 > INT_MAX || !dir_emit_dots(file, ctx))
+		return 0;
+
+	if (entry) {
+		while (ctx->pos - 2 < ARRAY_SIZE(mountfs_attrs)) {
+			s =3D mountfs_attrs[ctx->pos - 2];
+			if (!dir_emit(ctx, s, strlen(s),
+				      MOUNTFS_INO(entry->id) + ctx->pos,
+				      DT_REG))
+				break;
+			ctx->pos++;
+		}
+		return 0;
+	}
+
+	pos =3D ctx->pos - 2;
+	do {
+		spin_lock(&mountfs_lock);
+		mountfs_find_node(pos, &node);
+		pos =3D 1U + INT_MAX;
+		do {
+			if (!node) {
+				spin_unlock(&mountfs_lock);
+				goto out;
+			}
+			entry =3D mountfs_node_to_entry(node);
+			node =3D rb_next(node);
+		} while (!mountfs_entry_visible(entry));
+		if (node)
+			pos =3D mountfs_node_to_entry(node)->id;
+		id =3D entry->id;
+		spin_unlock(&mountfs_lock);
+
+		len =3D snprintf(name, sizeof(name), "%i", id);
+		ctx->pos =3D id + 2;
+		if (!dir_emit(ctx, name, len, MOUNTFS_INO(id), DT_DIR))
+			return 0;
+	} while (pos <=3D INT_MAX);
+out:
+	ctx->pos =3D  pos + 2;
+	return 0;
+}
+
+int mountfs_lookup_internal(struct vfsmount *m, struct path *path)
+{
+	char name[32];
+	struct qstr this =3D { .name =3D name };
+	struct mount *mnt =3D real_mount(m);
+	struct mountfs_entry *entry =3D mnt->mnt_mountfs_entry;
+	struct dentry *dentry, *old, *root =3D mountfs_mnt->mnt_root;
+
+	this.len =3D snprintf(name, sizeof(name), "%i", mnt->mnt_id);
+	dentry =3D d_hash_and_lookup(root, &this);
+	if (dentry && dentry->d_inode->i_private !=3D entry) {
+		d_invalidate(dentry);
+		dput(dentry);
+		dentry =3D NULL;
+	}
+	if (!dentry) {
+		dentry =3D d_alloc(root, &this);
+		if (!dentry)
+			return -ENOMEM;
+
+		kref_get(&entry->kref);
+		old =3D mountfs_lookup_entry(dentry, entry, 0);
+		if (old) {
+			dput(dentry);
+			if (IS_ERR(old))
+				return PTR_ERR(old);
+			dentry =3D old;
+		}
+	}
+
+	*path =3D (struct path) { .mnt =3D mountfs_mnt, .dentry =3D dentry };
+	return 0;
+}
+
+static const struct dentry_operations mountfs_dops =3D {
+	.d_revalidate =3D mountfs_d_revalidate,
+};
+
+static const struct inode_operations mountfs_iops =3D {
+	.lookup =3D mountfs_lookup,
+};
+
+static const struct file_operations mountfs_fops =3D {
+	.iterate_shared =3D mountfs_readdir,
+	.read =3D generic_read_dir,
+	.llseek =3D generic_file_llseek,
+};
+
+static void mountfs_init_inode(struct inode *inode, umode_t mode)
+{
+	inode->i_mode =3D mode;
+	inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_time(ino=
de);
+	if (S_ISREG(mode)) {
+		inode->i_size =3D PAGE_SIZE;
+		inode->i_fop =3D &mountfs_attr_fops;
+	} else {
+		inode->i_op =3D &mountfs_iops;
+		inode->i_fop =3D &mountfs_fops;
+	}
+}
+
+static void mountfs_evict_inode(struct inode *inode)
+{
+	struct mountfs_entry *entry =3D inode->i_private;
+
+	clear_inode(inode);
+	if (entry)
+		mountfs_entry_put(entry);
+}
+
+static const struct super_operations mountfs_sops =3D {
+	.statfs		=3D simple_statfs,
+	.drop_inode	=3D generic_delete_inode,
+	.evict_inode	=3D mountfs_evict_inode,
+};
+
+static int mountfs_fill_super(struct super_block *sb, struct fs_context *f=
c)
+{
+	struct inode *root;
+
+	sb->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
+	sb->s_blocksize =3D PAGE_SIZE;
+	sb->s_blocksize_bits =3D PAGE_SHIFT;
+	sb->s_magic =3D MOUNTFS_SUPER_MAGIC;
+	sb->s_time_gran =3D 1;
+	sb->s_shrink.seeks =3D 0;
+	sb->s_op =3D &mountfs_sops;
+	sb->s_d_op =3D &mountfs_dops;
+
+	root =3D new_inode(sb);
+	if (!root)
+		return -ENOMEM;
+
+	root->i_ino =3D 1;
+	mountfs_init_inode(root, S_IFDIR | 0444);
+
+	sb->s_root =3D d_make_root(root);
+	if (!sb->s_root)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int mountfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_single(fc, mountfs_fill_super);
+}
+
+static const struct fs_context_operations mountfs_context_ops =3D {
+	.get_tree =3D mountfs_get_tree,
+};
+
+static int mountfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops =3D &mountfs_context_ops;
+	fc->global =3D true;
+	return 0;
+}
+
+static struct file_system_type mountfs_fs_type =3D {
+	.name =3D "mountfs",
+	.init_fs_context =3D mountfs_init_fs_context,
+	.kill_sb =3D kill_anon_super,
+};
+
+static int __init mountfs_init(void)
+{
+	int err;
+
+	err =3D register_filesystem(&mountfs_fs_type);
+	if (!err) {
+		mountfs_mnt =3D kern_mount(&mountfs_fs_type);
+		if (IS_ERR(mountfs_mnt)) {
+			err =3D PTR_ERR(mountfs_mnt);
+			unregister_filesystem(&mountfs_fs_type);
+		}
+	}
+	return err;
+}
+fs_initcall(mountfs_init);
diff --git a/fs/namespace.c b/fs/namespace.c
index 5427e732c1bf..a05a2885a90e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -962,6 +962,8 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
=20
 	if (fc->sb_flags & SB_KERNMOUNT)
 		mnt->mnt.mnt_flags =3D MNT_INTERNAL;
+	else
+		mountfs_create(mnt);
=20
 	atomic_inc(&fc->root->d_sb->s_active);
 	mnt->mnt.mnt_sb		=3D fc->root->d_sb;
@@ -1033,7 +1035,7 @@ vfs_submount(const struct dentry *mountpoint, struct =
file_system_type *type,
 }
 EXPORT_SYMBOL_GPL(vfs_submount);
=20
-static struct mount *clone_mnt(struct mount *old, struct dentry *root,
+static struct mount *clone_mnt_common(struct mount *old, struct dentry *ro=
ot,
 					int flag)
 {
 	struct super_block *sb =3D old->mnt.mnt_sb;
@@ -1100,6 +1102,17 @@ static struct mount *clone_mnt(struct mount *old, st=
ruct dentry *root,
 	return ERR_PTR(err);
 }
=20
+static struct mount *clone_mnt(struct mount *old, struct dentry *root,
+			       int flag)
+{
+	struct mount *mnt =3D clone_mnt_common(old, root, flag);
+
+	if (!IS_ERR(mnt))
+		mountfs_create(mnt);
+
+	return mnt;
+}
+
 static void cleanup_mnt(struct mount *mnt)
 {
 	struct hlist_node *p;
@@ -1112,6 +1125,7 @@ static void cleanup_mnt(struct mount *mnt)
 	 * so mnt_get_writers() below is safe.
 	 */
 	WARN_ON(mnt_get_writers(mnt));
+
 	if (unlikely(mnt->mnt_pins.first))
 		mnt_pin_kill(mnt);
 	hlist_for_each_entry_safe(m, p, &mnt->mnt_stuck_children, mnt_umount) {
@@ -1197,6 +1211,8 @@ static void mntput_no_expire(struct mount *mnt)
 	unlock_mount_hash();
 	shrink_dentry_list(&list);
=20
+	mountfs_remove(mnt);
+
 	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
 		struct task_struct *task =3D current;
 		if (likely(!(task->flags & PF_KTHREAD))) {
@@ -1263,13 +1279,14 @@ EXPORT_SYMBOL(path_is_mountpoint);
 struct vfsmount *mnt_clone_internal(const struct path *path)
 {
 	struct mount *p;
-	p =3D clone_mnt(real_mount(path->mnt), path->dentry, CL_PRIVATE);
+	p =3D clone_mnt_common(real_mount(path->mnt), path->dentry, CL_PRIVATE);
 	if (IS_ERR(p))
 		return ERR_CAST(p);
 	p->mnt.mnt_flags |=3D MNT_INTERNAL;
 	return &p->mnt;
 }
=20
+
 #ifdef CONFIG_PROC_FS
 /* iterator; we want it to have access to namespace_sem, thus here... */
 static void *m_start(struct seq_file *m, loff_t *pos)
@@ -1411,6 +1428,16 @@ static inline void namespace_lock(void)
 	down_write(&namespace_sem);
 }
=20
+void mnt_namespace_lock_read(void)
+{
+	down_read(&namespace_sem);
+}
+
+void mnt_namespace_unlock_read(void)
+{
+	up_read(&namespace_sem);
+}
+
 enum umount_tree_flags {
 	UMOUNT_SYNC =3D 1,
 	UMOUNT_PROPAGATE =3D 2,
diff --git a/fs/proc/base.c b/fs/proc/base.c
index c7c64272b0fa..0477f8b51182 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3092,6 +3092,7 @@ static const struct pid_entry tgid_base_stuff[] =3D {
 	DIR("fd",         S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_oper=
ations),
 	DIR("map_files",  S_IRUSR|S_IXUSR, proc_map_files_inode_operations, proc_=
map_files_operations),
 	DIR("fdinfo",     S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdi=
nfo_operations),
+	DIR("fdmount",    S_IRUSR|S_IXUSR, proc_fdmount_inode_operations, proc_fd=
mount_operations),
 	DIR("ns",	  S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_op=
erations),
 #ifdef CONFIG_NET
 	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_op=
erations),
@@ -3497,6 +3498,7 @@ static const struct inode_operations proc_tid_comm_in=
ode_operations =3D {
 static const struct pid_entry tid_base_stuff[] =3D {
 	DIR("fd",        S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_opera=
tions),
 	DIR("fdinfo",    S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdin=
fo_operations),
+	DIR("fdmount",   S_IRUSR|S_IXUSR, proc_fdmount_inode_operations, proc_fdm=
ount_operations),
 	DIR("ns",	 S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_ope=
rations),
 #ifdef CONFIG_NET
 	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_op=
erations),
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d..94a57e178801 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -361,3 +361,85 @@ const struct file_operations proc_fdinfo_operations =
=3D {
 	.iterate_shared	=3D proc_readfdinfo,
 	.llseek		=3D generic_file_llseek,
 };
+
+static int proc_fdmount_link(struct dentry *dentry, struct path *path)
+{
+	struct files_struct *files =3D NULL;
+	struct task_struct *task;
+	struct path fd_path;
+	int ret =3D -ENOENT;
+
+	task =3D get_proc_task(d_inode(dentry));
+	if (task) {
+		files =3D get_files_struct(task);
+		put_task_struct(task);
+	}
+
+	if (files) {
+		unsigned int fd =3D proc_fd(d_inode(dentry));
+		struct file *fd_file;
+
+		spin_lock(&files->file_lock);
+		fd_file =3D fcheck_files(files, fd);
+		if (fd_file) {
+			fd_path =3D fd_file->f_path;
+			path_get(&fd_path);
+			ret =3D 0;
+		}
+		spin_unlock(&files->file_lock);
+		put_files_struct(files);
+	}
+	if (!ret) {
+		ret =3D mountfs_lookup_internal(fd_path.mnt, path);
+		path_put(&fd_path);
+	}
+
+	return ret;
+}
+
+static struct dentry *proc_fdmount_instantiate(struct dentry *dentry,
+	struct task_struct *task, const void *ptr)
+{
+	const struct fd_data *data =3D ptr;
+	struct proc_inode *ei;
+	struct inode *inode;
+
+	inode =3D proc_pid_make_inode(dentry->d_sb, task, S_IFLNK | 0400);
+	if (!inode)
+		return ERR_PTR(-ENOENT);
+
+	ei =3D PROC_I(inode);
+	ei->fd =3D data->fd;
+
+	inode->i_op =3D &proc_pid_link_inode_operations;
+	inode->i_size =3D 64;
+
+	ei->op.proc_get_link =3D proc_fdmount_link;
+	tid_fd_update_inode(task, inode, 0);
+
+	d_set_d_op(dentry, &tid_fd_dentry_operations);
+	return d_splice_alias(inode, dentry);
+}
+
+static struct dentry *
+proc_lookupfdmount(struct inode *dir, struct dentry *dentry, unsigned int =
flags)
+{
+	return proc_lookupfd_common(dir, dentry, proc_fdmount_instantiate);
+}
+
+static int proc_readfdmount(struct file *file, struct dir_context *ctx)
+{
+	return proc_readfd_common(file, ctx,
+				  proc_fdmount_instantiate);
+}
+
+const struct inode_operations proc_fdmount_inode_operations =3D {
+	.lookup		=3D proc_lookupfdmount,
+	.setattr	=3D proc_setattr,
+};
+
+const struct file_operations proc_fdmount_operations =3D {
+	.read		=3D generic_read_dir,
+	.iterate_shared	=3D proc_readfdmount,
+	.llseek		=3D generic_file_llseek,
+};
diff --git a/fs/proc/fd.h b/fs/proc/fd.h
index f371a602bf58..9e087c833e65 100644
--- a/fs/proc/fd.h
+++ b/fs/proc/fd.h
@@ -10,6 +10,9 @@ extern const struct inode_operations proc_fd_inode_operat=
ions;
 extern const struct file_operations proc_fdinfo_operations;
 extern const struct inode_operations proc_fdinfo_inode_operations;
=20
+extern const struct file_operations proc_fdmount_operations;
+extern const struct inode_operations proc_fdmount_inode_operations;
+
 extern int proc_fd_permission(struct inode *inode, int mask);
=20
 static inline unsigned int proc_fd(struct inode *inode)
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 273ee82d8aa9..e634faa9160e 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -61,24 +61,6 @@ static int show_sb_opts(struct seq_file *m, struct super=
_block *sb)
 	return security_sb_show_options(m, sb);
 }
=20
-static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
-{
-	static const struct proc_fs_info mnt_info[] =3D {
-		{ MNT_NOSUID, ",nosuid" },
-		{ MNT_NODEV, ",nodev" },
-		{ MNT_NOEXEC, ",noexec" },
-		{ MNT_NOATIME, ",noatime" },
-		{ MNT_NODIRATIME, ",nodiratime" },
-		{ MNT_RELATIME, ",relatime" },
-		{ 0, NULL }
-	};
-	const struct proc_fs_info *fs_infop;
-
-	for (fs_infop =3D mnt_info; fs_infop->flag; fs_infop++) {
-		if (mnt->mnt_flags & fs_infop->flag)
-			seq_puts(m, fs_infop->str);
-	}
-}
=20
 static inline void mangle(struct seq_file *m, const char *s)
 {
@@ -120,7 +102,7 @@ static int show_vfsmnt(struct seq_file *m, struct vfsmo=
unt *mnt)
 	err =3D show_sb_opts(m, sb);
 	if (err)
 		goto out;
-	show_mnt_opts(m, mnt);
+	seq_mnt_opts(m, mnt->mnt_flags);
 	if (sb->s_op->show_options)
 		err =3D sb->s_op->show_options(m, mnt_path.dentry);
 	seq_puts(m, " 0 0\n");
@@ -153,7 +135,7 @@ static int show_mountinfo(struct seq_file *m, struct vf=
smount *mnt)
 		goto out;
=20
 	seq_puts(m, mnt->mnt_flags & MNT_READONLY ? " ro" : " rw");
-	show_mnt_opts(m, mnt);
+	seq_mnt_opts(m, mnt->mnt_flags);
=20
 	/* Tagged fields ("foo:X" or "bar") */
 	if (IS_MNT_SHARED(r))
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 1600034a929b..9726baba1732 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -15,6 +15,7 @@
 #include <linux/cred.h>
 #include <linux/mm.h>
 #include <linux/printk.h>
+#include <linux/mount.h>
 #include <linux/string_helpers.h>
=20
 #include <linux/uaccess.h>
@@ -548,6 +549,28 @@ int seq_dentry(struct seq_file *m, struct dentry *dent=
ry, const char *esc)
 }
 EXPORT_SYMBOL(seq_dentry);
=20
+void seq_mnt_opts(struct seq_file *m, int mnt_flags)
+{
+	unsigned int i;
+	static const struct {
+		int flag;
+		const char *str;
+	} mnt_info[] =3D {
+		{ MNT_NOSUID, ",nosuid" },
+		{ MNT_NODEV, ",nodev" },
+		{ MNT_NOEXEC, ",noexec" },
+		{ MNT_NOATIME, ",noatime" },
+		{ MNT_NODIRATIME, ",nodiratime" },
+		{ MNT_RELATIME, ",relatime" },
+		{ 0, NULL }
+	};
+
+	for (i =3D 0; mnt_info[i].flag; i++) {
+		if (mnt_flags & mnt_info[i].flag)
+			seq_puts(m, mnt_info[i].str);
+	}
+}
+
 static void *single_start(struct seq_file *p, loff_t *pos)
 {
 	return NULL + (*pos =3D=3D 0);
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 770c2bf3aa43..9dd7812eb777 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -138,6 +138,7 @@ int seq_file_path(struct seq_file *, struct file *, con=
st char *);
 int seq_dentry(struct seq_file *, struct dentry *, const char *);
 int seq_path_root(struct seq_file *m, const struct path *path,
 		  const struct path *root, const char *esc);
+void seq_mnt_opts(struct seq_file *m, int mnt_flags);
=20
 int single_open(struct file *, int (*)(struct seq_file *, void *), void *);
 int single_open_size(struct file *, int (*)(struct seq_file *, void *), vo=
id *, size_t);
diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 19be60ab950e..78deb8483d27 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -4,6 +4,7 @@
 hostprogs :=3D \
 	test-fsinfo \
 	test-fsmount \
+	test-fsinfo-perf \
 	test-mntinfo \
 	test-statx
=20
@@ -12,6 +13,7 @@ always-y :=3D $(hostprogs)
 HOSTCFLAGS_test-fsinfo.o +=3D -I$(objtree)/usr/include
 HOSTLDLIBS_test-fsinfo +=3D -static -lm
 HOSTCFLAGS_test-mntinfo.o +=3D -I$(objtree)/usr/include
+HOSTCFLAGS_test-fsinfo-perf.o +=3D -I$(objtree)/usr/include
=20
 HOSTCFLAGS_test-fsmount.o +=3D -I$(objtree)/usr/include
 HOSTCFLAGS_test-statx.o +=3D -I$(objtree)/usr/include
diff --git a/samples/vfs/test-fsinfo-perf.c b/samples/vfs/test-fsinfo-perf.c
new file mode 100644
index 000000000000..fba40737f768
--- /dev/null
+++ b/samples/vfs/test-fsinfo-perf.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Test the fsinfo() system call
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define _GNU_SOURCE
+#define _ATFILE_SOURCE
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <errno.h>
+#include <time.h>
+#include <math.h>
+#include <fcntl.h>
+#include <sys/syscall.h>
+#include <sys/stat.h>
+#include <sys/mount.h>
+#include <sys/time.h>
+#include <linux/fsinfo.h>
+
+#ifndef __NR_fsinfo
+#define __NR_fsinfo -1
+#endif
+
+#define ERR(ret, what) do { if ((long)(ret) =3D=3D -1) { perror(what); exi=
t(1); } } while(0)
+#define OOM(ret) do { if (!(ret)) { perror(NULL); exit(1); } } while(0)
+
+static int nr_mounts =3D 3;
+static const char *base_path;
+
+static __attribute__((unused))
+ssize_t fsinfo(int dfd, const char *filename,
+	       struct fsinfo_params *params, size_t params_size,
+	       void *result_buffer, size_t result_buf_size)
+{
+	return syscall(__NR_fsinfo, dfd, filename,
+		       params, params_size,
+		       result_buffer, result_buf_size);
+}
+
+static void iterate(void (*func)(int i, const char *))
+{
+	char name[4096];
+	int i;
+
+	for (i =3D 0; i < nr_mounts; i++) {
+		sprintf(name, "%s/%d", base_path, i);
+		func(i, name);
+	}
+}
+
+static void make_mount(int ix, const char *path)
+{
+	ERR(mkdir(path, 0755), "mkdir");
+	ERR(mount("none", path, "tmpfs", 0, NULL), "mount");
+	ERR(mount("none", path, NULL, MS_PRIVATE, NULL), "mount");
+}
+
+static void do_umount(void)
+{
+	printf("--- umount ---\n");
+	if (umount2(base_path, MNT_DETACH) =3D=3D -1)
+		perror("umount");
+}
+
+static unsigned long sum_mnt_id;
+
+static void get_mntid_by_fsinfo(int ix, const char *path)
+{
+	struct fsinfo_mount_info r;
+	struct fsinfo_params params =3D {
+		.flags		=3D FSINFO_FLAGS_QUERY_PATH,
+		.request	=3D FSINFO_ATTR_MOUNT_INFO,
+	};
+
+	ERR(fsinfo(AT_FDCWD, path, &params, sizeof(params), &r, sizeof(r)),
+	    "fsinfo");
+	//printf("[%u] %u\n", ix, r.mnt_id);
+	sum_mnt_id +=3D r.mnt_id;
+}
+
+static void get_mntid_by_proc(int ix, const char *path)
+{
+	unsigned int mnt_id;
+	ssize_t len;
+	char procfile[100], buffer[4096], *p, *nl;
+	int fd, fd2;
+
+	fd =3D open(path, O_PATH);
+	ERR(fd, "open/path");
+	sprintf(procfile, "/proc/self/fdinfo/%u", fd);
+	fd2 =3D open(procfile, O_RDONLY);
+	ERR(fd2, "open/proc");
+	len =3D read(fd2, buffer, sizeof(buffer) - 1);
+	ERR(len, "read");
+	buffer[len] =3D 0;
+	close(fd2);
+	close(fd);
+
+	p =3D buffer;
+	do {
+		nl =3D strchr(p, '\n');
+		if (nl)
+			*nl++ =3D '\0';
+		else
+			nl =3D NULL;
+
+		if (strncmp(p, "mnt_id:", 7) !=3D 0)
+			continue;
+		p +=3D 7;
+		while (isblank(*p))
+			p++;
+		/* Have to allow for extra numbers being added to the line */
+		if (sscanf(p, "%u", &mnt_id) !=3D 1) {
+			fprintf(stderr, "Bad format %s\n", procfile);
+			exit(3);
+		}
+		break;
+
+	} while ((p =3D nl));
+
+	if (!p) {
+		fprintf(stderr, "Missing field %s\n", procfile);
+		exit(3);
+	}
+
+	sum_mnt_id +=3D mnt_id;
+	//printf("[%u] %u\n", ix, mnt_id);
+}
+
+static void get_mntid_by_fsinfo_2(void)
+{
+	struct fsinfo_mount_child *children, *c, *end;
+	struct fsinfo_mount_info r;
+	struct fsinfo_params params =3D {
+		.flags		=3D FSINFO_FLAGS_QUERY_PATH,
+		.request	=3D FSINFO_ATTR_MOUNT_INFO,
+	};
+	unsigned int base_mnt_id;
+	size_t s_children, n_children;
+	char name[32];
+	int i;
+
+	/* Convert path to mount ID */
+	ERR(fsinfo(AT_FDCWD, base_path, &params, sizeof(params), &r, sizeof(r)),
+	    "fsinfo/base");
+	base_mnt_id =3D r.mnt_id;
+	//printf("[B] %u\n", base_mnt_id);
+
+	/* Get a list of all the children of this mount ID */
+	s_children =3D (nr_mounts + 1) * sizeof(*children);
+	children =3D malloc(s_children);
+	OOM(children);
+
+	params.flags	=3D FSINFO_FLAGS_QUERY_MOUNT;
+	params.request	=3D FSINFO_ATTR_MOUNT_CHILDREN;
+	sprintf(name, "%u", base_mnt_id);
+	s_children =3D fsinfo(AT_FDCWD, name, &params, sizeof(params), children, =
s_children);
+	ERR(s_children, "fsinfo/children");
+
+	/* Query each child */
+	n_children =3D s_children / sizeof(*c) - 1; // Parent is added at end
+	c =3D children;
+	end =3D c + n_children;
+	for (i =3D 0; c < end; c++, i++) {
+		//printf("[%u] %u\n", i, c->mnt_id);
+		params.flags	=3D FSINFO_FLAGS_QUERY_MOUNT;
+		params.request	=3D FSINFO_ATTR_MOUNT_INFO;
+		sprintf(name, "%u", c->mnt_id);
+		ERR(fsinfo(AT_FDCWD, name, &params, sizeof(params), &r, sizeof(r)),
+		    "fsinfo/child");
+		sum_mnt_id +=3D r.mnt_id;
+	}
+}
+
+static void get_mntid_by_mountfs(void)
+{
+	unsigned int base_mnt_id, mnt_id, x;
+	ssize_t len, s_children;
+	char procfile[100], buffer[100], *children, *p, *q, *nl, *comma;
+	int fd, fd2, mntfd, i;
+
+	/* Start off by reading the mount ID from the base path */
+	fd =3D open(base_path, O_PATH);
+	ERR(fd, "open/path");
+	sprintf(procfile, "/proc/self/fdinfo/%u", fd);
+	fd2 =3D open(procfile, O_RDONLY);
+	ERR(fd2, "open/proc");
+	len =3D read(fd2, buffer, sizeof(buffer) - 1);
+	ERR(len, "read");
+	buffer[len] =3D 0;
+	close(fd2);
+	close(fd);
+
+	p =3D buffer;
+	do {
+		nl =3D strchr(p, '\n');
+		if (nl)
+			*nl++ =3D '\0';
+		else
+			nl =3D NULL;
+
+		if (strncmp(p, "mnt_id:", 7) !=3D 0)
+			continue;
+		p +=3D 7;
+		while (isblank(*p))
+			p++;
+		/* Have to allow for extra numbers being added to the line */
+		if (sscanf(p, "%u", &base_mnt_id) !=3D 1) {
+			fprintf(stderr, "Bad format %s\n", procfile);
+			exit(3);
+		}
+		break;
+
+	} while ((p =3D nl));
+
+	if (!p) {
+		fprintf(stderr, "Missing field %s\n", procfile);
+		exit(3);
+	}
+
+	if (0) printf("[B] %u\n", base_mnt_id);
+
+	mntfd =3D open("/mnt", O_PATH);
+	ERR(fd, "open/mountfs");
+
+	/* Get a list of all the children of this mount ID */
+	s_children =3D (nr_mounts) * 12;
+	children =3D malloc(s_children);
+	OOM(children);
+
+	sprintf(procfile, "%u/children", base_mnt_id);
+	fd =3D openat(mntfd, procfile, O_RDONLY);
+	ERR(fd, "open/children");
+	s_children =3D read(fd, children, s_children - 1);
+	ERR(s_children, "read/children");
+	close(fd);
+	if (s_children > 0 && children[s_children - 1] =3D=3D '\n')
+		s_children--;
+	children[s_children] =3D 0;
+
+	/* Query each child */
+	p =3D children;
+	if (!*p)
+		return;
+	i =3D 0;
+	do {
+		mnt_id =3D strtoul(p, &comma, 10);
+		if (*comma) {
+			if (*comma !=3D ',') {
+				fprintf(stderr, "Bad format in mountfs-children\n");
+				exit(3);
+			}
+			comma++;
+		}
+
+		sprintf(procfile, "%u/id", mnt_id);
+		fd =3D openat(mntfd, procfile, O_RDONLY);
+		ERR(fd, procfile);
+		len =3D read(fd, buffer, sizeof(buffer) - 1);
+		ERR(len, "read/id");
+		close(fd);
+		if (len > 0 && buffer[len - 1] =3D=3D '\n')
+			len--;
+		buffer[len] =3D 0;
+
+		x =3D strtoul(buffer, &q, 10);
+
+		if (*q) {
+			fprintf(stderr, "Bad format in %s '%s'\n", procfile, buffer);
+			exit(3);
+		}
+
+		if (0) printf("[%u] %u\n", i++, x);
+		sum_mnt_id +=3D x;
+	} while (p =3D comma, *comma);
+}
+
+static unsigned long duration(struct timeval *before, struct timeval *afte=
r)
+{
+	unsigned long a, b;
+
+	a =3D after->tv_sec * 1000000 + after->tv_usec;
+	b =3D before->tv_sec * 1000000 + before->tv_usec;
+	return a - b;
+}
+
+int main(int argc, char **argv)
+{
+	struct timeval f_before, f_after;
+	struct timeval f2_before, f2_after;
+	struct timeval p_before, p_after;
+	struct timeval p2_before, p2_after;
+	const char *path;
+	unsigned long f_dur, f2_dur, p_dur, p2_dur;
+
+	if (argc < 2) {
+		fprintf(stderr, "Format: %s <path> [nr_mounts]\n", argv[0]);
+		exit(2);
+	}
+
+	if (argc =3D=3D 3)
+		nr_mounts =3D atoi(argv[2]);
+
+	path =3D argv[1];
+	ERR(mount("none", path, "tmpfs", 0, NULL), "mount");
+	ERR(mount("none", path, NULL, MS_PRIVATE, NULL), "mount");
+	base_path =3D path;
+	atexit(do_umount);
+
+	printf("--- make mounts ---\n");
+	iterate(make_mount);
+
+	printf("--- test fsinfo by path ---\n");
+	sum_mnt_id =3D 0;
+	ERR(gettimeofday(&f_before, NULL), "gettimeofday");
+	iterate(get_mntid_by_fsinfo);
+	ERR(gettimeofday(&f_after, NULL), "gettimeofday");
+	printf("sum(mnt_id) =3D %lu\n", sum_mnt_id);
+
+	printf("--- test fsinfo by mnt_id ---\n");
+	sum_mnt_id =3D 0;
+	ERR(gettimeofday(&f2_before, NULL), "gettimeofday");
+	get_mntid_by_fsinfo_2();
+	ERR(gettimeofday(&f2_after, NULL), "gettimeofday");
+	printf("sum(mnt_id) =3D %lu\n", sum_mnt_id);
+
+	printf("--- test /proc/fdinfo ---\n");
+	sum_mnt_id =3D 0;
+	ERR(gettimeofday(&p_before, NULL), "gettimeofday");
+	iterate(get_mntid_by_proc);
+	ERR(gettimeofday(&p_after, NULL), "gettimeofday");
+	printf("sum(mnt_id) =3D %lu\n", sum_mnt_id);
+
+	printf("--- test mountfs ---\n");
+	sum_mnt_id =3D 0;
+	ERR(gettimeofday(&p2_before, NULL), "gettimeofday");
+	get_mntid_by_mountfs();
+	ERR(gettimeofday(&p2_after, NULL), "gettimeofday");
+	printf("sum(mnt_id) =3D %lu\n", sum_mnt_id);
+
+	f_dur  =3D duration(&f_before,  &f_after);
+	f2_dur =3D duration(&f2_before, &f2_after);
+	p_dur  =3D duration(&p_before,  &p_after);
+	p2_dur =3D duration(&p2_before, &p2_after);
+	//printf("fsinfo duration %10luus for %d mounts\n", f_dur, nr_mounts);
+	//printf("procfd duration %10luus for %d mounts\n", p_dur, nr_mounts);
+
+	printf("For %7d mounts, f=3D%10luus f2=3D%10luus p=3D%10luus p2=3D%10luus=
; p=3D%.1f*f p=3D%.1f*f2 p=3D%.1f*p2\n",
+	       nr_mounts, f_dur, f2_dur, p_dur, p2_dur,
+	       (double)p_dur / (double)f_dur,
+	       (double)p_dur / (double)f2_dur,
+	       (double)p_dur / (double)p2_dur);
+	return 0;
+}

