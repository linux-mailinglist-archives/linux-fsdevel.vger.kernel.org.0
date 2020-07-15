Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CB9220583
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 08:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgGOGym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 02:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgGOGym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:54:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B0AC061755;
        Tue, 14 Jul 2020 23:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CpKccRUj/EuaoDj7R7PuZcQepyFmkA8DPqq/K86MqLk=; b=BfnsMFmOQCJh97HQsNBH05fn8s
        ++Uh0aAWxXcwfIlV9f2jLy5hWDPZBGveopAULXGEcaxGXXz61oSNcJukYJYg1s0uu4Wo4r8cC8dKI
        KakbJcFdon3o4IrEL+DZthCTmhIN1g2WZW9A7O/G6XycyuIiWLQQ3DrgRYa5B+ApRVMyLqu5pTpV9
        7WW7mCBnRBAfCwic03cNqoM4vAWtMmlOugdxn9fhlT7cszypYcgRFREpA4EfhcWPKbkRQkGSi5RVm
        e1+kCk4qAPwltKMsquxcKQDP+SoWTjSGRG4kcI2WdgYwlKFBQhQeRqXxq5keAUcjGhQo0tRR427Ao
        iHGQARUA==;
Received: from [2001:4bb8:105:4a81:1c8f:d581:a5f2:bdb7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvbJP-0001kD-U8; Wed, 15 Jul 2020 06:54:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] fs: expose utimes_common
Date:   Wed, 15 Jul 2020 08:54:33 +0200
Message-Id: <20200715065434.2550-4-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715065434.2550-1-hch@lst.de>
References: <20200715065434.2550-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename utimes_common to vfs_utimes and make it available outside of
utimes.c.  This will be used by the initramfs unpacking code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/utimes.c        | 6 +++---
 include/linux/fs.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index 441c7fb54053ca..12dba0741e1a71 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -16,7 +16,7 @@ static bool nsec_valid(long nsec)
 	return nsec >= 0 && nsec <= 999999999;
 }
 
-static int utimes_common(const struct path *path, struct timespec64 *times)
+int vfs_utimes(const struct path *path, struct timespec64 *times)
 {
 	int error;
 	struct iattr newattrs;
@@ -94,7 +94,7 @@ static int do_utimes_path(int dfd, const char __user *filename,
 	if (error)
 		return error;
 
-	error = utimes_common(&path, times);
+	error = vfs_utimes(&path, times);
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -115,7 +115,7 @@ static int do_utimes_fd(int fd, struct timespec64 *times, int flags)
 	f = fdget(fd);
 	if (!f.file)
 		return -EBADF;
-	error = utimes_common(&f.file->f_path, times);
+	error = vfs_utimes(&f.file->f_path, times);
 	fdput(f);
 	return error;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 635086726f2053..a1d2685a487868 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1746,6 +1746,7 @@ int vfs_mkobj(struct dentry *, umode_t,
 
 int vfs_fchown(struct file *file, uid_t user, gid_t group);
 int vfs_fchmod(struct file *file, umode_t mode);
+int vfs_utimes(const struct path *path, struct timespec64 *times);
 
 extern long vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
-- 
2.27.0

