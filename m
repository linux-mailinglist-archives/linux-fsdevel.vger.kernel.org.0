Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAE010CC5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 17:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfK1P77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 10:59:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44051 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726858AbfK1P76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574956797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QILxa7RqQYQ4IyTulj5DZou1wI9mDMu/Shz+xSIroTs=;
        b=A8r0PvBrVe8EhL3tilrJ1K3uMf94IXNji7pxYaQm2BcxEDyGFV3XnXsLEMbEOHu0V+ji/6
        GBBkUTf3LTc+jiFxcW4DSddsQ0S7oe0kI3i3Wp+SrYXiIVG2YUoHliP2aaTwv1TlnkDeOT
        bHZEeSJq6eQ4D8pHOAgUqyvCFVwL0co=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-FcMKHSRyMM6LZBw52qj76Q-1; Thu, 28 Nov 2019 10:59:53 -0500
Received: by mail-wm1-f72.google.com with SMTP id z3so3718421wmk.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 07:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+mLHdhKK+RTjZWJLR+Q9KPjFkxVfyw86WO5G8timrLo=;
        b=a33D/qDn5FQ3GkBj8iOO8cKoQpppqYCLB7hrz6jxKezcrACKr1eNemBm36dN3OdcOV
         ARnpGZRXHFljchAWdA5AdzxDKtFgN58S+ZnS6Dppd0ITsAp1vvRs9UH8D6hgCT7XGVeD
         Vh7kO+WBwYKemCjylxSrfNo0LkhRI+NTb6EviOg5I8OJDNh+qkA7X5NQpl6wbNK6n+Ud
         t8l4yvk66J6rMnXgZyRUh/JEbfZdWG0SEHCJg9juWKcFi2ogq4KAzFT25PTpKLxq8Wrk
         sYmKkfSvQ4jyl9SeV6vo0KBZp65XFXD+Fo0nNINTxirBMz4amrNF7+CsfBJjk4ue4XiR
         er3w==
X-Gm-Message-State: APjAAAUx9/B5vdzFGBVcV4ghUmk0U6MQKF4zbHi1y5pkNMcwIwLXz33Z
        uDIl2+h5yDwWvu8A7PhNhBgtfiouRtnCbV1Dl5sdwZcGq7nF2F9AHKekY72PvYpuka6WA3VR0Qp
        haId0noZ0LSSs10oxScpXJ6YeSw==
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr10019157wmk.18.1574956792794;
        Thu, 28 Nov 2019 07:59:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfmGPafxnlfmoHK2fzycvAIcMrBZnABeqhb58fIBrDg5cokgJlyiyeWUs5sVPkhJkM5be0XA==
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr10019140wmk.18.1574956792568;
        Thu, 28 Nov 2019 07:59:52 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 2sm23689474wrq.31.2019.11.28.07.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:59:51 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/12] vfs: allow unprivileged whiteout creation
Date:   Thu, 28 Nov 2019 16:59:36 +0100
Message-Id: <20191128155940.17530-9-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128155940.17530-1-mszeredi@redhat.com>
References: <20191128155940.17530-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: FcMKHSRyMM6LZBw52qj76Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Whiteouts are special, but unlike real device nodes they should not require
privileges to create.

The 0 char device number should already be reserved, but make this explicit
in cdev_add() to be on the safe side.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/char_dev.c                 |  3 +++
 fs/namei.c                    | 17 ++++-------------
 include/linux/device_cgroup.h |  3 +++
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 00dfe17871ac..8bf66f40e5e0 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -483,6 +483,9 @@ int cdev_add(struct cdev *p, dev_t dev, unsigned count)
 =09p->dev =3D dev;
 =09p->count =3D count;
=20
+=09if (WARN_ON(dev =3D=3D WHITEOUT_DEV))
+=09=09return -EBUSY;
+
 =09error =3D kobj_map(cdev_map, dev, count, NULL,
 =09=09=09 exact_match, exact_lock, p);
 =09if (error)
diff --git a/fs/namei.c b/fs/namei.c
index 671c3c1a3425..05ca98595b62 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3687,12 +3687,14 @@ EXPORT_SYMBOL(user_path_create);
=20
 int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_=
t dev)
 {
+=09bool is_whiteout =3D S_ISCHR(mode) && dev =3D=3D WHITEOUT_DEV;
 =09int error =3D may_create(dir, dentry);
=20
 =09if (error)
 =09=09return error;
=20
-=09if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
+=09if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
+=09    !is_whiteout)
 =09=09return -EPERM;
=20
 =09if (!dir->i_op->mknod)
@@ -4527,9 +4529,6 @@ static int do_renameat2(int olddfd, const char __user=
 *oldname, int newdfd,
 =09    (flags & RENAME_EXCHANGE))
 =09=09return -EINVAL;
=20
-=09if ((flags & RENAME_WHITEOUT) && !capable(CAP_MKNOD))
-=09=09return -EPERM;
-
 =09if (flags & RENAME_EXCHANGE)
 =09=09target_flags =3D 0;
=20
@@ -4667,15 +4666,7 @@ SYSCALL_DEFINE2(rename, const char __user *, oldname=
, const char __user *, newna
=20
 int vfs_whiteout(struct inode *dir, struct dentry *dentry)
 {
-=09int error =3D may_create(dir, dentry);
-=09if (error)
-=09=09return error;
-
-=09if (!dir->i_op->mknod)
-=09=09return -EPERM;
-
-=09return dir->i_op->mknod(dir, dentry,
-=09=09=09=09S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
+=09return vfs_mknod(dir, dentry, S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
 }
 EXPORT_SYMBOL(vfs_whiteout);
=20
diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
index 8557efe096dc..fc989487c273 100644
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -62,6 +62,9 @@ static inline int devcgroup_inode_mknod(int mode, dev_t d=
ev)
 =09if (!S_ISBLK(mode) && !S_ISCHR(mode))
 =09=09return 0;
=20
+=09if (S_ISCHR(mode) && dev =3D=3D WHITEOUT_DEV)
+=09=09return 0;
+
 =09if (S_ISBLK(mode))
 =09=09type =3D DEVCG_DEV_BLOCK;
 =09else
--=20
2.21.0

