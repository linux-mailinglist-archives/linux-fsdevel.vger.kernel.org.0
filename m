Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236E51C524A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgEEJ73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:59:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24784 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728677AbgEEJ7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588672762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zXA4w7SFuvdgtElQZS4nWZuP6eglSGx7ZZVh8H1aUkI=;
        b=NN7YhVSxArdUFq0ke6ODbPFO78T+kyH9VNLhM7SH43EU2HNvw3FoelrQNAw9h99LS2SoB1
        89hFs4CMd/hQcpif2vuz34C7qkXYSqJrGRAHqYsDVXWoqv3KVn7dkB2QbxpnQfOqR4/xOq
        yy5qkslmXNu9swxtHyknbNhEE6wmGpc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-gTGbV3rhM--ZbfCGmKYCww-1; Tue, 05 May 2020 05:59:20 -0400
X-MC-Unique: gTGbV3rhM--ZbfCGmKYCww-1
Received: by mail-wr1-f72.google.com with SMTP id y4so975794wrt.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 02:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zXA4w7SFuvdgtElQZS4nWZuP6eglSGx7ZZVh8H1aUkI=;
        b=cgfnWQ5MS9G+yMRhUJkd9c+owndsQB/CXySwUbTqgfG7b+gH6Z6dfeZE5YCKGwzMUx
         E7Zjy7YPmC8dBrOBPwYru01J8htIkyV+L0GGz6HT55NOAVEZ4DNB9OpZ20p3OqKsZhX7
         9mFob8ETxsLhdC806THJKG/Ghz5tivijrQ5pU56Yu+OeBJMPTx7LDPprErLIf1Y8k4M6
         CWsgyjM/Yv2NWO2RfvfRjQ/l5pjs1j01mgkSFfx9mLfe2LpQuYg/BuSTu4MC4J6AeG0F
         P+ck2mSdkzQ7VL5Mpamo4HTB1f5KRhwW7t7agrR46Z2/ah9NzP1G1NdIHZDsmNJujY43
         /65Q==
X-Gm-Message-State: AGi0PubQucC26MzZ5xVhiJ821w8+I5xTt6RXzJu08EtMNv1F4sr3v8go
        HxHLfkUuAUV1pJEOTkZdos6s3y7ddMtjm0fBSEehxZmKSfJGjR68H6NG9Yr9s3j4CtrbxCdf7I8
        Clp3nJUu+ltEdjVepz/s/vUb1lQ==
X-Received: by 2002:adf:e84f:: with SMTP id d15mr3032033wrn.296.1588672758917;
        Tue, 05 May 2020 02:59:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypJShUnYILHJ8U5brRMrIssUCnaErztaa25cV9VvPFQqdJVpx0Vrslt1Z2BIuQkZt6KNTl+ItA==
X-Received: by 2002:adf:e84f:: with SMTP id d15mr3032013wrn.296.1588672758743;
        Tue, 05 May 2020 02:59:18 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t16sm2862734wmi.27.2020.05.05.02.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:59:18 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/12] vfs: allow unprivileged whiteout creation
Date:   Tue,  5 May 2020 11:59:04 +0200
Message-Id: <20200505095915.11275-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200505095915.11275-1-mszeredi@redhat.com>
References: <20200505095915.11275-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Whiteouts, unlike real device node should not require privileges to create.

The general concern with device nodes is that opening them can have side
effects.  The kernel already avoids zero major (see
Documentation/admin-guide/devices.txt).  To be on the safe side the patch
explicitly forbids registering a char device with 0/0 number (see
cdev_add()).

This guarantees that a non-O_PATH open on a whiteout will fail with ENODEV;
i.e. it won't have any side effect.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/char_dev.c                 |  3 +++
 fs/namei.c                    | 17 ++++-------------
 include/linux/device_cgroup.h |  3 +++
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index c5e6eff5a381..ba0ded7842a7 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -483,6 +483,9 @@ int cdev_add(struct cdev *p, dev_t dev, unsigned count)
 	p->dev = dev;
 	p->count = count;
 
+	if (WARN_ON(dev == WHITEOUT_DEV))
+		return -EBUSY;
+
 	error = kobj_map(cdev_map, dev, count, NULL,
 			 exact_match, exact_lock, p);
 	if (error)
diff --git a/fs/namei.c b/fs/namei.c
index a320371899cf..b48dc2e03888 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3505,12 +3505,14 @@ EXPORT_SYMBOL(user_path_create);
 
 int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 {
+	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
 	int error = may_create(dir, dentry);
 
 	if (error)
 		return error;
 
-	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
+	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
+	    !capable(CAP_MKNOD))
 		return -EPERM;
 
 	if (!dir->i_op->mknod)
@@ -4345,9 +4347,6 @@ static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
 	    (flags & RENAME_EXCHANGE))
 		return -EINVAL;
 
-	if ((flags & RENAME_WHITEOUT) && !capable(CAP_MKNOD))
-		return -EPERM;
-
 	if (flags & RENAME_EXCHANGE)
 		target_flags = 0;
 
@@ -4485,15 +4484,7 @@ SYSCALL_DEFINE2(rename, const char __user *, oldname, const char __user *, newna
 
 int vfs_whiteout(struct inode *dir, struct dentry *dentry)
 {
-	int error = may_create(dir, dentry);
-	if (error)
-		return error;
-
-	if (!dir->i_op->mknod)
-		return -EPERM;
-
-	return dir->i_op->mknod(dir, dentry,
-				S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
+	return vfs_mknod(dir, dentry, S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
 }
 EXPORT_SYMBOL(vfs_whiteout);
 
diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
index fa35b52e0002..57e63bd63370 100644
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -51,6 +51,9 @@ static inline int devcgroup_inode_mknod(int mode, dev_t dev)
 	if (!S_ISBLK(mode) && !S_ISCHR(mode))
 		return 0;
 
+	if (S_ISCHR(mode) && dev == WHITEOUT_DEV)
+		return 0;
+
 	if (S_ISBLK(mode))
 		type = DEVCG_DEV_BLOCK;
 	else
-- 
2.21.1

