Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C092FAA7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 20:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394004AbhARTqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 14:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393918AbhART3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:29:30 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCEDC0613C1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 11:28:50 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m4so17525289wrx.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 11:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eAONCYRKylUz1/dYxnZzz9br96ok5P+MkuxK8MN34VE=;
        b=YOFCreGYVOvGinSwUYCHYZx/F+eBQWXvKVmiQItBXTveXHunfbrsMqMgY4nrG7Mnq/
         /EKeJInYGt1FRthz0mejCTq4dYo4ChcxvYdoFlQ48BOArRVQN26nPuvyJU64ak5SoC5m
         MTDWSoHAgl16GCyfNoJKZQyBD4XvpHsdunYyBCRiorPuJczNmnlkHpJlXQDBYJN/J+Df
         cxLOeaM2v6Nz8hMpBiicEydy7GULRXghO4REdkoRzYRFSj2BgfZmiNKTF1UwMIhPsLL8
         7NMmZE9KvVEfleKNlXDokA18dZfhotAC3fToRkQBhW4SKYPDv0MZ7gP1Xvh0ePGCge/6
         NOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAONCYRKylUz1/dYxnZzz9br96ok5P+MkuxK8MN34VE=;
        b=X2SA7pyfQUo0SLlt773sp8+dPvHt62K2EeJRUNM6q+Ffdds1e/hoTGvldsjpmhcfJz
         5OJK9jZV+OQXNZ3EoPA0uhjTx7rTjhB7XL8iGmAxWQE+u2a+WuX7YM+C9FSmuQr6r6SO
         v7WETLhzvL7jtp4Z0jw0G6DHFhjpMHgYlKylYj+09ipsCLNkYWzohRiQCjs5NClzYYOc
         6wIn1+/pq+QoUFf++QSUVIF5sPDeVBs/KLJ1XKjjeESsBffTbiV+xa816gW3o3KPrINk
         nCWRB75jcWPWdXb9wOXaFHPqHGHf7iwT/2PfmPxlyKxGQm3KZjdf1+C6q9dvlfmnP3lx
         xJIQ==
X-Gm-Message-State: AOAM532/RthhSVTd3ucG6RUwrmAoh/RVurNATrTEaiFQnXUMUBtQf2zh
        2wR2XFPAGORH/b0iii4Hnn9YbQ==
X-Google-Smtp-Source: ABdhPJwKOB3FU4uoKpsudqYcRlYYihNcU1+h4pT+RPCe+aHHPU21b1wzBye2kPOBbkcMGugBn6NOYw==
X-Received: by 2002:adf:bc92:: with SMTP id g18mr960365wrh.160.1610998129268;
        Mon, 18 Jan 2021 11:28:49 -0800 (PST)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:41d4:8c90:d38:455d])
        by smtp.gmail.com with ESMTPSA id h5sm33583299wrp.56.2021.01.18.11.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 11:28:48 -0800 (PST)
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
Subject: [PATCH RESEND V11 1/7] fs: Generic function to convert iocb to rw flags
Date:   Mon, 18 Jan 2021 19:27:42 +0000
Message-Id: <20210118192748.584213-2-balsini@android.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210118192748.584213-1-balsini@android.com>
References: <20210118192748.584213-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

OverlayFS implements its own function to translate iocb flags into rw
flags, so that they can be passed into another vfs call.
With commit ce71bfea207b4 ("fs: align IOCB_* flags with RWF_* flags")
Jens created a 1:1 matching between the iocb flags and rw flags,
simplifying the conversion.

Reduce the OverlayFS code by making the flag conversion function generic
and reusable.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/overlayfs/file.c | 23 +++++------------------
 include/linux/fs.h  |  5 +++++
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index bd9dd38347ae..56be2ffc5a14 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -15,6 +15,8 @@
 #include <linux/fs.h>
 #include "overlayfs.h"
 
+#define OVL_IOCB_MASK (IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
+
 struct ovl_aio_req {
 	struct kiocb iocb;
 	struct kiocb *orig_iocb;
@@ -236,22 +238,6 @@ static void ovl_file_accessed(struct file *file)
 	touch_atime(&file->f_path);
 }
 
-static rwf_t ovl_iocb_to_rwf(int ifl)
-{
-	rwf_t flags = 0;
-
-	if (ifl & IOCB_NOWAIT)
-		flags |= RWF_NOWAIT;
-	if (ifl & IOCB_HIPRI)
-		flags |= RWF_HIPRI;
-	if (ifl & IOCB_DSYNC)
-		flags |= RWF_DSYNC;
-	if (ifl & IOCB_SYNC)
-		flags |= RWF_SYNC;
-
-	return flags;
-}
-
 static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
 {
 	struct kiocb *iocb = &aio_req->iocb;
@@ -299,7 +285,8 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	if (is_sync_kiocb(iocb)) {
 		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
-				    ovl_iocb_to_rwf(iocb->ki_flags));
+				    iocb_to_rw_flags(iocb->ki_flags,
+						     OVL_IOCB_MASK));
 	} else {
 		struct ovl_aio_req *aio_req;
 
@@ -356,7 +343,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (is_sync_kiocb(iocb)) {
 		file_start_write(real.file);
 		ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
-				     ovl_iocb_to_rwf(ifl));
+				     iocb_to_rw_flags(ifl, OVL_IOCB_MASK));
 		file_end_write(real.file);
 		/* Update size */
 		ovl_copyattr(ovl_inode_real(inode), inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd47deea7c17..647c35423545 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3275,6 +3275,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 	return 0;
 }
 
+static inline rwf_t iocb_to_rw_flags(int ifl, int iocb_mask)
+{
+	return ifl & iocb_mask;
+}
+
 static inline ino_t parent_ino(struct dentry *dentry)
 {
 	ino_t res;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

