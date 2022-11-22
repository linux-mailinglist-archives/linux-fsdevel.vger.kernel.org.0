Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C992163331A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 03:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiKVCTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 21:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiKVCR5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:17:57 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4EBE8709
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q135-20020a25d98d000000b006eebd2f0844so113963ybg.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+7lnONjHdi886Ig9Mqdu5pD+AjkqXhnQE6noiyOFdJA=;
        b=lrtwBrtXPPkYidFgin2J04BdRiJSMvbPz4VqiHsVwzBDAG9kDpeEPdifXAxmHw9zI0
         NKIkiPinjAMKlnqhSyv2sygr81lgE3nvzHVOn8k8x8uiH8dfmKseRpx7dw9KRkf7Hg2c
         lXbCB4QF3JdaNV7G03QBFnoniUskfNIfqqijZfJCWFEjW/44GdV8ysqFYt+GCyXJfN6g
         r+1L/JiP9nTm8+tZ0g8k577RNDvLHeONZM4F+pfQhpVob28c+olV32piW3TxFwIYXYLH
         57nmypvY34lk73vshQ6JxZ9nW5b8Rqizz3+kFsf9bb7liLpnIuarGf6lY2UXRbNq1ZoX
         ucUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7lnONjHdi886Ig9Mqdu5pD+AjkqXhnQE6noiyOFdJA=;
        b=X73BNZGoKWFqFcgrle4rYE7yMPZy2orisiEtZRixXhhHvqU7STuQJgHjf/MvL6bETL
         Ng5/bIKuoOLhHCOFUU2AQSQUQnYhFE+R+W6t/MnE9aBukvbQnOy6YS1IXlgHFqYUulMU
         70XnPVRMJL9/W0A7ecPUhGy+tp2ytH/q1IMw05gq1itwIgk4ZpQkR91DEmawm5JtvCXc
         uZ7oM5w4Oio+WKemaSFe4mObYBK2nHqTov4j3Zz23UKJsdzEmgm1EfJnq6I1HpM6e69j
         E4x8kEhQnmH/nEk7aANy4sUijJuItN0yvzNxDlJO8iEgRYAtV4U5txpe8A6l/FNV5ljr
         OmPg==
X-Gm-Message-State: ACrzQf3572opdBdPuSIMrXaBBV61VhHdVe2EJdEI04CburXpqnnBxRaQ
        D5inhqakTak7lxLNvnHsNv9Rmp67Uk8=
X-Google-Smtp-Source: AMsMyM5qNEluRhS7QKFWTOvy41GiEHaYUT0ydWTishvpXmRnJKjIU8Cs0lqnFvk4wZM2iqmoOyga+rGwBhU=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a25:1181:0:b0:6bf:bd96:2b01 with SMTP id
 123-20020a251181000000b006bfbd962b01mr63735903ybr.17.1669083388163; Mon, 21
 Nov 2022 18:16:28 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:30 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-16-drosen@google.com>
Subject: [RFC PATCH v2 15/21] fuse-bpf: Add support for sync operations
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
 fs/fuse/backing.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |   3 +
 fs/fuse/file.c    |   6 ++
 fs/fuse/fuse_i.h  |  18 ++++++
 4 files changed, 169 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index a15b5c107cfe..719292e03b18 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -652,6 +652,58 @@ int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file)
 				fuse_release_backing, fuse_release_finalize, inode, file);
 }
 
+static int fuse_flush_initialize_in(struct fuse_args *fa, struct fuse_flush_in *ffi,
+				    struct file *file, fl_owner_t id)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	*ffi = (struct fuse_flush_in) {
+		.fh = fuse_file->fh,
+	};
+
+	*fa = (struct fuse_args) {
+		.nodeid = get_node_id(file->f_inode),
+		.opcode = FUSE_FLUSH,
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*ffi),
+		.in_args[0].value = ffi,
+		.force = true,
+	};
+
+	return 0;
+}
+
+static int fuse_flush_initialize_out(struct fuse_args *fa, struct fuse_flush_in *ffi,
+				     struct file *file, fl_owner_t id)
+{
+	return 0;
+}
+
+static int fuse_flush_backing(struct fuse_args *fa, int *out, struct file *file, fl_owner_t id)
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
+static int fuse_flush_finalize(struct fuse_args *fa, int *out, struct file *file, fl_owner_t id)
+{
+	return 0;
+}
+
+int fuse_bpf_flush(int *out, struct inode *inode, struct file *file, fl_owner_t id)
+{
+	return fuse_bpf_backing(inode, struct fuse_flush_in, out,
+				fuse_flush_initialize_in, fuse_flush_initialize_out,
+				fuse_flush_backing,
+				fuse_flush_finalize,
+				file, id);
+}
+
 struct fuse_lseek_io {
 	struct fuse_lseek_in fli;
 	struct fuse_lseek_out flo;
@@ -740,6 +792,96 @@ int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t o
 				file, offset, whence);
 }
 
+static int fuse_fsync_initialize_in(struct fuse_args *fa, struct fuse_fsync_in *ffi,
+				    struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	*ffi = (struct fuse_fsync_in) {
+		.fh = fuse_file->fh,
+		.fsync_flags = datasync ? FUSE_FSYNC_FDATASYNC : 0,
+	};
+
+	*fa = (struct fuse_args) {
+		.nodeid = get_fuse_inode(file->f_inode)->nodeid,
+		.opcode = FUSE_FSYNC,
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*ffi),
+		.in_args[0].value = ffi,
+		.force = true,
+	};
+
+	return 0;
+}
+
+static int fuse_fsync_initialize_out(struct fuse_args *fa, struct fuse_fsync_in *ffi,
+				     struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
+static int fuse_fsync_backing(struct fuse_args *fa, int *out,
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
+static int fuse_fsync_finalize(struct fuse_args *fa, int *out,
+			       struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
+int fuse_bpf_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return fuse_bpf_backing(inode, struct fuse_fsync_in, out,
+				fuse_fsync_initialize_in, fuse_fsync_initialize_out,
+				fuse_fsync_backing, fuse_fsync_finalize,
+				file, start, end, datasync);
+}
+
+static int fuse_dir_fsync_initialize_in(struct fuse_args *fa, struct fuse_fsync_in *ffi,
+					struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	*ffi = (struct fuse_fsync_in) {
+		.fh = fuse_file->fh,
+		.fsync_flags = datasync ? FUSE_FSYNC_FDATASYNC : 0,
+	};
+
+	*fa = (struct fuse_args) {
+		.nodeid = get_fuse_inode(file->f_inode)->nodeid,
+		.opcode = FUSE_FSYNCDIR,
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*ffi),
+		.in_args[0].value = ffi,
+		.force = true,
+	};
+
+	return 0;
+}
+
+static int fuse_dir_fsync_initialize_out(struct fuse_args *fa, struct fuse_fsync_in *ffi,
+					 struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
+int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return fuse_bpf_backing(inode, struct fuse_fsync_in, out,
+				fuse_dir_fsync_initialize_in, fuse_dir_fsync_initialize_out,
+				fuse_fsync_backing, fuse_fsync_finalize,
+				file, start, end, datasync);
+}
+
 static inline void fuse_bpf_aio_put(struct fuse_bpf_aio_req *aio_req)
 {
 	if (refcount_dec_and_test(&aio_req->ref))
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 729a0348fa01..55ed3fb9d4a3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1591,6 +1591,9 @@ static int fuse_dir_fsync(struct file *file, loff_t start, loff_t end,
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_dir_fsync(&err, inode, file, start, end, datasync))
+		return err;
+
 	if (fc->no_fsyncdir)
 		return 0;
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 59f3d85106d3..fa9ee2740a42 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -502,6 +502,9 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_flush(&err, file_inode(file), file, id))
+		return err;
+
 	if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
 		return 0;
 
@@ -577,6 +580,9 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_fsync(&err, inode, file, start, end, datasync))
+		return err;
+
 	inode_lock(inode);
 
 	/*
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0ea3fb74caab..cb087364e9bb 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1409,7 +1409,10 @@ int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry);
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
@@ -1460,11 +1463,26 @@ static inline int fuse_bpf_releasedir(int *out, struct inode *inode, struct file
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
2.38.1.584.g0f3c55d4c2-goog

