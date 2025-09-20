Return-Path: <linux-fsdevel+bounces-62290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F22B8C27E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1B5189ACFD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCB02EB843;
	Sat, 20 Sep 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qGj6Qd1X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963EA2750E3;
	Sat, 20 Sep 2025 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354486; cv=none; b=K1kEhWKcB7a/rNlIf9LdPhP6gWr8s1jXs5pwmdH7r40Wwk/9wUj8/170K4Y7PwHh0dCsWXriIkfXe9xnbPnBFDQd1IdmkbQqVb3O90r6GpaR7poYcGi28+yzlr8ETO9i9xrtv4sdiSRvqvepLpnEJzqNX42FY0Krv+nhWZNaXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354486; c=relaxed/simple;
	bh=YmZqWUq8u6ZfTRwJbe8umAhD025q3PVcY+114B2Efjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5qVZ2pXMwswtTtcjGbE3VwZezHsP/MhE/usmuR6GbH0u9rHukuoJZlPUeRuJ8xlsbOXNkk4bQc9sgXgvvEKnLoQxT3nZlAj7wkTvDTqk6nfOwEvQUMgQkyds7xDFBvQBj1A91CubN3j+TlADKWaaIRHqoBnwXen4EZ6Y2vddD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qGj6Qd1X; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Jq+EXFMBexcz4hv/+ZNoaAPHC7nvuwAoAqAXIzjgm4M=; b=qGj6Qd1XokjgMX/A4lEawqmYbu
	alL8tqwhPjue0tgBhcw5Sxy03lWJ9m4wYHo8xpUh6q7TL4jvi4RXrVFQduGY/HeoSj35Rp3FAJo25
	SXacEAK2QID+FsbpDJovwzlVS91WcOd014dnZTSLqhX2qlY4iAWnohdDimuQDnuVlWYiGnUHnOeVw
	Hg42qAQRgnJT3pTXZaons3ZMCLfS4632o4CT9VwcEoJqZsnfn1m/PmU7lbwm24o2FbJ+PWDjslSt0
	OSeamM/KE7vwJygDI7gO78JIO7vikOagNTXVm+td9MSFXYm5tlwg4JLZI/wHwfUKbdatHjWohc7dy
	NO+YlZ9w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsKA-0000000ExEW-2fN4;
	Sat, 20 Sep 2025 07:48:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
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
	borntraeger@linux.ibm.com
Subject: [PATCH 17/39] convert tracefs
Date: Sat, 20 Sep 2025 08:47:36 +0100
Message-ID: <20250920074759.3564072-17-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

A mix of persistent and non-persistent dentries in there.  Strictly
speaking, no need for kill_litter_super() anyway - it pins an internal
mount whenever a persistent dentry is created, so at fs shutdown time
there won't be any to deal with.

However, let's make it explicit - replace d_instantiate() with
d_make_persistent() + dput() (the latter in tracefs_end_creating())
for dentries we want persistent and have d_make_discardable() done
either by simple_recursive_removal() (used by tracefs_remove())
or explicitly in eventfs_remove_events_dir().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/tracefs/event_inode.c |  4 ++--
 fs/tracefs/inode.c       | 13 ++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 8705c77a9e75..97bb0a79b0cd 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -822,7 +822,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	 * something not worth much. Keeping directory links at 1
 	 * tells userspace not to trust the link number.
 	 */
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	/* The dentry of the "events" parent does keep track though */
 	inc_nlink(dentry->d_parent->d_inode);
 	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
@@ -909,5 +909,5 @@ void eventfs_remove_events_dir(struct eventfs_inode *ei)
 	 * and destroyed dynamically.
 	 */
 	d_invalidate(dentry);
-	dput(dentry);
+	d_make_discardable(dentry);
 }
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 0c023941a316..d9d8932a7b9c 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -538,7 +538,7 @@ static struct file_system_type trace_fs_type = {
 	.name =		"tracefs",
 	.init_fs_context = tracefs_init_fs_context,
 	.parameters	= tracefs_param_specs,
-	.kill_sb =	kill_litter_super,
+	.kill_sb =	kill_anon_super,
 };
 MODULE_ALIAS_FS("tracefs");
 
@@ -571,16 +571,15 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
 
 struct dentry *tracefs_failed_creating(struct dentry *dentry)
 {
-	inode_unlock(d_inode(dentry->d_parent));
-	dput(dentry);
+	simple_done_creating(dentry);
 	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
 	return NULL;
 }
 
 struct dentry *tracefs_end_creating(struct dentry *dentry)
 {
-	inode_unlock(d_inode(dentry->d_parent));
-	return dentry;
+	simple_done_creating(dentry);
+	return dentry;	// borrowed
 }
 
 /* Find the inode that this will use for default */
@@ -661,7 +660,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	inode->i_private = data;
 	inode->i_uid = d_inode(dentry->d_parent)->i_uid;
 	inode->i_gid = d_inode(dentry->d_parent)->i_gid;
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
 	return tracefs_end_creating(dentry);
 }
@@ -692,7 +691,7 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
 	return tracefs_end_creating(dentry);
-- 
2.47.3


