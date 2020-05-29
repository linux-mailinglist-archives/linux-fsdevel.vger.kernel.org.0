Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334CE1E8BEC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 01:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgE2X1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 19:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgE2X1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 19:27:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E252C03E969;
        Fri, 29 May 2020 16:27:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeoPL-000Bhs-TE; Fri, 29 May 2020 23:27:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/9] x86: switch cp_stat64() to unsafe_put_user()
Date:   Sat, 30 May 2020 00:27:20 +0100
Message-Id: <20200529232723.44942-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/sys_ia32.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/sys_ia32.c b/arch/x86/kernel/sys_ia32.c
index ab03fede1422..f8d65c99feb8 100644
--- a/arch/x86/kernel/sys_ia32.c
+++ b/arch/x86/kernel/sys_ia32.c
@@ -135,26 +135,30 @@ static int cp_stat64(struct stat64 __user *ubuf, struct kstat *stat)
 	typeof(ubuf->st_gid) gid = 0;
 	SET_UID(uid, from_kuid_munged(current_user_ns(), stat->uid));
 	SET_GID(gid, from_kgid_munged(current_user_ns(), stat->gid));
-	if (!access_ok(ubuf, sizeof(struct stat64)) ||
-	    __put_user(huge_encode_dev(stat->dev), &ubuf->st_dev) ||
-	    __put_user(stat->ino, &ubuf->__st_ino) ||
-	    __put_user(stat->ino, &ubuf->st_ino) ||
-	    __put_user(stat->mode, &ubuf->st_mode) ||
-	    __put_user(stat->nlink, &ubuf->st_nlink) ||
-	    __put_user(uid, &ubuf->st_uid) ||
-	    __put_user(gid, &ubuf->st_gid) ||
-	    __put_user(huge_encode_dev(stat->rdev), &ubuf->st_rdev) ||
-	    __put_user(stat->size, &ubuf->st_size) ||
-	    __put_user(stat->atime.tv_sec, &ubuf->st_atime) ||
-	    __put_user(stat->atime.tv_nsec, &ubuf->st_atime_nsec) ||
-	    __put_user(stat->mtime.tv_sec, &ubuf->st_mtime) ||
-	    __put_user(stat->mtime.tv_nsec, &ubuf->st_mtime_nsec) ||
-	    __put_user(stat->ctime.tv_sec, &ubuf->st_ctime) ||
-	    __put_user(stat->ctime.tv_nsec, &ubuf->st_ctime_nsec) ||
-	    __put_user(stat->blksize, &ubuf->st_blksize) ||
-	    __put_user(stat->blocks, &ubuf->st_blocks))
+	if (!user_write_access_begin(ubuf, sizeof(struct stat64)))
 		return -EFAULT;
+	unsafe_put_user(huge_encode_dev(stat->dev), &ubuf->st_dev, Efault);
+	unsafe_put_user(stat->ino, &ubuf->__st_ino, Efault);
+	unsafe_put_user(stat->ino, &ubuf->st_ino, Efault);
+	unsafe_put_user(stat->mode, &ubuf->st_mode, Efault);
+	unsafe_put_user(stat->nlink, &ubuf->st_nlink, Efault);
+	unsafe_put_user(uid, &ubuf->st_uid, Efault);
+	unsafe_put_user(gid, &ubuf->st_gid, Efault);
+	unsafe_put_user(huge_encode_dev(stat->rdev), &ubuf->st_rdev, Efault);
+	unsafe_put_user(stat->size, &ubuf->st_size, Efault);
+	unsafe_put_user(stat->atime.tv_sec, &ubuf->st_atime, Efault);
+	unsafe_put_user(stat->atime.tv_nsec, &ubuf->st_atime_nsec, Efault);
+	unsafe_put_user(stat->mtime.tv_sec, &ubuf->st_mtime, Efault);
+	unsafe_put_user(stat->mtime.tv_nsec, &ubuf->st_mtime_nsec, Efault);
+	unsafe_put_user(stat->ctime.tv_sec, &ubuf->st_ctime, Efault);
+	unsafe_put_user(stat->ctime.tv_nsec, &ubuf->st_ctime_nsec, Efault);
+	unsafe_put_user(stat->blksize, &ubuf->st_blksize, Efault);
+	unsafe_put_user(stat->blocks, &ubuf->st_blocks, Efault);
+	user_access_end();
 	return 0;
+Efault:
+	user_write_access_end();
+	return -EFAULT;
 }
 
 COMPAT_SYSCALL_DEFINE2(ia32_stat64, const char __user *, filename,
-- 
2.11.0

