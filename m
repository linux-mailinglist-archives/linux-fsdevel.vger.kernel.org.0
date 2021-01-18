Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B742FAA7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 20:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394075AbhARTqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 14:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393971AbhART3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:29:34 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A53CC061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 11:28:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d26so17525525wrb.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F3cXmjxvqsjLDgr4m1O+IrhTdwMu3oOD7hCp15RNbpA=;
        b=UzNf2PLp1S2U0I3mhT/p/5J5doy7rziC9QDRw51E/gGeZvOKBtRpI+ZQ85an52tWj4
         Qxs943aizDkTxoNUam73NKwLWKfJdtDNg4K/yHJWvlpAtnzvk5wzJZFobSUn6EDl9Gnw
         XhmkSzsQb0zA7UWU84z9yC7kdVxTf4t/SK8adNol9+/coqq6mEic+TlGt2fEzW5I+HMw
         bmFPxFErtcSQ0M6gixkXlvuRZLaPP67dHn42N/NUTlhf+oeIkKP27MQTwnWXBgzWeOiK
         b3ioT89Ix2V5CmfRaIj1P3g/3WfBZZbAatJbz7cgeDlJ+LaEe9w2FjTiTuf6xw+0UmfG
         LW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F3cXmjxvqsjLDgr4m1O+IrhTdwMu3oOD7hCp15RNbpA=;
        b=SucpaZfwXxcsZ+fqnjlANVFmL7MnYCrNGFVVJ8WipXgno5DAOgq0cg3R5ip/YQu6A5
         NXsFSDlZ49E1wcjeFYeJM/PWli8NsnFPifL65usAYuyukOlbk5ZAT2ltDWlohdBxnPCl
         7H/LX4kzc67TvhE9RIX6amdt+nc6Yq6xgo2paZ6EHbN8ne+g7atY/j7RMW+oxUhrM/01
         BWNc36Un/6OxC5nf+NqngmsG4IdwrxjnNzPj3tddHOuU1qH9YTPIy6/2y0UOy5dZYbIx
         tS4JUzGptiytFqhL5vEZMAOwHX2jGLv3ZdR/5DN21TUrEC9NN4iY9Wmv154iVKJfjkVj
         6emw==
X-Gm-Message-State: AOAM531oSz+s172bbv+q9J3KI4GIG2MmbTQshEiQkQWDjqYP0KXwfrj+
        PpRyppNimkFD3i8gu54WBlc/Ag==
X-Google-Smtp-Source: ABdhPJwx4OUy+82KjBTRfN6OPyy0fNbvFvpq9k1a9l08YKumRCV6qJVBpNqaK9ZqHYCWWEaPnV37Fg==
X-Received: by 2002:adf:c387:: with SMTP id p7mr932317wrf.95.1610998132851;
        Mon, 18 Jan 2021 11:28:52 -0800 (PST)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:41d4:8c90:d38:455d])
        by smtp.gmail.com with ESMTPSA id h5sm33583299wrp.56.2021.01.18.11.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 11:28:52 -0800 (PST)
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
Subject: [PATCH RESEND V11 2/7] fuse: 32-bit user space ioctl compat for fuse device
Date:   Mon, 18 Jan 2021 19:27:43 +0000
Message-Id: <20210118192748.584213-3-balsini@android.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210118192748.584213-1-balsini@android.com>
References: <20210118192748.584213-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With a 64-bit kernel build the FUSE device cannot handle ioctl requests
coming from 32-bit user space.
This is due to the ioctl command translation that generates different
command identifiers that thus cannot be used for comparisons previous
proper manipulation.

Explicitly extract type and number from the ioctl command to enable
32-bit user space compatibility on 64-bit kernel builds.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/dev.c             | 29 ++++++++++++++++++-----------
 include/uapi/linux/fuse.h |  3 ++-
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 588f8d1240aa..ff9f3b83f879 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2233,37 +2233,44 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
-	int err = -ENOTTY;
+	int res;
+	int oldfd;
+	struct fuse_dev *fud = NULL;
 
-	if (cmd == FUSE_DEV_IOC_CLONE) {
-		int oldfd;
+	if (_IOC_TYPE(cmd) != FUSE_DEV_IOC_MAGIC)
+		return -EINVAL;
 
-		err = -EFAULT;
-		if (!get_user(oldfd, (__u32 __user *) arg)) {
+	switch (_IOC_NR(cmd)) {
+	case _IOC_NR(FUSE_DEV_IOC_CLONE):
+		res = -EFAULT;
+		if (!get_user(oldfd, (__u32 __user *)arg)) {
 			struct file *old = fget(oldfd);
 
-			err = -EINVAL;
+			res = -EINVAL;
 			if (old) {
-				struct fuse_dev *fud = NULL;
-
 				/*
 				 * Check against file->f_op because CUSE
 				 * uses the same ioctl handler.
 				 */
 				if (old->f_op == file->f_op &&
-				    old->f_cred->user_ns == file->f_cred->user_ns)
+				    old->f_cred->user_ns ==
+					    file->f_cred->user_ns)
 					fud = fuse_get_dev(old);
 
 				if (fud) {
 					mutex_lock(&fuse_mutex);
-					err = fuse_device_clone(fud->fc, file);
+					res = fuse_device_clone(fud->fc, file);
 					mutex_unlock(&fuse_mutex);
 				}
 				fput(old);
 			}
 		}
+		break;
+	default:
+		res = -ENOTTY;
+		break;
 	}
-	return err;
+	return res;
 }
 
 const struct file_operations fuse_dev_operations = {
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 98ca64d1beb6..54442612c48b 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -903,7 +903,8 @@ struct fuse_notify_retrieve_in {
 };
 
 /* Device ioctls: */
-#define FUSE_DEV_IOC_CLONE	_IOR(229, 0, uint32_t)
+#define FUSE_DEV_IOC_MAGIC		229
+#define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

