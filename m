Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F28322DCDF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 09:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgGZHOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 03:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgGZHOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:14:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C0DC0619D2;
        Sun, 26 Jul 2020 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ePYrotlytJXvI0CdCW3tl0P3sQHCqpS3OjHeAMmpEaE=; b=qhpb79ikcfqYXKIUvFaII+c4jE
        kFA6/rYf9K2KerRp8S8DPRZ4jsb0arAox4VSp48BN3v734pB+utYB7wiidXdtUOgvqjCzSokE1Mym
        KO7QQpUHHQlnZEi9+Y6wiqUkjzos9Qxh7c0Mqf1bWECXL68dV2bS6DMkth6tSbcrJfhlK37NFG8mT
        6dx31hIPSeOnqzZu9lP3X07CH+LY7Xh1eSC3kzedqJv/QiJsRLeUGFhNmkQAaQGLWt9vGiQh/yE31
        SCBdEO7Ibbku2HVgw48bDpAYhK0j3K/C2cuR38oeMeVnscxUWVrnrVcSRwGrR/j9+Kqld9AVmUTrS
        +AwK6RcQ==;
Received: from [2001:4bb8:18c:2acc:5ff1:d0b0:8643:670e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzarC-0002O6-0K; Sun, 26 Jul 2020 07:14:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 02/21] fs: refactor ksys_umount
Date:   Sun, 26 Jul 2020 09:13:37 +0200
Message-Id: <20200726071356.287160-3-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726071356.287160-1-hch@lst.de>
References: <20200726071356.287160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out a path_umount helper that takes a struct path * instead of the
actual file name.  This will allow to convert the init and devtmpfs code
to properly mount based on a kernel pointer instead of relying on the
implicit set_fs(KERNEL_DS) during early init.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/namespace.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6f8234f74bed90..43834b59eff6c3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1706,36 +1706,19 @@ static inline bool may_mandlock(void)
 }
 #endif
 
-/*
- * Now umount can handle mount points as well as block devices.
- * This is important for filesystems which use unnamed block devices.
- *
- * We now support a flag for forced unmount like the other 'big iron'
- * unixes. Our API is identical to OSF/1 to avoid making a mess of AMD
- */
-
-int ksys_umount(char __user *name, int flags)
+static int path_umount(struct path *path, int flags)
 {
-	struct path path;
 	struct mount *mnt;
 	int retval;
-	int lookup_flags = LOOKUP_MOUNTPOINT;
 
 	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
 		return -EINVAL;
-
 	if (!may_mount())
 		return -EPERM;
 
-	if (!(flags & UMOUNT_NOFOLLOW))
-		lookup_flags |= LOOKUP_FOLLOW;
-
-	retval = user_path_at(AT_FDCWD, name, lookup_flags, &path);
-	if (retval)
-		goto out;
-	mnt = real_mount(path.mnt);
+	mnt = real_mount(path->mnt);
 	retval = -EINVAL;
-	if (path.dentry != path.mnt->mnt_root)
+	if (path->dentry != path->mnt->mnt_root)
 		goto dput_and_out;
 	if (!check_mnt(mnt))
 		goto dput_and_out;
@@ -1748,12 +1731,25 @@ int ksys_umount(char __user *name, int flags)
 	retval = do_umount(mnt, flags);
 dput_and_out:
 	/* we mustn't call path_put() as that would clear mnt_expiry_mark */
-	dput(path.dentry);
+	dput(path->dentry);
 	mntput_no_expire(mnt);
-out:
 	return retval;
 }
 
+int ksys_umount(char __user *name, int flags)
+{
+	int lookup_flags = LOOKUP_MOUNTPOINT;
+	struct path path;
+	int ret;
+
+	if (!(flags & UMOUNT_NOFOLLOW))
+		lookup_flags |= LOOKUP_FOLLOW;
+	ret = user_path_at(AT_FDCWD, name, lookup_flags, &path);
+	if (ret)
+		return ret;
+	return path_umount(&path, flags);
+}
+
 SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
 {
 	return ksys_umount(name, flags);
-- 
2.27.0

