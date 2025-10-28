Return-Path: <linux-fsdevel+bounces-65821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB05FC12533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 01:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D347A1A60F15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 00:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0422F12DC;
	Tue, 28 Oct 2025 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tX1rzPoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB21A3BD7;
	Tue, 28 Oct 2025 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612386; cv=none; b=tkIdqIJFuW16gar+jdmLDwdar3Y2GXpW8pkJ3mnkEqmegQHDQ5Bk2SElvz1MTdaL9jr9XPt9LSzdNIaEQl7j67N6DkRjd4ROc41TfLEMF4hYPiirHOv1CMKXdFKOM3iZdd8hXXKX0Dc4h2+9SDLpr/l3qJVEoY59zb49al2JAvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612386; c=relaxed/simple;
	bh=YoozF3VZOUiY0NlNthkA1W6gLLvE1VxCvuQZJus7ATM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PF4i/szam0kKh3i2t+1J7AF0knDX8ZD8jGiIV81bUl8kg+UYS6ysBf1ih0gtqTJZJx0hBqOfgSCvcb5xyKV2pSSztOKB44W9oVaY+hSS7FgFyioTD5zt+BYvIFE+RsGKfpejHhdhxe1LFUfOcKGtH4swuJeN7hUOK003ryTfN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tX1rzPoI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yVog1JmPQq1AS/UVL7zjpUgX0UVPwCD5iHtdu2BZv2o=; b=tX1rzPoI/1o1o090qccKpgmnIE
	QqiR/xhjlRjUmW7P9jea5A6shY5HqE9KAWb7Aqgf2296vLnngrmPdFJsxX3IxxxyWHrjaMn+N16oN
	rkurUHdU0P3hehk92336DnZJ9QnK8zPyusTON5Bbz2ckKFCM4fnyBbkJ/cU1fRgZQHpMGPCCQcQeY
	dutnAhQTWa4V1Ifp8AjvhXoZuQ0T2Jp/GKhtwBw3kZ5rPDZJ35ICGa3HdKklj18biB+1ElMvcIRXL
	kxjqEJOJ3VWSbc3NdfMYVGFKkJSqF0KCaE1zJBpWjyJ2F5k16luWywgXZRm1Z23svR4xtIMDDVYST
	0bX1WSmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqs-00000001ea7-1K8h;
	Tue, 28 Oct 2025 00:46:18 +0000
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
Subject: [PATCH v2 35/50] convert selinuxfs
Date: Tue, 28 Oct 2025 00:45:54 +0000
Message-ID: <20251028004614.393374-36-viro@zeniv.linux.org.uk>
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

Tree has invariant part + two subtrees that get replaced upon each
policy load.  Invariant parts stay for the lifetime of filesystem,
these two subdirs - from policy load to policy load (serialized
on lock_rename(root, ...)).

All object creations are via d_alloc_name()+d_add() inside selinuxfs,
all removals are via simple_recursive_removal().

Turn those d_add() into d_make_persistent()+dput() and that's mostly it.

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


