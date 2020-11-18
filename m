Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35CB2B7BB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 11:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgKRKsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 05:48:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgKRKr7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605696478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8wAOglAL3fsqTpqfYjrg5+ouoD5MSyOi7eZ2Hc/xok=;
        b=Soxww3jKUR5ope3RQzJM9TDY5bstAycL3wp9TVoS5vatEwQV/IFJqY/hn8uhBXKtgcq6uE
        zjByhgn0lumISCkwgIAj9xI2tB+Rg2gGZrfCo84TZsPo6VqejdBH9ouMD570sFUFuRJLAn
        avhTGaOX7ZH92P2vTwl+SBM6BCVNB7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-FinVNhLKN-O1q4oYrDtVqQ-1; Wed, 18 Nov 2020 05:47:56 -0500
X-MC-Unique: FinVNhLKN-O1q4oYrDtVqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05B3F802B71;
        Wed, 18 Nov 2020 10:47:55 +0000 (UTC)
Received: from lithium.redhat.com (ovpn-113-143.ams2.redhat.com [10.36.113.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E20360C43;
        Wed, 18 Nov 2020 10:47:53 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org, christian.brauner@ubuntu.com
Cc:     linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org
Subject: [PATCH v3 1/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
Date:   Wed, 18 Nov 2020 11:47:45 +0100
Message-Id: <20201118104746.873084-2-gscrivan@redhat.com>
In-Reply-To: <20201118104746.873084-1-gscrivan@redhat.com>
References: <20201118104746.873084-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the flag CLOSE_RANGE_CLOEXEC is set, close_range doesn't
immediately close the files but it sets the close-on-exec bit.

It is useful for e.g. container runtimes that usually install a
seccomp profile "as late as possible" before execv'ing the container
process itself.  The container runtime could either do:
  1                                  2
- install_seccomp_profile();       - close_range(MIN_FD, MAX_INT, 0);
- close_range(MIN_FD, MAX_INT, 0); - install_seccomp_profile();
- execve(...);                     - execve(...);

Both alternative have some disadvantages.

In the first variant the seccomp_profile cannot block the close_range
syscall, as well as opendir/read/close/... for the fallback on older
kernels.
In the second variant, close_range() can be used only on the fds
that are not going to be needed by the runtime anymore, and it must be
potentially called multiple times to account for the different ranges
that must be closed.

Using close_range(..., ..., CLOSE_RANGE_CLOEXEC) solves these issues.
The runtime is able to use the existing open fds, the seccomp profile
can block close_range() and the syscalls used for its fallback.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 fs/file.c                        | 44 ++++++++++++++++++++++++--------
 include/uapi/linux/close_range.h |  3 +++
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 21c0893f2f1d..69382580ae32 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -672,6 +672,35 @@ int __close_fd(struct files_struct *files, unsigned fd)
 }
 EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
 
+static inline void __range_cloexec(struct files_struct *cur_fds,
+				   unsigned int fd, unsigned int max_fd)
+{
+	struct fdtable *fdt;
+
+	if (fd > max_fd)
+		return;
+
+	spin_lock(&cur_fds->file_lock);
+	fdt = files_fdtable(cur_fds);
+	bitmap_set(fdt->close_on_exec, fd, max_fd - fd + 1);
+	spin_unlock(&cur_fds->file_lock);
+}
+
+static inline void __range_close(struct files_struct *cur_fds, unsigned int fd,
+				 unsigned int max_fd)
+{
+	while (fd <= max_fd) {
+		struct file *file;
+
+		file = pick_file(cur_fds, fd++);
+		if (!file)
+			continue;
+
+		filp_close(file, cur_fds);
+		cond_resched();
+	}
+}
+
 /**
  * __close_range() - Close all file descriptors in a given range.
  *
@@ -687,7 +716,7 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 	struct task_struct *me = current;
 	struct files_struct *cur_fds = me->files, *fds = NULL;
 
-	if (flags & ~CLOSE_RANGE_UNSHARE)
+	if (flags & ~(CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC))
 		return -EINVAL;
 
 	if (fd > max_fd)
@@ -725,16 +754,11 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 	}
 
 	max_fd = min(max_fd, cur_max);
-	while (fd <= max_fd) {
-		struct file *file;
 
-		file = pick_file(cur_fds, fd++);
-		if (!file)
-			continue;
-
-		filp_close(file, cur_fds);
-		cond_resched();
-	}
+	if (flags & CLOSE_RANGE_CLOEXEC)
+		__range_cloexec(cur_fds, fd, max_fd);
+	else
+		__range_close(cur_fds, fd, max_fd);
 
 	if (fds) {
 		/*
diff --git a/include/uapi/linux/close_range.h b/include/uapi/linux/close_range.h
index 6928a9fdee3c..2d804281554c 100644
--- a/include/uapi/linux/close_range.h
+++ b/include/uapi/linux/close_range.h
@@ -5,5 +5,8 @@
 /* Unshare the file descriptor table before closing file descriptors. */
 #define CLOSE_RANGE_UNSHARE	(1U << 1)
 
+/* Set the FD_CLOEXEC bit instead of closing the file descriptor. */
+#define CLOSE_RANGE_CLOEXEC	(1U << 2)
+
 #endif /* _UAPI_LINUX_CLOSE_RANGE_H */
 
-- 
2.28.0

