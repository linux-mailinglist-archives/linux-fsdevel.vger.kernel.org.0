Return-Path: <linux-fsdevel+bounces-26584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B14095A8B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CD7281ECE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CD7AD2D;
	Thu, 22 Aug 2024 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="drer9Ez1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0524C8C
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286174; cv=none; b=A+8eF12ArBi20cUMDIcjbOedwiaXuUOqxJfBexiVlauu68eJTFXUw8UJo9XUjMgIqI4SrE6k+jEvM74MpRP7nNrK725jjJ7BgNwFlBoJKtqcRrdhHDzdXLkUfieplkSCbqlq4eA4Vndm3pPc8Uq70Zj75WJdDqeTif+c6159eIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286174; c=relaxed/simple;
	bh=WXy6/ngYjj/lddFtSfdj4BtSgOukvp5CSn6M8009Vmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOf8viwO80ifN2xQwMxMBu2ZsSFEksO20KbBBtvdL0Jb1debdO5+hh6nja94YPmBYICiC9jAevgx2pj5KZkb0NW5FKGhbsyYPcn9In/PA87Vo2JIMFTsKuIn7kUeKFfOCha9pIGjLRWhJUxRSovyZIR1DY1kBxuOeF88uxSrohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=drer9Ez1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tNfbAUFh70wPE4DQK3nYcBrgEEzv4kA+knTD/1o87ao=; b=drer9Ez1djS1hjhNhWXN65zzGU
	fOrFoG3AUSfx/zRb3GUO4ltavvR7ay+jfeZ5G+UJxBfcJ///rShmJSeWO52tXth9QZ1n8iK36GnpW
	94unwJigDcZFvdroEcHgQJ5Rp2tNqr78NSaZZ7xlfRttbnW40w2ZJl2/K+wLwJDo62nMEe3jCLcPD
	qYLBlk7D3R0AbNAKEGrQrigHIeiWRXHVCESxwy9z7pSpiS9hRRC9tZnc5oHDYetsns+mfVnYduNeN
	u9aISAiSuFMYqeMcbSmPrHsJZaCmHwq6a17pJcbPUnII2AT5JfXRPWK164KXWniIUmENMn4VJno/D
	CxB50ZFQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvbH-00000003w7u-0CPY;
	Thu, 22 Aug 2024 00:22:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 06/12] fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()
Date: Thu, 22 Aug 2024 01:22:44 +0100
Message-ID: <20240822002250.938396-6-viro@zeniv.linux.org.uk>
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

From: Yu Ma <yu.ma@intel.com>

alloc_fd() has a sanity check inside to make sure the struct file mapping to the
allocated fd is NULL. Remove this sanity check since it can be assured by
exisitng zero initilization and NULL set when recycling fd. Meanwhile, add
likely/unlikely and expand_file() call avoidance to reduce the work under
file_lock.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
Link: https://lore.kernel.org/r/20240717145018.3972922-2-yu.ma@intel.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index dcafae2acae8..9b8df3bc6fea 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -496,7 +496,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 	if (fd < files->next_fd)
 		fd = files->next_fd;
 
-	if (fd < fdt->max_fds)
+	if (likely(fd < fdt->max_fds))
 		fd = find_next_fd(fdt, fd);
 
 	/*
@@ -504,19 +504,21 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 	 * will limit the total number of files that can be opened.
 	 */
 	error = -EMFILE;
-	if (fd >= end)
+	if (unlikely(fd >= end))
 		goto out;
 
-	error = expand_files(files, fd);
-	if (error < 0)
-		goto out;
+	if (unlikely(fd >= fdt->max_fds)) {
+		error = expand_files(files, fd);
+		if (error < 0)
+			goto out;
 
-	/*
-	 * If we needed to expand the fs array we
-	 * might have blocked - try again.
-	 */
-	if (error)
-		goto repeat;
+		/*
+		 * If we needed to expand the fs array we
+		 * might have blocked - try again.
+		 */
+		if (error)
+			goto repeat;
+	}
 
 	if (start <= files->next_fd)
 		files->next_fd = fd + 1;
@@ -527,13 +529,6 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 	else
 		__clear_close_on_exec(fd, fdt);
 	error = fd;
-#if 1
-	/* Sanity check */
-	if (rcu_access_pointer(fdt->fd[fd]) != NULL) {
-		printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
-		rcu_assign_pointer(fdt->fd[fd], NULL);
-	}
-#endif
 
 out:
 	spin_unlock(&files->file_lock);
@@ -599,7 +594,7 @@ void fd_install(unsigned int fd, struct file *file)
 		rcu_read_unlock_sched();
 		spin_lock(&files->file_lock);
 		fdt = files_fdtable(files);
-		BUG_ON(fdt->fd[fd] != NULL);
+		WARN_ON(fdt->fd[fd] != NULL);
 		rcu_assign_pointer(fdt->fd[fd], file);
 		spin_unlock(&files->file_lock);
 		return;
-- 
2.39.2


