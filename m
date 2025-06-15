Return-Path: <linux-fsdevel+bounces-51677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30351ADA06B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 02:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568553B6169
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 00:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E387F9EC;
	Sun, 15 Jun 2025 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fYzyS4ah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA15223
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jun 2025 00:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749947710; cv=none; b=KW0Cr2s7XvgeWle6JtzwM4EzITOCo56fPObmHenIg6KVuUopiS6BnbOYo0PfOgy0iT1AGCRm1xEAvRwa9TRtLRbAdC/bengCEfct+uXlozCYi46/MXo/6n/nUQypPL0+12Vx7uRlpqOLFVMiZjVy9lODsI4+cCEDOUvxYpPMJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749947710; c=relaxed/simple;
	bh=StvbMwI9l+dNzg9MyGBz7jw4Al1p9ZIUAyVeZxFIusU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9E5J+k2FR5dAaj3nBUkR2GyMHacc38ShfH3gNZDKO1vKesdvpAUQ0yZCkWwnQt0xRfUvZ/I9WBBitxUBTlJ8qhpANPnSY7MJLavPQgQkPSxu8waSy3WZ++05I2KH0vhtbJ9xHCAnaYgu3A9i+4JkQmC01V50R6KuRH8aQfQvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fYzyS4ah; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9ziNd7SpeX+aHhVJlYrqbLjz3ARwgo1FCIFvpPO3/Q0=; b=fYzyS4ahJwPO6nS5qF4XmAMWrf
	xPjJQ9H1meBAL5ZKQDB5cm3m4CpJ/6ye3mD/A0/K/mRRTmGFF6fQgsPlT2STZnqs3+nvNjg1JFNmG
	vkbvqsbqfQ0Hyh8CD5zrV41lq+3M99bLLyOjJXsESSW4v/9YJhm6rUjs50yDvOvIPuO9E1iJj0/gT
	3hEJQaC4hsCu7sFycZ5j2wkHJ/f6rnBp+Mx/9/NhnP5W2DGouhFdiV93WyOJqLGHYxBDu8T6QhqvV
	7uP+uv+bS27ZB/39g1q3RAHc8tBaPA2q4JubjR0XuLf20yKUGLFwd4Syt7Xi1EoUIOHoAHnkp9fjg
	JrlIlv5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQbL1-0000000CgUA-0Wc4;
	Sun, 15 Jun 2025 00:35:07 +0000
Date: Sun, 15 Jun 2025 01:35:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] secretmem: move setting O_LARGEFILE and bumping users' count
 to the place where we create the file
Message-ID: <20250615003507.GD3011112@ZenIV>
References: <20250615003011.GD1880847@ZenIV>
 <20250615003110.GA3011112@ZenIV>
 <20250615003216.GB3011112@ZenIV>
 <20250615003321.GC3011112@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615003321.GC3011112@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[don't really care which tree that goes through; right now it's
in viro/vfs.git #work.misc, but if somebody prefers to grab it
through a different tree, just say so]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/secretmem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 589b26c2d553..ef4922baa1cd 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -208,7 +208,7 @@ static struct file *secretmem_file_create(unsigned long flags)
 	}
 
 	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
-				 O_RDWR, &secretmem_fops);
+				 O_RDWR | O_LARGEFILE, &secretmem_fops);
 	if (IS_ERR(file))
 		goto err_free_inode;
 
@@ -222,6 +222,8 @@ static struct file *secretmem_file_create(unsigned long flags)
 	inode->i_mode |= S_IFREG;
 	inode->i_size = 0;
 
+	atomic_inc(&secretmem_users);
+
 	return file;
 
 err_free_inode:
@@ -255,9 +257,6 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 		goto err_put_fd;
 	}
 
-	file->f_flags |= O_LARGEFILE;
-
-	atomic_inc(&secretmem_users);
 	fd_install(fd, file);
 	return fd;
 
-- 
2.39.5


