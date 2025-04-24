Return-Path: <linux-fsdevel+bounces-47155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557CEA9A0F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF105A1555
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284CB1D9324;
	Thu, 24 Apr 2025 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hs0H+ACA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C612701B8;
	Thu, 24 Apr 2025 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474932; cv=none; b=nW6oiDTwqqngu3xrSiZSlUnjEmZPyP5mnPmDEzJfPaJOEM0y/KFzHBBxz8M57l4cmbETuti7F9ymq6uVfFLCQFa8sPidYxgKuNe3zr0ua9ZW9UeSRWgCkFXFQelp6OAIk0CiW2Mt+hK4SD2pLRdsBk3UJ8ZJxpsQWN/E7L7cTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474932; c=relaxed/simple;
	bh=z69nq/MgzN2SYK20L3oEeyyjXxTnvMQZRovZMTQvL/k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oHpCrGJrC6bK3R1tky37oORZdQO9dASvTu13nJqhOmCSgSOZKHHFnYNn4zn0VzSKBonyt4jDyCdzHGoqRRA5Sxo7cAx/OeG2dDIL1exXx/ym7LR7iUMprgDJ5hOl7qs/8zmcUb2W/a5Kt0a/nby7WSfKMvabTvWHY0u9WXbD674=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hs0H+ACA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JPduwAvc1gp12G5xqoy89t/41gjq88tVopAmX2Kdf4I=; b=hs0H+ACAV5Xibgg0fcNkSXqJ96
	0wEf5vzPZAau1MS9pcIoslbMkWbSHCK6fddoc7L13S6Y4JrtVBX+DV/fcMc1YQ/0Apuo+xT9Ge/VI
	sbW2OWYdYS8Bofwqej9oJCBCR+36BZi8Yrk06Jmb+rET8Jlqck1Ukiy2xepydG3shpjzdtBZ2DzVE
	p/G09Nx/geyb+/B1F75QavBiKkZwnE68+C9Sj9qVVVBlzF9+olsQ4u/ITKYtx7rYLileh61Sh8a4D
	/Yp8ZUmcM7/e6LvCg99iAZTfgsdspYXVw7/KXcgHKlQUmD+SHiFOXEdFhDawzrwxckGdGO3GFybhi
	gNX50wMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7plN-0000000EDVB-0HVK;
	Thu, 24 Apr 2025 06:08:45 +0000
Date: Thu, 24 Apr 2025 07:08:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: [RFC][PATCH] saner calling conventions for ->d_automount()
Message-ID: <20250424060845.GG2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Currently the calling conventions for ->d_automount() instances have
an odd wart - returned new mount to be attached is expected to have
refcount 2.

That kludge is intended to make sure that mark_mounts_for_expiry() called
before we get around to attaching that new mount to the tree won't decide
to take it out.  finish_automount() drops the extra reference after it's
done with attaching mount to the tree - or drops the reference twice in
case of error.  ->d_automount() instances have rather counterintuitive
boilerplate in them.

There's a much simpler approach: have mark_mounts_for_expiry() skip the
mounts that are yet to be mounted.  And to hell with grabbing/dropping
those extra references.  Makes for simpler correctness analysis, at that...
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 767b2927c762..749637231773 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1203,3 +1203,10 @@ should use d_drop();d_splice_alias() and return the result of the latter.
 If a positive dentry cannot be returned for some reason, in-kernel
 clients such as cachefiles, nfsd, smb/server may not perform ideally but
 will fail-safe.
+
+---
+
+**mandatory**
+
+Calling conventions for ->d_automount() have changed; we should *not* grab
+an extra reference to new mount - it should be returned with refcount 1.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index ae79c30b6c0c..cc0a58e96770 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1411,9 +1411,7 @@ defined:
 
 	If a vfsmount is returned, the caller will attempt to mount it
 	on the mountpoint and will remove the vfsmount from its
-	expiration list in the case of failure.  The vfsmount should be
-	returned with 2 refs on it to prevent automatic expiration - the
-	caller will clean up the additional ref.
+	expiration list in the case of failure.
 
 	This function is only used if DCACHE_NEED_AUTOMOUNT is set on
 	the dentry.  This is set by __d_instantiate() if S_AUTOMOUNT is
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 45cee6534122..9434a5399f2b 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -189,7 +189,6 @@ struct vfsmount *afs_d_automount(struct path *path)
 	if (IS_ERR(newmnt))
 		return newmnt;
 
-	mntget(newmnt); /* prevent immediate expiration */
 	mnt_set_expiry(newmnt, &afs_vfsmounts);
 	queue_delayed_work(afs_wq, &afs_mntpt_expiry_timer,
 			   afs_mntpt_expiry_timeout * HZ);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 83ac192e7fdd..05d8584fd3b9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -319,9 +319,6 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 
 	/* Create the submount */
 	mnt = fc_mount(fsc);
-	if (!IS_ERR(mnt))
-		mntget(mnt);
-
 	put_fs_context(fsc);
 	return mnt;
 }
diff --git a/fs/namespace.c b/fs/namespace.c
index bbda516444ff..1807ccb1a52d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3903,10 +3903,6 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 		return PTR_ERR(m);
 
 	mnt = real_mount(m);
-	/* The new mount record should have at least 2 refs to prevent it being
-	 * expired before we get a chance to add it
-	 */
-	BUG_ON(mnt_get_count(mnt) < 2);
 
 	if (m->mnt_sb == path->mnt->mnt_sb &&
 	    m->mnt_root == dentry) {
@@ -3939,7 +3935,6 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 	unlock_mount(mp);
 	if (unlikely(err))
 		goto discard;
-	mntput(m);
 	return 0;
 
 discard_locked:
@@ -3953,7 +3948,6 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 		namespace_unlock();
 	}
 	mntput(m);
-	mntput(m);
 	return err;
 }
 
@@ -3990,11 +3984,14 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 
 	/* extract from the expiration list every vfsmount that matches the
 	 * following criteria:
+	 * - already mounted
 	 * - only referenced by its parent vfsmount
 	 * - still marked for expiry (marked on the last call here; marks are
 	 *   cleared by mntput())
 	 */
 	list_for_each_entry_safe(mnt, next, mounts, mnt_expire) {
+		if (!is_mounted(&mnt->mnt))
+			continue;
 		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
 			propagate_mount_busy(mnt, 1))
 			continue;
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 973aed9cc5fe..7f1ec9c67ff2 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -195,7 +195,6 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	if (IS_ERR(mnt))
 		goto out_fc;
 
-	mntget(mnt); /* prevent immediate expiration */
 	if (timeout <= 0)
 		goto out_fc;
 
diff --git a/fs/smb/client/namespace.c b/fs/smb/client/namespace.c
index e3f9213131c4..778daf11f1db 100644
--- a/fs/smb/client/namespace.c
+++ b/fs/smb/client/namespace.c
@@ -283,7 +283,6 @@ struct vfsmount *cifs_d_automount(struct path *path)
 		return newmnt;
 	}
 
-	mntget(newmnt); /* prevent immediate expiration */
 	mnt_set_expiry(newmnt, &cifs_automount_list);
 	schedule_delayed_work(&cifs_automount_task,
 			      cifs_mountpoint_expiry_timeout);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ddf6b17215c..fa488721019f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10085,8 +10085,6 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 	put_filesystem(type);
 	if (IS_ERR(mnt))
 		return NULL;
-	mntget(mnt);
-
 	return mnt;
 }
 

