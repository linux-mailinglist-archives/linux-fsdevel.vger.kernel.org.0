Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6C7633324
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 03:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiKVCUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 21:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiKVCTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:19:05 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5665E3D14
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:36 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-393c38f7bcfso107207727b3.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JFeUA3PbRtSHLNTEDynEdKNNWrqo68m/Sv/Ri911v1M=;
        b=jg7q/4HfLHsfBt1WL7tTNuB5B3bVu3bIH4ZmZLOvwtQ++pw/Tx1jZZa4cToMI7GJuy
         /+lbOSx4g82Rlg9a5y/azwCt2yFOG98n9bt6C1ANmyhGJMlJppMM0j7/OkqkOY8Em2Pn
         ACwO37txtQ7G0zdyJFLcw3XG2ghjR6lyLUPfcylAaC8vAuJdx7dhnSLyv+no1VmDeTWi
         6x51K9Xxu5mQSw28bsPkIZ4RefCbZJ2aA8BR8/zYcigYEEaPEl4Vfh4Ii4NdyiJlzW+2
         gqqz3L8Phg2zStOowpAC0DLKwASkP01kQ/jECUID7+e7lkmH/w1sWUT5Upoo7ejloHCI
         YOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFeUA3PbRtSHLNTEDynEdKNNWrqo68m/Sv/Ri911v1M=;
        b=DRzyuyUlVzr5kAx8YXPhS+vYEcKDTwux3SrPCoD9ny1o2xzIkEkN6Qiia3g1MA+jGt
         AEfuBs140oQPz/ma1ulWsQ8LyA0zdOn9MJa9rvZTXnAcHLHx98NOt3KRQTYsm3RnO+xJ
         u9/BLwY3Bz9dsfe89vkzGEYZzLPAZ3eOcPlJjm1RfyIUmccajX15qc70RBDklrekzGqa
         skeMXdBWSSF6mRc8euDbT8hf9Kioc9k4wsyzVumGAqprkkSh0+mNAmBF9bJhxWPAIL/t
         gxe5yXh7HnRVTjZVqJgkOc16coxXjefR5h6QZ/zsIAV/gnhBdfmZCYm5ScBBDd2Jxw+v
         P3sg==
X-Gm-Message-State: ANoB5pmm3W+hUlHwEOL4GulM+OhouZUJcaVU2hRjR2IvhvNmz1LyM6XP
        uhI/pfUwJnOLVeqMq7W9vBvlcscdy2Q=
X-Google-Smtp-Source: AA0mqf4OS7F3eu10sNB7hfjo5VTZ9mtZoxQ9rM/JwW9FGxFhh+kWW83TQuk9YPaDe/K1Dc9yRli+1XuvdQU=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a05:6902:1201:b0:6ec:73bd:1376 with SMTP id
 s1-20020a056902120100b006ec73bd1376mr1ybu.40.1669083395835; Mon, 21 Nov 2022
 18:16:35 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:33 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-19-drosen@google.com>
Subject: [RFC PATCH v2 18/21] fuse-bpf: Add support for FUSE_COPY_FILE_RANGE
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

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c    |  4 +++
 fs/fuse/fuse_i.h  | 10 ++++++
 3 files changed, 99 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index e2fe8c3aac2d..36c8688c4463 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -792,6 +792,91 @@ int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t o
 				file, offset, whence);
 }
 
+struct fuse_copy_file_range_io {
+	struct fuse_copy_file_range_in fci;
+	struct fuse_write_out fwo;
+};
+
+static int fuse_copy_file_range_initialize_in(struct fuse_args *fa,
+					      struct fuse_copy_file_range_io *fcf,
+					      struct file *file_in, loff_t pos_in, struct file *file_out,
+					      loff_t pos_out, size_t len, unsigned int flags)
+{
+	struct fuse_file *fuse_file_in = file_in->private_data;
+	struct fuse_file *fuse_file_out = file_out->private_data;
+
+	fcf->fci = (struct fuse_copy_file_range_in) {
+		.fh_in = fuse_file_in->fh,
+		.off_in = pos_in,
+		.nodeid_out = fuse_file_out->nodeid,
+		.fh_out = fuse_file_out->fh,
+		.off_out = pos_out,
+		.len = len,
+		.flags = flags,
+	};
+
+	*fa = (struct fuse_args) {
+		.nodeid = get_node_id(file_in->f_inode),
+		.opcode = FUSE_COPY_FILE_RANGE,
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(fcf->fci),
+		.in_args[0].value = &fcf->fci,
+	};
+
+	return 0;
+}
+
+static int fuse_copy_file_range_initialize_out(struct fuse_args *fa,
+					       struct fuse_copy_file_range_io *fcf,
+					       struct file *file_in, loff_t pos_in, struct file *file_out,
+					       loff_t pos_out, size_t len, unsigned int flags)
+{
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(fcf->fwo);
+	fa->out_args[0].value = &fcf->fwo;
+
+	return 0;
+}
+
+static int fuse_copy_file_range_backing(struct fuse_args *fa, ssize_t *out, struct file *file_in,
+					loff_t pos_in, struct file *file_out, loff_t pos_out, size_t len,
+					unsigned int flags)
+{
+	const struct fuse_copy_file_range_in *fci = fa->in_args[0].value;
+	struct fuse_file *fuse_file_in = file_in->private_data;
+	struct file *backing_file_in = fuse_file_in->backing_file;
+	struct fuse_file *fuse_file_out = file_out->private_data;
+	struct file *backing_file_out = fuse_file_out->backing_file;
+
+	/* TODO: Handle changing of in/out files */
+	if (backing_file_out)
+		*out = vfs_copy_file_range(backing_file_in, fci->off_in, backing_file_out,
+					   fci->off_out, fci->len, fci->flags);
+	else
+		*out = generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
+					       flags);
+	return 0;
+}
+
+static int fuse_copy_file_range_finalize(struct fuse_args *fa, ssize_t *out, struct file *file_in,
+					 loff_t pos_in, struct file *file_out, loff_t pos_out, size_t len,
+					 unsigned int flags)
+{
+	return 0;
+}
+
+int fuse_bpf_copy_file_range(ssize_t *out, struct inode *inode, struct file *file_in,
+			     loff_t pos_in, struct file *file_out, loff_t pos_out, size_t len,
+			     unsigned int flags)
+{
+	return fuse_bpf_backing(inode, struct fuse_copy_file_range_io, out,
+				fuse_copy_file_range_initialize_in,
+				fuse_copy_file_range_initialize_out,
+				fuse_copy_file_range_backing,
+				fuse_copy_file_range_finalize,
+				file_in, pos_in, file_out, pos_out, len, flags);
+}
+
 static int fuse_fsync_initialize_in(struct fuse_args *fa, struct fuse_fsync_in *ffi,
 				    struct file *file, loff_t start, loff_t end, int datasync)
 {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index fa9ee2740a42..8153e78ff1d6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3127,6 +3127,10 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	bool is_unstable = (!fc->writeback_cache) &&
 			   ((pos_out + len) > inode_out->i_size);
 
+	if (fuse_bpf_copy_file_range(&err, file_inode(file_in), file_in, pos_in,
+				     file_out, pos_out, len, flags))
+		return err;
+
 	if (fc->no_copy_file_range)
 		return -EOPNOTSUPP;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8ecaf55e4632..275b649bb5ed 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1416,6 +1416,9 @@ int fuse_bpf_release(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_flush(int *out, struct inode *inode, struct file *file, fl_owner_t id);
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
+int fuse_bpf_copy_file_range(ssize_t *out, struct inode *inode, struct file *file_in, loff_t pos_in,
+			     struct file *file_out, loff_t pos_out,
+			     size_t len, unsigned int flags);
 int fuse_bpf_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync);
 int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync);
 int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *to);
@@ -1495,6 +1498,13 @@ static inline int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *
 	return 0;
 }
 
+static inline int fuse_bpf_copy_file_range(ssize_t *out, struct inode *inode, struct file *file_in, loff_t pos_in,
+					   struct file *file_out, loff_t pos_out,
+					   size_t len, unsigned int flags)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync)
 {
 	return 0;
-- 
2.38.1.584.g0f3c55d4c2-goog

