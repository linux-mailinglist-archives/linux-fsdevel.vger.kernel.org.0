Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4CC2FAA71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 20:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437405AbhARTox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 14:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394010AbhARTaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:30:12 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E782C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 11:29:00 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v184so10503370wma.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 11:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A6Oskm85exd2P1bwvPrwmP4Mb1gHUWUZWFETbfW9HMA=;
        b=bYdZpB8MG5JNLUXwHli/yKfiXxAcvN2Q7jYSHPqaO03XhUqY+wQ2VBa4yE/j0O/Jy7
         iyFJCLWrpxyBUmSp2txbwaPNh08vHqbtM9tqkrD7m1raYNkB6p6LKd96AB3qe6XaJR0p
         n2qWBilTCVYafTszKNxh5HH7ao2TVaVVyhddGBkkWj65sMULUpHOkZYHI/wIaWENpkpb
         OKRfxD8dC194oLXUTh7y54r7M3PjP6LGt/l6ZL0NGqQxXGyFqriwGukmMeiE12ZFHIpd
         SFC1QqOupppG5AoSRKw9QVbgTv+2MFkeQCJ9msLG9cXpsidBlvvQRvHmuwZy6PDRe/x8
         /o6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6Oskm85exd2P1bwvPrwmP4Mb1gHUWUZWFETbfW9HMA=;
        b=Nk04p2gza52ZOSuAISxozbmdbQDYBUF5gGu/QKSIk9lmIXfSOwLNKqElNaIkxsEB/i
         7wgg4tq3sxMBiZS+6hm35aOvkdZZE042ogCEW5Bj779NGB4S3LpBpy6o0g2qnwMjhrOJ
         PVWu//Q6mARxGpxQ7OjF2HcByUkXJL5DATuDKhcQdiFj7QTAp9nyjAL3H7NKdxcAO0iF
         bxiABW+DrgSOdUYrKG3ZMxnXuksVmwZoXPGw1OySUQ7bdxa2fD56bPqR3wbi7JSD5XVv
         NVLAf94FQ2s3ET10ctGxY4kfAAc7C34IBVyQjudRc52LbcE7RN8weCWkwfWaucxtChyW
         9gzA==
X-Gm-Message-State: AOAM531T3mGiQcFEExK9JUs3hqgMjsE0pSP0/A4acXdhKKDTlroeqcfx
        plyIXZbBdEUKfqc7uAyghzHd3A==
X-Google-Smtp-Source: ABdhPJwykU5C5NsSJVH/bBRE21GNjF9wkxm+2nwiXIlZVhogKq9OBTYoDvXZDcb8VgOPPrVbZbBvjw==
X-Received: by 2002:a1c:1f86:: with SMTP id f128mr811746wmf.174.1610998138919;
        Mon, 18 Jan 2021 11:28:58 -0800 (PST)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:41d4:8c90:d38:455d])
        by smtp.gmail.com with ESMTPSA id h5sm33583299wrp.56.2021.01.18.11.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 11:28:58 -0800 (PST)
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
Subject: [PATCH RESEND V11 4/7] fuse: Passthrough initialization and release
Date:   Mon, 18 Jan 2021 19:27:45 +0000
Message-Id: <20210118192748.584213-5-balsini@android.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210118192748.584213-1-balsini@android.com>
References: <20210118192748.584213-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the FUSE passthrough ioctl() that associates the lower
(passthrough) file system file with the fuse_file.

The file descriptor passed to the ioctl() by the FUSE daemon is used to
access the relative file pointer, that will be copied to the fuse_file
data structure to consolidate the link between the FUSE and lower file
system.

To enable the passthrough mode, user space triggers the
FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl() and, if the call succeeds,
receives back an identifier that will be used at open/create response
time in the fuse_open_out field to associate the FUSE file to the lower
file system file.
The value returned by the ioctl() to user space can be:
- > 0: success, the identifier can be used as part of an open/create
  reply.
- < 0: an error occurred.
The value 0 has been left unused for backward compatibility: the
fuse_open_out field that is used to pass the passthrough_fh back to the
kernel uses the same bits that were previously as struct padding,
zero-initialized in the common libfuse implementation. Removing the 0
value fixes the ambiguity between the case in which 0 corresponds to a
real passthrough_fh or a missing implementation, simplifying the user
space implementation.

For the passthrough mode to be successfully activated, the lower file
system file must implement both read_iter and write_iter file
operations. This extra check avoids special pseudo files to be targeted
for this feature.
Passthrough comes with another limitation: if a FUSE file systems
enables passthrough, this feature is no more available to other FUSE
file systems stacked on top of it. This check is only performed when
FUSE passthrough is requested for a specific file and would simply
prevent the use of FUSE passthrough for that file, not limiting other
file operations.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/inode.c       |  5 +++
 fs/fuse/passthrough.c | 87 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d5c46eafb419..bc327789f25d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1133,6 +1133,11 @@ EXPORT_SYMBOL_GPL(fuse_send_init);
 
 static int free_fuse_passthrough(int id, void *p, void *data)
 {
+	struct fuse_passthrough *passthrough = (struct fuse_passthrough *)p;
+
+	fuse_passthrough_release(passthrough);
+	kfree(p);
+
 	return 0;
 }
 
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 594060c654f8..cf720ca14a45 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -3,19 +3,102 @@
 #include "fuse_i.h"
 
 #include <linux/fuse.h>
+#include <linux/idr.h>
 
 int fuse_passthrough_open(struct fuse_dev *fud,
 			  struct fuse_passthrough_out *pto)
 {
-	return -EINVAL;
+	int res;
+	struct file *passthrough_filp;
+	struct fuse_conn *fc = fud->fc;
+	struct inode *passthrough_inode;
+	struct super_block *passthrough_sb;
+	struct fuse_passthrough *passthrough;
+
+	if (!fc->passthrough)
+		return -EPERM;
+
+	/* This field is reserved for future implementation */
+	if (pto->len != 0)
+		return -EINVAL;
+
+	passthrough_filp = fget(pto->fd);
+	if (!passthrough_filp) {
+		pr_err("FUSE: invalid file descriptor for passthrough.\n");
+		return -EBADF;
+	}
+
+	if (!passthrough_filp->f_op->read_iter ||
+	    !passthrough_filp->f_op->write_iter) {
+		pr_err("FUSE: passthrough file misses file operations.\n");
+		res = -EBADF;
+		goto err_free_file;
+	}
+
+	passthrough_inode = file_inode(passthrough_filp);
+	passthrough_sb = passthrough_inode->i_sb;
+	if (passthrough_sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
+		pr_err("FUSE: fs stacking depth exceeded for passthrough\n");
+		res = -EINVAL;
+		goto err_free_file;
+	}
+
+	passthrough = kmalloc(sizeof(struct fuse_passthrough), GFP_KERNEL);
+	if (!passthrough) {
+		res = -ENOMEM;
+		goto err_free_file;
+	}
+
+	passthrough->filp = passthrough_filp;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&fc->passthrough_req_lock);
+	res = idr_alloc(&fc->passthrough_req, passthrough, 1, 0, GFP_ATOMIC);
+	spin_unlock(&fc->passthrough_req_lock);
+	idr_preload_end();
+
+	if (res > 0)
+		return res;
+
+	fuse_passthrough_release(passthrough);
+	kfree(passthrough);
+
+err_free_file:
+	fput(passthrough_filp);
+
+	return res;
 }
 
 int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
 			   struct fuse_open_out *openarg)
 {
-	return -EINVAL;
+	struct fuse_passthrough *passthrough;
+	int passthrough_fh = openarg->passthrough_fh;
+
+	if (!fc->passthrough)
+		return -EPERM;
+
+	/* Default case, passthrough is not requested */
+	if (passthrough_fh <= 0)
+		return -EINVAL;
+
+	spin_lock(&fc->passthrough_req_lock);
+	passthrough = idr_remove(&fc->passthrough_req, passthrough_fh);
+	spin_unlock(&fc->passthrough_req_lock);
+
+	if (!passthrough)
+		return -EINVAL;
+
+	ff->passthrough = *passthrough;
+	kfree(passthrough);
+
+	return 0;
 }
 
 void fuse_passthrough_release(struct fuse_passthrough *passthrough)
 {
+	if (passthrough->filp) {
+		fput(passthrough->filp);
+		passthrough->filp = NULL;
+	}
 }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

