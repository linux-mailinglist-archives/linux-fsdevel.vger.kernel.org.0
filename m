Return-Path: <linux-fsdevel+bounces-59357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B47D7B38074
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 13:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856DF1BA5E3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883E734DCE8;
	Wed, 27 Aug 2025 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jM1E90Rf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2D729C321
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292416; cv=none; b=uRTFgFhlYf0qt9q8ucOO8oXnTFc5lHPue4cgPfiN9SgPCaFI+JIKlBZLL+oJjwW1CTelvvsMBJW9tti4yNnbEdOBfwVFht547X2s74JqaZdVlqICTRg1rY3qg/HatrwnSWu7lILlRM+04NsdJH4ow+z7TPogxpE92RL3fm8Wc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292416; c=relaxed/simple;
	bh=oYMd0pDFc52u95We+BmYTEN1PCIiIq349oYD+ZxqP5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8ekD3lSVTSG8/ScGAl21CnlogTJgsvWwErtdlYrtAiYbsK5vd3smbn9KswdbyKxXcMUxxopXHql4Ji+UYoNoABWg6vhWsMvPNGaxr/ytfTipPc2M4VCv12hnu7yJ9PeNzXzHOxpC+jKCJt+TbB8cFOefwDUV/HEqN9D5GSUnfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jM1E90Rf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756292410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1g24Lg93QQsHqeKUQ9RfhstvU2XnRZhmQeK48Wc2V2I=;
	b=jM1E90RfgfuWiiw60VCtp8LsiLW+RoEERNVax4zxNlazCsawhxqn/ZuHulr0oUA8Y4GwZQ
	v+zhyLkMDBE1wdcFC9ihAmn4FhYm+DSIAWUkeoddyEe2d8dL8DW1UH7bvOi4L3rOcZWGIa
	y51w2eXCV20A/mF1fmFp9HEwY04naOw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-fXZK_2sOMA61uSLqUogtIQ-1; Wed, 27 Aug 2025 07:00:09 -0400
X-MC-Unique: fXZK_2sOMA61uSLqUogtIQ-1
X-Mimecast-MFC-AGG-ID: fXZK_2sOMA61uSLqUogtIQ_1756292408
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3cccba2f06bso163480f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 04:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756292408; x=1756897208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1g24Lg93QQsHqeKUQ9RfhstvU2XnRZhmQeK48Wc2V2I=;
        b=MOMMkTqYLVDY89QYns9Lk68maQ5zBgH2fU5P7Fh1nED+L/HnlRfENNFKAafzqBpIJn
         Z7SnjyS70rxcJsxJyRx8FQa9PhZVFzInx9DgmqLv65Vd6mPTVGEEQ79OttnGsJKPWKXY
         L7+mbEsJM5LUwwILc7BPARCpsHGVel0kbJ5S4cp3IegYHI1NoOjjBiG6nq5zC4cES/m9
         nvNK7Sli6biWsIoTB0ervDF1NIlExhbee5tFSlCDiEkfJWi9YREGx4x1CMne4ejasCYC
         c4vvQWR5bTtaJM/gx6IX17TpXI5x8BiE818o/vdihpFKqX0cZ+55ZUdkwgyiYb637OTp
         mgVw==
X-Gm-Message-State: AOJu0Yy9Gx8g1xVlwqx7Y/uC3PFFCHZ7rZFIob8kDXgER5t9pU9IT7kz
	ROdfEInrKm1EX0PdfXMncPeEqVPLRGGqdFuVHfc+eCjY5WcjT/LWlGV7puzTn9DAFEaCeK/rcCG
	9WNmePx5SMoaA14CmaiWSm/ph8Aix3firIf6XTHY9cOt8FwEUO9lLbvuaFnIY/lD0XrKQBapdJj
	1tuutYK+rjf5Kc6SBTvHUJDbX7YmPoT2tw/2qztM+lb0WUPgISOlf1Yg==
X-Gm-Gg: ASbGncsWYG3ZH5Un/VFG4Wno/bJhoYZffeA3qbYpsLadjdUZ7159Wbwh/9EnRCMuILa
	q86Rc1U0XnkDRKsLVdu8XIYTBDyL5EbGMgoouHhZLCdZxF1p4a+ZpduLrCjj11c/gYw0q5KBYkJ
	llzmZdRJ9kdgS4ffToju01PfqXXLULCF8fWYyUQClFOe888F0Nbk0HgH06eUgpFmdbKAkvVnQRX
	Dy8R2ACOGXQWUYJO1iC4DhyR6s5rGQ0Rttsc2428cRj3CzEpxN4XcWeqxy7AQetsDLC0WxjRBNF
	7fhviWLNIM5vuOiqqFylUTDeiH4LPK1LAq7mOW2ePJqAiA9FE2I4Zxfw8lsvVt9qZGZIP1vx8UL
	7/07GVkA63yqv7AggJMa+n7o=
X-Received: by 2002:a05:6000:2289:b0:3c9:4e1f:ef46 with SMTP id ffacd0b85a97d-3c94e1ff656mr8389712f8f.48.1756292407383;
        Wed, 27 Aug 2025 04:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuiQWtcx4OeSUJHAVr1IAL/ykl8tNIWvwkmpPxhdH9fenOna36mmEUEqQw/Cg4ffGh6uPBJQ==
X-Received: by 2002:a05:6000:2289:b0:3c9:4e1f:ef46 with SMTP id ffacd0b85a97d-3c94e1ff656mr8389666f8f.48.1756292406646;
        Wed, 27 Aug 2025 04:00:06 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (193-226-246-133.pool.digikabel.hu. [193.226.246.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211cc8sm20016212f8f.36.2025.08.27.04.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 04:00:06 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	John Groves <John@groves.net>,
	Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v2] fuse: allow synchronous FUSE_INIT
Date: Wed, 27 Aug 2025 12:59:55 +0200
Message-ID: <20250827110004.584582-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FUSE_INIT has always been asynchronous with mount.  That means that the
server processed this request after the mount syscall returned.

This means that FUSE_INIT can't supply the root inode's ID, hence it
currently has a hardcoded value.  There are other limitations such as not
being able to perform getxattr during mount, which is needed by selinux.

To remove these limitations allow server to process FUSE_INIT while
initializing the in-core super block for the fuse filesystem.  This can
only be done if the server is prepared to handle this, so add
FUSE_DEV_IOC_SYNC_INIT ioctl, which

 a) lets the server know whether this feature is supported, returning
 ENOTTY othewrwise.

 b) lets the kernel know to perform a synchronous initialization

The implementation is slightly tricky, since fuse_dev/fuse_conn are set up
only during super block creation.  This is solved by setting the private
data of the fuse device file to a special value ((struct fuse_dev *) 1) and
waiting for this to be turned into a proper fuse_dev before commecing with
operations on the device file.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
v2:

 - make fuse_send_init() perform sync/async sequence based on fc->sync_init
   (Joanne)

fs/fuse/cuse.c            |  3 +-
 fs/fuse/dev.c             | 74 +++++++++++++++++++++++++++++----------
 fs/fuse/dev_uring.c       |  4 +--
 fs/fuse/fuse_dev_i.h      | 13 +++++--
 fs/fuse/fuse_i.h          |  5 ++-
 fs/fuse/inode.c           | 50 ++++++++++++++++++++------
 include/uapi/linux/fuse.h |  1 +
 7 files changed, 115 insertions(+), 35 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index b39844d75a80..28c96961e85d 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -52,6 +52,7 @@
 #include <linux/user_namespace.h>
 
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 
 #define CUSE_CONNTBL_LEN	64
 
@@ -547,7 +548,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
  */
 static int cuse_channel_release(struct inode *inode, struct file *file)
 {
-	struct fuse_dev *fud = file->private_data;
+	struct fuse_dev *fud = __fuse_get_dev(file);
 	struct cuse_conn *cc = fc_to_cc(fud->fc);
 
 	/* remove from the conntbl, no more access from this point on */
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8ac074414897..948f45c6e0ef 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1530,14 +1530,34 @@ static int fuse_dev_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+struct fuse_dev *fuse_get_dev(struct file *file)
+{
+	struct fuse_dev *fud = __fuse_get_dev(file);
+	int err;
+
+	if (likely(fud))
+		return fud;
+
+	err = wait_event_interruptible(fuse_dev_waitq,
+				       READ_ONCE(file->private_data) != FUSE_DEV_SYNC_INIT);
+	if (err)
+		return ERR_PTR(err);
+
+	fud = __fuse_get_dev(file);
+	if (!fud)
+		return ERR_PTR(-EPERM);
+
+	return fud;
+}
+
 static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct fuse_copy_state cs;
 	struct file *file = iocb->ki_filp;
 	struct fuse_dev *fud = fuse_get_dev(file);
 
-	if (!fud)
-		return -EPERM;
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
 	if (!user_backed_iter(to))
 		return -EINVAL;
@@ -1557,8 +1577,8 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 	struct fuse_copy_state cs;
 	struct fuse_dev *fud = fuse_get_dev(in);
 
-	if (!fud)
-		return -EPERM;
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
 	bufs = kvmalloc_array(pipe->max_usage, sizeof(struct pipe_buffer),
 			      GFP_KERNEL);
@@ -2233,8 +2253,8 @@ static ssize_t fuse_dev_write(struct kiocb *iocb, struct iov_iter *from)
 	struct fuse_copy_state cs;
 	struct fuse_dev *fud = fuse_get_dev(iocb->ki_filp);
 
-	if (!fud)
-		return -EPERM;
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
 	if (!user_backed_iter(from))
 		return -EINVAL;
@@ -2258,8 +2278,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	ssize_t ret;
 
 	fud = fuse_get_dev(out);
-	if (!fud)
-		return -EPERM;
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
 	pipe_lock(pipe);
 
@@ -2343,7 +2363,7 @@ static __poll_t fuse_dev_poll(struct file *file, poll_table *wait)
 	struct fuse_iqueue *fiq;
 	struct fuse_dev *fud = fuse_get_dev(file);
 
-	if (!fud)
+	if (IS_ERR(fud))
 		return EPOLLERR;
 
 	fiq = &fud->fc->iq;
@@ -2490,7 +2510,7 @@ void fuse_wait_aborted(struct fuse_conn *fc)
 
 int fuse_dev_release(struct inode *inode, struct file *file)
 {
-	struct fuse_dev *fud = fuse_get_dev(file);
+	struct fuse_dev *fud = __fuse_get_dev(file);
 
 	if (fud) {
 		struct fuse_conn *fc = fud->fc;
@@ -2521,8 +2541,8 @@ static int fuse_dev_fasync(int fd, struct file *file, int on)
 {
 	struct fuse_dev *fud = fuse_get_dev(file);
 
-	if (!fud)
-		return -EPERM;
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
 	/* No locking - fasync_helper does its own locking */
 	return fasync_helper(fd, file, on, &fud->fc->iq.fasync);
@@ -2532,7 +2552,7 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 {
 	struct fuse_dev *fud;
 
-	if (new->private_data)
+	if (__fuse_get_dev(new))
 		return -EINVAL;
 
 	fud = fuse_dev_alloc_install(fc);
@@ -2563,7 +2583,7 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 	 * uses the same ioctl handler.
 	 */
 	if (fd_file(f)->f_op == file->f_op)
-		fud = fuse_get_dev(fd_file(f));
+		fud = __fuse_get_dev(fd_file(f));
 
 	res = -EINVAL;
 	if (fud) {
@@ -2581,8 +2601,8 @@ static long fuse_dev_ioctl_backing_open(struct file *file,
 	struct fuse_dev *fud = fuse_get_dev(file);
 	struct fuse_backing_map map;
 
-	if (!fud)
-		return -EPERM;
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
 	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		return -EOPNOTSUPP;
@@ -2598,8 +2618,8 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	struct fuse_dev *fud = fuse_get_dev(file);
 	int backing_id;
 
-	if (!fud)
-		return -EPERM;
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
 	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		return -EOPNOTSUPP;
@@ -2610,6 +2630,19 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	return fuse_backing_close(fud->fc, backing_id);
 }
 
+static long fuse_dev_ioctl_sync_init(struct file *file)
+{
+	int err = -EINVAL;
+
+	mutex_lock(&fuse_mutex);
+	if (!__fuse_get_dev(file)) {
+		WRITE_ONCE(file->private_data, FUSE_DEV_SYNC_INIT);
+		err = 0;
+	}
+	mutex_unlock(&fuse_mutex);
+	return err;
+}
+
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
@@ -2625,6 +2658,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_BACKING_CLOSE:
 		return fuse_dev_ioctl_backing_close(file, argp);
 
+	case FUSE_DEV_IOC_SYNC_INIT:
+		return fuse_dev_ioctl_sync_init(file);
+
 	default:
 		return -ENOTTY;
 	}
@@ -2633,7 +2669,7 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 #ifdef CONFIG_PROC_FS
 static void fuse_dev_show_fdinfo(struct seq_file *seq, struct file *file)
 {
-	struct fuse_dev *fud = fuse_get_dev(file);
+	struct fuse_dev *fud = __fuse_get_dev(file);
 	if (!fud)
 		return;
 
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 249b210becb1..bef38ed78249 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1139,9 +1139,9 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		return -EINVAL;
 
 	fud = fuse_get_dev(cmd->file);
-	if (!fud) {
+	if (IS_ERR(fud)) {
 		pr_info_ratelimited("No fuse device found\n");
-		return -ENOTCONN;
+		return PTR_ERR(fud);
 	}
 	fc = fud->fc;
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 5a9bd771a319..6e8373f97040 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -12,6 +12,8 @@
 #define FUSE_INT_REQ_BIT (1ULL << 0)
 #define FUSE_REQ_ID_STEP (1ULL << 1)
 
+extern struct wait_queue_head fuse_dev_waitq;
+
 struct fuse_arg;
 struct fuse_args;
 struct fuse_pqueue;
@@ -37,15 +39,22 @@ struct fuse_copy_state {
 	} ring;
 };
 
-static inline struct fuse_dev *fuse_get_dev(struct file *file)
+#define FUSE_DEV_SYNC_INIT ((struct fuse_dev *) 1)
+#define FUSE_DEV_PTR_MASK (~1UL)
+
+static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 {
 	/*
 	 * Lockless access is OK, because file->private data is set
 	 * once during mount and is valid until the file is released.
 	 */
-	return READ_ONCE(file->private_data);
+	struct fuse_dev *fud = READ_ONCE(file->private_data);
+
+	return (typeof(fud)) ((unsigned long) fud & FUSE_DEV_PTR_MASK);
 }
 
+struct fuse_dev *fuse_get_dev(struct file *file);
+
 unsigned int fuse_req_hash(u64 unique);
 struct fuse_req *fuse_request_find(struct fuse_pqueue *fpq, u64 unique);
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 486fa550c951..233c6111f768 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -904,6 +904,9 @@ struct fuse_conn {
 	/* Is link not implemented by fs? */
 	unsigned int no_link:1;
 
+	/* Is synchronous FUSE_INIT allowed? */
+	unsigned int sync_init:1;
+
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
@@ -1318,7 +1321,7 @@ struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
 struct fuse_dev *fuse_dev_alloc(void);
 void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
 void fuse_dev_free(struct fuse_dev *fud);
-void fuse_send_init(struct fuse_mount *fm);
+int fuse_send_init(struct fuse_mount *fm);
 
 /**
  * Fill in superblock and initialize fuse connection
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 9d26a5bc394d..7cf47d5bcc87 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 #include "dev_uring_i.h"
 
 #include <linux/dax.h>
@@ -34,6 +35,7 @@ MODULE_LICENSE("GPL");
 static struct kmem_cache *fuse_inode_cachep;
 struct list_head fuse_conn_list;
 DEFINE_MUTEX(fuse_mutex);
+DECLARE_WAIT_QUEUE_HEAD(fuse_dev_waitq);
 
 static int set_global_limit(const char *val, const struct kernel_param *kp);
 
@@ -1466,7 +1468,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 	wake_up_all(&fc->blocked_waitq);
 }
 
-void fuse_send_init(struct fuse_mount *fm)
+static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 {
 	struct fuse_init_args *ia;
 	u64 flags;
@@ -1525,10 +1527,29 @@ void fuse_send_init(struct fuse_mount *fm)
 	ia->args.out_args[0].value = &ia->out;
 	ia->args.force = true;
 	ia->args.nocreds = true;
-	ia->args.end = process_init_reply;
 
-	if (fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
-		process_init_reply(fm, &ia->args, -ENOTCONN);
+	return ia;
+}
+
+int fuse_send_init(struct fuse_mount *fm)
+{
+	struct fuse_init_args *ia = fuse_new_init(fm);
+	int err;
+
+	if (fm->fc->sync_init) {
+		err = fuse_simple_request(fm, &ia->args);
+		/* Ignore size of init reply */
+		if (err > 0)
+			err = 0;
+	} else {
+		ia->args.end = process_init_reply;
+		err = fuse_simple_background(fm, &ia->args, GFP_KERNEL);
+		if (!err)
+			return 0;
+		err = -ENOTCONN;
+	}
+	process_init_reply(fm, &ia->args, err);
+	return err;
 }
 EXPORT_SYMBOL_GPL(fuse_send_init);
 
@@ -1867,8 +1888,12 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
-	if (ctx->fudptr && *ctx->fudptr)
-		goto err_unlock;
+	if (ctx->fudptr && *ctx->fudptr) {
+		if (*ctx->fudptr == FUSE_DEV_SYNC_INIT) {
+			fc->sync_init = 1;
+		} else
+			goto err_unlock;
+	}
 
 	err = fuse_ctl_add_conn(fc);
 	if (err)
@@ -1876,8 +1901,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
-	if (ctx->fudptr)
+	if (ctx->fudptr) {
 		*ctx->fudptr = fud;
+		wake_up_all(&fuse_dev_waitq);
+	}
 	mutex_unlock(&fuse_mutex);
 	return 0;
 
@@ -1898,6 +1925,7 @@ EXPORT_SYMBOL_GPL(fuse_fill_super_common);
 static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 {
 	struct fuse_fs_context *ctx = fsc->fs_private;
+	struct fuse_mount *fm;
 	int err;
 
 	if (!ctx->file || !ctx->rootmode_present ||
@@ -1918,8 +1946,10 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 		return err;
 	/* file->private_data shall be visible on all CPUs after this */
 	smp_mb();
-	fuse_send_init(get_fuse_mount_super(sb));
-	return 0;
+
+	fm = get_fuse_mount_super(sb);
+
+	return fuse_send_init(fm);
 }
 
 /*
@@ -1980,7 +2010,7 @@ static int fuse_get_tree(struct fs_context *fsc)
 	 * Allow creating a fuse mount with an already initialized fuse
 	 * connection
 	 */
-	fud = READ_ONCE(ctx->file->private_data);
+	fud = __fuse_get_dev(ctx->file);
 	if (ctx->file->f_op == &fuse_dev_operations && fud) {
 		fsc->sget_key = fud->fc;
 		sb = sget_fc(fsc, fuse_test_super, fuse_set_no_super);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 3942d1fda599..30bf0846547f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1130,6 +1130,7 @@ struct fuse_backing_map {
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.49.0


