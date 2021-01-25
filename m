Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A56F3034AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbhAZFZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730252AbhAYPmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:42:31 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A25C0610D6
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 07:31:12 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y187so11474575wmd.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 07:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K33/kOxBcJ35u0ayW/ijJxNjK4mLraYNnDTliI6dnXg=;
        b=kEj9BGL5vLSacxvqiOxwxcXXj8ycWN/r3TCV1Hwysj38wWty0mJygofEQqWU26ui1M
         nSiKhu2j2W8JnvD8/P9Fecc8f6MmDioumRGUsVD1hlExvJ18kILVeqHFfiSrxVrXceUC
         EipXBOeNwHRtCdrckg8JGa2BqXsxzlX4awNOH25pPAbcE2zjU8E+9u12SERC+BBCWFkh
         DorvOEgbrys+KXkZ5Wm8YAqfPdg6tU76o0PRXGTCzJgC1lQbI0kVc9D5NO18BMN9oqPg
         U1VNlFw/T1jB79L7fD2O1y0zh5XwdnI7Zg8Hlf27ZtuOLoff0e0s6OWsM6D8AJpYwowe
         mJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K33/kOxBcJ35u0ayW/ijJxNjK4mLraYNnDTliI6dnXg=;
        b=lPVXUDoXjAcidhGG+gbWwJ+cQr01vs940XgzlpZS2EaCS1/gbb/JZenXb7B4g+bzYI
         1afEcW6Odd4Hn1Vu2z4dtBJbTjSxjyza6VnKSdc+LphrTVkp43yBiArzWkTREDwnnVBp
         2FuOhY6O7lFJsMHDTqp2wU1k1CKZrfeLC5p3Wn9aXh3feOtAw/cliC/d6gda5+qrYo5r
         azjNTVZqoJrUAT0PXap2yRr7GEMEGrRptrMaY7uCja60HmUzJ1HUAiLH3/hneKaY3ens
         F1PlU8e76BMkizDhasb3kOFOD97NqoxXL0sxVP15zF0R+JKVw49ZG24jHHvXkgyj6c6j
         9CNg==
X-Gm-Message-State: AOAM532pcKGKUjkWpYRmb/zIcX6iPf96lpcRR7bK5Q7mAI3ctq8mU13F
        UhAAjcukG+ry9eb6qXO7OM2CBw==
X-Google-Smtp-Source: ABdhPJxl8xZzl0+FEyNEX1aEMDptA5wDn7nR38epMj7SLt7Ns8ljT/fbQdKsorC/hddSaYL8bPtaZQ==
X-Received: by 2002:a7b:c942:: with SMTP id i2mr642875wml.51.1611588671158;
        Mon, 25 Jan 2021 07:31:11 -0800 (PST)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:4cd4:5994:40fe:253d])
        by smtp.gmail.com with ESMTPSA id o14sm22611965wri.48.2021.01.25.07.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:31:10 -0800 (PST)
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
Subject: [PATCH RESEND V12 4/8] fuse: Passthrough initialization and release
Date:   Mon, 25 Jan 2021 15:30:53 +0000
Message-Id: <20210125153057.3623715-5-balsini@android.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210125153057.3623715-1-balsini@android.com>
References: <20210125153057.3623715-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the FUSE passthrough ioctl that associates the lower
(passthrough) file system file with the fuse_file.

The file descriptor passed to the ioctl by the FUSE daemon is used to
access the relative file pointer, that will be copied to the fuse_file
data structure to consolidate the link between the FUSE and lower file
system.

To enable the passthrough mode, user space triggers the
FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl and, if the call succeeds, receives
back an identifier that will be used at open/create response time in the
fuse_open_out field to associate the FUSE file to the lower file system
file.
The value returned by the ioctl to user space can be:
- > 0: success, the identifier can be used as part of an open/create
reply.
- <= 0: an error occurred.
The value 0 represents an error to preserve backward compatibility: the
fuse_open_out field that is used to pass the passthrough_fh back to the
kernel uses the same bits that were previously as struct padding, and is
commonly zero-initialized (e.g., in the libfuse implementation).
Removing 0 from the correct values fixes the ambiguity between the case
in which 0 corresponds to a real passthrough_fh, a missing
implementation of FUSE passthrough or a request for a normal FUSE file,
simplifying the user space implementation.

For the passthrough mode to be successfully activated, the lower file
system file must implement both read_iter and write_iter file
operations. This extra check avoids special pseudo files to be targeted
for this feature.
Passthrough comes with another limitation: no further file system
stacking is allowed for those FUSE file systems using passthrough.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/inode.c       |  5 +++
 fs/fuse/passthrough.c | 87 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index a1104d5abb70..7ebc398fbacb 100644
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
index 594060c654f8..cf993e83803e 100644
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
+	if (passthrough_sb->s_stack_depth >= FILESYSTEM_MAX_STACK_DEPTH) {
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
2.30.0.280.ga3ce27912f-goog

