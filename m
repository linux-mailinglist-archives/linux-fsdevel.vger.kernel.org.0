Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152FB48C0A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 10:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbiALJDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 04:03:49 -0500
Received: from relay.sw.ru ([185.231.240.75]:35188 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351902AbiALJDs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Message-Id:Date:Subject:From:Content-Type:
        MIME-Version; bh=LXvcwvu/pJrvH+K8D0GYcsss9hjGYIeQtVGsSlxqdyg=; b=wGzyYFRnLJJZ
        mucOf3wrqT9EYp3thymNqbGrxkM7GLWq6g4wz/Xr/AjKYgp7P/LM4XFBfpL7gWL6dJ+L/9ecw/JSA
        AXwQbd/AicomCnyNMMaX15iq7iAwys86WxDE/OCQXGH1t0jiiZok0JDz5XGJh1mOBPLXSVb9giFTE
        jtawA=;
Received: from [10.93.0.12] (helo=dptest2.perf.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <andrey.zhadchenko@virtuozzo.com>)
        id 1n7ZXk-0060qk-Ql; Wed, 12 Jan 2022 12:03:44 +0300
From:   Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        christian.brauner@ubuntu.com, ptikhomirov@virtuozzo.com,
        linux-api@vger.kernel.org, andrey.zhadchenko@virtuozzo.com
Subject: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Date:   Wed, 12 Jan 2022 12:02:17 +0300
Message-Id: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If you have an opened O_PATH file, currently there is no way to re-open
it with other flags with openat/openat2. As a workaround it is possible
to open it via /proc/self/fd/<X>, however
1) You need to ensure that /proc exists
2) You cannot use O_NOFOLLOW flag

Both problems may look insignificant, but they are sensitive for CRIU.
First of all, procfs may not be mounted in the namespace where we are
restoring the process. Secondly, if someone opens a file with O_NOFOLLOW
flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU must also open the
file with this flag during restore.

This patch adds new constant RESOLVE_EMPTY_PATH for resolve field of
struct open_how and changes getname() call to getname_flags() to avoid
ENOENT for empty filenames.

Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
---

Why does even CRIU needs to reopen O_PATH files?
Long story short: to support restoring opened files that are overmounted
with single file bindmounts.
In-depth explanation: when restoring mount tree, before doing mount()
call, CRIU opens mountpoint with O_PATH and saves this fd for later use
for each mount. If we need to restore overmounted file, we look at the
mount which overmounts file mount and use its saved mountpoint fd in
openat(<saved_fd>, <relative_path>, flags).
If we need to open an overmounted mountpoint directory itself, we can use
openat(<saved_fd>, ".", flags). However, if we have a bindmount, its
mountpoint is a regular file. Therefore to open it we need to be able to
reopen O_PATH descriptor. As I mentioned above, procfs workaround is
possible but imposes several restrictions. Not to mention a hussle with
/proc.

Important note: the algorithm above relies on Virtozzo CRIU "mount-v2"
engine, which is currently being prepared for mainstream CRIU.
This patch ensures that CRIU will support all kinds of overmounted files.

 fs/open.c                    | 4 +++-
 include/linux/fcntl.h        | 2 +-
 include/uapi/linux/openat2.h | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index f732fb9..cfde988 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1131,6 +1131,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 			return -EAGAIN;
 		lookup_flags |= LOOKUP_CACHED;
 	}
+	if (how->resolve & RESOLVE_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
 
 	op->lookup_flags = lookup_flags;
 	return 0;
@@ -1203,7 +1205,7 @@ static long do_sys_openat2(int dfd, const char __user *filename,
 	if (fd)
 		return fd;
 
-	tmp = getname(filename);
+	tmp = getname_flags(filename, op.lookup_flags, 0);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79..eabc7a8 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -15,7 +15,7 @@
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
-	 RESOLVE_BENEATH | RESOLVE_IN_ROOT | RESOLVE_CACHED)
+	 RESOLVE_BENEATH | RESOLVE_IN_ROOT | RESOLVE_CACHED | RESOLVE_EMPTY_PATH)
 
 /* List of all open_how "versions". */
 #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index a5feb76..a42cf88 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -39,5 +39,7 @@ struct open_how {
 					completed through cached lookup. May
 					return -EAGAIN if that's not
 					possible. */
+#define RESOLVE_EMPTY_PATH	0x40 /* If pathname is an empty string, open
+					the file referred by dirfd */
 
 #endif /* _UAPI_LINUX_OPENAT2_H */
-- 
1.8.3.1

