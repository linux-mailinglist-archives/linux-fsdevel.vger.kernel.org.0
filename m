Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA431A88A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 18:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfEKQ5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 12:57:33 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:54204 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfEKQ5c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 12:57:32 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id EFD73C00A01;
        Sat, 11 May 2019 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1557593848;
        bh=STFNScRNnbGZUwRYFatPPVfqe+/yGK93JsjoMiYTs6w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ln6Xy6P/WrNmJu4DR0YuSBKjEMZzqKBjQBkPaLddpLXL6xKecFIUmsqfs1oTd6VOX
         XPHJJuB4tlbrvD+TreMv1mYI7afRzfmMCP4DXCafg6lpY0HfRV4rhD3HfV/MgfD+RK
         At84mTmt+pWGH0VKgEB2DM8sLnI/7m85eahQE/C8=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] fs: RWF flags override default IOCB flags from file flags
Date:   Sat, 11 May 2019 18:57:23 +0200
Message-Id: <20190511165727.31599-1-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <e2bf63a3-703b-9be2-c171-5dcc1797d2b1@stbuehler.de>
References: <e2bf63a3-703b-9be2-c171-5dcc1797d2b1@stbuehler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mapping between IOCB, RWF and file flags:

IOCB_APPEND | RWF_APPEND | O_APPEND
IOCB_HIPRI  | RWF_HIPRI  | -
IOCB_DSYNC  | RWF_DSYNC  | O_DSYNC || IS_SYNC(f_mapping->host)
IOCB_SYNC   | RWF_SYNC   | __O_SYNC
IOCB_NOWAIT | RWF_NOWAIT | O_NONBLOCK && (f_mode & FMODE_NOWAIT)
IOCB_DIRECT | -          | io_is_direct()

Most internal kernel functions taking rwf_t flags support taking
_RWF_DEFAULT instead of individual flags to signal "use default flags
from file flags"; APIs exposed to userspace should return EOPNOTSUPP
when they are passed _RWF_DEFAULT.

Also convert O_NONBLOCK file flag to IOCB_NOWAIT if supported by the
file (i.e. FMODE_NOWAIT is set), so read_iter/write_iter implementations
can consistently check for IOCB_NOWAIT instead of O_NONBLOCK.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 drivers/block/loop.c              |  8 +++--
 drivers/staging/android/ashmem.c  |  2 +-
 drivers/target/target_core_file.c |  6 ++--
 fs/coda/file.c                    |  6 ++--
 fs/nfsd/vfs.c                     |  4 +--
 fs/overlayfs/file.c               | 21 ++-----------
 fs/read_write.c                   | 40 ++++++++++++++++++------
 fs/splice.c                       | 11 +++++--
 include/linux/fs.h                | 51 +++++++++++++++++++++++++++++++
 9 files changed, 107 insertions(+), 42 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 102d79575895..cb06eef7d0d2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -280,7 +280,7 @@ static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
 	loop_iov_iter_bvec(&i, WRITE, bvec, 1, bvec->bv_len);
 
 	file_start_write(file);
-	bw = vfs_iter_write(file, &i, ppos, 0);
+	bw = vfs_iter_write(file, &i, ppos, _RWF_DEFAULT);
 	file_end_write(file);
 
 	if (likely(bw ==  bvec->bv_len))
@@ -356,7 +356,8 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 
 	rq_for_each_segment(bvec, rq, iter) {
 		loop_iov_iter_bvec(&i, READ, &bvec, 1, bvec.bv_len);
-		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
+		len = vfs_iter_read(lo->lo_backing_file, &i, &pos,
+				    _RWF_DEFAULT);
 		if (len < 0)
 			return len;
 
@@ -397,7 +398,8 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
 		b.bv_len = bvec.bv_len;
 
 		loop_iov_iter_bvec(&i, READ, &b, 1, b.bv_len);
-		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
+		len = vfs_iter_read(lo->lo_backing_file, &i, &pos,
+				    _RWF_DEFAULT);
 		if (len < 0) {
 			ret = len;
 			goto out_free_page;
diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 74d497d39c5a..813353d74eaf 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -307,7 +307,7 @@ static ssize_t ashmem_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 * ashmem_release is called.
 	 */
 	mutex_unlock(&ashmem_mutex);
-	ret = vfs_iter_read(asma->file, iter, &iocb->ki_pos, 0);
+	ret = vfs_iter_read(asma->file, iter, &iocb->ki_pos, _RWF_DEFAULT);
 	mutex_lock(&ashmem_mutex);
 	if (ret > 0)
 		asma->file->f_pos = iocb->ki_pos;
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 49b110d1b972..8ebfbf6bc56d 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -355,9 +355,9 @@ static int fd_do_rw(struct se_cmd *cmd, struct file *fd,
 
 	iov_iter_bvec(&iter, READ, bvec, sgl_nents, len);
 	if (is_write)
-		ret = vfs_iter_write(fd, &iter, &pos, 0);
+		ret = vfs_iter_write(fd, &iter, &pos, _RWF_DEFAULT);
 	else
-		ret = vfs_iter_read(fd, &iter, &pos, 0);
+		ret = vfs_iter_read(fd, &iter, &pos, _RWF_DEFAULT);
 
 	if (is_write) {
 		if (ret < 0 || ret != data_length) {
@@ -491,7 +491,7 @@ fd_execute_write_same(struct se_cmd *cmd)
 	}
 
 	iov_iter_bvec(&iter, READ, bvec, nolb, len);
-	ret = vfs_iter_write(fd_dev->fd_file, &iter, &pos, 0);
+	ret = vfs_iter_write(fd_dev->fd_file, &iter, &pos, _RWF_DEFAULT);
 
 	kfree(bvec);
 	if (ret < 0 || ret != len) {
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 1cbc1f2298ee..65d1cc7017e4 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -35,7 +35,8 @@ coda_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
 
-	return vfs_iter_read(cfi->cfi_container, to, &iocb->ki_pos, 0);
+	return vfs_iter_read(cfi->cfi_container, to, &iocb->ki_pos,
+			     _RWF_DEFAULT);
 }
 
 static ssize_t
@@ -52,7 +53,8 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	host_file = cfi->cfi_container;
 	file_start_write(host_file);
 	inode_lock(coda_inode);
-	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
+	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos,
+			     _RWF_DEFAULT);
 	coda_inode->i_size = file_inode(host_file)->i_size;
 	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
 	coda_inode->i_mtime = coda_inode->i_ctime = current_time(coda_inode);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7dc98e14655d..2d563d916b5c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -943,7 +943,7 @@ __be32 nfsd_readv(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
 	iov_iter_kvec(&iter, READ, vec, vlen, *count);
-	host_err = vfs_iter_read(file, &iter, &offset, 0);
+	host_err = vfs_iter_read(file, &iter, &offset, _RWF_DEFAULT);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, host_err);
 }
 
@@ -996,7 +996,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
 	int			use_wgather;
 	loff_t			pos = offset;
 	unsigned int		pflags = current->flags;
-	rwf_t			flags = 0;
+	rwf_t			flags = rwf_flags(file);
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 84dd957efa24..8567f2cc189f 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -174,23 +174,6 @@ static void ovl_file_accessed(struct file *file)
 	touch_atime(&file->f_path);
 }
 
-static rwf_t ovl_iocb_to_rwf(struct kiocb *iocb)
-{
-	int ifl = iocb->ki_flags;
-	rwf_t flags = 0;
-
-	if (ifl & IOCB_NOWAIT)
-		flags |= RWF_NOWAIT;
-	if (ifl & IOCB_HIPRI)
-		flags |= RWF_HIPRI;
-	if (ifl & IOCB_DSYNC)
-		flags |= RWF_DSYNC;
-	if (ifl & IOCB_SYNC)
-		flags |= RWF_SYNC;
-
-	return flags;
-}
-
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
@@ -207,7 +190,7 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
-			    ovl_iocb_to_rwf(iocb));
+			    rwf_from_iocb_flags(iocb));
 	revert_creds(old_cred);
 
 	ovl_file_accessed(file);
@@ -242,7 +225,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	file_start_write(real.file);
 	ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
-			     ovl_iocb_to_rwf(iocb));
+			     rwf_from_iocb_flags(iocb));
 	file_end_write(real.file);
 	revert_creds(old_cred);
 
diff --git a/fs/read_write.c b/fs/read_write.c
index 61b43ad7608e..1bb37364cb44 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -670,6 +670,8 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
+	if (flags == _RWF_DEFAULT)
+		flags = rwf_flags(filp);
 	ret = kiocb_set_rw_flags(&kiocb, flags);
 	if (ret)
 		return ret;
@@ -690,7 +692,7 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 {
 	ssize_t ret = 0;
 
-	if (flags & ~RWF_HIPRI)
+	if ((flags != _RWF_DEFAULT) && (flags & ~RWF_HIPRI))
 		return -EOPNOTSUPP;
 
 	while (iov_iter_count(iter)) {
@@ -1101,13 +1103,13 @@ static ssize_t do_pwritev(unsigned long fd, const struct iovec __user *vec,
 SYSCALL_DEFINE3(readv, unsigned long, fd, const struct iovec __user *, vec,
 		unsigned long, vlen)
 {
-	return do_readv(fd, vec, vlen, 0);
+	return do_readv(fd, vec, vlen, _RWF_DEFAULT);
 }
 
 SYSCALL_DEFINE3(writev, unsigned long, fd, const struct iovec __user *, vec,
 		unsigned long, vlen)
 {
-	return do_writev(fd, vec, vlen, 0);
+	return do_writev(fd, vec, vlen, _RWF_DEFAULT);
 }
 
 SYSCALL_DEFINE5(preadv, unsigned long, fd, const struct iovec __user *, vec,
@@ -1115,7 +1117,7 @@ SYSCALL_DEFINE5(preadv, unsigned long, fd, const struct iovec __user *, vec,
 {
 	loff_t pos = pos_from_hilo(pos_h, pos_l);
 
-	return do_preadv(fd, vec, vlen, pos, 0);
+	return do_preadv(fd, vec, vlen, pos, _RWF_DEFAULT);
 }
 
 SYSCALL_DEFINE6(preadv2, unsigned long, fd, const struct iovec __user *, vec,
@@ -1124,6 +1126,9 @@ SYSCALL_DEFINE6(preadv2, unsigned long, fd, const struct iovec __user *, vec,
 {
 	loff_t pos = pos_from_hilo(pos_h, pos_l);
 
+	if (flags == _RWF_DEFAULT)
+		return -EOPNOTSUPP;
+
 	if (pos == -1)
 		return do_readv(fd, vec, vlen, flags);
 
@@ -1135,7 +1140,7 @@ SYSCALL_DEFINE5(pwritev, unsigned long, fd, const struct iovec __user *, vec,
 {
 	loff_t pos = pos_from_hilo(pos_h, pos_l);
 
-	return do_pwritev(fd, vec, vlen, pos, 0);
+	return do_pwritev(fd, vec, vlen, pos, _RWF_DEFAULT);
 }
 
 SYSCALL_DEFINE6(pwritev2, unsigned long, fd, const struct iovec __user *, vec,
@@ -1144,6 +1149,9 @@ SYSCALL_DEFINE6(pwritev2, unsigned long, fd, const struct iovec __user *, vec,
 {
 	loff_t pos = pos_from_hilo(pos_h, pos_l);
 
+	if (flags == _RWF_DEFAULT)
+		return -EOPNOTSUPP;
+
 	if (pos == -1)
 		return do_writev(fd, vec, vlen, flags);
 
@@ -1221,7 +1229,7 @@ COMPAT_SYSCALL_DEFINE4(preadv64, unsigned long, fd,
 		const struct compat_iovec __user *,vec,
 		unsigned long, vlen, loff_t, pos)
 {
-	return do_compat_preadv64(fd, vec, vlen, pos, 0);
+	return do_compat_preadv64(fd, vec, vlen, pos, _RWF_DEFAULT);
 }
 #endif
 
@@ -1231,7 +1239,7 @@ COMPAT_SYSCALL_DEFINE5(preadv, compat_ulong_t, fd,
 {
 	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
 
-	return do_compat_preadv64(fd, vec, vlen, pos, 0);
+	return do_compat_preadv64(fd, vec, vlen, pos, _RWF_DEFAULT);
 }
 
 #ifdef __ARCH_WANT_COMPAT_SYS_PREADV64V2
@@ -1239,6 +1247,9 @@ COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
 		const struct compat_iovec __user *,vec,
 		unsigned long, vlen, loff_t, pos, rwf_t, flags)
 {
+	if (flags == _RWF_DEFAULT)
+		return -EOPNOTSUPP;
+
 	if (pos == -1)
 		return do_compat_readv(fd, vec, vlen, flags);
 
@@ -1253,6 +1264,9 @@ COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
 {
 	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
 
+	if (flags == _RWF_DEFAULT)
+		return -EOPNOTSUPP;
+
 	if (pos == -1)
 		return do_compat_readv(fd, vec, vlen, flags);
 
@@ -1303,7 +1317,7 @@ COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
 		const struct compat_iovec __user *, vec,
 		compat_ulong_t, vlen)
 {
-	return do_compat_writev(fd, vec, vlen, 0);
+	return do_compat_writev(fd, vec, vlen, _RWF_DEFAULT);
 }
 
 static long do_compat_pwritev64(unsigned long fd,
@@ -1330,7 +1344,7 @@ COMPAT_SYSCALL_DEFINE4(pwritev64, unsigned long, fd,
 		const struct compat_iovec __user *,vec,
 		unsigned long, vlen, loff_t, pos)
 {
-	return do_compat_pwritev64(fd, vec, vlen, pos, 0);
+	return do_compat_pwritev64(fd, vec, vlen, pos, _RWF_DEFAULT);
 }
 #endif
 
@@ -1340,7 +1354,7 @@ COMPAT_SYSCALL_DEFINE5(pwritev, compat_ulong_t, fd,
 {
 	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
 
-	return do_compat_pwritev64(fd, vec, vlen, pos, 0);
+	return do_compat_pwritev64(fd, vec, vlen, pos, _RWF_DEFAULT);
 }
 
 #ifdef __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
@@ -1348,6 +1362,9 @@ COMPAT_SYSCALL_DEFINE5(pwritev64v2, unsigned long, fd,
 		const struct compat_iovec __user *,vec,
 		unsigned long, vlen, loff_t, pos, rwf_t, flags)
 {
+	if (flags == _RWF_DEFAULT)
+		return -EOPNOTSUPP;
+
 	if (pos == -1)
 		return do_compat_writev(fd, vec, vlen, flags);
 
@@ -1361,6 +1378,9 @@ COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
 {
 	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
 
+	if (flags == _RWF_DEFAULT)
+		return -EOPNOTSUPP;
+
 	if (pos == -1)
 		return do_compat_writev(fd, vec, vlen, flags);
 
diff --git a/fs/splice.c b/fs/splice.c
index 25212dcca2df..1b7fdcce5d6b 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -302,6 +302,12 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 	iov_iter_pipe(&to, READ, pipe, len);
 	idx = to.idx;
 	init_sync_kiocb(&kiocb, in);
+	/*
+	 * SPLICE_F_NONBLOCK is only used on the pipe/socket end???
+	 *
+	 * Don't set IOCB_NOWAIT based on it here (O_NONBLOCK might set
+	 * IOCB_NOWAIT though).
+	 */
 	kiocb.ki_pos = *ppos;
 	ret = call_read_iter(in, &kiocb, &to);
 	if (ret > 0) {
@@ -355,7 +361,8 @@ static ssize_t kernel_readv(struct file *file, const struct kvec *vec,
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
 	/* The cast to a user pointer is valid due to the set_fs() */
-	res = vfs_readv(file, (const struct iovec __user *)vec, vlen, &pos, 0);
+	res = vfs_readv(file, (const struct iovec __user *)vec, vlen, &pos,
+			_RWF_DEFAULT);
 	set_fs(old_fs);
 
 	return res;
@@ -742,7 +749,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		}
 
 		iov_iter_bvec(&from, WRITE, array, n, sd.total_len - left);
-		ret = vfs_iter_write(out, &from, &sd.pos, 0);
+		ret = vfs_iter_write(out, &from, &sd.pos, _RWF_DEFAULT);
 		if (ret <= 0)
 			break;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2f66e247ecba..bc159cb87ea5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -83,6 +83,12 @@ extern int sysctl_protected_fifos;
 extern int sysctl_protected_regular;
 
 typedef __kernel_rwf_t rwf_t;
+/*
+ * kernel internal only value to signal using default flags from file;
+ * can't be combined with other flags and only used to simplify kernel
+ * APIs.
+ */
+#define _RWF_DEFAULT ((__force __kernel_rwf_t)-1)
 
 struct buffer_head;
 typedef int (get_block_t)(struct inode *inode, sector_t iblock,
@@ -3332,11 +3338,21 @@ static inline int iocb_flags(struct file *file)
 		res |= IOCB_DSYNC;
 	if (file->f_flags & __O_SYNC)
 		res |= IOCB_SYNC;
+	if ((file->f_flags & O_NONBLOCK) && (file->f_mode & FMODE_NOWAIT))
+		res |= IOCB_NOWAIT;
 	return res;
 }
 
+/* does NOT handle _RWF_DEFAULT */
 static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 {
+	/*
+	 * unset all flags controlled through RWF, right now all but:
+	 * IOCB_EVENTFD, IOCB_DIRECT, IOCB_WRITE
+	 */
+	ki->ki_flags &= ~(IOCB_APPEND | IOCB_HIPRI | IOCB_DSYNC | IOCB_SYNC |
+			  IOCB_NOWAIT);
+
 	if (unlikely(flags & ~RWF_SUPPORTED))
 		return -EOPNOTSUPP;
 
@@ -3356,6 +3372,41 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 	return 0;
 }
 
+static inline rwf_t rwf_flags(struct file *file)
+{
+	rwf_t flags = 0;
+
+	if (file->f_flags & O_APPEND)
+		flags |= RWF_APPEND;
+	if ((file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host))
+		flags |= RWF_DSYNC;
+	if (file->f_flags & __O_SYNC)
+		flags |= RWF_SYNC;
+	if ((file->f_flags & O_NONBLOCK) && (file->f_mode & FMODE_NOWAIT))
+		flags |= RWF_NOWAIT;
+
+	return flags;
+}
+
+static inline rwf_t rwf_from_iocb_flags(struct kiocb *iocb)
+{
+	int ifl = iocb->ki_flags;
+	rwf_t flags = 0;
+
+	if (ifl & IOCB_APPEND)
+		flags |= RWF_APPEND;
+	if (ifl & IOCB_NOWAIT)
+		flags |= RWF_NOWAIT;
+	if (ifl & IOCB_HIPRI)
+		flags |= RWF_HIPRI;
+	if (ifl & IOCB_DSYNC)
+		flags |= RWF_DSYNC;
+	if (ifl & IOCB_SYNC)
+		flags |= RWF_SYNC;
+
+	return flags;
+}
+
 static inline ino_t parent_ino(struct dentry *dentry)
 {
 	ino_t res;
-- 
2.20.1

