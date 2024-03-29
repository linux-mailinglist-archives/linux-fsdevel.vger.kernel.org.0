Return-Path: <linux-fsdevel+bounces-15635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0DB8910D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3318128BEBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 01:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3C7446C5;
	Fri, 29 Mar 2024 01:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lT+Ih0ob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF323308A
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677271; cv=none; b=Mp/Fx3J8L8vXe/SlA/rZvOW4WNCIzt4NUs6FyBG6UtmuHn0pGSe+6xPBze4HpIukkzTEfr79m/FhWZBv2GjEBx8lt3ayo5PaBZpSw2HRsmPCb1CJDoyPKB+dJ/bfQFQ0gyn7AGumK4yyByX35FL8u4FLDVwKRc466TTkbOhsrpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677271; c=relaxed/simple;
	bh=NaP8Vft/GCAaEKsbOOM9Dr7QiorAg1ARMwM5E2MqRF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nRVttCL4pkNqvfH6WZ47giIgHDo1QE+X7IMJngUQBN1Mz7TycirQEpdYuxOyyTzedPXKP575fxbJ7+GTKSI0/QSES+RUPfite98Jshf3NAABnGCh/BT5/iyUwyBPOtTzHJVsjaRElxGfs3dUTrIm9rJkUs6b+PO7TXCEG5c2ZBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lT+Ih0ob; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0b18e52dso19453967b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677268; x=1712282068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgfnibGcrOVFHgtkyPrSmeFKMY0WwKAtVw/Eqs3kVuY=;
        b=lT+Ih0obznZkTbK5lyea+SYqjPyXQzBMvcsErTjzwk+es2+00jROkZemLqpTBfBp11
         3HXVKpx6Jciy9Ibyuk9Htrag/h1HL9jvTkwAh95XV9YpFqFKI5wiTBKu/78m6Z5kRlz0
         oMUbINMNk5gCQzSK8ULFmkl8ZX26YFLUpR0PBXTGep6uSXuzQJPNdPm8bKyLrpp7jwAN
         u/Vk8/5Q6elIni/NE9+J6Z9fg4s+ieQaKiPew0JAa7+MT9FfseqpFcAEbluyhUByNDK0
         xb9luCSq7DqsAExfXvbyGU4bK5A5q6VEQPTcyJHhiHJjFFgn0r9FGx8cpOiyIKjOtdBO
         eDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677268; x=1712282068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgfnibGcrOVFHgtkyPrSmeFKMY0WwKAtVw/Eqs3kVuY=;
        b=VQmLelKvEtlC91GbITnmGIMxmzHSRT3QfZOrsP9haalheyD7NWHdI2EXI3XvroIGpA
         hWCuRzv4Rc8IonRLZmNYvD9f+NfREKZtAkQUzvBQ05N5ozSyLe73va7KYF5ytXuJCEgA
         ysGKBU0IoarMTkhO44tzTgMEMrR7tzy+Jzi7MaLIzoZPTxKtZLZiyrjDKJzTce1OJbno
         ZevtA8YF5ukmMsPZNFOT9npTXECzGenZ2fk06jcy16XMVd0WleX4vM4CTZYsyiyHuplY
         CeTojk1h7TmdLO12YMKXVQGHAR9YqSGAAMIjNYPSUYy32oaDOXLigcEoD6mvSsbl7HWx
         A5CA==
X-Forwarded-Encrypted: i=1; AJvYcCWf+f5STErn2CUZdYe4g0FLzYfrnGq2IM2L065HoY/WNM095RSiuy/uSCgfA3DX4xHnh1smVBJg2Z1clvotFonsACJgRAv3ipIa6W6F8g==
X-Gm-Message-State: AOJu0Ywd6868lQF9cvtY+Gce218wgWHbnoVuDXaFM6E59NzjzsHEoDbJ
	CoCRR3QHVHj0EHHXI/hmNdVY+pPuOT/DUZclEzu52Oto5Pnz+Frd284MU/R0UY42Z063xc8BXNK
	u6g==
X-Google-Smtp-Source: AGHT+IHAEp2pWokjVXFWzyRyEDQMztibYQ9ro0+bBqN+eb3ILoKKnWSV3bt5MHWyS0RsNihpNUcWDR/etXw=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a81:52cd:0:b0:611:537:2c0f with SMTP id
 g196-20020a8152cd000000b0061105372c0fmr289607ywb.2.1711677267815; Thu, 28 Mar
 2024 18:54:27 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:28 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-14-drosen@google.com>
Subject: [RFC PATCH v4 13/36] fuse-bpf: Add support for read/write iter
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"

Adds backing support for FUSE_READ and FUSE_WRITE

This includes adjustments from Amir Goldstein's patch to FUSE
Passthrough

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c         | 384 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/control.c         |   2 +-
 fs/fuse/file.c            |   8 +
 fs/fuse/fuse_i.h          |  19 +-
 fs/fuse/inode.c           |  13 ++
 include/uapi/linux/fuse.h |  10 +
 6 files changed, 434 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 567f859d300c..c813237b6599 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/fs_stack.h>
 #include <linux/namei.h>
+#include <linux/uio.h>
 
 /*
  * expression statement to wrap the backing filter logic
@@ -76,6 +77,95 @@
 	handled;							\
 })
 
+#define FUSE_BPF_IOCB_MASK (IOCB_APPEND | IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
+
+struct fuse_bpf_aio_req {
+	struct kiocb iocb;
+	refcount_t ref;
+	struct kiocb *iocb_orig;
+	struct timespec64 pre_atime;
+};
+
+static struct kmem_cache *fuse_bpf_aio_request_cachep;
+
+static void fuse_file_accessed(struct file *dst_file, struct file *src_file)
+{
+	struct inode *dst_inode;
+	struct inode *src_inode;
+	struct timespec64 dest_mtime, src_mtime, dst_ctime, src_ctime;
+
+	if (dst_file->f_flags & O_NOATIME)
+		return;
+
+	dst_inode = file_inode(dst_file);
+	src_inode = file_inode(src_file);
+
+	dest_mtime = inode_get_mtime(dst_inode);
+	src_mtime = inode_get_mtime(src_inode);
+	dst_ctime = inode_get_ctime(dst_inode);
+	src_ctime = inode_get_ctime(src_inode);
+	if ((!timespec64_equal(&dest_mtime, &src_mtime) ||
+	     !timespec64_equal(&dst_ctime, &src_ctime))) {
+		inode_set_mtime_to_ts(dst_inode, src_mtime);
+		inode_set_ctime_to_ts(dst_inode, src_ctime);
+	}
+
+	touch_atime(&dst_file->f_path);
+}
+
+static void fuse_copyattr(struct file *dst_file, struct file *src_file)
+{
+	struct inode *dst = file_inode(dst_file);
+	struct inode *src = file_inode(src_file);
+
+	inode_set_atime_to_ts(dst, inode_get_atime(src));
+	inode_set_mtime_to_ts(dst, inode_get_mtime(src));
+	inode_set_ctime_to_ts(dst, inode_get_ctime(src));
+	i_size_write(dst, i_size_read(src));
+	fuse_invalidate_attr(dst);
+}
+
+static void fuse_file_start_write(struct file *fuse_file, struct file *backing_file,
+				  loff_t pos, size_t count)
+{
+	struct inode *inode = file_inode(fuse_file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	if (inode->i_size < pos + count)
+		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
+
+	file_start_write(backing_file);
+}
+
+static void fuse_file_end_write(struct file *fuse_file, struct file *backing_file,
+				loff_t pos, size_t res)
+{
+	struct inode *inode = file_inode(fuse_file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	file_end_write(backing_file);
+
+	if (res > 0)
+		fuse_write_update_attr(inode, pos, res);
+
+	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
+	fuse_invalidate_attr(inode);
+}
+
+static void fuse_file_start_read(struct file *backing_file, struct timespec64 *pre_atime)
+{
+	*pre_atime = inode_get_atime(file_inode(backing_file));
+}
+
+static void fuse_file_end_read(struct file *fuse_file, struct file *backing_file,
+			  struct timespec64 *pre_atime)
+{
+	struct timespec64 atime = inode_get_atime(file_inode(backing_file));
+	/* Mimic atime update policy of passthrough inode, not the value */
+	if (!timespec64_equal(&atime, pre_atime))
+		fuse_invalidate_atime(file_inode(fuse_file));
+}
+
 static void fuse_get_backing_path(struct file *file, struct path *path)
 {
 	path_get(&file->f_path);
@@ -635,6 +725,284 @@ int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t o
 				file, offset, whence);
 }
 
+static inline void fuse_bpf_aio_put(struct fuse_bpf_aio_req *aio_req)
+{
+	if (refcount_dec_and_test(&aio_req->ref))
+		kmem_cache_free(fuse_bpf_aio_request_cachep, aio_req);
+}
+
+static void fuse_bpf_aio_cleanup_handler(struct fuse_bpf_aio_req *aio_req, long res)
+{
+	struct kiocb *iocb = &aio_req->iocb;
+	struct kiocb *iocb_orig = aio_req->iocb_orig;
+	struct file *filp = iocb->ki_filp;
+	struct file *fuse_filp = iocb_orig->ki_filp;
+
+	if (iocb->ki_flags & IOCB_WRITE) {
+		__sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
+				      SB_FREEZE_WRITE);
+		fuse_file_end_write(iocb_orig->ki_filp, iocb->ki_filp, iocb->ki_pos, res);
+	} else {
+		fuse_file_end_read(fuse_filp, filp, &aio_req->pre_atime);
+	}
+	iocb_orig->ki_pos = iocb->ki_pos;
+	fuse_bpf_aio_put(aio_req);
+}
+
+static void fuse_bpf_aio_rw_complete(struct kiocb *iocb, long res)
+{
+	struct fuse_bpf_aio_req *aio_req =
+		container_of(iocb, struct fuse_bpf_aio_req, iocb);
+	struct kiocb *iocb_orig = aio_req->iocb_orig;
+
+	fuse_bpf_aio_cleanup_handler(aio_req, res);
+	iocb_orig->ki_complete(iocb_orig, res);
+}
+
+struct fuse_file_read_iter_args {
+	struct fuse_read_in in;
+	struct fuse_read_iter_out out;
+};
+
+static int fuse_file_read_iter_initialize_in(struct bpf_fuse_args *fa, struct fuse_file_read_iter_args *args,
+					     struct kiocb *iocb, struct iov_iter *to)
+{
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+
+	args->in = (struct fuse_read_in) {
+		.fh = ff->fh,
+		.offset = iocb->ki_pos,
+		.size = to->count,
+	};
+
+	/* TODO we can't assume 'to' is a kvec */
+	/* TODO we also can't assume the vector has only one component */
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.opcode = FUSE_READ,
+			.nodeid = ff->nodeid,
+		},		.in_numargs = 1,
+		.in_args[0].size = sizeof(args->in),
+		.in_args[0].value = &args->in,
+		/*
+		 * TODO Design this properly.
+		 * Possible approach: do not pass buf to bpf
+		 * If going to userland, do a deep copy
+		 * For extra credit, do that to/from the vector, rather than
+		 * making an extra copy in the kernel
+		 */
+	};
+
+	return 0;
+}
+
+static int fuse_file_read_iter_initialize_out(struct bpf_fuse_args *fa, struct fuse_file_read_iter_args *args,
+					      struct kiocb *iocb, struct iov_iter *to)
+{
+	args->out = (struct fuse_read_iter_out) {
+		.ret = args->in.size,
+	};
+
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(args->out);
+	fa->out_args[0].value = &args->out;
+
+	return 0;
+}
+
+
+// TODO: use backing-file.c
+static inline rwf_t fuse_iocb_to_rw_flags(int ifl, int iocb_mask)
+{
+	return ifl & iocb_mask;
+}
+
+static int fuse_file_read_iter_backing(struct bpf_fuse_args *fa, ssize_t *out,
+				       struct kiocb *iocb, struct iov_iter *to)
+{
+	struct fuse_read_iter_out *frio = fa->out_args[0].value;
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+
+	if (!iov_iter_count(to))
+		return 0;
+
+	if ((iocb->ki_flags & IOCB_DIRECT) &&
+	    (!ff->backing_file->f_mapping->a_ops ||
+	     !ff->backing_file->f_mapping->a_ops->direct_IO))
+		return -EINVAL;
+
+	/* TODO This just plain ignores any change to fuse_read_in */
+	if (is_sync_kiocb(iocb)) {
+		struct timespec64 pre_atime;
+
+		fuse_file_start_read(ff->backing_file, &pre_atime);
+		*out = vfs_iter_read(ff->backing_file, to, &iocb->ki_pos,
+				fuse_iocb_to_rw_flags(iocb->ki_flags, FUSE_BPF_IOCB_MASK));
+		fuse_file_end_read(file, ff->backing_file, &pre_atime);
+	} else {
+		struct fuse_bpf_aio_req *aio_req;
+
+		*out = -ENOMEM;
+		aio_req = kmem_cache_zalloc(fuse_bpf_aio_request_cachep, GFP_KERNEL);
+		if (!aio_req)
+			goto out;
+
+		aio_req->iocb_orig = iocb;
+		fuse_file_start_read(ff->backing_file, &aio_req->pre_atime);
+		kiocb_clone(&aio_req->iocb, iocb, ff->backing_file);
+		aio_req->iocb.ki_complete = fuse_bpf_aio_rw_complete;
+		refcount_set(&aio_req->ref, 2);
+		*out = vfs_iocb_iter_read(ff->backing_file, &aio_req->iocb, to);
+		fuse_bpf_aio_put(aio_req);
+		if (*out != -EIOCBQUEUED)
+			fuse_bpf_aio_cleanup_handler(aio_req, *out);
+	}
+
+	frio->ret = *out;
+
+	/* TODO Need to point value at the buffer for post-modification */
+
+out:
+	fuse_file_accessed(file, ff->backing_file);
+
+	return *out;
+}
+
+static int fuse_file_read_iter_finalize(struct bpf_fuse_args *fa, ssize_t *out,
+					struct kiocb *iocb, struct iov_iter *to)
+{
+	struct fuse_read_iter_out *frio = fa->out_args[0].value;
+
+	*out = frio->ret;
+
+	return 0;
+}
+
+int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *to)
+{
+	return bpf_fuse_backing(inode, struct fuse_file_read_iter_args, out,
+				fuse_file_read_iter_initialize_in,
+				fuse_file_read_iter_initialize_out,
+				fuse_file_read_iter_backing,
+				fuse_file_read_iter_finalize,
+				iocb, to);
+}
+
+struct fuse_file_write_iter_args {
+	struct fuse_write_in in;
+	struct fuse_write_iter_out out;
+};
+
+static int fuse_file_write_iter_initialize_in(struct bpf_fuse_args *fa,
+					      struct fuse_file_write_iter_args *args,
+					      struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+
+	*args = (struct fuse_file_write_iter_args) {
+		.in.fh = ff->fh,
+		.in.offset = iocb->ki_pos,
+		.in.size = from->count,
+	};
+
+	/* TODO we can't assume 'from' is a kvec */
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.opcode = FUSE_WRITE,
+			.nodeid = ff->nodeid,
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(args->in),
+		.in_args[0].value = &args->in,
+	};
+
+	return 0;
+}
+
+static int fuse_file_write_iter_initialize_out(struct bpf_fuse_args *fa,
+					       struct fuse_file_write_iter_args *args,
+					       struct kiocb *iocb, struct iov_iter *from)
+{
+	/* TODO we can't assume 'from' is a kvec */
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(args->out);
+	fa->out_args[0].value = &args->out;
+
+	return 0;
+}
+
+static int fuse_file_write_iter_backing(struct bpf_fuse_args *fa, ssize_t *out,
+					struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+	struct fuse_write_iter_out *fwio = fa->out_args[0].value;
+	ssize_t count = iov_iter_count(from);
+
+	if (!count)
+		return 0;
+
+	/* TODO This just plain ignores any change to fuse_write_in */
+	/* TODO uint32_t seems smaller than ssize_t.... right? */
+	inode_lock(file_inode(file));
+
+	fuse_copyattr(file, ff->backing_file);
+
+	if (is_sync_kiocb(iocb)) {
+		fuse_file_start_write(file, ff->backing_file, iocb->ki_pos, count);
+		*out = vfs_iter_write(ff->backing_file, from, &iocb->ki_pos,
+					   fuse_iocb_to_rw_flags(iocb->ki_flags, FUSE_BPF_IOCB_MASK));
+		fuse_file_end_write(file, ff->backing_file, iocb->ki_pos, *out);
+	} else {
+		struct fuse_bpf_aio_req *aio_req;
+
+		*out = -ENOMEM;
+		aio_req = kmem_cache_zalloc(fuse_bpf_aio_request_cachep, GFP_KERNEL);
+		if (!aio_req)
+			goto out;
+
+		fuse_file_start_write(file, ff->backing_file, iocb->ki_pos, count);
+		__sb_writers_release(file_inode(ff->backing_file)->i_sb, SB_FREEZE_WRITE);
+		aio_req->iocb_orig = iocb;
+		kiocb_clone(&aio_req->iocb, iocb, ff->backing_file);
+		aio_req->iocb.ki_complete = fuse_bpf_aio_rw_complete;
+		refcount_set(&aio_req->ref, 2);
+		*out = vfs_iocb_iter_write(ff->backing_file, &aio_req->iocb, from);
+		fuse_bpf_aio_put(aio_req);
+		if (*out != -EIOCBQUEUED)
+			fuse_bpf_aio_cleanup_handler(aio_req, *out);
+	}
+
+out:
+	inode_unlock(file_inode(file));
+	fwio->ret = *out;
+	if (*out < 0)
+		return *out;
+	return 0;
+}
+
+static int fuse_file_write_iter_finalize(struct bpf_fuse_args *fa, ssize_t *out,
+					 struct kiocb *iocb, struct iov_iter *from)
+{
+	struct fuse_write_iter_out *fwio = fa->out_args[0].value;
+
+	*out = fwio->ret;
+	return 0;
+}
+
+int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *from)
+{
+	return bpf_fuse_backing(inode, struct fuse_file_write_iter_args, out,
+				fuse_file_write_iter_initialize_in,
+				fuse_file_write_iter_initialize_out,
+				fuse_file_write_iter_backing,
+				fuse_file_write_iter_finalize,
+				iocb, from);
+}
+
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	int ret;
@@ -1335,3 +1703,19 @@ int fuse_bpf_access(int *out, struct inode *inode, int mask)
 				fuse_access_initialize_in, fuse_access_initialize_out,
 				fuse_access_backing, fuse_access_finalize, inode, mask);
 }
+
+int __init fuse_bpf_init(void)
+{
+	fuse_bpf_aio_request_cachep = kmem_cache_create("fuse_bpf_aio_req",
+						   sizeof(struct fuse_bpf_aio_req),
+						   0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!fuse_bpf_aio_request_cachep)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void __exit fuse_bpf_cleanup(void)
+{
+	kmem_cache_destroy(fuse_bpf_aio_request_cachep);
+}
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 284a35006462..3e1d183b6c60 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -378,7 +378,7 @@ int __init fuse_ctl_init(void)
 	return register_filesystem(&fuse_ctl_fs_type);
 }
 
-void __exit fuse_ctl_cleanup(void)
+void fuse_ctl_cleanup(void)
 {
 	unregister_filesystem(&fuse_ctl_fs_type);
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c43f2d61c41a..3443510027a5 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1646,6 +1646,7 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(file);
+	ssize_t ret;
 
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -1653,6 +1654,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
+	if (fuse_bpf_file_read_iter(&ret, inode, iocb, to))
+		return ret;
+
 	if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_read_iter(iocb, to);
 	else
@@ -1664,6 +1668,7 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(file);
+	ssize_t ret = 0;
 
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -1671,6 +1676,9 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
+	if (fuse_bpf_file_write_iter(&ret, inode, iocb, from))
+		return ret;
+
 	if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_write_iter(iocb, from);
 	else
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9b176f78999f..bd187dbf20b2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1164,7 +1164,7 @@ int fuse_dev_init(void);
 void fuse_dev_cleanup(void);
 
 int fuse_ctl_init(void);
-void __exit fuse_ctl_cleanup(void);
+void fuse_ctl_cleanup(void);
 
 /**
  * Simple request sending that does request allocation and freeing
@@ -1448,6 +1448,8 @@ int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry);
 int fuse_bpf_release(int *out, struct inode *inode, struct fuse_file *ff);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct fuse_file *ff);
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
+int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *to);
+int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *from);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
@@ -1500,6 +1502,16 @@ static inline int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *
 	return 0;
 }
 
+static inline int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *to)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *from)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length)
 {
 	return 0;
@@ -1523,4 +1535,9 @@ int fuse_handle_backing(struct fuse_bpf_entry *fbe, struct path *backing_path);
 
 int fuse_revalidate_backing(struct dentry *entry, unsigned int flags);
 
+#ifdef CONFIG_FUSE_BPF
+int __init fuse_bpf_init(void);
+void __exit fuse_bpf_cleanup(void);
+#endif /* CONFIG_FUSE_BPF */
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b47b2e41e5e4..825b65117126 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2199,11 +2199,21 @@ static int __init fuse_init(void)
 	if (res)
 		goto err_sysfs_cleanup;
 
+#ifdef CONFIG_FUSE_BPF
+	res = fuse_bpf_init();
+	if (res)
+		goto err_ctl_cleanup;
+#endif
+
 	sanitize_global_limit(&max_user_bgreq);
 	sanitize_global_limit(&max_user_congthresh);
 
 	return 0;
 
+#ifdef CONFIG_FUSE_BPF
+ err_ctl_cleanup:
+	fuse_ctl_cleanup();
+#endif
  err_sysfs_cleanup:
 	fuse_sysfs_cleanup();
  err_dev_cleanup:
@@ -2221,6 +2231,9 @@ static void __exit fuse_exit(void)
 	fuse_ctl_cleanup();
 	fuse_sysfs_cleanup();
 	fuse_fs_cleanup();
+#ifdef CONFIG_FUSE_BPF
+	fuse_bpf_cleanup();
+#endif
 	fuse_dev_cleanup();
 }
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 74bc15e1d0b7..8efaa9eecc5f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -811,6 +811,11 @@ struct fuse_read_in {
 	uint32_t	padding;
 };
 
+// This is likely not what we want
+struct fuse_read_iter_out {
+	uint64_t ret;
+};
+
 #define FUSE_COMPAT_WRITE_IN_SIZE 24
 
 struct fuse_write_in {
@@ -828,6 +833,11 @@ struct fuse_write_out {
 	uint32_t	padding;
 };
 
+// This is likely not what we want
+struct fuse_write_iter_out {
+	uint64_t ret;
+};
+
 #define FUSE_COMPAT_STATFS_SIZE 48
 
 struct fuse_statfs_out {
-- 
2.44.0.478.gd926399ef9-goog


