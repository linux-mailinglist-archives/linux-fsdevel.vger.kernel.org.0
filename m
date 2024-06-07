Return-Path: <linux-fsdevel+bounces-21154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9248FF9D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDA1B2293E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EF6383BD;
	Fri,  7 Jun 2024 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fzINSoJX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44417571
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725604; cv=none; b=SM+3Pzh6wQEkFnHEvh63gWgzqBu+hehtxpO0J+2utY83sp/IprnlkiKKN50xenUXhwzCM9GNb/JaL5pfFXiSbz3yfD0GUJw/xPObOsnw9gbJw45OfIQRMhl4zcrE63xcXjkxUVGz/Zz8goG7OrXN5kEdq4gmW7oJQ4/z6VIC6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725604; c=relaxed/simple;
	bh=qukz4BHEcYXyp1h2kV0/LK5dfMpbiNQr3TBvAfV279w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TCU0Ga4eL/2k6Kpe/9J+PrreG23V6K0Z3lLcr9jnCfFfCKWMZ9/C8H0HGmrCC0MKm6RlRkW0hbaboZyfZO8uUhlLeC7Y/rD1/f5aocv3nN8Cei4lOas5VJ+NZczLTyBQwdrT6gwzcQ5ClsTReLALN/j6pNtqwVCm+uCuuBQPCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fzINSoJX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oe5dDGCa/J10fAHEtgbRSO/fXofzw7oNu4MDtF+i+ek=; b=fzINSoJXVG9aW+sF5ym83D55CH
	X0HeRVY6rxw3n75eJHKF8qkpY0BwLIVL08KDejEOVoPsSnM2ucQuzKHz9EDJYSRHJ+1y2mkepgB9N
	tpLsiOB/kKnhoixInccIlikcsagNLMWybLK3cmceAqC8prQ1+vDv0BKkIe2yNeKX5AXSQTUKDMNyA
	z1qXuPbjt0b3L//qYiRjA4ePYi/l2etvxvMBld23IRAiH2s0eXG8+tUPyaodg/aHyPlb4gFCgfpZC
	WeI+jF6GU9uYIkpRm+tvqWfBZQLfcZIHInmtUDoFqB19UpAUyql1XFOeIBVuF6rjcWuC6TkMEHEfk
	NqoYJsPQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOtc-009xCn-1e;
	Fri, 07 Jun 2024 02:00:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 17/19] simplify xfs_find_handle() a bit
Date: Fri,  7 Jun 2024 02:59:55 +0100
Message-Id: <20240607015957.2372428-17-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
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
index bb250f4246b3..ccf87940f264 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -86,22 +86,23 @@ xfs_find_handle(
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
@@ -135,10 +136,7 @@ xfs_find_handle(
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
2.39.2


