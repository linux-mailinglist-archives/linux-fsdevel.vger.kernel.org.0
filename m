Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2323049B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbhAZFZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbhAYPl1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:41:27 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D9CC061A2A
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 07:31:09 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d16so12380022wro.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 07:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PmbAjVrlHcxm5n/bwgc2+WaEfTI9G00ILEGpn8g1B2s=;
        b=pIm9gqCvzmGTZV5I8GJ9+T38akNqP4Kv15XEl58FJ71C/wUV1CO5KYx/nMnV+i2/Dl
         qR2HzLG4y6z8xn0KKJTNhw+HMKNivW1uUtcHd/LVwJU2m75Pa8XWF/gbDmrjTAHHSAQB
         pESLS8gsM5Zh1RQTbjNVUuQ8f0u3ZUcRXrdhanvhM1fE3iby45cDBitZOFJxTUgVjEtE
         slJ2S+nlFGi9dlw8duihGV4vSBlSBRqAXj9oVWCHXwFqB+T0nzSL3cNK00yvheytIjHv
         mryS+brTv1Gwdzcj6szMHZa3XFA9yisIsdG0ipRLdGZQfi4Qrm/qn8OcwJ9oRhgUJrmY
         k4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PmbAjVrlHcxm5n/bwgc2+WaEfTI9G00ILEGpn8g1B2s=;
        b=Uy8OLOTh/i4NxS6kWtMD6bL4kwvNoqxDU7zOQLah0jrHaxTzsu9NEeHgI33HGurX4Q
         hUAEIcT2Cj+539hlwq/km8R1obcCWLQYk18/M0stpmUQ5IggAjb1Y6w642Kn5AJZRula
         S0iruWJCFp0ccRoQKZyBM9orlXDOXh8EeefxO70gDnAHFWxhE4z4V7tOrthpMn5SllFf
         AGTO+9c9b4/rlG9MV2zzTS7s6VcSBpFw4GKSbA1Rma84mXAT62IG0F4cjau8WjPzfvPg
         KppScYgzkmXEpiRfvWgfetnOwTfAcqZaWqd2+H0hjWK2ClaT3v7TuUkX6ho4STb7rrad
         DGqA==
X-Gm-Message-State: AOAM533ITwGqD4S6wJR1rje1eggVRQZt5a8OfW+rhlIgftllEz6TCotf
        skkSpaiI5qif/4mRYGK9cpjzrA==
X-Google-Smtp-Source: ABdhPJxGVLJp9p/xvJrz9/Q0C+7UywtvCTwYVi0tfEJCCCl9SPSmP4RdW+yUMSRO5tFoxeDes2PdAA==
X-Received: by 2002:adf:fc8a:: with SMTP id g10mr1632693wrr.189.1611588668411;
        Mon, 25 Jan 2021 07:31:08 -0800 (PST)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:4cd4:5994:40fe:253d])
        by smtp.gmail.com with ESMTPSA id o14sm22611965wri.48.2021.01.25.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:31:08 -0800 (PST)
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
Subject: [PATCH RESEND V12 1/8] fs: Generic function to convert iocb to rw flags
Date:   Mon, 25 Jan 2021 15:30:50 +0000
Message-Id: <20210125153057.3623715-2-balsini@android.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210125153057.3623715-1-balsini@android.com>
References: <20210125153057.3623715-1-balsini@android.com>
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
2.30.0.280.ga3ce27912f-goog

