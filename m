Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB01633312
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 03:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKVCS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 21:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiKVCRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:17:39 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E23AE6EEC
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:24 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-39967085ae9so75182047b3.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZmovE66ZdqhOmBbykw9B8nSGupb/ebR6gSpmGb5LGI=;
        b=o7bbni3nAcZylijRv69Vs5PD7bchjW2PbDqhDwTIf/E1XkYKIhh8XNGNi/YPCo0HZF
         pNkTB/LJmEZ1oIf8pbwqXf1yAqIu1gby/ZQSrozaSQFqMLUNSQ+G4wPg2+s1okCgHcpI
         rCdLKMiB+OugLqqK1dHnnlANqrm/izNKItafjIuJM84hklmpSFFZ0tGtA1F95XtRip9p
         0xy1xmnk9oFyZrX0QZB5Z/1zJsrsFzwy1XXnJge9o59l+jdFndAI/TDt2xseMgc30VLg
         gl1+UHW8205lO3C4cSBQFSH8IuXm8TsTbL4nFlsnurGz1y19fyCqMnlIbqZ4Hlvv83V+
         J/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZmovE66ZdqhOmBbykw9B8nSGupb/ebR6gSpmGb5LGI=;
        b=KBwQi8etVHGQygkrSeP43nqJv1IqamPUkbuPrQhLXSC8/FLHgYX0r4i4pCQNYne7yn
         VPdeP+YYvghAYtw4ZZj0vdQXDOmw26kWngIKQOnl9Y6scW70QQjOx9QidppBznnVc465
         VbXWb7uGskPxvpqx23F2wV/3b4ubElGy5OzdnGjWq43L/MR6giHTvJY+QpZysTPskntp
         0VqIVeObNINFZxVFEm3CI5ZnfVnl6UTP4goquhO192wX2h935EP5/JYG7KmRCUYm+nmA
         hf2u/XsMPSZOeTP7hEfnQEsu46Re8koo0g6yCYDmMD+7gOgrEmdIF8A1Vz2LinpHZ8pL
         u36g==
X-Gm-Message-State: ANoB5pn2+luO3eAY3V5+4IsIiUTAXAudmFt8b7N885KPqZYddtsbyZlr
        XDyCqO2LlB69XDRYpfZrXn3ynY0fmNs=
X-Google-Smtp-Source: AA0mqf6qA2TG/uVflDd0veqW/Cs6jYwHv7pDIhvA1ecR1WdwREWm6rcSIV+IaIpdMk2s/nh3ZLJU6vjVKSk=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a05:6902:50c:b0:6dd:df31:a7a2 with SMTP id
 x12-20020a056902050c00b006dddf31a7a2mr19543665ybs.635.1669083383456; Mon, 21
 Nov 2022 18:16:23 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:28 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-14-drosen@google.com>
Subject: [RFC PATCH v2 13/21] fuse-bpf: Add support for read/write iter
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This includes adjustments from Amir Goldstein's patch to FUSE
Passthrough

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 377 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/control.c |   2 +-
 fs/fuse/file.c    |   8 +
 fs/fuse/fuse_i.h  |  19 ++-
 fs/fuse/inode.c   |  13 ++
 5 files changed, 417 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index a7505d6887e0..425815d7f5dc 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -10,6 +10,7 @@
 #include <linux/file.h>
 #include <linux/fs_stack.h>
 #include <linux/namei.h>
+#include <linux/uio.h>
 
 /*
  * expression statement to wrap the backing filter logic
@@ -74,6 +75,89 @@
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
+
+	if (dst_file->f_flags & O_NOATIME)
+		return;
+
+	dst_inode = file_inode(dst_file);
+	src_inode = file_inode(src_file);
+
+	if ((!timespec64_equal(&dst_inode->i_mtime, &src_inode->i_mtime) ||
+	     !timespec64_equal(&dst_inode->i_ctime, &src_inode->i_ctime))) {
+		dst_inode->i_mtime = src_inode->i_mtime;
+		dst_inode->i_ctime = src_inode->i_ctime;
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
+	dst->i_atime = src->i_atime;
+	dst->i_mtime = src->i_mtime;
+	dst->i_ctime = src->i_ctime;
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
+	*pre_atime = file_inode(backing_file)->i_atime;
+}
+
+static void fuse_file_end_read(struct file *fuse_file, struct file *backing_file,
+			  struct timespec64 *pre_atime)
+{
+	/* Mimic atime update policy of passthrough inode, not the value */
+	if (!timespec64_equal(&file_inode(backing_file)->i_atime, pre_atime))
+		fuse_invalidate_atime(file_inode(fuse_file));
+}
+
 static void fuse_get_backing_path(struct file *file, struct path *path)
 {
 	path_get(&file->f_path);
@@ -656,6 +740,283 @@ int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t o
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
+struct fuse_read_iter_out {
+	uint64_t ret;
+};
+struct fuse_file_read_iter_io {
+	struct fuse_read_in fri;
+	struct fuse_read_iter_out frio;
+};
+
+static int fuse_file_read_iter_initialize_in(struct fuse_args *fa, struct fuse_file_read_iter_io *fri,
+					     struct kiocb *iocb, struct iov_iter *to)
+{
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+
+	fri->fri = (struct fuse_read_in) {
+		.fh = ff->fh,
+		.offset = iocb->ki_pos,
+		.size = to->count,
+	};
+
+	/* TODO we can't assume 'to' is a kvec */
+	/* TODO we also can't assume the vector has only one component */
+	*fa = (struct fuse_args) {
+		.opcode = FUSE_READ,
+		.nodeid = ff->nodeid,
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(fri->fri),
+		.in_args[0].value = &fri->fri,
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
+static int fuse_file_read_iter_initialize_out(struct fuse_args *fa, struct fuse_file_read_iter_io *fri,
+					      struct kiocb *iocb, struct iov_iter *to)
+{
+	fri->frio = (struct fuse_read_iter_out) {
+		.ret = fri->fri.size,
+	};
+
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(fri->frio);
+	fa->out_args[0].value = &fri->frio;
+
+	return 0;
+}
+
+static int fuse_file_read_iter_backing(struct fuse_args *fa, ssize_t *out,
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
+				iocb_to_rw_flags(iocb->ki_flags, FUSE_BPF_IOCB_MASK));
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
+static int fuse_file_read_iter_finalize(struct fuse_args *fa, ssize_t *out,
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
+	return fuse_bpf_backing(inode, struct fuse_file_read_iter_io, out,
+				fuse_file_read_iter_initialize_in,
+				fuse_file_read_iter_initialize_out,
+				fuse_file_read_iter_backing,
+				fuse_file_read_iter_finalize,
+				iocb, to);
+}
+
+struct fuse_write_iter_out {
+	uint64_t ret;
+};
+struct fuse_file_write_iter_io {
+	struct fuse_write_in fwi;
+	struct fuse_write_out fwo;
+	struct fuse_write_iter_out fwio;
+};
+
+static int fuse_file_write_iter_initialize_in(struct fuse_args *fa,
+					      struct fuse_file_write_iter_io *fwio,
+					      struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+
+	*fwio = (struct fuse_file_write_iter_io) {
+		.fwi.fh = ff->fh,
+		.fwi.offset = iocb->ki_pos,
+		.fwi.size = from->count,
+	};
+
+	/* TODO we can't assume 'from' is a kvec */
+	*fa = (struct fuse_args) {
+		.opcode = FUSE_WRITE,
+		.nodeid = ff->nodeid,
+		.in_numargs = 2,
+		.in_args[0].size = sizeof(fwio->fwi),
+		.in_args[0].value = &fwio->fwi,
+		.in_args[1].size = fwio->fwi.size,
+		.in_args[1].value = from->kvec->iov_base,
+	};
+
+	return 0;
+}
+
+static int fuse_file_write_iter_initialize_out(struct fuse_args *fa,
+					       struct fuse_file_write_iter_io *fwio,
+					       struct kiocb *iocb, struct iov_iter *from)
+{
+	/* TODO we can't assume 'from' is a kvec */
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(fwio->fwio);
+	fa->out_args[0].value = &fwio->fwio;
+
+	return 0;
+}
+
+static int fuse_file_write_iter_backing(struct fuse_args *fa, ssize_t *out,
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
+					   iocb_to_rw_flags(iocb->ki_flags, FUSE_BPF_IOCB_MASK));
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
+static int fuse_file_write_iter_finalize(struct fuse_args *fa, ssize_t *out,
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
+	return fuse_bpf_backing(inode, struct fuse_file_write_iter_io, out,
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
@@ -1280,3 +1641,19 @@ int fuse_bpf_access(int *out, struct inode *inode, int mask)
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
index 247ef4f76761..685552453751 100644
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
index 70a5bd5403ca..59f3d85106d3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1604,6 +1604,7 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(file);
+	ssize_t ret;
 
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -1611,6 +1612,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
+	if (fuse_bpf_file_read_iter(&ret, inode, iocb, to))
+		return ret;
+
 	if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_read_iter(iocb, to);
 	else
@@ -1622,6 +1626,7 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(file);
+	ssize_t ret = 0;
 
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -1629,6 +1634,9 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
+	if (fuse_bpf_file_write_iter(&ret, inode, iocb, from))
+		return ret;
+
 	if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_write_iter(iocb, from);
 	else
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index dc5bba2a75ab..25cedaa9014c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1130,7 +1130,7 @@ int fuse_dev_init(void);
 void fuse_dev_cleanup(void);
 
 int fuse_ctl_init(void);
-void __exit fuse_ctl_cleanup(void);
+void fuse_ctl_cleanup(void);
 
 /**
  * Simple request sending that does request allocation and freeing
@@ -1410,6 +1410,8 @@ int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry);
 int fuse_bpf_release(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
+int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *to);
+int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *from);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
@@ -1462,6 +1464,16 @@ static inline int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *
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
@@ -1512,4 +1524,9 @@ static inline u64 attr_timeout(struct fuse_attr_out *o)
 	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
 }
 
+#ifdef CONFIG_FUSE_BPF
+int __init fuse_bpf_init(void);
+void __exit fuse_bpf_cleanup(void);
+#endif /* CONFIG_FUSE_BPF */
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bafb2832627d..9781faff6df6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2094,11 +2094,21 @@ static int __init fuse_init(void)
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
@@ -2116,6 +2126,9 @@ static void __exit fuse_exit(void)
 	fuse_ctl_cleanup();
 	fuse_sysfs_cleanup();
 	fuse_fs_cleanup();
+#ifdef CONFIG_FUSE_BPF
+	fuse_bpf_cleanup();
+#endif
 	fuse_dev_cleanup();
 }
 
-- 
2.38.1.584.g0f3c55d4c2-goog

