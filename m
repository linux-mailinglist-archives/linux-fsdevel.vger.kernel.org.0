Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A546E56BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjDRBmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjDRBl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:41:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD91A6A6D
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c17fb245dso307204137b3.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782078; x=1684374078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oN6x+PcjBowjEB90+rsteKN+eOkqOSAMj6ggqH7i4oE=;
        b=e2l+365Y5NfwgrmJ3glTREcW5dUMa28BQ3rkaEXIxzCaUVeE1IhaW2auQ6TAoZSlTV
         2DPfi5gIQFGcRKYkma2DV8pvrKv+CMBRJ5PqPI/sdCdJlujipWSi8TX5fpC7CIATr/wd
         IZ08/Y5ullb70ZOKJIK0Fa3l1w37fzqtYaUA2LBOQ+U08RbTKlpgXJi+kOkZuc5emqyT
         txsRKHpNndZBshfMylH2G+PKKT4M75pZSQdvHa69EiYZG+SqYwtca9kBbOLbesWQNZOV
         ScLqr6LEl57hIDUX6HFB91pq60LCptprJlfycy0AaC9T8kF5M0PJh2968Q/Fdg6j+/Y2
         nZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782078; x=1684374078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oN6x+PcjBowjEB90+rsteKN+eOkqOSAMj6ggqH7i4oE=;
        b=P+IjA7+ZslA9vzR17s4LkI64/8/9DlYxhWDulZ37/n9ckAKrhYe21LSxigTB5TPdWK
         DBg6wuPBEHcyZDZ6GDexXhbRt+AjjYGpuaA9z1tAKG68ooyhFiAbgVmvxoKsVb5+YoJ1
         qr+XOhtM+9iUYaA27eUO+4tAc7VgK98qLWTglvqruI20ZwF7PmJqo5ZvqbF6BCTwNEpt
         2aAtri//iHMAQNAIgb54uxtF9/Tb/O18iZAtI8JE0ePae/7RpEjauGKct35GzEISyfiA
         3joILdRltUc+Jw6ee4UNdjxN7SrJ+RmPMgFyiu8B6OVm13a/lxMrkU4cj71rT0RIU8iO
         366A==
X-Gm-Message-State: AAQBX9d0sRbB/LY656snhIGpGmk0GGvsgDnDqjvOjEU8R+eReRIOsITA
        WVdaLEu22AJ654qX8gxtwzMkuhGFukw=
X-Google-Smtp-Source: AKy350ZlkcIB5L39o8Rx8chg+be3fQChvnEEvP0sguYtyhqx+uHhdIzeUdU455ATM/2zMsWmD3vY1g4K4MY=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:74d4:0:b0:b8e:cb88:1b8a with SMTP id
 p203-20020a2574d4000000b00b8ecb881b8amr10919222ybc.8.1681782078105; Mon, 17
 Apr 2023 18:41:18 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:12 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-13-drosen@google.com>
Subject: [RFC PATCH v3 12/37] fuse-bpf: Partially add mapping support
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

This adds a backing implementation for mapping, but is not currently
hooked into the infrastructure that will call the bpf programs.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 37 +++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c    |  6 ++++++
 fs/fuse/fuse_i.h  |  4 +++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index e42622584037..930aa370e376 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -207,6 +207,43 @@ static void fuse_stat_to_attr(struct fuse_conn *fc, struct inode *inode,
 	attr->blksize = 1 << blkbits;
 }
 
+ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int ret;
+	struct fuse_file *ff = file->private_data;
+	struct inode *fuse_inode = file_inode(file);
+	struct file *backing_file = ff->backing_file;
+	struct inode *backing_inode = file_inode(backing_file);
+
+	if (!backing_file->f_op->mmap)
+		return -ENODEV;
+
+	if (WARN_ON(file != vma->vm_file))
+		return -EIO;
+
+	vma->vm_file = get_file(backing_file);
+
+	ret = call_mmap(vma->vm_file, vma);
+
+	if (ret)
+		fput(backing_file);
+	else
+		fput(file);
+
+	if (file->f_flags & O_NOATIME)
+		return ret;
+
+	if ((!timespec64_equal(&fuse_inode->i_mtime, &backing_inode->i_mtime) ||
+	     !timespec64_equal(&fuse_inode->i_ctime,
+			       &backing_inode->i_ctime))) {
+		fuse_inode->i_mtime = backing_inode->i_mtime;
+		fuse_inode->i_ctime = backing_inode->i_ctime;
+	}
+	touch_atime(&file->f_path);
+
+	return ret;
+}
+
 /*******************************************************************************
  * Directory operations after here                                             *
  ******************************************************************************/
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 25fb49f0a9f7..865167a80d35 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2527,6 +2527,12 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (FUSE_IS_DAX(file_inode(file)))
 		return fuse_dax_mmap(file, vma);
 
+#ifdef CONFIG_FUSE_BPF
+	/* TODO - this is simply passthrough, not a proper BPF filter */
+	if (ff->backing_file)
+		return fuse_backing_mmap(file, vma);
+#endif
+
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
 		/* Can't provide the coherency needed for MAP_SHARED */
 		if (vma->vm_flags & VM_MAYSHARE)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index cb166168f9c2..5eb357f482dc 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1422,7 +1422,9 @@ static inline int fuse_bpf_access(int *out, struct inode *inode, int mask)
 
 #endif // CONFIG_FUSE_BPF
 
-int fuse_handle_backing(struct fuse_bpf_entry *feb, struct path *backing_path);
+ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma);
+
+int fuse_handle_backing(struct fuse_bpf_entry *fbe, struct path *backing_path);
 
 int fuse_revalidate_backing(struct dentry *entry, unsigned int flags);
 
-- 
2.40.0.634.g4ca3ef3211-goog

