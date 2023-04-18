Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D686E56C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjDRBmy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjDRBmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:42:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1837B7ABE
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d14-20020a25e60e000000b00b8f65697946so10091078ybh.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782080; x=1684374080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NYL4IdJjh78Mx0ERjHXq1HM7WDhJyXfUI9ZLvdFWk98=;
        b=gDPc8KFBWBSDxYuCP48vLLO3Vue1Z2AubLCuuloL4zyW7pB2dhVnlUg0914m1YDuUd
         6Ne1KGXCk4u/o9jyWFV2XXPimdtwupUUcvgkfbZVD+J5Tucff+wx4eEkpGMKftKAyHVg
         ggIWdp57XhPiL081zazQF4KJrhUtgo1n62jsm/nCPnSpTOEEa0QdfXLnA7/I0/JPpbtE
         VeS6W6NpNQNbK8tDqcm+zMNAS2xTiCwbBK1HqQrGP1vXMzw3/f3jYAJNVlOzDCvIkqDR
         jKpbPZPCr3xy77kbdxnHzURMl+sPneGV3POnYfCtJgR+D28OHQNxJkj6v0N/ovT13U9O
         wz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782080; x=1684374080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYL4IdJjh78Mx0ERjHXq1HM7WDhJyXfUI9ZLvdFWk98=;
        b=JUrijdcKmmuRuD5D9Ul2lwZ/ahePQ6a1chvegCdfHLKrTCaT/DZMfxEpiQENg4ABnQ
         IABn3pOVKZf/dWvRqrhxtQbHu8RdnZaUteU70uq9+UWIA2EovZD8FRabPxQI2O7ln23I
         0Dz2D2tgdD/7PpQqCDmbTn2wb5zkjVgAa8mM5a1xJtNySTG7x+MIF5qZRbH/3s1hUmDT
         9K/Ub07Ew2ksYPTJMqVWxr0Qn8OA1b0tzb9y92gnAB+cTcYh5skC8kQhgBBEgJ0lawNg
         dxWUlaIFj0eV9BKIMIALOtQwm0giLQh50wCD0GaUh8UJgydj9vsn6vIBrkR0DhJ9cjEH
         Li5w==
X-Gm-Message-State: AAQBX9dcitFOYJydf6zon1CcyZ3O9Hvzb9vTCArDb24i4ZGqSM4hFP3g
        R7W2zpqsYDXV2nzpViq5rdIz8wDHwF0=
X-Google-Smtp-Source: AKy350YBlKkuvX66p/6m/H2JvUtFIa2769A+526n9Y5/glS4dC9W1cB3cMRNvaXNmAOriHpO5bnUIntTZ3U=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a0d:ec02:0:b0:54c:2723:560d with SMTP id
 q2-20020a0dec02000000b0054c2723560dmr10854311ywn.3.1681782080382; Mon, 17 Apr
 2023 18:41:20 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:13 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-14-drosen@google.com>
Subject: [RFC PATCH v3 13/37] fuse-bpf: Add lseek support
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

This adds backing support for FUSE_LSEEK

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c    |  3 ++
 fs/fuse/fuse_i.h  |  6 ++++
 3 files changed, 98 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 930aa370e376..c4916dde48c8 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -207,6 +207,95 @@ static void fuse_stat_to_attr(struct fuse_conn *fc, struct inode *inode,
 	attr->blksize = 1 << blkbits;
 }
 
+struct fuse_lseek_args {
+	struct fuse_lseek_in in;
+	struct fuse_lseek_out out;
+};
+
+static int fuse_lseek_initialize_in(struct bpf_fuse_args *fa, struct fuse_lseek_args *args,
+				    struct file *file, loff_t offset, int whence)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	args->in = (struct fuse_lseek_in) {
+		.fh = fuse_file->fh,
+		.offset = offset,
+		.whence = whence,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(file->f_inode),
+			.opcode = FUSE_LSEEK,
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(args->in),
+		.in_args[0].value = &args->in,
+	};
+
+	return 0;
+}
+
+static int fuse_lseek_initialize_out(struct bpf_fuse_args *fa, struct fuse_lseek_args *args,
+				     struct file *file, loff_t offset, int whence)
+{
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(args->out);
+	fa->out_args[0].value = &args->out;
+
+	return 0;
+}
+
+static int fuse_lseek_backing(struct bpf_fuse_args *fa, loff_t *out,
+			      struct file *file, loff_t offset, int whence)
+{
+	const struct fuse_lseek_in *fli = fa->in_args[0].value;
+	struct fuse_lseek_out *flo = fa->out_args[0].value;
+	struct fuse_file *fuse_file = file->private_data;
+	struct file *backing_file = fuse_file->backing_file;
+
+	/* TODO: Handle changing of the file handle */
+	if (offset == 0) {
+		if (whence == SEEK_CUR) {
+			flo->offset = file->f_pos;
+			*out = flo->offset;
+			return 0;
+		}
+
+		if (whence == SEEK_SET) {
+			flo->offset = vfs_setpos(file, 0, 0);
+			*out = flo->offset;
+			return 0;
+		}
+	}
+
+	inode_lock(file->f_inode);
+	backing_file->f_pos = file->f_pos;
+	*out = vfs_llseek(backing_file, fli->offset, fli->whence);
+	flo->offset = *out;
+	inode_unlock(file->f_inode);
+	return 0;
+}
+
+static int fuse_lseek_finalize(struct bpf_fuse_args *fa, loff_t *out,
+			       struct file *file, loff_t offset, int whence)
+{
+	struct fuse_lseek_out *flo = fa->out_args[0].value;
+
+	if (!fa->info.error_in)
+		file->f_pos = flo->offset;
+	*out = flo->offset;
+	return 0;
+}
+
+int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence)
+{
+	return bpf_fuse_backing(inode, struct fuse_lseek_args, out,
+				fuse_lseek_initialize_in, fuse_lseek_initialize_out,
+				fuse_lseek_backing, fuse_lseek_finalize,
+				file, offset, whence);
+}
+
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	int ret;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 865167a80d35..9758bd1665a6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2779,6 +2779,9 @@ static loff_t fuse_file_llseek(struct file *file, loff_t offset, int whence)
 	loff_t retval;
 	struct inode *inode = file_inode(file);
 
+	if (fuse_bpf_lseek(&retval, inode, file, offset, whence))
+		return retval;
+
 	switch (whence) {
 	case SEEK_SET:
 	case SEEK_CUR:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5eb357f482dc..624d0cebd287 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1405,11 +1405,17 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
 
 #ifdef CONFIG_FUSE_BPF
 
+int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
 #else
 
+static inline int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags)
 {
 	return 0;
-- 
2.40.0.634.g4ca3ef3211-goog

