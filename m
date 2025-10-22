Return-Path: <linux-fsdevel+bounces-65033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 594C7BF9FE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B866E19C8F71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487772DEA75;
	Wed, 22 Oct 2025 04:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="w4LZP7yV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NG2rZi4S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10232DAFAF
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108440; cv=none; b=n1w10th2YjfyIUGKttTUOiyQQtfC4znzCZu7VyYPbg7ICk27BKt26cLOdnCZO6ifU6LNyaZMItUz/s715yN+Icrk7rEqgRTZvQ+6Ote/EMDi7T5NH/QTRdVThOYGvSB+n85wTrV2Rd621kXHMxSLfx4ckp3w0JWSXS5kUg8ionM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108440; c=relaxed/simple;
	bh=jP0VItjW9TmC0N0ZbtcfmmKXjB/xRix3f/Yq+pI0+9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnnqzBIU4KL15hxWqqO3ZARzm3lPleApsce8l7mYlKUI5QCT1UzniVtCp9Ka18P8oTZu/gdZYqxkS7R8E9D1D4lIRDE4i5mCbaMpMeBNJacP0VDyLnicLf1+ks6iPdyUWIPXNX9XUbEpyLa96yMDL+jSGLwClPXTuxdqqv5nzZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=w4LZP7yV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NG2rZi4S; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B91B0EC00A9;
	Wed, 22 Oct 2025 00:47:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 22 Oct 2025 00:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761108436;
	 x=1761194836; bh=OmYIKVAm3NJgSpHW8ca60oUoTW8yQaaXXVdC2pwpq+I=; b=
	w4LZP7yVrGMW56GsrPRXyCKnd+JsHuUI4jiI1VQbHtusYL1kvJWUyBc43MzClcDQ
	UQDCv1ucdo8Ce2xYisj8S7D1OkLy7zNVRlWNNvwgTW+4qIB8sC6tzdkQYWfgUsV7
	ffgbL0PV5kG4Ujd0Eij17uz7CnJZ1BuS7wJm9LkQC4Qq/LamI/tuD+Ts61P8kYZd
	wnleVvXwzrIaYl9sUBF6WndclTLXhisKgpXqOqhrdqFE7MdxfLaRcFYLdXwil0GW
	Z27l9xtK+c1L78pFP1JKR0HJ1W16iZsu9Hm4nNhxGxlTkk4koXHxr9TUinLbq0Mh
	ZTsEAGKcQ7pyeHzY+94tMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761108436; x=1761194836; bh=O
	mYIKVAm3NJgSpHW8ca60oUoTW8yQaaXXVdC2pwpq+I=; b=NG2rZi4SMo8gyemNS
	6iOFlubIzhdv9bzQVjlAQ5/fQEO+SnMmwfx4u7qhuLKc1BrVC2soeEKBm5Ysl35R
	d0etoznEK2RBwsGhzHXsllGM95bPWWNOGiQbSSVn5QGdvvl/WTPWMBZ8EMNEWqu0
	nuLVx5fc0ww3+WwVngFXlScivA+fzeOufOVTPgiHC7k6FBWLvy9a2R6dRmkYF20M
	fWNwaWt2mTT57nX2pOIEeJthlKxfkeQIRP6tUmyNAqYdC0PKQPHt6Y4BCthmBerc
	piNCa1jywDugi18/NXQtvr1vpYPyGHhZOg24Vc1vwovzZfHSGL+lQsX0U2Wn9XNh
	VUA3g==
X-ME-Sender: <xms:1GH4aAIBb2RCo_JZ7WdvFQPUDtp5D-d0pKMPEGAyuKIDzN5WouEqbg>
    <xme:1GH4aHiwCza6rAwZVG5EQgvsqQAlN-YqBOuJa097Jzkl9EqkcIDxQpuu36eWXcOY-
    FtKJa0rJK-9Uon_3AuTKCZf60bWQX7znVJ0tTi5GRVO9EXzgKY>
X-ME-Received: <xmr:1GH4aGT380C1mpal0fZzfpN6-qabJBZYHhaEtRMKxxJG3ydIerEp1fJVGvAQ7xl9OZaTqRN1iFR8phD2uutdnn6vEEIZo2-ielTZDkczYSdH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:1GH4aJUJmIszeChDYa_1BbFgJUsHpGKn_zGjg0QtIOFzQD2lJ3rjqg>
    <xmx:1GH4aKRgY6ICVwvNEfwm1JwhS0JheLP9kUK66_8guZ4m_7-jYhHqPA>
    <xmx:1GH4aDlSCASs7aLab2jsmhZvH7gBppaK9SKi-Bi6cSt_7T9Bl54ffw>
    <xmx:1GH4aA6YQ77fmduDY3ono93UhTQQc-_xA4_yeiiK2fxHE5_OOf8aPw>
    <xmx:1GH4aGjroNc2SPPBJtiKxeexOqW73V5dbfJGFXz0P-l0RNsKYpwvMqEa>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 00:47:14 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 01/14] debugfs: rename end_creating() to debugfs_end_creating()
Date: Wed, 22 Oct 2025 15:41:35 +1100
Message-ID: <20251022044545.893630-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251022044545.893630-1-neilb@ownmail.net>
References: <20251022044545.893630-1-neilb@ownmail.net>
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


