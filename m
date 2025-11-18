Return-Path: <linux-fsdevel+bounces-68880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6239C67966
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A6A8029E2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C42C2D738F;
	Tue, 18 Nov 2025 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="W02RSBpz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F96225A35;
	Tue, 18 Nov 2025 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763444540; cv=none; b=OqXvxJ4L00Em5Dz11jrL6wjbp939h4hzm+liWOTFXGpyykRXyWmrd6IDR6etYXm6rbP29c9/IPYL5kF7n/sPOtRVdlVKEcvjbKTsnYYLJH8D5pHcG+pRQDvvSbDKEO97Z5ntx9Puyfi4zRRHd73iqCJoEBwmWsehfzyRpsttZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763444540; c=relaxed/simple;
	bh=EPwXfKzUq6WB4Lo0fSXpMaiMt3x+BzpT0g03SMuKZHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2VY6ZZSlODJ91AvYDEsKgNpOwXOfL1jbKE89Y8U/2jzUKnPDDQzlPACXaniR6tiJAg18aCmqaQsKpA6yf2n2CeHoZrglUyVa76XDqx+kPb0EopxZYx30YR0ESpyaZbvZ9BX8mE43rz0BgUQEezBSMaQ/hOJtf+Yz7w1Ro+jApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=W02RSBpz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=q+YJfK1JQC1qMGUqrxdt1F1Oxcx2pv8iNDDBzggBjk0=; b=W02RSBpzlMqLVn0YEvFbpQLGIB
	B1xtSWS2Xpn5FsRTVUCuXxS441ywMkx4Q4tChzkjpM7OdOos6vsjpmlA1Z2zqliUAdAeOUrCkl4yA
	twLanctiYTm2TrhF2JuqprNKCx5C1OgDEb5VhVrEDOG4oYqHSyhhlHLvUdR7ySIDu1QcIqufjvDFz
	fg3BoTHlt4zzzoBRHhd9UFriLRJjA2XkCxlzuQgjqFrQEqBFrbljk+W561fXXGncu3vcxrWfCZ3rA
	av77KdzetMrnx0X53ANKFtJe4tSqLpECx0Ve4j/MSoRKo15Xs40u5Op0OOtatpBT+hfkjzgtievvq
	B+fD3mwg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4b-0000000GEl1-2wuq;
	Tue, 18 Nov 2025 05:16:13 +0000
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
Subject: [PATCH v4 54/54] d_make_discardable(): warn if given a non-persistent dentry
Date: Tue, 18 Nov 2025 05:16:03 +0000
Message-ID: <20251118051604.3868588-55-viro@zeniv.linux.org.uk>
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

At this point there are very few call chains that might lead to
d_make_discardable() on a dentry that hadn't been made persistent:
calls of simple_unlink() and simple_rmdir() in configfs and
apparmorfs.

Both filesystems do pin (part of) their contents in dcache, but
they are currently playing very unusual games with that.  Converting
them to more usual patterns might be possible, but it's definitely
going to be a long series of changes in both cases.

For now the easiest solution is to have both stop using simple_unlink()
and simple_rmdir() - that allows to make d_make_discardable() warn
when given a non-persistent dentry.

Rather than giving them full-blown private copies (with calls of
d_make_discardable() replaced with dput()), let's pull the parts of
simple_unlink() and simple_rmdir() that deal with timestamps and link
counts into separate helpers (__simple_unlink() and __simple_rmdir()
resp.) and have those used by configfs and apparmorfs.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c              | 10 ++++++++--
 fs/configfs/inode.c            |  3 ++-
 fs/dcache.c                    |  9 +--------
 fs/libfs.c                     | 21 +++++++++++++++++----
 include/linux/fs.h             |  2 ++
 security/apparmor/apparmorfs.c | 13 +++++++++----
 6 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 81f4f06bc87e..e8f2f44012e9 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -400,8 +400,14 @@ static void remove_dir(struct dentry * d)
 
 	configfs_remove_dirent(d);
 
-	if (d_really_is_positive(d))
-		simple_rmdir(d_inode(parent),d);
+	if (d_really_is_positive(d)) {
+		if (likely(simple_empty(d))) {
+			__simple_rmdir(d_inode(parent),d);
+			dput(d);
+		} else {
+			pr_warn("remove_dir (%pd): attributes remain", d);
+		}
+	}
 
 	pr_debug(" o %pd removing done (%d)\n", d, d_count(d));
 
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index 1d2e3a5738d1..bcda3372e141 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -211,7 +211,8 @@ void configfs_drop_dentry(struct configfs_dirent * sd, struct dentry * parent)
 			dget_dlock(dentry);
 			__d_drop(dentry);
 			spin_unlock(&dentry->d_lock);
-			simple_unlink(d_inode(parent), dentry);
+			__simple_unlink(d_inode(parent), dentry);
+			dput(dentry);
 		} else
 			spin_unlock(&dentry->d_lock);
 	}
diff --git a/fs/dcache.c b/fs/dcache.c
index 5ee2e78a91b3..824d620bb563 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -931,14 +931,7 @@ EXPORT_SYMBOL(dput);
 void d_make_discardable(struct dentry *dentry)
 {
 	spin_lock(&dentry->d_lock);
-	/*
-	 * By the end of the series we'll add
-	 * WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT);
-	 * here, but while object removal is done by a few common helpers,
-	 * object creation tends to be open-coded (if nothing else, new inode
-	 * needs to be set up), so adding a warning from the very beginning
-	 * would make for much messier patch series.
-	 */
+	WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT));
 	dentry->d_flags &= ~DCACHE_PERSISTENT;
 	dentry->d_lockref.count--;
 	rcu_read_lock();
diff --git a/fs/libfs.c b/fs/libfs.c
index 80f288a771e3..0aa630e7eb00 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -790,13 +790,27 @@ int simple_empty(struct dentry *dentry)
 }
 EXPORT_SYMBOL(simple_empty);
 
-int simple_unlink(struct inode *dir, struct dentry *dentry)
+void __simple_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 
 	inode_set_mtime_to_ts(dir,
 			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
 	drop_nlink(inode);
+}
+EXPORT_SYMBOL(__simple_unlink);
+
+void __simple_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	drop_nlink(d_inode(dentry));
+	__simple_unlink(dir, dentry);
+	drop_nlink(dir);
+}
+EXPORT_SYMBOL(__simple_rmdir);
+
+int simple_unlink(struct inode *dir, struct dentry *dentry)
+{
+	__simple_unlink(dir, dentry);
 	d_make_discardable(dentry);
 	return 0;
 }
@@ -807,9 +821,8 @@ int simple_rmdir(struct inode *dir, struct dentry *dentry)
 	if (!simple_empty(dentry))
 		return -ENOTEMPTY;
 
-	drop_nlink(d_inode(dentry));
-	simple_unlink(dir, dentry);
-	drop_nlink(dir);
+	__simple_rmdir(dir, dentry);
+	d_make_discardable(dentry);
 	return 0;
 }
 EXPORT_SYMBOL(simple_rmdir);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 95933ceaae51..ef842adbd418 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3621,6 +3621,8 @@ extern int simple_open(struct inode *inode, struct file *file);
 extern int simple_link(struct dentry *, struct inode *, struct dentry *);
 extern int simple_unlink(struct inode *, struct dentry *);
 extern int simple_rmdir(struct inode *, struct dentry *);
+extern void __simple_unlink(struct inode *, struct dentry *);
+extern void __simple_rmdir(struct inode *, struct dentry *);
 void simple_rename_timestamp(struct inode *old_dir, struct dentry *old_dentry,
 			     struct inode *new_dir, struct dentry *new_dentry);
 extern int simple_rename_exchange(struct inode *old_dir, struct dentry *old_dentry,
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 391a586d0557..9b9090d38ea2 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -358,10 +358,15 @@ static void aafs_remove(struct dentry *dentry)
 	dir = d_inode(dentry->d_parent);
 	inode_lock(dir);
 	if (simple_positive(dentry)) {
-		if (d_is_dir(dentry))
-			simple_rmdir(dir, dentry);
-		else
-			simple_unlink(dir, dentry);
+		if (d_is_dir(dentry)) {
+			if (!WARN_ON(!simple_empty(dentry))) {
+				__simple_rmdir(dir, dentry);
+				dput(dentry);
+			}
+		} else {
+			__simple_unlink(dir, dentry);
+			dput(dentry);
+		}
 		d_delete(dentry);
 		dput(dentry);
 	}
-- 
2.47.3


