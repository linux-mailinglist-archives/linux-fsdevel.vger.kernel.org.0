Return-Path: <linux-fsdevel+bounces-50442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 310B7ACC3B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 11:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E4F173940
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF31D2857FC;
	Tue,  3 Jun 2025 09:54:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949EA2820BF;
	Tue,  3 Jun 2025 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944441; cv=none; b=ebukuInO0clMdH16FtJ+2z6GWp3x6Q5qZ1DHT42KiVZ50LxCie/kX02A67kwxLOXvZCAvGjznt+Di6Tg10fPIi20YkIoSfZ61ZuukTx9GVzL35CRDWGmMsOGL4WK1Gb9apF3jjhr/6eVDvDkIDCuwWkUR3DTrLQ08x19wV/yIdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944441; c=relaxed/simple;
	bh=yUi7+p00jMqRela2NQwhtGNLkrlaHVdgOe80QIGCYOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYEm//TFq9LpzWXwTdR2e9pq/gLV66i8mnHMVPS3ne5x2LB5gLgoXJO5sJNWvsrj4GZH86Z/NaobWSZg+yOGCKgSgJRXRo9GuhY0VbR0Osdg5KSsAE+4ViRAtmTeqxF+uyjpgzY+NMXTKIJa9OB2jc2TuEfdSMHUNIpJmSg2VCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4bBQw53G5YzYlP5Y;
	Tue,  3 Jun 2025 17:51:33 +0800 (CST)
Received: from a010.hihonor.com (10.68.16.52) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Jun
 2025 17:53:50 +0800
Received: from localhost.localdomain (10.144.18.117) by a010.hihonor.com
 (10.68.16.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Jun
 2025 17:53:50 +0800
From: wangtao <tao.wangtao@honor.com>
To: <sumit.semwal@linaro.org>, <christian.koenig@amd.com>,
	<kraxel@redhat.com>, <vivek.kasireddy@intel.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <hughd@google.com>, <akpm@linux-foundation.org>,
	<amir73il@gmail.com>
CC: <benjamin.gaignard@collabora.com>, <Brian.Starkey@arm.com>,
	<jstultz@google.com>, <tjmercier@google.com>, <jack@suse.cz>,
	<baolin.wang@linux.alibaba.com>, <linux-media@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <bintian.wang@honor.com>, <yipengxiang@honor.com>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, wangtao <tao.wangtao@honor.com>
Subject: [PATCH v4 1/4] fs: allow cross-FS copy_file_range for memory file with direct I/O
Date: Tue, 3 Jun 2025 17:52:42 +0800
Message-ID: <20250603095245.17478-2-tao.wangtao@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250603095245.17478-1-tao.wangtao@honor.com>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a010.hihonor.com
 (10.68.16.52)

Memory files can optimize copy performance via copy_file_range callbacks:
-Compared to mmap&read: reduces GUP (get_user_pages) overhead
-Compared to sendfile/splice: eliminates one memory copy
-Supports dma-buf direct I/O zero-copy implementation

Suggested by: Christian König <christian.koenig@amd.com>
Suggested by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: wangtao <tao.wangtao@honor.com>
---
 fs/read_write.c    | 64 +++++++++++++++++++++++++++++++++++++---------
 include/linux/fs.h |  2 ++
 2 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index bb0ed26a0b3a..ecb4f753c632 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1469,6 +1469,31 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
 }
 #endif
 
+static const struct file_operations *memory_copy_file_ops(
+			struct file *file_in, struct file *file_out)
+{
+	if ((file_in->f_op->fop_flags & FOP_MEMORY_FILE) &&
+	    (file_in->f_mode & FMODE_CAN_ODIRECT) &&
+	    file_in->f_op->copy_file_range && file_out->f_op->write_iter)
+		return file_in->f_op;
+	else if ((file_out->f_op->fop_flags & FOP_MEMORY_FILE) &&
+		 (file_out->f_mode & FMODE_CAN_ODIRECT) &&
+		 file_in->f_op->read_iter && file_out->f_op->copy_file_range)
+		return file_out->f_op;
+	else
+		return NULL;
+}
+
+static int essential_file_rw_checks(struct file *file_in, struct file *file_out)
+{
+	if (!(file_in->f_mode & FMODE_READ) ||
+	    !(file_out->f_mode & FMODE_WRITE) ||
+	    (file_out->f_flags & O_APPEND))
+		return -EBADF;
+
+	return 0;
+}
+
 /*
  * Performs necessary checks before doing a file copy
  *
@@ -1484,9 +1509,16 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	struct inode *inode_out = file_inode(file_out);
 	uint64_t count = *req_count;
 	loff_t size_in;
+	bool splice = flags & COPY_FILE_SPLICE;
+	const struct file_operations *mem_fops;
 	int ret;
 
-	ret = generic_file_rw_checks(file_in, file_out);
+	/* The dma-buf file is not a regular file. */
+	mem_fops = memory_copy_file_ops(file_in, file_out);
+	if (splice || mem_fops == NULL)
+		ret = generic_file_rw_checks(file_in, file_out);
+	else
+		ret = essential_file_rw_checks(file_in, file_out);
 	if (ret)
 		return ret;
 
@@ -1500,8 +1532,10 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	 * and several different sets of file_operations, but they all end up
 	 * using the same ->copy_file_range() function pointer.
 	 */
-	if (flags & COPY_FILE_SPLICE) {
+	if (splice) {
 		/* cross sb splice is allowed */
+	} else if (mem_fops != NULL) {
+		/* cross-fs copy is allowed for memory file. */
 	} else if (file_out->f_op->copy_file_range) {
 		if (file_in->f_op->copy_file_range !=
 		    file_out->f_op->copy_file_range)
@@ -1554,6 +1588,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	ssize_t ret;
 	bool splice = flags & COPY_FILE_SPLICE;
 	bool samesb = file_inode(file_in)->i_sb == file_inode(file_out)->i_sb;
+	const struct file_operations *mem_fops;
 
 	if (flags & ~COPY_FILE_SPLICE)
 		return -EINVAL;
@@ -1574,18 +1609,27 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (len == 0)
 		return 0;
 
+	if (splice)
+		goto do_splice;
+
 	file_start_write(file_out);
 
 	/*
 	 * Cloning is supported by more file systems, so we implement copy on
 	 * same sb using clone, but for filesystems where both clone and copy
 	 * are supported (e.g. nfs,cifs), we only call the copy method.
+	 * For copy to/from memory file, we alway call the copy method of the
+	 * memory file.
 	 */
-	if (!splice && file_out->f_op->copy_file_range) {
+	mem_fops = memory_copy_file_ops(file_in, file_out);
+	if (mem_fops) {
+		ret = mem_fops->copy_file_range(file_in, pos_in,
+					file_out, pos_out, len, flags);
+	} else if (file_out->f_op->copy_file_range) {
 		ret = file_out->f_op->copy_file_range(file_in, pos_in,
-						      file_out, pos_out,
-						      len, flags);
-	} else if (!splice && file_in->f_op->remap_file_range && samesb) {
+						file_out, pos_out,
+						len, flags);
+	} else if (file_in->f_op->remap_file_range && samesb) {
 		ret = file_in->f_op->remap_file_range(file_in, pos_in,
 				file_out, pos_out,
 				min_t(loff_t, MAX_RW_COUNT, len),
@@ -1603,6 +1647,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (!splice)
 		goto done;
 
+do_splice:
 	/*
 	 * We can get here for same sb copy of filesystems that do not implement
 	 * ->copy_file_range() in case filesystem does not support clone or in
@@ -1786,12 +1831,7 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
 		return -EINVAL;
 
-	if (!(file_in->f_mode & FMODE_READ) ||
-	    !(file_out->f_mode & FMODE_WRITE) ||
-	    (file_out->f_flags & O_APPEND))
-		return -EBADF;
-
-	return 0;
+	return essential_file_rw_checks(file_in, file_out);
 }
 
 int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..37df1b497418 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2187,6 +2187,8 @@ struct file_operations {
 #define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 6))
 /* File system supports uncached read/write buffered IO */
 #define FOP_DONTCACHE		((__force fop_flags_t)(1 << 7))
+/* Supports cross-FS copy_file_range for memory file */
+#define FOP_MEMORY_FILE		((__force fop_flags_t)(1 << 8))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
-- 
2.17.1


