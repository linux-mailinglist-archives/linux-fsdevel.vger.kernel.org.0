Return-Path: <linux-fsdevel+bounces-31232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BC299353E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F417D1C223BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7801DDA3F;
	Mon,  7 Oct 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="O4McCDeA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FD41DDA0A
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323042; cv=none; b=kZDDlgIsgX6Asve6O1ycJ1kZS8cum/iChrSSPseQnm7KOhuswLAd/9u/9SX0ltNQ2yBcD651jhftjzambvtTOWrAIZhK4PcNjnXbx4pkWgdfD4PBhyN/OWj3FlwL1Vf/Sk+U6vdahs9yRpdOJAqZd+ciJRKDVJMiCFLu4KgbrBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323042; c=relaxed/simple;
	bh=RZ7xC3qVarmgC2SYiQcAT7IBdUDDDOFFGasERLq4dJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHNyPsgGLt/uSIdNdkc38AAQQntN8+/8jSU+zmgJyAMjuyEQ9id3oLAisHikZlQagLxpbX4Fy44eiwmnhXSzcKAtyyoqiVvt6kTdtcR6oTzdzqo0Z4xuSbeX4mUWYnkprf+zztKoRDoxURokDohkmOd6wGIdijRpHXIjNdylNGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=O4McCDeA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=chpqbSmMWBtqOla3XaEjvIe3j8xmQzrT0ADSD7AoouU=; b=O4McCDeAz6XOZfF5WPajToaKuU
	p2jY8nDMIUHaDQkxO1FRX0tXY5X7G0wj8OMYuWXXU/dIZeFC5G+48fCHVQ8tApA+rE7pAFJVXIvyx
	tcJHJMstyGyZV7e5LneiNML7Wxx3gHedscMmrFHed2ef0HO4dSWDMEI3Y2qrm9bEsY0r2VHJ3p5CE
	qGJjDaHOa2xnedb4dwIdSeu/0XC3BdqFk/M5sUcJBckHUmvem8RwwP/RbgX1se/yv8RazA2bGOinS
	HLKx2/wsnJtL7oMGPj6ue9n7ULNJkz8P/NV91pMihM6D8qse+LTs21YCCuOH9RfDqgVCLshuGosgM
	uHVk8bAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxrm3-00000001f3F-0dLi;
	Mon, 07 Oct 2024 17:43:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH v3 04/11] move close_range(2) into fs/file.c, fold __close_range() into it
Date: Mon,  7 Oct 2024 18:43:51 +0100
Message-ID: <20241007174358.396114-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007174358.396114-1-viro@zeniv.linux.org.uk>
References: <20241007173912.GR4017910@ZenIV>
 <20241007174358.396114-1-viro@zeniv.linux.org.uk>
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
index 8770010170c5..8e8f504782bf 100644
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
index acaeb3e25c88..62dd1383d6f9 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1574,23 +1574,6 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
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
2.39.5


