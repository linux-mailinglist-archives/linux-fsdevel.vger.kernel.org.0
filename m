Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B6C282D43
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 21:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgJDTZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Oct 2020 15:25:42 -0400
Received: from relay.sw.ru ([185.231.240.75]:42358 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbgJDTZm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Oct 2020 15:25:42 -0400
Received: from [172.16.25.93] (helo=amikhalitsyn-pc0.sw.ru)
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1kP9cr-00318e-ED; Sun, 04 Oct 2020 22:24:53 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     miklos@szeredi.hu
Cc:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        David Howells <dhowells@redhat.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] overlayfs: add ioctls that allows to get fhandle for layers dentries
Date:   Sun,  4 Oct 2020 22:24:01 +0300
Message-Id: <20201004192401.9738-2-alexander.mikhalitsyn@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201004192401.9738-1-alexander.mikhalitsyn@virtuozzo.com>
References: <20201004192401.9738-1-alexander.mikhalitsyn@virtuozzo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add several ioctls to ovl_dir_operations that allows to get file handles
for upperdir, workdir, lowerdir dentries. Special {s_dev; fhandle}
format used. (Ideally should be {mnt_id; fhandle} but this impossible
because overlayfs not keeps mounts refcnt for layers.)

Added ioctls list:
OVL_IOC_GETLWRFHNDLSNUM - get lowerdirs count
OVL_IOC_GETLWRFHNDL - get i-th lowerdir fhandle
OVL_IOC_GETUPPRFHNDL - get upperdir fhandle
OVL_IOC_GETWRKFHNDL - get workdir fhandle

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
---
 fs/overlayfs/readdir.c | 160 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 596002054ac6..12ee043d2b3a 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/cred.h>
 #include <linux/ratelimit.h>
+#include <linux/exportfs.h>
 #include "overlayfs.h"
 
 struct ovl_cache_entry {
@@ -58,6 +59,20 @@ struct ovl_dir_file {
 	struct file *upperfile;
 };
 
+struct ovl_mnt_opt_fh {
+	__u32 s_dev;
+	struct file_handle fh;
+	/* use f_handle field from struct file_handle */
+	__u8 __fhdata[MAX_HANDLE_SZ];
+};
+
+struct ovl_mnt_opt_fh_req {
+	union {
+		unsigned int lowernum;
+		struct ovl_mnt_opt_fh result;
+	};
+} __packed;
+
 static struct ovl_cache_entry *ovl_cache_entry_from_node(struct rb_node *n)
 {
 	return rb_entry(n, struct ovl_cache_entry, node);
@@ -942,6 +957,150 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static long ovl_ioctl_get_lowers_num(struct super_block *sb)
+{
+	struct ovl_entry *oe = sb->s_root->d_fsdata;
+	return oe->numlower;
+}
+
+static struct ovl_mnt_opt_fh *__ovl_encode_mnt_opt_fh(struct dentry *dentry)
+{
+	struct ovl_mnt_opt_fh *opt_fh;
+	int fh_type, dwords;
+	int buflen = MAX_HANDLE_SZ;
+	int err;
+
+	opt_fh = kzalloc(sizeof(struct ovl_mnt_opt_fh), GFP_KERNEL);
+	if (!opt_fh)
+		return ERR_PTR(-ENOMEM);
+
+	/* we ask for a non connected handle */
+	dwords = buflen >> 2;
+	fh_type = exportfs_encode_fh(dentry, (void *)opt_fh->fh.f_handle, &dwords, 0);
+	buflen = (dwords << 2);
+
+	err = -EIO;
+	if (WARN_ON(fh_type < 0) ||
+	    WARN_ON(buflen > MAX_HANDLE_SZ) ||
+	    WARN_ON(fh_type == FILEID_INVALID))
+		goto out_err;
+
+	opt_fh->fh.handle_type = fh_type;
+	opt_fh->fh.handle_bytes = buflen;
+
+	/*
+	 * Ideally, we want to have mnt_id+fhandle, but overlayfs not
+	 * keep refcnts on layers mounts and we couldn't determine
+	 * mnt_ids for layers. So, let's give s_dev to CRIU.
+	 * It's better than nothing.
+	 */
+	opt_fh->s_dev = dentry->d_sb->s_dev;
+
+	return opt_fh;
+
+out_err:
+	kfree(opt_fh);
+	return ERR_PTR(err);
+}
+
+static long __ovl_ioctl_get_fhandle(struct dentry *origin,
+				    unsigned long arg)
+{
+	struct ovl_mnt_opt_fh *fh;
+	int ret = 0;
+
+	fh = __ovl_encode_mnt_opt_fh(origin);
+	if (IS_ERR(fh))
+		return PTR_ERR(fh);
+
+	if (copy_to_user((struct ovl_mnt_opt_fh __user *)arg,
+			 fh, sizeof(*fh)))
+		ret = -EFAULT;
+
+	kfree(fh);
+	return ret;
+}
+
+static long ovl_ioctl_get_lower_fhandle(struct super_block *sb,
+					unsigned long arg)
+{
+	struct ovl_entry *oe = sb->s_root->d_fsdata;
+	struct dentry *origin;
+	struct ovl_mnt_opt_fh_req input;
+
+	BUILD_BUG_ON(sizeof(struct ovl_mnt_opt_fh_req) != sizeof(struct ovl_mnt_opt_fh));
+
+	if (copy_from_user(&input, (struct ovl_mnt_opt_fh_req __user *)arg,
+			   sizeof(input)))
+		return -EFAULT;
+
+	if (input.lowernum >= oe->numlower)
+		return -EINVAL;
+
+	origin = oe->lowerstack[input.lowernum].dentry;
+
+	return __ovl_ioctl_get_fhandle(origin, arg);
+}
+
+static long ovl_ioctl_get_upper_fhandle(struct super_block *sb,
+					unsigned long arg)
+{
+	struct ovl_fs *ofs = sb->s_fs_info;
+	struct dentry *origin;
+
+	if (!ofs->config.upperdir)
+		return -EINVAL;
+
+	origin = OVL_I(d_inode(sb->s_root))->__upperdentry;
+
+	return __ovl_ioctl_get_fhandle(origin, arg);
+}
+
+static long ovl_ioctl_get_work_fhandle(struct super_block *sb,
+				       unsigned long arg)
+{
+	struct ovl_fs *ofs = sb->s_fs_info;
+
+	if (!ofs->config.upperdir)
+		return -EINVAL;
+
+	return __ovl_ioctl_get_fhandle(ofs->workbasedir, arg);
+}
+
+#define	OVL_IOC_GETLWRFHNDLSNUM			_IO('o', 1)
+// DISCUSS: what if MAX_HANDLE_SZ will change?
+#define	OVL_IOC_GETLWRFHNDL			_IOR('o', 2, struct ovl_mnt_opt_fh)
+#define	OVL_IOC_GETUPPRFHNDL			_IOR('o', 3, struct ovl_mnt_opt_fh)
+#define	OVL_IOC_GETWRKFHNDL			_IOR('o', 4, struct ovl_mnt_opt_fh)
+
+static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	long ret;
+
+	switch (cmd) {
+	case OVL_IOC_GETLWRFHNDLSNUM:
+		ret = ovl_ioctl_get_lowers_num(file_inode(file)->i_sb);
+		break;
+
+	case OVL_IOC_GETLWRFHNDL:
+		ret = ovl_ioctl_get_lower_fhandle(file_inode(file)->i_sb, arg);
+		break;
+
+	case OVL_IOC_GETUPPRFHNDL:
+		ret = ovl_ioctl_get_upper_fhandle(file_inode(file)->i_sb, arg);
+		break;
+
+	case OVL_IOC_GETWRKFHNDL:
+		ret = ovl_ioctl_get_work_fhandle(file_inode(file)->i_sb, arg);
+		break;
+
+	default:
+		ret = -ENOTTY;
+	}
+
+	return ret;
+}
+
 const struct file_operations ovl_dir_operations = {
 	.read		= generic_read_dir,
 	.open		= ovl_dir_open,
@@ -949,6 +1108,7 @@ const struct file_operations ovl_dir_operations = {
 	.llseek		= ovl_dir_llseek,
 	.fsync		= ovl_dir_fsync,
 	.release	= ovl_dir_release,
+	.unlocked_ioctl	= ovl_ioctl,
 };
 
 int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
-- 
2.25.1

