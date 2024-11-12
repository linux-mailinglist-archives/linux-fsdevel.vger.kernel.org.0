Return-Path: <linux-fsdevel+bounces-34551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE19C62D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4BBABC61F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2742721C165;
	Tue, 12 Nov 2024 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="E7+8jNkp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1043B21B44A
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443200; cv=none; b=sZ8ElDpT29lho107GVytytzsIUtqpgcc6F/NerOBpae6sffmUpi1XNuOQ+2akwrxeKDfIN4cMK3Cy5moVuRYWv2KHmTr172AxrmL0rLeYG+H5M+pHX1iGA8eMQMN93vm66IxFFraq1iaJeCShGSPmoscCbRPJfDW0wAECl2H8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443200; c=relaxed/simple;
	bh=GQXLcBOEw2jJECfb1qXu1BWYALW1j5mQH7CNElj6mUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITD/lbeHAc6zri8w+5O6fbTXQqtOqhgMokhXlXy2jlXLbbQllAgz/eCRZiQCrMRWK8XmiW7tLt4Gooj/MMsSmv2PwWM9DUQL8JC8NDthdLWmZQW4iRf5qz1O1HqoGB5IrlpOZGF4Mlb+VOSpqZHkzfHIlNNWUxuBpI8L66Wqahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=E7+8jNkp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=e4KgWI985IxAuGWwpcXk8SKPdzusVHJXdHLzTuAKkK0=; b=E7+8jNkp7nwOYeBuC+/CuhDHyF
	4S80HJDDnDUs3BVrhLdDDyYNEDdJJTuCkCMyjy/DYURxMEAIBeqLFEmsL+YYiEpBbxwNFly/HotkN
	OECRahUY+s+h1GDDcXJkPt8o4BJBg/wqzpUORUraVmsMTN/jJmtAGaPKhdWPHblqlUWAG4fP6vnzz
	FBV7aYEHlJZC7PP1Uv9Nx/FtesF2AA6tVEjy/6du98XjzGytECAXITV42utGg5KOYTv3EqpZdGkIC
	feqUHFZUGEp7PVLnFPlUv1CXfJvwPxCLARMB5236fZ89+kJmVbqR3WydK+hGasVTJfX7lpb6QEfC2
	kUFVsm2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAxTB-0000000EEuO-243V;
	Tue, 12 Nov 2024 20:26:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] libfs: kill empty_dir_getattr()
Date: Tue, 12 Nov 2024 20:25:52 +0000
Message-ID: <20241112202552.3393751-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
References: <20241112202118.GA3387508@ZenIV>
 <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

It's used only to initialize ->getattr in one inode_operations instance
(empty_dir_inode_operations) and its behaviour had always been equivalent
to what we get with NULL ->getattr.

Just remove that initializer, along with empty_dir_getattr() itself.
While we are at it, the same instance has ->permission initialized to
generic_permission, which is what NULL ->permission ends up doing.
Again, no point keeping it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/libfs.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 46966fd8bcf9..12f5185f3fa9 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1711,15 +1711,6 @@ static struct dentry *empty_dir_lookup(struct inode *dir, struct dentry *dentry,
 	return ERR_PTR(-ENOENT);
 }
 
-static int empty_dir_getattr(struct mnt_idmap *idmap,
-			     const struct path *path, struct kstat *stat,
-			     u32 request_mask, unsigned int query_flags)
-{
-	struct inode *inode = d_inode(path->dentry);
-	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-	return 0;
-}
-
 static int empty_dir_setattr(struct mnt_idmap *idmap,
 			     struct dentry *dentry, struct iattr *attr)
 {
@@ -1733,9 +1724,7 @@ static ssize_t empty_dir_listxattr(struct dentry *dentry, char *list, size_t siz
 
 static const struct inode_operations empty_dir_inode_operations = {
 	.lookup		= empty_dir_lookup,
-	.permission	= generic_permission,
 	.setattr	= empty_dir_setattr,
-	.getattr	= empty_dir_getattr,
 	.listxattr	= empty_dir_listxattr,
 };
 
-- 
2.39.5


