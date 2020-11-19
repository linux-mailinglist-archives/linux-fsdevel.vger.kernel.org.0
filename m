Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8152B9499
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 15:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgKSO1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 09:27:08 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:58540 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbgKSO1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:27:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id C7938181E21C3;
        Thu, 19 Nov 2020 15:18:28 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vuGU_PlldUSR; Thu, 19 Nov 2020 15:18:27 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O_yPa03onSx9; Thu, 19 Nov 2020 15:18:27 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/5] fuse: Implement MUSE: MTD in userspace
Date:   Thu, 19 Nov 2020 15:16:59 +0100
Message-Id: <20201119141659.26176-6-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201119141659.26176-1-richard@nod.at>
References: <20201119141659.26176-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

MUSE allows implementing a MTD in userspace.
So far userspace has control over mtd_read, mtd_write, mtd_erase,
and mtd_sync.
It can also set the following MTD parameters:
name, flags, site, writesize and erasesize.

That way advanced simulators for many type of flashes
can be implemented in userspace.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/fuse/Kconfig           |  11 +
 fs/fuse/Makefile          |   1 +
 fs/fuse/muse.c            | 450 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |  25 ++-
 4 files changed, 486 insertions(+), 1 deletion(-)
 create mode 100644 fs/fuse/muse.c

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 9c8cc1e7b3a5..2fc63dc18a53 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -56,3 +56,14 @@ config FUSE_DAX
=20
 	  If you want to allow mounting a Virtio Filesystem with the "dax"
 	  option, answer Y.
+
+config MUSE
+	tristate "Memory Technology Device (MTD) in Userspace support"
+	depends on FUSE_FS
+	select FUSE_HELPER
+	select MTD
+	help
+	  This FUSE extension allows an MTD to be implemented in userspace.
+
+	  If you want to develop or use a userspace MTD based on MUSE,
+	  answer Y or M.
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 7a5768cce6be..67a7af3fb047 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_FUSE_FS) +=3D fuse.o
 obj-$(CONFIG_CUSE) +=3D cuse.o
 obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
+obj-$(CONFIG_MUSE) +=3D muse.o
=20
 fuse-y :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o
 fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
diff --git a/fs/fuse/muse.c b/fs/fuse/muse.c
new file mode 100644
index 000000000000..249907be9d98
--- /dev/null
+++ b/fs/fuse/muse.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MUSE: MTD in userspace
+ * Copyright (C) 2020 sigma star gmbh
+ * Author: Richard Weinberger <richard@nod.at>
+ */
+
+#define pr_fmt(fmt) "MUSE: " fmt
+
+#include <linux/anon_inodes.h>
+#include <linux/fuse.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/slab.h>
+
+#include "fuse_i.h"
+
+static struct file_operations muse_ctrl_fops;
+
+struct muse_conn {
+	struct fuse_mount fm;
+	struct fuse_conn fc;
+	struct fuse_file *ff;
+	struct mtd_info mtd;
+	struct file *dummy_file;
+	bool init_done;
+};
+
+struct muse_init_args {
+	struct fuse_args_pages ap;
+	struct muse_init_in in;
+	struct muse_init_out out;
+	struct page *page;
+	struct fuse_page_desc desc;
+};
+
+static int dummy_file_open(struct inode *inode, struct file *filp)
+{
+	WARN_ON_ONCE(1);
+	return -EIO;
+}
+
+static const struct file_operations dummy_file_ops =3D {
+	.open =3D dummy_file_open,
+};
+
+static void muse_fc_release(struct fuse_conn *fc)
+{
+	struct muse_conn *mc =3D container_of(fc, struct muse_conn, fc);
+
+	fput(mc->dummy_file);
+	kfree_rcu(mc, fc.rcu);
+}
+
+static int muse_mtd_erase(struct mtd_info *mtd, struct erase_info *instr=
)
+{
+	struct muse_conn *mc =3D mtd->priv;
+	struct fuse_mount *fm =3D &mc->fm;
+	struct muse_erase_in inarg;
+	FUSE_ARGS(args);
+
+	inarg.addr =3D instr->addr;
+	inarg.len =3D instr->len;
+
+	args.opcode =3D MUSE_ERASE;
+	args.nodeid =3D mc->ff->nodeid;
+	args.in_numargs =3D 1;
+	args.in_args[0].size =3D sizeof(inarg);
+	args.in_args[0].value =3D &inarg;
+
+	return fuse_simple_request(fm, &args);
+}
+
+static void muse_mtd_sync(struct mtd_info *mtd)
+{
+	struct muse_conn *mc =3D mtd->priv;
+	struct fuse_mount *fm =3D &mc->fm;
+	struct fuse_fsync_in inarg;
+	FUSE_ARGS(args);
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.fh =3D mc->ff->fh;
+	inarg.fsync_flags =3D 0;
+
+	/*
+	 * We reuse FUSE_FSYNC to sync the whole MTD.
+	 */
+	args.opcode =3D FUSE_FSYNC;
+	args.nodeid =3D mc->ff->nodeid;
+	args.in_numargs =3D 1;
+	args.in_args[0].size =3D sizeof(inarg);
+	args.in_args[0].value =3D &inarg;
+
+	fuse_simple_request(fm, &args);
+}
+
+static int do_dio(struct kiocb *kiocb, struct iov_iter *iter, loff_t *po=
s, int flags)
+{
+	struct fuse_io_priv io =3D FUSE_IO_PRIV_SYNC(kiocb);
+
+	return fuse_direct_io(&io, iter, pos, flags);
+}
+
+static int muse_mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
+			 size_t *retlen, u_char *buf)
+{
+	struct kvec iov =3D { .iov_base =3D buf, .iov_len =3D len };
+	struct muse_conn *mc =3D mtd->priv;
+	struct kiocb kiocb;
+	struct iov_iter to;
+	loff_t pos =3D from;
+	int ret;
+
+	iov_iter_kvec(&to, READ, &iov, 1, len);
+	init_sync_kiocb(&kiocb, mc->dummy_file);
+
+	ret =3D do_dio(&kiocb, &to, &pos, FUSE_DIO_NOFS);
+
+	*retlen =3D len;
+	return len;
+}
+
+static int muse_mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
+			  size_t *retlen, const u_char *buf)
+{
+	struct kvec iov =3D { .iov_base =3D (u_char *)buf, .iov_len =3D len };
+	struct muse_conn *mc =3D mtd->priv;
+	struct iov_iter from;
+	struct kiocb kiocb;
+	loff_t pos =3D to;
+	int ret;
+
+	iov_iter_kvec(&from, WRITE, &iov, 1, len);
+	init_sync_kiocb(&kiocb, mc->dummy_file);
+
+	ret =3D do_dio(&kiocb, &from, &pos, FUSE_DIO_WRITE | FUSE_DIO_NOFS);
+
+	*retlen =3D len;
+	return 0;
+}
+
+static int muse_mtd_get_device(struct mtd_info *mtd)
+{
+	struct muse_conn *mc =3D mtd->priv;
+
+	fuse_conn_get(&mc->fc);
+
+	return 0;
+}
+
+static void muse_mtd_put_device(struct mtd_info *mtd)
+{
+	struct muse_conn *mc =3D mtd->priv;
+
+	fuse_conn_put(&mc->fc);
+}
+
+struct mtdreq {
+	const char *name;
+	struct mtd_info_user mi;
+};
+
+static int muse_parse_mtdreq(char *p, size_t len, struct mtd_info *mtd)
+{
+	struct mtdreq req =3D {};
+	char *end =3D p + len;
+	char *key, *val;
+	int ret;
+
+        for (;;) {
+                ret =3D fuse_kv_parse_one(&p, end, &key, &val);
+		if (ret < 0)
+			goto out;
+		if (!ret)
+			break;
+
+		if (strcmp(key, "NAME") =3D=3D 0) {
+			req.name =3D val;
+		} else if (strcmp(key, "TYPE") =3D=3D 0) {
+			req.mi.type =3D (uint8_t)simple_strtoul(val, NULL, 10);
+		} else if (strcmp(key, "FLAGS") =3D=3D 0) {
+			req.mi.flags =3D simple_strtoul(val, NULL, 10);
+		} else if (strcmp(key, "SIZE") =3D=3D 0) {
+			req.mi.size =3D simple_strtoul(val, NULL, 10);
+		} else if (strcmp(key, "WRITESIZE") =3D=3D 0) {
+			req.mi.writesize =3D simple_strtoul(val, NULL, 10);
+		} else if (strcmp(key, "ERASESIZE") =3D=3D 0) {
+			req.mi.erasesize =3D simple_strtoul(val, NULL, 10);
+		} else {
+			pr_warn("Ignoring unknown MTD param \"%s\"\n", key);
+		}
+	}
+
+	ret =3D -EINVAL;
+
+	if (!req.name)
+		goto out;
+
+	if (!req.mi.size || !req.mi.writesize || !req.mi.erasesize)
+		goto out;
+
+	if (req.mi.size % req.mi.writesize)
+		goto out;
+
+	if (req.mi.size % req.mi.erasesize)
+		goto out;
+
+	if (req.mi.flags & ~(MTD_WRITEABLE | MTD_BIT_WRITEABLE | MTD_NO_ERASE))
+		goto out;
+
+	if (req.mi.type =3D=3D MTD_ABSENT || req.mi.type =3D=3D MTD_UBIVOLUME)
+		goto out;
+
+	mtd->name =3D kstrdup(req.name, GFP_KERNEL);
+	if (!mtd->name) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	mtd->size =3D req.mi.size;
+	mtd->erasesize =3D req.mi.erasesize;
+	mtd->writesize =3D req.mi.writesize;
+	mtd->writebufsize =3D mtd->writesize;
+	mtd->type =3D req.mi.type;
+	mtd->flags =3D MTD_MUSE | req.mi.flags;
+
+	ret =3D 0;
+out:
+	return ret;
+}
+
+static void muse_process_init_reply(struct fuse_mount *fm,
+				    struct fuse_args *args, int error)
+{
+	struct fuse_conn *fc =3D fm->fc;
+	struct muse_init_args *ia =3D container_of(args, struct muse_init_args,=
 ap.args);
+	struct muse_conn *mc =3D container_of(fc, struct muse_conn, fc);
+	struct fuse_args_pages *ap =3D &ia->ap;
+	struct muse_init_out *arg =3D &ia->out;
+	struct page *page =3D ap->pages[0];
+	int ret;
+
+	if (error || arg->fuse_major !=3D FUSE_KERNEL_VERSION || arg->fuse_mino=
r < 33) {
+		goto abort;
+	}
+
+	fc->minor =3D arg->fuse_minor;
+	fc->max_read =3D max_t(unsigned int, arg->max_read, 4096);
+	fc->max_write =3D max_t(unsigned int, arg->max_write, 4096);
+
+        ret =3D muse_parse_mtdreq(page_address(page), ap->args.out_args[=
1].size,
+				&mc->mtd);
+	if (ret)
+		goto abort;
+
+	mc->ff =3D fuse_file_alloc(fm);
+	if (!mc->ff)
+		goto abort;
+
+	/*
+	 * HACK:
+	 * fuse_direct_io() expects a file object.
+	 */
+	mc->dummy_file =3D anon_inode_getfile("[muse]", &dummy_file_ops, NULL, =
O_RDWR);
+	if (!mc->dummy_file)
+		goto abort_free_ff;
+
+	mc->dummy_file->private_data =3D mc->ff;
+
+	mc->ff->fh =3D 0;
+	mc->ff->open_flags =3D FOPEN_DIRECT_IO;
+
+	/*
+	 * With MUSE there are no files, so we use one fuse file for the mtd ob=
ject
+	 * with nodeid FUSE_ROOT_ID.
+	 */
+	mc->ff->nodeid =3D FUSE_ROOT_ID;
+
+	mc->mtd._erase =3D muse_mtd_erase;
+	mc->mtd._read =3D muse_mtd_read;
+	mc->mtd._sync =3D muse_mtd_sync;
+	mc->mtd._write =3D muse_mtd_write;
+	mc->mtd._get_device =3D muse_mtd_get_device;
+	mc->mtd._put_device =3D muse_mtd_put_device;
+	mc->mtd.priv =3D mc;
+	mc->mtd.owner =3D THIS_MODULE;
+
+	/*
+	 * We want one READ/WRITE op per MTD io. So the MTD pagesize needs
+	 * to fit into max_write/max_read:
+	 */
+	if (fc->max_write < mc->mtd.writesize || fc->max_read < mc->mtd.writesi=
ze)
+		goto abort_put_file;
+
+	if (mtd_device_register(&mc->mtd, NULL, 0) !=3D 0)
+		goto abort_put_file;
+
+	mc->init_done =3D true;
+
+	kfree(ia);
+	__free_page(page);
+	return;
+
+abort_put_file:
+	fput(mc->dummy_file);
+abort_free_ff:
+	fuse_file_free(mc->ff);
+abort:
+	fuse_abort_conn(fc);
+}
+
+static int muse_send_init(struct muse_conn *mc)
+{
+	struct fuse_mount *fm =3D &mc->fm;
+	struct fuse_args_pages *ap;
+	struct muse_init_args *ia;
+	struct page *page;
+	int ret =3D -ENOMEM;
+
+	BUILD_BUG_ON(MUSE_INIT_INFO_MAX > PAGE_SIZE);
+
+	page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
+		goto err;
+
+	ia =3D kzalloc(sizeof(*ia), GFP_KERNEL);
+	if (!ia)
+		goto err_page;
+
+	ap =3D &ia->ap;
+	ia->in.fuse_major =3D FUSE_KERNEL_VERSION;
+	ia->in.fuse_minor =3D FUSE_KERNEL_MINOR_VERSION;
+	ap->args.opcode =3D MUSE_INIT;
+	ap->args.in_numargs =3D 1;
+	ap->args.in_args[0].size =3D sizeof(ia->in);
+	ap->args.in_args[0].value =3D &ia->in;
+	ap->args.out_numargs =3D 2;
+	ap->args.out_args[0].size =3D sizeof(ia->out);
+	ap->args.out_args[0].value =3D &ia->out;
+	ap->args.out_args[1].size =3D MUSE_INIT_INFO_MAX;
+	ap->args.out_argvar =3D true;
+	ap->args.out_pages =3D true;
+	ap->num_pages =3D 1;
+	ap->pages =3D &ia->page;
+	ap->descs =3D &ia->desc;
+	ia->page =3D page;
+	ia->desc.length =3D ap->args.out_args[1].size;
+	ap->args.end =3D muse_process_init_reply;
+
+	ret =3D fuse_simple_background(fm, &ap->args, GFP_KERNEL);
+	if (ret)
+		goto err_ia;
+
+	return 0;
+
+err_ia:
+	kfree(ia);
+err_page:
+	__free_page(page);
+err:
+	return ret;
+}
+
+static int muse_ctrl_open(struct inode *inode, struct file *file)
+{
+	struct muse_conn *mc;
+	struct fuse_dev *fud;
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		ret =3D -EPERM;
+		goto err;
+	}
+
+	mc =3D kzalloc(sizeof(*mc), GFP_KERNEL);
+	if (!mc) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	fuse_conn_init(&mc->fc, &mc->fm, get_user_ns(&init_user_ns),
+		       &fuse_dev_fiq_ops, NULL);
+
+	fud =3D fuse_dev_alloc_install(&mc->fc);
+	if (!fud) {
+		ret =3D -ENOMEM;
+		goto err_free;
+	}
+
+	mc->fc.release =3D muse_fc_release;
+	mc->fc.initialized =3D 1;
+
+	ret =3D muse_send_init(mc);
+	if (ret)
+		goto err_dev;
+
+	file->private_data =3D fud;
+
+	return 0;
+
+err_dev:
+	fuse_dev_free(fud);
+	fuse_conn_put(&mc->fc);
+err_free:
+	kfree(mc);
+err:
+	return ret;
+}
+
+static int muse_ctrl_release(struct inode *inode, struct file *file)
+{
+	struct fuse_dev *fud =3D file->private_data;
+	struct muse_conn *mc =3D container_of(fud->fc, struct muse_conn, fc);
+
+	if (mc->init_done)
+		mtd_device_unregister(&mc->mtd);
+
+	fuse_conn_put(&mc->fc);
+
+	return fuse_dev_release(inode, file);
+}
+
+static struct miscdevice muse_ctrl_dev =3D {
+	.minor =3D MISC_DYNAMIC_MINOR,
+	.name  =3D "muse",
+	.fops =3D &muse_ctrl_fops,
+};
+
+static int __init muse_init(void)
+{
+	muse_ctrl_fops =3D fuse_dev_operations;
+	muse_ctrl_fops.owner =3D THIS_MODULE;
+	muse_ctrl_fops.open =3D muse_ctrl_open;
+	muse_ctrl_fops.release =3D muse_ctrl_release;
+
+	return misc_register(&muse_ctrl_dev);
+}
+
+static void __exit muse_exit(void)
+{
+	misc_deregister(&muse_ctrl_dev);
+}
+
+module_init(muse_init);
+module_exit(muse_exit);
+
+MODULE_AUTHOR("Richard Weinberger <richard@nod.at>");
+MODULE_DESCRIPTION("MTD in userspace");
+MODULE_LICENSE("GPLv2");
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 7233502ea991..7862c6df7e63 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -210,7 +210,7 @@
 #define FUSE_KERNEL_VERSION 7
=20
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 32
+#define FUSE_KERNEL_MINOR_VERSION 33
=20
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -483,6 +483,10 @@ enum fuse_opcode {
 	/* CUSE specific operations */
 	CUSE_INIT		=3D 4096,
=20
+	/* MUSE specific operations */
+	MUSE_INIT		=3D 8192,
+	MUSE_ERASE		=3D 8193,
+
 	/* Reserved opcodes: helpful to detect structure endian-ness */
 	CUSE_INIT_BSWAP_RESERVED	=3D 1048576,	/* CUSE_INIT << 8 */
 	FUSE_INIT_BSWAP_RESERVED	=3D 436207616,	/* FUSE_INIT << 24 */
@@ -936,4 +940,23 @@ struct fuse_removemapping_one {
 #define FUSE_REMOVEMAPPING_MAX_ENTRY   \
 		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
=20
+#define MUSE_INIT_INFO_MAX 4096
+
+struct muse_init_in {
+	uint32_t	fuse_major;
+	uint32_t	fuse_minor;
+};
+
+struct muse_init_out {
+	uint32_t	fuse_major;
+	uint32_t	fuse_minor;
+	uint32_t	max_read;
+	uint32_t	max_write;
+};
+
+struct muse_erase_in {
+	uint64_t	addr;
+	uint64_t	len;
+};
+
 #endif /* _LINUX_FUSE_H */
--=20
2.26.2

