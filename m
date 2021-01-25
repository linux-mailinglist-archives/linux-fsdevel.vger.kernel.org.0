Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804083034AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbhAZFZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730253AbhAYPmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:42:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6410BC061BD1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 07:31:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a9so13051856wrt.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 07:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czRDsr9ZveGlA8Lh9Z/2Mcsvya5PJVoy03eWuT8s21A=;
        b=Nc7odzg9UfBt9Cztyn7oJXUuGuEaPINkh4HcF8tCwL6QydMJTw2bmDU18RP2eOhhfw
         ePgjf3pmTG4MpLsKkntdB/KkguZ5V8AEK3F/hVhEzxkD+9MYckgjKpbPyGGTXU50PV4c
         E93p427a15/+JjVI3J5lppYDaKZhg9X2eJ9b3wqC2WIMcsUopruusKcBT3rzagEZ/8dd
         JF14cHgqdQMwp3QCnGmkWzRC/tVyfIdi3pd5yycPwcnWNwOASenr21U2u8o8+Q729+hf
         zGYb22YwmOOafGvfRwM882pHOVBY6+XER5CMGcBz75hLYQ8BhB5FKmyOTFzH8iuHgQi7
         4dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czRDsr9ZveGlA8Lh9Z/2Mcsvya5PJVoy03eWuT8s21A=;
        b=tZk5bVaV+GDYTKO6yP48RUCXzCi/xJ3n3oBYP2OL9KbvDqFQs4JxggH6rF5uZEPNWc
         pWQAzs0FAtDRIz2axUxn5EUnrm7Hb7PesMknnnyK/tmoQBWmGYEVXK/ilwH35k+iPgxT
         rNQqWOUPKQvpu+NB58anWpcwql/vFUimWG46NK7el/Mg86B2H/2CWasmrVDb6DBG3U7L
         qwPvfbh66jT08qbbZZOCy5VImlJ2iljZQG96GrGUcuro8u8WdQO7rozQnl6RGmroVyFa
         pwj5bUly/65swfBxAHlAbM4QM4uwjyLjvTFsGfPsAGsGtXDT8QW7GYSN3ETdvUaNmEby
         iUPQ==
X-Gm-Message-State: AOAM5316W5c40+Jd0Mm5ro/pgTxWidJHxKtzL171kPHyJQfKT+C48EbZ
        Y2DocgHDD+ZqKmlbrHF4ml/jWw==
X-Google-Smtp-Source: ABdhPJxRalGgtsXNqfUpShWnl29ttfx4tBQRgzfNHdPdlZQBfdjgX6kBkwceyp+jLPxO4iLmohi6HQ==
X-Received: by 2002:adf:b78d:: with SMTP id s13mr1611637wre.344.1611588672186;
        Mon, 25 Jan 2021 07:31:12 -0800 (PST)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:4cd4:5994:40fe:253d])
        by smtp.gmail.com with ESMTPSA id o14sm22611965wri.48.2021.01.25.07.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:31:11 -0800 (PST)
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
Subject: [PATCH RESEND V12 5/8] fuse: Introduce synchronous read and write for passthrough
Date:   Mon, 25 Jan 2021 15:30:54 +0000
Message-Id: <20210125153057.3623715-6-balsini@android.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210125153057.3623715-1-balsini@android.com>
References: <20210125153057.3623715-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All the read and write operations performed on fuse_files which have the
passthrough feature enabled are forwarded to the associated lower file
system file via VFS.

Sending the request directly to the lower file system avoids the
userspace round-trip that, because of possible context switches and
additional operations might reduce the overall performance, especially
in those cases where caching doesn't help, for example in reads at
random offsets.

Verifying if a fuse_file has a lower file system file associated with
can be done by checking the validity of its passthrough_filp pointer.
This pointer is not NULL only if passthrough has been successfully
enabled via the appropriate ioctl().
When a read/write operation is requested for a FUSE file with
passthrough enabled, a new equivalent VFS request is generated, which
instead targets the lower file system file.
The VFS layer performs additional checks that allow for safer operations
but may cause the operation to fail if the process accessing the FUSE
file system does not have access to the lower file system.

This change only implements synchronous requests in passthrough,
returning an error in the case of asynchronous operations, yet covering
the majority of the use cases.

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
index cf993e83803e..d949ca07a83b 100644
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
2.30.0.280.ga3ce27912f-goog

