Return-Path: <linux-fsdevel+bounces-68125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61280C54F06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 01:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B9EC34ABFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F7C156678;
	Thu, 13 Nov 2025 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="iMIqdoYf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fnogvJKL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36935959;
	Thu, 13 Nov 2025 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994398; cv=none; b=ZDh4V4ufdxHINqH5FzJssKFKhHAkOOC0cfU39b1jMZLovw+0nlYR5oEfADOI7GCN/vOje0lxKKRwNkuXzAQ+mJ8WmCzfQj46mzodkxkcPb8MJbhScLptu2iEwiGiTNwzpYiEmfPlf+PLj7s1OjEDjAImR71YLD/EJ1uxBOi8cyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994398; c=relaxed/simple;
	bh=TAN7fEBHF6l6av49IjnjkWwi18U3z35Kj1YFqr+hndU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJKQRyVNZiMGsQtBLNVGTIFPMWpZLbpaTEF8ElqK/VnZR3FTcyePE1sa9AqPtdsBt+j/QwT9QirkAiV+d1oaEtD5bsCIPmP6nBU19VCn+DDkyEtT1djJs92R4oR7IebLahIw1E3h5NNmuhfd4awNvWrA4LWGtiuYKu1bW72pXKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=iMIqdoYf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fnogvJKL; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 05EE113000C2;
	Wed, 12 Nov 2025 19:39:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Nov 2025 19:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762994393;
	 x=1763001593; bh=ymZTXBnehovWBhFY5IZfw5DvNFPVLbASCb4gqoKTrXQ=; b=
	iMIqdoYf311DwAUNczsfpI0cq8Qq/v7bBAZwEeq5OFpHV2ecJCQukg6xBr33/wfQ
	AddpzU2Ryvu7kc7+rnQVn3pEwIx5ySOrchntuxHmhPG/apfsnpO+xSYQhfWcr4kZ
	Mgh4sRrxq1My6k/7itBWBVb1wxZiVXaQRo0bCsJE+uAkDDggJk1ZnOeyBVJxAmHF
	hxHfE2Gut0yHhlnD2OxHs5lN3kpWv7T32NYVponOr8L3qRp2u4W3aND6/PFQ0Vkz
	l4FGNduqo4iHbtQSxqTnOGWsFaPDZbBli3/kIctBp0CsE745G3Kr7fjawu41R22R
	5B5ZNtz4MgyJ+ti2bz9OmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762994393; x=1763001593; bh=y
	mZTXBnehovWBhFY5IZfw5DvNFPVLbASCb4gqoKTrXQ=; b=fnogvJKLM3XwbZBHI
	8fW7r4nPh6XB3r0yi0uTgJitmtu1+mUk5oZFeWuAuw4D7RIf99Pfusv+2Z8CoAHY
	1ofXfnrnWDLaq+JbbUWp4dq8an0sQ21TdrIdzX9lXaAi65qrF1tf7JKdXRQfCMSA
	sGdv8zzcC6DpvtRWvTRjXj0nPNeJrDM7v1zOsgWVVxF/gfBp86Z0S17TKFIB/Qn9
	R8kjbFX7S6h3WLMZ9MkWEmeOpu8E3BJ1DfHuk4atihoOooHXwb1UWM04+h1sD4xR
	G84Sdft/evW5VUBMHCdyCeUfouSBQ2h6VNe6Zud+YKBrUmvjU3oQ056l1+ISfgzj
	5M1CA==
X-ME-Sender: <xms:2SgVaYGLcuNLXShoRQl6S3QtsRjKY2BmLEbhlJ-0P2C5qvve14WqXQ>
    <xme:2SgVaWYaCSdBsdeJpr2tn8o_s27b5U9DbRlqPoo3msT8msIXEsWLsOQ2mrCe8Dbjz
    pc5NqchrROJTuxxGfAu0A53PoQIDufo53nM1-LN3ZmpysQSJg4>
X-ME-Received: <xmr:2SgVafImxoE_kjP5zJLBqxGMuJK73ysfU6sVu4ahWa_UiMwG7qe-PC0UEq7TRNBCQRC50CVLxaGMRUXvI2ckFu6kb0p7vJ6cNTkpoZajVmas>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:2SgVaXyiooDLSiYYgskgCqU2FdoZTl6Qhx_3sXP2aDq5ft9bMkHs0w>
    <xmx:2SgVaf0tG_GTuP-UQB3xA1xiym4P1mH02GYttIjT9OCsrVYvGWBR-w>
    <xmx:2SgVaSjx_DJ-_Y0z3rhcCRHHvBPyI-Pvs83AzQ5TckU_ItQa69yaWA>
    <xmx:2SgVabOyddN2sTKz_7qjZ6EANoKIzBxZmFIzTIK6st1p3QF7tgawJg>
    <xmx:2SgVaaEj3bXh7ydOJz7g1mZqs_vAbd6xes8w8tUvwYulJzQWreFT7ZbR>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 19:39:42 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,	Dai Ngo <Dai.Ngo@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,	ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,	linux-xfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,	selinux@vger.kernel.org
Subject: [PATCH v6 01/15] debugfs: rename end_creating() to debugfs_end_creating()
Date: Thu, 13 Nov 2025 11:18:24 +1100
Message-ID: <20251113002050.676694-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251113002050.676694-1-neilb@ownmail.net>
References: <20251113002050.676694-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

By not using the generic end_creating() name here we are free to use it
more globally for a more generic function.
This should have been done when start_creating() was renamed.

For consistency, also rename failed_creating().

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/debugfs/inode.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 661a99a7dfbe..f241b9df642a 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -403,7 +403,7 @@ static struct dentry *debugfs_start_creating(const char *name,
 	return dentry;
 }
 
-static struct dentry *failed_creating(struct dentry *dentry)
+static struct dentry *debugfs_failed_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	dput(dentry);
@@ -411,7 +411,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
 	return ERR_PTR(-ENOMEM);
 }
 
-static struct dentry *end_creating(struct dentry *dentry)
+static struct dentry *debugfs_end_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	return dentry;
@@ -435,7 +435,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 		return dentry;
 
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
+		debugfs_failed_creating(dentry);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -443,7 +443,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create file '%s'\n",
 		       name);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 
 	inode->i_mode = mode;
@@ -458,7 +458,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 
 	d_instantiate(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 
 struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
@@ -585,7 +585,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 		return dentry;
 
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
+		debugfs_failed_creating(dentry);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -593,7 +593,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create directory '%s'\n",
 		       name);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
@@ -605,7 +605,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_dir);
 
@@ -632,7 +632,7 @@ struct dentry *debugfs_create_automount(const char *name,
 		return dentry;
 
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
+		debugfs_failed_creating(dentry);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -640,7 +640,7 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create automount '%s'\n",
 		       name);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 
 	make_empty_dir_inode(inode);
@@ -652,7 +652,7 @@ struct dentry *debugfs_create_automount(const char *name,
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL(debugfs_create_automount);
 
@@ -699,13 +699,13 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 		pr_err("out of free dentries, can not create symlink '%s'\n",
 		       name);
 		kfree(link);
-		return failed_creating(dentry);
+		return debugfs_failed_creating(dentry);
 	}
 	inode->i_mode = S_IFLNK | S_IRWXUGO;
 	inode->i_op = &debugfs_symlink_inode_operations;
 	inode->i_link = link;
 	d_instantiate(dentry, inode);
-	return end_creating(dentry);
+	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_symlink);
 
-- 
2.50.0.107.gf914562f5916.dirty


