Return-Path: <linux-fsdevel+bounces-51655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCBBAD9A4F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 08:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6BF189CBCF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 06:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E27A1E5B9E;
	Sat, 14 Jun 2025 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZDlPmafA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526031DE3DB
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749880954; cv=none; b=beFooSCLUd2Wold6FROG78LJCMHGX74F815zVI6qcyeHMNg9ZHnOyhldKojDZE2Qi4vrlwt2EbC5EgfmNUTAPFFinIOjoEvcjE3rVccEkHVrmfipUxltwvvAJoapb/L8WZw95GM5519ZzTARpIc4BbgOpOfaIPcDjPuxAOpO36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749880954; c=relaxed/simple;
	bh=BoFBC7E08IoyO0PdINxQElFSAGB0AXvsGKCZqtkPIio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeQEP2g+ChWK6Xm5Q7r4wnYGr+gLmsqV9kqqk3jBzihMxWAnNfwvCLdkutjTgD6ZN0Frqgpk63qn0NUwlAQWClfG7JXn27ei+cN7VJ4mr73v2u8hcaU9387uimqKIt0wpH2gnaEnIoJHFXO5hqdWabIZULeHmX8DxbIOLdnQH48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZDlPmafA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=d4yT/v7kjFaTlsq7A710+cWMBTwSY0HqVc7XZ/5amrk=; b=ZDlPmafA8LnOP35sHHwCbHtiwl
	uPYWyQPTXU3PsG+3c4PIuAd0roFj2liDn9KRaFvUGz/tVKXn8uNSmszsVY+QvUsw9GhaAUBrgpBHW
	Odpgli6RuHIMAfpcM3rBe8ppLhixf/5cMs9fRbEySpEetUzhgFKIOpQVSmJD7lLDYp9/m2/0CarQL
	ZeBbAm+g0rxKi2FXnK7nL2l8YW3vkcYqFnIRNtaZZOdzngLQODjthRckHqHAg0ARfiC0oKDpr9nUu
	Kzw7qS6i7FqEODLWIErfof1XGDPLKG+ln3cTfSYwzV8vWCgyXnpiJ1WnVZTZ0eQOjPK/KRO0h9Y0X
	MqAgdBMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQJyJ-000000022qW-2ZKD;
	Sat, 14 Jun 2025 06:02:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: neil@brown.name,
	torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH 6/8] fuse_ctl: use simple_recursive_removal()
Date: Sat, 14 Jun 2025 07:02:28 +0100
Message-ID: <20250614060230.487463-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614060230.487463-1-viro@zeniv.linux.org.uk>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

easier that way - no need to keep that array of dentry references, etc.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fuse/control.c | 30 +++++++++++++-----------------
 fs/fuse/fuse_i.h  |  6 ------
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 2a730d88cc3b..bb407705603c 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/fs_context.h>
+#include <linux/namei.h>
 
 #define FUSE_CTL_SUPER_MAGIC 0x65735543
 
@@ -212,7 +213,6 @@ static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
 	struct dentry *dentry;
 	struct inode *inode;
 
-	BUG_ON(fc->ctl_ndents >= FUSE_CTL_NUM_DENTRIES);
 	dentry = d_alloc_name(parent, name);
 	if (!dentry)
 		return NULL;
@@ -236,8 +236,6 @@ static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
 	inode->i_private = fc;
 	d_add(dentry, inode);
 
-	fc->ctl_dentry[fc->ctl_ndents++] = dentry;
-
 	return dentry;
 }
 
@@ -280,27 +278,29 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 	return -ENOMEM;
 }
 
+static void remove_one(struct dentry *dentry)
+{
+	d_inode(dentry)->i_private = NULL;
+}
+
 /*
  * Remove a connection from the control filesystem (if it exists).
  * Caller must hold fuse_mutex
  */
 void fuse_ctl_remove_conn(struct fuse_conn *fc)
 {
-	int i;
+	struct dentry *dentry;
+	char name[32];
 
 	if (!fuse_control_sb || fc->no_control)
 		return;
 
-	for (i = fc->ctl_ndents - 1; i >= 0; i--) {
-		struct dentry *dentry = fc->ctl_dentry[i];
-		d_inode(dentry)->i_private = NULL;
-		if (!i) {
-			/* Get rid of submounts: */
-			d_invalidate(dentry);
-		}
-		dput(dentry);
+	sprintf(name, "%u", fc->dev);
+	dentry = lookup_noperm_positive_unlocked(&QSTR(name), fuse_control_sb->s_root);
+	if (!IS_ERR(dentry)) {
+		simple_recursive_removal(dentry, remove_one);
+		dput(dentry);	// paired with lookup_noperm_positive_unlocked()
 	}
-	drop_nlink(d_inode(fuse_control_sb->s_root));
 }
 
 static int fuse_ctl_fill_super(struct super_block *sb, struct fs_context *fsc)
@@ -346,12 +346,8 @@ static int fuse_ctl_init_fs_context(struct fs_context *fsc)
 
 static void fuse_ctl_kill_sb(struct super_block *sb)
 {
-	struct fuse_conn *fc;
-
 	mutex_lock(&fuse_mutex);
 	fuse_control_sb = NULL;
-	list_for_each_entry(fc, &fuse_conn_list, entry)
-		fc->ctl_ndents = 0;
 	mutex_unlock(&fuse_mutex);
 
 	kill_litter_super(sb);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b54f4f57789f..30206605e114 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -913,12 +913,6 @@ struct fuse_conn {
 	/** Device ID from the root super block */
 	dev_t dev;
 
-	/** Dentries in the control filesystem */
-	struct dentry *ctl_dentry[FUSE_CTL_NUM_DENTRIES];
-
-	/** number of dentries used in the above array */
-	int ctl_ndents;
-
 	/** Key for lock owner ID scrambling */
 	u32 scramble_key[4];
 
-- 
2.39.5


