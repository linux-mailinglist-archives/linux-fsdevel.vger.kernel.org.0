Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963E25EB58C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiIZXU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiIZXTL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32650AE850
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a2-20020a5b0002000000b006b48689da76so7059490ybp.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=2Vms6hT+a5AXcGx17Wqoa38QyfAlu/Z7/56LHSXtwF0=;
        b=hR+9ea/UI4PHjIU2gyK9peBCvVu080aH8iNz5YwOMrzV4BPGGVScQk0Dleakmbveb1
         k6Ma4BaknfcKJuc8EL4izk/wswjiJjfetupBDDnEyZkW6vbCLXgZbIXy1stterUIELh+
         SaPOe+EHGhjwrZNTqJLKVLzFO4PcG7VpSJAyHNdm8OxZmQ6TQo2F1SdD0cN8/K8Yrnxg
         LJtf5IRoeaD7ZZIPAOl1z9n92COBClqSLp6eJ8gs8D/qDjY4IZiicVz7yQd4mMm4LgO8
         kKfyA8gECzVLh8FID2p92gQtNk27wU46fOPiu4fLvsThMJTJmBMjhmA3dEWP5n+Y0MOn
         niMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=2Vms6hT+a5AXcGx17Wqoa38QyfAlu/Z7/56LHSXtwF0=;
        b=pMLxcONc/o/SduLQMDadUWpHPyQAmzOQ4lZAt50ny/2xEsCajTRPvkTRtWTjM1V0d7
         +FAQp712njumsqE4EyPNWVr1tuMzDw8PK0iF2oNYfUPLIgLJ0WkxCP8KqhrJQ2HyC2RY
         sYJ+Z8hAD+tabjAf/CwWZ+EX2kJHgVsRfLY0fYGuqhcfF2+kFd0CyN6CVtTTjBgtxSlI
         WC3jyjXx3SJO/8LpTxhcsUUK1k7PAFPxHTxi7MWhWNZu2Rap+HqX1ncFIdafLV3Tdunn
         6F/M5WnDKSPIZB3kuE2K16eiARfbW+Sk5UcG/crMfSWSmjCBZe5dlN33zdHhQjcFP9+A
         r2YA==
X-Gm-Message-State: ACrzQf1l9+ZC6Kw+r8tgWAmUmcRq/FH1KF/ATz9JulQ8HKpwyAnZM3id
        h54PXIQHSj2KU9pHsVgpJOPrT803yKg=
X-Google-Smtp-Source: AMsMyM7YjJYj+OfuEcDkdYQnOEA5bambgULEkZXfRYlzwlLxvbF3+7AlvvcRz+N+1J2wOULfBKvQ1FT2mK4=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a25:9f0e:0:b0:691:f74:9ed6 with SMTP id
 n14-20020a259f0e000000b006910f749ed6mr23694271ybq.307.1664234349492; Mon, 26
 Sep 2022 16:19:09 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:11 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-16-drosen@google.com>
Subject: [PATCH 15/26] fuse-bpf: Add support for read/write iter
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 291 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/control.c |   2 +-
 fs/fuse/file.c    |  28 +++++
 fs/fuse/fuse_i.h  |  42 ++++++-
 fs/fuse/inode.c   |  13 +++
 5 files changed, 374 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 1fe61177cdfb..cf4ad9f4fe10 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -12,6 +12,47 @@
 #include <linux/namei.h>
 #include <linux/bpf_fuse.h>
 
+#define FUSE_BPF_IOCB_MASK (IOCB_APPEND | IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
+
+struct fuse_bpf_aio_req {
+	struct kiocb iocb;
+	refcount_t ref;
+	struct kiocb *iocb_orig;
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
+}
+
 struct bpf_prog *fuse_get_bpf_prog(struct file *file)
 {
 	struct bpf_prog *bpf_prog = ERR_PTR(-EINVAL);
@@ -469,6 +510,241 @@ int fuse_lseek_finalize(struct bpf_fuse_args *fa, loff_t *out,
 	return 0;
 }
 
+static inline void fuse_bpf_aio_put(struct fuse_bpf_aio_req *aio_req)
+{
+	if (refcount_dec_and_test(&aio_req->ref))
+		kmem_cache_free(fuse_bpf_aio_request_cachep, aio_req);
+}
+
+static void fuse_bpf_aio_cleanup_handler(struct fuse_bpf_aio_req *aio_req)
+{
+	struct kiocb *iocb = &aio_req->iocb;
+	struct kiocb *iocb_orig = aio_req->iocb_orig;
+
+	if (iocb->ki_flags & IOCB_WRITE) {
+		__sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
+				      SB_FREEZE_WRITE);
+		file_end_write(iocb->ki_filp);
+		fuse_copyattr(iocb_orig->ki_filp, iocb->ki_filp);
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
+	fuse_bpf_aio_cleanup_handler(aio_req);
+	iocb_orig->ki_complete(iocb_orig, res);
+}
+
+int fuse_file_read_iter_initialize_in(struct bpf_fuse_args *fa, struct fuse_file_read_iter_io *fri,
+				      struct kiocb *iocb, struct iov_iter *to)
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
+	*fa = (struct bpf_fuse_args) {
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
+int fuse_file_read_iter_initialize_out(struct bpf_fuse_args *fa, struct fuse_file_read_iter_io *fri,
+				       struct kiocb *iocb, struct iov_iter *to)
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
+int fuse_file_read_iter_backing(struct bpf_fuse_args *fa, ssize_t *out,
+				struct kiocb *iocb, struct iov_iter *to)
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
+		*out = vfs_iter_read(ff->backing_file, to, &iocb->ki_pos,
+				iocb_to_rw_flags(iocb->ki_flags, FUSE_BPF_IOCB_MASK));
+	} else {
+		struct fuse_bpf_aio_req *aio_req;
+
+		*out = -ENOMEM;
+		aio_req = kmem_cache_zalloc(fuse_bpf_aio_request_cachep, GFP_KERNEL);
+		if (!aio_req)
+			goto out;
+
+		aio_req->iocb_orig = iocb;
+		kiocb_clone(&aio_req->iocb, iocb, ff->backing_file);
+		aio_req->iocb.ki_complete = fuse_bpf_aio_rw_complete;
+		refcount_set(&aio_req->ref, 2);
+		*out = vfs_iocb_iter_read(ff->backing_file, &aio_req->iocb, to);
+		fuse_bpf_aio_put(aio_req);
+		if (*out != -EIOCBQUEUED)
+			fuse_bpf_aio_cleanup_handler(aio_req);
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
+int fuse_file_read_iter_finalize(struct bpf_fuse_args *fa, ssize_t *out,
+				 struct kiocb *iocb, struct iov_iter *to)
+{
+	struct fuse_read_iter_out *frio = fa->out_args[0].value;
+
+	*out = frio->ret;
+
+	return 0;
+}
+
+int fuse_file_write_iter_initialize_in(struct bpf_fuse_args *fa,
+				       struct fuse_file_write_iter_io *fwio,
+				       struct kiocb *iocb, struct iov_iter *from)
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
+	*fa = (struct bpf_fuse_args) {
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
+int fuse_file_write_iter_initialize_out(struct bpf_fuse_args *fa,
+					struct fuse_file_write_iter_io *fwio,
+					struct kiocb *iocb, struct iov_iter *from)
+{
+	/* TODO we can't assume 'from' is a kvec */
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(fwio->fwio);
+	fa->out_args[0].value = &fwio->fwio;
+
+	return 0;
+}
+
+int fuse_file_write_iter_backing(struct bpf_fuse_args *fa, ssize_t *out,
+				 struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+	struct fuse_write_iter_out *fwio = fa->out_args[0].value;
+
+	if (!iov_iter_count(from))
+		return 0;
+
+	/* TODO This just plain ignores any change to fuse_write_in */
+	/* TODO uint32_t seems smaller than ssize_t.... right? */
+	inode_lock(file_inode(file));
+
+	fuse_copyattr(file, ff->backing_file);
+
+	if (is_sync_kiocb(iocb)) {
+		file_start_write(ff->backing_file);
+		*out = vfs_iter_write(ff->backing_file, from, &iocb->ki_pos,
+					   iocb_to_rw_flags(iocb->ki_flags, FUSE_BPF_IOCB_MASK));
+		file_end_write(ff->backing_file);
+
+		/* Must reflect change in size of backing file to upper file */
+		if (*out > 0)
+			fuse_copyattr(file, ff->backing_file);
+	} else {
+		struct fuse_bpf_aio_req *aio_req;
+
+		*out = -ENOMEM;
+		aio_req = kmem_cache_zalloc(fuse_bpf_aio_request_cachep, GFP_KERNEL);
+		if (!aio_req)
+			goto out;
+
+		file_start_write(ff->backing_file);
+		__sb_writers_release(file_inode(ff->backing_file)->i_sb, SB_FREEZE_WRITE);
+		aio_req->iocb_orig = iocb;
+		kiocb_clone(&aio_req->iocb, iocb, ff->backing_file);
+		aio_req->iocb.ki_complete = fuse_bpf_aio_rw_complete;
+		refcount_set(&aio_req->ref, 2);
+		*out = vfs_iocb_iter_write(ff->backing_file, &aio_req->iocb, from);
+		fuse_bpf_aio_put(aio_req);
+		if (*out != -EIOCBQUEUED)
+			fuse_bpf_aio_cleanup_handler(aio_req);
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
+int fuse_file_write_iter_finalize(struct bpf_fuse_args *fa, ssize_t *out,
+				  struct kiocb *iocb, struct iov_iter *from)
+{
+	struct fuse_write_iter_out *fwio = fa->out_args[0].value;
+
+	*out = fwio->ret;
+	return 0;
+}
+
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	int ret;
@@ -1074,3 +1350,18 @@ int fuse_access_finalize(struct bpf_fuse_args *fa, int *out, struct inode *inode
 	return 0;
 }
 
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
index 7feb73274c3e..443f1af8a431 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1625,6 +1625,20 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
+#ifdef CONFIG_FUSE_BPF
+	{
+		ssize_t ret;
+
+		if (fuse_bpf_backing(inode, struct fuse_file_read_iter_io, ret,
+				       fuse_file_read_iter_initialize_in,
+				       fuse_file_read_iter_initialize_out,
+				       fuse_file_read_iter_backing,
+				       fuse_file_read_iter_finalize,
+				       iocb, to))
+			return ret;
+	}
+#endif
+
 	if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_read_iter(iocb, to);
 	else
@@ -1643,6 +1657,20 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
+#ifdef CONFIG_FUSE_BPF
+	{
+		ssize_t ret = 0;
+
+		if (fuse_bpf_backing(inode, struct fuse_file_write_iter_io, ret,
+				       fuse_file_write_iter_initialize_in,
+				       fuse_file_write_iter_initialize_out,
+				       fuse_file_write_iter_backing,
+				       fuse_file_write_iter_finalize,
+				       iocb, from))
+			return ret;
+	}
+#endif
+
 	if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_write_iter(iocb, from);
 	else
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9d6c9cc68268..f427a7bb367c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1135,7 +1135,7 @@ int fuse_dev_init(void);
 void fuse_dev_cleanup(void);
 
 int fuse_ctl_init(void);
-void __exit fuse_ctl_cleanup(void);
+void fuse_ctl_cleanup(void);
 
 /**
  * Simple request sending that does request allocation and freeing
@@ -1503,6 +1503,43 @@ int fuse_lseek_backing(struct bpf_fuse_args *fa, loff_t *out, struct file *file,
 int fuse_lseek_finalize(struct bpf_fuse_args *fa, loff_t *out, struct file *file,
 			loff_t offset, int whence);
 
+struct fuse_read_iter_out {
+	uint64_t ret;
+};
+struct fuse_file_read_iter_io {
+	struct fuse_read_in fri;
+	struct fuse_read_iter_out frio;
+};
+
+int fuse_file_read_iter_initialize_in(struct bpf_fuse_args *fa, struct fuse_file_read_iter_io *fri,
+				      struct kiocb *iocb, struct iov_iter *to);
+int fuse_file_read_iter_initialize_out(struct bpf_fuse_args *fa, struct fuse_file_read_iter_io *fri,
+				       struct kiocb *iocb, struct iov_iter *to);
+int fuse_file_read_iter_backing(struct bpf_fuse_args *fa, ssize_t *out,
+				struct kiocb *iocb, struct iov_iter *to);
+int fuse_file_read_iter_finalize(struct bpf_fuse_args *fa, ssize_t *out,
+				 struct kiocb *iocb, struct iov_iter *to);
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
+int fuse_file_write_iter_initialize_in(struct bpf_fuse_args *fa,
+				       struct fuse_file_write_iter_io *fwio,
+				       struct kiocb *iocb, struct iov_iter *from);
+int fuse_file_write_iter_initialize_out(struct bpf_fuse_args *fa,
+					struct fuse_file_write_iter_io *fwio,
+					struct kiocb *iocb, struct iov_iter *from);
+int fuse_file_write_iter_backing(struct bpf_fuse_args *fa, ssize_t *out,
+				 struct kiocb *iocb, struct iov_iter *from);
+int fuse_file_write_iter_finalize(struct bpf_fuse_args *fa, ssize_t *out,
+				  struct kiocb *iocb, struct iov_iter *from);
+
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma);
 
 int fuse_file_fallocate_initialize_in(struct bpf_fuse_args *fa,
@@ -1570,6 +1607,9 @@ static inline u64 attr_timeout(struct fuse_attr_out *o)
 }
 
 #ifdef CONFIG_FUSE_BPF
+int __init fuse_bpf_init(void);
+void __exit fuse_bpf_cleanup(void);
+
 /*
  * expression statement to wrap the backing filter logic
  * struct inode *inode: inode with bpf and backing inode
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 290eae750282..c96cfcbfd96a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2117,11 +2117,21 @@ static int __init fuse_init(void)
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
@@ -2139,6 +2149,9 @@ static void __exit fuse_exit(void)
 	fuse_ctl_cleanup();
 	fuse_sysfs_cleanup();
 	fuse_fs_cleanup();
+#ifdef CONFIG_FUSE_BPF
+	fuse_bpf_cleanup();
+#endif
 	fuse_dev_cleanup();
 }
 
-- 
2.37.3.998.g577e59143f-goog

