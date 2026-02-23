Return-Path: <linux-fsdevel+bounces-78105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIJCAc3hnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:25:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3331817F526
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA5CB3042451
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0819837F8BA;
	Mon, 23 Feb 2026 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoEptV16"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575137F8A5;
	Mon, 23 Feb 2026 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889028; cv=none; b=DOIcsUP48E5e+DhidpN1u60Wcw3oVxfTH68c0PQfP9qkdY0k/kZsXumQ4mLYl+kHe/xdfJMWYEYQQzqCpksTF43c0KAinxd7SOr9DMerWPSBkxWOkMU2t+VRas1vdRlhSoUU5hCQQkJdgdnIfBqpRtm7w1YHd0bu+MVEt9zhcS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889028; c=relaxed/simple;
	bh=3gUcJd9XcX32+ohAhYaJl7nxbzsChG/ry6Mu+tMRdqc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gbv29mzXoM7GZFy8VPnePm1iun+DQXK/8CVOu2w+Ya/KWcqe1wZEuW1V8Kfr/q5YYevqJKNSYS5ePrURCViDK5oErDnCVJHi8lxBJ51eZUQT4QwUaf8HH2+mi/My4oUg4YF9WzyLGhWt24fbTjiENRdSs9Ye/XSYxuFMqVzrQck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoEptV16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603BAC19424;
	Mon, 23 Feb 2026 23:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889028;
	bh=3gUcJd9XcX32+ohAhYaJl7nxbzsChG/ry6Mu+tMRdqc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YoEptV16WRAdYzESZyUVRUzwDFeNOt/W/chdghOBPR49nJiszgXGoEpe411zZBAFJ
	 7bzeOEstE11UEFyPR75JJNllrpG9maBunn0/s7+Fi1WUCZFzLAeYs1vAXTAoo/2vPW
	 s3dyMex5mlaga9dV3VgJERdFCMsanrCmkuIO8690zkAHssXWwVnkHVZ/QZnKVT+V+q
	 7kPh9da7iYNv4TIu1cIGd69Ba/vPbrEfkZCtCwluhGF0s4BFmuxwz+wTdiD2ZHeOGj
	 v/1BELXl9FkBxevU+tQL/N+nzyWkbrSvNDP4UNw6dlihRQT8EyYL2FZgKjVVc5FseF
	 yyJ4Xm8cmyNnA==
Date: Mon, 23 Feb 2026 15:23:47 -0800
Subject: [PATCH 1/2] fuse: allow privileged mount helpers to pre-approve iomap
 usage
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188736523.3938056.13778508788152940994.stgit@frogsfrogsfrogs>
In-Reply-To: <177188736492.3938056.12632921710724088507.stgit@frogsfrogsfrogs>
References: <177188736492.3938056.12632921710724088507.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78105-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3331817F526
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

For the upcoming safemount functionality in libfuse, we will create a
privileged "mount.safe" helper that starts the fuse server in a
completely unprivileged systemd container.  The mount helper will pass
the mount options and fds for /dev/fuse and any other files requested by
the fuse server into the container via a Unix socket.

Currently, the ability to turn on iomap for fuse depends on a module
parameter and the process that calls mount() having the CAP_SYS_RAWIO
capability.  However, the unprivilged fuse server might want to query
the /dev/fuse fd for iomap capabilities before mount or FUSE_INIT so
that it can get ready.

Similar to FUSE_DEV_SYNC_INIT, add a new bit for iomap that can be
squirreled away in file->private_data and an ioctl to set that bit.
That way the privileged mount helper can pass its iomap privilege to the
contained fuse server without the fuse server needing to have
CAP_SYS_RAWIO.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_dev_i.h      |   32 +++++++++++++++++++++++++++++---
 fs/fuse/fuse_i.h          |    7 +++++++
 fs/fuse/fuse_iomap.h      |    2 ++
 include/uapi/linux/fuse.h |    1 +
 fs/fuse/dev.c             |   11 +++++------
 fs/fuse/fuse_iomap.c      |   45 +++++++++++++++++++++++++++++++++++++++++++--
 fs/fuse/inode.c           |   18 ++++++++++++------
 7 files changed, 99 insertions(+), 17 deletions(-)


diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 134bf44aff0d39..900c0ce2ffa96e 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -39,8 +39,10 @@ struct fuse_copy_state {
 	} ring;
 };
 
-#define FUSE_DEV_SYNC_INIT ((struct fuse_dev *) 1)
-#define FUSE_DEV_PTR_MASK (~1UL)
+#define FUSE_DEV_SYNC_INIT	(1UL << 0)
+#define FUSE_DEV_INHERIT_IOMAP	(1UL << 1)
+#define FUSE_DEV_FLAGS_MASK	(FUSE_DEV_SYNC_INIT | FUSE_DEV_INHERIT_IOMAP)
+#define FUSE_DEV_PTR_MASK	(~FUSE_DEV_FLAGS_MASK)
 
 static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 {
@@ -50,7 +52,31 @@ static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 	 */
 	struct fuse_dev *fud = READ_ONCE(file->private_data);
 
-	return (typeof(fud)) ((unsigned long) fud & FUSE_DEV_PTR_MASK);
+	return (typeof(fud)) ((uintptr_t)fud & FUSE_DEV_PTR_MASK);
+}
+
+static inline struct fuse_dev *__fuse_get_dev_and_flags(struct file *file,
+							uintptr_t *flagsp)
+{
+	/*
+	 * Lockless access is OK, because file->private data is set
+	 * once during mount and is valid until the file is released.
+	 */
+	struct fuse_dev *fud = READ_ONCE(file->private_data);
+
+	*flagsp = ((uintptr_t)fud) & FUSE_DEV_FLAGS_MASK;
+	return (typeof(fud)) ((uintptr_t) fud & FUSE_DEV_PTR_MASK);
+}
+
+static inline int __fuse_set_dev_flags(struct file *file, uintptr_t flag)
+{
+	uintptr_t old_flags = 0;
+
+	if (__fuse_get_dev_and_flags(file, &old_flags))
+		return -EINVAL;
+
+	WRITE_ONCE(file->private_data, (struct fuse_dev *)(old_flags | flag));
+	return 0;
 }
 
 struct fuse_dev *fuse_get_dev(struct file *file);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5c10be0d02538e..5f2e7755e3e4e4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -982,6 +982,13 @@ struct fuse_conn {
 	/* Enable fs/iomap for file operations */
 	unsigned int iomap:1;
 
+	/*
+	 * Are filesystems using this connection allowed to use iomap?  This is
+	 * determined by the privilege level of the process that initiated the
+	 * mount() call.
+	 */
+	unsigned int may_iomap:1;
+
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index b13d305ee0508b..6afc916e31a4fa 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -71,6 +71,7 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
 				  u64 written);
 
+int fuse_dev_ioctl_add_iomap(struct file *file);
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
 int fuse_iomap_dev_inval(struct fuse_conn *fc,
@@ -108,6 +109,7 @@ int fuse_iomap_inval_mappings(struct fuse_conn *fc,
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_iomap_copied_file_range(...)	((void)0)
+# define fuse_dev_ioctl_add_iomap(...)		(-EOPNOTSUPP)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 035e1a59ce50d3..1132493c66d266 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1212,6 +1212,7 @@ struct fuse_iomap_support {
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
 #define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
+#define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 101)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b2433dec8cc5e5..f4ca408653cf61 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1559,7 +1559,7 @@ struct fuse_dev *fuse_get_dev(struct file *file)
 		return fud;
 
 	err = wait_event_interruptible(fuse_dev_waitq,
-				       READ_ONCE(file->private_data) != FUSE_DEV_SYNC_INIT);
+				       __fuse_get_dev(file) != NULL);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2757,13 +2757,10 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 
 static long fuse_dev_ioctl_sync_init(struct file *file)
 {
-	int err = -EINVAL;
+	int err;
 
 	mutex_lock(&fuse_mutex);
-	if (!__fuse_get_dev(file)) {
-		WRITE_ONCE(file->private_data, FUSE_DEV_SYNC_INIT);
-		err = 0;
-	}
+	err = __fuse_set_dev_flags(file, FUSE_DEV_SYNC_INIT);
 	mutex_unlock(&fuse_mutex);
 	return err;
 }
@@ -2790,6 +2787,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		return fuse_dev_ioctl_iomap_support(file, argp);
 	case FUSE_DEV_IOC_SET_NOFS:
 		return fuse_dev_ioctl_iomap_set_nofs(file, argp);
+	case FUSE_DEV_IOC_ADD_IOMAP:
+		return fuse_dev_ioctl_add_iomap(file);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 74bd18bb4009c6..ca37eb93d71a43 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -10,6 +10,7 @@
 #include <linux/fadvise.h>
 #include <linux/swap.h>
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 #include "fuse_trace.h"
 #include "fuse_iomap.h"
 #include "fuse_iomap_i.h"
@@ -80,6 +81,12 @@ bool fuse_iomap_enabled(void)
 	return enable_iomap && has_capability_noaudit(current, CAP_SYS_RAWIO);
 }
 
+static inline bool fuse_iomap_may_enable(void)
+{
+	/* Same as above, but this time we log the denial in audit log */
+	return enable_iomap && capable(CAP_SYS_RAWIO);
+}
+
 /* Convert IOMAP_* mapping types to FUSE_IOMAP_TYPE_* */
 #define XMAP(word) \
 	case IOMAP_##word: \
@@ -2526,12 +2533,46 @@ fuse_iomap_fallocate(
 	return 0;
 }
 
+int fuse_dev_ioctl_add_iomap(struct file *file)
+{
+	uintptr_t flags = 0;
+	struct fuse_dev *fud;
+	int ret = 0;
+
+	mutex_lock(&fuse_mutex);
+	fud = __fuse_get_dev_and_flags(file, &flags);
+	if (fud) {
+		if (!fud->fc->may_iomap && !fuse_iomap_may_enable()) {
+			ret = -EPERM;
+			goto out_unlock;
+		}
+
+		fud->fc->may_iomap = 1;
+		goto out_unlock;
+	}
+
+	if (!(flags & FUSE_DEV_INHERIT_IOMAP) && !fuse_iomap_may_enable()) {
+		ret = -EPERM;
+		goto out_unlock;
+	}
+
+	ret = __fuse_set_dev_flags(file, FUSE_DEV_INHERIT_IOMAP);
+
+out_unlock:
+	mutex_unlock(&fuse_mutex);
+	return ret;
+}
+
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp)
 {
 	struct fuse_iomap_support ios = { };
+	uintptr_t flags = 0;
+	struct fuse_dev *fud = __fuse_get_dev_and_flags(file, &flags);
 
-	if (fuse_iomap_enabled())
+	if ((!fud && (flags & FUSE_DEV_INHERIT_IOMAP)) ||
+	    (fud && fud->fc->may_iomap) ||
+	    fuse_iomap_enabled())
 		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO |
 			    FUSE_IOMAP_SUPPORT_ATOMIC;
 
@@ -2604,7 +2645,7 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
 
 static inline bool can_set_nofs(struct fuse_dev *fud)
 {
-	if (fud && fud->fc && fud->fc->iomap)
+	if (fud && fud->fc && (fud->fc->iomap || fud->fc->may_iomap))
 	       return true;
 
 	return capable(CAP_SYS_RESOURCE);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1fedfb57a22514..0f2b12aa1ac4bb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1047,6 +1047,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->name_max = FUSE_NAME_LOW_MAX;
 	fc->timeout.req_timeout = 0;
 	fc->root_nodeid = FUSE_ROOT_ID;
+	fc->may_iomap = fuse_iomap_enabled();
 
 	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_init(fc);
@@ -1581,7 +1582,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
 
-			if ((flags & FUSE_IOMAP) && fuse_iomap_enabled()) {
+			if ((flags & FUSE_IOMAP) && fc->may_iomap) {
 				fc->iomap = 1;
 				pr_warn(
  "EXPERIMENTAL iomap feature enabled.  Use at your own risk!");
@@ -1668,7 +1669,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 	 */
 	if (fuse_uring_enabled())
 		flags |= FUSE_OVER_IO_URING;
-	if (fuse_iomap_enabled())
+	if (fm->fc->may_iomap)
 		flags |= FUSE_IOMAP;
 
 	ia->in.flags = flags;
@@ -2041,11 +2042,16 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
-	if (ctx->fudptr && *ctx->fudptr) {
-		if (*ctx->fudptr == FUSE_DEV_SYNC_INIT)
-			fc->sync_init = 1;
-		else
+	if (ctx->fudptr) {
+		uintptr_t raw = (uintptr_t)(*ctx->fudptr);
+		uintptr_t flags = raw & FUSE_DEV_FLAGS_MASK;
+
+		if (raw & FUSE_DEV_PTR_MASK)
 			goto err_unlock;
+		if (flags & FUSE_DEV_SYNC_INIT)
+			fc->sync_init = 1;
+		if (flags & FUSE_DEV_INHERIT_IOMAP)
+			fc->may_iomap = 1;
 	}
 
 	err = fuse_ctl_add_conn(fc);


