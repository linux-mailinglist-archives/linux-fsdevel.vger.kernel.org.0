Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D5E7097D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 14:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjESM6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjESM6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 08:58:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EB41726
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3078aa0b152so2138383f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684501038; x=1687093038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMWT+RpHQCoujOgf7xDkLajJi5Hjlt9yeUnva+XoCC0=;
        b=rW2Q9P+Srf9e1s09J6M1QoJIMp2Tq1MEoi7NYqAVwWcf4q1Y3rAUatsxLm5Pl9bk+5
         NYxGPoNz2xWx3060PeaLxvEr9WMiGl7z1dzIvRBOSBIjKP16rnRLsCFT816RpPTAEQHr
         UNcPDyT6AVgGjw7xBeirzRPj0AoGp1NQSY907jkYTJ0VDZS/2OPVYU+U69jLDZDdZeyC
         XovLtw3de7Y99GOZAHWSaekCCKQ7hQILse9OzWhDHTN/Fency4b/maI3mz9M8usQh3Lz
         +9vtPMhonjlEj1NKzqyo2/YKrUzSJayi7uM66gMVN8m/JFTT8M4W0NP9X6g0fZmkKhdc
         9O6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684501038; x=1687093038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMWT+RpHQCoujOgf7xDkLajJi5Hjlt9yeUnva+XoCC0=;
        b=P0e/gXAPiDZM0BMvazz3dgmhOrwcL6oaAe9T2PB4hM+xB1YuUBcpNdIQr0o7pqryX8
         ECVQjOF/NcKgpIddG3d/RcYP86FL5Dv9oaBl3ftaUzSIUBgns55gJvhePJeBW6vNrDEi
         9RUrVAqYNtJjcsg2EL6JTBYGOmOJLCZl0II414Zw7aAJgvwq46FgpKVQgSsj9wz+Jm80
         BehpRWkiBk6oD3fRkSt/Z4K7xSCaKtapLgl2ySnuuL8FYcZ9WkgxIcjAl6wde87iD/ya
         SrOUFRnyavyNiS+wrRl3lgQ0b5RYL0Gazc77J3U7uO9BdNLKFyDQbqJ4z4Ch8j9eyqJ5
         s5ng==
X-Gm-Message-State: AC+VfDwjUt2a/LJGzRIprhyR/WxXXxYZ6xRZXy8saUnNYJQ+7VxKqyGR
        XjdbSjrnaXwEceAWKCskdWE=
X-Google-Smtp-Source: ACHHUZ6tPaURxH/zd5P2HeoISLN4oqXLNFUC+NI7AayIKQorYF+3dzWtQM+UlEAHQMv+4OVvxYsA+Q==
X-Received: by 2002:a5d:43cb:0:b0:306:3731:f73b with SMTP id v11-20020a5d43cb000000b003063731f73bmr1677182wrr.43.1684501038357;
        Fri, 19 May 2023 05:57:18 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b0030630120e56sm5250937wrd.57.2023.05.19.05.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:57:18 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 04/10] fuse: Introduce synchronous read and write for passthrough
Date:   Fri, 19 May 2023 15:56:59 +0300
Message-Id: <20230519125705.598234-5-amir73il@gmail.com>
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

All the read and write operations performed on fuse_files which have the
passthrough feature enabled are forwarded to the associated backing file
via VFS.

Sending the request directly to the backing file avoids the userspace
round-trip that, because of possible context switches and additional
operations might reduce the overall performance, especially in those
cases where caching doesn't help, for example in reads at random offsets.

Verifying if a fuse_file has a backing file associated with it
can be done by checking the validity of its passthrough_filp pointer.
This pointer is not NULL only if passthrough has been successfully
enabled via the appropriate ioctl().

When a read/write operation is requested for a FUSE file with passthrough
enabled, a new equivalent VFS request is generated, which instead targets
the backing file.

The VFS layer performs additional checks that allow for safer operations
but may cause the operation to fail if the process accessing the FUSE
file does not have access to the backing file.

This change only implements synchronous requests in passthrough,
returning an error in the case of asynchronous operations, yet covering
the majority of the use cases.

Signed-off-by: Alessio Balsini <balsini@android.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c        |  8 ++++++--
 fs/fuse/fuse_i.h      |  3 +++
 fs/fuse/passthrough.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 96a46a5aa892..24d37681ddcd 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1682,7 +1682,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (ff->passthrough)
+		return fuse_passthrough_read_iter(iocb, to);
+	else if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_read_iter(iocb, to);
 	else
 		return fuse_direct_read_iter(iocb, to);
@@ -1700,7 +1702,9 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (ff->passthrough)
+		return fuse_passthrough_write_iter(iocb, from);
+	else if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_write_iter(iocb, from);
 	else
 		return fuse_direct_write_iter(iocb, from);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9ad1cc37a5c4..ff09fcd840df 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1352,4 +1352,7 @@ int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
 void fuse_passthrough_put(struct fuse_passthrough *passthrough);
 void fuse_passthrough_free(struct fuse_passthrough *passthrough);
 
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to);
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 8d090ae252f2..9d81f3982c96 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -4,6 +4,53 @@
 
 #include <linux/file.h>
 #include <linux/idr.h>
+#include <linux/uio.h>
+
+#define FUSE_IOCB_MASK                                                  \
+	(IOCB_APPEND | IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
+
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
+				   struct iov_iter *iter)
+{
+	struct file *fuse_filp = iocb_fuse->ki_filp;
+	struct fuse_file *ff = fuse_filp->private_data;
+	struct file *passthrough_filp = ff->passthrough->filp;
+	ssize_t ret;
+	rwf_t rwf;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	rwf = iocb_to_rw_flags(iocb_fuse->ki_flags, FUSE_IOCB_MASK);
+	ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos, rwf);
+
+	return ret;
+}
+
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
+				    struct iov_iter *iter)
+{
+	struct file *fuse_filp = iocb_fuse->ki_filp;
+	struct fuse_file *ff = fuse_filp->private_data;
+	struct inode *fuse_inode = file_inode(fuse_filp);
+	struct file *passthrough_filp = ff->passthrough->filp;
+	ssize_t ret;
+	rwf_t rwf;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	inode_lock(fuse_inode);
+
+	file_start_write(passthrough_filp);
+	rwf = iocb_to_rw_flags(iocb_fuse->ki_flags, FUSE_IOCB_MASK);
+	ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos, rwf);
+	file_end_write(passthrough_filp);
+
+	inode_unlock(fuse_inode);
+
+	return ret;
+}
 
 /*
  * Returns passthrough_fh id that can be passed with FOPEN_PASSTHROUGH
-- 
2.34.1

