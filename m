Return-Path: <linux-fsdevel+bounces-78068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGKlCyrgnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:18:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B3E17F1E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 741F63195F31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB61037E31E;
	Mon, 23 Feb 2026 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtwLVgp0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335BB37E2FA;
	Mon, 23 Feb 2026 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888450; cv=none; b=VWiUE3PHi/G8cseTNTyH1wUJ6iF4WHDjaAdyfcsc1lUiUr7DgOWCScNj8O898vF0TI5/9uKEPsQifQs5N9jM/k6qJ8Cp5UW44qUcE7UVgaQGDRUEi+SBv/fn7pyxCbxrEc+kjcS8A4m7siW2s0AumkmCFpjdzsEGd+A8whhUITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888450; c=relaxed/simple;
	bh=VWrdDDE06dB4U83FvAZiZ6TwwzI6HH5C/oFFTy0eGAE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBWU2krXtO68mxMvCOO7pRxfnSzyGzz7t9ycqTYXH6uNsQJEsKJgACCt/JXE5e63PCxY0FC6FzoPr7Yk06mFXVVojLwfDFb3eSzdFF1f5VpsqeQdW/9kNpujCzcBg+8EnoJkfsDC4kXtWKUuKKpTV4eVyEW/6d2PZ88Ljt1OJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtwLVgp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093F7C116C6;
	Mon, 23 Feb 2026 23:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888450;
	bh=VWrdDDE06dB4U83FvAZiZ6TwwzI6HH5C/oFFTy0eGAE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MtwLVgp0tms7ycS3RKhlz9/h5j8kVDfpXXZ9+nTGrmQMbXF83o84AB56Sl6CS+vI+
	 nQDofsV6/ILSap5qZ4OLA0KaM078B0Z9ufMu8d79lX9xgDJ4nkiOVeV6dWKICFd6rk
	 g+EK4lyXRgRxxnkxP5sMPvY3o0WHLtaitgeMPfXY8sGZYFcjcY0QaFTk66dQSIi4ut
	 X7eM20UiGXVIUka5++1t6wG2lVJNrF2qwKOfXBdI0cdIL+u4yW8RWhjoxzH20pHDXU
	 hwg3Q6/rWAHh5aukYgG25HTgBIWPQAAaowkWU20yC9yqmGyqJCebNr08LCEAGZRPwQ
	 jnCzctRlrwb7A==
Date: Mon, 23 Feb 2026 15:14:09 -0800
Subject: [PATCH 21/33] fuse: query filesystem geometry when using iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734695.3935739.8198854011004837207.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78068-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4B3E17F1E4
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add a new upcall to the fuse server so that the kernel can request
filesystem geometry bits when iomap mode is in use.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    4 +
 fs/fuse/fuse_iomap.h      |    6 +-
 include/uapi/linux/fuse.h |   39 ++++++++++++
 fs/fuse/fuse_iomap.c      |  147 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |   42 ++++++++++---
 5 files changed, 227 insertions(+), 11 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b9f41c08cc8fb0..153aa441a78320 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1037,6 +1037,9 @@ struct fuse_conn {
 	struct fuse_ring *ring;
 #endif
 
+	/** How many subsystems still need initialization? */
+	atomic_t need_init;
+
 	/** Only used if the connection opts into request timeouts */
 	struct {
 		/* Worker for checking if any requests have timed out */
@@ -1450,6 +1453,7 @@ struct fuse_dev *fuse_dev_alloc(void);
 void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
 void fuse_dev_free(struct fuse_dev *fud);
 int fuse_send_init(struct fuse_mount *fm);
+void fuse_finish_init(struct fuse_conn *fc, bool ok);
 
 /**
  * Fill in superblock and initialize fuse connection
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 9a1051638a6ff4..f80c1eae098af3 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -21,7 +21,8 @@ static inline bool fuse_has_iomap(const struct inode *inode)
 
 extern const struct fuse_backing_ops fuse_iomap_backing_ops;
 
-void fuse_iomap_mount(struct fuse_mount *fm);
+int fuse_iomap_mount(struct fuse_mount *fm);
+void fuse_iomap_mount_async(struct fuse_mount *fm);
 void fuse_iomap_unmount(struct fuse_mount *fm);
 
 void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr);
@@ -66,7 +67,8 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
-# define fuse_iomap_mount(...)			((void)0)
+# define fuse_iomap_mount(...)			(0)
+# define fuse_iomap_mount_async(...)		((void)0)
 # define fuse_iomap_unmount(...)		((void)0)
 # define fuse_iomap_init_inode(...)		((void)0)
 # define fuse_iomap_evict_inode(...)		((void)0)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index de9b56e6e8d250..33668d66e9c4b4 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -246,6 +246,7 @@
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
+ *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  */
 
 #ifndef _LINUX_FUSE_H
@@ -677,6 +678,7 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_IOMAP_CONFIG	= 4092,
 	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
@@ -1452,4 +1454,41 @@ struct fuse_iomap_ioend_out {
 	uint64_t newsize;	/* new ondisk size */
 };
 
+struct fuse_iomap_config_in {
+	uint64_t flags;		/* supported FUSE_IOMAP_CONFIG_* flags */
+	int64_t maxbytes;	/* maximum supported file size */
+	uint64_t padding[6];	/* zero */
+};
+
+/* Which fields are set in fuse_iomap_config_out? */
+#define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
+#define FUSE_IOMAP_CONFIG_UUID		(1 << 1ULL)
+#define FUSE_IOMAP_CONFIG_BLOCKSIZE	(1 << 2ULL)
+#define FUSE_IOMAP_CONFIG_MAX_LINKS	(1 << 3ULL)
+#define FUSE_IOMAP_CONFIG_TIME		(1 << 4ULL)
+#define FUSE_IOMAP_CONFIG_MAXBYTES	(1 << 5ULL)
+
+struct fuse_iomap_config_out {
+	uint64_t flags;		/* FUSE_IOMAP_CONFIG_* */
+
+	char s_id[32];		/* Informational name */
+	char s_uuid[16];	/* UUID */
+
+	uint8_t s_uuid_len;	/* length of s_uuid */
+
+	uint8_t s_pad[3];	/* must be zeroes */
+
+	uint32_t s_blocksize;	/* fs block size */
+	uint32_t s_max_links;	/* max hard links */
+
+	/* Granularity of c/m/atime in ns (cannot be worse than a second) */
+	uint32_t s_time_gran;
+
+	/* Time limits for c/m/atime in seconds */
+	int64_t s_time_min;
+	int64_t s_time_max;
+
+	int64_t s_maxbytes;	/* max file size */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 3395b1cd907afa..d9be7d47fb7acd 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -718,14 +718,103 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
 	.post_open = fuse_iomap_post_open,
 };
 
-void fuse_iomap_mount(struct fuse_mount *fm)
+struct fuse_iomap_config_args {
+	struct fuse_args args;
+	struct fuse_iomap_config_in inarg;
+	struct fuse_iomap_config_out outarg;
+};
+
+#define FUSE_IOMAP_CONFIG_ALL (FUSE_IOMAP_CONFIG_SID | \
+			       FUSE_IOMAP_CONFIG_UUID | \
+			       FUSE_IOMAP_CONFIG_BLOCKSIZE | \
+			       FUSE_IOMAP_CONFIG_MAX_LINKS | \
+			       FUSE_IOMAP_CONFIG_TIME | \
+			       FUSE_IOMAP_CONFIG_MAXBYTES)
+
+static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
+				     const struct fuse_iomap_config_out *outarg)
 {
+	struct super_block *sb = fm->sb;
+
+	switch (error) {
+	case 0:
+		break;
+	case -ENOSYS:
+		return 0;
+	default:
+		return error;
+	}
+
+	if (outarg->flags & ~FUSE_IOMAP_CONFIG_ALL)
+		return -EINVAL;
+
+	if (outarg->s_uuid_len > sizeof(outarg->s_uuid))
+		return -EINVAL;
+
+	if (memchr_inv(outarg->s_pad, 0, sizeof(outarg->s_pad)))
+		return -EINVAL;
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_BLOCKSIZE) {
+		if (sb->s_bdev) {
+#ifdef CONFIG_BLOCK
+			if (!sb_set_blocksize(sb, outarg->s_blocksize))
+				return -EINVAL;
+#else
+			/*
+			 * XXX: how do we have a bdev filesystem without
+			 * CONFIG_BLOCK???
+			 */
+			return -EINVAL;
+#endif
+		} else {
+			sb->s_blocksize = outarg->s_blocksize;
+			sb->s_blocksize_bits = blksize_bits(outarg->s_blocksize);
+		}
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_SID)
+		memcpy(sb->s_id, outarg->s_id, sizeof(sb->s_id));
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_UUID) {
+		memcpy(&sb->s_uuid, outarg->s_uuid, outarg->s_uuid_len);
+		sb->s_uuid_len = outarg->s_uuid_len;
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_MAX_LINKS)
+		sb->s_max_links = outarg->s_max_links;
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_TIME) {
+		sb->s_time_gran = outarg->s_time_gran;
+		sb->s_time_min = outarg->s_time_min;
+		sb->s_time_max = outarg->s_time_max;
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_MAXBYTES)
+		sb->s_maxbytes = outarg->s_maxbytes;
+
+	return 0;
+}
+
+static void fuse_iomap_config_reply(struct fuse_mount *fm,
+				    struct fuse_args *args, int error)
+{
+	struct fuse_iomap_config_args *ia =
+		container_of(args, struct fuse_iomap_config_args, args);
 	struct fuse_conn *fc = fm->fc;
 	struct super_block *sb = fm->sb;
 	struct backing_dev_info *old_bdi = sb->s_bdi;
 	char *suffix = sb->s_bdev ? "-fuseblk" : "-fuse";
+	bool ok = true;
 	int res;
 
+	res = fuse_iomap_process_config(fm, error, &ia->outarg);
+	if (res) {
+		printk(KERN_ERR "%s: could not configure iomap, err=%d",
+		       sb->s_id, res);
+		ok = false;
+		goto done;
+	}
+
 	/*
 	 * sb->s_bdi points to the initial private bdi.  However, we want to
 	 * redirect it to a new private bdi with default dirty and readahead
@@ -749,6 +838,62 @@ void fuse_iomap_mount(struct fuse_mount *fm)
 	 * freeze/thaw properly.
 	 */
 	fc->sync_fs = true;
+
+done:
+	kfree(ia);
+	fuse_finish_init(fc, ok);
+}
+
+static struct fuse_iomap_config_args *
+fuse_iomap_new_mount(struct fuse_mount *fm)
+{
+	struct fuse_iomap_config_args *ia;
+
+	ia = kzalloc(sizeof(*ia), GFP_KERNEL | __GFP_NOFAIL);
+	ia->inarg.maxbytes = MAX_LFS_FILESIZE;
+	ia->inarg.flags = FUSE_IOMAP_CONFIG_ALL;
+
+	ia->args.opcode = FUSE_IOMAP_CONFIG;
+	ia->args.nodeid = 0;
+	ia->args.in_numargs = 1;
+	ia->args.in_args[0].size = sizeof(ia->inarg);
+	ia->args.in_args[0].value = &ia->inarg;
+	ia->args.out_argvar = true;
+	ia->args.out_numargs = 1;
+	ia->args.out_args[0].size = sizeof(ia->outarg);
+	ia->args.out_args[0].value = &ia->outarg;
+	ia->args.force = true;
+	ia->args.nocreds = true;
+
+	return ia;
+}
+
+int fuse_iomap_mount(struct fuse_mount *fm)
+{
+	struct fuse_iomap_config_args *ia = fuse_iomap_new_mount(fm);
+	int err;
+
+	ASSERT(fm->fc->sync_init);
+
+	err = fuse_simple_request(fm, &ia->args);
+	/* Ignore size of iomap_config reply */
+	if (err > 0)
+		err = 0;
+	fuse_iomap_config_reply(fm, &ia->args, err);
+	return err;
+}
+
+void fuse_iomap_mount_async(struct fuse_mount *fm)
+{
+	struct fuse_iomap_config_args *ia = fuse_iomap_new_mount(fm);
+	int err;
+
+	ASSERT(!fm->fc->sync_init);
+
+	ia->args.end = fuse_iomap_config_reply;
+	err = fuse_simple_background(fm, &ia->args, GFP_KERNEL);
+	if (err)
+		fuse_iomap_config_reply(fm, &ia->args, -ENOTCONN);
 }
 
 void fuse_iomap_unmount(struct fuse_mount *fm)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 039a780749da30..4d805c7f484517 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1354,6 +1354,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 	struct fuse_init_out *arg = &ia->out;
 	bool ok = true;
 
+	atomic_inc(&fc->need_init);
+
 	if (error || arg->major != FUSE_KERNEL_VERSION)
 		ok = false;
 	else {
@@ -1500,9 +1502,6 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 		init_server_timeout(fc, timeout);
 
-		if (fc->iomap)
-			fuse_iomap_mount(fm);
-
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
 		fc->minor = arg->minor;
@@ -1512,13 +1511,27 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 	}
 	kfree(ia);
 
-	if (!ok) {
+	if (!ok)
 		fc->conn_init = 0;
+
+	if (ok && fc->iomap) {
+		atomic_inc(&fc->need_init);
+		if (!fc->sync_init)
+			fuse_iomap_mount_async(fm);
+	}
+
+	fuse_finish_init(fc, ok);
+}
+
+void fuse_finish_init(struct fuse_conn *fc, bool ok)
+{
+	if (!ok)
 		fc->conn_error = 1;
-	}
 
-	fuse_set_initialized(fc);
-	wake_up_all(&fc->blocked_waitq);
+	if (atomic_dec_and_test(&fc->need_init)) {
+		fuse_set_initialized(fc);
+		wake_up_all(&fc->blocked_waitq);
+	}
 }
 
 static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
@@ -1995,7 +2008,20 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 
 	fm = get_fuse_mount_super(sb);
 
-	return fuse_send_init(fm);
+	err = fuse_send_init(fm);
+	if (err)
+		return err;
+
+	if (fm->fc->conn_init && fm->fc->sync_init && fm->fc->iomap) {
+		err = fuse_iomap_mount(fm);
+		if (err)
+			return err;
+	}
+
+	if (fm->fc->conn_error)
+		return -EIO;
+
+	return 0;
 }
 
 /*


