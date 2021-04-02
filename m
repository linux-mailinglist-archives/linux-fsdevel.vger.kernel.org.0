Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B781D352AB9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 14:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhDBMh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 08:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhDBMhZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 08:37:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57E0C61002;
        Fri,  2 Apr 2021 12:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617367044;
        bh=dUbTt4/JMI0Wi0hAdKMzvQDwqNf84SO9tY537ehAXeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GoIkUPhVFBewCC2U86mUUUZBWAT3+TSZeHX0eLYf1HjbOXexFNb0w4byPaAZw2uz7
         sYQKo13OrjfIUT/qN8HEeAy0iTENDkwDfpBHGb+0mlrrb/KjvCb4ncuh7+trLlHUkf
         lN4hU35ettriK4Aod/Q/TIF/G6M7Ib5HGHmGvyjk2QGbK6RcjtkPtMGi2iE3yrsEdU
         f4cDGxteEW8A4lxLeBtfy0/H7cokFtVWI8zjwjjXm+R/uL/qZuzdLBlLQsIJMqndX8
         G2zAL9DUVnfWOdtG7Zx4BBJcpwN++FpZ6VbC6Ok/m1Z8RQybs4iny9ee995OpzlmNj
         i2I0m69ageftQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: [PATCH 3/3] file: simplify logic in __close_range()
Date:   Fri,  2 Apr 2021 14:35:48 +0200
Message-Id: <20210402123548.108372-4-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <00000000000069c40405be6bdad4@google.com>
References: <00000000000069c40405be6bdad4@google.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=hxAQsk9Vm8whjH4fxdkcMpV9D/g/lrfRks3myDn8G5c=; m=nVAEuvMh4LK8seH9ue5IB38FN/6opr9N10BP3dDo73k=; p=c6iH7+6Y7h0lMivORcnihZU6RmsASk6k6ixprq2fgP8=; g=d55e07709d088c140ca4de213024a3759b86a094
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYGcPkwAKCRCRxhvAZXjcoiIYAQDvmHB 2mTiXLZaKEdlR+VJV0L4UXsCsU8pj5ca3PqhcdQD/eYIC8ayng5KsrLzBotDqfWYDVGfDAnoHymoI cURv1g4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

It never looked too pleasant and it doesn't really buy us anything
anymore now that CLOSE_RANGE_CLOEXEC exists and we need to retake the
current maximum under the lock for it anyway. This also makes the logic
easier to follow.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/file.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 740040346a98..ed46cd3ae225 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -701,7 +701,6 @@ static inline void __range_close(struct files_struct *cur_fds, unsigned int fd,
  */
 int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 {
-	unsigned int cur_max;
 	struct task_struct *me = current;
 	struct files_struct *cur_fds = me->files, *fds = NULL;
 
@@ -711,26 +710,26 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 	if (fd > max_fd)
 		return -EINVAL;
 
-	rcu_read_lock();
-	cur_max = files_fdtable(cur_fds)->max_fds;
-	rcu_read_unlock();
-
-	/* cap to last valid index into fdtable */
-	cur_max--;
-
 	if (flags & CLOSE_RANGE_UNSHARE) {
 		int ret;
 		unsigned int max_unshare_fds = NR_OPEN_MAX;
 
 		/*
-		 * If the requested range is greater than the current maximum,
-		 * we're closing everything so only copy all file descriptors
-		 * beneath the lowest file descriptor.
-		 * If the caller requested all fds to be made cloexec copy all
-		 * of the file descriptors since they still want to use them.
+		 * If the caller requested all fds to be made cloexec we always
+		 * copy all of the file descriptors since they still want to
+		 * use them.
 		 */
-		if (!(flags & CLOSE_RANGE_CLOEXEC) && (max_fd >= cur_max))
-			max_unshare_fds = fd;
+		if (!(flags & CLOSE_RANGE_CLOEXEC)) {
+			/*
+			 * If the requested range is greater than the current
+			 * maximum, we're closing everything so only copy all
+			 * file descriptors beneath the lowest file descriptor.
+			 */
+			rcu_read_lock();
+			if (max_fd >= last_fd(files_fdtable(cur_fds)))
+				max_unshare_fds = fd;
+			rcu_read_unlock();
+		}
 
 		ret = unshare_fd(CLONE_FILES, max_unshare_fds, &fds);
 		if (ret)
@@ -744,8 +743,6 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 			swap(cur_fds, fds);
 	}
 
-	max_fd = min(max_fd, cur_max);
-
 	if (flags & CLOSE_RANGE_CLOEXEC)
 		__range_cloexec(cur_fds, fd, max_fd);
 	else
-- 
2.27.0

