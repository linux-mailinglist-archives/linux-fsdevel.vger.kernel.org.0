Return-Path: <linux-fsdevel+bounces-67807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ED3C4BDD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D521897DF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 06:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24C634FF5A;
	Tue, 11 Nov 2025 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OsRGle84"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3471344037;
	Tue, 11 Nov 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844131; cv=none; b=EWx0gVbhp4H7gle+pI5t92CEIq6U9IDK+3Oe5VZBRV0Kvbhrhw89FVXVjuC2mS7RXjTPMcoV1Ml6quCA0qqlldK6vr+bY2M5KpH4+TE281J5u5LldMwPz09IPtmdr84L747XF6fIxoVw+5Pq7JiKuWKL0bWxP3gTs2Odhp1w67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844131; c=relaxed/simple;
	bh=X6JFnoVtKD57NvZa94J2H+MWO1OHhaAUlhfoIPR5JFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsMTLyTv2TmVqlLSCp4yfOXP2den+syeDZ726+Mhix9AxGdXKNRdOnzF5frC29ovvjVgcFhdSmJYcsI032jPh8nigrm1ZT9amXBH3Vm7CvEs+eoF35jN7IlGlqr946i1amFUrCst54M0551BF7VQMwqJbeJqQIabmXtR5JJ4bbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OsRGle84; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bkByHERsS9JuCtqGS9wCvZ7R+EhcIoCC8ci4VG063fc=; b=OsRGle84xX6lCMsOqbmX88O9Vv
	QCGMmghlcMX+6qLKlD9YKtDKt/l7fD3/fJuRQCcxCewWhB6+puUIARCAP4cdHhdwrk97PNTrKy26Q
	8csjifXGqpFVsO9ko9DNm/2juQyXZvXFmkWFAeWU+31WAdIv7cfWan9d4z/6lgn5AjPSiVVRTdXaU
	VhylboWKmDvf+1FPY/jegeXzt69CLtlo6J62v6F96sm5LguMFUuvDL6c0RASnXkK+tYJuZ/c+7FMb
	jUPSTT+hCcfBeXvrWHIi3KnwppTrUqUdM5EsI3H7rnVi1AuKn23uRGHjcgBa/LO4606zdkJpk/K1m
	OCyq9HEQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHk-0000000Bwyi-0fof;
	Tue, 11 Nov 2025 06:55:24 +0000
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
Subject: [PATCH v3 19/50] convert tracefs
Date: Tue, 11 Nov 2025 06:54:48 +0000
Message-ID: <20251111065520.2847791-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
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
d_make_persistent() + dput() (the latter in tracefs_end_creating(),
where it folds with inode_unlock() into simple_done_creating())
for dentries we want persistent and have d_make_discardable() done
either by simple_recursive_removal() (used by tracefs_remove())
or explicitly in eventfs_remove_events_dir().

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/tracefs/event_inode.c |  4 ++--
 fs/tracefs/inode.c       | 13 ++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 93c231601c8e..61cbdafa2411 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -823,7 +823,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	 * something not worth much. Keeping directory links at 1
 	 * tells userspace not to trust the link number.
 	 */
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	/* The dentry of the "events" parent does keep track though */
 	inc_nlink(dentry->d_parent->d_inode);
 	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
@@ -910,5 +910,5 @@ void eventfs_remove_events_dir(struct eventfs_inode *ei)
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


