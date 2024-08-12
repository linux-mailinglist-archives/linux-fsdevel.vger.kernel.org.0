Return-Path: <linux-fsdevel+bounces-25639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B060894E704
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CFAFB22FC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E7215886B;
	Mon, 12 Aug 2024 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="R/7b+6U3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA37B1509A8
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445071; cv=none; b=JZ1kHMMWF2C/0rlsUG4NhsmC6dF9E9jAPRuaIFoSGYFx8EpEx/z249KLa4ZqdTzEI3kY9uLIKXPROI7EbYm+GqIq8qxN2+fUybaxflxA96bkMoxpllrvkZltS3WBfotdcpwcp741hlO9nBBzvIZHKV0njaKYfJg80dZSbmezj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445071; c=relaxed/simple;
	bh=+qcGKHob8p3oDUUG+zfvCzxe5AO0Jfpmj0UcT7GDRAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbMG+Xn75t3c+38wfXyPeDsetMbkzz4tpFYZtbuo5Cn269npfUyPuQJYm2JAS52XbN+/486GykyNFWk/Z9xVj1Ah7QqcFo+Af9bg6LtUhXc73Rdh2XclOZKZwSHnrxmZE0Q9NgjhJFl8Xok/8q0ocGBdQlAh8WoyfSc40uNbm7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=R/7b+6U3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UMaZZ1YtEb3YlU3PlNTlA4FF5/bJC7A8/2t79j6VGjg=; b=R/7b+6U35qwCbGnSwl7Cx/zn4d
	jjv9Wd+ffW+FZ/wiPrxyREONJKAFWfc2ay3O1RS6F8bNSk4vLfDg+8RxSnCmBy5by2RsZJy413bBe
	OlFztr4scZMIjJ24qkp6d8DDDwspsERkeCeX69mD5/Tw8azj6qRlon0+JWEk6MpQmAYBxRj6xxTRB
	jbUO3ybyLrISNaIDQU4zb9e4/v0gN/FnCwIafQsoPh6QNBROGB9+adn2C6n9uOJDhHWrPrTOvrmNm
	Op26F77WmoyU9QXI0YEJjhoiPGYcF9IwGqtDDFZCmDNpQytgJ7egcZ6fpxyMO/qbVgB67d/WGwKa2
	d6ZJK94g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdOn6-000000010Uk-1afS;
	Mon, 12 Aug 2024 06:44:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/11] fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()
Date: Mon, 12 Aug 2024 07:44:23 +0100
Message-ID: <20240812064427.240190-7-viro@zeniv.linux.org.uk>
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
index 894bd18241b5..e217247006a2 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -514,7 +514,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 	if (fd < files->next_fd)
 		fd = files->next_fd;
 
-	if (fd < fdt->max_fds)
+	if (likely(fd < fdt->max_fds))
 		fd = find_next_fd(fdt, fd);
 
 	/*
@@ -522,19 +522,21 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
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
@@ -545,13 +547,6 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
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
@@ -617,7 +612,7 @@ void fd_install(unsigned int fd, struct file *file)
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


