Return-Path: <linux-fsdevel+bounces-26591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22C095A8BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBE0282735
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6717D14A84;
	Thu, 22 Aug 2024 00:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aLNKfGAJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4902363A9
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286175; cv=none; b=uJC6iQgAX3NLidMa3Po58K+l2AXVC27zyceC8ZNAcg//AHRLmJw7fiTfesET4Wwe+y4UmEgEptE6kiiLYBCH4W4VS28T1p6dYtfOeLvpnfOlS2BBacxTE1g9udRwnUeGu7Lslddv/mY9/28vcRYnktlETDQAD3N3UgtsbtoDh74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286175; c=relaxed/simple;
	bh=cT3R6qzHczWm4yOal0yPsSMPNfd2jEobcbBV8zDD32k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tagEqBwyyqZ53kBsiJPEf/zQvQKKdKK2Hg3cE1RwRcFkLCBZxrXhdhPEreAODRPwCD1r0HqjxRrHLra+6s2HiRGdbrx9RHqrO8LsK/flkDMMLKjnWFo6rClnH4KKhskfNk2lMmayDVVX8ztd9Bdu0lt81CPcS7YM3mLAivMkGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aLNKfGAJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ebnev/Sb85foG9a0RzdbmEvZJIvOUB7cNfFqBep8RlE=; b=aLNKfGAJhXRxCuEvnfGDf44GLK
	lgM3Ad3UaErWH4Q1xOQm8ncl96jcInlDNz0iLQkweIArkrMCZ92Qa4dfvo/9XYVlA91l/Xn/yFSD+
	Tt1bn2kI7Prftq5DUKIycspqDvpiksyb/S6V4kIbjuUvPuQbOrRvQbAzk1Hrp0GNpEpbcYMQ63MnY
	IM4Nyl+DdqUUuf6FATOqOZz0v69H6yrzYqPlaPpt5GJIkdWI5hJXgl8+0R0MDEtVhh4vaKBAo+UPF
	czI/w8Ly/jZAgWBMD920a+fGxxrW2lF1l4tJgEIanRMSvQjAAeAwaQS69UyaL+MZPDucO1XKa2kb1
	0CHYTDFg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvbH-00000003w8U-3W9i;
	Thu, 22 Aug 2024 00:22:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 12/12] expand_files(): simplify calling conventions
Date: Thu, 22 Aug 2024 01:22:50 +0100
Message-ID: <20240822002250.938396-12-viro@zeniv.linux.org.uk>
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

All callers treat 0 and 1 returned by expand_files() in the same way
now since the call in alloc_fd() had been made conditional.  Just make
it return 0 on success and be done with it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 411e658c3fa3..0dbb3f68249d 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -162,7 +162,7 @@ static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
  * Expand the file descriptor table.
  * This function will allocate a new fdtable and both fd array and fdset, of
  * the given size.
- * Return <0 error code on error; 1 on successful completion.
+ * Return <0 error code on error; 0 on successful completion.
  * The files->file_lock should be held on entry, and will be held on exit.
  */
 static int expand_fdtable(struct files_struct *files, unsigned int nr)
@@ -191,15 +191,14 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 		call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
 	/* coupled with smp_rmb() in fd_install() */
 	smp_wmb();
-	return 1;
+	return 0;
 }
 
 /*
  * Expand files.
  * This function will expand the file structures, if the requested size exceeds
  * the current capacity and there is room for expansion.
- * Return <0 error code on error; 0 when nothing done; 1 when files were
- * expanded and execution may have blocked.
+ * Return <0 error code on error; 0 on success.
  * The files->file_lock should be held on entry, and will be held on exit.
  */
 static int expand_files(struct files_struct *files, unsigned int nr)
@@ -207,14 +206,14 @@ static int expand_files(struct files_struct *files, unsigned int nr)
 	__acquires(files->file_lock)
 {
 	struct fdtable *fdt;
-	int expanded = 0;
+	int error;
 
 repeat:
 	fdt = files_fdtable(files);
 
 	/* Do we need to expand? */
 	if (nr < fdt->max_fds)
-		return expanded;
+		return 0;
 
 	/* Can we expand? */
 	if (nr >= sysctl_nr_open)
@@ -222,7 +221,6 @@ static int expand_files(struct files_struct *files, unsigned int nr)
 
 	if (unlikely(files->resize_in_progress)) {
 		spin_unlock(&files->file_lock);
-		expanded = 1;
 		wait_event(files->resize_wait, !files->resize_in_progress);
 		spin_lock(&files->file_lock);
 		goto repeat;
@@ -230,11 +228,11 @@ static int expand_files(struct files_struct *files, unsigned int nr)
 
 	/* All good, so we try */
 	files->resize_in_progress = true;
-	expanded = expand_fdtable(files, nr);
+	error = expand_fdtable(files, nr);
 	files->resize_in_progress = false;
 
 	wake_up_all(&files->resize_wait);
-	return expanded;
+	return error;
 }
 
 static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt,
@@ -507,12 +505,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 		if (error < 0)
 			goto out;
 
-		/*
-		 * If we needed to expand the fs array we
-		 * might have blocked - try again.
-		 */
-		if (error)
-			goto repeat;
+		goto repeat;
 	}
 
 	if (start <= files->next_fd)
-- 
2.39.2


