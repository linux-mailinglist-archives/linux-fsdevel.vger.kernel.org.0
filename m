Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50790283D01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 19:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgJERDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 13:03:30 -0400
Received: from relay.sw.ru ([185.231.240.75]:50324 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726320AbgJERDa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:03:30 -0400
Received: from [172.16.25.93] (helo=amikhalitsyn-pc0.sw.ru)
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1kPTsk-0039Uv-Gp; Mon, 05 Oct 2020 20:02:38 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     miklos@szeredi.hu
Cc:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        David Howells <dhowells@redhat.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] overlayfs: add OVL_IOC_GETINFOFD ioctl that opens ovlinfofd
Date:   Mon,  5 Oct 2020 20:02:27 +0300
Message-Id: <20201005170227.11340-1-alexander.mikhalitsyn@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201004192401.9738-1-alexander.mikhalitsyn@virtuozzo.com>
References: <20201004192401.9738-1-alexander.mikhalitsyn@virtuozzo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Second variant of possible interface to get source-dirs fhandles from
userspace. OVL_IOC_GETINFOFD ioctls opens special [ovlinfofd] descriptor
which is really just seq_file. When read from this seq_file we will get
something like this:
===
numlower: 2
L fhandle-bytes:c fhandle-type:1 f_handle:9685a2160200000000000000
L fhandle-bytes:c fhandle-type:1 f_handle:c74cd5c10300000000000000
U fhandle-bytes:c fhandle-type:1 f_handle:e45842640400000000000000
W fhandle-bytes:c fhandle-type:1 f_handle:d393374d0500000000000000
===

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
 fs/overlayfs/readdir.c | 171 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 12ee043d2b3a..60c3c47a6b3e 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -14,6 +14,9 @@
 #include <linux/cred.h>
 #include <linux/ratelimit.h>
 #include <linux/exportfs.h>
+#include <linux/anon_inodes.h>
+#include <linux/seq_file.h>
+#include <linux/syscalls.h>
 #include "overlayfs.h"
 
 struct ovl_cache_entry {
@@ -1067,11 +1070,175 @@ static long ovl_ioctl_get_work_fhandle(struct super_block *sb,
 	return __ovl_ioctl_get_fhandle(ofs->workbasedir, arg);
 }
 
+static int ovlinfofd_release(struct inode *inode, struct file *file)
+{
+	printk("ovlinfofd_release\n");
+	return single_release(inode, file);
+}
+
+#ifdef CONFIG_PROC_FS
+static void ovlinfofd_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	/* TODO */
+}
+#endif
+
+static const struct file_operations ovlinfofd_fops = {
+	.owner		= THIS_MODULE,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	= ovlinfofd_show_fdinfo,
+#endif
+	.release	= ovlinfofd_release,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+};
+
+static long __ovl_ioctl_show_dentry_fhandle(struct seq_file *s,
+					    const char *prefix,
+					    struct dentry *origin)
+{
+	struct ovl_mnt_opt_fh *fh;
+	int ret = 0, i;
+
+	fh = __ovl_encode_mnt_opt_fh(origin);
+	if (IS_ERR(fh))
+		return PTR_ERR(fh);
+
+	seq_printf(s, "%s fhandle-bytes:%x fhandle-type:%x f_handle:",
+		   prefix, fh->fh.handle_bytes, fh->fh.handle_type);
+
+	for (i = 0; i < fh->fh.handle_bytes; i++)
+		seq_printf(s, "%02x", (int)fh->fh.f_handle[i]);
+
+	seq_putc(s, '\n');
+
+	kfree(fh);
+	return ret;
+}
+
+static long ovl_ioctl_show_lower_fhandle(struct seq_file *s,
+					 unsigned long arg)
+{
+	struct super_block *sb = s->private;
+	struct ovl_entry *oe = sb->s_root->d_fsdata;
+	struct dentry *origin;
+
+	if (arg >= oe->numlower)
+		return -EINVAL;
+
+	origin = oe->lowerstack[arg].dentry;
+
+	return __ovl_ioctl_show_dentry_fhandle(s, "L", origin);
+}
+
+static long ovl_ioctl_show_upper_fhandle(struct seq_file *s)
+{
+	struct super_block *sb = s->private;
+	struct ovl_fs *ofs = sb->s_fs_info;
+	struct dentry *origin;
+
+	if (!ofs->config.upperdir)
+		return -EINVAL;
+
+	origin = OVL_I(d_inode(sb->s_root))->__upperdentry;
+
+	return __ovl_ioctl_show_dentry_fhandle(s, "U", origin);
+}
+
+static long ovl_ioctl_show_work_fhandle(struct seq_file *s)
+{
+	struct super_block *sb = s->private;
+	struct ovl_fs *ofs = sb->s_fs_info;
+
+	if (!ofs->config.upperdir)
+		return -EINVAL;
+
+	return __ovl_ioctl_show_dentry_fhandle(s, "W", ofs->workbasedir);
+}
+
+static int ovlinfofd_show(struct seq_file *s, void *unused)
+{
+	struct super_block *sb = s->private;
+	struct ovl_entry *oe = sb->s_root->d_fsdata;
+	int i;
+
+	printk("ovlinfofd_show\n");
+
+	seq_printf(s, "numlower: %d\n", oe->numlower);
+
+	for (i = 0; i < oe->numlower; i++)
+		ovl_ioctl_show_lower_fhandle(s, i);
+	ovl_ioctl_show_upper_fhandle(s);
+	ovl_ioctl_show_work_fhandle(s);
+
+	return 0;
+}
+
+static long ovl_ioctl_get_info_fd(struct super_block *sb,
+				  unsigned long arg)
+{
+	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_entry *oe = sb->s_root->d_fsdata;
+	int err, ufd, flags = arg;
+	struct fd f;
+
+	if (flags & ~(O_CLOEXEC))
+		return -EINVAL;
+
+	/* FIXME Comment taken from signalfd.c. Need to think about this.
+	 * When we call this, the initialization must be complete, since
+	 * anon_inode_getfd() will install the fd.
+	 */
+	ufd = anon_inode_getfd("[ovlinfofd]", &ovlinfofd_fops, NULL,
+				O_RDONLY | (flags & (O_CLOEXEC)));
+	if (ufd < 0)
+		return ufd;
+
+	f = fdget(ufd);
+	if (!f.file) {
+		err = -EBADF;
+		goto err_close;
+	}
+
+	/*
+	 * It's good to have some good guess of seq_file buffer size
+	 * from start because if we will just use single_open() function
+	 * then we will make several seq_file overflows and .show callback
+	 * will be called several times. It's very bad for performance.
+	 *
+	 * Guess is very simple: we show fhandles as hex string. So,
+	 * all that we need is take MAX_HANDLE_SZ * 2 and multiply by
+	 * number of overlayfs mount source-dirs.
+	 */
+	err = single_open_size(f.file, ovlinfofd_show, sb,
+			       MAX_HANDLE_SZ * 2 *
+			       (oe->numlower + 2 * !!ofs->config.upperdir));
+	if (err)
+		goto err_fdput;
+
+	/*
+	 * We doing tricky things by combining anon_inode_getfd with seq_files,
+	 * so, it's better to check that all fine with fops after single_open_size
+	 * call.
+	 */
+	WARN_ON(f.file->f_op != &ovlinfofd_fops);
+	fdput(f);
+
+	return ufd;
+
+err_fdput:
+	fdput(f);
+err_close:
+	ksys_close(ufd);
+	return err;
+}
+
 #define	OVL_IOC_GETLWRFHNDLSNUM			_IO('o', 1)
 // DISCUSS: what if MAX_HANDLE_SZ will change?
 #define	OVL_IOC_GETLWRFHNDL			_IOR('o', 2, struct ovl_mnt_opt_fh)
 #define	OVL_IOC_GETUPPRFHNDL			_IOR('o', 3, struct ovl_mnt_opt_fh)
 #define	OVL_IOC_GETWRKFHNDL			_IOR('o', 4, struct ovl_mnt_opt_fh)
+#define	OVL_IOC_GETINFOFD			_IO('o', 5)
 
 static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
@@ -1094,6 +1261,10 @@ static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		ret = ovl_ioctl_get_work_fhandle(file_inode(file)->i_sb, arg);
 		break;
 
+	case OVL_IOC_GETINFOFD:
+		ret = ovl_ioctl_get_info_fd(file_inode(file)->i_sb, arg);
+		break;
+
 	default:
 		ret = -ENOTTY;
 	}
-- 
2.25.1

