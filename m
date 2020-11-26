Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D017A2C5E37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 00:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403983AbgKZXdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 18:33:47 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:55398 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391977AbgKZXdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 18:33:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 69AA9181C8918;
        Fri, 27 Nov 2020 00:33:41 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id y0WI_39iVq3Y; Fri, 27 Nov 2020 00:33:40 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4muHbyB312yT; Fri, 27 Nov 2020 00:33:39 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 6/7] fuse: Implement MUSE: MTD in userspace
Date:   Fri, 27 Nov 2020 00:32:59 +0100
Message-Id: <20201126233300.10714-7-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201126233300.10714-1-richard@nod.at>
References: <20201126233300.10714-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

MUSE allows implementing a MTD in userspace.
So far userspace has control over mtd_read, mtd_write, mtd_erase,
mtd_block_isbad, mtd_block_markbad, and mtd_sync.
It can also set the following MTD parameters:
name, flags, site, writesize and erasesize.

That way advanced simulators for many type of flashes
can be implemented in userspace.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/fuse/Kconfig  |  11 +
 fs/fuse/Makefile |   1 +
 fs/fuse/muse.c   | 730 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 742 insertions(+)
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
index 000000000000..b947f5aa2e1c
--- /dev/null
+++ b/fs/fuse/muse.c
@@ -0,0 +1,730 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MUSE: MTD in userspace
+ * Copyright (C) 2020 sigma star gmbh
+ * Author: Richard Weinberger <richard@nod.at>
+ */
+
+#define pr_fmt(fmt) "MUSE: " fmt
+
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
+/*
+ * struct muse_conn - MUSE connection object.
+ *
+ * @fm: FUSE mount object.
+ * @fc: FUSE connection object.
+ * @mtd: MTD object.
+ * @init_done: true when the MTD was registered.
+ *
+ * Describes a connection to a userspace server.
+ * Each connection implements a single MTD.
+ */
+struct muse_conn {
+	struct fuse_mount fm;
+	struct fuse_conn fc;
+	struct mtd_info mtd;
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
+static void muse_fc_release(struct fuse_conn *fc)
+{
+	struct muse_conn *mc =3D container_of(fc, struct muse_conn, fc);
+
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
+	ssize_t ret;
+
+	inarg.addr =3D instr->addr;
+	inarg.len =3D instr->len;
+
+	args.opcode =3D MUSE_ERASE;
+	args.nodeid =3D FUSE_ROOT_ID;
+	args.in_numargs =3D 1;
+	args.in_args[0].size =3D sizeof(inarg);
+	args.in_args[0].value =3D &inarg;
+
+	ret =3D fuse_simple_request(fm, &args);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int muse_mtd_markbad(struct mtd_info *mtd, loff_t addr)
+{
+	struct muse_conn *mc =3D mtd->priv;
+	struct fuse_mount *fm =3D &mc->fm;
+	struct muse_markbad_in inarg;
+	FUSE_ARGS(args);
+	ssize_t ret;
+
+	inarg.addr =3D addr;
+
+	args.opcode =3D MUSE_MARKBAD;
+	args.nodeid =3D FUSE_ROOT_ID;
+	args.in_numargs =3D 1;
+	args.in_args[0].size =3D sizeof(inarg);
+	args.in_args[0].value =3D &inarg;
+
+	ret =3D fuse_simple_request(fm, &args);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int muse_mtd_isbad(struct mtd_info *mtd, loff_t addr)
+{
+	struct muse_conn *mc =3D mtd->priv;
+	struct fuse_mount *fm =3D &mc->fm;
+	struct muse_isbad_in inarg;
+	struct muse_isbad_out outarg;
+	FUSE_ARGS(args);
+	ssize_t ret;
+
+	inarg.addr =3D addr;
+
+	args.opcode =3D MUSE_ISBAD;
+	args.nodeid =3D FUSE_ROOT_ID;
+	args.in_numargs =3D 1;
+	args.in_args[0].size =3D sizeof(inarg);
+	args.in_args[0].value =3D &inarg;
+	args.out_numargs =3D 1;
+	args.out_args[0].size =3D sizeof(outarg);
+	args.out_args[0].value =3D &outarg;
+
+	ret =3D fuse_simple_request(fm, &args);
+	if (ret < 0)
+		return ret;
+
+	return outarg.result;
+}
+
+static void muse_mtd_sync(struct mtd_info *mtd)
+{
+	struct muse_conn *mc =3D mtd->priv;
+	struct fuse_mount *fm =3D &mc->fm;
+	FUSE_ARGS(args);
+
+	args.opcode =3D MUSE_SYNC;
+	args.nodeid =3D FUSE_ROOT_ID;
+	args.in_numargs =3D 0;
+
+	fuse_simple_request(fm, &args);
+}
+
+static ssize_t muse_send_write(struct fuse_args_pages *ap, struct fuse_m=
ount *fm,
+			       loff_t from, size_t count, int *soft_error)
+{
+	struct fuse_args *args =3D &ap->args;
+	ssize_t ret;
+
+	struct muse_write_in in;
+	struct muse_write_out out;
+
+	in.dataaddr =3D from;
+	in.datalen =3D count;
+	in.flags =3D 0;
+	args->opcode =3D MUSE_WRITE;
+	args->nodeid =3D FUSE_ROOT_ID;
+	args->in_numargs =3D 2;
+	args->in_args[0].size =3D sizeof(in);
+	args->in_args[0].value =3D &in;
+	/*
+	 * args->in_args[1].value was set in set_ap_inout_bufs()
+	 */
+	args->in_args[1].size =3D count;
+	args->out_numargs =3D 1;
+	args->out_args[0].size =3D sizeof(out);
+	args->out_args[0].value =3D &out;
+
+	ret =3D fuse_simple_request(fm, &ap->args);
+	if (ret < 0)
+		goto out;
+
+	ret =3D out.datalen;
+	*soft_error =3D out.soft_error;
+
+out:
+	return ret;
+}
+
+static ssize_t muse_send_read(struct fuse_args_pages *ap, struct fuse_mo=
unt *fm,
+			      loff_t from, size_t count, int *soft_error)
+{
+	struct fuse_args *args =3D &ap->args;
+	ssize_t ret;
+
+	struct muse_read_in in;
+	struct muse_read_out out;
+
+	in.dataaddr =3D from;
+	in.datalen =3D count;
+	in.flags =3D 0;
+	args->opcode =3D MUSE_READ;
+	args->nodeid =3D FUSE_ROOT_ID;
+	args->in_numargs =3D 1;
+	args->in_args[0].size =3D sizeof(in);
+	args->in_args[0].value =3D &in;
+	args->out_argvar =3D true;
+	args->out_numargs =3D 2;
+	args->out_args[0].size =3D sizeof(out);
+	args->out_args[0].value =3D &out;
+	/*
+	 * args->out_args[1].value was set in set_ap_inout_bufs()
+	 */
+	args->out_args[1].size =3D count;
+
+	ret =3D fuse_simple_request(fm, &ap->args);
+	if (ret < 0)
+		goto out;
+
+	ret =3D out.datalen;
+	*soft_error =3D out.soft_error;
+
+out:
+	return ret;
+}
+
+/*
+ * set_ap_inout_bufs - Set in/out buffers for fuse args
+ *
+ * @ap: FUSE args pages object
+ * @iter: IOV iter which describes source/destination of the IO operatio=
n
+ * @count: Inputs the max amount of data we can process,
+ *	   outputs the amount of data @iter has left.
+ * @write: If non-zero, this is a write operation, read otherwise.
+ *
+ * This function takes a IOV iter object and sets up FUSE args pointer.
+ * Since in MTD all buffers are kernel memory we can directly use
+ * fuse_get_user_addr().
+ */
+static void set_ap_inout_bufs(struct fuse_args_pages *ap, struct iov_ite=
r *iter,
+				size_t *count, int write)
+{
+	unsigned long addr;
+	size_t frag_size;
+
+	addr =3D fuse_get_user_addr(iter);
+	frag_size =3D fuse_get_frag_size(iter, *count);
+
+	if (write)
+		ap->args.in_args[1].value =3D (void *)addr;
+	else
+		ap->args.out_args[1].value =3D (void *)addr;
+
+	iov_iter_advance(iter, frag_size);
+	*count =3D frag_size;
+}
+
+/*
+ * muse_do_io - MUSE main IO processing function.
+ *
+ * @mc: MUSE connection object.
+ * @ops: MTD read/write operation object.
+ * @pos: Where to start reading/writing on the MTD.
+ * @retcode: Outputs the return code for the MTD subsystem.
+ * @write: If non-zero, this is a write operation, read otherwise.
+ *
+ * This function is responsible for processing reads and writes to the M=
TD.
+ * It directly takes @pos and @ops from the MTD subsystem.
+ * All IO is synchronous and buffers provided by @ops have to be kernel =
memory.
+ * Each MUSE_READ/MUSE_WRITE operation is at most mtd->writebuffer long,
+ * such that the userspace server can assume that each operaion affects =
at most
+ * one page.
+ * The userspace server can inject also custom errors into the IO path,
+ * mostly -EUCLEAN to signal fixed bit-flips or -EBADMSG for uncorrectab=
le
+ * bit-flips.
+ *
+ * It returns the amount of processed bytes and via @retcode the return =
code
+ * for the MTD subsystem.
+ */
+static ssize_t muse_do_io(struct muse_conn *mc, struct mtd_oob_ops *ops,
+			  loff_t pos, int *retcode, int write)
+{
+	struct kvec iov =3D { .iov_base =3D ops->datbuf, .iov_len =3D ops->len =
};
+	struct fuse_mount *fm =3D &mc->fm;
+	struct fuse_conn *fc =3D fm->fc;
+	size_t fc_max_io =3D write ? fc->max_write : fc->max_read;
+	size_t count;
+	size_t retlen =3D 0;
+	struct fuse_args_pages ap;
+	unsigned int max_pages;
+	int bitflips =3D 0;
+	int eccerrors =3D 0;
+	ssize_t ret =3D 0;
+	struct iov_iter iter;
+
+	/*
+	 * TODO: Implement OOB support
+	 */
+	if (ops->mode !=3D MTD_OPS_PLACE_OOB || ops->ooblen) {
+		ret =3D -ENOTSUPP;
+		goto out;
+	}
+
+	iov_iter_kvec(&iter, write ? WRITE : READ, &iov, 1, ops->len);
+
+	/*
+	 * A full page needs to fit into a single FUSE request.
+	 */
+	if (fc_max_io < mc->mtd.writebufsize) {
+		ret =3D -ENOBUFS;
+		goto out;
+	}
+
+	count =3D iov_iter_count(&iter);
+
+	max_pages =3D iov_iter_npages(&iter, fc->max_pages);
+	memset(&ap, 0, sizeof(ap));
+
+	ap.pages =3D fuse_pages_alloc(max_pages, GFP_KERNEL, &ap.descs);
+	if (!ap.pages) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	*retcode =3D 0;
+
+	while (count) {
+		size_t nbytes =3D min_t(size_t, count, mc->mtd.writebufsize);
+		int soft_error;
+
+		set_ap_inout_bufs(&ap, &iter, &nbytes, write);
+
+		if (write)
+			ret =3D muse_send_write(&ap, fm, pos, nbytes, &soft_error);
+		else
+			ret =3D muse_send_read(&ap, fm, pos, nbytes, &soft_error);
+
+		kfree(ap.pages);
+		ap.pages =3D NULL;
+
+		if (ret < 0) {
+			iov_iter_revert(&iter, nbytes);
+			break;
+		}
+
+		if (soft_error) {
+			/*
+			 * Userspace wants to inject an error code.
+			 */
+
+			if (write) {
+				/*
+				 * For writes, take it as-is.
+				 */
+				ret =3D soft_error;
+				break;
+			}
+
+			/*
+			 * -EUCLEAN and -EBADMSG are special for reads
+			 * in MTD, it expects from a device to return all
+			 * requsted data even if there are (un)correctable errors.
+			 * The upper layer, such as UBI, has to deal with them.
+			 */
+			if (soft_error =3D=3D -EUCLEAN) {
+				bitflips++;
+			} else if (soft_error =3D=3D -EBADMSG) {
+				eccerrors++;
+			} else {
+				ret =3D soft_error;
+				break;
+			}
+		}
+
+		/*
+		 * No short reads are allowed in MTD.
+		 */
+		if (ret !=3D nbytes) {
+			iov_iter_revert(&iter, nbytes - ret);
+			ret =3D -EIO;
+			break;
+		}
+
+		count -=3D ret;
+		retlen +=3D ret;
+		pos +=3D ret;
+
+		if (count) {
+			max_pages =3D iov_iter_npages(&iter, fc->max_pages);
+			memset(&ap, 0, sizeof(ap));
+			ap.pages =3D fuse_pages_alloc(max_pages, GFP_KERNEL, &ap.descs);
+			if (!ap.pages)
+				break;
+		}
+	}
+
+	kfree(ap.pages);
+
+	if (bitflips)
+		*retcode =3D -EUCLEAN;
+	if (eccerrors)
+		*retcode =3D -EBADMSG;
+
+out:
+	/*
+	 * If ret is set, it must be a fatal error which overrides
+	 * -EUCLEAN and -EBADMSG.
+	 */
+	if (ret < 0)
+		*retcode =3D ret;
+
+	return retlen;
+}
+
+static int muse_mtd_read_oob(struct mtd_info *mtd, loff_t from, struct m=
td_oob_ops *ops)
+{
+	struct muse_conn *mc =3D mtd->priv;
+	int retcode;
+
+	ops->retlen =3D muse_do_io(mc, ops, from, &retcode, 0);
+
+	return retcode;
+}
+
+static int muse_mtd_write_oob(struct mtd_info *mtd, loff_t to, struct mt=
d_oob_ops *ops)
+{
+	struct muse_conn *mc =3D mtd->priv;
+	int retcode;
+
+	ops->retlen =3D muse_do_io(mc, ops, to, &retcode, 1);
+
+	return retcode;
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
+	for (;;) {
+		ret =3D fuse_kv_parse_one(&p, end, &key, &val);
+		if (ret < 0)
+			goto out;
+		if (!ret)
+			break;
+
+		if (strcmp(key, "NAME") =3D=3D 0) {
+			req.name =3D val;
+		} else if (strcmp(key, "TYPE") =3D=3D 0) {
+			ret =3D kstrtoul(val, 10, &req.mi.type);
+			if (ret)
+				goto out;
+		} else if (strcmp(key, "FLAGS") =3D=3D 0) {
+			ret =3D kstrtoul(val, 10, &req.mi.flags);
+			if (ret)
+				goto out;
+		} else if (strcmp(key, "SIZE") =3D=3D 0) {
+			ret =3D kstrtoul(val, 10, &req.mi.size);
+			if (ret)
+				goto out;
+		} else if (strcmp(key, "WRITESIZE") =3D=3D 0) {
+			ret =3D kstrtoul(val, 10, &req.mi.writesize);
+			if (ret)
+				goto out;
+		} else if (strcmp(key, "ERASESIZE") =3D=3D 0) {
+			ret =3D kstrtoul(val, 10, &req.mi.erasesize);
+			if (ret)
+				goto out;
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
+	/*
+	 * MTD_ABSENT and MTD_UBIVOLUME and special, and can only be used by
+	 * internal MTD drivers. Allowing userspace to emulate them asks for
+	 * trouble.
+	 */
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
+	struct muse_init_args *mia =3D container_of(args, struct muse_init_args=
, ap.args);
+	struct muse_conn *mc =3D container_of(fc, struct muse_conn, fc);
+	struct fuse_args_pages *ap =3D &mia->ap;
+	struct muse_init_out *arg =3D &mia->out;
+	struct page *page =3D ap->pages[0];
+	struct mtd_info *mtd =3D &mc->mtd;
+	int ret;
+
+	if (error || arg->fuse_major !=3D FUSE_KERNEL_VERSION || arg->fuse_mino=
r < 33)
+		goto abort;
+
+	fc->minor =3D arg->fuse_minor;
+	fc->max_read =3D max_t(unsigned int, arg->max_read, 4096);
+	fc->max_write =3D max_t(unsigned int, arg->max_write, 4096);
+
+	ret =3D muse_parse_mtdreq(page_address(page), ap->args.out_args[1].size=
, mtd);
+	if (ret)
+		goto abort;
+
+	mtd->_erase =3D muse_mtd_erase;
+	mtd->_sync =3D muse_mtd_sync;
+	mtd->_read_oob =3D muse_mtd_read_oob;
+	mtd->_write_oob =3D muse_mtd_write_oob;
+	mtd->_get_device =3D muse_mtd_get_device;
+	mtd->_put_device =3D muse_mtd_put_device;
+
+	/*
+	 * Bad blocks make only sense on NAND devices.
+	 * As soon _block_isbad is set, upper layer such as
+	 * UBI expects a working _block_isbad, so userspace
+	 * has to implement MUSE_ISBAD.
+	 */
+	if (mtd_type_is_nand(mtd)) {
+		mtd->_block_isbad =3D muse_mtd_isbad;
+		mtd->_block_markbad =3D muse_mtd_markbad;
+	}
+
+	mtd->priv =3D mc;
+	mtd->owner =3D THIS_MODULE;
+
+	/*
+	 * We want one READ/WRITE op per MTD io. So the MTD pagesize needs
+	 * to fit into max_write/max_read
+	 */
+	if (fc->max_write < mtd->writebufsize || fc->max_read < mtd->writebufsi=
ze)
+		goto abort;
+
+	if (mtd_device_register(mtd, NULL, 0) !=3D 0)
+		goto abort;
+
+	mc->init_done =3D true;
+
+	kfree(mia);
+	__free_page(page);
+	return;
+
+abort:
+	fuse_abort_conn(fc);
+}
+
+static int muse_send_init(struct muse_conn *mc)
+{
+	struct fuse_mount *fm =3D &mc->fm;
+	struct fuse_args_pages *ap;
+	struct muse_init_args *mia;
+	struct page *page;
+	int ret =3D -ENOMEM;
+
+	BUILD_BUG_ON(MUSE_INIT_INFO_MAX > PAGE_SIZE);
+
+	page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
+		goto err;
+
+	mia =3D kzalloc(sizeof(*mia), GFP_KERNEL);
+	if (!mia)
+		goto err_page;
+
+	ap =3D &mia->ap;
+	mia->in.fuse_major =3D FUSE_KERNEL_VERSION;
+	mia->in.fuse_minor =3D FUSE_KERNEL_MINOR_VERSION;
+	ap->args.opcode =3D MUSE_INIT;
+	ap->args.in_numargs =3D 1;
+	ap->args.in_args[0].size =3D sizeof(mia->in);
+	ap->args.in_args[0].value =3D &mia->in;
+	ap->args.out_numargs =3D 2;
+	ap->args.out_args[0].size =3D sizeof(mia->out);
+	ap->args.out_args[0].value =3D &mia->out;
+	ap->args.out_args[1].size =3D MUSE_INIT_INFO_MAX;
+	ap->args.out_argvar =3D true;
+	ap->args.out_pages =3D true;
+	ap->num_pages =3D 1;
+	ap->pages =3D &mia->page;
+	ap->descs =3D &mia->desc;
+	mia->page =3D page;
+	mia->desc.length =3D ap->args.out_args[1].size;
+	ap->args.end =3D muse_process_init_reply;
+
+	ret =3D fuse_simple_background(fm, &ap->args, GFP_KERNEL);
+	if (ret)
+		goto err_ia;
+
+	return 0;
+
+err_ia:
+	kfree(mia);
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
+	/*
+	 * Paranoia check.
+	 */
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
+MODULE_LICENSE("GPL");
--=20
2.26.2

