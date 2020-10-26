Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D969F298D25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 13:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775590AbgJZMve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 08:51:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43567 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775581AbgJZMvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:51:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so12356713wrp.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8U6Qxx953w4L4tpJflBCmGVShrqbgz4wqR0nsj2i66M=;
        b=k7bQnsf63vkCKsp8Rvxr7QOrch0TfaeXCi6nD1OZg5KP7PnOCGqEYtVxrvjHPIJECi
         ikDfclmimdvLua7YBaaUzumilE+yGMsAKKo99Zbi33Y4OQoWQZS3BnEcMXHE1S+yIUKy
         tAbfSzQlJfUVBtiehjICl3umaBVwuQ89Pb/D3wfWOrDWi/C0plwRi9n7ot4fnnUH2qi4
         hbzZk0VJ+KsbnquuJijziGPftFUsY2gIJnzzvPOL6/lTiatBoEL1+wZfsRfDtIMZd6JO
         8dSM3ET/8MNL2HSvDgQFZ66I31+HGAH0oAkb0fb3nEps9/8mbKcZzde4dvmKYRVUd1et
         wlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8U6Qxx953w4L4tpJflBCmGVShrqbgz4wqR0nsj2i66M=;
        b=mbXHlloFClPuslMtBbskJw8RUIKDpTczCeG5AZA2IgUXAVsWMg7PZ3MXJf0HLojiMe
         cus+fqfd3edizyK6Yzm1l8GzLPLvZaIyvxXzeDdMQrED+m5NQRXdj7BkVh0RB98J8Ask
         S9f8dbb4rcKhDGryQ25cABelu154w2MrFeLtR87lVI56JxBohlSUXMToQTv6g60OdkDM
         TThpPSRIj8zIbSNWSxWqqYceaCnlzQdP52Ya+UWi/DjiDNwUoBkSo3cLWCcUDixgXajs
         hTMEqgkFKqOq4r6uCa5rrM27XU3HzyxIGjBpCn5XVCuUtIt5/Tcnqz8oelx+NqqC1P4p
         2x4A==
X-Gm-Message-State: AOAM532mEJdp2JKInKTnOGKuATXLhZ7qpWVRWPCRn6PwrBubl/LWUh7+
        YsNg/nKJXQloV9wq3K+9/eC9KQ==
X-Google-Smtp-Source: ABdhPJxjAqwKYi0Nh7e0kUODbADs1aQzhY1OUhWjvVLG7utC+bT1UdOvnc/p69OAAc0DjO1EJYo2QQ==
X-Received: by 2002:adf:ef06:: with SMTP id e6mr17579382wro.397.1603716688727;
        Mon, 26 Oct 2020 05:51:28 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id r1sm24423262wro.18.2020.10.26.05.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:51:28 -0700 (PDT)
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
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V10 2/5] fuse: Passthrough initialization and release
Date:   Mon, 26 Oct 2020 12:50:13 +0000
Message-Id: <20201026125016.1905945-3-balsini@android.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201026125016.1905945-1-balsini@android.com>
References: <20201026125016.1905945-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the FUSE passthrough ioctl() that associates the lower
(passthrough) file system file with the fuse_file.

The file descriptor passed to the ioctl() by the FUSE daemon is used to
access the relative file pointer, that will be copied to the fuse_file data
structure to consolidate the link between the FUSE and lower file system.

To enable the passthrough mode, userspace triggers the
FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl() and, if the call succeeds,
receives back an identifier that will be used at open/create response
time in the fuse_open_out field to associate the FUSE file to the lower
file system file.
The value returned by the ioctl() to userspace can be:
- > 0: success, the identifier can be used as part of an open/create
  reply.
- < 0: an error occurred.
The value 0 has been left unused for backward compatibility: the
fuse_open_out field that is used to pass the passthrough_fh back to the
kernel uses the same bits that were previously as struct padding,
zero-initialized in the common libfuse implementation. Removing the 0
value fixes the ambiguity between the case in which 0 corresponds to a
real passthrough_fh or a missing implementation, simplifying the
userspace implementation.

For the passthrough mode to be successfully activated, the lower file
system file must implement both read_ and write_iter file operations.
This extra check avoids special pseudo files to be targeted for this
feature.
Passthrough comes with another limitation: no further file system stacking
is allowed for those FUSE file systems using passthrough.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/inode.c       |  5 +++
 fs/fuse/passthrough.c | 80 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6738dd5ff5d2..1e94c54d1455 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1034,6 +1034,11 @@ EXPORT_SYMBOL_GPL(fuse_send_init);
 
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
index 594060c654f8..a135c955cc33 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -3,19 +3,95 @@
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
+		return -EBADF;
+	}
+
+	passthrough = kmalloc(sizeof(struct fuse_passthrough), GFP_KERNEL);
+	if (!passthrough)
+		return -ENOMEM;
+
+	passthrough->filp = passthrough_filp;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&fc->passthrough_req_lock);
+	res = idr_alloc(&fc->passthrough_req, passthrough, 1, 0, GFP_ATOMIC);
+	spin_unlock(&fc->passthrough_req_lock);
+	idr_preload_end();
+	if (res <= 0) {
+		fuse_passthrough_release(passthrough);
+		kfree(passthrough);
+	}
+
+	return res;
 }
 
 int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
 			   struct fuse_open_out *openarg)
 {
-	return -EINVAL;
+	struct inode *passthrough_inode;
+	struct super_block *passthrough_sb;
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
+	passthrough_inode = file_inode(passthrough->filp);
+	passthrough_sb = passthrough_inode->i_sb;
+	if (passthrough_sb->s_stack_depth >= FILESYSTEM_MAX_STACK_DEPTH) {
+		pr_err("FUSE: fs stacking depth exceeded for passthrough\n");
+		fuse_passthrough_release(passthrough);
+		kfree(passthrough);
+		return -EINVAL;
+	}
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
2.29.0.rc1.297.gfa9743e501-goog

