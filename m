Return-Path: <linux-fsdevel+bounces-20100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D29E18CE114
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 08:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605131F21FD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 06:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C612C1292C2;
	Fri, 24 May 2024 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kkZEgKTN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8732E3EB;
	Fri, 24 May 2024 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716532840; cv=none; b=bmWsZxDM8qxtgHyDG/vUC+ZBg37z2zbhoqcr/PHnD9K+lQtD3JS51lmwLYahKGSSxxe45pnaFY/iTi5ZunrG4zwhhmtYYPhynm/hajUQwcKHm65LIeNtvwv54XxvLeUlyXfaWIwjZ6Atrt+R1W5ND8fIh05DAYmt7YpuFrDDTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716532840; c=relaxed/simple;
	bh=ZZGbH4j4KoLjxGa3gP5t89NBjh2/+4eT31Si1kIQmoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDq9m4pTqQwrxePZTburY2Xfr3Nw+0U+x8ZjjnbqqVbdVa+lxgaVIOTgByrAJ2ery3oX6UETUVaq3rRraIYH1sNI1o04QpYQ1j+GAHbQZUIB4odbuXU12o+TFAJeJurJYzDtUazsrCQ2gH7s8h88Ezj5BBOGaxk+clodku/UYxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kkZEgKTN; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716532834; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JqgpZan+Q4jsdC6mGDfJkv600tZnziXykNUHVC93ALE=;
	b=kkZEgKTNGaMCL1pW3tmBqDl3f1yFnaryZkjpvs3BI6hQahxQ3cUJ+/ZyE2pFM4pPJmFDpOaFdQwrc6/8rfzu9by56lOXygrHo5EOP/SrC8svq3oKp6SzZaICjMEY5bMZUP4Lwf8E5av3smGddZZdOUszKAQmI5FwAh+GKcLh9d0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W757n.A_1716532832;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W757n.A_1716532832)
          by smtp.aliyun-inc.com;
          Fri, 24 May 2024 14:40:33 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	winters.zc@antgroup.com
Subject: [RFC 1/2] fuse: introduce recovery mechanism for fuse server
Date: Fri, 24 May 2024 14:40:29 +0800
Message-Id: <20240524064030.4944-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce failover mechanism for fuse server, with which the fuse
connection could keep alive while the fuse server crashes.  The fuse
server could re-attach to the fuse connection after crash and recover
the filesystem service.

The requests submitted after the server crash will stay in the iqueue
and get serviced once the fuse server recovers from the crash and
retrieve the previous fuse connection.  As for the inflight requests
that have been sent to the fuse server before the server crash and not
been replied yet, the fuse server could request the kernel to resend
those inflight requests through FUSE_NOTIFY_RESEND notification type.

To implement the above mechanism:

1. Introduce a new "tag=" mount option, with which useres could identify
a fuse connection with a unique name.
2. Introduce a new FUSE_DEV_IOC_ATTACH ioctl, with which the fuse server
could reconnect to the fuse connection corresponding to the given tag.
3. Introduce a new FUSE_HAS_RECOVERY init flag.  The fuse server should
advertise this feature if it supports server recovery.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dev.c             | 43 ++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          |  7 +++++++
 fs/fuse/inode.c           | 35 ++++++++++++++++++++++++++++++-
 include/uapi/linux/fuse.h |  7 +++++++
 4 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3ec8bb5e68ff..7599138baac0 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2271,7 +2271,7 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 		end_requests(&to_end);
 
 		/* Are we the last open device? */
-		if (atomic_dec_and_test(&fc->dev_count)) {
+		if (atomic_dec_and_test(&fc->dev_count) && !fc->recovery) {
 			WARN_ON(fc->iq.fasync != NULL);
 			fuse_abort_conn(fc);
 		}
@@ -2376,6 +2376,44 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	return fuse_backing_close(fud->fc, backing_id);
 }
 
+static inline bool fuse_device_attach_match(struct fuse_conn *fc,
+					    const char *tag)
+{
+	if (!fc->recovery)
+		return false;
+
+	return !strncmp(fc->tag, tag, FUSE_TAG_NAME_MAX);
+}
+
+static int fuse_device_attach(struct file *file, const char *tag)
+{
+	struct fuse_conn *fc;
+
+	list_for_each_entry(fc, &fuse_conn_list, entry) {
+		if (!fuse_device_attach_match(fc, tag))
+			continue;
+		return fuse_device_clone(fc, file);
+	}
+	return -ENOTTY;
+}
+
+static long fuse_dev_ioctl_attach(struct file *file, __u32 __user *argp)
+{
+	struct fuse_ioctl_attach attach;
+	int res;
+
+	if (copy_from_user(&attach, argp, sizeof(attach)))
+		return -EFAULT;
+
+	if (attach.tag[0] == '\0')
+		return -EINVAL;
+
+	mutex_lock(&fuse_mutex);
+	res = fuse_device_attach(file, attach.tag);
+	mutex_unlock(&fuse_mutex);
+	return res;
+}
+
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
@@ -2391,6 +2429,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_BACKING_CLOSE:
 		return fuse_dev_ioctl_backing_close(file, argp);
 
+	case FUSE_DEV_IOC_ATTACH:
+		return fuse_dev_ioctl_attach(file, argp);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..e9832186f84f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -575,6 +575,7 @@ struct fuse_fs_context {
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
+	const char *tag;
 
 	/* DAX device, may be NULL */
 	struct dax_device *dax_dev;
@@ -860,6 +861,9 @@ struct fuse_conn {
 	/** Passthrough support for read/write IO */
 	unsigned int passthrough:1;
 
+	/** Support for fuse server recovery */
+	unsigned int recovery:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
@@ -917,6 +921,9 @@ struct fuse_conn {
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
+
+	/* Tag of the connection used by fuse server recovery */
+	const char *tag;
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..1ab245d6ade3 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -733,6 +733,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_TAG,
 	OPT_ERR
 };
 
@@ -747,6 +748,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_string	("tag",			OPT_TAG),
 	{}
 };
 
@@ -830,6 +832,15 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		ctx->blksize = result.uint_32;
 		break;
 
+	case OPT_TAG:
+		if (ctx->tag)
+			return invalfc(fsc, "Multiple tags specified");
+		if (strlen(param->string) > FUSE_TAG_NAME_MAX)
+			return invalfc(fsc, "Tag name too long");
+		ctx->tag = param->string;
+		param->string = NULL;
+		return 0;
+
 	default:
 		return -EINVAL;
 	}
@@ -843,6 +854,7 @@ static void fuse_free_fsc(struct fs_context *fsc)
 
 	if (ctx) {
 		kfree(ctx->subtype);
+		kfree(ctx->tag);
 		kfree(ctx);
 	}
 }
@@ -969,6 +981,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 		}
 		if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 			fuse_backing_files_free(fc);
+		kfree(fc->tag);
 		call_rcu(&fc->rcu, delayed_release);
 	}
 }
@@ -1331,6 +1344,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_NO_EXPORT_SUPPORT)
 				fm->sb->s_export_op = &fuse_export_fid_operations;
+			if (flags & FUSE_HAS_RECOVERY)
+				fc->recovery = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1378,7 +1393,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_HAS_RECOVERY;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
@@ -1520,6 +1535,17 @@ void fuse_dev_free(struct fuse_dev *fud)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_free);
 
+static bool fuse_find_conn_tag(const char *tag)
+{
+	struct fuse_conn *fc;
+
+	list_for_each_entry(fc, &fuse_conn_list, entry) {
+		if (!strcmp(fc->tag, tag))
+			return true;
+	}
+	return false;
+}
+
 static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
 				      const struct fuse_inode *fi)
 {
@@ -1727,6 +1753,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
+	fc->tag = ctx->tag;
+	ctx->tag = NULL;
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
@@ -1742,6 +1770,11 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	if (ctx->fudptr && *ctx->fudptr)
 		goto err_unlock;
 
+	if (fc->tag && fuse_find_conn_tag(fc->tag)) {
+		pr_err("tag %s already exist\n", fc->tag);
+		goto err_unlock;
+	}
+
 	err = fuse_ctl_add_conn(fc);
 	if (err)
 		goto err_unlock;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..054d6789b2fc 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -463,6 +463,7 @@ struct fuse_file_lock {
 #define FUSE_PASSTHROUGH	(1ULL << 37)
 #define FUSE_NO_EXPORT_SUPPORT	(1ULL << 38)
 #define FUSE_HAS_RESEND		(1ULL << 39)
+#define FUSE_HAS_RECOVERY	(1ULL << 40)
 
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
@@ -1079,12 +1080,18 @@ struct fuse_backing_map {
 	uint64_t	padding;
 };
 
+struct fuse_ioctl_attach {
+#define FUSE_TAG_NAME_MAX		128
+	char	tag[FUSE_TAG_NAME_MAX];
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_ATTACH		_IOW(FUSE_DEV_IOC_MAGIC, 3, struct fuse_ioctl_attach)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.19.1.6.gb485710b


