Return-Path: <linux-fsdevel+bounces-79230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGdHB03opmlWZgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:55:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D11181F0D1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B419E3072BCE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 13:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE9936655B;
	Tue,  3 Mar 2026 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNFivJpM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA3364EB6;
	Tue,  3 Mar 2026 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545785; cv=none; b=GU74ru1KyH12vbnqNcbPl9xcLL3t+MekciykuOcjVQrlj1UGd6mW6yde382D3G8geM5BIcjygFFuCS38CZoedsPknegXWtXrS8+uC+CUM616TmcGnrr6S4ZatVFTYtcSjlMIAA17xVx8Xj2wb2nv/7H4IO6bu8bc6aqzxSeQEqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545785; c=relaxed/simple;
	bh=aX5gO+5Iccj0yV9V7P8CAMTUIqqZ5nyE5IExGpNekTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XylETVTSoELyG4DP7/qGy2gFDKiLWbZ8fBPiQn0Nc0XTJMUw4+01lwSXiLVvjrY3Rolw4KuuZSljh+/Xi76bWyDuu2uzTOjUaFhSboRSZek6OLCsFd0ZB8bQIvEYwQkxvBrnyWAqIgPo6O4vIVgXwxx4ffz13+lHXe7TjH4FEro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNFivJpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531C0C19422;
	Tue,  3 Mar 2026 13:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545785;
	bh=aX5gO+5Iccj0yV9V7P8CAMTUIqqZ5nyE5IExGpNekTs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QNFivJpM+sQAYYx7A87jfUjL+KMzaYWq4mkENqshivLyyPIwBOLwWsPgRw7/wsB3p
	 AjavOKSZb3bBecr7N5SohB578iL3sbWa0szbCVaKxdd/y8t8WRHrNTiw/BBvXXF4o0
	 HbzdiPGzGJfw9j/kQclF9k7e0piJfv+mevs+Xa1uXMGwtqHuvUnC9NdrrtxRFYZjQL
	 09wEoXwIrYD+c+fqANzERhLR7/9TZByCAHLWNcBwS80VQp2N4sxO5cC3nHh08yR5MS
	 QvgssH7l+uW9Ruy9rcDL0v4RkFW980HRJ9BG2WUo4Xyt3SWju/D7ZsBOivATzGTbvv
	 WBi7MyhuZ6ZnA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Mar 2026 14:49:21 +0100
Subject: [PATCH RFC DRAFT POC 10/11] tree-wide: make all kthread path
 lookups to use LOOKUP_IN_INIT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-work-kthread-nullfs-v1-10-87e559b94375@kernel.org>
References: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
In-Reply-To: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=14803; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aX5gO+5Iccj0yV9V7P8CAMTUIqqZ5nyE5IExGpNekTs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQue3bvzLr6rfOSt7wwYwr7Ue+yzpmBv4HLaf89v21TG
 VqYPhV3dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkuycjwxf7vt41vzTyIz7y
 rrxsfE7YJTHoxMfMmZ+dnt/VMTqxYRUjw2HR+ULdAftN1drnHFm7+VOaZXf66knip5X3OT+s4FF
 bzgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: D11181F0D1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79230-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

In preparation to isolate all kthreads in nullfs convert all lookups
performed from kthread context to use LOOKUP_IN_INIT. This will make
them all perform the relevant lookup operation in init's filesystem
state.

This should be switched to individual commits for easy bisectability but
right now it serves to illustrate the idea without creating a massive
patchbomb.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/rnbd/rnbd-srv.c     |  2 +-
 drivers/char/misc_minor_kunit.c   |  2 +-
 drivers/crypto/ccp/sev-dev.c      |  4 +---
 drivers/target/target_core_alua.c |  2 +-
 drivers/target/target_core_pr.c   |  2 +-
 fs/btrfs/volumes.c                |  6 +++++-
 fs/coredump.c                     |  6 ++----
 fs/init.c                         | 23 ++++++++++++-----------
 fs/kernel_read_file.c             |  4 +---
 fs/namei.c                        |  2 +-
 fs/nfs/blocklayout/dev.c          |  4 ++--
 fs/smb/server/mgmt/share_config.c |  3 ++-
 fs/smb/server/smb2pdu.c           |  2 +-
 fs/smb/server/vfs.c               |  6 ++++--
 init/initramfs.c                  |  4 ++--
 init/initramfs_test.c             |  4 ++--
 net/unix/af_unix.c                |  4 +---
 17 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 10e8c438bb43..6796aee9a2f0 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -734,7 +734,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto reject;
 	}
 
-	bdev_file = bdev_file_open_by_path(full_path, open_flags, NULL, NULL);
+	bdev_file = bdev_file_open_init(full_path, open_flags, NULL, NULL);
 	if (IS_ERR(bdev_file)) {
 		ret = PTR_ERR(bdev_file);
 		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %pe\n",
diff --git a/drivers/char/misc_minor_kunit.c b/drivers/char/misc_minor_kunit.c
index e930c78e1ef9..8af1377c42f9 100644
--- a/drivers/char/misc_minor_kunit.c
+++ b/drivers/char/misc_minor_kunit.c
@@ -165,7 +165,7 @@ static void __init miscdev_test_can_open(struct kunit *test, struct miscdevice *
 	if (ret != 0)
 		KUNIT_FAIL(test, "failed to create node\n");
 
-	filp = filp_open(devname, O_RDONLY, 0);
+	filp = filp_open_init(devname, O_RDONLY, 0);
 	if (IS_ERR(filp))
 		KUNIT_FAIL(test, "failed to open misc device: %ld\n", PTR_ERR(filp));
 	else
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 096f993974d1..92971671fa9d 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -262,9 +262,7 @@ static struct file *open_file_as_root(const char *filename, int flags, umode_t m
 {
 	struct path root __free(path_put) = {};
 
-	task_lock(&init_task);
-	get_fs_root(init_task.fs, &root);
-	task_unlock(&init_task);
+	init_root(&root);
 
 	CLASS(prepare_creds, cred)();
 	if (!cred)
diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core_alua.c
index 10250aca5a81..d23390d1b6ab 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -856,7 +856,7 @@ static int core_alua_write_tpg_metadata(
 	unsigned char *md_buf,
 	u32 md_buf_len)
 {
-	struct file *file = filp_open(path, O_RDWR | O_CREAT | O_TRUNC, 0600);
+	struct file *file = filp_open_init(path, O_RDWR | O_CREAT | O_TRUNC, 0600);
 	loff_t pos = 0;
 	int ret;
 
diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index f88e63aefcd8..7ad6b534ccc6 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -1969,7 +1969,7 @@ static int __core_scsi3_write_aptpl_to_file(
 	if (!path)
 		return -ENOMEM;
 
-	file = filp_open(path, flags, 0600);
+	file = filp_open_init(path, flags, 0600);
 	if (IS_ERR(file)) {
 		pr_err("filp_open(%s) for APTPL metadata"
 			" failed\n", path);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6fb0c4cd50ff..8baeacca01da 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2119,8 +2119,12 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 static void update_dev_time(const char *device_path)
 {
 	struct path path;
+	unsigned int flags = LOOKUP_FOLLOW;
 
-	if (!kern_path(device_path, LOOKUP_FOLLOW, &path)) {
+	if (tsk_is_kthread(current))
+		flags |= LOOKUP_IN_INIT;
+
+	if (!kern_path(device_path, flags, &path)) {
 		vfs_utimes(&path, NULL);
 		path_put(&path);
 	}
diff --git a/fs/coredump.c b/fs/coredump.c
index 550a1553f6cb..1e631c5d2076 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -919,13 +919,11 @@ static bool coredump_file(struct core_name *cn, struct coredump_params *cprm,
 		 * with a fully qualified path" rule is to control where
 		 * coredumps may be placed using root privileges,
 		 * current->fs->root must not be used. Instead, use the
-		 * root directory of init_task.
+		 * root directory of PID 1.
 		 */
 		struct path root;
 
-		task_lock(&init_task);
-		get_fs_root(init_task.fs, &root);
-		task_unlock(&init_task);
+		init_root(&root);
 		file = file_open_root(&root, cn->corename, open_flags, 0600);
 		path_put(&root);
 	} else {
diff --git a/fs/init.c b/fs/init.c
index a79872d5af3b..eb224e945328 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -12,6 +12,7 @@
 #include <linux/init_syscalls.h>
 #include <linux/security.h>
 #include "internal.h"
+#include "mount.h"
 
 int __init init_pivot_root(const char *new_root, const char *put_old)
 {
@@ -102,7 +103,7 @@ int __init init_chown(const char *filename, uid_t user, gid_t group, int flags)
 	struct path path;
 	int error;
 
-	error = kern_path(filename, lookup_flags, &path);
+	error = kern_path(filename, lookup_flags | LOOKUP_IN_INIT, &path);
 	if (error)
 		return error;
 	error = mnt_want_write(path.mnt);
@@ -119,7 +120,7 @@ int __init init_chmod(const char *filename, umode_t mode)
 	struct path path;
 	int error;
 
-	error = kern_path(filename, LOOKUP_FOLLOW, &path);
+	error = kern_path(filename, LOOKUP_FOLLOW | LOOKUP_IN_INIT, &path);
 	if (error)
 		return error;
 	error = chmod_common(&path, mode);
@@ -132,7 +133,7 @@ int __init init_eaccess(const char *filename)
 	struct path path;
 	int error;
 
-	error = kern_path(filename, LOOKUP_FOLLOW, &path);
+	error = kern_path(filename, LOOKUP_FOLLOW | LOOKUP_IN_INIT, &path);
 	if (error)
 		return error;
 	error = path_permission(&path, MAY_ACCESS);
@@ -146,7 +147,7 @@ int __init init_stat(const char *filename, struct kstat *stat, int flags)
 	struct path path;
 	int error;
 
-	error = kern_path(filename, lookup_flags, &path);
+	error = kern_path(filename, lookup_flags | LOOKUP_IN_INIT, &path);
 	if (error)
 		return error;
 	error = vfs_getattr(&path, stat, STATX_BASIC_STATS,
@@ -158,39 +159,39 @@ int __init init_stat(const char *filename, struct kstat *stat, int flags)
 int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 {
 	CLASS(filename_kernel, name)(filename);
-	return filename_mknodat(AT_FDCWD, name, mode, dev, 0);
+	return filename_mknodat(AT_FDCWD, name, mode, dev, LOOKUP_IN_INIT);
 }
 
 int __init init_link(const char *oldname, const char *newname)
 {
 	CLASS(filename_kernel, old)(oldname);
 	CLASS(filename_kernel, new)(newname);
-	return filename_linkat(AT_FDCWD, old, AT_FDCWD, new, 0, 0);
+	return filename_linkat(AT_FDCWD, old, AT_FDCWD, new, 0, LOOKUP_IN_INIT);
 }
 
 int __init init_symlink(const char *oldname, const char *newname)
 {
 	CLASS(filename_kernel, old)(oldname);
 	CLASS(filename_kernel, new)(newname);
-	return filename_symlinkat(old, AT_FDCWD, new, 0);
+	return filename_symlinkat(old, AT_FDCWD, new, LOOKUP_IN_INIT);
 }
 
 int __init init_unlink(const char *pathname)
 {
 	CLASS(filename_kernel, name)(pathname);
-	return filename_unlinkat(AT_FDCWD, name, 0);
+	return filename_unlinkat(AT_FDCWD, name, LOOKUP_IN_INIT);
 }
 
 int __init init_mkdir(const char *pathname, umode_t mode)
 {
 	CLASS(filename_kernel, name)(pathname);
-	return filename_mkdirat(AT_FDCWD, name, mode, 0);
+	return filename_mkdirat(AT_FDCWD, name, mode, LOOKUP_IN_INIT);
 }
 
 int __init init_rmdir(const char *pathname)
 {
 	CLASS(filename_kernel, name)(pathname);
-	return filename_rmdir(AT_FDCWD, name, 0);
+	return filename_rmdir(AT_FDCWD, name, LOOKUP_IN_INIT);
 }
 
 int __init init_utimes(char *filename, struct timespec64 *ts)
@@ -198,7 +199,7 @@ int __init init_utimes(char *filename, struct timespec64 *ts)
 	struct path path;
 	int error;
 
-	error = kern_path(filename, 0, &path);
+	error = kern_path(filename, LOOKUP_IN_INIT, &path);
 	if (error)
 		return error;
 	error = vfs_utimes(&path, ts);
diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index de32c95d823d..00bbe0757ad3 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -156,9 +156,7 @@ ssize_t kernel_read_file_from_path_initns(const char *path, loff_t offset,
 	if (!path || !*path)
 		return -EINVAL;
 
-	task_lock(&init_task);
-	get_fs_root(init_task.fs, &root);
-	task_unlock(&init_task);
+	init_root(&root);
 
 	file = file_open_root(&root, path, O_RDONLY, 0);
 	path_put(&root);
diff --git a/fs/namei.c b/fs/namei.c
index 5cf407aad5b3..976b1e9f7032 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4906,7 +4906,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	struct dentry *dentry = ERR_PTR(-EEXIST);
 	struct qstr last;
 	bool want_dir = lookup_flags & LOOKUP_DIRECTORY;
-	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
+	unsigned int reval_flag = lookup_flags & (LOOKUP_REVAL | LOOKUP_IN_INIT);
 	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
 	int type;
 	int error;
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index cc6327d97a91..32dee716237a 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -370,8 +370,8 @@ bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 	if (!devname)
 		return ERR_PTR(-ENOMEM);
 
-	bdev_file = bdev_file_open_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
-					NULL, NULL);
+	bdev_file = bdev_file_open_init(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
+				       NULL, NULL);
 	if (IS_ERR(bdev_file)) {
 		dprintk("failed to open device %s (%ld)\n",
 			devname, PTR_ERR(bdev_file));
diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index 53f44ff4d376..2deefdc242a8 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -189,7 +189,8 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 				goto out;
 			}
 
-			ret = kern_path(share->path, 0, &share->vfs_path);
+			ret = kern_path(share->path, LOOKUP_IN_INIT,
+					&share->vfs_path);
 			ksmbd_revert_fsids(work);
 			if (ret) {
 				ksmbd_debug(SMB, "failed to access '%s'\n",
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 95901a78951c..8e89fb9a8c35 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5462,7 +5462,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	if (!share->path)
 		return -EIO;
 
-	rc = kern_path(share->path, LOOKUP_NO_SYMLINKS, &path);
+	rc = kern_path(share->path, LOOKUP_NO_SYMLINKS | LOOKUP_IN_INIT, &path);
 	if (rc) {
 		pr_err("cannot create vfs path\n");
 		return -EIO;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index d08973b288e5..2e64ed65dcca 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -62,6 +62,7 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
 	if (pathname[0] == '\0') {
 		pathname = share_conf->path;
 		root_share_path = NULL;
+		flags |= LOOKUP_IN_INIT;
 	} else {
 		flags |= LOOKUP_BENEATH;
 	}
@@ -622,7 +623,7 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 	if (ksmbd_override_fsids(work))
 		return -ENOMEM;
 
-	err = kern_path(oldname, LOOKUP_NO_SYMLINKS, &oldpath);
+	err = kern_path(oldname, LOOKUP_NO_SYMLINKS | LOOKUP_IN_INIT, &oldpath);
 	if (err) {
 		pr_err("cannot get linux path for %s, err = %d\n",
 		       oldname, err);
@@ -1258,7 +1259,8 @@ struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 	if (!abs_name)
 		return ERR_PTR(-ENOMEM);
 
-	dent = start_creating_path(AT_FDCWD, abs_name, path, flags);
+	dent = start_creating_path(AT_FDCWD, abs_name, path,
+				   flags | LOOKUP_IN_INIT);
 	kfree(abs_name);
 	return dent;
 }
diff --git a/init/initramfs.c b/init/initramfs.c
index 139baed06589..f44d772f960b 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -382,7 +382,7 @@ static int __init do_name(void)
 			int openflags = O_WRONLY|O_CREAT|O_LARGEFILE;
 			if (ml != 1)
 				openflags |= O_TRUNC;
-			wfile = filp_open(collected, openflags, mode);
+			wfile = filp_open_init(collected, openflags, mode);
 			if (IS_ERR(wfile))
 				return 0;
 			wfile_pos = 0;
@@ -702,7 +702,7 @@ static void __init populate_initrd_image(char *err)
 
 	printk(KERN_INFO "rootfs image is not initramfs (%s); looks like an initrd\n",
 			err);
-	file = filp_open("/initrd.image", O_WRONLY|O_CREAT|O_LARGEFILE, 0700);
+	file = filp_open_init("/initrd.image", O_WRONLY|O_CREAT|O_LARGEFILE, 0700);
 	if (IS_ERR(file))
 		return;
 
diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 2ce38d9a8fd0..9415b9cfb9d3 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -224,7 +224,7 @@ static void __init initramfs_test_data(struct kunit *test)
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
 
-	file = filp_open(c[0].fname, O_RDONLY, 0);
+	file = filp_open_init(c[0].fname, O_RDONLY, 0);
 	if (IS_ERR(file)) {
 		KUNIT_FAIL(test, "open failed");
 		goto out;
@@ -430,7 +430,7 @@ static void __init initramfs_test_fname_pad(struct kunit *test)
 	err = unpack_to_rootfs(tbufs->cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
 
-	file = filp_open(c[0].fname, O_RDONLY, 0);
+	file = filp_open_init(c[0].fname, O_RDONLY, 0);
 	if (IS_ERR(file)) {
 		KUNIT_FAIL(test, "open failed");
 		goto out;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3756a93dc63a..6f370cb44afe 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1200,9 +1200,7 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	if (flags & SOCK_COREDUMP) {
 		struct path root;
 
-		task_lock(&init_task);
-		get_fs_root(init_task.fs, &root);
-		task_unlock(&init_task);
+		init_root(&root);
 
 		scoped_with_kernel_creds()
 			err = vfs_path_lookup(root.dentry, root.mnt, sunaddr->sun_path,

-- 
2.47.3


