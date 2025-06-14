Return-Path: <linux-fsdevel+bounces-51658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D677EAD9A51
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 08:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB2C189CAEF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 06:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29B51EB5CE;
	Sat, 14 Jun 2025 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nBtItsXK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1BA1DE4D8
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749880956; cv=none; b=HhsQeXk/wKam2F5NfpDzVNXWFTT6G0skhXS67s2wRaG3oXlnUA8dk4keO5WGC512wgPLvzHzXRu1rnBQVkVfUfPwsqwDsUpSWYJ/8w1RnTShBQsEMC7ywSOxcw/dp+fX8Tig95ZAQnMupE+8+BBCVP4Cnnzgb2CyCXWVNTl+dD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749880956; c=relaxed/simple;
	bh=TZS2yDuNWlA4hsReznb1044ApWzfJd1sBdU6YioqeFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zyy+6jTkLIJx6Kb7D5qQ0XTA3I3Xc6+vEqu0GglIndKNMN4UfjMyFn5a2y6xqijsUnTyfa1VQPQMQ30vnxfwIIbO0sDDJY21eZepJGiT3wjjqqXwvXvRnmyqvpZ29FTqfNl46pfzGsL2mrQ1ozvTW5TpHjGxRJiocCCNDFO+BzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nBtItsXK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8r/2R8ebUxqM49sOrLnw4atDSCCDfzY1m5B/CdCgePk=; b=nBtItsXK1DVFuZvhIzojnXd92B
	sWIYGqBlYY5drG/dv/W/rqd1geYQlwXArkZuvrWvzeBI0V+c/hIEl4cdpLaC1xI2VNEDY5LkpvvfO
	SREnGQmYeAOjivbqAMm/BrRjFHMRfsSmQrbOaskS+SynNZCXztA0VIZqaV5IO4GRmGOZK8JIRJXhL
	sZXKrtPrcetQWd0kyrN7PCQUgbMSiU3XrFl1uhcouveUxGrfxrYKKCHmy519QWIwIOcAFQjRpTXHR
	kPBSB3S/y93akoiXD69/IYVB9t0oGQVXl7MLAUNFz36NGCOJkJW2UHObuZGarVAijj/is2H+3vqpK
	CKBndWYA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQJyJ-000000022qk-3o7q;
	Sat, 14 Jun 2025 06:02:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: neil@brown.name,
	torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH 7/8] kill binderfs_remove_file()
Date: Sat, 14 Jun 2025 07:02:29 +0100
Message-ID: <20250614060230.487463-7-viro@zeniv.linux.org.uk>
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

don't try to open-code simple_recursive_removal(), especially when
you miss things like d_invalidate()...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/android/binder.c          |  2 +-
 drivers/android/binder_internal.h |  2 --
 drivers/android/binderfs.c        | 15 ---------------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c463ca4a8fff..ffecf212c2d0 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6128,7 +6128,7 @@ static int binder_release(struct inode *nodp, struct file *filp)
 	debugfs_remove(proc->debugfs_entry);
 
 	if (proc->binderfs_entry) {
-		binderfs_remove_file(proc->binderfs_entry);
+		simple_recursive_removal(proc->binderfs_entry, NULL);
 		proc->binderfs_entry = NULL;
 	}
 
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 1ba5caf1d88d..a5fd23dcafcd 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -81,7 +81,6 @@ extern bool is_binderfs_device(const struct inode *inode);
 extern struct dentry *binderfs_create_file(struct dentry *dir, const char *name,
 					   const struct file_operations *fops,
 					   void *data);
-extern void binderfs_remove_file(struct dentry *dentry);
 #else
 static inline bool is_binderfs_device(const struct inode *inode)
 {
@@ -94,7 +93,6 @@ static inline struct dentry *binderfs_create_file(struct dentry *dir,
 {
 	return NULL;
 }
-static inline void binderfs_remove_file(struct dentry *dentry) {}
 #endif
 
 #ifdef CONFIG_ANDROID_BINDERFS
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 024275dbfdd8..acc946bb1457 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -500,21 +500,6 @@ static struct dentry *binderfs_create_dentry(struct dentry *parent,
 	return dentry;
 }
 
-void binderfs_remove_file(struct dentry *dentry)
-{
-	struct inode *parent_inode;
-
-	parent_inode = d_inode(dentry->d_parent);
-	inode_lock(parent_inode);
-	if (simple_positive(dentry)) {
-		dget(dentry);
-		simple_unlink(parent_inode, dentry);
-		d_delete(dentry);
-		dput(dentry);
-	}
-	inode_unlock(parent_inode);
-}
-
 struct dentry *binderfs_create_file(struct dentry *parent, const char *name,
 				    const struct file_operations *fops,
 				    void *data)
-- 
2.39.5


