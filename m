Return-Path: <linux-fsdevel+bounces-59152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279B2B35122
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 03:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5E4207825
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 01:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191F41F418F;
	Tue, 26 Aug 2025 01:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hWVkL5LU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF71F956
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172698; cv=none; b=Yqehm56rdsf2zpdWNs++6jVSJG+xQjyQo2uJBfbCDw68E0SrQoch+asIJLcu24VJTbpurVjJ+YPL95pCHY/vTiLNMyjwCEuAciJ9a0Kl/CN4HIlG9AjUdbRy2jgIcrqmmGtcq7kuO7jRoatRqr3nhi+0RBgXlnIe3E3LyGXvoQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172698; c=relaxed/simple;
	bh=rxwZGPyF6MqVPAQO+Bn7Mygjj9381iHA/lkCsg62E/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGtxD4otbYmDsE2ZZ/D7Z1FInj4rDokpeb7ksrzZlw796ReW/kVfta/vNFWcgJlJhyICGUmhpdBIbnVKttmCU/xLO4wGKNulk1Q6RVAdjvN6w6UaSYOSmxoqQY/e1PjmfcW7GBSdhUevqvM4daGzwobefK5jgjwszy0IS6Ql+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hWVkL5LU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V6AFgfk8z7kxOfNnNIwAn1hWf+Nomtm4lr4AY3EkC0s=; b=hWVkL5LUMrmXvOs0brRD4VjWlV
	Jvys/btStkS+FwtCdOHWI0fTMfudhIAAKlVX4I8fH3zJCSQrZ1Akqpv8SxjnQZL2O/fD0CY6Zh9rc
	oKjkiWbiNw/3HMRHd5ARARVqgUAM1l44wJEwyOpSpHyo+fCLvtiLA4y6Poiy/av0TmIZaSKoph45M
	c1fMPBXoBtxm7PpLSheLAictZgTTenR39C9bTzcJg//R2FILzpGpLpn5okxjBPZegiDoEU8mZFC/Y
	HGc5iiLE7ZyLct6IjXm4lH+hCdi5jxqTUWAU02dAtUhDPGIxspvNrEmt6NJE0gwhjD79aUWclGp/9
	eekSm/zA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqik1-000000075Qk-14GX;
	Tue, 26 Aug 2025 01:44:53 +0000
Date: Tue, 26 Aug 2025 02:44:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 02/52] introduced guards for mount_lock
Message-ID: <20250826014453.GA1667359@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-2-viro@zeniv.linux.org.uk>
 <20250825-repressiv-selektiert-7496db0b38aa@brauner>
 <20250825134604.GJ39973@ZenIV>
 <20250825202141.GA220312@ZenIV>
 <20250825234413.GR39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825234413.GR39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 26, 2025 at 12:44:13AM +0100, Al Viro wrote:

> As for the second, couldn't we simply use !list_empty(&ns->mnt_ns_list)
> as a condition?  And avoiding an RCU delay... nice, in principle, but
> the case when that would've saved us anything is CLONE_NEWNS clone(2) or
> unshare(2) failing due to severe OOM.  Do we give a damn about one extra
> call_rcu() for each of such failures?
> 
> mnt_ns_tree handling is your code; do you see any problems with

... this (on top of the posted series, needs to be carved into several parts -
dropping pointless lock_mount_hash() in open_detached_copy(), making
mnt_ns_tree_remove() and thus free_mnt_ns() safe to use on ns not in mnt_ns_tree
yet, then dealing with open_detached_copy() and copy_mnt_ns() separately):

diff --git a/fs/namespace.c b/fs/namespace.c
index 63b74d7384fd..b77469789f82 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -195,7 +195,7 @@ static void mnt_ns_release_rcu(struct rcu_head *rcu)
 static void mnt_ns_tree_remove(struct mnt_namespace *ns)
 {
 	/* remove from global mount namespace list */
-	if (!is_anon_ns(ns)) {
+	if (!list_empty(&ns->mnt_ns_list)) {
 		mnt_ns_tree_write_lock();
 		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
 		list_bidir_del_rcu(&ns->mnt_ns_list);
@@ -3053,18 +3053,17 @@ static int do_loopback(const struct path *path, const char *old_name,
 	return err;
 }
 
-static struct file *open_detached_copy(struct path *path, bool recursive)
+static struct mnt_namespace *get_detached_copy(const struct path *path, bool recursive)
 {
 	struct mnt_namespace *ns, *mnt_ns = current->nsproxy->mnt_ns, *src_mnt_ns;
 	struct user_namespace *user_ns = mnt_ns->user_ns;
 	struct mount *mnt, *p;
-	struct file *file;
 
 	ns = alloc_mnt_ns(user_ns, true);
 	if (IS_ERR(ns))
-		return ERR_CAST(ns);
+		return ns;
 
-	namespace_lock();
+	guard(namespace_excl)();
 
 	/*
 	 * Record the sequence number of the source mount namespace.
@@ -3081,23 +3080,28 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 
 	mnt = __do_loopback(path, recursive);
 	if (IS_ERR(mnt)) {
-		namespace_unlock();
-		free_mnt_ns(ns);
+		emptied_ns = ns;
 		return ERR_CAST(mnt);
 	}
 
-	lock_mount_hash();
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
 		mnt_add_to_ns(ns, p);
 		ns->nr_mounts++;
 	}
 	ns->root = mnt;
-	mntget(&mnt->mnt);
-	unlock_mount_hash();
-	namespace_unlock();
+	return ns;
+}
+
+static struct file *open_detached_copy(struct path *path, bool recursive)
+{
+	struct mnt_namespace *ns = get_detached_copy(path, recursive);
+	struct file *file;
+
+	if (IS_ERR(ns))
+		return ERR_CAST(ns);
 
 	mntput(path->mnt);
-	path->mnt = &mnt->mnt;
+	path->mnt = mntget(&ns->root->mnt);
 	file = dentry_open(path, O_PATH, current_cred());
 	if (IS_ERR(file))
 		dissolve_on_fput(path->mnt);
@@ -4165,7 +4169,8 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		struct user_namespace *user_ns, struct fs_struct *new_fs)
 {
 	struct mnt_namespace *new_ns;
-	struct vfsmount *rootmnt = NULL, *pwdmnt = NULL;
+	struct vfsmount *rootmnt __free(mntput)= NULL;
+	struct vfsmount *pwdmnt __free(mntput) = NULL;
 	struct mount *p, *q;
 	struct mount *old;
 	struct mount *new;
@@ -4184,23 +4189,20 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	if (IS_ERR(new_ns))
 		return new_ns;
 
-	namespace_lock();
+	guard(namespace_excl)();
 	/* First pass: copy the tree topology */
 	copy_flags = CL_COPY_UNBINDABLE | CL_EXPIRE;
 	if (user_ns != ns->user_ns)
 		copy_flags |= CL_SLAVE;
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
-		namespace_unlock();
-		ns_free_inum(&new_ns->ns);
-		dec_mnt_namespaces(new_ns->ucounts);
-		mnt_ns_release(new_ns);
+		emptied_ns = new_ns;
 		return ERR_CAST(new);
 	}
+
 	if (user_ns != ns->user_ns) {
-		lock_mount_hash();
-		lock_mnt_tree(new);
-		unlock_mount_hash();
+		scoped_guard(mount_writer)
+			lock_mnt_tree(new);
 	}
 	new_ns->root = new;
 
@@ -4232,12 +4234,6 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		while (p->mnt.mnt_root != q->mnt.mnt_root)
 			p = next_mnt(skip_mnt_tree(p), old);
 	}
-	namespace_unlock();
-
-	if (rootmnt)
-		mntput(rootmnt);
-	if (pwdmnt)
-		mntput(pwdmnt);
 
 	mnt_ns_tree_add(new_ns);
 	return new_ns;

