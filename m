Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD75396FB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 10:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhFAJAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 05:00:38 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:38740 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233096AbhFAJAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:00:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tao.peng@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uat92-g_1622537934;
Received: from localhost(mailfrom:tao.peng@linux.alibaba.com fp:SMTPD_---0Uat92-g_1622537934)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Jun 2021 16:58:54 +0800
From:   Peng Tao <tao.peng@linux.alibaba.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH RFC] fuse: add generic file store
Date:   Tue,  1 Jun 2021 16:58:26 +0800
Message-Id: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a generic file store that userspace can save/restore any open file
descriptor. These file descriptors can be managed by different
applications not just the same user space application.

A possible use case is fuse fd passthrough being developed
by Alessio Balsini [1] where underlying file system fd can be saved in
this file store.

Another possible use case is user space application live upgrade and
failover (upon panic etc.). Currently during userspace live upgrade and
failover, open file descriptors usually have to be saved seprately in
a different management process with AF_UNIX sendmsg.

But it causes chicken and egg problem and such management process needs
to support live upgrade and failover as well. With a generic file store
in the kernel, application live upgrade and failover no longer require such
management process to hold reference for their open file descriptors.

This is an RFC to see if the approach makes sense to upstream and it can be
tested with the following C programe.

Why FUSE?
- Because we are trying to solve FUSE fd passthrough and FUSE daemon
  live upgrade.

Why global IDR rather than per fuse connnection one?
- Because for live upgrade new process, we don't have a valid fuse connection
  in the first place.

Missing cleanup method in case user space messes up?
- We can limit the number of saved FDs and hey it is RFC ;).

[1] https://lore.kernel.org/lkml/20210125153057.3623715-1-balsini@android.com/
--------

/#include <sys/types.h>
/#include <sys/stat.h>
/#include <fcntl.h>
/#include <unistd.h>
/#include <stdlib.h>
/#include <stdio.h>
/#include <stdbool.h>
/#include <string.h>
/#include <sys/ioctl.h>
/#include <stdint.h>

/#define FUSE_DEV_IOC_SAVE_FD    _IOWR(229, 1, uint32_t)
/#define FUSE_DEV_IOC_RESTORE_FD _IOWR(229, 2, uint32_t)
/#define FUSE_DEV_IOC_REMOVE_FD  _IOW(229, 3, uint32_t)

static const char *FUSEDEV = "/dev/fuse";
int fuse_fd;

void show_help(char *pname)
{
	fprintf(stdout, "%s [-sh] [-d <id>] [-f <filename>] [-r <id>]\n", pname);
	fprintf(stdout, "\t-s open <filename>(default foobar) and save its fd\n");
	fprintf(stdout, "\t-r <id> restore fd identified by id\n");
	fprintf(stdout, "\t-f <filename> set filename to save\n");
	fprintf(stdout, "\t-d <id> delete id identified by id\n");
	fprintf(stdout, "\t-h show this help\n");
}

int open_save_fd(char *name)
{
	int fd;

	fd = open(name, O_RDWR | O_CREAT, 0666);
	if (fd < 0)
		return fd;
	if (ioctl(fuse_fd, FUSE_DEV_IOC_SAVE_FD, &fd) < 0)
		return -1;

	return fd;
}

int restore_fd(int id)
{
	if (ioctl(fuse_fd, FUSE_DEV_IOC_RESTORE_FD, &id) < 0)
		return -1;
	return id;
}

int delete_fd(int id)
{
	return ioctl(fuse_fd, FUSE_DEV_IOC_REMOVE_FD, &id);
}

int read_file(int fd)
{
	char buf[1024];
	int ret;

	lseek(fd, 0, SEEK_SET);
	memset(buf, 0, sizeof(buf));
	fprintf(stdout, "file content:\n");
	while ((ret = read(fd, buf, sizeof(buf))) > 0) {
		fprintf(stdout, "%s", buf);
	}
	return 0;
}

int main(int argc, char *argv[])
{
	bool save = false, restore = false;
	int fd, opt, ret, id, restored_fd;
	char *name = "foobar";

	fuse_fd = open(FUSEDEV, O_RDWR);
	if (fuse_fd < 0) {
		fprintf(stderr, "failed to open fuse device\n");
		return -1;
	}

	while ((opt = getopt(argc, argv, "shd:f:r:")) != -1) {
		switch (opt) {
		case 's':
			save = true;
			break;
		case 'r':
			id = atoi(optarg);
			restored_fd = restore_fd(id);
			if (restored_fd < 0)
				fprintf(stderr, "failed to restore fd with id %d\n", id);
			else
				fprintf(stdout, "restored file fd %d with id %d\n", restored_fd, id);
			restore = true;
			break;
		case 'd':
			id = atoi(optarg);
			ret = delete_fd(id);
			if (ret < 0)
				fprintf(stderr, "failed to delete fd with id %d\n", id);
			else
				fprintf(stdout, "deleted file id %d\n", id);
		case 'f':
			name = strdup(optarg);
			break;
		case 'h':
		default:
			show_help(argv[0]);
			return 0;
		}
	}
	if (save) {
		ret = open_save_fd(name);
		if (ret < 0)
			fprintf(stderr, "failed to open save fd with filename %s\n", name);
		else
			fprintf(stdout, "saved file id %d\n", ret);
	}
	if (restore && restored_fd > 0) {
		ret = read_file(restored_fd);
		if (ret < 0)
			fprintf(stderr, "failed to read_file with fd %d\n", restored_fd);
	}

	return 0;
}

Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
---
 fs/fuse/dev.c             | 31 ++++++++++++++---
 fs/fuse/fuse_i.h          |  5 +++
 fs/fuse/inode.c           | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |  3 ++
 4 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index a5ceccc..dfce809 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2229,15 +2229,14 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
-	int res;
-	int oldfd;
+	int res = -EFAULT;
+	int fd;
 	struct fuse_dev *fud = NULL;
 
 	switch (cmd) {
 	case FUSE_DEV_IOC_CLONE:
-		res = -EFAULT;
-		if (!get_user(oldfd, (__u32 __user *)arg)) {
-			struct file *old = fget(oldfd);
+		if (!get_user(fd, (__u32 __user *)arg)) {
+			struct file *old = fget(fd);
 
 			res = -EINVAL;
 			if (old) {
@@ -2258,6 +2257,28 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			}
 		}
 		break;
+	case FUSE_DEV_IOC_SAVE_FD:
+		if (!get_user(fd, (__u32 __user *) arg)) {
+			res = fuse_filp_save(fd);
+			if (res > 0) {
+				res = put_user(res, (__u32 __user *) arg);
+			}
+		}
+		break;
+	case FUSE_DEV_IOC_RESTORE_FD:
+		if (!get_user(fd, (__u32 __user *) arg)) {
+			res = fuse_filp_restore(fd);
+			if (res > 0) {
+				res = put_user(res, (__u32 __user *) arg);
+			}
+		}
+		break;
+	case FUSE_DEV_IOC_REMOVE_FD:
+		if (!get_user(fd, (__u32 __user *) arg)) {
+			fuse_filp_remove(fd);
+			res = 0;
+		}
+		break;
 	default:
 		res = -ENOTTY;
 		break;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7e463e2..1060391 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1259,4 +1259,9 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
+/* fuse fd store management */
+int fuse_filp_save(int fd);
+int fuse_filp_restore(int id);
+void fuse_filp_remove(int id);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 393e36b7..b95c597 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -23,6 +23,7 @@
 #include <linux/exportfs.h>
 #include <linux/posix_acl.h>
 #include <linux/pid_namespace.h>
+#include <linux/idr.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Filesystem in Userspace");
@@ -32,6 +33,9 @@
 struct list_head fuse_conn_list;
 DEFINE_MUTEX(fuse_mutex);
 
+DEFINE_IDR(fuse_filp_store);
+DEFINE_MUTEX(fuse_filp_store_mutex);
+
 static int set_global_limit(const char *val, const struct kernel_param *kp);
 
 unsigned max_user_bgreq;
@@ -1623,6 +1627,86 @@ static inline void unregister_fuseblk(void)
 }
 #endif
 
+int fuse_filp_save(int fd)
+{
+	struct file *filp;
+	int res = -EBADF;
+
+	filp = fget(fd);
+	if (!filp) {
+		pr_err("FUSE: invalid file descriptor to save.\n");
+		goto out;
+	}
+
+	idr_preload(GFP_KERNEL);
+	mutex_lock(&fuse_filp_store_mutex);
+	res = idr_alloc(&fuse_filp_store, filp, 1, 0, GFP_ATOMIC);
+	mutex_unlock(&fuse_filp_store_mutex);
+	idr_preload_end();
+
+	if (res < 0)
+		fput(filp);
+
+out:
+	return res;
+}
+
+static struct file *do_fuse_filp_restore(int id)
+{
+	struct file *filp;
+
+	rcu_read_lock();
+	filp = idr_find(&fuse_filp_store, id);
+	if (filp && !get_file_rcu(filp))
+		filp = NULL;
+	rcu_read_unlock();
+
+	return filp;
+}
+
+int fuse_filp_restore(int id)
+{
+	struct file *filp;
+	int res;
+
+	filp = do_fuse_filp_restore(id);
+	if (!filp)
+		return -ENOENT;
+
+	res = get_unused_fd_flags(0);
+	if (res >= 0)
+		fd_install(res, filp);
+	else
+		fput(filp);
+
+	return res;
+}
+
+void fuse_filp_remove(int id)
+{
+	struct file *filp;
+
+	mutex_lock(&fuse_filp_store_mutex);
+	filp = idr_remove(&fuse_filp_store, id);
+	mutex_unlock(&fuse_filp_store_mutex);
+	if (filp)
+		fput(filp);
+}
+
+static int fuse_filp_free(int id, void *p, void *data)
+{
+	struct file *filp = (struct file *)p;
+	fput(filp);
+
+	return 0;
+}
+
+static void fuse_filp_store_cleanup(void)
+{
+	idr_for_each(&fuse_filp_store, &fuse_filp_free, NULL);
+	idr_destroy(&fuse_filp_store);
+}
+
 static void fuse_inode_init_once(void *foo)
 {
 	struct inode *inode = foo;
@@ -1746,6 +1830,7 @@ static void __exit fuse_exit(void)
 {
 	pr_debug("exit\n");
 
+	fuse_filp_store_cleanup();
 	fuse_ctl_cleanup();
 	fuse_sysfs_cleanup();
 	fuse_fs_cleanup();
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 271ae90..d12a5c2 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -919,6 +919,9 @@ struct fuse_notify_retrieve_in {
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_SAVE_FD		_IOWR(FUSE_DEV_IOC_MAGIC, 1, uint32_t)
+#define FUSE_DEV_IOC_RESTORE_FD		_IOWR(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_REMOVE_FD		_IOW(FUSE_DEV_IOC_MAGIC, 3, uint32_t)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
1.8.3.1

