Return-Path: <linux-fsdevel+bounces-16985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B31EA8A5E8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59571C20B89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822E6159208;
	Mon, 15 Apr 2024 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS3376ix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2DF156967;
	Mon, 15 Apr 2024 23:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224465; cv=none; b=rZ5IOWf3ZHwYMpBmjY87YEL8lCa87dEEi7gdHUoM3vhD5JzvPQP5nkblQrXbjOR0wKqak3ItuLURlTW63qr4e3bMYeUE8q8sOtAbDkTVSzRKXX+NbkpiHiH0rF9qRk0nNUQAxCWaFOfPlPoRfv/LgwtT1Ih6+Ttxz55VxqghLFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224465; c=relaxed/simple;
	bh=tErBx4Jr4zXE2+GsjxRUd2QtGTTIXCbw61rLMiT4F3k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBPlZILTFCFw+mBVz/3yorQBADYjfCjax7csu+vkXYhsgoebwKtOaQPbrfkvwylm16jVCV6d1vMr8NloVXqXiRsDAf8aV00RM3RGTPNakyKZR4o8oPhx81mDnSjEp9NWmUOqC+t0His49xpFMJLthbIZN7qZyxCJdh20ydIIFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS3376ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65641C113CC;
	Mon, 15 Apr 2024 23:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224464;
	bh=tErBx4Jr4zXE2+GsjxRUd2QtGTTIXCbw61rLMiT4F3k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HS3376ix5mYOeJnHB/8vafYSXdQqhsJCPDcvbAYMAEXJqQcML2enJ4D23DgI3AJin
	 XFq2PJU11DARmM3l3pFPFMFjO5DuHvm1afh13dym18Ex8EZBvi13/z1tymCYf0fsNd
	 KHbNsgumw2RPKjeGWxBKJ7d0p2+Lafp88YZpklviHTNM2WBREBR7BauaL0WXkDncxe
	 x2We3kjhOGq+CodHck3R9fSriF+ngGOzQufZhMsQ9UxG2jxZN3FT6QitakK49OKKkQ
	 JY8cdOakzHpigEEfIiAwXzYY9mQu8UQ9AqyzyqhBCF4CrXCXtyuvauz2puSXi36Kzx
	 b/cvE0roLuvsg==
Date: Mon, 15 Apr 2024 16:41:03 -0700
Subject: [PATCH 01/15] vfs: export remap and write check helpers
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <171322381237.87355.17055121600436347427.stgit@frogsfrogsfrogs>
In-Reply-To: <171322381182.87355.15534989930482135103.stgit@frogsfrogsfrogs>
References: <171322381182.87355.15534989930482135103.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Export these functions so that the next patch can use them to check the
file ranges being passed to the XFS_IOC_EXCHANGE_RANGE operation.

Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c    |    1 +
 fs/remap_range.c   |    4 ++--
 include/linux/fs.h |    1 +
 3 files changed, 4 insertions(+), 2 deletions(-)


diff --git a/fs/read_write.c b/fs/read_write.c
index d4c036e82b6c..85c096f2c0d0 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1667,6 +1667,7 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(generic_write_check_limits);
 
 /* Like generic_write_checks(), but takes size of write instead of iter. */
 int generic_write_checks_count(struct kiocb *iocb, loff_t *count)
diff --git a/fs/remap_range.c b/fs/remap_range.c
index de07f978ce3e..28246dfc8485 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -99,8 +99,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 	return 0;
 }
 
-static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
-			     bool write)
+int remap_verify_area(struct file *file, loff_t pos, loff_t len, bool write)
 {
 	int mask = write ? MAY_WRITE : MAY_READ;
 	loff_t tmp;
@@ -118,6 +117,7 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
 
 	return fsnotify_file_area_perm(file, mask, &pos, len);
 }
+EXPORT_SYMBOL_GPL(remap_verify_area);
 
 /*
  * Ensure that we don't remap a partial EOF block in the middle of something
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8dfd53b52744..0835faeebe7b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2119,6 +2119,7 @@ extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
+int remap_verify_area(struct file *file, loff_t pos, loff_t len, bool write);
 int __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    loff_t *len, unsigned int remap_flags,


