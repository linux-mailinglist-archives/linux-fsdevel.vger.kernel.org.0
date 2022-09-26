Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E565EB594
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiIZXVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiIZXTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:32 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979DBEBD78
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:15 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id n11-20020a17090ade8b00b00200ab47f82fso2793142pjv.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=kEarMH2WfphhfcixiUioZfkeGDc7VISdu5Tdeqb4x7c=;
        b=AtpxV+bkSVPVBumpFA8NL3O5PdL4P2ugp9l2yKdDoH6Eh9aj5TRzQlagKazNsSDUTv
         f061wC6lkKahu/896JKL9vcoUIuCa5QWVclYiesoHq04oaUL1fqA6haevUQOnnOjC2ga
         A4RUm3tYkCoPpaZ3x4sszS1aIKuHL0K2vwCxC3zFqBprGu1J5Ked5iVqtDDSm0rcUIuH
         SQ6V83DEmrUuZHVpz4M+hgMtaMFOWjQb8HELRU4KuAVpHm44JfjY+8VmbgrbQGRd8rTc
         Us2bHH6IP2/L3N6LKvZRpu6sSUYa5YCeQVjf4/RHGDr+QKp0DADEmC6wsu6GgYp1jjOX
         rOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=kEarMH2WfphhfcixiUioZfkeGDc7VISdu5Tdeqb4x7c=;
        b=iG9Mb0+bI1IAHrG4naVXwI3BcnCBkBk2SYHLrPu69NEOY92u2BWW5hCBzcNsZIzH75
         wtuDRg0z11GNk/nvautmds7Nv4JOqSRUTV0hoPhgNsvOx8pakGmU6doKqZfmsAPq/NGx
         ZWWYt6DYcXV62V7u36lvZJjFtTSi6evsKGgpl6H83cv1Q9cezkKnjCmA+DFRUZuciYlt
         RXWK5wKGCAq/goQd8Pljqn000FYijMekhjLpahUaDSpHVRwgBk1XS+mXfB10vbItEqsL
         tYAolMHRkfRbay1vCDvb7hq0JI6oUK7L2yKVaV9f5nyWC7Z66ZWzBQgf1PUC5I6JSrS8
         9kJg==
X-Gm-Message-State: ACrzQf26qNuYyRzMHZoaaIdi6rW2RLQYAv+v24RMdT9u/Osu2udMFw1O
        YGJVSgACYkyod76aCS+6Ph1khLk/AUg=
X-Google-Smtp-Source: AMsMyM5/oyD0bCiBdDXDpgXSCvKMRAmdu33hy9rbdcT2L4rxi8lIxmO9pBBG+gtLhahpwNgnT1nJrCJF9qM=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a17:90a:4607:b0:202:e22d:489c with SMTP id
 w7-20020a17090a460700b00202e22d489cmr1229712pjg.80.1664234355074; Mon, 26 Sep
 2022 16:19:15 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:13 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-18-drosen@google.com>
Subject: [PATCH 17/26] fuse-bpf: Add support for sync operations
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |   8 ++++
 fs/fuse/file.c    |  17 +++++++
 fs/fuse/fuse_i.h  |  21 +++++++++
 4 files changed, 163 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index a31199064dc7..4fd7442c94a1 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -436,6 +436,49 @@ int fuse_release_finalize(struct bpf_fuse_args *fa, int *out,
 	return 0;
 }
 
+int fuse_flush_initialize_in(struct bpf_fuse_args *fa, struct fuse_flush_in *ffi,
+			     struct file *file, fl_owner_t id)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	*ffi = (struct fuse_flush_in) {
+		.fh = fuse_file->fh,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_node_id(file->f_inode),
+		.opcode = FUSE_FLUSH,
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*ffi),
+		.in_args[0].value = ffi,
+		.flags = FUSE_BPF_FORCE,
+	};
+
+	return 0;
+}
+
+int fuse_flush_initialize_out(struct bpf_fuse_args *fa, struct fuse_flush_in *ffi,
+			      struct file *file, fl_owner_t id)
+{
+	return 0;
+}
+
+int fuse_flush_backing(struct bpf_fuse_args *fa, int *out, struct file *file, fl_owner_t id)
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
+int fuse_flush_finalize(struct bpf_fuse_args *fa, int *out, struct file *file, fl_owner_t id)
+{
+	return 0;
+}
+
 int fuse_lseek_initialize_in(struct bpf_fuse_args *fa, struct fuse_lseek_io *flio,
 			     struct file *file, loff_t offset, int whence)
 {
@@ -510,6 +553,80 @@ int fuse_lseek_finalize(struct bpf_fuse_args *fa, loff_t *out,
 	return 0;
 }
 
+int fuse_fsync_initialize_in(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
+			     struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	*ffi = (struct fuse_fsync_in) {
+		.fh = fuse_file->fh,
+		.fsync_flags = datasync ? FUSE_FSYNC_FDATASYNC : 0,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_fuse_inode(file->f_inode)->nodeid,
+		.opcode = FUSE_FSYNC,
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*ffi),
+		.in_args[0].value = ffi,
+		.flags = FUSE_BPF_FORCE,
+	};
+
+	return 0;
+}
+
+int fuse_fsync_initialize_out(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
+			      struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
+int fuse_fsync_backing(struct bpf_fuse_args *fa, int *out,
+		       struct file *file, loff_t start, loff_t end, int datasync)
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
+int fuse_fsync_finalize(struct bpf_fuse_args *fa, int *out,
+			struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
+int fuse_dir_fsync_initialize_in(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
+				 struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	*ffi = (struct fuse_fsync_in) {
+		.fh = fuse_file->fh,
+		.fsync_flags = datasync ? FUSE_FSYNC_FDATASYNC : 0,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_fuse_inode(file->f_inode)->nodeid,
+		.opcode = FUSE_FSYNCDIR,
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*ffi),
+		.in_args[0].value = ffi,
+		.flags = FUSE_BPF_FORCE,
+	};
+
+	return 0;
+}
+
+int fuse_dir_fsync_initialize_out(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
+				  struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
 static inline void fuse_bpf_aio_put(struct fuse_bpf_aio_req *aio_req)
 {
 	if (refcount_dec_and_test(&aio_req->ref))
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d8237b7a23f2..f159b9a6d305 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1638,6 +1638,14 @@ static int fuse_dir_fsync(struct file *file, loff_t start, loff_t end,
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+#ifdef CONFIG_FUSE_BPF
+	if (fuse_bpf_backing(inode, struct fuse_fsync_in, err,
+			fuse_dir_fsync_initialize_in, fuse_dir_fsync_initialize_out,
+			fuse_fsync_backing, fuse_fsync_finalize,
+			file, start, end, datasync))
+		return err;
+#endif
+
 	if (fc->no_fsyncdir)
 		return 0;
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 443f1af8a431..fc8f8e3a06b3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -513,6 +513,15 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	FUSE_ARGS(args);
 	int err;
 
+#ifdef CONFIG_FUSE_BPF
+	if (fuse_bpf_backing(file->f_inode, struct fuse_flush_in, err,
+			       fuse_flush_initialize_in, fuse_flush_initialize_out,
+			       fuse_flush_backing,
+			       fuse_flush_finalize,
+			       file, id))
+	return err;
+#endif
+
 	if (fuse_is_bad(inode))
 		return -EIO;
 
@@ -588,6 +597,14 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	int err;
 
+#ifdef CONFIG_FUSE_BPF
+	if (fuse_bpf_backing(inode, struct fuse_fsync_in, err,
+			       fuse_fsync_initialize_in, fuse_fsync_initialize_out,
+			       fuse_fsync_backing, fuse_fsync_finalize,
+			       file, start, end, datasync))
+		return err;
+#endif
+
 	if (fuse_is_bad(inode))
 		return -EIO;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8780a50be244..db769dd0a2e4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1489,6 +1489,14 @@ int fuse_release_backing(struct bpf_fuse_args *fa, int *out,
 int fuse_release_finalize(struct bpf_fuse_args *fa, int *out,
 			    struct inode *inode, struct file *file);
 
+int fuse_flush_initialize_in(struct bpf_fuse_args *fa, struct fuse_flush_in *ffi,
+			     struct file *file, fl_owner_t id);
+int fuse_flush_initialize_out(struct bpf_fuse_args *fa, struct fuse_flush_in *ffi,
+			      struct file *file, fl_owner_t id);
+int fuse_flush_backing(struct bpf_fuse_args *fa, int *out, struct file *file, fl_owner_t id);
+int fuse_flush_finalize(struct bpf_fuse_args *fa, int *out,
+			struct file *file, fl_owner_t id);
+
 struct fuse_lseek_io {
 	struct fuse_lseek_in fli;
 	struct fuse_lseek_out flo;
@@ -1503,6 +1511,19 @@ int fuse_lseek_backing(struct bpf_fuse_args *fa, loff_t *out, struct file *file,
 int fuse_lseek_finalize(struct bpf_fuse_args *fa, loff_t *out, struct file *file,
 			loff_t offset, int whence);
 
+int fuse_fsync_initialize_in(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
+			     struct file *file, loff_t start, loff_t end, int datasync);
+int fuse_fsync_initialize_out(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
+			      struct file *file, loff_t start, loff_t end, int datasync);
+int fuse_fsync_backing(struct bpf_fuse_args *fa, int *out,
+		       struct file *file, loff_t start, loff_t end, int datasync);
+int fuse_fsync_finalize(struct bpf_fuse_args *fa, int *out,
+			struct file *file, loff_t start, loff_t end, int datasync);
+int fuse_dir_fsync_initialize_in(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
+				 struct file *file, loff_t start, loff_t end, int datasync);
+int fuse_dir_fsync_initialize_out(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
+				  struct file *file, loff_t start, loff_t end, int datasync);
+
 struct fuse_read_iter_out {
 	uint64_t ret;
 };
-- 
2.37.3.998.g577e59143f-goog

