Return-Path: <linux-fsdevel+bounces-25642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E9C94E708
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AB31C21CFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D56015FD08;
	Mon, 12 Aug 2024 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oRIqUiLV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3914EC64
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445071; cv=none; b=FLyRQQglYBjQuhmXFS/z8cSO/b/qK+i1lsyZ11tVYeq/ndjENDjwo/svHYKeWPR2rCfpA5HET0o4LaRfDR0aXAddhzbPHAdbBFeKygdkBbsUMACqtDBJFbW3YFR4T7UkcmhaLB1yuB+dnewCnJmpQLwtQzr4CpNFcZ4KV98nmZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445071; c=relaxed/simple;
	bh=UBt8u6dsKDs4nj9QRUcas17pQBOD/9lbg4mnk6E7eh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNbo9B+gk75DVP98W7iZYvKC+9BMl/46MF8GtpwF2oAD2s+QVJV+BFlJZfZjXhQHZ39syN5VIN2U6v1eqqwVImGjoRdO19E+3RluJb22A/Hzr6+ecOHNsdoMTh4lnT81uiqXNZfgS2e2cXycognaS59YB3FOnFctcvpmxrrWnfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oRIqUiLV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SNRleuGbC5ZjtR+vITaWBkdhY7r+Rw7PevIVgf82NJk=; b=oRIqUiLV3jttyEV8jca8v9lZwJ
	fJ4rtOninuOrriDSaGwKkBEmRbJZgcRnfeHcW47c6Hi3Hs8NeKeRlJAnTX/kyV/0d9VMWiCAgQT5p
	xEj7zWlInjroB6pw87U8GRPgp8EbLcbiqhSXDgi+bprni7ev9nwaFD+v7OarPZT+0JzoQtDjwWYTM
	+ODQKaLIsfXV5ijEUHQ+N1Hk72zX4Qac2c+ctWGI/6OLiNtiKkkya8YyodpJzby+huXNdU/WD6g0v
	IwNX8ZP3NxnszHqlo8SSfuN2vsgpXoZlwuXGNAp9Y6HHJ2yNR5XNlRfwDiOtuL4P18TT2oVwbOGSy
	1krT2nrw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdOn5-000000010UP-3uU9;
	Mon, 12 Aug 2024 06:44:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/11] proc_fd_getattr(): don't bother with S_ISDIR() check
Date: Mon, 12 Aug 2024 07:44:20 +0100
Message-ID: <20240812064427.240190-4-viro@zeniv.linux.org.uk>
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

that thing is callable only as ->i_op->getattr() instance and only
for directory inodes (/proc/*/fd and /proc/*/task/*/fd)

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/proc/fd.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 077c51ba1ba7..f3c5767db3d4 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -351,18 +351,9 @@ static int proc_fd_getattr(struct mnt_idmap *idmap,
 			u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
-	int rv = 0;
 
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-
-	/* If it's a directory, put the number of open fds there */
-	if (S_ISDIR(inode->i_mode)) {
-		rv = proc_readfd_count(inode, &stat->size);
-		if (rv < 0)
-			return rv;
-	}
-
-	return rv;
+	return proc_readfd_count(inode, &stat->size);
 }
 
 const struct inode_operations proc_fd_inode_operations = {
-- 
2.39.2


