Return-Path: <linux-fsdevel+bounces-60980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AD7B53ECF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 00:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2201C24116
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 22:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C777D2F5482;
	Thu, 11 Sep 2025 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="d6rCc6Is"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3B23BD02;
	Thu, 11 Sep 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757630793; cv=none; b=ELOL0ajP1GJ5ZskrlXykAboyB49UuukODVNAzG+mKKU4NAJxkojvEOgC2IOKK5TUlfu/FidS7/eiURBiWBVGIgj5nAy0p2cqUu3+dHN8KXqsoc8b17A0hTIRefPMq4FgbI7cpXNLAqfZphul41Er92fT42vkTx9uOOwxYo/e6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757630793; c=relaxed/simple;
	bh=L1ijgZIWyS3JyuRzSU931ad2FvK2A1V1AUrD5GsJjZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuVbXOsQerAJ9FYnrZe5VeUtp72bHXmHQtnDzO3fmYSAslgB0N72xzPPVr/5ekpw7Vt/EPsT4ItXGPir59uDp/ubaeRVw87BoPaqh7cgv4/2ixzOOCGEORC8Kqq6vTbR8bDAelghR+qKlRsWaLsdPkT/an2nAhSbenicaAGiGNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=d6rCc6Is; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7FH3XVCFHeGOZjm2Sy0EqJnWmvpOd8X9pa6ceHadPCs=; b=d6rCc6Isu6tdUGUacIbXT6LkGY
	hRIsqM8pfwIgIm/CrEOCLGARSI8vAfugZkXziCDhnnq5URpkQhdGynFO45WAKCfapG7u3zH9PPk3D
	oeUz1mkCKxIr2wPNgnKa1TUXtT1fsICOjKAbDsFMnzNaT4oZfNzzNLvtwRn5lkYHsuo03/VtDiRDh
	5nwDuoD/CCWza3ASX52P1ApM2vftOaoxqf4t9rLNInSSlr9Wcbk9jwcSuf2nawEc2JFUkLkovFebn
	5lD0ycK/4ZxGERlQmq+ChbFScwvILOK5DUBYH771QSX2KlP1KPfCVn3uCHIc0EdSVW5FFPHIaTUQl
	AheZqVVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwq3h-00000006g3C-0hOb;
	Thu, 11 Sep 2025 22:46:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org,
	jlayton@kernel.org,
	neil@brown.name
Subject: [PATCH 5/5] nfsd_get_inode(): lift setting ->i_{,f}op to callers.
Date: Thu, 11 Sep 2025 23:46:28 +0100
Message-ID: <20250911224628.1591565-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911224628.1591565-1-viro@zeniv.linux.org.uk>
References: <20250911224429.GX39973@ZenIV>
 <20250911224628.1591565-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfsctl.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 6deabe359a80..c19a74a36c45 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1103,27 +1103,14 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
  *	populating the filesystem.
  */
 
-/* Basically copying rpc_get_inode. */
 static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
 {
 	struct inode *inode = new_inode(sb);
-	if (!inode)
-		return NULL;
-	/* Following advice from simple_fill_super documentation: */
-	inode->i_ino = iunique(sb, NFSD_MaxReserved);
-	inode->i_mode = mode;
-	simple_inode_init_ts(inode);
-	switch (mode & S_IFMT) {
-	case S_IFDIR:
-		inode->i_fop = &simple_dir_operations;
-		inode->i_op = &simple_dir_inode_operations;
-		inc_nlink(inode);
-		break;
-	case S_IFLNK:
-		inode->i_op = &simple_symlink_inode_operations;
-		break;
-	default:
-		break;
+	if (inode) {
+		/* Following advice from simple_fill_super documentation: */
+		inode->i_ino = iunique(sb, NFSD_MaxReserved);
+		inode->i_mode = mode;
+		simple_inode_init_ts(inode);
 	}
 	return inode;
 }
@@ -1143,6 +1130,9 @@ static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_client *nc
 		iput(inode);
 		return dentry;
 	}
+	inode->i_fop = &simple_dir_operations;
+	inode->i_op = &simple_dir_inode_operations;
+	inc_nlink(inode);
 	if (ncl) {
 		inode->i_private = ncl;
 		kref_get(&ncl->cl_ref);
@@ -1176,6 +1166,7 @@ static void _nfsd_symlink(struct dentry *parent, const char *name,
 		return;
 	}
 
+	inode->i_op = &simple_symlink_inode_operations;
 	inode->i_link = (char *)content;
 	inode->i_size = strlen(content);
 
-- 
2.47.2


