Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEA068B8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 15:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfGONlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 09:41:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52743 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731070AbfGONix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:38:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so15229094wms.2;
        Mon, 15 Jul 2019 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KVs1ANiN2NT/lZIPwqkW0aBmJkSeWx7/rdfuHFS1eHU=;
        b=qsisdaRbYtw7TgTK1em4losVONCF/1Mujd5Rjg2z19ciNDHC60xtIpKh6qlfGOnkxS
         g4pcnXuNpYT4qRaq6Y4F22ZzQY/aBJ8Hypi8kALHwM6PG7heG0mTEzE6HHCfNQxBcPt9
         gasZ3aAmc7SAPF9VqrpmhSY9SgoiDMZjcr798aYkT/vJJDnigsH2mIJNw2NLrC1MYPa7
         Y/fYBdulWfeX/zfxVZVkhoFSD3xW0uAuMdA3Dy39TbosA0qohlCNIB/XgUrqEwHtnRra
         QHeGvAD1r+FLEhBv+proaSt9No22Ql565t37ouRbJu8lvEKPQywWbyHdBlbIp8jKChT7
         EiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KVs1ANiN2NT/lZIPwqkW0aBmJkSeWx7/rdfuHFS1eHU=;
        b=nPjVTb/3CfAg/I/FiVdn82CSQzD93fg4YgXm1ogXnBD8LjFuQPsklJ2Pb7tUPs2BoT
         8URzgsgO34yYaPJCMmw7LZlgj0FP4TEbJikpDlfx07dda3fwYsydrIm34tTlFug85SSv
         UCo2Ja2kr9aLglUTLxbqBYM6sYE/WaQloaAgKaln4DCpiFvZH1Y5X2eG4NE+ZvM5qUpi
         XmLKSCbcxGXKppTfa9tu7+Rrh2wnZxnDrrJM7hBfcLbhQN0FfJV1Jj/HaPrhC6f9I2bW
         CeRlFd69BffKjHi/4LYtUVbtPxG0yGpJGgdDf+iXPZ+O5Wn5MjxjCEDBBfBnpFa6JNLV
         U9sQ==
X-Gm-Message-State: APjAAAX+U6cv9oiboV6n1dLYa55sx/Fwr5N63UTe2epgJfg5PyWDJrkF
        bKzB4+XwDRa5ZP09NR1SCUgB2GAN
X-Google-Smtp-Source: APXvYqwBton4gqT+iscohwzl/iRrP1OAXtjnpaj92SihOBRWt8S0e4KlMJPKqmh37R+yWdOaNRAYLA==
X-Received: by 2002:a7b:c251:: with SMTP id b17mr25410042wmj.143.1563197931750;
        Mon, 15 Jul 2019 06:38:51 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id s15sm4058250wrw.21.2019.07.15.06.38.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 06:38:51 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [PATCH 2/4] ovl: use generic vfs_ioc_setflags_prepare() helper
Date:   Mon, 15 Jul 2019 16:38:37 +0300
Message-Id: <20190715133839.9878-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715133839.9878-1-amir73il@gmail.com>
References: <20190715133839.9878-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Canonalize to ioctl FS_* flags instead of inode S_* flags.

Note that we do not call the helper vfs_ioc_fssetxattr_check()
for FS_IOC_FSSETXATTR ioctl. The reason is that underlying filesystem
will perform all the checks. We only need to perform the capability
check before overriding credentials.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 62 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index c6426e4d3f1f..1ba40845fba0 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -406,12 +406,28 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
 	return ret;
 }
 
+static unsigned int ovl_iflags_to_fsflags(unsigned int iflags)
+{
+	unsigned int flags = 0;
+
+	if (iflags & S_SYNC)
+		flags |= FS_SYNC_FL;
+	if (iflags & S_APPEND)
+		flags |= FS_APPEND_FL;
+	if (iflags & S_IMMUTABLE)
+		flags |= FS_IMMUTABLE_FL;
+	if (iflags & S_NOATIME)
+		flags |= FS_NOATIME_FL;
+
+	return flags;
+}
+
 static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
-				unsigned long arg, unsigned int iflags)
+				unsigned long arg, unsigned int flags)
 {
 	long ret;
 	struct inode *inode = file_inode(file);
-	unsigned int old_iflags;
+	unsigned int oldflags;
 
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
@@ -423,10 +439,9 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
 	inode_lock(inode);
 
 	/* Check the capability before cred override */
-	ret = -EPERM;
-	old_iflags = READ_ONCE(inode->i_flags);
-	if (((iflags ^ old_iflags) & (S_APPEND | S_IMMUTABLE)) &&
-	    !capable(CAP_LINUX_IMMUTABLE))
+	oldflags = ovl_iflags_to_fsflags(READ_ONCE(inode->i_flags));
+	ret = vfs_ioc_setflags_prepare(inode, oldflags, flags);
+	if (ret)
 		goto unlock;
 
 	ret = ovl_maybe_copy_up(file_dentry(file), O_WRONLY);
@@ -445,22 +460,6 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
 
 }
 
-static unsigned int ovl_fsflags_to_iflags(unsigned int flags)
-{
-	unsigned int iflags = 0;
-
-	if (flags & FS_SYNC_FL)
-		iflags |= S_SYNC;
-	if (flags & FS_APPEND_FL)
-		iflags |= S_APPEND;
-	if (flags & FS_IMMUTABLE_FL)
-		iflags |= S_IMMUTABLE;
-	if (flags & FS_NOATIME_FL)
-		iflags |= S_NOATIME;
-
-	return iflags;
-}
-
 static long ovl_ioctl_set_fsflags(struct file *file, unsigned int cmd,
 				  unsigned long arg)
 {
@@ -469,24 +468,23 @@ static long ovl_ioctl_set_fsflags(struct file *file, unsigned int cmd,
 	if (get_user(flags, (int __user *) arg))
 		return -EFAULT;
 
-	return ovl_ioctl_set_flags(file, cmd, arg,
-				   ovl_fsflags_to_iflags(flags));
+	return ovl_ioctl_set_flags(file, cmd, arg, flags);
 }
 
-static unsigned int ovl_fsxflags_to_iflags(unsigned int xflags)
+static unsigned int ovl_fsxflags_to_fsflags(unsigned int xflags)
 {
-	unsigned int iflags = 0;
+	unsigned int flags = 0;
 
 	if (xflags & FS_XFLAG_SYNC)
-		iflags |= S_SYNC;
+		flags |= FS_SYNC_FL;
 	if (xflags & FS_XFLAG_APPEND)
-		iflags |= S_APPEND;
+		flags |= FS_APPEND_FL;
 	if (xflags & FS_XFLAG_IMMUTABLE)
-		iflags |= S_IMMUTABLE;
+		flags |= FS_IMMUTABLE_FL;
 	if (xflags & FS_XFLAG_NOATIME)
-		iflags |= S_NOATIME;
+		flags |= FS_NOATIME_FL;
 
-	return iflags;
+	return flags;
 }
 
 static long ovl_ioctl_set_fsxflags(struct file *file, unsigned int cmd,
@@ -499,7 +497,7 @@ static long ovl_ioctl_set_fsxflags(struct file *file, unsigned int cmd,
 		return -EFAULT;
 
 	return ovl_ioctl_set_flags(file, cmd, arg,
-				   ovl_fsxflags_to_iflags(fa.fsx_xflags));
+				   ovl_fsxflags_to_fsflags(fa.fsx_xflags));
 }
 
 long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-- 
2.17.1

