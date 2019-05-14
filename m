Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6B1E4B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 00:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfENWTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 18:19:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36255 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfENWTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 18:19:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id s17so472757wru.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 15:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GVlogRg79Wqyr1hZWWSXcwzY7VWlV2o1M6WoAHCLED4=;
        b=c0a7CG91NaHEsAS1B28yPqeIc130Anvsi+y3Zn0jOQrEZPtPkRNMz4RysUZKvGqhMN
         D0p66+Xck0oqFmMYwR43WFgpNiqijgrB206AePuDSePpeqgKHxT66bj2bEmOzTxh8a5g
         rRdxO9cWSNkXa1y6UZS2SeHVwDXkzlVm0WAD/7+QinKDhxSeKSa4JsZ5aIq/e1teDLVV
         VTtgAyDal5EuhYsyS+SpujtKFtPBsupWshZTxHL600QwjYaX7Tk6DJNjTFXRi+7KqYwq
         5GoeT10w+85cxw9Rtm7OVHHRD+o+ajZyBIWd51qhJHXmbLjrjbtClJUX18Klr831gGTr
         3YUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GVlogRg79Wqyr1hZWWSXcwzY7VWlV2o1M6WoAHCLED4=;
        b=YXB6gCPA3Ij2mI8hbISfomT4qu97aWxhAop1kZ68gQvZtMx0MSX/lOAH4HRCwn5EPj
         Lz50+8oz2p2Y7d9hBZZxuRQefjCL/2m4eBhzvJYbOLhAsbc+kkSgfU8rLgC/ffBvRa+y
         POcTp5eTxvTu6yQchryjT7XS2QEmBCaaDB31PyYHu40mQSNC+LwQzccP7cqeOBDfp2fs
         9lqawfjt43BNmuZxnvbeBs6ycU5NziYzJbWIVcHMW0szxJ5iBEyxf7Dtardm3OHMQE6Q
         vbS/u0uvLocI8QJF3a8GOSs16uBSRJYMUQyyrTRwxsLCmRQ699NbIObXkv5d27yEUyIG
         23oA==
X-Gm-Message-State: APjAAAUevHXN2FcJyZjSwxINoajTIw+tO1vKQ950OmK030FuzfM9t5Dy
        AkWqryg3I38+9xLELAnXBHo=
X-Google-Smtp-Source: APXvYqw8Eq1TWWuinP3vzYIvXxxUKOGhtUVFIAwJShUfFCRAtI9YeDpCRsp0Vo7dwj+WSULFvYc8rg==
X-Received: by 2002:adf:ce88:: with SMTP id r8mr1841616wrn.191.1557872353319;
        Tue, 14 May 2019 15:19:13 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id h188sm423553wmf.48.2019.05.14.15.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 15:19:12 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 2/4] fsnotify: add empty fsnotify_remove() hook
Date:   Wed, 15 May 2019 01:18:59 +0300
Message-Id: <20190514221901.29125-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514221901.29125-1-amir73il@gmail.com>
References: <20190514221901.29125-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We would like to move fsnotify_nameremove() calls from d_delete()
into a higher layer where the hook makes more sense and so we can
consider every d_delete() call site individually.

Start by creating an empty hook called fsnotify_remove() and place
it in the proper VFS call sites.  After all d_delete() call sites
will be converted to use the new hook, it will replace the old
fsnotify_nameremove() hook in d_delete().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/libfs.c               |  5 ++++-
 fs/namei.c               |  2 ++
 include/linux/fsnotify.h | 13 +++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 030e67c52b5f..0dd676fc9272 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -10,6 +10,7 @@
 #include <linux/cred.h>
 #include <linux/mount.h>
 #include <linux/vfs.h>
+#include <linux/fsnotify.h>
 #include <linux/quotaops.h>
 #include <linux/mutex.h>
 #include <linux/namei.h>
@@ -367,8 +368,10 @@ int simple_remove(struct inode *dir, struct dentry *dentry)
 	else
 		ret = simple_unlink(dir, dentry);
 
-	if (!ret)
+	if (!ret) {
+		fsnotify_remove(dir, dentry);
 		d_delete(dentry);
+	}
 	dput(dentry);
 
 	return ret;
diff --git a/fs/namei.c b/fs/namei.c
index 20831c2fbb34..c9eda9cc5d43 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3883,6 +3883,7 @@ int vfs_rmdir(struct inode *dir, struct dentry *dentry)
 	dentry->d_inode->i_flags |= S_DEAD;
 	dont_mount(dentry);
 	detach_mounts(dentry);
+	fsnotify_remove(dir, dentry);
 
 out:
 	inode_unlock(dentry->d_inode);
@@ -3999,6 +4000,7 @@ int vfs_unlink(struct inode *dir, struct dentry *dentry, struct inode **delegate
 			if (!error) {
 				dont_mount(dentry);
 				detach_mounts(dentry);
+				fsnotify_remove(dir, dentry);
 			}
 		}
 	}
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 94972e8eb6d1..455dff82595e 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -151,6 +151,19 @@ static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
 	__fsnotify_vfsmount_delete(mnt);
 }
 
+/*
+ * fsnotify_remove - a filename was removed from a directory
+ *
+ * Caller must make sure that dentry->d_name is stable.
+ */
+static inline void fsnotify_remove(struct inode *dir, struct dentry *dentry)
+{
+	/* Expected to be called before d_delete() */
+	WARN_ON_ONCE(d_is_negative(dentry));
+
+	/* TODO: call fsnotify_dirent() */
+}
+
 /*
  * fsnotify_inoderemove - an inode is going away
  */
-- 
2.17.1

