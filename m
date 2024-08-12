Return-Path: <linux-fsdevel+bounces-25638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAA194E703
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02658B209D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6797154C02;
	Mon, 12 Aug 2024 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s/Gr4s42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C114F9C9
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445071; cv=none; b=ng3V5zeClq6KL+WllI1JJtv57xEWgatL76Nrf0JO+zy1OMJM7i4Ns25qkdr7en8VkEenY22kHCy/POCqA6XTZUkXOMcqyyLeLY8Tr10S5UdO5xyoAtLlgeH7jIcB74obB085b4Yw3PGgSyJijOGhDL9Ao/IUOMGGlq7T4WxcTBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445071; c=relaxed/simple;
	bh=vEyMMs0IkIQgdbGVHHSac4MwJ6mb2hJ+cyfbSx6AgI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENqr/uMj8VVskiL3X2kwbhtcMqueGmHFjfIextsAiEHkBIZDvxpQf6rnodBCqyqVJHk4oGD+zsn26nf8JAazkmPxN7TrmpacFc4kj1QQgOMI9of6dzc2pJj1EpDAJJ2JSHGxQg+JFPF3v6p0Lzn36/xzOj73twbO/eg7dJ/xOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=s/Gr4s42; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vHS5EobCcBHhSj/ruuL0apPSGFAHrZXKydfkyRUFfP4=; b=s/Gr4s42Yn41AH5zkDtouRRRwd
	BNPBhNnvFht/EFcG0sK8NdmpoWgfSTsth3ErkhH+dLXYLjzbbMCb/26qX1Stu3bOxNxwBMDJCQthf
	9u2TPU3OAcrr2TQCrU96fk2bWqUvobFbnkjsaNkP7nPF6k0Zvhwh/EuEFDbsb7y8JNIFA3Ksy+Y4h
	qRd62hZhFSF1Zj47HDZyfAMXlpyXrTTKx2tfvdjj3R9ExS4ajtKbPgofcUbg9sj4t6o8CILe7q4Rj
	o4rtLfis9d8+48XPTbIItwlUa5kQ+uZ1qxNzfSH577O7NtyuI/0oxEAAQZzscZ1n5cF5ekQzWZPqQ
	LlOsp5Mw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdOn6-000000010UW-0KUW;
	Mon, 12 Aug 2024 06:44:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/11] move close_range(2) into fs/file.c, fold __close_range() into it
Date: Mon, 12 Aug 2024 07:44:21 +0100
Message-ID: <20240812064427.240190-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812064427.240190-1-viro@zeniv.linux.org.uk>
References: <20240812064214.GH13701@ZenIV>
 <20240812064427.240190-1-viro@zeniv.linux.org.uk>
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
index 313cfb860941..fbcd3da46109 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -728,7 +728,7 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
 }
 
 /**
- * __close_range() - Close all file descriptors in a given range.
+ * sys_close_range() - Close all file descriptors in a given range.
  *
  * @fd:     starting file descriptor to close
  * @max_fd: last file descriptor to close
@@ -736,8 +736,10 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
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
index b395a34eebf4..42cadad89f99 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -109,7 +109,6 @@ int iterate_fd(struct files_struct *, unsigned,
 		const void *);
 
 extern int close_fd(unsigned int fd);
-extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
 extern struct file *file_close_fd(unsigned int fd);
 extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
 		      struct files_struct **new_fdp);
-- 
2.39.2


