Return-Path: <linux-fsdevel+bounces-65044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5748ABFA006
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C023564B0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38B62DC770;
	Wed, 22 Oct 2025 04:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="npZTbgue";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P9MnC1gQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100312DC350
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108492; cv=none; b=AEHcrbwqZhNXHTMcyWNflKGS4JbHjqQcrmwHnbHNHYTXmC1NF4m3FpCdmYTIHAephxEgqAnVlf5D8xMiiYwUAMapksVTDUtcd++ipcx+R5poTVQ2hpom3gEHFRFGl1XIEjx1iUFKsxtgpRFF1hqdgRxpCYsFIhdlI8iBovq55F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108492; c=relaxed/simple;
	bh=HdPv8mDw8o2H979T1xmhL3gmAMBLZERXGevY6LlAFbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQ08No94Svd7foJ+KCtl3joGYoQAI7qQuQ/rU/gfGQ1tkbZj/gmwR03D1dnPcpqrk6yljVlDxsbov7gLLcbH6Qi534G97tg5hL4lGHnKkbWP8hZD+Cmjyyb7JC03YeIIZ60iZO7+pTcmjw17Z9op9nNFX55cHeP+TbxWkaJHH1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=npZTbgue; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P9MnC1gQ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3FFDBEC00C2;
	Wed, 22 Oct 2025 00:48:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 22 Oct 2025 00:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761108489;
	 x=1761194889; bh=74qOPrcozMZPRqC6V9uAJY4k8e/gVMYB1Snqabb+puY=; b=
	npZTbgue/TsBI1Qekb52FkVxEaaf+IMyy7QU0LB4wFOSD4B14zTHdi8n1QXrKM4M
	MaQzrEXKIXMFm8FnX9/316vQcq0kSFUYRh2tgtTOSy/7xdAu2VV6LojwmU3dsbj3
	jYvmiM8NHcmrO30eb19T90sGnHeP52EXzFH0SPISASlEPP5+vT4OPdqPVYne+inF
	QIGHqgpHQT9wBJpVo75Jjs8zO1BXeuoVbZWln5+YOE7pJRlVfujXy8w/VKF3wgb2
	J6QW+8/83VVSO96uHvELq+hPiwmcoI2V7Kb9sBeUoIMHD2vRd4ynRwpOGPASceoD
	MJoM+IiKsPtenngn78zyTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761108489; x=1761194889; bh=7
	4qOPrcozMZPRqC6V9uAJY4k8e/gVMYB1Snqabb+puY=; b=P9MnC1gQFQWwUb0FK
	yP5aup44XKH68liwMN+Z+gyhjkXhrusKNTmqxd4c0vatihUy3u43z/b+ibsYPWed
	hinqa4VAibDP0qGueuP+fG6T7lesCsuNOdJ7Hq+EeyHqPAgIvRoUihJ5Ntn9hs+5
	+sr+/Jq6CsCxC6t0OeRPXmlWHN22vb1RvIHZAh/EZIvXOiY9jveDLAl5iYx+VCR6
	p7kqNJXozLksJik4kIhMmNG0DcIIs26q2+0Lx40O+/v+oIdg8PSfRozshQn41Wbu
	L5UT0BOk+BmkVa4oEyPCRVhTaFZl9dfSA8pFIQF9YB23/QtNspSEbyBjnf3KeWEg
	8piXA==
X-ME-Sender: <xms:CWL4aF3JQDH23DEBzAeqYRHycrXK85n6VTCtqNnx6hlatyuFQXB4_g>
    <xme:CWL4aHBpawT756_IKw6-LpMwU8KJRnXKU9Yg1oFdSTUkna9pWl7lCDyNIKzcPBLZv
    pTVUqKyLLKnSEi54Szh7sby_yAuS-kfWUY6YIG52ZVVgE-tsQ>
X-ME-Received: <xmr:CWL4aE77vsMITjvDVRk921CxjNtFiV7TpyTUZ1UJcR4164S7TuUAglPicQimaDTeDtxh_eRAXHmn_vWmE2-DOkzeaeAnQevQqs5gMAI43c-1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:CWL4aIIYzzwa88jDAscQj106BJFIJPYQ1LcbAumKyxOhS2AEglUi2Q>
    <xmx:CWL4aFsXTjOp3MPpQl1R3GFEqIVL1B1oHCb8ZcSpXuG2X1gEZduo2A>
    <xmx:CWL4aPIhzwFaG03b6kJ9L9tU7e5ym5hTO1VdvVTbx30wmHXP-cb0bQ>
    <xmx:CWL4aG-0fUxAb-C4ANxz2e42hlJth9tGJolq9UyT5EIPwggKfo9gLg>
    <xmx:CWL4aFuTbRzurIyy-Xslom7Rmad9VrTEmKVq2ObuvBUjOuITxq6RRpp6>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 00:48:06 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 12/14] ecryptfs: use new start_creating/start_removing APIs
Date: Wed, 22 Oct 2025 15:41:46 +1100
Message-ID: <20251022044545.893630-13-neilb@ownmail.net>
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

This requires the addition of start_creating_dentry() which is given the
dentry which has already been found, and asks for it to be locked and
its parent validated.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ecryptfs/inode.c   | 153 ++++++++++++++++++++----------------------
 fs/namei.c            |  33 +++++++++
 include/linux/namei.h |   2 +
 3 files changed, 107 insertions(+), 81 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index ed1394da8d6b..b3702105d236 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -24,18 +24,26 @@
 #include <linux/unaligned.h>
 #include "ecryptfs_kernel.h"
 
-static int lock_parent(struct dentry *dentry,
-		       struct dentry **lower_dentry,
-		       struct inode **lower_dir)
+static struct dentry *ecryptfs_start_creating_dentry(struct dentry *dentry)
 {
-	struct dentry *lower_dir_dentry;
+	struct dentry *parent = dget_parent(dentry->d_parent);
+	struct dentry *ret;
 
-	lower_dir_dentry = ecryptfs_dentry_to_lower(dentry->d_parent);
-	*lower_dir = d_inode(lower_dir_dentry);
-	*lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	ret = start_creating_dentry(ecryptfs_dentry_to_lower(parent),
+				    ecryptfs_dentry_to_lower(dentry));
+	dput(parent);
+	return ret;
+}
 
-	inode_lock_nested(*lower_dir, I_MUTEX_PARENT);
-	return (*lower_dentry)->d_parent == lower_dir_dentry ? 0 : -EINVAL;
+static struct dentry *ecryptfs_start_removing_dentry(struct dentry *dentry)
+{
+	struct dentry *parent = dget_parent(dentry->d_parent);
+	struct dentry *ret;
+
+	ret = start_removing_dentry(ecryptfs_dentry_to_lower(parent),
+				    ecryptfs_dentry_to_lower(dentry));
+	dput(parent);
+	return ret;
 }
 
 static int ecryptfs_inode_test(struct inode *inode, void *lower_inode)
@@ -141,15 +149,12 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 	struct inode *lower_dir;
 	int rc;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	dget(lower_dentry);	// don't even try to make the lower negative
-	if (!rc) {
-		if (d_unhashed(lower_dentry))
-			rc = -EINVAL;
-		else
-			rc = vfs_unlink(&nop_mnt_idmap, lower_dir, lower_dentry,
-					NULL);
-	}
+	lower_dentry = ecryptfs_start_removing_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return PTR_ERR(lower_dentry);
+
+	lower_dir = lower_dentry->d_parent->d_inode;
+	rc = vfs_unlink(&nop_mnt_idmap, lower_dir, lower_dentry, NULL);
 	if (rc) {
 		printk(KERN_ERR "Error in vfs_unlink; rc = [%d]\n", rc);
 		goto out_unlock;
@@ -158,8 +163,7 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
 	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
 out_unlock:
-	dput(lower_dentry);
-	inode_unlock(lower_dir);
+	end_removing(lower_dentry);
 	if (!rc)
 		d_drop(dentry);
 	return rc;
@@ -186,10 +190,12 @@ ecryptfs_do_create(struct inode *directory_inode,
 	struct inode *lower_dir;
 	struct inode *inode;
 
-	rc = lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_create(&nop_mnt_idmap, lower_dir,
-				lower_dentry, mode, true);
+	lower_dentry = ecryptfs_start_creating_dentry(ecryptfs_dentry);
+	if (IS_ERR(lower_dentry))
+		return ERR_CAST(lower_dentry);
+	lower_dir = lower_dentry->d_parent->d_inode;
+	rc = vfs_create(&nop_mnt_idmap, lower_dir,
+			lower_dentry, mode, true);
 	if (rc) {
 		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
 		       "rc = [%d]\n", __func__, rc);
@@ -205,7 +211,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 	fsstack_copy_attr_times(directory_inode, lower_dir);
 	fsstack_copy_inode_size(directory_inode, lower_dir);
 out_lock:
-	inode_unlock(lower_dir);
+	end_creating(lower_dentry, NULL);
 	return inode;
 }
 
@@ -433,10 +439,12 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 
 	file_size_save = i_size_read(d_inode(old_dentry));
 	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
-	rc = lock_parent(new_dentry, &lower_new_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_dir,
-			      lower_new_dentry, NULL);
+	lower_new_dentry = ecryptfs_start_creating_dentry(new_dentry);
+	if (IS_ERR(lower_new_dentry))
+		return PTR_ERR(lower_new_dentry);
+	lower_dir = lower_new_dentry->d_parent->d_inode;
+	rc = vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_dir,
+		      lower_new_dentry, NULL);
 	if (rc || d_really_is_negative(lower_new_dentry))
 		goto out_lock;
 	rc = ecryptfs_interpose(lower_new_dentry, new_dentry, dir->i_sb);
@@ -448,7 +456,7 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 		  ecryptfs_inode_to_lower(d_inode(old_dentry))->i_nlink);
 	i_size_write(d_inode(new_dentry), file_size_save);
 out_lock:
-	inode_unlock(lower_dir);
+	end_creating(lower_new_dentry, NULL);
 	return rc;
 }
 
@@ -468,9 +476,11 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 	size_t encoded_symlen;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat = NULL;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	if (rc)
-		goto out_lock;
+	lower_dentry = ecryptfs_start_creating_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return PTR_ERR(lower_dentry);
+	lower_dir = lower_dentry->d_parent->d_inode;
+
 	mount_crypt_stat = &ecryptfs_superblock_to_private(
 		dir->i_sb)->mount_crypt_stat;
 	rc = ecryptfs_encrypt_and_encode_filename(&encoded_symname,
@@ -490,7 +500,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 	fsstack_copy_attr_times(dir, lower_dir);
 	fsstack_copy_inode_size(dir, lower_dir);
 out_lock:
-	inode_unlock(lower_dir);
+	end_creating(lower_dentry, NULL);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
@@ -501,12 +511,14 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 {
 	int rc;
 	struct dentry *lower_dentry;
+	struct dentry *lower_dir_dentry;
 	struct inode *lower_dir;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	if (rc)
-		goto out;
-
+	lower_dentry = ecryptfs_start_creating_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return lower_dentry;
+	lower_dir_dentry = dget(lower_dentry->d_parent);
+	lower_dir = lower_dir_dentry->d_inode;
 	lower_dentry = vfs_mkdir(&nop_mnt_idmap, lower_dir,
 				 lower_dentry, mode);
 	rc = PTR_ERR(lower_dentry);
@@ -522,7 +534,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	fsstack_copy_inode_size(dir, lower_dir);
 	set_nlink(dir, lower_dir->i_nlink);
 out:
-	inode_unlock(lower_dir);
+	end_creating(lower_dentry, lower_dir_dentry);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return ERR_PTR(rc);
@@ -534,21 +546,18 @@ static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
 	struct inode *lower_dir;
 	int rc;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	dget(lower_dentry);	// don't even try to make the lower negative
-	if (!rc) {
-		if (d_unhashed(lower_dentry))
-			rc = -EINVAL;
-		else
-			rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
-	}
+	lower_dentry = ecryptfs_start_removing_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return PTR_ERR(lower_dentry);
+	lower_dir = lower_dentry->d_parent->d_inode;
+
+	rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
 	if (!rc) {
 		clear_nlink(d_inode(dentry));
 		fsstack_copy_attr_times(dir, lower_dir);
 		set_nlink(dir, lower_dir->i_nlink);
 	}
-	dput(lower_dentry);
-	inode_unlock(lower_dir);
+	end_removing(lower_dentry);
 	if (!rc)
 		d_drop(dentry);
 	return rc;
@@ -562,10 +571,12 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	struct dentry *lower_dentry;
 	struct inode *lower_dir;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_mknod(&nop_mnt_idmap, lower_dir,
-			       lower_dentry, mode, dev);
+	lower_dentry = ecryptfs_start_creating_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return PTR_ERR(lower_dentry);
+	lower_dir = lower_dentry->d_parent->d_inode;
+
+	rc = vfs_mknod(&nop_mnt_idmap, lower_dir, lower_dentry, mode, dev);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
@@ -574,7 +585,7 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	fsstack_copy_attr_times(dir, lower_dir);
 	fsstack_copy_inode_size(dir, lower_dir);
 out:
-	inode_unlock(lower_dir);
+	end_removing(lower_dentry);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
@@ -590,7 +601,6 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct dentry *lower_new_dentry;
 	struct dentry *lower_old_dir_dentry;
 	struct dentry *lower_new_dir_dentry;
-	struct dentry *trap;
 	struct inode *target_inode;
 	struct renamedata rd = {};
 
@@ -605,31 +615,13 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	target_inode = d_inode(new_dentry);
 
-	trap = lock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
-	if (IS_ERR(trap))
-		return PTR_ERR(trap);
-	dget(lower_new_dentry);
-	rc = -EINVAL;
-	if (lower_old_dentry->d_parent != lower_old_dir_dentry)
-		goto out_lock;
-	if (lower_new_dentry->d_parent != lower_new_dir_dentry)
-		goto out_lock;
-	if (d_unhashed(lower_old_dentry) || d_unhashed(lower_new_dentry))
-		goto out_lock;
-	/* source should not be ancestor of target */
-	if (trap == lower_old_dentry)
-		goto out_lock;
-	/* target should not be ancestor of source */
-	if (trap == lower_new_dentry) {
-		rc = -ENOTEMPTY;
-		goto out_lock;
-	}
+	rd.mnt_idmap  = &nop_mnt_idmap;
+	rd.old_parent = lower_old_dir_dentry;
+	rd.new_parent = lower_new_dir_dentry;
+	rc = start_renaming_two_dentries(&rd, lower_old_dentry, lower_new_dentry);
+	if (rc)
+		return rc;
 
-	rd.mnt_idmap		= &nop_mnt_idmap;
-	rd.old_parent		= lower_old_dir_dentry;
-	rd.old_dentry		= lower_old_dentry;
-	rd.new_parent		= lower_new_dir_dentry;
-	rd.new_dentry		= lower_new_dentry;
 	rc = vfs_rename(&rd);
 	if (rc)
 		goto out_lock;
@@ -640,8 +632,7 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (new_dir != old_dir)
 		fsstack_copy_attr_all(old_dir, d_inode(lower_old_dir_dentry));
 out_lock:
-	dput(lower_new_dentry);
-	unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
+	end_renaming(&rd);
 	return rc;
 }
 
diff --git a/fs/namei.c b/fs/namei.c
index 4a4b8b96c192..8b7807cd1343 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3397,6 +3397,39 @@ struct dentry *start_removing_noperm(struct dentry *parent,
 }
 EXPORT_SYMBOL(start_removing_noperm);
 
+/**
+ * start_creating_dentry - prepare to create a given dentry
+ * @parent: directory from which dentry should be removed
+ * @child:  the dentry to be removed
+ *
+ * A lock is taken to protect the dentry again other dirops and
+ * the validity of the dentry is checked: correct parent and still hashed.
+ *
+ * If the dentry is valid and negative a reference is taken and
+ * returned.  If not an error is returned.
+ *
+ * end_creating() should be called when creation is complete, or aborted.
+ *
+ * Returns: the valid dentry, or an error.
+ */
+struct dentry *start_creating_dentry(struct dentry *parent,
+				     struct dentry *child)
+{
+	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
+	if (unlikely(IS_DEADDIR(parent->d_inode) ||
+		     child->d_parent != parent ||
+		     d_unhashed(child))) {
+		inode_unlock(parent->d_inode);
+		return ERR_PTR(-EINVAL);
+	}
+	if (d_is_positive(child)) {
+		inode_unlock(parent->d_inode);
+		return ERR_PTR(-EEXIST);
+	}
+	return dget(child);
+}
+EXPORT_SYMBOL(start_creating_dentry);
+
 /**
  * start_removing_dentry - prepare to remove a given dentry
  * @parent: directory from which dentry should be removed
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a99ac8b7e24a..208aed1d6728 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -100,6 +100,8 @@ struct dentry *start_removing_killable(struct mnt_idmap *idmap,
 				       struct qstr *name);
 struct dentry *start_creating_noperm(struct dentry *parent, struct qstr *name);
 struct dentry *start_removing_noperm(struct dentry *parent, struct qstr *name);
+struct dentry *start_creating_dentry(struct dentry *parent,
+				     struct dentry *child);
 struct dentry *start_removing_dentry(struct dentry *parent,
 				     struct dentry *child);
 
-- 
2.50.0.107.gf914562f5916.dirty


