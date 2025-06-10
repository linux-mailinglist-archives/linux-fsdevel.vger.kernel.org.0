Return-Path: <linux-fsdevel+bounces-51140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED8AD3017
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E59C3B66B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111D6284669;
	Tue, 10 Jun 2025 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TAGNzUfo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9362820AD
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543716; cv=none; b=IjoCQU8qtHNoZjla6Yncs4PhBsTei2v9G0KiwlNInTHc7CY2ZxDIqamjRAMTfJwfXYLVuPdbkHVR0R9xto6YeSkGYZHY0heXdqL3rrEqbZIdkT0l4+uBRIOkBOSkkrSnhQWfGnSkHOM1Ctoa0ZTXbqB01/2JZMNi2c/73etV3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543716; c=relaxed/simple;
	bh=Re+KG/epDjdZJUIpOosnl61wZpKcvQUAUhyd9fxCXlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcWxJe9ommukDFSm+nhjognesDMz3LnS1zawgXtElT+ZQLCMXMiDbTsoLaIIn+wF+dtf1Xy2/HyZHK5fk4+LFyTAcliPNMFK2NOHpE/jXUD1b2EZS8BaQdjbIvorV2NFlBa8SjvR2cqlteAOKTa79/ZClz6RwgKmlXTrGrJgp68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TAGNzUfo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uBUyJZH1eJXDxBniBdVQgKuo0ApXSP/1ytw8qwvPHB8=; b=TAGNzUfoigGqPyRfol4oiJOR6V
	rbhGx3geqfDfY/k1vN0GUg0eWaOuC/n/rJYn5Y3Aa4KxS84ptMcdSaJUq1Z8nNMFrNmKpbVTnaUej
	c5ia4I20XiHXRqtjSZg6XRFm64iRMvtk8BJCc9l6li4UQW3Zj99ZFFtupak+rtnDcBpGobSi6wlRR
	jttz0SsgaoFvtNmd2baczTmoWDWR9e0VlIlR0u9jLnPY+Av/bQkhIHKWoePGPtdCT2245IyQVxwSK
	5k/oB5vGCAwPlAh0Rm5YF/j2ZzTcdi0/OBj2KcKYlXRHr+K4XVUmpSJIFu4A8j27L16suhOKHkkzl
	+YQrxGxw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEy-00000004jOY-1c34;
	Tue, 10 Jun 2025 08:21:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 22/26] take ->mnt_expire handling under mount_lock [read_seqlock_excl]
Date: Tue, 10 Jun 2025 09:21:44 +0100
Message-ID: <20250610082148.1127550-22-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Doesn't take much massage, and we no longer need to make sure that
by the time of final mntput() the victim has been removed from the
list.  Makes life safer for ->d_automount() instances...

Rules:
	* all ->mnt_expire accesses are under mount_lock.
	* insertion into the list is done by mnt_set_expiry(), and
caller (->d_automount() instance) must hold a reference to mount
in question.  It shouldn't be done more than once for a mount.
	* if a mount on an expiry list is not yet mounted, it will
be ignored by anything that walks that list.
	* if the final mntput() finds its victim still on an expiry
list (in which case it must've never been mounted - umount_tree()
would've taken it out), it will remove the victim from the list.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d9ad214b3fec..7df00ed26db5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1347,13 +1347,6 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 		list_add(&mnt->mnt_slave, &old->mnt_slave);
 		mnt->mnt_master = old->mnt_master;
 	}
-
-	/* stick the duplicate mount on the same expiry list
-	 * as the original if that was on one */
-	if (flag & CL_EXPIRE) {
-		if (!list_empty(&old->mnt_expire))
-			list_add(&mnt->mnt_expire, &old->mnt_expire);
-	}
 	return mnt;
 
  out_free:
@@ -1446,6 +1439,8 @@ static void mntput_no_expire(struct mount *mnt)
 	rcu_read_unlock();
 
 	list_del(&mnt->mnt_instance);
+	if (unlikely(!list_empty(&mnt->mnt_expire)))
+		list_del(&mnt->mnt_expire);
 
 	if (unlikely(!list_empty(&mnt->mnt_mounts))) {
 		struct mount *p, *tmp;
@@ -2267,6 +2262,13 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 			lock_mount_hash();
 			if (src_mnt->mnt.mnt_flags & MNT_LOCKED)
 				dst_mnt->mnt.mnt_flags |= MNT_LOCKED;
+			if (unlikely(flag & CL_EXPIRE)) {
+				/* stick the duplicate mount on the same expiry
+				 * list as the original if that was on one */
+				if (!list_empty(&src_mnt->mnt_expire))
+					list_add(&dst_mnt->mnt_expire,
+						 &src_mnt->mnt_expire);
+			}
 			list_add_tail(&dst_mnt->mnt_list, &res->mnt_list);
 			attach_mnt(dst_mnt, dst_parent, src_parent->mnt_mp);
 			unlock_mount_hash();
@@ -3848,12 +3850,6 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 	namespace_unlock();
 	inode_unlock(dentry->d_inode);
 discard:
-	/* remove m from any expiration list it may be on */
-	if (!list_empty(&mnt->mnt_expire)) {
-		namespace_lock();
-		list_del_init(&mnt->mnt_expire);
-		namespace_unlock();
-	}
 	mntput(m);
 	return err;
 }
@@ -3865,11 +3861,9 @@ int finish_automount(struct vfsmount *m, const struct path *path)
  */
 void mnt_set_expiry(struct vfsmount *mnt, struct list_head *expiry_list)
 {
-	namespace_lock();
-
+	read_seqlock_excl(&mount_lock);
 	list_add_tail(&real_mount(mnt)->mnt_expire, expiry_list);
-
-	namespace_unlock();
+	read_sequnlock_excl(&mount_lock);
 }
 EXPORT_SYMBOL(mnt_set_expiry);
 
-- 
2.39.5


