Return-Path: <linux-fsdevel+bounces-20753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA8D8D7829
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 22:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D319B1F2104F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 20:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2078C6E;
	Sun,  2 Jun 2024 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KPvKiQJb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991BC78C69
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jun 2024 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717360963; cv=none; b=rDrPLjAAtSPC+LqxAXRNDjhT90Qiu3zZbqEIn+D7vf1sU7gIkmCwwFujj0ckygT37v2MvYcB9mua8L3yCBRaE/KVDgmKLbnAYWzmiuUjEwbGIBfPHTC9YIiVivJztKEJbNBn92xPZWxH23KhTVbRVeV2efvKWbUzB2KZxLvpcHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717360963; c=relaxed/simple;
	bh=Gt7as4oh+CokncQQBUpQG3JuSU1IL0+574+KIpSBjms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DIUEhJXKcKwVkztp2MGIHkG92VJ+HwLf/2qRPnP3/su5S7RRL4VmlswAe1PsrPuGajksf2LBx/+aiuEcxaVICUw0sN1E8kHHZBZRMLWb9C+ddugwFlbaklgNPn3n4tTwLT224e/FO1D4RHWK2Z//tPWqpMfvpR+viJdcREOY2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KPvKiQJb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qaPCfQNzGKgNufO+xaScpL1fFgEvdNEXlMcKIzZKsvw=; b=KPvKiQJbXzpTXte7WwYsuy/j2C
	n0tlB5SIl57ucZPe9T+Y+yBI573XuWB9UsPcyfOHhODopYOT4PiPyItuKQKB7nqwmr6332KkOt+PH
	eK0dFOk8BOtIt9sYInVYd151YLJ7MqrIUYgI72A8B6zKt5ZhnrWwXo6rA3yeZmBzyOHD/L1ZNzSaq
	guEHquY2lZE7hrddfrWt7ZbV2H+0nTdhI723NxyLCauguSJpeZ4vPkXSelLt1ZCcXi0nsv0kz7dUd
	q4MAOZsUhCS0tPZ7kqYWJSQNiVCowV6HLetLMIx5j9mIYkM+1kTE2oST57G4tUW2wOHcyLmexdvs6
	rRbFHRVw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sDs2I-00Axs5-2h;
	Sun, 02 Jun 2024 20:42:38 +0000
Date: Sun, 2 Jun 2024 21:42:38 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Subject: [PATCH][RFC] move close_range(2) into fs/file.c, fold
 __close_range() into it
Message-ID: <20240602204238.GD1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	We never had callers for __close_range() except for close_range(2)
itself.  Nothing of that sort has appeared in four years and if any users
do show up, we can always separate those suckers again.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/file.c b/fs/file.c
index 8076aef9c210..f9fcebc7c838 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -732,7 +732,7 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
 }
 
 /**
- * __close_range() - Close all file descriptors in a given range.
+ * sys_close_range() - Close all file descriptors in a given range.
  *
  * @fd:     starting file descriptor to close
  * @max_fd: last file descriptor to close
@@ -740,8 +740,10 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
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
index 89cafb572061..7ee11c4de4ca 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1564,23 +1564,6 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
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
index 2944d4aa413b..4e7d1bcca5b7 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -113,7 +113,6 @@ int iterate_fd(struct files_struct *, unsigned,
 		const void *);
 
 extern int close_fd(unsigned int fd);
-extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
 extern struct file *file_close_fd(unsigned int fd);
 extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
 		      struct files_struct **new_fdp);

