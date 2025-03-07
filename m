Return-Path: <linux-fsdevel+bounces-43393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC9BA55C87
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 02:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BBAF1897BD4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 01:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B1418BBAE;
	Fri,  7 Mar 2025 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="jP8nwB4R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999D515B99E;
	Fri,  7 Mar 2025 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309124; cv=none; b=Qy8ocO0SkwI7B+rngZeJoZ08wvpADUMAX/Z8ql5pDy7dJnO2Dx0XELatYbuF+nIA5394+Er2TKPTwMm1wswzxbTyc81ncych8s5PETJ5CCsiqoKI3iLBfk95qvV+OX7DGlOz6DTCTjkERMR55rMqRlO7UpfznVJLoHgNw9QOHEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309124; c=relaxed/simple;
	bh=yiyAS94KCu4e2acKNOAaXLPEKQ1jS/LJFKU5vN90AmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCAVrn1HDjtwa7MWi6aXyhHSi1sOFDibB/ZrE8uLpSOuRId2BaRf8TjtMQoVki3/VIcsNSgnjzqws0qYDqZELki35tKdDAchFGSbwv2YjNkUNH+rk1f3D/NoM0JNDNkfdkOK9edWKQMAtH0eoXdj6LnJSVZj8w28cp/ytApfQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=jP8nwB4R; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1741309121; x=1772845121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xs//Ktg1Y251LV5BPFRVIZ6BEdLyRGdSogUo8qySbUI=;
  b=jP8nwB4RAJcoy9XUPwp7+97gRQ45nbNEygaFLmFMGBc+91e9dJQrrnjS
   Bdx7XjauIaxoeQ82ySrBHd7OHYeDybyA70bW7pmJ+/AfR+d/UOK3IFsLh
   rB/8ea5LiDMQo/VCD+bVe9G1hC0fcxgHNjvEZLQIFr64vcVqrbnqcPK+j
   E=;
X-IronPort-AV: E=Sophos;i="6.14,227,1736812800"; 
   d="scan'208";a="277072810"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 00:58:36 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:33741]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.151:2525] with esmtp (Farcaster)
 id d64753f7-51ff-49fc-9439-056aa2d48a0b; Fri, 7 Mar 2025 00:58:35 +0000 (UTC)
X-Farcaster-Flow-ID: d64753f7-51ff-49fc-9439-056aa2d48a0b
Received: from EX19D020UWA002.ant.amazon.com (10.13.138.222) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D020UWA002.ant.amazon.com (10.13.138.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 00:58:34 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com (Postfix) with ESMTP id 68D4580110;
	Fri,  7 Mar 2025 00:58:33 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 011884FCC; Fri,  7 Mar 2025 00:58:32 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: <linux-kernel@vger.kernel.org>
CC: Pratyush Yadav <ptyadav@amazon.de>, Jonathan Corbet <corbet@lwn.net>,
	"Eric Biederman" <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Hugh Dickins <hughd@google.com>, Alexander Graf
	<graf@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David
 Woodhouse" <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, "Mike
 Rapoport" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Pasha
 Tatashin" <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, "Wei
 Yang" <richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
Subject: [RFC PATCH 1/5] misc: introduce FDBox
Date: Fri, 7 Mar 2025 00:57:35 +0000
Message-ID: <20250307005830.65293-2-ptyadav@amazon.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307005830.65293-1-ptyadav@amazon.de>
References: <20250307005830.65293-1-ptyadav@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The File Descriptor Box (FDBox) is a mechanism for userspace to name
file descriptors and give them over to the kernel to hold. They can
later be retrieved by passing in the same name.

The primary purpose of FDBox is to be used with Kexec Handover (KHO).
There are many kinds anonymous file descriptors in the kernel like
memfd, guest_memfd, iommufd, etc. that would be useful to be preserved
using KHO. To be able to do that, there needs to be a mechanism to label
FDs that allows userspace to set the label before doing KHO and to use
the label to map them back after KHO. FDBox achieves that purpose by
exposing a miscdevice which exposes ioctls to label and transfer FDs
between the kernel and userspace. FDBox is not intended to work with any
generic file descriptor. Support for each kind of FDs must be explicitly
enabled.

While the primary purpose of FDBox is to be used with KHO, it does not
explicitly require CONFIG_KEXEC_HANDOVER, since it can be used without
KHO, simply as a way to preserve or transfer FDs when userspace exits.

Co-developed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---

Notes:
    In a real live-update environment, it would likely make more sense to
    have a way of passing a hint to the kernel that KHO is about to happen
    and it should start preparing. Having as much state serialized as
    possible before the KHO freeze would help reduce downtime. An FDBox
    operation, say FDBOX_PREPARE_FD that can give the signal to prepare
    before actually being put in the box and sealed. I have not added
    something like that yet for simplicity sake.

 MAINTAINERS                |   8 +
 drivers/misc/Kconfig       |   7 +
 drivers/misc/Makefile      |   1 +
 drivers/misc/fdbox.c       | 758 +++++++++++++++++++++++++++++++++++++
 include/linux/fdbox.h      | 119 ++++++
 include/linux/fs.h         |   7 +
 include/linux/miscdevice.h |   1 +
 include/uapi/linux/fdbox.h |  61 +++
 8 files changed, 962 insertions(+)
 create mode 100644 drivers/misc/fdbox.c
 create mode 100644 include/linux/fdbox.h
 create mode 100644 include/uapi/linux/fdbox.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 82c2ef421c000..d329d3e5514c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8862,6 +8862,14 @@ F:	include/scsi/libfc.h
 F:	include/scsi/libfcoe.h
 F:	include/uapi/scsi/fc/
 
+FDBOX
+M:	Pratyush Yadav <pratyush@kernel.org>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	drivers/misc/fdbox.c
+F:	include/linux/fdbox.h
+F:	include/uapi/linux/fdbox.h
+
 FILE LOCKING (flock() and fcntl()/lockf())
 M:	Jeff Layton <jlayton@kernel.org>
 M:	Chuck Lever <chuck.lever@oracle.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 56bc72c7ce4a9..6fee70c9479c4 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -632,6 +632,13 @@ config MCHP_LAN966X_PCI
 	    - lan966x-miim (MDIO_MSCC_MIIM)
 	    - lan966x-switch (LAN966X_SWITCH)
 
+config FDBOX
+	bool "File Descriptor Box device to persist fds"
+	help
+	  Add a new /dev/fdbox directory that allows user space to preserve specific
+	  types of file descritors when user space exits. Also preserves the same
+	  types of file descriptors across kexec when KHO is enabled.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 545aad06d0885..59a398dcfcd64 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -75,3 +75,4 @@ lan966x-pci-objs		:= lan966x_pci.o
 lan966x-pci-objs		+= lan966x_pci.dtbo.o
 obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
 obj-y				+= keba/
+obj-$(CONFIG_FDBOX)		+= fdbox.o
diff --git a/drivers/misc/fdbox.c b/drivers/misc/fdbox.c
new file mode 100644
index 0000000000000..a8f6574e2c25f
--- /dev/null
+++ b/drivers/misc/fdbox.c
@@ -0,0 +1,758 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fdbox.c - framework to preserve file descriptors across
+ *           process lifetime and kexec
+ *
+ * Copyright (C) 2024-2025 Amazon.com Inc. or its affiliates.
+ *
+ * Author: Pratyush Yadav <ptyadav@amazon.de>
+ * Author: Alexander Graf <graf@amazon.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/anon_inodes.h>
+#include <linux/cdev.h>
+#include <linux/miscdevice.h>
+#include <linux/fdtable.h>
+#include <linux/file.h>
+#include <linux/kexec.h>
+#include <linux/kexec_handover.h>
+#include <linux/libfdt.h>
+#include <linux/fdbox.h>
+
+static struct miscdevice fdbox_dev;
+
+static struct {
+	struct class			*class;
+	dev_t				box_devt;
+	struct xarray			box_list;
+	struct xarray			handlers;
+	struct rw_semaphore		recover_sem;
+	bool				recover_done;
+} priv = {
+	.box_list = XARRAY_INIT(fdbox.box_list, XA_FLAGS_ALLOC),
+	.handlers = XARRAY_INIT(fdbox.handlers, XA_FLAGS_ALLOC),
+	.recover_sem = __RWSEM_INITIALIZER(priv.recover_sem),
+};
+
+struct fdbox_handler {
+	const char *compatible;
+	struct file *(*fn)(const void *fdt, int offset);
+};
+
+static struct fdbox *fdbox_remove_box(char *name)
+{
+	struct xarray *boxlist = &priv.box_list;
+	unsigned long box_idx;
+	struct fdbox *box;
+
+	xa_lock(boxlist);
+	xa_for_each(boxlist, box_idx, box) {
+		if (!strcmp(box->name, name)) {
+			__xa_erase(boxlist, box_idx);
+			break;
+		}
+	}
+	xa_unlock(boxlist);
+
+	return box;
+}
+
+static struct fdbox_fd *fdbox_remove_fd(struct fdbox *box, char *name)
+{
+	struct xarray *fdlist = &box->fd_list;
+	struct fdbox_fd *box_fd;
+	unsigned long idx;
+
+	xa_lock(fdlist);
+	xa_for_each(fdlist, idx, box_fd) {
+		if (!strncmp(box_fd->name, name, sizeof(box_fd->name))) {
+			__xa_erase(fdlist, idx);
+			break;
+		}
+	}
+	xa_unlock(fdlist);
+
+	return box_fd;
+}
+
+/* Must be called with box->rwsem held. */
+static struct fdbox_fd *fdbox_put_file(struct fdbox *box, const char *name,
+				       struct file *file)
+{
+	struct fdbox_fd *box_fd __free(kfree) = NULL, *cmp;
+	struct xarray *fdlist = &box->fd_list;
+	unsigned long idx;
+	u32 newid;
+	int ret;
+
+	/* Only files that set f_fdbox_op are allowed in the box. */
+	if (!file->f_fdbox_op)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	box_fd = kzalloc(sizeof(*box_fd), GFP_KERNEL);
+	if (!box_fd)
+		return ERR_PTR(-ENOMEM);
+
+	if (strscpy_pad(box_fd->name, name, sizeof(box_fd->name)) < 0)
+		/* Name got truncated. This means the name is not NUL-terminated. */
+		return ERR_PTR(-EINVAL);
+
+	box_fd->file = file;
+	box_fd->box = box;
+
+	xa_lock(fdlist);
+	xa_for_each(fdlist, idx, cmp) {
+		/* Look for name collisions. */
+		if (!strcmp(box_fd->name, cmp->name)) {
+			xa_unlock(fdlist);
+			return ERR_PTR(-EEXIST);
+		}
+	}
+
+	ret = __xa_alloc(fdlist, &newid, box_fd, xa_limit_32b, GFP_KERNEL);
+	xa_unlock(fdlist);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return_ptr(box_fd);
+}
+
+static long fdbox_put_fd(struct fdbox *box, unsigned long arg)
+{
+	struct fdbox_put_fd put_fd;
+	struct fdbox_fd *box_fd;
+	struct file *file;
+	int ret;
+
+	if (copy_from_user(&put_fd, (void __user *)arg, sizeof(put_fd)))
+		return -EFAULT;
+
+	guard(rwsem_read)(&box->rwsem);
+
+	if (box->sealed)
+		return -EBUSY;
+
+	file = fget_raw(put_fd.fd);
+	if (!file)
+		return -EINVAL;
+
+	box_fd = fdbox_put_file(box, put_fd.name, file);
+	if (IS_ERR(box_fd)) {
+		fput(file);
+		return PTR_ERR(box_fd);
+	}
+
+	ret = close_fd(put_fd.fd);
+	if (ret) {
+		struct fdbox_fd *del;
+
+		del = fdbox_remove_fd(box, put_fd.name);
+		/*
+		 * If we fail to remove from list, it means someone else took
+		 * the FD out. In that case, they own the refcount of the file
+		 * now.
+		 */
+		if (del == box_fd)
+			fput(file);
+
+		return ret;
+	}
+
+	return 0;
+}
+
+static long fdbox_seal(struct fdbox *box)
+{
+	struct fdbox_fd *box_fd;
+	unsigned long idx;
+	int ret;
+
+	guard(rwsem_write)(&box->rwsem);
+
+	if (box->sealed)
+		return -EBUSY;
+
+	xa_for_each(&box->fd_list, idx, box_fd) {
+		const struct fdbox_file_ops *fdbox_ops = box_fd->file->f_fdbox_op;
+
+		if (fdbox_ops && fdbox_ops->seal) {
+			ret = fdbox_ops->seal(box);
+			if (ret)
+				return ret;
+		}
+	}
+
+	box->sealed = true;
+
+	return 0;
+}
+
+static long fdbox_unseal(struct fdbox *box)
+{
+	struct fdbox_fd *box_fd;
+	unsigned long idx;
+	int ret;
+
+	guard(rwsem_write)(&box->rwsem);
+
+	if (!box->sealed)
+		return -EBUSY;
+
+	xa_for_each(&box->fd_list, idx, box_fd) {
+		const struct fdbox_file_ops *fdbox_ops = box_fd->file->f_fdbox_op;
+
+		if (fdbox_ops && fdbox_ops->seal) {
+			ret = fdbox_ops->seal(box);
+			if (ret)
+				return ret;
+		}
+	}
+
+	box->sealed = false;
+
+	return 0;
+}
+
+static long fdbox_get_fd(struct fdbox *box, unsigned long arg)
+{
+	struct fdbox_get_fd get_fd;
+	struct fdbox_fd *box_fd;
+	int fd;
+
+	guard(rwsem_read)(&box->rwsem);
+
+	if (box->sealed)
+		return -EBUSY;
+
+	if (copy_from_user(&get_fd, (void __user *)arg, sizeof(get_fd)))
+		return -EFAULT;
+
+	if (get_fd.flags)
+		return -EINVAL;
+
+	fd = get_unused_fd_flags(0);
+	if (fd < 0)
+		return fd;
+
+	box_fd = fdbox_remove_fd(box, get_fd.name);
+	if (!box_fd) {
+		put_unused_fd(fd);
+		return -ENOENT;
+	}
+
+	fd_install(fd, box_fd->file);
+	kfree(box_fd);
+	return fd;
+}
+
+static long box_fops_unl_ioctl(struct file *filep,
+			       unsigned int cmd, unsigned long arg)
+{
+	struct fdbox *box = filep->private_data;
+	long ret = -EINVAL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	switch (cmd) {
+	case FDBOX_PUT_FD:
+		ret = fdbox_put_fd(box, arg);
+		break;
+	case FDBOX_UNSEAL:
+		ret = fdbox_unseal(box);
+		break;
+	case FDBOX_SEAL:
+		ret = fdbox_seal(box);
+		break;
+	case FDBOX_GET_FD:
+		ret = fdbox_get_fd(box, arg);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int box_fops_open(struct inode *inode, struct file *filep)
+{
+	struct fdbox *box = container_of(inode->i_cdev, struct fdbox, cdev);
+
+	filep->private_data = box;
+
+	return 0;
+}
+
+static const struct file_operations box_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= box_fops_unl_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+	.open		= box_fops_open,
+};
+
+static void fdbox_device_release(struct device *dev)
+{
+	struct fdbox *box = container_of(dev, struct fdbox, dev);
+	struct xarray *fdlist = &box->fd_list;
+	struct fdbox_fd *box_fd;
+	unsigned long idx;
+
+	unregister_chrdev_region(box->dev.devt, 1);
+
+	xa_for_each(fdlist, idx, box_fd) {
+		xa_erase(fdlist, idx);
+		fput(box_fd->file);
+		kfree(box_fd);
+	}
+
+	xa_destroy(fdlist);
+	kfree(box);
+}
+
+static struct fdbox *_fdbox_create_box(const char *name)
+{
+	struct fdbox *box;
+	int ret = 0;
+	u32 id;
+
+	box = kzalloc(sizeof(*box), GFP_KERNEL);
+	if (!box)
+		return ERR_PTR(-ENOMEM);
+
+	xa_init_flags(&box->fd_list, XA_FLAGS_ALLOC);
+	xa_init_flags(&box->pending_fds, XA_FLAGS_ALLOC);
+	init_rwsem(&box->rwsem);
+
+	if (strscpy_pad(box->name, name, sizeof(box->name)) < 0) {
+		/* Name got truncated. This means the name is not NUL-terminated. */
+		kfree(box);
+		return ERR_PTR(-EINVAL);
+	}
+
+	dev_set_name(&box->dev, "fdbox/%s", name);
+
+	ret = alloc_chrdev_region(&box->dev.devt, 0, 1, name);
+	if (ret) {
+		kfree(box);
+		return ERR_PTR(ret);
+	}
+
+	box->dev.release = fdbox_device_release;
+	device_initialize(&box->dev);
+
+	cdev_init(&box->cdev, &box_fops);
+	box->cdev.owner = THIS_MODULE;
+	kobject_set_name(&box->cdev.kobj, "fdbox/%s", name);
+
+	ret = cdev_device_add(&box->cdev, &box->dev);
+	if (ret)
+		goto err_dev;
+
+	ret = xa_alloc(&priv.box_list, &id, box, xa_limit_32b, GFP_KERNEL);
+	if (ret)
+		goto err_cdev;
+
+	return box;
+
+err_cdev:
+	cdev_device_del(&box->cdev, &box->dev);
+err_dev:
+	/*
+	 * This should free the box and chrdev region via
+	 * fdbox_device_release().
+	 */
+	put_device(&box->dev);
+
+	return ERR_PTR(ret);
+}
+
+static long fdbox_create_box(unsigned long arg)
+{
+	struct fdbox_create_box create_box;
+
+	if (copy_from_user(&create_box, (void __user *)arg, sizeof(create_box)))
+		return -EFAULT;
+
+	if (create_box.flags)
+		return -EINVAL;
+
+	return PTR_ERR_OR_ZERO(_fdbox_create_box(create_box.name));
+}
+
+static void _fdbox_delete_box(struct fdbox *box)
+{
+	cdev_device_del(&box->cdev, &box->dev);
+	unregister_chrdev_region(box->dev.devt, 1);
+	put_device(&box->dev);
+}
+
+static long fdbox_delete_box(unsigned long arg)
+{
+	struct fdbox_delete_box delete_box;
+	struct fdbox *box;
+
+	if (copy_from_user(&delete_box, (void __user *)arg, sizeof(delete_box)))
+		return -EFAULT;
+
+	if (delete_box.flags)
+		return -EINVAL;
+
+	box = fdbox_remove_box(delete_box.name);
+	if (!box)
+		return -ENOENT;
+
+	_fdbox_delete_box(box);
+	return 0;
+}
+
+static long fdbox_fops_unl_ioctl(struct file *filep,
+				 unsigned int cmd, unsigned long arg)
+{
+	long ret = -EINVAL;
+
+	switch (cmd) {
+	case FDBOX_CREATE_BOX:
+		ret = fdbox_create_box(arg);
+		break;
+	case FDBOX_DELETE_BOX:
+		ret = fdbox_delete_box(arg);
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations fdbox_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= fdbox_fops_unl_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+};
+
+static struct miscdevice fdbox_dev = {
+	.minor = FDBOX_MINOR,
+	.name = "fdbox",
+	.fops = &fdbox_fops,
+	.nodename = "fdbox/fdbox",
+	.mode = 0600,
+};
+
+static char *fdbox_devnode(const struct device *dev, umode_t *mode)
+{
+	char *ret = kasprintf(GFP_KERNEL, "fdbox/%s", dev_name(dev));
+	return ret;
+}
+
+static int fdbox_kho_write_fds(void *fdt, struct fdbox *box)
+{
+	struct fdbox_fd *box_fd;
+	struct file *file;
+	unsigned long idx;
+	int err = 0;
+
+	xa_for_each(&box->fd_list, idx, box_fd) {
+		file = box_fd->file;
+
+		if (!file->f_fdbox_op->kho_write) {
+			pr_info("box '%s' FD '%s' has no KHO method. It won't be saved across kexec\n",
+				box->name, box_fd->name);
+			continue;
+		}
+
+		err = fdt_begin_node(fdt, box_fd->name);
+		if (err) {
+			pr_err("failed to begin node for box '%s' FD '%s'\n",
+			       box->name, box_fd->name);
+			return err;
+		}
+
+		inode_lock(file_inode(file));
+		err = file->f_fdbox_op->kho_write(box_fd, fdt);
+		inode_unlock(file_inode(file));
+		if (err) {
+			pr_err("kho_write failed for box '%s' FD '%s': %d\n",
+			       box->name, box_fd->name, err);
+			return err;
+		}
+
+		err = fdt_end_node(fdt);
+		if (err) {
+			/* TODO: This leaks all pages reserved by kho_write(). */
+			pr_err("failed to end node for box '%s' FD '%s'\n",
+			       box->name, box_fd->name);
+			return err;
+		}
+	}
+
+	return err;
+}
+
+static int fdbox_kho_write_boxes(void *fdt)
+{
+	static const char compatible[] = "fdbox,box-v1";
+	struct fdbox *box;
+	unsigned long idx;
+	int err = 0;
+
+	xa_for_each(&priv.box_list, idx, box) {
+		if (!box->sealed)
+			continue;
+
+		err |= fdt_begin_node(fdt, box->name);
+		err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+		err |= fdbox_kho_write_fds(fdt, box);
+		err |= fdt_end_node(fdt);
+	}
+
+	return err;
+}
+
+static int fdbox_kho_notifier(struct notifier_block *self,
+			      unsigned long cmd,
+			      void *v)
+{
+	static const char compatible[] = "fdbox-v1";
+	void *fdt = v;
+	int err = 0;
+
+	switch (cmd) {
+	case KEXEC_KHO_ABORT:
+		return NOTIFY_DONE;
+	case KEXEC_KHO_DUMP:
+		/* Handled below */
+		break;
+	default:
+		return NOTIFY_BAD;
+	}
+
+	err |= fdt_begin_node(fdt, "fdbox");
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= fdbox_kho_write_boxes(fdt);
+	err |= fdt_end_node(fdt);
+
+	return err ? NOTIFY_BAD : NOTIFY_DONE;
+}
+
+static struct notifier_block fdbox_kho_nb = {
+	.notifier_call = fdbox_kho_notifier,
+};
+
+static void fdbox_recover_fd(const void *fdt, int offset, struct fdbox *box,
+			     struct file *(*fn)(const void *fdt, int offset))
+{
+	struct fdbox_fd *box_fd;
+	struct file *file;
+	const char *name;
+
+	name = fdt_get_name(fdt, offset, NULL);
+	if (!name) {
+		pr_err("no name in FDT for FD at offset %d\n", offset);
+		return;
+	}
+
+	file = fn(fdt, offset);
+	if (!file)
+		return;
+
+	scoped_guard(rwsem_read, &box->rwsem) {
+		box_fd = fdbox_put_file(box, name, file);
+		if (IS_ERR(box_fd)) {
+			pr_err("failed to put fd '%s' into box '%s': %ld\n",
+			       box->name, name, PTR_ERR(box_fd));
+			fput(file);
+			return;
+		}
+	}
+}
+
+static void fdbox_kho_recover(void)
+{
+	const void *fdt = kho_get_fdt();
+	const char *path = "/fdbox";
+	int off, box, fd;
+	int err;
+
+	/* Not a KHO boot */
+	if (!fdt)
+		return;
+
+	/*
+	 * When adding handlers this is taken as read. Taking it as write here
+	 * ensures no handlers get added while nodes are being processed,
+	 * eliminating the race of a handler getting added after its node is
+	 * processed, but before the whole recover is done.
+	 */
+	guard(rwsem_write)(&priv.recover_sem);
+
+	off = fdt_path_offset(fdt, path);
+	if (off < 0) {
+		pr_debug("could not find '%s' in DT", path);
+		return;
+	}
+
+	err = fdt_node_check_compatible(fdt, off, "fdbox-v1");
+	if (err) {
+		pr_err("invalid top level compatible\n");
+		return;
+	}
+
+	fdt_for_each_subnode(box, fdt, off) {
+		struct fdbox *new_box;
+
+		err = fdt_node_check_compatible(fdt, box, "fdbox,box-v1");
+		if (err) {
+			pr_err("invalid compatible for box '%s'\n",
+			       fdt_get_name(fdt, box, NULL));
+			continue;
+		}
+
+		new_box = _fdbox_create_box(fdt_get_name(fdt, box, NULL));
+		if (IS_ERR(new_box)) {
+			pr_warn("could not create box '%s'\n",
+				fdt_get_name(fdt, box, NULL));
+			continue;
+		}
+
+		fdt_for_each_subnode(fd, fdt, box) {
+			struct fdbox_handler *handler;
+			const char *compatible;
+			unsigned long idx;
+
+			compatible = fdt_getprop(fdt, fd, "compatible", NULL);
+			if (!compatible) {
+				pr_warn("failed to get compatible for FD '%s'. Skipping.\n",
+					fdt_get_name(fdt, fd, NULL));
+				continue;
+			}
+
+			xa_for_each(&priv.handlers, idx, handler) {
+				if (!strcmp(handler->compatible, compatible))
+					break;
+			}
+
+			if (handler) {
+				fdbox_recover_fd(fdt, fd, new_box, handler->fn);
+			} else {
+				u32 id;
+
+				pr_debug("found no handler for compatible %s. Queueing for later.\n",
+					 compatible);
+
+				if (xa_alloc(&new_box->pending_fds, &id,
+					     xa_mk_value(fd), xa_limit_32b,
+					     GFP_KERNEL)) {
+					pr_warn("failed to queue pending FD '%s' to list\n",
+						fdt_get_name(fdt, fd, NULL));
+				}
+			}
+		}
+
+		new_box->sealed = true;
+	}
+
+	priv.recover_done = true;
+}
+
+static void fdbox_recover_pending(struct fdbox_handler *handler)
+{
+	const void *fdt = kho_get_fdt();
+	unsigned long bid, pid;
+	struct fdbox *box;
+	void *pending;
+
+	if (WARN_ON(!fdt))
+		return;
+
+	xa_for_each(&priv.box_list, bid, box) {
+		xa_for_each(&box->pending_fds, pid, pending) {
+			int off = xa_to_value(pending);
+
+			if (fdt_node_check_compatible(fdt, off, handler->compatible) == 0) {
+				fdbox_recover_fd(fdt, off, box, handler->fn);
+				xa_erase(&box->pending_fds, pid);
+			}
+		}
+	}
+}
+
+int fdbox_register_handler(const char *compatible,
+			   struct file *(*fn)(const void *fdt, int offset))
+{
+	struct xarray *handlers = &priv.handlers;
+	struct fdbox_handler *handler, *cmp;
+	unsigned long idx;
+	int ret;
+	u32 id;
+
+	/* See comment in fdbox_kho_recover(). */
+	guard(rwsem_read)(&priv.recover_sem);
+
+	handler = kmalloc(sizeof(*handler), GFP_KERNEL);
+	if (!handler)
+		return -ENOMEM;
+
+	handler->compatible = compatible;
+	handler->fn = fn;
+
+	xa_lock(handlers);
+	xa_for_each(handlers, idx, cmp) {
+		if (!strcmp(cmp->compatible, compatible)) {
+			xa_unlock(handlers);
+			kfree(handler);
+			return -EEXIST;
+		}
+	}
+
+	ret = __xa_alloc(handlers, &id, handler, xa_limit_32b, GFP_KERNEL);
+	xa_unlock(handlers);
+	if (ret) {
+		kfree(handler);
+		return ret;
+	}
+
+	if (priv.recover_done)
+		fdbox_recover_pending(handler);
+
+	return 0;
+}
+
+static int __init fdbox_init(void)
+{
+	int ret = 0;
+
+	/* /dev/fdbox/$NAME */
+	priv.class = class_create("fdbox");
+	if (IS_ERR(priv.class))
+		return PTR_ERR(priv.class);
+
+	priv.class->devnode = fdbox_devnode;
+
+	ret = alloc_chrdev_region(&priv.box_devt, 0, 1, "fdbox");
+	if (ret)
+		goto err_class;
+
+	ret = misc_register(&fdbox_dev);
+	if (ret) {
+		pr_err("fdbox: misc device register failed\n");
+		goto err_chrdev;
+	}
+
+	if (IS_ENABLED(CONFIG_KEXEC_HANDOVER)) {
+		register_kho_notifier(&fdbox_kho_nb);
+		fdbox_kho_recover();
+	}
+
+	return 0;
+
+err_chrdev:
+	unregister_chrdev_region(priv.box_devt, 1);
+	priv.box_devt = 0;
+err_class:
+	class_destroy(priv.class);
+	priv.class = NULL;
+	return ret;
+}
+module_init(fdbox_init);
diff --git a/include/linux/fdbox.h b/include/linux/fdbox.h
new file mode 100644
index 0000000000000..0bc18742940f5
--- /dev/null
+++ b/include/linux/fdbox.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024-2025 Amazon.com Inc. or its affiliates.
+ *
+ * Author: Pratyush Yadav <ptyadav@amazon.de>
+ * Author: Alexander Graf <graf@amazon.com>
+ */
+#ifndef _LINUX_FDBOX_H
+#define _LINUX_FDBOX_H
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <uapi/linux/fdbox.h>
+
+/**
+ * struct fdbox - A box of FDs.
+ * @name: Name of the box. Must be unique.
+ * @rwsem: Used to ensure exclusive access to the box during SEAL/UNSEAL
+ *         operations.
+ * @dev: Backing device for the character device.
+ * @cdev: Character device which accepts ioctls from userspace.
+ * @fd_list: List of FDs in the box.
+ * @sealed: Whether the box is sealed or not.
+ */
+struct fdbox {
+	char				name[FDBOX_NAME_LEN];
+	/*
+	 * Taken as read when non-exclusive access is needed and the box can be
+	 * in mutable state. For example, the GET_FD and PUT_FD operations use
+	 * it as read when adding or removing FDs from the box.
+	 *
+	 * Taken as write when exclusive access is needed and the box should be
+	 * in a stable, non-mutable state. For example, the SEAL and UNSEAL
+	 * operations use it as write because they need the list of FDs to be
+	 * stable.
+	 */
+	struct rw_semaphore		rwsem;
+	struct device			dev;
+	struct cdev			cdev;
+	struct xarray			fd_list;
+	struct xarray			pending_fds;
+	bool				sealed;
+};
+
+/**
+ * struct fdbox_fd - An FD in a box.
+ * @name: Name of the FD. Must be unique in the box.
+ * @file: Underlying file for the FD.
+ * @flags: Box flags. Currently, no flags are allowed.
+ * @box: The box to which this FD belongs.
+ */
+struct fdbox_fd {
+	char				name[FDBOX_NAME_LEN];
+	struct file			*file;
+	int				flags;
+	struct fdbox			*box;
+};
+
+/**
+ * struct fdbox_file_ops - operations for files that can be put into a fdbox.
+ */
+struct fdbox_file_ops {
+	/**
+	 * @kho_write: write fd to KHO FDT.
+	 *
+	 * box_fd: Box FD to be serialized.
+	 *
+	 * fdt: KHO FDT
+	 *
+	 * This is called during KHO activation phase to serialize all data
+	 * needed for a FD to be preserved across a KHO.
+	 *
+	 * Returns: 0 on success, -errno on failure. Error here causes KHO
+	 * activation failure.
+	 */
+	int (*kho_write)(struct fdbox_fd *box_fd, void *fdt);
+	/**
+	 * @seal: seal the box
+	 *
+	 * box: Box which is going to be sealed.
+	 *
+	 * This can be set if a file has a dependency on other files. At seal
+	 * time, all the FDs in the box can be inspected to ensure all the
+	 * dependencies are met.
+	 */
+	int (*seal)(struct fdbox *box);
+	/**
+	 * @unseal: unseal the box
+	 *
+	 * box: Box which is going to be sealed.
+	 *
+	 * The opposite of seal. This can be set if a file has a dependency on
+	 * other files. At unseal time, all the FDs in the box can be inspected
+	 * to ensure all the dependencies are met. This can help ensure all
+	 * necessary FDs made it through after a KHO for example.
+	 */
+	int (*unseal)(struct fdbox *box);
+};
+
+/**
+ * fdbox_register_handler - register a handler for recovering Box FDs after KHO.
+ * @compatible: compatible string in the KHO FDT node.
+ * @handler: function to parse the FDT at offset 'offset'.
+ *
+ * After KHO, the FDs in the KHO FDT must be deserialized by the underlying
+ * modules or file systems. Since module initialization can be in any order,
+ * including after FDBox has been initialized, handler registration allows
+ * modules to queue their parsing functions, and FDBox will execute them when it
+ * can.
+ *
+ * Returns: 0 on success, -errno otherwise.
+ */
+int fdbox_register_handler(const char *compatible,
+			   struct file *(*handler)(const void *fdt, int offset));
+#endif /* _LINUX_FDBOX_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index be3ad155ec9f7..7d710a5e09b5b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -81,6 +81,9 @@ struct fs_context;
 struct fs_parameter_spec;
 struct fileattr;
 struct iomap_ops;
+struct fdbox;
+struct fdbox_fd;
+struct fdbox_file_ops;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -1078,6 +1081,7 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
  * @f_llist: work queue entrypoint
  * @f_ra: file's readahead state
  * @f_freeptr: Pointer used by SLAB_TYPESAFE_BY_RCU file cache (don't touch.)
+ * @f_fdbox_op: FDBOX operations
  */
 struct file {
 	file_ref_t			f_ref;
@@ -1116,6 +1120,9 @@ struct file {
 		freeptr_t		f_freeptr;
 	};
 	/* --- cacheline 3 boundary (192 bytes) --- */
+#ifdef CONFIG_FDBOX
+	const struct fdbox_file_ops	*f_fdbox_op;
+#endif
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 69e110c2b86a9..fedb873c04453 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -71,6 +71,7 @@
 #define USERIO_MINOR		240
 #define VHOST_VSOCK_MINOR	241
 #define RFKILL_MINOR		242
+#define FDBOX_MINOR		243
 #define MISC_DYNAMIC_MINOR	255
 
 struct device;
diff --git a/include/uapi/linux/fdbox.h b/include/uapi/linux/fdbox.h
new file mode 100644
index 0000000000000..577ba33b908fd
--- /dev/null
+++ b/include/uapi/linux/fdbox.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This file contains definitions and structures for fdbox ioctls.
+ *
+ * Copyright (C) 2024-2025 Amazon.com Inc. or its affiliates.
+ *
+ * Author: Pratyush Yadav <ptyadav@amazon.de>
+ * Author: Alexander Graf <graf@amazon.com>
+ */
+#ifndef _UAPI_LINUX_FDBOX_H
+#define _UAPI_LINUX_FDBOX_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define FDBOX_NAME_LEN			256
+
+#define FDBOX_TYPE	('.')
+#define FDBOX_BASE	0
+
+/* Ioctls on /dev/fdbox/fdbox */
+
+/* Create a box. */
+#define FDBOX_CREATE_BOX	_IO(FDBOX_TYPE, FDBOX_BASE + 0)
+struct fdbox_create_box {
+	__u64 flags;
+	__u8 name[FDBOX_NAME_LEN];
+};
+
+/* Delete a box. */
+#define FDBOX_DELETE_BOX	_IO(FDBOX_TYPE, FDBOX_BASE + 1)
+struct fdbox_delete_box {
+	__u64 flags;
+	__u8 name[FDBOX_NAME_LEN];
+};
+
+/* Ioctls on /dev/fdbox/$BOXNAME */
+
+/* Put FD into box. This unmaps the FD from the calling process. */
+#define FDBOX_PUT_FD	_IO(FDBOX_TYPE, FDBOX_BASE + 2)
+struct fdbox_put_fd {
+	__u64 flags;
+	__u32 fd;
+	__u32 pad;
+	__u8 name[FDBOX_NAME_LEN];
+};
+
+/* Get the FD from box. This maps the FD into the calling process. */
+#define FDBOX_GET_FD	_IO(FDBOX_TYPE, FDBOX_BASE + 3)
+struct fdbox_get_fd {
+	__u64 flags;
+	__u32 pad;
+	__u8 name[FDBOX_NAME_LEN];
+};
+
+/* Seal the box. After this, no FDs can be put in or taken out of the box. */
+#define FDBOX_SEAL	_IO(FDBOX_TYPE, FDBOX_BASE + 4)
+/* Unseal the box. Opposite of seal. */
+#define FDBOX_UNSEAL	_IO(FDBOX_TYPE, FDBOX_BASE + 5)
+
+#endif /* _UAPI_LINUX_FDBOX_H */
-- 
2.47.1


