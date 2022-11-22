Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D8D633304
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 03:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiKVCR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 21:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiKVCRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:17:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38488E675A
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a5-20020a25af05000000b006e450a5e507so12710822ybh.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/H+L2cRtspRUVOzDKfhmH9r0h1z7XV5y5jiKoA2w7Jo=;
        b=GkbYhSRuG3pnC12YeGswQtbl8Qkm/FgEIiaZy5lmsxd6nnIJGVSGgoCrt6HlEko6Ki
         C6yr+mtFUhPtVnoaJg/ByALo10sNnWpcBCubg/D8R0ssNLL3XjyN46mJHVC5Um8b16CU
         orSmyP3WSpCgYDTcMIiZcxb2R80zdMKhHpr45RrSwbcJgu+a3jL9Xhb8MiJaYe2teBth
         L8HZN6e2FJlFs1cfNF808/GPl/xs2NrIzv6kCLjM5O/xSQgt9ou3kcdxWqlecQ+QDqfO
         utLWnK4t1OVh8O7dFmQ1g64uSIWNxLOGjQxuWWbknOLE404qWDNW8Qs3bG4NsLYvtmbe
         jw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/H+L2cRtspRUVOzDKfhmH9r0h1z7XV5y5jiKoA2w7Jo=;
        b=RxoFNwENzX4VDMqg0oABk7YMJT+fEjMbBUrJXLNoOcl+umhEd1h4PGxHQXYmbcX9Kx
         9Qieq+/khuFupkjxc6k4y04gaprR0j2eWN8YlRuE/xbqJ+U/RrRVJL5513rnKtvTZt6m
         /dGEbgLrJBItOd9t3hMIDFNsHuruAJBm6Joo3jxMgiMD93EvkrmpzybVUodVPaF3nmQ9
         GOQ15AkxjSho1xoeCGcWIFyzrX2YlJtkvMPy4tc8CzcQOpje6YN5n82tvDyI89HriCoJ
         JKZc9cX4RTvlpEhAZxiEjs1ZrfcxMYUm30SGuIoc5EZrZ+5RMMl5RrDFxdORv1D7OPTs
         VsNw==
X-Gm-Message-State: ANoB5pkcs0ZygiCF7HdEQsgCrCrOCXm1pkZphhjrLYqvgIH1qgNxSGUX
        N5plU0HDE6f1+wWg7V3lSC76lfGIZRA=
X-Google-Smtp-Source: AA0mqf6T81Q7kb/8MBkNfWtjc8pLPbKvhJyO5HsbQTEwR7WiW1wy5USpYOyxaJPL2wysP5NucahLhCtfZFU=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a05:690c:845:b0:3a5:36e5:94eb with SMTP id
 bz5-20020a05690c084500b003a536e594ebmr5266716ywb.39.1669083377322; Mon, 21
 Nov 2022 18:16:17 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:25 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-11-drosen@google.com>
Subject: [RFC PATCH v2 10/21] fuse-bpf: Add support for fallocate
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
 fs/fuse/backing.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c    |  3 +++
 fs/fuse/fuse_i.h  |  6 +++++
 3 files changed, 67 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 76f48872ed35..51aadeb1b7dc 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -330,6 +330,64 @@ ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
 	return ret;
 }
 
+static int fuse_file_fallocate_initialize_in(struct fuse_args *fa,
+					     struct fuse_fallocate_in *ffi,
+					     struct file *file, int mode, loff_t offset, loff_t length)
+{
+	struct fuse_file *ff = file->private_data;
+
+	*ffi = (struct fuse_fallocate_in) {
+		.fh = ff->fh,
+		.offset = offset,
+		.length = length,
+		.mode = mode,
+	};
+
+	*fa = (struct fuse_args) {
+		.opcode = FUSE_FALLOCATE,
+		.nodeid = ff->nodeid,
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*ffi),
+		.in_args[0].value = ffi,
+	};
+
+	return 0;
+}
+
+static int fuse_file_fallocate_initialize_out(struct fuse_args *fa,
+					      struct fuse_fallocate_in *ffi,
+					      struct file *file, int mode, loff_t offset, loff_t length)
+{
+	return 0;
+}
+
+static int fuse_file_fallocate_backing(struct fuse_args *fa, int *out,
+				       struct file *file, int mode, loff_t offset, loff_t length)
+{
+	const struct fuse_fallocate_in *ffi = fa->in_args[0].value;
+	struct fuse_file *ff = file->private_data;
+
+	*out = vfs_fallocate(ff->backing_file, ffi->mode, ffi->offset,
+			     ffi->length);
+	return 0;
+}
+
+static int fuse_file_fallocate_finalize(struct fuse_args *fa, int *out,
+					struct file *file, int mode, loff_t offset, loff_t length)
+{
+	return 0;
+}
+
+int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length)
+{
+	return fuse_bpf_backing(inode, struct fuse_fallocate_in, out,
+				fuse_file_fallocate_initialize_in,
+				fuse_file_fallocate_initialize_out,
+				fuse_file_fallocate_backing,
+				fuse_file_fallocate_finalize,
+				file, mode, offset, length);
+}
+
 /*******************************************************************************
  * Directory operations after here                                             *
  ******************************************************************************/
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e90b3e2d5452..ab3cd43556e0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2997,6 +2997,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 
 	bool block_faults = FUSE_IS_DAX(inode) && lock_inode;
 
+	if (fuse_bpf_file_fallocate(&err, inode, file, mode, offset, length))
+		return err;
+
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
 		return -EOPNOTSUPP;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 108c2ea15a49..4351dbc7f10d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1401,6 +1401,7 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
 #ifdef CONFIG_FUSE_BPF
 
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
+int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
@@ -1411,6 +1412,11 @@ static inline int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *
 	return 0;
 }
 
+static inline int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags)
 {
 	return 0;
-- 
2.38.1.584.g0f3c55d4c2-goog

