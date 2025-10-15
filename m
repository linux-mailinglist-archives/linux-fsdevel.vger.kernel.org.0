Return-Path: <linux-fsdevel+bounces-64177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E55BBDC057
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 03:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398321926A6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 01:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C099B2FB610;
	Wed, 15 Oct 2025 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OWSY8kHr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QLgQyjp+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD622F7478
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492897; cv=none; b=lQAPIwzOeGUufCRD378QUQ72Bxb1KR14kmExykuStJ8WC/Vh2OoI7Tu7/3NVJvRf8aWHMjw8oC8niTfo6Bo/WYRrP1wfEtnulfdq74cgk7WVs8YdhLnKX8DiEBA8Lgzt2WXdUCYHZyQ4c4eSQtgf8Uf6pn6vE59hOsEGV2XV+E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492897; c=relaxed/simple;
	bh=jP0VItjW9TmC0N0ZbtcfmmKXjB/xRix3f/Yq+pI0+9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqqoAIlDvWTtTj7d8CNpcT+4L8NsCyajb26IDU9z5UHxNZncx0A7XAtNsEW55gLDdcFnSui6VaB7pCPQmlxUC5LzD6mfSLNByR4YeVgwVCbecsKQIAN5Lohu5yfeazhzS2LuJPEZ1gg+XV5zITwhKxV9YXvmfLA3k7Fv5nO6L4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OWSY8kHr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QLgQyjp+; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 0482DEC0241;
	Tue, 14 Oct 2025 21:48:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 14 Oct 2025 21:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760492894;
	 x=1760579294; bh=OmYIKVAm3NJgSpHW8ca60oUoTW8yQaaXXVdC2pwpq+I=; b=
	OWSY8kHrsjNcBYJBRemMKtY4N6Bc+JBngqB/UEJz8Y86m9NAMU8SsaHSvX/tF11a
	S9+E5FLSbNhC4tE8bA4b9GYivmhCJ8SXUV/jz3pU1GeeZEHhhmpUTqR2Ia7t5NOZ
	TZTKU43rahsE7Y91JNb0vZpKM+j4jOqjNqYBzB6tXq4Z4gOKgZavYyyN/Qbio9Km
	2+63yFZPQqvv6TFqrNRATRTdH6R8lJ8EZ/vuKDaY6vvtJVSBUgmusLlrsB1zS1M5
	wz4uLCuHi7BCO/1DbRy6SjsDztWGwZFLYaxQRMYO4iUjqLo4Rnh0vwaeCS7sATxj
	NsIU6rMp1tTGR3FzvqlPXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760492894; x=1760579294; bh=O
	mYIKVAm3NJgSpHW8ca60oUoTW8yQaaXXVdC2pwpq+I=; b=QLgQyjp+rOwEFFsxw
	qoD20d5jnnDKapihP1eyanSibqQ9uK2bHo7ID3LXJUhqkg4MqgVCiA+XN/jMxdqv
	jmNVWOm93t3opSfRUG2xEykk+2qHlNNi2jnUbOtfJZtOb2kXPav+fm5Ct9x9lTdg
	ZG7ia1dI/tWF2y3h1+9xUp45wkqh9/5Sbs8Fb6XZix8+pU+C0S3rV3Y2tO+DHDh2
	I7vCzDuoVtel2/MSZrJwHBMf2ffpNOGZYKcLUNjU2L58xj/fMP6s20GxblE9tuZA
	yiZRshfo8cHjJ2htGWjzmBEkGYwB9C0r1/Uzco6Ey1MS77pmMYTYZohCoN8T17aW
	KtDzQ==
X-ME-Sender: <xms:Xf3uaBKAWbhvRX1XvjmiYZCXzyO5WrfWDxOioA4LBvSyBmS77fOf5A>
    <xme:Xf3uaIHS8yKPq1Q3dx0t5FvJtXDswebuCqT8TMWUWUtPMoWVce7t975EJ8oCViOFq
    yc28_0l91flavDgvgGXOVCjmBnXIdhe8KJoKHGK_p5XUz2k>
X-ME-Received: <xmr:Xf3uaIv95OtH09qK7k3vP5bQqAOZUyCTdUEBElM_gMkpGzaeDI2U1a_5lVOePgHolf9OBppN0AIvbbpDGCd1332lxb47VvJ50zQIQsBPndKa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvudefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Xf3uaHvaPHHmlZz9oLEeudoAD6Y9Sc03PDnr7XFUV_dYh0_tJX4yqw>
    <xmx:Xf3uaGBk2-GbfZiD47lxAUSrvm4BV7HsyA_csmOnc6AyUHMZ7UDXFA>
    <xmx:Xf3uaBNrx50VWo_neXVBTHI-dKnIvEkTskwcdTO9BAGD3UFYrUiIGQ>
    <xmx:Xf3uaHx9VM_r5ljSh-LTby65eU_MwiVxWL_3Z0HO55ZBQBIo4TJ61w>
    <xmx:Xf3uaIhgJw3S9F6s8-krYGIB9O69aq4jSsVOY58CrhDmGJqdvqRO0TZT>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 21:48:11 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 01/14] debugfs: rename end_creating() to debugfs_end_creating()
Date: Wed, 15 Oct 2025 12:46:53 +1100
Message-ID: <20251015014756.2073439-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251015014756.2073439-1-neilb@ownmail.net>
References: <20251015014756.2073439-1-neilb@ownmail.net>
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


