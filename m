Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5892B6E56DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjDRBnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjDRBmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:42:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FC365B5
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54be7584b28so368339407b3.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782094; x=1684374094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHPyQOgLAeTv27Hmk1jV/Qw6lBeg9KsOnD3+nmdgTBc=;
        b=WfhU75GkbNBBGPNdlQQqWpIVlOAmIt1xhsdC8ETWkv8e89D2kVJXdfo2nDvpBH4oXa
         nqAcJ0rkvNDwDtDwu+BjaH1Q8oFoMz/kg0Or59UBboMN/KJfqzGCb2RqOb/U/0RSQ32t
         dDjHoFKhRwU61k68E2xItY5TqBQZUfdSkdlDFCBzv5zViEbPhG4YAFlvC6a4+lykVyz3
         PN4aTi6QZSAJo3dKZSZtek7fRmsqdmoYf8DNy1EJQUBpOuz65vrZutPzrVi47/+A8syB
         akZ3w8TvKAFp/kH3G4HD2NJLL5M0F242/508++FqsS0CRy19r4HQJW7deZinJ5f6k7Yh
         LtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782094; x=1684374094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHPyQOgLAeTv27Hmk1jV/Qw6lBeg9KsOnD3+nmdgTBc=;
        b=YHHGPn6Wp5S2HzZy30t5GY6y3vnKz0X+RWsptOgeNeSmODuDosXIQ6NWhZltlSH7Xb
         cK6N6U3ujhMnGIoRBYaG8w6Jxc32rEaXO6hj8XTP8ICGVAcnsV7dCa2+AXdzWeotQjzK
         tpd5W2sp7jsREKNxCrQpFZwraa2HNhxtPzPMJNWv0jDUm23lsSDOI8y6nQ3k91ACPmY2
         HhBPET4vKVIGRTZrbAE+TA4oO2DMsgcUwRZquYEUV5a5U6pxjjbldzzWqRKuluDaBwtk
         s9xTYuHxhZarDmBjVnnmmYIFm/swhtbohxIpQvXoluapMUeyW8QEGs9ekKGyBy3ioYup
         1gyw==
X-Gm-Message-State: AAQBX9fOrXSdxqG5PzfGBmarukcW6xDWJgBwQh1Gio70wlihlIhot6Pt
        y0jRP/J3FQIXiwU7bQBAPKE7NAhH7DY=
X-Google-Smtp-Source: AKy350ZGdfGHneASHc+2qR8hpHc/w9BF7/xnpO/COHxv9rPK2B1jF3L8CR7fh6IuzYQx0u6d+K6DOtAYt2s=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:8051:0:b0:b92:40f8:a46f with SMTP id
 a17-20020a258051000000b00b9240f8a46fmr4359628ybn.2.1681782094311; Mon, 17 Apr
 2023 18:41:34 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:19 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-20-drosen@google.com>
Subject: [RFC PATCH v3 19/37] fuse-bpf: Add support for sync operations
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds backing support for FUSE_FLUSH, FUSE_FSYNC, and FUSE_FSYNCDIR.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |   3 +
 fs/fuse/file.c    |   7 +++
 fs/fuse/fuse_i.h  |  18 ++++++
 4 files changed, 175 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 2908c231a695..30492f7b2a05 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -659,6 +659,59 @@ int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file)
 				fuse_release_backing, fuse_release_finalize, inode, file);
 }
 
+static int fuse_flush_initialize_in(struct bpf_fuse_args *fa, struct fuse_flush_in *ffi,
+				    struct file *file, fl_owner_t id)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	*ffi = (struct fuse_flush_in) {
+		.fh = fuse_file->fh,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(file->f_inode),
+			.opcode = FUSE_FLUSH,
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*ffi),
+		.in_args[0].value = ffi,
+		.flags = FUSE_BPF_FORCE,
+	};
+
+	return 0;
+}
+
+static int fuse_flush_initialize_out(struct bpf_fuse_args *fa, struct fuse_flush_in *ffi,
+				     struct file *file, fl_owner_t id)
+{
+	return 0;
+}
+
+static int fuse_flush_backing(struct bpf_fuse_args *fa, int *out, struct file *file, fl_owner_t id)
+{
+	struct fuse_file *fuse_file = file->private_data;
+	struct file *backing_file = fuse_file->backing_file;
+
+	*out = 0;
+	if (backing_file->f_op->flush)
+		*out = backing_file->f_op->flush(backing_file, id);
+	return *out;
+}
+
+static int fuse_flush_finalize(struct bpf_fuse_args *fa, int *out, struct file *file, fl_owner_t id)
+{
+	return 0;
+}
+
+int fuse_bpf_flush(int *out, struct inode *inode, struct file *file, fl_owner_t id)
+{
+	return bpf_fuse_backing(inode, struct fuse_flush_in, out,
+				fuse_flush_initialize_in, fuse_flush_initialize_out,
+				fuse_flush_backing, fuse_flush_finalize,
+				file, id);
+}
+
 struct fuse_lseek_args {
 	struct fuse_lseek_in in;
 	struct fuse_lseek_out out;
@@ -748,6 +801,100 @@ int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t o
 				file, offset, whence);
 }
 
+static int fuse_fsync_initialize_in(struct bpf_fuse_args *fa, struct fuse_fsync_in *in,
+				    struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	*in = (struct fuse_fsync_in) {
+		.fh = fuse_file->fh,
+		.fsync_flags = datasync ? FUSE_FSYNC_FDATASYNC : 0,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(file->f_inode)->nodeid,
+			.opcode = FUSE_FSYNC,
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*in),
+		.in_args[0].value = in,
+		.flags = FUSE_BPF_FORCE,
+	};
+
+	return 0;
+}
+
+static int fuse_fsync_initialize_out(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
+				     struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
+static int fuse_fsync_backing(struct bpf_fuse_args *fa, int *out,
+			      struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct fuse_file *fuse_file = file->private_data;
+	struct file *backing_file = fuse_file->backing_file;
+	const struct fuse_fsync_in *ffi = fa->in_args[0].value;
+	int new_datasync = (ffi->fsync_flags & FUSE_FSYNC_FDATASYNC) ? 1 : 0;
+
+	*out = vfs_fsync(backing_file, new_datasync);
+	return 0;
+}
+
+static int fuse_fsync_finalize(struct bpf_fuse_args *fa, int *out,
+			       struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
+int fuse_bpf_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return bpf_fuse_backing(inode, struct fuse_fsync_in, out,
+				fuse_fsync_initialize_in, fuse_fsync_initialize_out,
+				fuse_fsync_backing, fuse_fsync_finalize,
+				file, start, end, datasync);
+}
+
+static int fuse_dir_fsync_initialize_in(struct bpf_fuse_args *fa, struct fuse_fsync_in *in,
+					struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	*in = (struct fuse_fsync_in) {
+		.fh = fuse_file->fh,
+		.fsync_flags = datasync ? FUSE_FSYNC_FDATASYNC : 0,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(file->f_inode)->nodeid,
+			.opcode = FUSE_FSYNCDIR,
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*in),
+		.in_args[0].value = in,
+		.flags = FUSE_BPF_FORCE,
+	};
+
+	return 0;
+}
+
+static int fuse_dir_fsync_initialize_out(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
+					 struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
+int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return bpf_fuse_backing(inode, struct fuse_fsync_in, out,
+				fuse_dir_fsync_initialize_in, fuse_dir_fsync_initialize_out,
+				fuse_fsync_backing, fuse_fsync_finalize,
+				file, start, end, datasync);
+}
+
 static inline void fuse_bpf_aio_put(struct fuse_bpf_aio_req *aio_req)
 {
 	if (refcount_dec_and_test(&aio_req->ref))
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a763a45fa973..5ce65f696980 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1666,6 +1666,9 @@ static int fuse_dir_fsync(struct file *file, loff_t start, loff_t end,
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_dir_fsync(&err, inode, file, start, end, datasync))
+		return err;
+
 	if (fc->no_fsyncdir)
 		return 0;
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5f19ef5bf124..a4a0aeb28e4a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -554,10 +554,14 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	struct inode *inode = file_inode(file);
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_file *ff = file->private_data;
+	int err;
 
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_flush(&err, file_inode(file), file, id))
+		return err;
+
 	if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
 		return 0;
 
@@ -615,6 +619,9 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_fsync(&err, inode, file, start, end, datasync))
+		return err;
+
 	inode_lock(inode);
 
 	/*
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fb3a77b79b0f..e60207bf66de 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1414,7 +1414,10 @@ int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry);
 int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry);
 int fuse_bpf_release(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file);
+int fuse_bpf_flush(int *out, struct inode *inode, struct file *file, fl_owner_t id);
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
+int fuse_bpf_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync);
+int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync);
 int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *to);
 int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *from);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
@@ -1465,11 +1468,26 @@ static inline int fuse_bpf_releasedir(int *out, struct inode *inode, struct file
 	return 0;
 }
 
+static inline int fuse_bpf_flush(int *out, struct inode *inode, struct file *file, fl_owner_t id)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence)
 {
 	return 0;
 }
 
+static inline int fuse_bpf_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
-- 
2.40.0.634.g4ca3ef3211-goog

