Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3469D1E70BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 01:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437772AbgE1XtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 19:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437707AbgE1XtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 19:49:21 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707D4C008631;
        Thu, 28 May 2020 16:49:21 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSH1-00HDo6-SR; Thu, 28 May 2020 23:49:19 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/6] readdir.c: get rid of the last __put_user(), drop now-useless access_ok()
Date:   Fri, 29 May 2020 00:49:19 +0100
Message-Id: <20200528234919.4104604-3-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528234919.4104604-1-viro@ZenIV.linux.org.uk>
References: <20200528234832.GA4103769@ZenIV.linux.org.uk>
 <20200528234919.4104604-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/readdir.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 9534675880ce..a49f07c11cfb 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -276,9 +276,6 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	};
 	int error;
 
-	if (!access_ok(dirent, count))
-		return -EFAULT;
-
 	f = fdget_pos(fd);
 	if (!f.file)
 		return -EBADF;
@@ -362,9 +359,6 @@ int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
 	};
 	int error;
 
-	if (!access_ok(dirent, count))
-		return -EFAULT;
-
 	f = fdget_pos(fd);
 	if (!f.file)
 		return -EBADF;
@@ -377,7 +371,7 @@ int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
 		typeof(lastdirent->d_off) d_off = buf.ctx.pos;
 
 		lastdirent = (void __user *) buf.current_dir - buf.prev_reclen;
-		if (__put_user(d_off, &lastdirent->d_off))
+		if (put_user(d_off, &lastdirent->d_off))
 			error = -EFAULT;
 		else
 			error = count - buf.count;
@@ -537,9 +531,6 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	};
 	int error;
 
-	if (!access_ok(dirent, count))
-		return -EFAULT;
-
 	f = fdget_pos(fd);
 	if (!f.file)
 		return -EBADF;
-- 
2.11.0

