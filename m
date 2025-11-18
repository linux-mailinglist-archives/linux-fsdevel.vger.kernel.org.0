Return-Path: <linux-fsdevel+bounces-68866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBD8C67859
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 98FC82B586
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2203093C1;
	Tue, 18 Nov 2025 05:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YJuOa56O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3259A29D29B;
	Tue, 18 Nov 2025 05:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442979; cv=none; b=LE8IssTumf7VA0Hctz+oh+iC6Bl9q0vom3J5YEwwN0zYVshXTiL016J2H+Kl3qxUIZMdBJ/QvkJG/E8p1imIxP8b+gAI0BMRsvzOIDzl1a6QZ6PxchAYO3mPq6yU/nwpOqj5o/fTOnE4/EQFUvDsEEm7lyWgQelEcJViyHr4CZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442979; c=relaxed/simple;
	bh=il8mOVf2818vHOFW/JAhYdqvQSi0sBbx783nwZmQsx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQyMoWLH3EsK9lp04if0x3/x/XkshsTNYC3Mw+hEWSTds8TASglFTVZZV5DREvfBJdQnzNPRdlKRuvc2wWxVztCJbKDEdhPDqelCa8kx3VSGmZHyPyzUtcjC2gv+2BR6RkK5CIvNsT1WiSasTYkGOnHoU0UMK64oNKqFL1FO91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YJuOa56O; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FZUuqKrs+nqWkpfLt5q4RrHggbnk1CWWQm+NX1Cw0DM=; b=YJuOa56O1MjxYGTgaENOoy61GE
	pW9BzUrfOK+4o3p4qm+AJO0GBRfVwfQIkuRSUxdY+22Q3QUMcnZIT7TV5oOi/iLqJgLHtYRjjp0Cz
	icaAAzCWMnLekniPfnn9IyaYt1f9ZUuMsv1I+L50s53kJJCvGsOd5aHDpW1EkZAH+UEd0J0GlZPjs
	pjfdjwxDOhzoiPPnLnBcovS5mXBMc2w/Pwa8nhiquqr7IPOWftRwjnGCeHNTQ76lgTpBvLJwnm24o
	GlJGTEgxKAwsZtFGDSsdzA5CdC9Wz+bO6RgwK3mR7wGYbekp/XVbxHmh7icarI9y/w9mr+YZhhyQL
	2EEZJN9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4W-0000000GET9-3lku;
	Tue, 18 Nov 2025 05:16:08 +0000
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
	bpf@vger.kernel.org,
	clm@meta.com
Subject: [PATCH v4 35/54] convert selinuxfs
Date: Tue, 18 Nov 2025 05:15:44 +0000
Message-ID: <20251118051604.3868588-36-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Tree has invariant part + two subtrees that get replaced upon each
policy load.  Invariant parts stay for the lifetime of filesystem,
these two subdirs - from policy load to policy load (serialized
on lock_rename(root, ...)).

All object creations are via d_alloc_name()+d_add() inside selinuxfs,
all removals are via simple_recursive_removal().

Turn those d_add() into d_make_persistent()+dput() and that's mostly it.

Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/selinux/selinuxfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f088776dbbd3..eae565358db4 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1205,7 +1205,8 @@ static struct dentry *sel_attach(struct dentry *parent, const char *name,
 		iput(inode);
 		return ERR_PTR(-ENOMEM);
 	}
-	d_add(dentry, inode);
+	d_make_persistent(dentry, inode);
+	dput(dentry);
 	return dentry;
 }
 
@@ -1934,10 +1935,11 @@ static struct dentry *sel_make_swapover_dir(struct super_block *sb,
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	inode_lock(sb->s_root->d_inode);
-	d_add(dentry, inode);
+	d_make_persistent(dentry, inode);
 	inc_nlink(sb->s_root->d_inode);
 	inode_unlock(sb->s_root->d_inode);
-	return dentry;
+	dput(dentry);
+	return dentry;	// borrowed
 }
 
 #define NULL_FILE_NAME "null"
@@ -2080,7 +2082,7 @@ static int sel_init_fs_context(struct fs_context *fc)
 static void sel_kill_sb(struct super_block *sb)
 {
 	selinux_fs_info_free(sb);
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 }
 
 static struct file_system_type sel_fs_type = {
-- 
2.47.3


