Return-Path: <linux-fsdevel+bounces-65854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC82C12771
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 02:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAB75E154E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 00:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5F6342CB8;
	Tue, 28 Oct 2025 00:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="w10996o+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151BF21B9C0;
	Tue, 28 Oct 2025 00:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612388; cv=none; b=B65s3KsfhLdzFnWxZvo6YKNB71zchrrjqU+3fzWUWAQt9fX7IWFwjxkslOP6GBjaz2j+mFvGiF/wi+75Ucq1MImq7qLlsoIcNeJmmOGgDq9Ayq09AJSwHVcuM9uZMwYD0lsGxkKDCCqZdIqApyF4YDWHFkjGeJE7YyALmeAKtOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612388; c=relaxed/simple;
	bh=hvKn4v226vlFPVcEMTmI8vKLyXW8b3xQk740dDR1S7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tavUFj4bilt8Zzb8h3YWY9sXKuScappy1G8leGcCfVAeNW9VTX5tWjPlDJIr1/IYQPfKyHwExA0gVRXdJxIqg7w0GQoCRToeif5yGV7G08WTRdqwDILnPjukg+vK1+NdGQwU85duNLDjyfLsIvEgk0ytVfLXJD241UXH+HGJ6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=w10996o+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aIO5z+XlaxOUN+dxGxWKQXIfyt7HKUVO8xN2mehuHOs=; b=w10996o+4wBACa8wFc2VJLTe4l
	AE6SJfEeRlDJBYm9lG/BAJ2sno1dzvFxIr+TtSNTtBOWzrsOCuWNgNAkAt0vBEbh1UMQG+wJlVBHQ
	sr8OKStPsOoMhX34Qf9DmIY46eYtxaTPX5hENvuK30W7LXSkmdHMOhCs1ztH4929mgSkNcSTduvmQ
	Ra/dafUsYAby60kk2NLpCI2h5RjB+QHXiUdARFd5c+bM2avsNoSpvSX4Qomh81V30TPn/scJZlW+K
	oeoNBr+ZulzfdrkHMiokpoHrOb3j9iKluVu8L+IDFhPH2OH6bFaWMaGGhse1QPURBnFF6IceB3uY/
	fm9paVBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqu-00000001ejA-11In;
	Tue, 28 Oct 2025 00:46:20 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: [PATCH v2 44/50] convert rpc_pipefs
Date: Tue, 28 Oct 2025 00:46:03 +0000
Message-ID: <20251028004614.393374-45-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Just use d_make_persistent() + dput() (and fold the latter into
simple_finish_creating()) and that's it...

NOTE: pipe->dentry is a borrowed reference - it does not contribute
to dentry refcount.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/sunrpc/rpc_pipe.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 0bd1df2ebb47..379daefc4847 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -536,17 +536,16 @@ static int rpc_new_file(struct dentry *parent,
 
 	inode = rpc_get_inode(dir->i_sb, S_IFREG | mode);
 	if (unlikely(!inode)) {
-		dput(dentry);
-		inode_unlock(dir);
+		simple_done_creating(dentry);
 		return -ENOMEM;
 	}
 	inode->i_ino = iunique(dir->i_sb, 100);
 	if (i_fop)
 		inode->i_fop = i_fop;
 	rpc_inode_setowner(inode, private);
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	fsnotify_create(dir, dentry);
-	inode_unlock(dir);
+	simple_done_creating(dentry);
 	return 0;
 }
 
@@ -563,18 +562,17 @@ static struct dentry *rpc_new_dir(struct dentry *parent,
 
 	inode = rpc_get_inode(dir->i_sb, S_IFDIR | mode);
 	if (unlikely(!inode)) {
-		dput(dentry);
-		inode_unlock(dir);
+		simple_done_creating(dentry);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	inode->i_ino = iunique(dir->i_sb, 100);
 	inc_nlink(dir);
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	fsnotify_mkdir(dir, dentry);
-	inode_unlock(dir);
+	simple_done_creating(dentry);
 
-	return dentry;
+	return dentry; // borrowed
 }
 
 static int rpc_populate(struct dentry *parent,
@@ -657,8 +655,7 @@ int rpc_mkpipe_dentry(struct dentry *parent, const char *name,
 
 	inode = rpc_get_inode(dir->i_sb, umode);
 	if (unlikely(!inode)) {
-		dput(dentry);
-		inode_unlock(dir);
+		simple_done_creating(dentry);
 		err = -ENOMEM;
 		goto failed;
 	}
@@ -668,10 +665,10 @@ int rpc_mkpipe_dentry(struct dentry *parent, const char *name,
 	rpci->private = private;
 	rpci->pipe = pipe;
 	rpc_inode_setowner(inode, private);
-	d_instantiate(dentry, inode);
-	pipe->dentry = dentry;
+	pipe->dentry = dentry; // borrowed
+	d_make_persistent(dentry, inode);
 	fsnotify_create(dir, dentry);
-	inode_unlock(dir);
+	simple_done_creating(dentry);
 	return 0;
 
 failed:
@@ -1206,7 +1203,7 @@ static void rpc_kill_sb(struct super_block *sb)
 					   sb);
 	mutex_unlock(&sn->pipefs_sb_lock);
 out:
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 	put_net(net);
 }
 
-- 
2.47.3


