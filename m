Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B673B199CE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 19:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgCaRb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 13:31:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34545 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726225AbgCaRb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585675885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Fr4pTYRZKTTjCgplR+n8iUtyktVF/dU5oYAI+2uVVI=;
        b=a66AnHqr2A9V5yR9PJJctmyZoMsDAQUlFp7FnXXhTCZFluj2Os2dB0nIUu53oh78lx8M9D
        jVPtHEeps+7qjOY/bfyjhokPcIxcYSGMN3frLmuZ99g620m7iJihQL7M8GAoixg7FTnoyp
        +sPpYK9o208ImduZFL0IuhPSH6pXenc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-RtOQVZ_FP0q0gMEk3EOYwg-1; Tue, 31 Mar 2020 13:31:21 -0400
X-MC-Unique: RtOQVZ_FP0q0gMEk3EOYwg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD6A0477;
        Tue, 31 Mar 2020 17:31:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C5AF96B92;
        Tue, 31 Mar 2020 17:31:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com>
References: <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com> <1445647.1585576702@warthog.procyon.org.uk>
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
Date:   Tue, 31 Mar 2020 18:31:15 +0100
Message-ID: <2294742.1585675875@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> The basic problem in my view, is that the performance requirement of a
> "get filesystem information" type of API just does not warrant a
> binary coded interface. I've said this a number of times, but it fell
> on deaf ears.

It hasn't so fallen, but don't necessarily agree with you.  Let's pin some
numbers on this.

Using what I think is your latest patch where you look up
/proc/<pid>/fdinfo/<fd> to find a file that gives a summary of some
information in "key: val" format, including a mount ID.  You then have to l=
ook
in a mounted mountfs magic filesystem for a directory corresponding mount ID
that has a bunch of attribute files in it, most with a single attribute val=
ue.

What I can do with it is, say, look up the mount ID of the object attached =
to
a path - but that's about all because it doesn't implement anything like
look-up-by-mount-ID or list-children.

Attached is a kernel patch, supplementary to the fsinfo patchset, that adds
your implementation, fixed for coexistence with the mount notifications cod=
e,
plus a sample program that creates N mounts and then sees how long it takes=
 to
query each of those mounts for its mnt_id by four different methods:

 (1) "f" - Use fsinfo, looking up each mount root directly by path.

 (2) "f2" - Use fsinfo, firstly using fsinfo() to look up the base mount by
     path, then use fsinfo() to get a list of all the children of that mount
     (which in fact gives me the mnt_id, but ignoring that), and then call
     fsinfo() by mount ID for each child to get its information, including =
its
     mnt_id.

 (3) "p" - Open the root of each mount with O_PATH and then open and read t=
he
     procfile to retrieve information, then parse the received text to find
     the line with that key, then parse the line to get the number, allowing
     for the possibility that the line might acquire extra numbers.

 (4) "p2" - Open the root of the base mount with O_PATH, then read the
     appropriate file in /proc/fdinfo to find the base mount ID.  Open "/mn=
t"
     O_PATH to use as a base.  Then read <mntid>/children and parse the list
     to find each child.  Each child's <mntid>/id file is then read.

Run the program like:

	mount -t mountfs none /mnt
	mkdir /tmp/a
	./test-fsinfo-perf /tmp/a 20000

Note that it detaches its base mount afterwards and lets it get cleaned up =
and
systemd goes crazy for a bit.  Note also that it prints the sum of all the
mount IDs as a consistency check for each test.

Okay, the results:

  For  1000 mounts, f=3D 1514us f2=3D 1102us p=3D  6014us p2=3D  6935us; p=
=3D4.0*f p=3D5.5*f2 p=3D0.9*p2
  For  2000 mounts, f=3D 4712us f2=3D 3675us p=3D 20937us p2=3D 22878us; p=
=3D4.4*f p=3D5.7*f2 p=3D0.9*p2
  For  3000 mounts, f=3D 6795us f2=3D 5304us p=3D 31080us p2=3D 34056us; p=
=3D4.6*f p=3D5.9*f2 p=3D0.9*p2
  For  4000 mounts, f=3D 9291us f2=3D 7434us p=3D 40723us p2=3D 46479us; p=
=3D4.4*f p=3D5.5*f2 p=3D0.9*p2
  For  5000 mounts, f=3D11423us f2=3D 9219us p=3D 50878us p2=3D 58857us; p=
=3D4.5*f p=3D5.5*f2 p=3D0.9*p2
  For 10000 mounts, f=3D22899us f2=3D18240us p=3D101054us p2=3D117273us; p=
=3D4.4*f p=3D5.5*f2 p=3D0.9*p2
  For 20000 mounts, f=3D45811us f2=3D37211us p=3D203640us p2=3D237377us; p=
=3D4.4*f p=3D5.5*f2 p=3D0.9*p2
  For 30000 mounts, f=3D69703us f2=3D54800us p=3D306778us p2=3D357629us; p=
=3D4.4*f p=3D5.6*f2 p=3D0.9*p2
=20=20=20=20=20=20
The number of mounts doesn't have an effect - not surprising with direct
pathwalk-based approaches ("f" and "p") since the pathwalk part is the same=
 in
both cases, though in one fsinfo() does it and in the other, open(O_PATH).

As you can see, your procfs-based approach takes consistently about 4.4 tim=
es
as long as fsinfo(QUERY_PATH) and 5.5 times as long as fsinfo(QUERY_MOUNT).

Going through mountfs ("p2") is even slower than going through procfs, thou=
gh
this really ought to be comparable to fsinfo-by-mount-ID ("f2"), but the
latter is something like 6.5x faster.

I suspect the procfs-based and mountfs-based approaches suffer from creating
lots of inodes, dentries and file structs as you access the files.  This al=
so
means that they use more live state memory - and I think it lingers - if you
start using them, whereas fsinfo() uses none at all, beyond whatever is used
by the pathwalk to find the object to query (if you go that route).

mountfs is going to be worse also if you want more than one value if you
persist in putting one attribute in each file.

David
---
commit ed109ef4351d44a3e881e6518a207431113c17c0
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

