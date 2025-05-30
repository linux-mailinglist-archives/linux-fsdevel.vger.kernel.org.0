Return-Path: <linux-fsdevel+bounces-50213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95772AC8C47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 12:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A684E2AD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 10:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61B422A1EF;
	Fri, 30 May 2025 10:41:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B7022688B;
	Fri, 30 May 2025 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601662; cv=none; b=Bj1iop1GkYziXFlgMCsDamjCznHxw8L5x6y991mo714ObPFZlpeZhK823S+OevC2U1J9JYJqcqz1efhPcyfICpODnhmoH4rkqEylFmK26XbP0etD5j3rJtaErzgsh10UCqH2USqR5mCUrmNna5f0Cc4OML6l9I1CIJY+WmamhSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601662; c=relaxed/simple;
	bh=3FwFsP+bAsxLQZtn2gjT+Rh+iqx6TpoONFUb2IdXGEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCFcUTz6tWbl1GUEDnBE57dHM2WMoJQ6hhQaBdSs1VfFXNTqqSfGrDiZvW2HQo63rTVzcZxg/dTUZ9KmqR0lrB8n3sV3J5j8g1+FpuCPZAGZ21vMrmGbBprN9W6cclkL381bMni+Qgh9Gap6bhjFaRftjkDdQ2DNUC+ZIdGxQ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4b808F6vTHzYkys6;
	Fri, 30 May 2025 18:38:37 +0800 (CST)
Received: from a010.hihonor.com (10.68.16.52) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 May
 2025 18:40:52 +0800
Received: from localhost.localdomain (10.144.18.117) by a010.hihonor.com
 (10.68.16.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 May
 2025 18:40:51 +0800
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
Subject: [PATCH v3 1/4] fs: allow cross-FS copy_file_range for memory-backed files
Date: Fri, 30 May 2025 18:39:38 +0800
Message-ID: <20250530103941.11092-2-tao.wangtao@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250530103941.11092-1-tao.wangtao@honor.com>
References: <20250530103941.11092-1-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w011.hihonor.com (10.68.20.122) To a010.hihonor.com
 (10.68.16.52)

Memory-backed files can optimize copy performance via
copy_file_range callbacks. Compared to mmap&read: reduces
GUP (get_user_pages) overhead; vs sendfile/splice: eliminates
one memory copy; supports dmabuf zero-copy implementation.

Signed-off-by: wangtao <tao.wangtao@honor.com>
---
 fs/read_write.c    | 71 +++++++++++++++++++++++++++++++++-------------
 include/linux/fs.h |  2 ++
 2 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index bb0ed26a0b3a..591c6db7b785 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1469,6 +1469,20 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
 }
 #endif
 
+static inline bool is_copy_memory_file_to_file(struct file *file_in,
+				struct file *file_out)
+{
+	return (file_in->f_op->fop_flags & FOP_MEMORY_FILE) &&
+		file_in->f_op->copy_file_range && file_out->f_op->write_iter;
+}
+
+static inline bool is_copy_file_to_memory_file(struct file *file_in,
+				struct file *file_out)
+{
+	return (file_out->f_op->fop_flags & FOP_MEMORY_FILE) &&
+		file_in->f_op->read_iter && file_out->f_op->copy_file_range;
+}
+
 /*
  * Performs necessary checks before doing a file copy
  *
@@ -1484,11 +1498,23 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	struct inode *inode_out = file_inode(file_out);
 	uint64_t count = *req_count;
 	loff_t size_in;
+	bool splice = flags & COPY_FILE_SPLICE;
+	bool has_memory_file;
 	int ret;
 
-	ret = generic_file_rw_checks(file_in, file_out);
-	if (ret)
-		return ret;
+	/* Skip generic checks, allow cross-sb copies for dma-buf/tmpfs */
+	has_memory_file = is_copy_memory_file_to_file(file_in, file_out) ||
+			  is_copy_file_to_memory_file(file_in, file_out);
+	if (!splice && has_memory_file) {
+		if (!(file_in->f_mode & FMODE_READ) ||
+		    !(file_out->f_mode & FMODE_WRITE) ||
+		    (file_out->f_flags & O_APPEND))
+			return -EBADF;
+	} else {
+		ret = generic_file_rw_checks(file_in, file_out);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * We allow some filesystems to handle cross sb copy, but passing
@@ -1500,7 +1526,7 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	 * and several different sets of file_operations, but they all end up
 	 * using the same ->copy_file_range() function pointer.
 	 */
-	if (flags & COPY_FILE_SPLICE) {
+	if (splice || has_memory_file) {
 		/* cross sb splice is allowed */
 	} else if (file_out->f_op->copy_file_range) {
 		if (file_in->f_op->copy_file_range !=
@@ -1581,23 +1607,30 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	 * same sb using clone, but for filesystems where both clone and copy
 	 * are supported (e.g. nfs,cifs), we only call the copy method.
 	 */
-	if (!splice && file_out->f_op->copy_file_range) {
-		ret = file_out->f_op->copy_file_range(file_in, pos_in,
-						      file_out, pos_out,
-						      len, flags);
-	} else if (!splice && file_in->f_op->remap_file_range && samesb) {
-		ret = file_in->f_op->remap_file_range(file_in, pos_in,
-				file_out, pos_out,
-				min_t(loff_t, MAX_RW_COUNT, len),
-				REMAP_FILE_CAN_SHORTEN);
-		/* fallback to splice */
-		if (ret <= 0)
+	if (!splice) {
+		if (is_copy_memory_file_to_file(file_in, file_out)) {
+			ret = file_in->f_op->copy_file_range(file_in, pos_in,
+					file_out, pos_out, len, flags);
+		} else if (is_copy_file_to_memory_file(file_in, file_out)) {
+			ret = file_out->f_op->copy_file_range(file_in, pos_in,
+					file_out, pos_out, len, flags);
+		} else if (file_out->f_op->copy_file_range) {
+			ret = file_out->f_op->copy_file_range(file_in, pos_in,
+							file_out, pos_out,
+							len, flags);
+		} else if (file_in->f_op->remap_file_range && samesb) {
+			ret = file_in->f_op->remap_file_range(file_in, pos_in,
+					file_out, pos_out,
+					min_t(loff_t, MAX_RW_COUNT, len),
+					REMAP_FILE_CAN_SHORTEN);
+			/* fallback to splice */
+			if (ret <= 0)
+				splice = true;
+		} else if (samesb) {
+			/* Fallback to splice for same sb copy for backward compat */
 			splice = true;
-	} else if (samesb) {
-		/* Fallback to splice for same sb copy for backward compat */
-		splice = true;
+		}
 	}
-
 	file_end_write(file_out);
 
 	if (!splice)
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


