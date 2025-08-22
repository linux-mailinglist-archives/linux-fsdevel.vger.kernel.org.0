Return-Path: <linux-fsdevel+bounces-58780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECDBB31698
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC1EB64F74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D7E2F8BFF;
	Fri, 22 Aug 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDX0sqSO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF02F1FDC
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863085; cv=none; b=U85rkcs+SU8DBMlY0qMTkaWvyMit8MTCRO7833bMgBls7Mzn3k4eRws8dz46dSs3XNfwfIbK1GPelXaCFfDq63hBgOCQHVjD8EfGAaWCOto/UpwxnIZLkz7skqxy4ImMM7esFU+yrioIKI7AV8ywuMGJj2uxy6AJFRmKwS186FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863085; c=relaxed/simple;
	bh=uuRePrqWbO9qiB7QXLjgBAQ4+jZY13LhgnE+dItv3a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DqbGtyphmQeigbNBQ3St8fbMu8OM46msb/eFLW9JLWYdSnpB1wvb0W3Xl/42+d5l15Hfo2IwumD8Hyqt7Xfvdjtaui4jCShOCmP7d/hE+TE1liUX8PDrU++oDkpCgYNqvM+pbkvkI1DipyeQ7LRE5degHkLvKpdM0GZXXNSzjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDX0sqSO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755863082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LZeZsBkIL9ciKTZ7CQVij92orr9I+eZz2oLATuvSNms=;
	b=hDX0sqSOQ/+Nsk4ZCTm9a65Wt3cQqgKmO4GVdFfdFaagr1SMD7VW27V5JVH6QC1mrEU0Wk
	gmaNhiaXbZig9SsaxG3ADfyvr0o9CfFEJpVLyCYD5zKWfEL+X3FsvTFHAVKoxQQVtiLnQU
	rVg7LOQlhOxQzgN31nNTirtdAcE5ook=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-3dz02iKlNGi-zsxWh6-fUg-1; Fri, 22 Aug 2025 07:44:41 -0400
X-MC-Unique: 3dz02iKlNGi-zsxWh6-fUg-1
X-Mimecast-MFC-AGG-ID: 3dz02iKlNGi-zsxWh6-fUg_1755863080
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b05d251so11936825e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 04:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755863080; x=1756467880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZeZsBkIL9ciKTZ7CQVij92orr9I+eZz2oLATuvSNms=;
        b=lAQzgUpligjTPisQEkWJbiQ/lSnOzVZIQQcwM799Sa1eJwxfIcjYCVj/ouLDEkyGe7
         IM2N5rRHP+E7OiP87CYc5dn76uFT6B/0ntcfIeq1h5IX82zPrDDFO4dFJl2nNaLY5Ifg
         KjzoYDCh9AnUML/wGOyWNvirkrUfhyiFP6l2ewfTXE6/JA19P0io1GQMumXgq27S9+oY
         FU8zIxUGiujQGTEABZekTe9dB/tO/d+f43s+cIp4CIRuLTwN6I1a09jHv3YmVm0xwDvi
         SoPTOLDR/Z6Ifot/BAYj+iN3U0NouhJlLvfZ0JKc0iAQF3Q6ash4u//5KkfgcM1bVDC0
         WbwA==
X-Gm-Message-State: AOJu0Yw3gw3vvgq9hUMrGwL7uQAH4G34HtAORqvaybfV1IMKZYobI801
	2QRMMbO8wiCWyu9WgaGV1PxKU7YSAcVEzNzhFaIyl9M0aEaMp6IODEB2Y7KUBH1ZTBhxC/OIpvW
	SMwfaVmL25ctI9Nv+Qm8wyhn9CkL7QqiTU6KGmDXC/j+q82toabCNdv9IPeWDStbURrxzO2rhKg
	nc838aRMpghLAmVKfmSRrbhV9LdLrSYq9OLbn3KecElun/ReWlJtXM+w==
X-Gm-Gg: ASbGncv0ZoOEbKcnsnw5DU/x1GcqL9w9WFdXbWEl5elIAznZuU31hzRcbm5REWk+Qbw
	IR0iVj0Pk31l0j3v/5F9pdPIkgEWNLv5owqiLYSQyH9nukJjg5e87oIKChqRNw0UjbLIKYIS74W
	5D/TqupVnb6e519LEhG+CpXKBNfOW+Auq+MaJQLeJvPOHPDvHEtyd9EVA3XLGjUKGnH8MdNqSsi
	vk7ytrT+jXFTbtneBwjz5/1e6AqZlJTjlcj2YBunRMGjM+75sfFz+5IOzJhcVaaGamngX8NYUAt
	+NnZc5QXemFOZf8JxfJEaGcjVZ+EnCXpu99hZ7Wg47pUaQ1Y1MQuNiy4quMMaKerx6SdGf/5aGp
	dZyhg5BNrwwqW
X-Received: by 2002:a05:600c:4e90:b0:458:a559:a693 with SMTP id 5b1f17b1804b1-45b517b957emr24394605e9.18.1755863079450;
        Fri, 22 Aug 2025 04:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCQdmJVBf/IR7KgDUXxUt3EwIRyqPSgKCFcdKKfAfT/xeoqs5WGTyT00/nBJ6XSiubcZdoAg==
X-Received: by 2002:a05:600c:4e90:b0:458:a559:a693 with SMTP id 5b1f17b1804b1-45b517b957emr24394315e9.18.1755863078864;
        Fri, 22 Aug 2025 04:44:38 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (254C12DB.nat.pool.telekom.hu. [37.76.18.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50df6d1csm33845905e9.19.2025.08.22.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:44:38 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	John Groves <John@groves.net>,
	Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH] fuse: allow synchronous FUSE_INIT
Date: Fri, 22 Aug 2025 13:44:35 +0200
Message-ID: <20250822114436.438844-1-mszeredi@redhat.com>
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
I tested this with my raw-interface tester, so no libfuse update yet.  Will
work on that next.

 fs/fuse/cuse.c            |  3 +-
 fs/fuse/dev.c             | 74 +++++++++++++++++++++++++++++----------
 fs/fuse/dev_uring.c       |  4 +--
 fs/fuse/fuse_dev_i.h      | 13 +++++--
 fs/fuse/fuse_i.h          |  3 ++
 fs/fuse/inode.c           | 46 +++++++++++++++++++-----
 include/uapi/linux/fuse.h |  1 +
 7 files changed, 112 insertions(+), 32 deletions(-)

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
index 486fa550c951..54121207cfb2 100644
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
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 9d26a5bc394d..d5f9f2abc569 100644
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
@@ -1525,8 +1527,15 @@ void fuse_send_init(struct fuse_mount *fm)
 	ia->args.out_args[0].value = &ia->out;
 	ia->args.force = true;
 	ia->args.nocreds = true;
-	ia->args.end = process_init_reply;
 
+	return ia;
+}
+
+void fuse_send_init(struct fuse_mount *fm)
+{
+	struct fuse_init_args *ia = fuse_new_init(fm);
+
+	ia->args.end = process_init_reply;
 	if (fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
 		process_init_reply(fm, &ia->args, -ENOTCONN);
 }
@@ -1867,8 +1876,12 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
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
@@ -1876,8 +1889,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
-	if (ctx->fudptr)
+	if (ctx->fudptr) {
 		*ctx->fudptr = fud;
+		wake_up_all(&fuse_dev_waitq);
+	}
 	mutex_unlock(&fuse_mutex);
 	return 0;
 
@@ -1898,6 +1913,7 @@ EXPORT_SYMBOL_GPL(fuse_fill_super_common);
 static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 {
 	struct fuse_fs_context *ctx = fsc->fs_private;
+	struct fuse_mount *fm;
 	int err;
 
 	if (!ctx->file || !ctx->rootmode_present ||
@@ -1918,8 +1934,22 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 		return err;
 	/* file->private_data shall be visible on all CPUs after this */
 	smp_mb();
-	fuse_send_init(get_fuse_mount_super(sb));
-	return 0;
+
+	fm = get_fuse_mount_super(sb);
+
+	if (fm->fc->sync_init) {
+		struct fuse_init_args *ia = fuse_new_init(fm);
+
+		err = fuse_simple_request(fm, &ia->args);
+		if (err > 0)
+			err = 0;
+		process_init_reply(fm, &ia->args, err);
+	} else {
+		fuse_send_init(fm);
+		err = 0;
+	}
+
+	return err;
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
index 94621f68a5cc..6b9fb8b08768 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1131,6 +1131,7 @@ struct fuse_backing_map {
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.49.0


