Return-Path: <linux-fsdevel+bounces-33518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4299B9CEF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85C8B20F91
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F5E16F265;
	Sat,  2 Nov 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Xwsxx4TZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51FB14831E;
	Sat,  2 Nov 2024 05:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524112; cv=none; b=XnwRTHH5DIVeehbWnhKWIUTIUTIGrx3MzkWO6VnLN8mC+STCjqLKvCULcSTKYbo3k0jlRipnbWmzOz285yNCaWEZoczrtGkDRKCUTazNiV6E91G0+HQXVFgxMLqdYXAVUD3eRoB1PKboUbb0vZ2YUg9HVz4bSFcOs+ErQYpYGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524112; c=relaxed/simple;
	bh=b3BJpJBrh+RANTDXsCVL0TCetF0F8Vk/L4xWX0jCIKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8ZWNH6vqR4gAfqOhUSBrc1erCiGJAkrATfNO99codWVXENRd0mq3gq/7EdmAcB+skfH3xsvrGu45eeMHVjs38hT5bLHHAzgE2DYKG+n6o45VtZEjA8zZIvzZiC7Er7FA67ZcKx+Mo+xsafkVuJ1JSAfMTqHgctCIU0PZbshrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Xwsxx4TZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=a4BBc2dEfgcXLzqlqbXv5jXPxT+m2hJvqfQvxFNLGlY=; b=Xwsxx4TZTGJlKlFtS/tdF5u4mr
	5vPa5oVUE3NSqB5Ku/MoXM1uHyJcNXaMNDQZ3QXs36V2u4LlxprZuZgnlanTd7N5qhv3h26Qht1jO
	pz8SRHGsKFUWixtOcFdkJ8Xyd2ByY6gdzKlmdD7U8CUPJKO/+WNajTwuFRFFRRYgWaAlPiUI5HQyS
	0PDVT0Ninr0BfYSitQh1qmtboZZ+myKVOHJvnuW9218BnBhHuiUBTAgW3gd3uCB4F8sbI01GszTdw
	IR/Wz5PKCEHjwKtihAVhyukfukg3SrdD7XH+2quRO7gXYnHirTBx3DQZDTr6+cc0cHJMo9/ijZanL
	0Y0+zKLA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NA-0000000AHmQ-0czI;
	Sat, 02 Nov 2024 05:08:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 08/28] simplify xfs_find_handle() a bit
Date: Sat,  2 Nov 2024 05:08:06 +0000
Message-ID: <20241102050827.2451599-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

XFS_IOC_FD_TO_HANDLE can grab a reference to copied ->f_path and
let the file go; results in simpler control flow - cleanup is
the same for both "by descriptor" and "by pathname" cases.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/xfs/xfs_handle.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index 49e5e5f04e60..f19fce557354 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -85,22 +85,23 @@ xfs_find_handle(
 	int			hsize;
 	xfs_handle_t		handle;
 	struct inode		*inode;
-	struct fd		f = EMPTY_FD;
 	struct path		path;
 	int			error;
 	struct xfs_inode	*ip;
 
 	if (cmd == XFS_IOC_FD_TO_HANDLE) {
-		f = fdget(hreq->fd);
-		if (!fd_file(f))
+		CLASS(fd, f)(hreq->fd);
+
+		if (fd_empty(f))
 			return -EBADF;
-		inode = file_inode(fd_file(f));
+		path = fd_file(f)->f_path;
+		path_get(&path);
 	} else {
 		error = user_path_at(AT_FDCWD, hreq->path, 0, &path);
 		if (error)
 			return error;
-		inode = d_inode(path.dentry);
 	}
+	inode = d_inode(path.dentry);
 	ip = XFS_I(inode);
 
 	/*
@@ -134,10 +135,7 @@ xfs_find_handle(
 	error = 0;
 
  out_put:
-	if (cmd == XFS_IOC_FD_TO_HANDLE)
-		fdput(f);
-	else
-		path_put(&path);
+	path_put(&path);
 	return error;
 }
 
-- 
2.39.5


