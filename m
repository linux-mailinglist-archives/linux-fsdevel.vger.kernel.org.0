Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014185EB581
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiIZXT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiIZXTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085E1DCCF0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 189-20020a2516c6000000b006bbbcc3dd9bso3112264ybw.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=XIhmt29MnSHMOUbW5hWxk0PJQl3NxeeWjpzsriw+TZI=;
        b=o66d+GY2M6xQDpW8c+jjW5mRmO2/zo5TbEA83P3bE8MkORJDWa6zNbP1M+88MIdFNa
         zO3jdsiPWGt9de4+zcGtH7/P8z0vlOUcLdYgsvT3Oj7xbUuHnJhCp/95cyZ8/vl/6S6t
         HXl2chUbbyB9efN67IfnwzUSoJ+vnVuEtK9j/9sWbt89KM6Q14wcBacRrYlANMd+hJUj
         whypPugP0O0WEMAcDkhpy+2ZbiKV2tsMIPGhDOB5S3fdEbhb7aLl3OOCsPBqWamXYi4E
         mfICZEsdaG/ZMqdp1/oaclJqi+c7zldrdO/pPatkIq7IaQSM2f4hQAHKUKgzmMxwKePf
         M1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=XIhmt29MnSHMOUbW5hWxk0PJQl3NxeeWjpzsriw+TZI=;
        b=Ykzi/+sTy99EJOBuB7Qp9L3m4idPMdYHuepZdLE8tW2XeaoH7AokJjanpb1jBw81dq
         RhHIDzo8XG2H6VHWbhHLXrSWVIddaabbLFMBA8IjPUuMxpg28AQDc7PyM6okkF9nnUwl
         s2zoywsmj7rX4bDq0J0+N4tqFD7YlzfTbQosfB2XB0vTVF1Ho/r9MTED4DF4sj9XvJdR
         IwiCFDHo4Owvsros4YcomVpNwRTvVPZP/0t4o6IYqVqaQFghviyVeoL+N6XIIxdq1qam
         eVo+uphnQdk4d6magzYeaEeNHXjTNyTkR6ytEciEtU1ovFkeK4FS7VhPyYGOt42VaYS4
         MbQA==
X-Gm-Message-State: ACrzQf2gsNDbayt/fXzTDWuDWNudgpRGRoXYOMQR0vGfHLVuKKw7ahKB
        t3IQVkPh/uvucGBex9MCoqo1shmIYaU=
X-Google-Smtp-Source: AMsMyM72yYQI5nrA0MNBYDI6J1jX3hc41LxhbrmvGHzt69qbX3A9FfCw8w+KvIQtn1Hc99RXohw4XKiWJZ0=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a25:bb8d:0:b0:696:340c:a672 with SMTP id
 y13-20020a25bb8d000000b00696340ca672mr24097705ybg.332.1664234338780; Mon, 26
 Sep 2022 16:18:58 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:07 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-12-drosen@google.com>
Subject: [PATCH 11/26] fuse-bpf: Add lseek support
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
 fs/fuse/backing.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c    |  8 +++++
 fs/fuse/fuse_i.h  | 15 +++++++++-
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index fa8805e24061..97e92c633cfd 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -77,6 +77,80 @@ int parse_fuse_entry_bpf(struct fuse_entry_bpf *feb)
 	return err;
 }
 
+int fuse_lseek_initialize_in(struct bpf_fuse_args *fa, struct fuse_lseek_io *flio,
+			     struct file *file, loff_t offset, int whence)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	flio->fli = (struct fuse_lseek_in) {
+		.fh = fuse_file->fh,
+		.offset = offset,
+		.whence = whence,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_node_id(file->f_inode),
+		.opcode = FUSE_LSEEK,
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(flio->fli),
+		.in_args[0].value = &flio->fli,
+	};
+
+	return 0;
+}
+
+int fuse_lseek_initialize_out(struct bpf_fuse_args *fa, struct fuse_lseek_io *flio,
+			      struct file *file, loff_t offset, int whence)
+{
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(flio->flo);
+	fa->out_args[0].value = &flio->flo;
+
+	return 0;
+}
+
+int fuse_lseek_backing(struct bpf_fuse_args *fa, loff_t *out,
+		       struct file *file, loff_t offset, int whence)
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
+int fuse_lseek_finalize(struct bpf_fuse_args *fa, loff_t *out,
+			struct file *file, loff_t offset, int whence)
+{
+	struct fuse_lseek_out *flo = fa->out_args[0].value;
+
+	if (!fa->error_in)
+		file->f_pos = flo->offset;
+	*out = flo->offset;
+	return 0;
+}
+
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	int ret;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 138890eae07c..dd4485261cc7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2703,6 +2703,14 @@ static loff_t fuse_file_llseek(struct file *file, loff_t offset, int whence)
 {
 	loff_t retval;
 	struct inode *inode = file_inode(file);
+#ifdef CONFIG_FUSE_BPF
+	if (fuse_bpf_backing(inode, struct fuse_lseek_io, retval,
+			       fuse_lseek_initialize_in, fuse_lseek_initialize_out,
+			       fuse_lseek_backing,
+			       fuse_lseek_finalize,
+			       file, offset, whence))
+		return retval;
+#endif
 
 	switch (whence) {
 	case SEEK_SET:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a9653f71c145..fc3e8adf0422 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1404,9 +1404,22 @@ struct fuse_entry_bpf {
 	struct bpf_prog *bpf;
 };
 
-
 int parse_fuse_entry_bpf(struct fuse_entry_bpf *feb);
 
+struct fuse_lseek_io {
+	struct fuse_lseek_in fli;
+	struct fuse_lseek_out flo;
+};
+
+int fuse_lseek_initialize_in(struct bpf_fuse_args *fa, struct fuse_lseek_io *fli,
+			     struct file *file, loff_t offset, int whence);
+int fuse_lseek_initialize_out(struct bpf_fuse_args *fa, struct fuse_lseek_io *fli,
+			      struct file *file, loff_t offset, int whence);
+int fuse_lseek_backing(struct bpf_fuse_args *fa, loff_t *out, struct file *file,
+		       loff_t offset, int whence);
+int fuse_lseek_finalize(struct bpf_fuse_args *fa, loff_t *out, struct file *file,
+			loff_t offset, int whence);
+
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma);
 
 struct fuse_lookup_io {
-- 
2.37.3.998.g577e59143f-goog

