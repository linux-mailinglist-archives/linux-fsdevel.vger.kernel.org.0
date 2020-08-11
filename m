Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CA9241BD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 15:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgHKNyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 09:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgHKNya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:54:30 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61345C06178A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 06:54:29 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qc22so13186937ejb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PaRKw4AkPFZb5y0XO1Ni5E6XdIZGKwOtbXJj+RQBtAg=;
        b=QzBwN0u7bB8TheFfRAJtCdk0w7y3gXs9960+fr+7T1UiUxxnw6XIuVScQHjIHGtQaQ
         Hx2DBSlxv+9MDOWHsJjoMB20rwQmz2XaBcOeNcGArYg936hPWfDZ6EMvKepD6T4LuI0H
         bP0X5Pw/BnZf19bb0yTF0MYScpOdKAcH6b3W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PaRKw4AkPFZb5y0XO1Ni5E6XdIZGKwOtbXJj+RQBtAg=;
        b=mo2iSQi570k1adHjDmbgvBNCPB4dhklOwrIOmePNz3Az3PpahxWZSTFVqF3+IEaY4V
         RUPK5inyJfHqq0pIPkHrh+pUTwr+QsJl1UACngp8TAnCYlJr/2+oi5kM7F1BGMFCbe46
         iGBmAOI/pV+IWIQEIe6eCsA85fy4q6h31peSIWKG2mOHcyP+ViRyH0xZNfzCJJ73r4wS
         DG8lT5nSS+ts7FcBa/dSUy5aSYevPB8yzpQzc4hBIeUdwc0nlJ28y7hhNHzcE+L0Ko+0
         7RFmPu5EA2t+8V4jkSpEL7Ob7zxIRnzB5Zy4ArVon1XQXjXTxG5YfzzWzb+TKxUyKbsn
         q6dg==
X-Gm-Message-State: AOAM530ts7+eoS991LmYQGOBVtnGmhg4QYUcLSwRg7pH6j/FxSTIxoao
        0YRpOxYpDyb1/8ET4vz6d7oVzgcNm86jRA==
X-Google-Smtp-Source: ABdhPJxgVl0CDmA8JYa8zYwCB+cWtxF0+cP5b6W9fP434Hc3CdQ6J8ApKCCYQdoaYvmHBzUq1VdwBw==
X-Received: by 2002:a17:906:68b:: with SMTP id u11mr28213804ejb.143.1597154067285;
        Tue, 11 Aug 2020 06:54:27 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id s9sm8737495edt.36.2020.08.11.06.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 06:54:26 -0700 (PDT)
Date:   Tue, 11 Aug 2020 15:54:19 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: file metadata via fs API  (was: [GIT PULL] Filesystem
 Information)
Message-ID: <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
References: <1842689.1596468469@warthog.procyon.org.uk>
 <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 05, 2020 at 10:24:23AM +0200, Miklos Szeredi wrote:
> On Tue, Aug 4, 2020 at 4:36 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > I think we already lost that with the xattr API, that should have been
> > done in a way that fits this philosophy.  But given that we  have "/"
> > as the only special purpose char in filenames, and even repetitions
> > are allowed, it's hard to think of a good way to do that.  Pity.
> 
> One way this could be solved is to allow opting into an alternative
> path resolution mode.
> 
> E.g.
>   openat(AT_FDCWD, "foo/bar//mnt/info", O_RDONLY | O_ALT);

Proof of concept patch and test program below.

Opted for triple slash in the hope that just maybe we could add a global
/proc/sys/fs/resolve_alt knob to optionally turn on alternative (non-POSIX) path
resolution without breaking too many things.  Will try that later...

Comments?

Thanks,
Miklos

cat_alt.c:
-------- >8 --------
#define _GNU_SOURCE
#include <err.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <linux/unistd.h>
#include <linux/openat2.h>

#define RESOLVE_ALT		0x20 /* Alternative path walk mode where
					multiple slashes have special meaning */

int main(int argc, char *argv[])
{
	struct open_how how = {
		.flags = O_RDONLY,
		.resolve = RESOLVE_ALT,
	};
	int fd, res, i;
	char buf[65536], *end;
	const char *path = argv[1];
	int dfd = AT_FDCWD;

	if (argc < 2 || argc > 4)
		errx(1, "usage: %s path [dirfd] [--nofollow]", argv[0]);


	for (i = 2; i < argc; i++) {
		if (strcmp(argv[i], "--nofollow") == 0) {
			how.flags |= O_NOFOLLOW;
		} else {
			dfd = strtoul(argv[i], &end, 0);
			if (end == argv[i] || *end)
				errx(1, "invalid dirfd: %s", argv[i]);
		}
	}

	fd = syscall(__NR_openat2, dfd, path, &how, sizeof(how));
	if (fd == -1)
		err(1, "failed to open %s", argv[1]);

	while (1) {
		res = read(fd, buf, sizeof(buf));
		if (res == -1)
			err(1, "failed to read file");
		if (res == 0)
			break;

		write(1, buf, res);
	}
	close(fd);
	return 0;
}
-------- >8 --------

---
 fs/Makefile                  |    2 
 fs/file_table.c              |   70 ++++++++++++++--------
 fs/fsmeta.c                  |  135 +++++++++++++++++++++++++++++++++++++++++++
 fs/internal.h                |    9 ++
 fs/mount.h                   |    4 +
 fs/namei.c                   |   77 +++++++++++++++++++++---
 fs/namespace.c               |   12 +++
 fs/open.c                    |    2 
 fs/proc_namespace.c          |    2 
 include/linux/fcntl.h        |    2 
 include/linux/namei.h        |    3 
 include/uapi/linux/magic.h   |    1 
 include/uapi/linux/openat2.h |    2 
 13 files changed, 282 insertions(+), 39 deletions(-)

--- a/fs/Makefile
+++ b/fs/Makefile
@@ -13,7 +13,7 @@ obj-y :=	open.o read_write.o file_table.
 		seq_file.o xattr.o libfs.o fs-writeback.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
-		fs_types.o fs_context.o fs_parser.o fsopen.o
+		fs_types.o fs_context.o fs_parser.o fsopen.o fsmeta.o \
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -178,22 +178,9 @@ struct file *alloc_empty_file_noaccount(
 	return f;
 }
 
-/**
- * alloc_file - allocate and initialize a 'struct file'
- *
- * @path: the (dentry, vfsmount) pair for the new file
- * @flags: O_... flags with which the new file will be opened
- * @fop: the 'struct file_operations' for the new file
- */
-static struct file *alloc_file(const struct path *path, int flags,
-		const struct file_operations *fop)
+static void init_file(struct file *file, const struct path *path, int flags,
+		      const struct file_operations *fop)
 {
-	struct file *file;
-
-	file = alloc_empty_file(flags, current_cred());
-	if (IS_ERR(file))
-		return file;
-
 	file->f_path = *path;
 	file->f_inode = path->dentry->d_inode;
 	file->f_mapping = path->dentry->d_inode->i_mapping;
@@ -209,31 +196,66 @@ static struct file *alloc_file(const str
 	file->f_op = fop;
 	if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
 		i_readcount_inc(path->dentry->d_inode);
+}
+
+/**
+ * alloc_file - allocate and initialize a 'struct file'
+ *
+ * @path: the (dentry, vfsmount) pair for the new file
+ * @flags: O_... flags with which the new file will be opened
+ * @fop: the 'struct file_operations' for the new file
+ */
+static struct file *alloc_file(const struct path *path, int flags,
+		const struct file_operations *fop)
+{
+	struct file *file;
+
+	file = alloc_empty_file(flags, current_cred());
+	if (IS_ERR(file))
+		return file;
+
+	init_file(file, path, flags, fop);
+
 	return file;
 }
 
-struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
-				const char *name, int flags,
-				const struct file_operations *fops)
+int init_file_pseudo(struct file *file, struct inode *inode,
+		     struct vfsmount *mnt, const char *name, int flags,
+		     const struct file_operations *fops)
 {
 	static const struct dentry_operations anon_ops = {
 		.d_dname = simple_dname
 	};
 	struct qstr this = QSTR_INIT(name, strlen(name));
 	struct path path;
-	struct file *file;
 
 	path.dentry = d_alloc_pseudo(mnt->mnt_sb, &this);
 	if (!path.dentry)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	if (!mnt->mnt_sb->s_d_op)
 		d_set_d_op(path.dentry, &anon_ops);
 	path.mnt = mntget(mnt);
 	d_instantiate(path.dentry, inode);
-	file = alloc_file(&path, flags, fops);
-	if (IS_ERR(file)) {
-		ihold(inode);
-		path_put(&path);
+	init_file(file, &path, flags, fops);
+
+	return 0;
+}
+
+struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
+				const char *name, int flags,
+				const struct file_operations *fops)
+{
+	struct file *file;
+	int err;
+
+	file = alloc_empty_file(flags, current_cred());
+	if (IS_ERR(file))
+		return file;
+
+	err = init_file_pseudo(file, inode, mnt, name, flags, fops);
+	if (err) {
+		fput(file);
+		file = ERR_PTR(err);
 	}
 	return file;
 }
--- /dev/null
+++ b/fs/fsmeta.c
@@ -0,0 +1,135 @@
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/magic.h>
+#include <linux/seq_file.h>
+#include <linux/fs_struct.h>
+#include <linux/pseudo_fs.h>
+
+#include "mount.h"
+#include "internal.h"
+
+static struct vfsmount *fsmeta_mnt;
+static struct inode *fsmeta_inode;
+
+
+static struct vfsmount *fsmeta_mnt_info_get_mnt(struct seq_file *seq)
+{
+	struct proc_mounts *p = seq->private;
+
+	return &list_entry(p->cursor.mnt_list.next, struct mount, mnt_list)->mnt;
+}
+
+static void *fsmeta_mnt_info_start(struct seq_file *seq, loff_t *pos)
+{
+	mnt_namespace_lock_read();
+	return *pos == 0 ? fsmeta_mnt_info_get_mnt(seq) : NULL;
+}
+
+static void *fsmeta_mnt_info_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	return NULL;
+}
+
+static void fsmeta_mnt_info_stop(struct seq_file *seq, void *v)
+{
+	mnt_namespace_unlock_read();
+}
+
+static int fsmeta_mnt_info_show(struct seq_file *seq, void *v)
+{
+	return show_mountinfo(seq, v);
+}
+
+static const struct seq_operations fsmeta_mnt_info_sops = {
+	.start = fsmeta_mnt_info_start,
+	.next = fsmeta_mnt_info_next,
+	.stop = fsmeta_mnt_info_stop,
+	.show = fsmeta_mnt_info_show,
+};
+
+static int fsmeta_mnt_info_release(struct inode *inode, struct file *file)
+{
+	if (file->private_data) {
+		struct seq_file *seq = file->private_data;
+		struct proc_mounts *p = seq->private;
+
+		mntput(fsmeta_mnt_info_get_mnt(seq));
+		path_put(&p->root);
+
+		return seq_release_private(inode, file);
+	}
+	return 0;
+}
+
+static const struct file_operations fsmeta_mnt_info_fops = {
+	.release = fsmeta_mnt_info_release,
+	.read = seq_read,
+	.llseek = no_llseek,
+};
+
+static int fsmeta_mnt_info_open(struct file *file, const struct path *path,
+				const struct open_flags *op)
+{
+	struct proc_mounts *p;
+	int err;
+
+	err = init_file_pseudo(file, fsmeta_inode, fsmeta_mnt, "[mnt.info]",
+			       op->open_flag, &fsmeta_mnt_info_fops);
+	if (err)
+		return err;
+	/*
+	 * This reference is now sunk in file->f_path.dentry->d_inode and will
+	 * be released by fput()
+	 */
+	ihold(fsmeta_inode);
+
+	err = seq_open_private(file, &fsmeta_mnt_info_sops, sizeof(*p));
+	if (err)
+		return err;
+
+	p = ((struct seq_file *)file->private_data)->private;
+	get_fs_root(current->fs, &p->root);
+	p->cursor.mnt_list.next = &real_mount(mntget(path->mnt))->mnt_list;
+
+	return 0;
+}
+
+int fsmeta_open(const char *meta_name, const struct path *path,
+	      struct file *file, const struct open_flags *op)
+{
+	if (op->open_flag & ~(O_LARGEFILE | O_CLOEXEC | O_NOFOLLOW))
+		return -EINVAL;
+
+	if (strcmp(meta_name, "mnt/info") == 0)
+		return fsmeta_mnt_info_open(file, path, op);
+
+	pr_info("invalid fsmeta file <%s> on %pd4\n", meta_name, path->dentry);
+	return -EINVAL;
+}
+
+static int fsmeta_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, FSMETA_MAGIC) ? 0 : -ENOMEM;
+}
+
+static struct file_system_type fsmeta_fs_type = {
+	.name		= "fsmeta",
+	.init_fs_context = fsmeta_init_fs_context,
+	.kill_sb	= kill_anon_super,
+};
+
+static int __init fsmeta_init(void)
+{
+	fsmeta_mnt = kern_mount(&fsmeta_fs_type);
+	if (IS_ERR(fsmeta_mnt))
+		panic("fsmeta_init() kernel mount failed (%ld)\n", PTR_ERR(fsmeta_mnt));
+
+	fsmeta_inode = alloc_anon_inode(fsmeta_mnt->mnt_sb);
+	if (IS_ERR(fsmeta_inode))
+		panic("fsmeta_init() inode allocation failed (%ld)\n", PTR_ERR(fsmeta_inode));
+
+	return 0;
+}
+fs_initcall(fsmeta_init);
+
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -99,6 +99,9 @@ extern void chroot_fs_refs(const struct
  */
 extern struct file *alloc_empty_file(int, const struct cred *);
 extern struct file *alloc_empty_file_noaccount(int, const struct cred *);
+extern int init_file_pseudo(struct file *file, struct inode *inode,
+			    struct vfsmount *mnt, const char *name, int flags,
+			    const struct file_operations *fops);
 
 /*
  * super.c
@@ -185,3 +188,9 @@ int sb_init_dio_done_wq(struct super_blo
  */
 int do_statx(int dfd, const char __user *filename, unsigned flags,
 	     unsigned int mask, struct statx __user *buffer);
+
+/*
+ * fs/fsmeta.c
+ */
+int fsmeta_open(const char *meta_name, const struct path *path,
+		struct file *file, const struct open_flags *op);
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -159,3 +159,7 @@ static inline bool is_anon_ns(struct mnt
 }
 
 extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor);
+
+void mnt_namespace_lock_read(void);
+void mnt_namespace_unlock_read(void);
+int show_mountinfo(struct seq_file *m, struct vfsmount *mnt);
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2094,6 +2094,30 @@ static inline u64 hash_name(const void *
 
 #endif
 
+static int lookup_alt(const char *name, struct nameidata *nd)
+{
+	if ((nd->flags & LOOKUP_RCU) && unlazy_walk(nd) != 0)
+		return -ECHILD;
+
+	nd->last.name = name + 3;
+	nd->last_type = LAST_META;
+
+	return 0;
+}
+
+static bool is_alt(const char *name, struct nameidata *nd, int depth)
+{
+	if (!(nd->flags & LOOKUP_ALT))
+		return false;
+
+	/* no alternative lookup inside symlinks */
+	if (depth)
+		return false;
+
+	/* name[0] has already been verified to be a slash */
+	return name[1] == '/' && name[2] == '/' && name[3] != '/';
+}
+
 /*
  * Name resolution.
  * This is the basic name resolution function, turning a pathname into
@@ -2111,8 +2135,13 @@ static int link_path_walk(const char *na
 	nd->flags |= LOOKUP_PARENT;
 	if (IS_ERR(name))
 		return PTR_ERR(name);
-	while (*name=='/')
-		name++;
+	if (*name == '/') {
+		if (!is_alt(name, nd, depth)) {
+			do {
+				name++;
+			} while (*name == '/');
+		}
+	}
 	if (!*name)
 		return 0;
 
@@ -2122,6 +2151,9 @@ static int link_path_walk(const char *na
 		u64 hash_len;
 		int type;
 
+		if (*name == '/')
+			return lookup_alt(name, nd);
+
 		err = may_lookup(nd);
 		if (err)
 			return err;
@@ -2163,6 +2195,13 @@ static int link_path_walk(const char *na
 		 * If it wasn't NUL, we know it was '/'. Skip that
 		 * slash, and continue until no more slashes.
 		 */
+		if (is_alt(name, nd, depth)) {
+			link = walk_component(nd, WALK_TRAILING);
+			if (unlikely(link))
+				goto LINK;
+
+			return lookup_alt(name, nd);
+		}
 		do {
 			name++;
 		} while (unlikely(*name == '/'));
@@ -2183,6 +2222,7 @@ static int link_path_walk(const char *na
 			link = walk_component(nd, WALK_MORE);
 		}
 		if (unlikely(link)) {
+LINK:
 			if (IS_ERR(link))
 				return PTR_ERR(link);
 			/* a symlink to follow */
@@ -2239,11 +2279,11 @@ static const char *path_init(struct name
 	nd->path.dentry = NULL;
 
 	/* Absolute pathname -- fetch the root (LOOKUP_IN_ROOT uses nd->dfd). */
-	if (*s == '/' && !(flags & LOOKUP_IN_ROOT)) {
+	if (*s == '/' && !is_alt(s, nd, 0) && !(flags & LOOKUP_IN_ROOT)) {
 		error = nd_jump_root(nd);
 		if (unlikely(error))
 			return ERR_PTR(error);
-		return s;
+		return s + 1;
 	}
 
 	/* Relative pathname -- get the starting-point it is relative to. */
@@ -2272,7 +2312,8 @@ static const char *path_init(struct name
 
 		dentry = f.file->f_path.dentry;
 
-		if (*s && unlikely(!d_can_lookup(dentry))) {
+		if (*s && unlikely(!d_can_lookup(dentry)) &&
+		    !is_alt(s, nd, 0)) {
 			fdput(f);
 			return ERR_PTR(-ENOTDIR);
 		}
@@ -2303,6 +2344,9 @@ static const char *path_init(struct name
 
 static inline const char *lookup_last(struct nameidata *nd)
 {
+	if (nd->last_type == LAST_META)
+		return ERR_PTR(-EINVAL);
+
 	if (nd->last_type == LAST_NORM && nd->last.name[nd->last.len])
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
@@ -2331,7 +2375,7 @@ static int path_lookupat(struct nameidat
 
 	while (!(err = link_path_walk(s, nd)) &&
 	       (s = lookup_last(nd)) != NULL)
-		;
+		nd->flags &= ~LOOKUP_ALT;
 	if (!err)
 		err = complete_walk(nd);
 
@@ -2410,9 +2454,15 @@ static struct filename *filename_parenta
 	if (unlikely(retval == -ESTALE))
 		retval = path_parentat(&nd, flags | LOOKUP_REVAL, parent);
 	if (likely(!retval)) {
-		*last = nd.last;
-		*type = nd.last_type;
-		audit_inode(name, parent->dentry, AUDIT_INODE_PARENT);
+		if (nd.last_type == LAST_META) {
+			path_put(parent);
+			putname(name);
+			name = ERR_PTR(-EINVAL);
+		} else {
+			*last = nd.last;
+			*type = nd.last_type;
+			audit_inode(name, parent->dentry, AUDIT_INODE_PARENT);
+		}
 	} else {
 		putname(name);
 		name = ERR_PTR(retval);
@@ -3123,6 +3173,10 @@ static const char *open_last_lookups(str
 	nd->flags |= op->intent;
 
 	if (nd->last_type != LAST_NORM) {
+		if (nd->last_type == LAST_META) {
+			return ERR_PTR(fsmeta_open(nd->last.name, &nd->path,
+						   file, op));
+		}
 		if (nd->depth)
 			put_link(nd);
 		return handle_dots(nd, nd->last_type);
@@ -3206,6 +3260,9 @@ static int do_open(struct nameidata *nd,
 	int acc_mode;
 	int error;
 
+	if (nd->last_type == LAST_META)
+		return 0;
+
 	if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
 		error = complete_walk(nd);
 		if (error)
@@ -3355,7 +3412,7 @@ static struct file *path_openat(struct n
 		const char *s = path_init(nd, flags);
 		while (!(error = link_path_walk(s, nd)) &&
 		       (s = open_last_lookups(nd, file, op)) != NULL)
-			;
+			nd->flags &= ~LOOKUP_ALT;
 		if (!error)
 			error = do_open(nd, file, op);
 		terminate_walk(nd);
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -69,7 +69,7 @@ static DEFINE_IDA(mnt_group_ida);
 static struct hlist_head *mount_hashtable __read_mostly;
 static struct hlist_head *mountpoint_hashtable __read_mostly;
 static struct kmem_cache *mnt_cache __read_mostly;
-static DECLARE_RWSEM(namespace_sem);
+DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 
@@ -1435,6 +1435,16 @@ static inline void namespace_lock(void)
 	down_write(&namespace_sem);
 }
 
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
 	UMOUNT_SYNC = 1,
 	UMOUNT_PROPAGATE = 2,
--- a/fs/open.c
+++ b/fs/open.c
@@ -1098,6 +1098,8 @@ inline int build_open_flags(const struct
 		lookup_flags |= LOOKUP_BENEATH;
 	if (how->resolve & RESOLVE_IN_ROOT)
 		lookup_flags |= LOOKUP_IN_ROOT;
+	if (how->resolve & RESOLVE_ALT)
+		lookup_flags |= LOOKUP_ALT;
 
 	op->lookup_flags = lookup_flags;
 	return 0;
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -128,7 +128,7 @@ static int show_vfsmnt(struct seq_file *
 	return err;
 }
 
-static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
+int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
 {
 	struct proc_mounts *p = m->private;
 	struct mount *r = real_mount(mnt);
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -19,7 +19,7 @@
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
-	 RESOLVE_BENEATH | RESOLVE_IN_ROOT)
+	 RESOLVE_BENEATH | RESOLVE_IN_ROOT | RESOLVE_ALT)
 
 /* List of all open_how "versions". */
 #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -15,7 +15,7 @@ enum { MAX_NESTED_LINKS = 8 };
 /*
  * Type of the last component on LOOKUP_PARENT
  */
-enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
+enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_META};
 
 /* pathwalk mode */
 #define LOOKUP_FOLLOW		0x0001	/* follow links at the end */
@@ -27,6 +27,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LA
 
 #define LOOKUP_REVAL		0x0020	/* tell ->d_revalidate() to trust no cache */
 #define LOOKUP_RCU		0x0040	/* RCU pathwalk mode; semi-internal */
+#define LOOKUP_ALT		0x200000 /* Alternative path walk mode */
 
 /* These tell filesystem methods that we are dealing with the final component... */
 #define LOOKUP_OPEN		0x0100	/* ... in open */
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -88,6 +88,7 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #define AAFS_MAGIC		0x5a3c69f0
 #define ZONEFS_MAGIC		0x5a4f4653
+#define FSMETA_MAGIC		0x9f8ea387
 
 /* Since UDF 2.01 is ISO 13346 based... */
 #define UDF_SUPER_MAGIC		0x15013346
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -35,5 +35,7 @@ struct open_how {
 #define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
 					be scoped inside the dirfd
 					(similar to chroot(2)). */
+#define RESOLVE_ALT		0x20 /* Alternative path walk mode where
+					multiple slashes have special meaning */
 
 #endif /* _UAPI_LINUX_OPENAT2_H */
