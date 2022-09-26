Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5B05EB599
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiIZXVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiIZXTx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23274F34D2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b18-20020a253412000000b006b0177978eeso7106683yba.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=/MWTk5cysONTkajogc8imoYB1PQZdnV2vN5IrumczcE=;
        b=XDRyI/18RaNQpcgU8Kp0jScwwKVN13Ni2/yH3mX/U9JBrtoEx+QdaY/wpZJjagglW5
         IE4x6/Bu1aMoHR/TG2H4ogylyWcplz9TaZMoGNVKVmTJBNUhbNQy46UGx+nvbIaNlvDh
         QRFby+0lUFgpOA0+Tjc4/kY7FBGwrROoI8PSevRh2a2PEGCgskI8YJBv/SmkxOz5YQE+
         0JLCc57QmnDWPO0PSxx6wv5XvZNqphhY813MEg+SzmsvNtPPjK4Kz+EcKB0PYalQ50OC
         CG3OI8iYejv2XSWMfn1rEshQdWR1dPrjXu2XpaO5hMr9ddJoGDGI5mm1Ufif2Fla6AVh
         K6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=/MWTk5cysONTkajogc8imoYB1PQZdnV2vN5IrumczcE=;
        b=lRkRIgntqoUIjkgG9P1SQ+MSByOL0hR7/iTzVegrVlFxURHwpO8dSyyhoUs3cANDq7
         3Ut4qZDUJXUodYQls1fMlYFu64Vky03aOltx3mQhYiKKvEbjjZIn+hnxiBBNTDT6D4mq
         E3Cx/DC7iPZ1GxZ2lRmWl3S7ENGcy6U56u/FFqWvvtI/TFxQlAIlGa3/hOQE0kg6xR7w
         Alzu8GHgTQzg4nncK4/qQKbfhuD7/3tZsSjDAaLgpF37M0tMCfOCcXAtgvxOiCZ06GmP
         VR4FcVLAF3TzHDNY/2s+eQaphOIXdwVnXna5WlcRmb9yuuezRJi8BEsefz8RTOjXOWXL
         Nocg==
X-Gm-Message-State: ACrzQf2NIgezMhMxGBdYSoULNyXrhX32J8haKts7WlQfMMdfUI9IQ9EL
        XiEMFVCLW6PJka8WK7IRSAERo6Om+ZE=
X-Google-Smtp-Source: AMsMyM62dsLzOCPu+LpNtke5HI/IMmmzqLf1Opzm3w83M/6lP1DgNsrQvlEGIpJMTx5GERSkkGfgqF7z1Bk=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a25:3851:0:b0:6ad:9cba:9708 with SMTP id
 f78-20020a253851000000b006ad9cba9708mr23861237yba.36.1664234363392; Mon, 26
 Sep 2022 16:19:23 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:16 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-21-drosen@google.com>
Subject: [PATCH 20/26] fuse-bpf: Add support for FUSE_COPY_FILE_RANGE
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
 fs/fuse/backing.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c    | 10 +++++++
 fs/fuse/fuse_i.h  | 24 +++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 13075eddeb7e..8fd5cbfdd4fa 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -553,6 +553,74 @@ int fuse_lseek_finalize(struct bpf_fuse_args *fa, loff_t *out,
 	return 0;
 }
 
+int fuse_copy_file_range_initialize_in(struct bpf_fuse_args *fa,
+					struct fuse_copy_file_range_io *fcf,
+					struct file *file_in, loff_t pos_in, struct file *file_out,
+					loff_t pos_out, size_t len, unsigned int flags)
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
+	*fa = (struct bpf_fuse_args) {
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
+int fuse_copy_file_range_initialize_out(struct bpf_fuse_args *fa,
+					struct fuse_copy_file_range_io *fcf,
+					struct file *file_in, loff_t pos_in, struct file *file_out,
+					loff_t pos_out, size_t len, unsigned int flags)
+{
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(fcf->fwo);
+	fa->out_args[0].value = &fcf->fwo;
+
+	return 0;
+}
+
+int fuse_copy_file_range_backing(struct bpf_fuse_args *fa, ssize_t *out, struct file *file_in,
+				 loff_t pos_in, struct file *file_out, loff_t pos_out, size_t len,
+				 unsigned int flags)
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
+int fuse_copy_file_range_finalize(struct bpf_fuse_args *fa, ssize_t *out, struct file *file_in,
+				  loff_t pos_in, struct file *file_out, loff_t pos_out, size_t len,
+				  unsigned int flags)
+{
+	return 0;
+}
+
 int fuse_fsync_initialize_in(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
 			     struct file *file, loff_t start, loff_t end, int datasync)
 {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index fc8f8e3a06b3..85aeb6ade085 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3180,6 +3180,16 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	bool is_unstable = (!fc->writeback_cache) &&
 			   ((pos_out + len) > inode_out->i_size);
 
+#ifdef CONFIG_FUSE_BPF
+	if (fuse_bpf_backing(file_in->f_inode, struct fuse_copy_file_range_io, err,
+			       fuse_copy_file_range_initialize_in,
+			       fuse_copy_file_range_initialize_out,
+			       fuse_copy_file_range_backing,
+			       fuse_copy_file_range_finalize,
+			       file_in, pos_in, file_out, pos_out, len, flags))
+		return err;
+#endif
+
 	if (fc->no_copy_file_range)
 		return -EOPNOTSUPP;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f8eddcb24137..370fe944387e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1541,6 +1541,30 @@ int fuse_lseek_backing(struct bpf_fuse_args *fa, loff_t *out, struct file *file,
 int fuse_lseek_finalize(struct bpf_fuse_args *fa, loff_t *out, struct file *file,
 			loff_t offset, int whence);
 
+struct fuse_copy_file_range_io {
+	struct fuse_copy_file_range_in fci;
+	struct fuse_write_out fwo;
+};
+
+int fuse_copy_file_range_initialize_in(struct bpf_fuse_args *fa,
+				       struct fuse_copy_file_range_io *fcf,
+				       struct file *file_in, loff_t pos_in,
+				       struct file *file_out, loff_t pos_out,
+				       size_t len, unsigned int flags);
+int fuse_copy_file_range_initialize_out(struct bpf_fuse_args *fa,
+					struct fuse_copy_file_range_io *fcf,
+					struct file *file_in, loff_t pos_in,
+					struct file *file_out, loff_t pos_out,
+					size_t len, unsigned int flags);
+int fuse_copy_file_range_backing(struct bpf_fuse_args *fa, ssize_t *out,
+				 struct file *file_in, loff_t pos_in,
+				 struct file *file_out, loff_t pos_out,
+				 size_t len, unsigned int flags);
+int fuse_copy_file_range_finalize(struct bpf_fuse_args *fa, ssize_t *out,
+				  struct file *file_in, loff_t pos_in,
+				  struct file *file_out, loff_t pos_out,
+				  size_t len, unsigned int flags);
+
 int fuse_fsync_initialize_in(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
 			     struct file *file, loff_t start, loff_t end, int datasync);
 int fuse_fsync_initialize_out(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
-- 
2.37.3.998.g577e59143f-goog

