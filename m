Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB19D4E46A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 20:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiCVT2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 15:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiCVT2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 15:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C8916A077
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647977238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AlcfQuo4iEbZLZjHhX48HXxSMzf0loBKLXxvGRSWBMY=;
        b=b76JIkYSaZt1XWSP5biNQ8WoUCPSy8vg4Fi/EmcksJ8AopJ0D2NsVrMd5vmOQj6w75f/fP
        EUh/8pIpUvGf6HVgN1D6+qnM78KATKKliOEZQfZZ7DL1xWtgjy5nTPE4bji1Uz+CUckMMo
        78FNRunM2CYYJ7zi2+piiEt/AV/nwHE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-pF9reMiVNbidysM5I_Gq0w-1; Tue, 22 Mar 2022 15:27:17 -0400
X-MC-Unique: pF9reMiVNbidysM5I_Gq0w-1
Received: by mail-ej1-f71.google.com with SMTP id de52-20020a1709069bf400b006dffb966922so3665485ejc.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 12:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AlcfQuo4iEbZLZjHhX48HXxSMzf0loBKLXxvGRSWBMY=;
        b=lK1Po+snFWFm+3+8S0vNr810bvkuTuCF9b0Eoal5ZZzdj375xBZuqlj4mPTd/wYIqd
         Gxcd8ZtupsYWNmPuzd1luzP/fIhkHMukHAIvP8f1LnHNFQmcemzQc02+smLDynkBAjW4
         TBJF8hHxfuTHh/LAPjHsH2iRgYxbrInwHglIznVxul/EGauLEkPVbtRWGdS5ore2I7aA
         +mQ76WPHwrkvGUGivwKCoWt2+ZQyEEQmT7HBUl3WMTdQBUiBV1TRmlMimVpoWAOPPRPd
         GiGTV1DR3dbBbV/1zkUGd4lH93m7WwkEovwpDV3mP59YfPqXM7TRjs4KDK3pIl+uDgl9
         sQAg==
X-Gm-Message-State: AOAM531xC4XDUDG7bERMLXdA/YfDtTvkNyypM7BuVCcFx9Ib2l0t58hV
        2btCcA8Orn+0ZbGboOe1ZGAOBO8T9u/pNuHKK2iRYLX8tibWEbISWauwmU/Hs4zXhvB98RYqGM3
        Qa8UmBNZm3PtBoE+thrDGMi1mTZ8K5ALDovX7lsRWF6M6kQlPJ3kLbydc7LPEduekDani1x3TJN
        2LHg==
X-Received: by 2002:a17:907:da0:b0:6df:d4a4:9d0f with SMTP id go32-20020a1709070da000b006dfd4a49d0fmr17849308ejc.407.1647977235373;
        Tue, 22 Mar 2022 12:27:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEvbJggkvnYAczGIEQ/ejTRgwZTeEY9I193ebMBVe3soDzZnhJS3SkHmWdaSlMrCCtXwFByw==
X-Received: by 2002:a17:907:da0:b0:6df:d4a4:9d0f with SMTP id go32-20020a1709070da000b006dfd4a49d0fmr17849247ejc.407.1647977234826;
        Tue, 22 Mar 2022 12:27:14 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.fixed.vodafone.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id u24-20020a1709064ad800b006d70e40bd9esm8867142ejt.15.2022.03.22.12.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 12:27:14 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: [RFC PATCH] getvalues(2) prototype
Date:   Tue, 22 Mar 2022 20:27:12 +0100
Message-Id: <20220322192712.709170-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new userspace API that allows getting multiple short values in a
single syscall.

This would be useful for the following reasons:

- Calling open/read/close for many small files is inefficient.  E.g. on my
  desktop invoking lsof(1) results in ~60k open + read + close calls under
  /proc and 90% of those are 128 bytes or less.

- Interfaces for getting various attributes and statistics are fragmented.
  For files we have basic stat, statx, extended attributes, file attributes
  (for which there are two overlapping ioctl interfaces).  For mounts and
  superblocks we have stat*fs as well as /proc/$PID/{mountinfo,mountstats}.
  The latter also has the problem on not allowing queries on a specific
  mount.

- Some attributes are cheap to generate, some are expensive.  Allowing
  userspace to select which ones it needs should allow optimizing queries.

- Adding an ascii namespace should allow easy extension and self
  description.

- The values can be text or binary, whichever is fits best.

The interface definition is:

struct name_val {
	const char *name;	/* in */
	struct iovec value_in;	/* in */
	struct iovec value_out;	/* out */
	uint32_t error;		/* out */
	uint32_t reserved;
};

int getvalues(int dfd, const char *path, struct name_val *vec, size_t num,
	      unsigned int flags);

@dfd and @path are used to lookup object $ORIGIN.  @vec contains @num
name/value descriptors.  @flags contains lookup flags for @path.

The syscall returns the number of values filled or an error.

A single name/value descriptor has the following fields:

@name describes the object whose value is to be returned.  E.g.

mnt                    - list of mount parameters
mnt:mountpoint         - the mountpoint of the mount of $ORIGIN
mntns                  - list of mount ID's reachable from the current root
mntns:21:parentid      - parent ID of the mount with ID of 21
xattr:security.selinux - the security.selinux extended attribute
data:foo/bar           - the data contained in file $ORIGIN/foo/bar

If the name starts with the separator, then it is taken to have the same
prefix as the previous name/value descriptor.  E.g. in the following
sequence of names the second one is equivalent to mnt:parentid:

mnt:mountpoint
:parentid

@value_in supplies the buffer to store value(s) in.  If a subsequent
name/value descriptor has NULL value of value_in.iov_base, then the buffer
from the previous name/value descriptor will be used.  This way it's
possible to use a shared buffer for multiple values.

The starting address and length of the actual value will be stored in
@value_out, unless an error has occurred in which case @error will be set to
the positive errno value.

Multiple names starting with the same prefix (including the shorthand form)
may also be batched together under the same lock, so the order of the names
can determine atomicity.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/Makefile                            |   2 +-
 fs/mount.h                             |   8 +
 fs/namespace.c                         |  42 ++
 fs/proc_namespace.c                    |   2 +-
 fs/values.c                            | 524 +++++++++++++++++++++++++
 6 files changed, 577 insertions(+), 2 deletions(-)
 create mode 100644 fs/values.c

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..c72668001b39 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,7 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	getvalues		sys_getvalues
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/fs/Makefile b/fs/Makefile
index 208a74e0b00e..f00d6bcd1178 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -16,7 +16,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
-		kernel_read_file.o remap_range.o
+		kernel_read_file.o remap_range.o values.o
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o direct-io.o mpage.o
diff --git a/fs/mount.h b/fs/mount.h
index 0b6e08cf8afb..a3ca5233e481 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -148,3 +148,11 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 }
 
 extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor);
+
+extern void namespace_lock_read(void);
+extern void namespace_unlock_read(void);
+extern void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt);
+extern void seq_mnt_list(struct seq_file *seq, struct mnt_namespace *ns,
+			 struct path *root);
+extern struct vfsmount *mnt_lookup_by_id(struct mnt_namespace *ns,
+					 struct path *root, int id);
diff --git a/fs/namespace.c b/fs/namespace.c
index de6fae84f1a1..52b15c17251f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1405,6 +1405,38 @@ void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor)
 }
 #endif  /* CONFIG_PROC_FS */
 
+void seq_mnt_list(struct seq_file *seq, struct mnt_namespace *ns,
+		  struct path *root)
+{
+	struct mount *m;
+
+	down_read(&namespace_sem);
+	for (m = mnt_list_next(ns, &ns->list); m; m = mnt_list_next(ns, &m->mnt_list)) {
+		if (is_path_reachable(m, m->mnt.mnt_root, root)) {
+			seq_printf(seq, "%i", m->mnt_id);
+			seq_putc(seq, '\0');
+		}
+	}
+	up_read(&namespace_sem);
+}
+
+/* called with namespace_sem held for read */
+struct vfsmount *mnt_lookup_by_id(struct mnt_namespace *ns, struct path *root,
+				  int id)
+{
+	struct mount *m;
+
+	for (m = mnt_list_next(ns, &ns->list); m; m = mnt_list_next(ns, &m->mnt_list)) {
+		if (m->mnt_id == id) {
+			if (is_path_reachable(m, m->mnt.mnt_root, root))
+				return mntget(&m->mnt);
+			else
+				return NULL;
+		}
+	}
+	return NULL;
+}
+
 /**
  * may_umount_tree - check if a mount tree is busy
  * @m: root of mount tree
@@ -1494,6 +1526,16 @@ static inline void namespace_lock(void)
 	down_write(&namespace_sem);
 }
 
+void namespace_lock_read(void)
+{
+	down_read(&namespace_sem);
+}
+
+void namespace_unlock_read(void)
+{
+	up_read(&namespace_sem);
+}
+
 enum umount_tree_flags {
 	UMOUNT_SYNC = 1,
 	UMOUNT_PROPAGATE = 2,
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 49650e54d2f8..fa6dc2c20578 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -61,7 +61,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 	return security_sb_show_options(m, sb);
 }
 
-static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
+void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
 {
 	static const struct proc_fs_opts mnt_opts[] = {
 		{ MNT_NOSUID, ",nosuid" },
diff --git a/fs/values.c b/fs/values.c
new file mode 100644
index 000000000000..618fa9bf48a1
--- /dev/null
+++ b/fs/values.c
@@ -0,0 +1,524 @@
+#include <linux/syscalls.h>
+#include <linux/printk.h>
+#include <linux/namei.h>
+#include <linux/fs_struct.h>
+#include <linux/posix_acl_xattr.h>
+#include <linux/xattr.h>
+#include "pnode.h"
+#include "internal.h"
+
+#define VAL_GRSEP ':'
+
+struct name_val {
+	const char __user *name;	/* in */
+	struct iovec value_in;		/* in */
+	struct iovec value_out;		/* out */
+	__u32 error;			/* out */
+	__u32 reserved;
+};
+
+struct val_iter {
+	struct name_val __user *curr;
+	size_t num;
+	struct iovec vec;
+	char name[256];
+	size_t bufsize;
+	struct seq_file seq;
+	const char *prefix;
+	const char *sub;
+};
+
+struct val_desc {
+	const char *name;
+	union {
+		int idx;
+		int (*get)(struct val_iter *vi, const struct path *path);
+	};
+};
+
+static int val_get(struct val_iter *vi)
+{
+	struct name_val nameval;
+	long err;
+
+	if (copy_from_user(&nameval, vi->curr, sizeof(nameval)))
+		return -EFAULT;
+
+	err = strncpy_from_user(vi->name, nameval.name, sizeof(vi->name));
+	if (err < 0)
+		return err;
+	if (err == sizeof(vi->name))
+		return -ERANGE;
+
+	if (nameval.value_in.iov_base)
+		vi->vec = nameval.value_in;
+
+	vi->seq.size = min(vi->vec.iov_len, vi->bufsize);
+	vi->seq.count = 0;
+
+	return 0;
+}
+
+static int val_next(struct val_iter *vi)
+{
+	vi->curr++;
+	vi->num--;
+
+	return vi->num ? val_get(vi) : 0;
+}
+
+static int val_end(struct val_iter *vi, size_t count)
+{
+	struct iovec iov = {
+		.iov_base = vi->vec.iov_base,
+		.iov_len = count,
+	};
+
+	if (copy_to_user(&vi->curr->value_out, &iov, sizeof(iov)))
+		return -EFAULT;
+
+	vi->vec.iov_base += count;
+	vi->vec.iov_len -= count;
+
+	return val_next(vi);
+}
+
+static int val_err(struct val_iter *vi, int err)
+{
+	if (put_user(-err, &vi->curr->error))
+		return -EFAULT;
+
+	return val_next(vi);
+}
+
+static int val_end_seq(struct val_iter *vi, int err)
+{
+	size_t count = vi->seq.count;
+
+	if (err)
+		return val_err(vi, err);
+
+	if (count == vi->seq.size)
+		return -EOVERFLOW;
+
+	if (copy_to_user(vi->vec.iov_base, vi->seq.buf, count))
+		return -EFAULT;
+
+	return val_end(vi, count);
+}
+
+static struct val_desc *val_lookup(struct val_iter *vi, struct val_desc *vd)
+{
+	const char *name = vi->name;
+	const char *prefix = vi->prefix;
+	size_t prefixlen = strlen(prefix);
+
+	if (prefixlen) {
+		/*
+		 * Name beggining with a group separator is a shorthand for
+		 * previously prefix.
+		 */
+		if (name[0] == VAL_GRSEP) {
+			name++;
+		} else  {
+			if (strncmp(name, prefix, prefixlen) != 0)
+				return NULL;
+			name += prefixlen;
+		}
+	}
+
+	vi->sub = NULL;
+	for (; vd->name; vd++) {
+		if (strcmp(name, vd->name) == 0)
+			break;
+		else {
+			size_t grlen = strlen(vd->name);
+
+			if (strncmp(vd->name, name, grlen) == 0 &&
+			    name[grlen] == VAL_GRSEP) {
+				vi->sub = name + grlen + 1;
+				break;
+			}
+		}
+	}
+	return vd;
+}
+
+static int val_get_group(struct val_iter *vi, struct val_desc *vd)
+{
+	for (; vd->name; vd++)
+		seq_write(&vi->seq, vd->name, strlen(vd->name) + 1);
+
+	return val_end_seq(vi, 0);
+}
+
+static bool val_push_prefix(struct val_iter *vi, const char **oldprefix)
+{
+	char *newprefix;
+
+	newprefix = kmemdup_nul(vi->name, vi->sub - vi->name, GFP_KERNEL);
+	if (newprefix) {
+		*oldprefix = vi->prefix;
+		vi->prefix = newprefix;
+	}
+
+	return newprefix;
+}
+
+static void val_pop_prefix(struct val_iter *vi, const char *oldprefix)
+{
+	kfree(vi->prefix);
+	vi->prefix = oldprefix;
+}
+
+enum {
+	VAL_MNT_ID,
+	VAL_MNT_PARENTID,
+	VAL_MNT_ROOT,
+	VAL_MNT_MOUNTPOINT,
+	VAL_MNT_OPTIONS,
+	VAL_MNT_SHARED,
+	VAL_MNT_MASTER,
+	VAL_MNT_PROPAGATE_FROM,
+	VAL_MNT_UNBINDABLE,
+	VAL_MNT_NOTFOUND,
+};
+
+static struct val_desc val_mnt_group[] = {
+	{ .name = "id",			.idx = VAL_MNT_ID		},
+	{ .name = "parentid",		.idx = VAL_MNT_PARENTID,	},
+	{ .name = "root",		.idx = VAL_MNT_ROOT,		},
+	{ .name = "mountpoint",		.idx = VAL_MNT_MOUNTPOINT,	},
+	{ .name = "options",		.idx = VAL_MNT_OPTIONS,		},
+	{ .name = "shared",		.idx = VAL_MNT_SHARED,		},
+	{ .name = "master",		.idx = VAL_MNT_MASTER,		},
+	{ .name = "propagate_from",	.idx = VAL_MNT_PROPAGATE_FROM,	},
+	{ .name = "unbindable",		.idx = VAL_MNT_UNBINDABLE,	},
+	{ .name = NULL,			.idx = VAL_MNT_NOTFOUND		},
+};
+
+static int seq_mnt_root(struct seq_file *seq, struct vfsmount *mnt)
+{
+	struct super_block *sb = mnt->mnt_sb;
+	int err = 0;
+
+	if (sb->s_op->show_path) {
+		err = sb->s_op->show_path(seq, mnt->mnt_root);
+		if (!err) {
+			seq_putc(seq, '\0');
+			if (seq->count < seq->size)
+				seq->count = string_unescape(seq->buf, seq->buf, seq->size, UNESCAPE_OCTAL);
+		}
+	} else {
+		seq_dentry(seq, mnt->mnt_root, "");
+	}
+
+	return err;
+}
+
+static int val_mnt_show(struct val_iter *vi, struct vfsmount *mnt)
+{
+	struct mount *m = real_mount(mnt);
+	struct path root, mnt_path;
+	struct val_desc *vd;
+	const char *oldprefix;
+	int err = 0;
+
+	if (!val_push_prefix(vi, &oldprefix))
+		return -ENOMEM;
+
+	while (!err && vi->num) {
+		vd = val_lookup(vi, val_mnt_group);
+		if (!vd)
+			break;
+
+		switch(vd->idx) {
+		case VAL_MNT_ID:
+			seq_printf(&vi->seq, "%i", m->mnt_id);
+			break;
+		case VAL_MNT_PARENTID:
+			seq_printf(&vi->seq, "%i", m->mnt_parent->mnt_id);
+			break;
+		case VAL_MNT_ROOT:
+			seq_mnt_root(&vi->seq, mnt);
+			break;
+		case VAL_MNT_MOUNTPOINT:
+			get_fs_root(current->fs, &root);
+			mnt_path.dentry = mnt->mnt_root;
+			mnt_path.mnt = mnt;
+			err = seq_path_root(&vi->seq, &mnt_path, &root, "");
+			path_put(&root);
+			break;
+		case VAL_MNT_OPTIONS:
+			seq_puts(&vi->seq, mnt->mnt_flags & MNT_READONLY ? "ro" : "rw");
+			show_mnt_opts(&vi->seq, mnt);
+			break;
+		case VAL_MNT_SHARED:
+			if (IS_MNT_SHARED(m))
+				seq_printf(&vi->seq, "%i,", m->mnt_group_id);
+			break;
+		case VAL_MNT_MASTER:
+			if (IS_MNT_SLAVE(m))
+				seq_printf(&vi->seq, "%i,",
+					   m->mnt_master->mnt_group_id);
+			break;
+		case VAL_MNT_PROPAGATE_FROM:
+			if (IS_MNT_SLAVE(m)) {
+				int dom;
+
+				get_fs_root(current->fs, &root);
+				dom = get_dominating_id(m, &root);
+				path_put(&root);
+				if (dom)
+					seq_printf(&vi->seq, "%i,", dom);
+			}
+			break;
+		case VAL_MNT_UNBINDABLE:
+			if (IS_MNT_UNBINDABLE(m))
+				seq_puts(&vi->seq, "yes");
+			break;
+		default:
+			err = -ENOENT;
+			break;
+		}
+		err = val_end_seq(vi, err);
+	}
+	val_pop_prefix(vi, oldprefix);
+
+	return err;
+}
+
+static int val_mnt_get(struct val_iter *vi, const struct path *path)
+{
+	int err;
+
+	if (!vi->sub)
+		return val_get_group(vi, val_mnt_group);
+
+	namespace_lock_read();
+	err = val_mnt_show(vi, path->mnt);
+	namespace_unlock_read();
+
+	return err;
+}
+
+static int val_mntns_get(struct val_iter *vi, const struct path *path)
+{
+	struct mnt_namespace *mnt_ns = current->nsproxy->mnt_ns;
+	struct vfsmount *mnt;
+	struct path root;
+	char *end;
+	int mnt_id;
+	int err;
+
+	if (!vi->sub) {
+		get_fs_root(current->fs, &root);
+		seq_mnt_list(&vi->seq, mnt_ns, &root);
+		path_put(&root);
+		return val_end_seq(vi, 0);
+	}
+
+	end = strchr(vi->sub, VAL_GRSEP);
+	if (end)
+		*end = '\0';
+	err = kstrtoint(vi->sub, 10, &mnt_id);
+	if (err)
+		return val_err(vi, err);
+	vi->sub = NULL;
+	if (end) {
+		*end = VAL_GRSEP;
+		vi->sub = end + 1;
+	}
+
+	namespace_lock_read();
+	get_fs_root(current->fs, &root);
+	mnt = mnt_lookup_by_id(mnt_ns, &root, mnt_id);
+	path_put(&root);
+	if (!mnt) {
+		namespace_unlock_read();
+		return val_err(vi, -ENOENT);
+	}
+	if (vi->sub)
+		err = val_mnt_show(vi, mnt);
+	else
+		err = val_get_group(vi, val_mnt_group);
+
+	namespace_unlock_read();
+	mntput(mnt);
+
+	return err;
+}
+
+static ssize_t val_do_read(struct val_iter *vi, struct path *path)
+{
+	ssize_t ret;
+	struct file *file;
+	struct open_flags op = {
+		.open_flag = O_RDONLY,
+		.acc_mode = MAY_READ,
+		.intent = LOOKUP_OPEN,
+	};
+
+	file = do_file_open_root(path, "", &op);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ret = vfs_read(file, vi->vec.iov_base, vi->vec.iov_len, NULL);
+	fput(file);
+
+	return ret;
+}
+
+static ssize_t val_do_readlink(struct val_iter *vi, struct path *path)
+{
+	int ret;
+
+	ret = security_inode_readlink(path->dentry);
+	if (ret)
+		return ret;
+
+	return vfs_readlink(path->dentry, vi->vec.iov_base, vi->vec.iov_len);
+}
+
+static inline bool dot_or_dotdot(const char *s)
+{
+	return s[0] == '.' &&
+		(s[1] == '/' || s[1] == '\0' ||
+		 (s[1] == '.' && (s[2] == '/' || s[2] == '\0')));
+}
+
+/*
+ * - empty path is okay
+ * - must not begin or end with slash or have a double slash anywhere
+ * - must not have . or .. components
+ */
+static bool val_verify_path(const char *subpath)
+{
+	const char *s = subpath;
+
+	if (s[0] == '\0')
+		return true;
+
+	if (s[0] == '/' || s[strlen(s) - 1] == '/' || strstr(s, "//"))
+		return false;
+
+	for (s--; s; s = strstr(s + 3, "/."))
+		if (dot_or_dotdot(s + 1))
+			return false;
+
+	return true;
+}
+
+static int val_data_get(struct val_iter *vi, const struct path *path)
+{
+	struct path this;
+	ssize_t ret;
+
+	if (!vi->sub)
+		return val_err(vi, -ENOENT);
+
+	if (!val_verify_path(vi->sub))
+		return val_err(vi, -EINVAL);
+
+	ret = vfs_path_lookup(path->dentry, path->mnt, vi->sub,
+			      LOOKUP_NO_XDEV | LOOKUP_BENEATH |
+			      LOOKUP_IN_ROOT, &this);
+	if (ret)
+		return val_err(vi, ret);
+
+	ret = -ENODATA;
+	if (d_is_reg(this.dentry) || d_is_symlink(this.dentry)) {
+		if (d_is_reg(this.dentry))
+			ret = val_do_read(vi, &this);
+		else
+			ret = val_do_readlink(vi, &this);
+	}
+	path_put(&this);
+	if (ret == -EFAULT)
+		return ret;
+	if (ret < 0)
+		return val_err(vi, ret);
+	if (ret == vi->vec.iov_len)
+		return -EOVERFLOW;
+
+	return val_end(vi, ret);
+}
+
+static int val_xattr_get(struct val_iter *vi, const struct path *path)
+{
+	ssize_t ret;
+	struct user_namespace *mnt_userns = mnt_user_ns(path->mnt);
+	void *value = vi->seq.buf + vi->seq.count;
+	size_t size = min_t(size_t, vi->seq.size - vi->seq.count,
+			    XATTR_SIZE_MAX);
+
+	if (!vi->sub)
+		return val_err(vi, -ENOENT);
+
+	ret = vfs_getxattr(mnt_userns, path->dentry, vi->sub, value, size);
+	if (ret < 0)
+		return val_err(vi, ret);
+
+	if ((strcmp(vi->sub, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
+	    (strcmp(vi->sub, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
+		posix_acl_fix_xattr_to_user(mnt_userns, value, ret);
+
+	vi->seq.count += ret;
+
+	return val_end_seq(vi, 0);
+}
+
+
+static struct val_desc val_toplevel_group[] = {
+	{ .name = "mnt",	.get = val_mnt_get,	},
+	{ .name = "mntns",	.get = val_mntns_get,	},
+	{ .name = "xattr",	.get = val_xattr_get,	},
+	{ .name = "data",	.get = val_data_get,	},
+	{ .name = NULL },
+};
+
+SYSCALL_DEFINE5(getvalues,
+		int, dfd,
+		const char __user *, pathname,
+		struct name_val __user *, vec,
+		size_t, num,
+		unsigned int, flags)
+{
+	char vals[1024];
+	struct val_iter vi = {
+		.curr = vec,
+		.num = num,
+		.seq.buf = vals,
+		.bufsize = sizeof(vals),
+		.prefix = "",
+	};
+	struct val_desc *vd;
+	struct path path = {};
+	ssize_t err;
+
+	err = user_path_at(dfd, pathname, 0, &path);
+	if (err)
+		return err;
+
+	err = val_get(&vi);
+	if (err)
+		goto out;
+
+	if (!strlen(vi.name)) {
+		err = val_get_group(&vi, val_toplevel_group);
+		goto out;
+	}
+	while (!err && vi.num) {
+		vd = val_lookup(&vi, val_toplevel_group);
+		if (!vd->name)
+			err = val_err(&vi, -ENOENT);
+		else
+			err = vd->get(&vi, &path);
+	}
+out:
+	if (err == -EOVERFLOW)
+		err = 0;
+
+	path_put(&path);
+	return err < 0 ? err : num - vi.num;
+}
-- 
2.35.1

