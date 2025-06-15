Return-Path: <linux-fsdevel+bounces-51676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A02ADA069
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 02:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788F71892317
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 00:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553341BF58;
	Sun, 15 Jun 2025 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ViJ+pXKr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0651DFE1
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jun 2025 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749947604; cv=none; b=Uy2ol/XjGIrL/eDeZZqszKFeoS+Xp2vKZkOHC5KTVUoVzrcu0X58F9qOAV6nwlt6snOUlUK9P1TrDBNguzCv0LKXQ1dIg4y+lCqZSkClWWW0M7ql08EDAotjAyScov4PNDx4SZdAlEp9eH8T64n/RsK9pCiYvaCrsSHIKFNjeHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749947604; c=relaxed/simple;
	bh=m+fRlKrZZt+aZ29VSnTblJDLLPhTrqF2D9C/c+cfU0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xo/0E534fn/nu0VHM7VE56v4ssE6thkaZROw11ZkpNHmF5HaZYSpJgMYoENL3aRGQcBUup1tvYAeA7IqewD2SdzhxoyquJuSXuyHKYr1W2lvO/G03WC2iKp+3fPLNH6YJNEEyyh20dtt7Zw7O07Xpd51xoViMn33GHwEO9ZLBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ViJ+pXKr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UvIn0oanOH/N6DTff1aC2/9zjRR3BgvryeM/yTAPRo4=; b=ViJ+pXKrWKbhZQJ/a8tkub6efC
	hVW9zjcHT2zKVLiOqQhKnpUrhbSYzcErXI0WVieDLlRbhjloV3Gfcw/be4cjtP2uMUhMZ0UtpaPBt
	ZxVoSmAHBxWGDPezTtVKgWTHU6BkLALM9mPNMPD2zYVRXghMYkmrEfbcqp2IXKgOcYKDQJjaWetTE
	bmGW2TPHW6M/b25gKc7giA6RrmVqhHmwcYrP6l2N0Jn1dY2qCD60gwNY/G0wm8oPV7TJGvUt7U/Fk
	1hDT+19zRJI1oqKiak8goinF6XMTnDay4c8lDe/xuyaDfKghR6yjExEn6WmMpiQ2p3b6OzYYyFcdh
	mojnsYIw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQbJJ-0000000CfGF-2Asf;
	Sun, 15 Jun 2025 00:33:21 +0000
Date: Sun, 15 Jun 2025 01:33:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Subject: [PATCH] proc_fd_getattr(): don't bother with S_ISDIR() check
Message-ID: <20250615003321.GC3011112@ZenIV>
References: <20250615003011.GD1880847@ZenIV>
 <20250615003110.GA3011112@ZenIV>
 <20250615003216.GB3011112@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615003216.GB3011112@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[don't really care which tree that goes through; right now it's
in viro/vfs.git #work.misc, but if somebody prefers to grab it
through a different tree, just say so]

that thing is callable only as ->i_op->getattr() instance and only
for directory inodes (/proc/*/fd and /proc/*/task/*/fd)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/proc/fd.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 37aa778d1af7..9eeccff49b2a 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -352,18 +352,9 @@ static int proc_fd_getattr(struct mnt_idmap *idmap,
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
2.39.5


