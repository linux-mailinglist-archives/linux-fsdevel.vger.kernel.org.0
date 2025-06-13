Return-Path: <linux-fsdevel+bounces-51565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD584AD8437
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E20189B54C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6F42E610A;
	Fri, 13 Jun 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="siRuDdHc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E72F2D8DB1;
	Fri, 13 Jun 2025 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800078; cv=none; b=Qhh3nMaBto4Gon1Emqu2JPtO0lTTMgI1qMxCmRNVS/QdymbqQUvU3/x+p7r2pyeH4LdhMieIKVh34z6UJI4skrn8joaM9+hy/jWmif3vHXHswIeISwG/ZxgtSonLXtcbM3zEmnrH7E+hYUwX3yzZWzKi4uFv1UHxxq6ezEBEoVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800078; c=relaxed/simple;
	bh=wdXWpFOatLjdWqlca8dGwPt2EXAw/wiCY/0oCvMwnxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RERV1IB2/y9RYttF8yOAFs0NpvS35TC7StDkvG76LWa/67pW2mZ9Lyh2l405SD4ahtsn4CWKMo55qHGncZpyEYvjvLEh5ISk/LtfaVHieILzd1vGrkVuAdKxCxqrQNKvJ6a7YVxXtlPGstwhy/Dq5JTpuDG+/7bvBDs9MqKdrmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=siRuDdHc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SzKs44alqNGAJ3kFgYs8fo+7Wy1bSYSoSaOe36CWM88=; b=siRuDdHc4PES8uBXs3aYWjZVhG
	Ql27fYcpl+Af0yt+P7sncyy5hZAfwWViGvytxN095e2QyNjOW8QCDAt5tqdoFmQHQFzEyFWC/7bT9
	cPZmF05U3BeRf4k/vEkVu4LDvkhbjUKFslRCQq1zR+yQBwU7dKx8aH6MqACqNkXwa8jgkFG5Jw0Ny
	GAucTxMHG1YtGE44xQ8Kfa3U10w+ihA+8W6jqtD0J7DsFeQAw1P1a6uuFiy3pKrTpD52S7N0nicvM
	b5SljHp6tfhy1t9hpwdl+9/OyvgReMPZmhayt86xUkbm+/adduCYiFFTacWmJfmFx+U5dkCplNgPM
	oJ2ZEMTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvq-00000007qqA-07Hl;
	Fri, 13 Jun 2025 07:34:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 09/17] rpc_pipe: don't overdo directory locking
Date: Fri, 13 Jun 2025 08:34:24 +0100
Message-ID: <20250613073432.1871345-9-viro@zeniv.linux.org.uk>
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

Don't try to hold directories locked more than VFS requires;
lock just before getting a child to be made positive (using
simple_start_creating()) and unlock as soon as the child is
created.  There's no benefit in keeping the parent locked
while populating the child - it won't stop dcache lookups anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/sunrpc/rpc_pipe.c | 44 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 35 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index dac1c35a642f..a61c1173738c 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -594,22 +594,6 @@ static int __rpc_mkpipe_dentry(struct inode *dir, struct dentry *dentry,
 	return 0;
 }
 
-static struct dentry *__rpc_lookup_create_exclusive(struct dentry *parent,
-					  const char *name)
-{
-	struct qstr q = QSTR(name);
-	struct dentry *dentry = try_lookup_noperm(&q, parent);
-	if (!dentry) {
-		dentry = d_alloc(parent, &q);
-		if (!dentry)
-			return ERR_PTR(-ENOMEM);
-	}
-	if (d_really_is_negative(dentry))
-		return dentry;
-	dput(dentry);
-	return ERR_PTR(-EEXIST);
-}
-
 static int rpc_populate(struct dentry *parent,
 			const struct rpc_filelist *files,
 			int start, int eof,
@@ -619,9 +603,8 @@ static int rpc_populate(struct dentry *parent,
 	struct dentry *dentry;
 	int i, err;
 
-	inode_lock(dir);
 	for (i = start; i < eof; i++) {
-		dentry = __rpc_lookup_create_exclusive(parent, files[i].name);
+		dentry = simple_start_creating(parent, files[i].name);
 		err = PTR_ERR(dentry);
 		if (IS_ERR(dentry))
 			goto out_bad;
@@ -633,20 +616,20 @@ static int rpc_populate(struct dentry *parent,
 						files[i].mode,
 						files[i].i_fop,
 						private);
+				inode_unlock(dir);
 				break;
 			case S_IFDIR:
 				err = __rpc_mkdir(dir, dentry,
 						files[i].mode,
 						NULL,
 						private);
+				inode_unlock(dir);
 		}
 		if (err != 0)
 			goto out_bad;
 	}
-	inode_unlock(dir);
 	return 0;
 out_bad:
-	inode_unlock(dir);
 	printk(KERN_WARNING "%s: %s failed to populate directory %pd\n",
 			__FILE__, __func__, parent);
 	return err;
@@ -660,27 +643,21 @@ static struct dentry *rpc_mkdir_populate(struct dentry *parent,
 	struct inode *dir = d_inode(parent);
 	int error;
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-	dentry = __rpc_lookup_create_exclusive(parent, name);
+	dentry = simple_start_creating(parent, name);
 	if (IS_ERR(dentry))
-		goto out;
+		return dentry;
 	error = __rpc_mkdir(dir, dentry, mode, NULL, private);
+	inode_unlock(dir);
 	if (error != 0)
-		goto out_err;
+		return ERR_PTR(error);
 	if (populate != NULL) {
 		error = populate(dentry, args_populate);
 		if (error) {
-			inode_unlock(dir);
 			simple_recursive_removal(dentry, NULL);
 			return ERR_PTR(error);
 		}
 	}
-out:
-	inode_unlock(dir);
 	return dentry;
-out_err:
-	dentry = ERR_PTR(error);
-	goto out;
 }
 
 /**
@@ -715,12 +692,9 @@ int rpc_mkpipe_dentry(struct dentry *parent, const char *name,
 	if (pipe->ops->downcall == NULL)
 		umode &= ~0222;
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-	dentry = __rpc_lookup_create_exclusive(parent, name);
-	if (IS_ERR(dentry)) {
-		inode_unlock(dir);
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
-	}
 	err = __rpc_mkpipe_dentry(dir, dentry, umode, &rpc_pipe_fops,
 				  private, pipe);
 	if (unlikely(err))
-- 
2.39.5


