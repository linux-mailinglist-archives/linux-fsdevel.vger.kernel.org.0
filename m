Return-Path: <linux-fsdevel+bounces-51562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF20AD8433
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5174D189B961
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F0F2E3395;
	Fri, 13 Jun 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="szGlC0Ux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9E2DECB2;
	Fri, 13 Jun 2025 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800077; cv=none; b=fZmg2mspkCNI1ZaFVBbAVTOldgoDUQ5DaPdgMorOeFOiSJ4HO4Rg/V0GdscZmVGrJNET/ln7pZ2HWiFLEKagaTjsbXwcIZU+TshyF4NoJPTpaUMHMf9jkJhKKRWRl0AGdSgWaHCnHPQqMpoP7YZcb/i/ZZ/bYAEM6qYIW/s/cyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800077; c=relaxed/simple;
	bh=nDBXpQ5NCa+DjE2FWh3I+CuMyHcWah+WadKz9dd5ES8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j056vonWoLmGKeZ1UdOicZJlewTZUzjsybIoPXBdvbf9hVLp+2Q04QhUqU32rrC9XWREHbwVagKJvajBTYX3KYJc9ChJXmzIo9VYJ9DGwz6BwtDe2C8jP7Pu8+hMXpr6pZn5csEQkkcntUdjc8Y6x+oxECmITpVTi3PxJszNFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=szGlC0Ux; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=e3+1TGMQb4mue+l+D2rsnmyH2dtFbX4Elku0NC2LJJI=; b=szGlC0Uxz8iok+ClB3CTgUVcw7
	078oD2yivMaPyzwVTUuqV9N2DH6MOrA9voLOQzxVDzo9HGWv1eb7z8XiLlqe6NlUG9Ih/88f5fEd5
	xnHand1KfHVls/iycIcxPFbFd+rbyNntgBThRvaY/mnQXHQCa4/OyxAsmjzAuPs6PyhKHq/2UGHMg
	5prbY275A/Xx9grJITXcXJqSb06yX8ogncIuKrK9YRRAWXsFxjKE2ljx1PCl7RBkVr1LCNHFTabDR
	2E0uzk4DbvrjYrSwmuluw1vA3qC0Tb3KUrDO7/DlanENj24ica9VjoZQctAEZsAxjAapTkEfV+mJf
	e6MqQg2w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvq-00000007qqS-0zOG;
	Fri, 13 Jun 2025 07:34:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 11/17] rpc_pipe: saner primitive for creating regular files
Date: Fri, 13 Jun 2025 08:34:26 +0100
Message-ID: <20250613073432.1871345-11-viro@zeniv.linux.org.uk>
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

rpc_new_file(); similar to rpc_new_dir(), except that here we pass
file_operations as well.  Callers don't care about dentry, just
return 0 or -E...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/sunrpc/rpc_pipe.c | 61 +++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index c3f269aadcaf..8f88c75c9b30 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -510,20 +510,6 @@ static int __rpc_create_common(struct inode *dir, struct dentry *dentry,
 	return -ENOMEM;
 }
 
-static int __rpc_create(struct inode *dir, struct dentry *dentry,
-			umode_t mode,
-			const struct file_operations *i_fop,
-			void *private)
-{
-	int err;
-
-	err = __rpc_create_common(dir, dentry, S_IFREG | mode, i_fop, private);
-	if (err)
-		return err;
-	fsnotify_create(dir, dentry);
-	return 0;
-}
-
 static void
 init_pipe(struct rpc_pipe *pipe)
 {
@@ -579,6 +565,35 @@ static int __rpc_mkpipe_dentry(struct inode *dir, struct dentry *dentry,
 	return 0;
 }
 
+static int rpc_new_file(struct dentry *parent,
+			   const char *name,
+			   umode_t mode,
+			   const struct file_operations *i_fop,
+			   void *private)
+{
+	struct dentry *dentry = simple_start_creating(parent, name);
+	struct inode *dir = parent->d_inode;
+	struct inode *inode;
+
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	inode = rpc_get_inode(dir->i_sb, S_IFREG | mode);
+	if (unlikely(!inode)) {
+		dput(dentry);
+		inode_unlock(dir);
+		return -ENOMEM;
+	}
+	inode->i_ino = iunique(dir->i_sb, 100);
+	if (i_fop)
+		inode->i_fop = i_fop;
+	rpc_inode_setowner(inode, private);
+	d_instantiate(dentry, inode);
+	fsnotify_create(dir, dentry);
+	inode_unlock(dir);
+	return 0;
+}
+
 static struct dentry *rpc_new_dir(struct dentry *parent,
 				  const char *name,
 				  umode_t mode,
@@ -613,7 +628,6 @@ static int rpc_populate(struct dentry *parent,
 			int start, int eof,
 			void *private)
 {
-	struct inode *dir = d_inode(parent);
 	struct dentry *dentry;
 	int i, err;
 
@@ -622,27 +636,24 @@ static int rpc_populate(struct dentry *parent,
 			default:
 				BUG();
 			case S_IFREG:
-				dentry = simple_start_creating(parent, files[i].name);
-				err = PTR_ERR(dentry);
-				if (IS_ERR(dentry))
-					goto out_bad;
-				err = __rpc_create(dir, dentry,
+				err = rpc_new_file(parent,
+						files[i].name,
 						files[i].mode,
 						files[i].i_fop,
 						private);
-				inode_unlock(dir);
+				if (err)
+					goto out_bad;
 				break;
 			case S_IFDIR:
 				dentry = rpc_new_dir(parent,
 						files[i].name,
 						files[i].mode,
 						private);
-				err = PTR_ERR(dentry);
-				if (IS_ERR(dentry))
+				if (IS_ERR(dentry)) {
+					err = PTR_ERR(dentry);
 					goto out_bad;
+				}
 		}
-		if (err != 0)
-			goto out_bad;
 	}
 	return 0;
 out_bad:
-- 
2.39.5


