Return-Path: <linux-fsdevel+bounces-6560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AD5819813
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3A928841E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49D7DDC6;
	Wed, 20 Dec 2023 05:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XiEp+VQT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25316CA41
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 05:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=naGbgEwPmhlREwG0QtHCyePUhb8k3nSlMHrLIeAahoU=; b=XiEp+VQT/iAVSYwB6zmpYcPLMu
	1NwmlXQ+6kie7mS0s59Qb3W5X2iQ9F+i2KjLx5L42FO5lZC77nMFqBjnLcTZ6d0TDGIPvPox8NFFG
	sFSf20+twLx9ARYlgzvVY4nbbgQiJHk+wt8PZRYkuWR1IdYbdGU9HNWb7lOUov7g8jbwfMNyqPzio
	rHjzSHV88bgdOL8wy4pyxjbvuGzfbQNoEXagsQcNFEPs0whfvMXzUHtEoevX5Y6abNWrMRY9RDR61
	xOFoS0GLJGc5u4dgWJka0vFnMuiE+GJ04oCfRFbxNmpa86K/vcnK7dr6lie0rk15vFkTTKkkp039p
	Rd4xUgBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFp5M-00HJ8S-1W;
	Wed, 20 Dec 2023 05:25:36 +0000
Date: Wed, 20 Dec 2023 05:25:36 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: "Tigran A. Aivazian" <aivazian.tigran@gmail.com>
Subject: [PATCH 13/22] bfs_add_entry(): get rid of pointless ->d_name.len
 checks
Message-ID: <20231220052536.GL1674809@ZenIV>
References: <20231220051348.GY1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220051348.GY1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

First of all, any dentry getting here would have passed bfs_lookup(),
so it it passed ENAMETOOLONG check there, there's no need to
repeat it.  And we are not going to get dentries with zero name length -
that check ultimately comes from ext2 and it's as pointless here as it
used to be there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/bfs/dir.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index fbc4ae80a4b2..c375e22c4c0c 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -275,11 +275,6 @@ static int bfs_add_entry(struct inode *dir, const struct qstr *child, int ino)
 
 	dprintf("name=%s, namelen=%d\n", name, namelen);
 
-	if (!namelen)
-		return -ENOENT;
-	if (namelen > BFS_NAMELEN)
-		return -ENAMETOOLONG;
-
 	sblock = BFS_I(dir)->i_sblock;
 	eblock = BFS_I(dir)->i_eblock;
 	for (block = sblock; block <= eblock; block++) {
-- 
2.39.2


