Return-Path: <linux-fsdevel+bounces-51564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C98EAD842D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6483A2197
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBA52E6112;
	Fri, 13 Jun 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oOgOfpJa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCE12D8DAE;
	Fri, 13 Jun 2025 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800077; cv=none; b=KGeLRtr5eYBlaH3eQJ+r0em6yFsqlqqS+lvUKipIMERSqhutqmeSSv7FdaNRRiinq3/SRDw27XyD3stY7tPJLyaMFKQvOddAPeS/MVcBIWIPCjo8tmo3KnVhNpJMJ1L3fAggoMS6kIv0QSIKHsaMWV/zCC2b8xlPlkR5JyiVlNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800077; c=relaxed/simple;
	bh=dTiNSgThItZecnP137uptNA5NvevIEF9N/hciizudmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETvdPv8IbpSTQY6EQ2yAp9s9ee7dMaXbVJl0KjHAJ+6CaN5rHAXUcQl6oxt4ifOh1bVl4Cyldg8EAvo5DwZ8SleTz9GgphnzFUWmAsAkbMx0FM0O1Pu6YKnYxLp7sFkuJ4G5TNpw+OwP9K2tmd3WaKCaRZ7sPAPGNNNaZdamN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oOgOfpJa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BeDUitGQM7v9elzOJiSTo/Qy2tJV8QNbdb20/rJTc7E=; b=oOgOfpJaDWk3UiRFq3ec1pqCgr
	6XQGUMok+w4WzOxsYDWfC5w+GD+UqHmOX1BXiebRALRAqkIslfhMyV4lSRRRmkp0W2K1J5aVOSGXf
	SQGIwNppMoopPGCH1zwJQSaPHY/oa3ESaVZOIJM7KASeudlV1ECpHqrK7Au72m5QYoSNDVGk9Vjt4
	CXNd1CPZaxRvVpYYCm4GzwS/cYd2T+dF+duLOJbC85CUuy+wpw5V9//gpo8FdTeZ9RqFCGT+ItzW0
	+fcoH4rvqYsXBzb/HCqLhFNRvSDZsNh1az0dRsDFFB+3DF6MplfQRZxhgzx9OhTrbiOXfh8nbmeKb
	NtTZYyng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvq-00000007qqL-0ldv;
	Fri, 13 Jun 2025 07:34:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 10/17] rpc_pipe: saner primitive for creating subdirectories
Date: Fri, 13 Jun 2025 08:34:25 +0100
Message-ID: <20250613073432.1871345-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
References: <20250613073149.GI1647736@ZenIV>
 <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

All users of __rpc_mkdir() have the same form - start_creating(),
followed, in case of success, by __rpc_mkdir() and unlocking parent.

Combine that into a single helper, expanding __rpc_mkdir() into it,
along with the call of __rpc_create_common() in it.

Don't mess with d_drop() + d_add() - just d_instantiate() and be
done with that.  The reason __rpc_create_common() goes for that
dance is that dentry it gets might or might not be hashed; here
we know it's hashed.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/sunrpc/rpc_pipe.c | 67 +++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index a61c1173738c..c3f269aadcaf 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -524,21 +524,6 @@ static int __rpc_create(struct inode *dir, struct dentry *dentry,
 	return 0;
 }
 
-static int __rpc_mkdir(struct inode *dir, struct dentry *dentry,
-		       umode_t mode,
-		       const struct file_operations *i_fop,
-		       void *private)
-{
-	int err;
-
-	err = __rpc_create_common(dir, dentry, S_IFDIR | mode, i_fop, private);
-	if (err)
-		return err;
-	inc_nlink(dir);
-	fsnotify_mkdir(dir, dentry);
-	return 0;
-}
-
 static void
 init_pipe(struct rpc_pipe *pipe)
 {
@@ -594,6 +579,35 @@ static int __rpc_mkpipe_dentry(struct inode *dir, struct dentry *dentry,
 	return 0;
 }
 
+static struct dentry *rpc_new_dir(struct dentry *parent,
+				  const char *name,
+				  umode_t mode,
+				  void *private)
+{
+	struct dentry *dentry = simple_start_creating(parent, name);
+	struct inode *dir = parent->d_inode;
+	struct inode *inode;
+
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode = rpc_get_inode(dir->i_sb, S_IFDIR | mode);
+	if (unlikely(!inode)) {
+		dput(dentry);
+		inode_unlock(dir);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	inode->i_ino = iunique(dir->i_sb, 100);
+	rpc_inode_setowner(inode, private);
+	inc_nlink(dir);
+	d_instantiate(dentry, inode);
+	fsnotify_mkdir(dir, dentry);
+	inode_unlock(dir);
+
+	return dentry;
+}
+
 static int rpc_populate(struct dentry *parent,
 			const struct rpc_filelist *files,
 			int start, int eof,
@@ -604,14 +618,14 @@ static int rpc_populate(struct dentry *parent,
 	int i, err;
 
 	for (i = start; i < eof; i++) {
-		dentry = simple_start_creating(parent, files[i].name);
-		err = PTR_ERR(dentry);
-		if (IS_ERR(dentry))
-			goto out_bad;
 		switch (files[i].mode & S_IFMT) {
 			default:
 				BUG();
 			case S_IFREG:
+				dentry = simple_start_creating(parent, files[i].name);
+				err = PTR_ERR(dentry);
+				if (IS_ERR(dentry))
+					goto out_bad;
 				err = __rpc_create(dir, dentry,
 						files[i].mode,
 						files[i].i_fop,
@@ -619,11 +633,13 @@ static int rpc_populate(struct dentry *parent,
 				inode_unlock(dir);
 				break;
 			case S_IFDIR:
-				err = __rpc_mkdir(dir, dentry,
+				dentry = rpc_new_dir(parent,
+						files[i].name,
 						files[i].mode,
-						NULL,
 						private);
-				inode_unlock(dir);
+				err = PTR_ERR(dentry);
+				if (IS_ERR(dentry))
+					goto out_bad;
 		}
 		if (err != 0)
 			goto out_bad;
@@ -640,16 +656,11 @@ static struct dentry *rpc_mkdir_populate(struct dentry *parent,
 		int (*populate)(struct dentry *, void *), void *args_populate)
 {
 	struct dentry *dentry;
-	struct inode *dir = d_inode(parent);
 	int error;
 
-	dentry = simple_start_creating(parent, name);
+	dentry = rpc_new_dir(parent, name, mode, private);
 	if (IS_ERR(dentry))
 		return dentry;
-	error = __rpc_mkdir(dir, dentry, mode, NULL, private);
-	inode_unlock(dir);
-	if (error != 0)
-		return ERR_PTR(error);
 	if (populate != NULL) {
 		error = populate(dentry, args_populate);
 		if (error) {
-- 
2.39.5


