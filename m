Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F737097D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 14:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjESM6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 08:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjESM6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 08:58:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F4C10E9
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so22178895e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684501042; x=1687093042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ3gWAvNGu9jH/8gT9PxXGnaj6D8w7EfQVaZKUffX4A=;
        b=BZTFNuP89vsIOk/TFT/zSdKQbdCo66sWfMZ2w3p0LFtq7akePHOI2yOMVoSE5CKi1c
         JKZg+ilvTbzJ+60dT6/1msiY0WaVD+w4ooi9HHZ4U5xW3DgnEX3yXkHN8y+yshJz/0vB
         cjWu+bV0+qBqL0xyw6rloDpenDdsRWrs7F3mDEcBNaCKXs3I3TEiGqsWlibhFGA2fZeG
         jDS44CJNShaol4QN9T86ztLHjhwxZkYltewbs0fY49eF8N0dWGqafDDW7LPgEq4gSWu1
         E5+wwDB/KyqV5DD9iVDSRSONkflX0Q1w1ApgalwoqpTzqozSCSTx1u816e/U1b/J7JmM
         3TJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684501042; x=1687093042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZ3gWAvNGu9jH/8gT9PxXGnaj6D8w7EfQVaZKUffX4A=;
        b=gPR47b9MD22EBj0bGHbmijXvB1pjr3MR97FwGVM0cUJbFCXXk0epvQvxBr0iEkaQ8h
         nX7Vv8bXaTeZvPmHhSaNvM5A5fLf4VmnNDQXEEh9BMr1L+DRu8I+wHGc9BZy30wv0nW0
         SDkbn8fWsMI7G9mSNEuAj7BxZQZWv/ibfPOl8erfEkFia+3bhSNRI7FIFjAqmbCPoYkb
         nFnNoqMJCnHGeexHGWWOs/djG6oFJFpH61B/Sl5HWxEMx9H9wiX6d/dS3IkrUAevZHTV
         BbnTrBI+Rtx0o1Lm7zUu/GzV5zmvpVa5xEO1uGxieGaWxrtBLpDTcyfqkRN5nR2RZm1g
         C8pw==
X-Gm-Message-State: AC+VfDxxzAuwSwNmle66WOiMQ35uTrp7L1XX5wrKF9K2A3N1NmJp4CqV
        VYSnDJayhAKUACr2yTFiQTTbN8fC5GE=
X-Google-Smtp-Source: ACHHUZ5/Leda5DnlzAgUM4CYWzPr/Sirk70iOc1OO93pHWOikZ90dJGyHAhRxmySn+uPAACn7BmqbA==
X-Received: by 2002:a7b:c396:0:b0:3f4:29c2:1cd0 with SMTP id s22-20020a7bc396000000b003f429c21cd0mr1380528wmj.25.1684501042584;
        Fri, 19 May 2023 05:57:22 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b0030630120e56sm5250937wrd.57.2023.05.19.05.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:57:22 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 07/10] fuse: Introduce passthrough for mmap
Date:   Fri, 19 May 2023 15:57:02 +0300
Message-Id: <20230519125705.598234-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519125705.598234-1-amir73il@gmail.com>
References: <20230519125705.598234-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enabling FUSE passthrough for mmap-ed operations not only affects
performance, but has also been shown as mandatory for the correct
functioning of FUSE passthrough.

yanwu noticed [1] that a FUSE file with passthrough enabled may suffer
data inconsistencies if the same file is also accessed with mmap.
What happens is that read/write operations are directly applied to the
backing file's page cache, while mmap-ed operations are affecting the
FUSE file's page cache.

Extend the FUSE passthrough implementation to also handle memory-mapped
FUSE file, to both fix the cache inconsistencies and extend the
passthrough performance benefits to mmap-ed operations.

[1] https://lore.kernel.org/lkml/20210119110654.11817-1-wu-yan@tcl.com/

Signed-off-by: Alessio Balsini <balsini@android.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c        |  3 +++
 fs/fuse/fuse_i.h      |  1 +
 fs/fuse/passthrough.c | 27 +++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 24d37681ddcd..80e20bae569f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2521,6 +2521,9 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (FUSE_IS_DAX(file_inode(file)))
 		return fuse_dax_mmap(file, vma);
 
+	if (ff->passthrough)
+		return fuse_passthrough_mmap(file, vma);
+
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
 		/* Can't provide the coherency needed for MAP_SHARED */
 		if (vma->vm_flags & VM_MAYSHARE)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 61a3968cfc8f..238a43349298 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1356,5 +1356,6 @@ void fuse_passthrough_free(struct fuse_passthrough *passthrough);
 
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from);
+ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 06c6926aa85a..10b370bcc423 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -129,6 +129,33 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 	return ret;
 }
 
+ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int ret;
+	const struct cred *old_cred;
+	struct fuse_file *ff = file->private_data;
+	struct file *passthrough_filp = ff->passthrough->filp;
+
+	if (!passthrough_filp->f_op->mmap)
+		return -ENODEV;
+
+	if (WARN_ON(file != vma->vm_file))
+		return -EIO;
+
+	vma->vm_file = get_file(passthrough_filp);
+
+	old_cred = override_creds(ff->passthrough->cred);
+	ret = call_mmap(vma->vm_file, vma);
+	revert_creds(old_cred);
+
+	if (ret)
+		fput(passthrough_filp);
+	else
+		fput(file);
+
+	return ret;
+}
+
 /*
  * Returns passthrough_fh id that can be passed with FOPEN_PASSTHROUGH
  * open response and needs to be released with fuse_passthrough_close().
-- 
2.34.1

