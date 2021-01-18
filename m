Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C282FAA32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 20:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437220AbhARTaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 14:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437157AbhART3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:29:52 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F70DC061795
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 11:29:03 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m187so8324658wme.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 11:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PVG/me9P6YYLKoWQ4zvxfRU5IE2peiWMdE+UgdM0W3Y=;
        b=ncGoZP8Q0UcDMxfzLQbb+EgoM+BsZ+i/Od2KuWfAjqJhVjKQh5ncuvGmP3InJlEt0s
         kSwD0bxkaYvJs3X5Glv0F/vIe1wsaPDj4kjLjextdS9l4loohL8qqqkCPmldvMNZHX20
         Brako97W5WiVBVrdIK30VXDyUM+8FnR3u5MgCs/FAZ5K9Qb4STk/HyX7oo6st1fwfocB
         k9yCRFphdz19NYQPoWOSkXQ5Pjhq2hksmG8F158uR50cDeE1YqJrwkZF77uMrOgGQZhA
         O/L6OtptcaCDIaDjLnYyn3/D41f/rueJlHdwgZyYeMYKmTLaYkEU8426OBLRALAs62cr
         20OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PVG/me9P6YYLKoWQ4zvxfRU5IE2peiWMdE+UgdM0W3Y=;
        b=aViKjsbOZ1SUaf7nQxDKeejvOZmjHkN1KBRypY5XZp+pQE4SoEYocN0a3zp+JxDDEb
         j2B4Mbr4cRgdE7lRNFRv9FMcP/sxLLzKcuA1msy2wKJxhxqAXgt76mefqfY0oUwYSx27
         NXRBlW2ihVWmgEuFdpR463vNNn/3OBGXrAecuGSBKuQR0+MWZUIkKsz1w8Oq9yMFnsdy
         QqS/gdRlKKiK+V4Iu5oZbCnlml5+HKsb99AjR7T4ARaUuve9aqq0KcESU3qSl+kvuWs3
         JedAQF2AoiSjsRwA3KQQ0vCQ0RXQqGsC8fbYVqIVrHXVkneh9cueqZntT+kakzcLEP4T
         YDeg==
X-Gm-Message-State: AOAM5321U63oWK2g3++n3+ma8H8w9YEegFpk3CldULA43gGnN+DBrl0q
        LZyHmu/IuvkVxG4y4JtcBMnkvA==
X-Google-Smtp-Source: ABdhPJwZQpl3ibaeEItD/Krv9JaEX+IhYiHkWSROrAvCazNqnKgZz4qGa2BDpU9yptsVPmMToSEjPw==
X-Received: by 2002:a05:600c:19c7:: with SMTP id u7mr807715wmq.122.1610998141951;
        Mon, 18 Jan 2021 11:29:01 -0800 (PST)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:41d4:8c90:d38:455d])
        by smtp.gmail.com with ESMTPSA id h5sm33583299wrp.56.2021.01.18.11.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 11:29:01 -0800 (PST)
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND V11 5/7] fuse: Introduce synchronous read and write for passthrough
Date:   Mon, 18 Jan 2021 19:27:46 +0000
Message-Id: <20210118192748.584213-6-balsini@android.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210118192748.584213-1-balsini@android.com>
References: <20210118192748.584213-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All the read and write operations performed on fuse_files which have the
passthrough feature enabled are forwarded to the associated lower file
system file via VFS.

Sending the request directly to the lower file system avoids the userspace
round-trip that, because of possible context switches and additional
operations might reduce the overall performance, especially in those cases
where caching doesn't help, for example in reads at random offsets.

Verifying if a fuse_file has a lower file system file associated with can
be done by checking the validity of its passthrough_filp pointer. This
pointer is not NULL only if passthrough has been successfully enabled via
the appropriate ioctl().
When a read/write operation is requested for a FUSE file with passthrough
enabled, a new equivalent VFS request is generated, which instead targets
the lower file system file.
The VFS layer performs additional checks that allow for safer operations
but may cause the operation to fail if the process accessing the FUSE file
system does not have access to the lower file system.

This change only implements synchronous requests in passthrough, returning
an error in the case of asynchronous operations, yet covering the majority
of the use cases.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/file.c        |  8 ++++--
 fs/fuse/fuse_i.h      |  2 ++
 fs/fuse/passthrough.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 953f3034c375..cddada1e8bd9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1581,7 +1581,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (ff->passthrough.filp)
+		return fuse_passthrough_read_iter(iocb, to);
+	else if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_read_iter(iocb, to);
 	else
 		return fuse_direct_read_iter(iocb, to);
@@ -1599,7 +1601,9 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (ff->passthrough.filp)
+		return fuse_passthrough_write_iter(iocb, from);
+	else if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_write_iter(iocb, from);
 	else
 		return fuse_direct_write_iter(iocb, from);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8d39f5304a11..c4730d893324 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1239,5 +1239,7 @@ int fuse_passthrough_open(struct fuse_dev *fud,
 int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
 			   struct fuse_open_out *openarg);
 void fuse_passthrough_release(struct fuse_passthrough *passthrough);
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to);
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index cf720ca14a45..8f6882a31a0b 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -4,6 +4,63 @@
 
 #include <linux/fuse.h>
 #include <linux/idr.h>
+#include <linux/uio.h>
+
+#define PASSTHROUGH_IOCB_MASK                                                  \
+	(IOCB_APPEND | IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
+
+static void fuse_copyattr(struct file *dst_file, struct file *src_file)
+{
+	struct inode *dst = file_inode(dst_file);
+	struct inode *src = file_inode(src_file);
+
+	i_size_write(dst, i_size_read(src));
+}
+
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
+				   struct iov_iter *iter)
+{
+	ssize_t ret;
+	struct file *fuse_filp = iocb_fuse->ki_filp;
+	struct fuse_file *ff = fuse_filp->private_data;
+	struct file *passthrough_filp = ff->passthrough.filp;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
+			    iocb_to_rw_flags(iocb_fuse->ki_flags,
+					     PASSTHROUGH_IOCB_MASK));
+
+	return ret;
+}
+
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
+				    struct iov_iter *iter)
+{
+	ssize_t ret;
+	struct file *fuse_filp = iocb_fuse->ki_filp;
+	struct fuse_file *ff = fuse_filp->private_data;
+	struct inode *fuse_inode = file_inode(fuse_filp);
+	struct file *passthrough_filp = ff->passthrough.filp;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	inode_lock(fuse_inode);
+
+	file_start_write(passthrough_filp);
+	ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos,
+			     iocb_to_rw_flags(iocb_fuse->ki_flags,
+					      PASSTHROUGH_IOCB_MASK));
+	file_end_write(passthrough_filp);
+	if (ret > 0)
+		fuse_copyattr(fuse_filp, passthrough_filp);
+
+	inode_unlock(fuse_inode);
+
+	return ret;
+}
 
 int fuse_passthrough_open(struct fuse_dev *fud,
 			  struct fuse_passthrough_out *pto)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

