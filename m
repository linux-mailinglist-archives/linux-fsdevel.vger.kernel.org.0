Return-Path: <linux-fsdevel+bounces-26588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D026195A8BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417BFB211F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A490610A19;
	Thu, 22 Aug 2024 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gEqXUAEx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF514405
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286175; cv=none; b=UQkGPhkajZf/4OYDzh65+E8xHBKw5Pa4AIbe5SRBd4Co/udluEV7prAcVKZFIAL2Mh+r4xinBb9TbzUborF7D3L9SXIqStXHCYjaXLn9GKL8jlrdaHlP/ydTYFk/zCKdCIx3QTvlgI4IQXrMeQGPO7IQM/mmxNHPwT/KJhbOHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286175; c=relaxed/simple;
	bh=BQXjtD8LhaCuVEINpvWikngK7LcyGZzZMi42iMqWYPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tW4gNYZt4Ou04Zen6Yz/jEDHhigV8w7LjW/uiTsIyG/r67PVcJRD0Gsvhca8qJ3ahN80e2sSaPchEKrOk6aWfGSrzJ4P/JY2ZNJzrMBxly2xAPUQOvl/W+CqAwrRPzIuRwU8ct+ewT4PQieHEk+yArHOcrXrDC1MeJjOpi7a5zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gEqXUAEx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AmEZMTVrJ3Qgs6hY44S/27dH/rGCHngnJzHLMYmIZWw=; b=gEqXUAExeerPDjAiGCGtJnVM7n
	yWQZDMnkyABxnFrpmU0NBRq+UMHV9f6DIAy/3xPQH8ZLDbwYmDWq+e6QFYXBcswxP3/JPZKevmcP0
	vxuVhJtOW+xEOHC42GVxqWnOFKG6KXH6QaQmFsAa/qKbWJKsKR/k98x9o/O91zl6nYaxzrl244rqT
	7KkBDLV7qqh/AQg7iRFhIwjEZ7bwvI4RzO1CTRnzNWxzP/s9fz5BPpUHQ8pnL5y0HbscjThgKdgYK
	BIWo3ODJcjhZtuhVwjhsblweEPM8jg6cwhsvE6rZ4Lps5fXq0RhMdBI3SUJG0B8fo3vHiAGOFKqbU
	FZnFUhfw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvbG-00000003w7p-40sE;
	Thu, 22 Aug 2024 00:22:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 05/12] move close_range(2) into fs/file.c, fold __close_range() into it
Date: Thu, 22 Aug 2024 01:22:43 +0100
Message-ID: <20240822002250.938396-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822002250.938396-1-viro@zeniv.linux.org.uk>
References: <20240822002012.GM504335@ZenIV>
 <20240822002250.938396-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

	We never had callers for __close_range() except for close_range(2)
itself.  Nothing of that sort has appeared in four years and if any users
do show up, we can always separate those suckers again.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c               |  6 ++++--
 fs/open.c               | 17 -----------------
 include/linux/fdtable.h |  1 -
 3 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 4ea7afce828c..dcafae2acae8 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -713,7 +713,7 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
 }
 
 /**
- * __close_range() - Close all file descriptors in a given range.
+ * sys_close_range() - Close all file descriptors in a given range.
  *
  * @fd:     starting file descriptor to close
  * @max_fd: last file descriptor to close
@@ -721,8 +721,10 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
  *
  * This closes a range of file descriptors. All file descriptors
  * from @fd up to and including @max_fd are closed.
+ * Currently, errors to close a given file descriptor are ignored.
  */
-int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
+SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
+		unsigned int, flags)
 {
 	struct task_struct *me = current;
 	struct files_struct *cur_fds = me->files, *fds = NULL;
diff --git a/fs/open.c b/fs/open.c
index 22adbef7ecc2..25443d846d5e 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1575,23 +1575,6 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
 	return retval;
 }
 
-/**
- * sys_close_range() - Close all file descriptors in a given range.
- *
- * @fd:     starting file descriptor to close
- * @max_fd: last file descriptor to close
- * @flags:  reserved for future extensions
- *
- * This closes a range of file descriptors. All file descriptors
- * from @fd up to and including @max_fd are closed.
- * Currently, errors to close a given file descriptor are ignored.
- */
-SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
-		unsigned int, flags)
-{
-	return __close_range(fd, max_fd, flags);
-}
-
 /*
  * This routine simulates a hangup on the tty, to arrange that users
  * are given clean terminals at login time.
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index e25e2cb65d30..c45306a9f007 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -111,7 +111,6 @@ int iterate_fd(struct files_struct *, unsigned,
 		const void *);
 
 extern int close_fd(unsigned int fd);
-extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
 extern struct file *file_close_fd(unsigned int fd);
 
 extern struct kmem_cache *files_cachep;
-- 
2.39.2


